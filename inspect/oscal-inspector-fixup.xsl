<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:XSLT="http://www.w3.org/1999/XSL/Transform/alias"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mx="http://csrc.nist.gov/ns/csd/metaschema-xslt"
   xpath-default-namespace="http://csrc.nist.gov/ns/oscal/metaschema/1.0" xmlns="http://www.w3.org/1999/xhtml"
   version="3.0">

   <!-- For extra integrity run Schematron inspector-generator-checkup.sch on this XSLT. -->

   <xsl:output indent="yes" encoding="us-ascii"/>
   <!-- pushing out upper ASCII using entity notation -->

   <xsl:namespace-alias stylesheet-prefix="XSLT" result-prefix="xsl"/>
   
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <!--    <xsl:key name="NDX_catalog-parts" match="catalog/(//part)" use="(@id)"/>
   <xsl:key name="NDX_catalog-props" match="catalog/(//prop)" use="(@uuid)"/>
   <xsl:key name="NDX_catalog-groups-controls-parts" match="catalog/(//(control|group|part))"
            use="(@id)"/>
   <xsl:key name="NDX_catalog-controls" match="catalog/(//control)" use="(@id)"/>
   <xsl:key name="NDX_catalog-params" match="catalog/(//param)" use="(@id)"/>
   <xsl:key name="NDX_catalog-groups" match="catalog/(//group)" use="(@id)"/>

   -->
   
   
   <xsl:template match="@match[.='catalog/(//part)']">
      <xsl:attribute name="match">catalog//part</xsl:attribute>
   </xsl:template>
   <xsl:template match="@match[.='catalog/(//prop)']">
      <xsl:attribute name="match">catalog//prop</xsl:attribute>
   </xsl:template>
   <xsl:template match="@match[.='catalog/(//(control|group|part))']">
      <xsl:attribute name="match">catalog//control | catalog//group | catalog//part</xsl:attribute>
   </xsl:template>
   <xsl:template match="@match[.='catalog/(//control)']">
      <xsl:attribute name="match">catalog//control</xsl:attribute>
   </xsl:template>
   <xsl:template match="@match[.='catalog/(//param)']">
      <xsl:attribute name="match">catalog//param</xsl:attribute>
   </xsl:template>
   <xsl:template match="@match[.='catalog/(//group)']">
      <xsl:attribute name="match">catalog//group</xsl:attribute>
   </xsl:template>
   
   <!--match="catalog/metadata/location/(prop[has-oscal-namespace('http://csrc.nist.gov/ns/oscal') and @name='type']/@value)-->
   
   <xsl:variable name="replacing-regex" as="xs:string">has-oscal-namespace\('http://csrc.nist.gov/ns/oscal'\)</xsl:variable>
   
   <xsl:variable name="replacement" as="xs:string">not(@ns!='http://csrc.nist.gov/ns/oscal')</xsl:variable>
   
   <xsl:template match="@match[matches(.,$replacing-regex)]">
      <xsl:attribute name="match" expand-text="true">{ replace(.,$replacing-regex,$replacement) }</xsl:attribute>
      
   </xsl:template>
</xsl:stylesheet>