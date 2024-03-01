<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:cx="http://xmlcalabash.com/ns/extensions" version="1.0"
   xmlns:metaschema="http://csrc.nist.gov/ns/metaschema/1.0"
   type="metaschema:XSD-VALIDATE-OSCAL-SAMPLES"
   name="XSD-VALIDATE-OSCAL-SAMPLES"
   xmlns:x="http://www.jenitennison.com/xslt/xspec"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nm="http://csrc.nist.gov/ns/metaschema"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">

   <!-- Input: depends on finding file 'inspector-functional-xspec/validations-in-batch.xspec' in place -->
   <!-- Input: Additionally, all inputs named therein (expect errors for files broken or missing)-->
   <!-- Input: Additionally, an up-to-date XSD for the OSCAL schema taken as reference, either a local copy or link to Github -->
   <!-- Output: an 'all is well' message, or unexpected results such as errors from files expected to be valid or validity from files expected to be invalid -->
   <!-- Purpose: test alignment between XSD-based Metaschea validates and other forms, by providing a basis for comparisohn-->


   <!-- &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& -->
   <!-- Ports -->

   <p:input port="parameters" kind="parameter"/>


   <!-- Lists are being maintained by hand for now, for clarity and robustness -->
   <!-- Align with file 'testing/per-document/validations-in-batch.xspec' -->

   <!--
      Among our samples, if a document contains anywhere a processing instruction like so:
        <?EXPECT ERROR?>
      we take this to indicate a validation failure is expected at or near that spot
      
      Don't be distracted by the file system organization: every file in 'invalid' should be so marked
      (with one or more PIs) and every file in 'valid' should not be so marked
      
   -->
   
   <p:input port="samples" sequence="true">
      <p:document href="samples/catalog/invalid/not-okay-catalog.xml"/>
      <p:document href="samples/catalog/invalid/broken-date.xml"/>
      
      <p:document href="samples/catalog/valid/minimal.xml"/>
      <p:document href="samples/catalog/valid/okay-catalog.xml"/>
      <p:document href="samples/catalog/valid/some-backmatter.xml"/>
      <p:document href="samples/catalog/valid/some-parameters.xml"/>
      
   </p:input>

   <p:input port="oscal-xsd">
      <p:document href="lib/oscal_catalog_schema.xsd"/>
      <!--<p:document href="https://github.com/usnistgov/OSCAL/releases/download/v1.1.2/oscal_catalog_schema.xsd"/>-->
   </p:input>
   
   <p:serialization port="survey" indent="true"/>
   <p:output port="survey">
      <p:pipe port="result" step="assessment"/>
   </p:output>
   
   <p:serialization port="summary" indent="true" method="xml"/>
   <p:output port="summary">
      <p:pipe port="result" step="summary"/>
   </p:output>
   
   <p:serialization port="plaintext" indent="false" method="text"/>
   <p:output port="plaintext">
      <p:pipe port="result" step="plaintext"/>
   </p:output>
   
   <p:for-each>
      <p:iteration-source>
         <p:pipe port="samples" step="XSD-VALIDATE-OSCAL-SAMPLES"/>
      </p:iteration-source>
      <p:variable name="base" select="base-uri(.)"/>

      <p:try>
         <p:group>
            <p:validate-with-xml-schema name="validate-sample" assert-valid="true" mode="strict">
               <!--<cx:message>
                  <p:with-option name="message" select="'here a message'"/>
               </cx:message>-->
               <p:input port="schema">
                  <p:pipe port="oscal-xsd" step="XSD-VALIDATE-OSCAL-SAMPLES"/>
               </p:input>
               <!-- xsi:VALIDATING will be invalid unless contrived to be otherwise, but coming back valid also indicates success -->

            </p:validate-with-xml-schema>

         </p:group>
         <p:catch>
            <p:add-attribute attribute-name="VALIDATION-STATUS" match="/*" attribute-value="XSD-INVALID"/>
         </p:catch>
      </p:try>

      <p:add-attribute attribute-name="base-uri" match="/*">
         <p:with-option name="attribute-value" select="$base"/>
      </p:add-attribute>

   </p:for-each>

   <p:wrap-sequence name="wrapup" wrapper="ANY-VALID"/>

   <p:xslt name="assessment">
      <p:input port="stylesheet">
         <p:inline>
            <xsl:stylesheet version="3.0" exclude-result-prefixes="#all">
               <xsl:mode on-no-match="shallow-copy"/>

               <xsl:function name="nm:is-marked" as="xs:boolean">
                 <xsl:param name="doc" as="node()"/>
                  <xsl:param name="marking" as="xs:string+"/>
                  <xsl:sequence select="$doc/descendant::processing-instruction('EXPECT')/replace(.,'\s*:.*$','')=$marking"/>
                  <!--<xsl:sequence select="true()"/>-->
               </xsl:function>
               
               <xsl:template match="/*">
                  <xsl:copy>
                     <NOMINALLY-VALID>
                        <xsl:apply-templates select="*[not(nm:is-marked(.,'ERROR'))]"/>
                     </NOMINALLY-VALID>
                     <NOMINALLY-INVALID>
                        <xsl:apply-templates select="*[nm:is-marked(.,'ERROR')]"/>
                     </NOMINALLY-INVALID>
                  </xsl:copy>
               </xsl:template>
               <xsl:template match="/*/*">
                  <document href="{@base-uri}">
                     <xsl:copy-of select="@VALIDATION-STATUS"/>
                  </document>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:input>
   </p:xslt>

   <p:xslt name="summary">
      <p:input port="stylesheet">
         <p:inline>
            <xsl:stylesheet version="3.0" exclude-result-prefixes="#all" expand-text="true">

               <xsl:template match="/*">
                  <xsl:variable name="anomalies"
                     select="child::NOMINALLY-VALID/document[@VALIDATION-STATUS='XSD-INVALID'] |
                             child::NOMINALLY-INVALID/document[not(@VALIDATION-STATUS='XSD-INVALID')]"/>
                  <REPORT>
                     <progress>Checking { count(*/*) }{ if (count(*/*) eq 1) then ' document' else ' documents' } against an OSCAL Catalog XSD ...</progress>
                        <xsl:apply-templates select="child::*/document"/>

                        <xsl:if test="empty($anomalies)">
                           <summary>ALL GOOD - confirming expected results from XSD validation</summary>
                        </xsl:if>
                  </REPORT>
               </xsl:template>

               <xsl:template match="NOMINALLY-VALID/document[@VALIDATION-STATUS='XSD-INVALID']" priority="10">
                  <finding href="{@href}">VALIDATION ANOMALY: a document expected to be valid is found to be INVALID</finding>
               </xsl:template>

               <xsl:template match="NOMINALLY-INVALID/document[not(@VALIDATION-STATUS='XSD-INVALID')]" priority="11">
                  <finding href="{@href}">VALIDATION ANOMALY: a marked document ('&lt;?EXPECT ERROR?>') is found to be VALID</finding>
               </xsl:template>
               
               <xsl:template match="document[@VALIDATION-STATUS='XSD-INVALID']" priority="3">
                  <finding href="{@href}">CONFIRMED (invalid)</finding>
               </xsl:template>
               
               <xsl:template match="document">
                  <finding href="{@href}">CONFIRMED (valid)</finding>
               </xsl:template>
               
            </xsl:stylesheet>
         </p:inline>
      </p:input>
   </p:xslt>

   <p:xslt name="plaintext">
      <p:input port="stylesheet">
         <p:inline>
            <xsl:stylesheet version="3.0" exclude-result-prefixes="#all" expand-text="true">
               <xsl:mode on-no-match="shallow-copy"/>
               
               <xsl:template match="/*">
                  <xsl:copy>
                  <xsl:apply-templates/>
                  <xsl:text>&#xA;{ (1 to 12) ! ':::::' }</xsl:text>
                  </xsl:copy>
               </xsl:template>
               
               <xsl:template match="REPORT/*">
                  <xsl:text>&#xA;</xsl:text>
                  <xsl:apply-templates/>
                  <xsl:apply-templates select="@href"/>
               </xsl:template>
               
               <xsl:template match="@href">: { . }</xsl:template>
               
            </xsl:stylesheet>
         </p:inline>
      </p:input>
   </p:xslt>
   
</p:declare-step>