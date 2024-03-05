<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0"
   xmlns:metaschema="http://csrc.nist.gov/ns/metaschema/1.0" type="metaschema:OSCAL-CATALOG-INSPECTOR-XSLT"
   name="OSCAL-CATALOG-INSPECTOR-XSLT">

   <!-- Purpose: Produces an Inspector XSLT for the OSCAL Catalog metaschema  -->
   <!-- Input: is hard-wired to a current copy of the metaschema on Github -->
   <!-- Output: Writes artifacts to the file system, in 'current' subdirectory -->

   <!-- &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& -->
   <!-- Ports -->

   <p:input port="METASCHEMA" primary="true">
      <p:document
         href="https://raw.githubusercontent.com/usnistgov/OSCAL/main/src/metaschema/oscal_catalog_metaschema.xml"/>
   </p:input>

   <p:input port="parameters" kind="parameter"/>

   <!-- ports for diagnostics
      
      <p:serialization port="OUT_inspector-xslt" indent="true" method="xml" encoding="us-ascii" omit-xml-declaration="false"/>
   <p:output port="OUT_inspector-xslt">
      <p:pipe port="OUT_inspector-xslt" step="produce-inspector"/>
   </p:output>

   <p:serialization port="OUT_inspector-xslt-PATCHED" indent="true" method="xml" encoding="us-ascii" omit-xml-declaration="false"/>
   <p:output port="OUT_inspector-xslt-PATCHED" primary="true">
      <p:pipe port="result" step="patch-inspector"/>
   </p:output>-->


   <!-- &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& -->
   <!-- Import (subpipeline) -->

   <p:import href="https://raw.githubusercontent.com/usnistgov/metaschema-xslt/develop/src/schema-gen/METASCHEMA-INSPECTOR-XSLT.xpl"/>

   <!-- &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& &&& -->
   <!-- Pipeline -->

   <metaschema:METASCHEMA-INSPECTOR-XSLT name="produce-inspector">
      <p:with-option name="xslt-test" select="'skip'"/>
   </metaschema:METASCHEMA-INSPECTOR-XSLT>

   <p:store href="current/oscal-catalog_inspector-RAW.xsl" indent="true" method="xml"
      encoding="us-ascii">
      <p:input port="source">
         <p:pipe port="OUT_inspector-xslt" step="produce-inspector"/>
      </p:input>
   </p:store>

   <p:xslt name="patch-inspector">
      <p:input port="source">
         <p:pipe port="OUT_inspector-xslt" step="produce-inspector"/>
      </p:input>
      <p:input port="stylesheet">
         <p:document href="../generator/oscal-inspector-fixup.xsl"/>
         <!--<p:document href="../common/no-op.xsl"/>-->
      </p:input>
   </p:xslt>

   <p:store href="../oscal-catalog_inspector.xsl" indent="true" method="xml"
      encoding="us-ascii"/>

</p:declare-step>