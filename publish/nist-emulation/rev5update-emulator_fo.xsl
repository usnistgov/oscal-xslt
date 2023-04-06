<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all"
  expand-text="true">
  
  <xsl:import href="oscal_sp800-53-emulator_fo.xsl"/>


<!--

TO DO:
  x fonts and header fonts
    x Only family titles are sans serif
  x add link from family header to Appendix C table
    o code and test link
  x header
  x footer
  x Appendix C tables tuneup
    x correct header
    x links
  x "Control Enhancement/s" header
  x "Control Enhancements: None" when there are no Enhancements
  x "Related Controls: None" when there are no Related Controls
  x bug - all Appendix C tables are coming out C-1?
  o Bibliography update - labels and listing
  o new page sequence for each Table 3
  o brackets around Reference labels
  o top-level metadata
  
  o margins?
  o remove Preview sidebar
  o make enhancement titles bold?
  
  -->

  <xsl:param name="use-font" as="xs:string">serif</xsl:param>
  
  <xsl:variable name="inline-header-size">10pt</xsl:variable>
  
  <xsl:param name="appendix-start-page" select="1001" as="xs:integer"/>
  
  <xsl:template match="section[@class='appendix']">
    <fo:page-sequence master-reference="simple" format="1" initial-page-number="{}" font-family="{ $frame-font-family }" force-page-count="no-force">
      <xsl:if test="$appendix-start-page gt 0">
        <xsl:attribute name="initial-page-number" select="$appendix-start-page"/>
      </xsl:if>
      
      <fo:static-content flow-name="header">
        <xsl:apply-templates select="ancestor::body" mode="header-table"/>
      </fo:static-content>
      <fo:static-content flow-name="footer" font-family="{ $frame-font-family }" text-align="center">
        <xsl:call-template name="pageno-block"/>
        <!--<xsl:call-template name="oscal-source-notice"/>-->
        
      </fo:static-content>
      <xsl:call-template name="page-left-column"/>
      <fo:flow flow-name="main" >
        <fo:block-container font-size="{ $base-font-size }">
          <xsl:apply-templates/>
        </fo:block-container>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
  
  <xsl:template match="section" mode="footer">
    <xsl:call-template name="grid-footer">
      <xsl:with-param name="notice">
        <xsl:call-template name="pageno-block"/>
      </xsl:with-param>
      <xsl:with-param name="right-side">
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="pageno-block">
    <fo:block text-align="center" font-size="{ $small }">
      <xsl:text>PAGE </xsl:text>
      <fo:page-number/>
      <xsl:text> </xsl:text>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="td[string(.)='√']/text()" mode="tables">
    <fo:inline font-family="Calibri">√</fo:inline>
  </xsl:template>
  
  <xsl:template match="body" mode="header-table">
    <fo:table border-after-style="solid" table-layout="fixed" width="6.25in">
      <fo:table-column column-width="2.75in"/>
      <fo:table-column column-width="3.5in"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell width="2.25in">
            <fo:block-container font-size="{ $small }">
              <fo:block>SP 800-53 Revision 5</fo:block>
              <fo:block>February 2023</fo:block>
            </fo:block-container>
          </fo:table-cell>
          <fo:table-cell width="4in"  text-align="right">
            <fo:block-container font-size="{ $small }">
              <fo:block>Security and Privacy Controls</fo:block>
              <fo:block>for Information Systems and Organizations</fo:block>
            </fo:block-container>
            
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>
  
  <xsl:template match="div[contains-token(@class,'control')]">
    <xsl:variable name="enhancement" select="ancestor::div/tokenize(@class,'\s+')='control'"/>
    <fo:block space-before="1em">
      <xsl:copy-of select="@id"/>
      <fo:list-block provisional-distance-between-starts="{ if ($enhancement) then '0.3' else '0.5' }in"
        provisional-label-separation="1em"  space-before="0.5em">
        <fo:list-item space-before="0.5em">
          <fo:list-item-label>
            <fo:block font-weight="bold" font-family="{ $label-font-family }" font-size="{ $big }">
              <!--forcing a link in here b/c stripped from value -->
              <xsl:variable name="tableC-target" select="details/summary/span[@class='label']/a/@href/substring-after(.,'#')"/>
              <fo:basic-link color="blue" internal-destination="{ $tableC-target }">
                <xsl:choose>
                  <xsl:when test="$enhancement">
                    <xsl:value-of select="replace(details/summary/span[1],'^[^\(]+','')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="details/summary/span[@class='label']"/>
                  </xsl:otherwise>
                </xsl:choose>
              </fo:basic-link>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <xsl:apply-templates select="." mode="control-contents"/>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </fo:block>
  </xsl:template>
  
  
  <xsl:template priority="5" match="section[@class='group']/details/div[contains-token(@class,'overview')]">
    <fo:block border-top-style="solid" border-top-width="1pt" border-top-color="#4472c4"
      border-bottom-style="solid" border-bottom-width="1pt" border-bottom-color="#4472c4"
      font-style="italic"
      margin-left="1em" margin-right="1em" padding-top="1em" padding-bottom="1em" space-before="2em" color="#4472c4">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  
  <xsl:template priority="5" match="section[@class='group']/details/summary">
    <xsl:variable name="family-id" select="parent::details/parent::section/@id"/>
    <xsl:variable name="family-name">
      <xsl:apply-templates/>
    </xsl:variable>
    <fo:block font-family="sans-serif" font-weight="bold" font-size="12pt" keep-with-next="always">
      <!-- same width as provisional space between starts on list container of control content -->
      <fo:inline-container width="0.5in">
        <fo:block>
          <xsl:text>3.</xsl:text>
          <xsl:number count="section[@class='group']" level="single" format="1."/>
      </fo:block>
      </fo:inline-container>
      <xsl:sequence select="$family-name"/>
      <xsl:text> ({ upper-case($family-id) }) Family</xsl:text>
    </fo:block>
    <fo:block space-before="1em"><fo:basic-link color="blue" internal-destination="AppendixC-{$family-id}">Quick link to { string($family-name) } Summary Table</fo:basic-link></fo:block>
  </xsl:template>
  
  <!--<h4 class="tableC-head"><span class="tableC-no">C.1: </span>Access Control(AC) Family</h4>-->
  <xsl:template match="h4[@class='tableC-head']">
    <fo:block font-family="sans-serif" font-weight="bold" font-size="12pt" keep-with-next="always">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="div[@class='family-tableC']">
    <fo:block-container space-before="1em" page-break-before="always">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates/>
    </fo:block-container>
  </xsl:template>
  
  <xsl:template match="div[contains-token(@class,'control')]">
    <xsl:variable name="enhancement" select="ancestor::div/tokenize(@class,'\s+')='control'"/>
    <fo:block space-before="1em">
      <xsl:copy-of select="@id"/>
      <fo:list-block provisional-distance-between-starts="{ if ($enhancement) then '0.3' else '0.5' }in"
        provisional-label-separation="1em"  space-before="0.5em">
        <fo:list-item space-before="0.5em">
          <fo:list-item-label>
            <fo:block font-weight="bold" font-family="{ $label-font-family }" font-size="{ $big }">
              <!--forcing a link in here b/c stripped from value -->
              <xsl:variable name="tableC-target" select="details/summary/span[@class='label']/a/@href/substring-after(.,'#')"/>
              <fo:basic-link color="blue" internal-destination="{ $tableC-target }">
                <xsl:choose>
                  <xsl:when test="$enhancement">
                    <xsl:value-of select="replace(details/summary/span[1],'^[^\(]+','')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="details/summary/span[@class='label']"/>
                  </xsl:otherwise>
                </xsl:choose>
              </fo:basic-link>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <xsl:apply-templates select="." mode="control-contents"/>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="span[@class='tableC-no']">
    <fo:inline-container width="0.5in">
      <fo:block>
        <xsl:apply-templates/>
      </fo:block>
    </fo:inline-container>
  </xsl:template>
  
  <xsl:template match="a[starts-with(@href,'#')]" mode="tables">
    <fo:basic-link internal-destination="{ substring-after(@href,'#') }">
      <xsl:apply-templates select="." mode="link-features"/>
      <xsl:apply-templates/>
    </fo:basic-link>
  </xsl:template>
  
  <!--<p><span class="inline-head">Related controls</span>: None.</p>-->
  <xsl:template match="p[span[@class='inline-head']='Related controls'][. = ': None.']">
    <xsl:message>Matching</xsl:message>
  </xsl:template>
  
  <!--<div class="part enhancements  none">
    <details>
      <summary class="h4"><span class="inline-head">Control enhancements</span> <span class="count"> None</span></summary>
    </details>
  </div>-->
  
  <xsl:template match="span[@class='smallcaps']" mode="tables">
    <fo:inline text-transform="uppercase" font-weight="normal" font-size="smaller">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
  
  <xsl:template mode="tables" match="td[@class='control-enhancement-title']/sc">
    <fo:inline text-transform="uppercase" font-size="smaller">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
  
  <xsl:template match="th" mode="tables">
    <fo:table-cell xsl:use-attribute-sets="td" font-weight="bold" text-align="center">
      <xsl:apply-templates select="." mode="enhance-AppC-cell"/>
      <xsl:call-template name="process-table-cell"/>
    </fo:table-cell>
  </xsl:template>
  
  <xsl:template match="br" mode="tables">
    <fo:block/>
  </xsl:template>
  
  <xsl:template match="td" mode="tables">
    <fo:table-cell xsl:use-attribute-sets="td">
      <xsl:apply-templates select="." mode="enhance-AppC-cell"/>
      <xsl:call-template name="process-table-cell"/>
    </fo:table-cell>
  </xsl:template>

  <xsl:template mode="enhance-AppC-cell" match="tr[ends-with(@class,'withdrawn')]/*" priority="101">
    <!--<xsl:attribute name="color">black</xsl:attribute>-->
    <xsl:attribute name="background-color">gainsboro</xsl:attribute>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template mode="enhance-AppC-cell" match="td[@class='withdrawn-notice']" priority="100">
    <xsl:attribute name="font-size" select="$smaller"/>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template mode="enhance-AppC-cell" match="td[@class='withdrawn-notice']" priority="99">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template name="process-style"><xsl:param name="style"/></xsl:template>
  
  <!--<td class="control-no">-->
  <xsl:template match="*" mode="enhance-AppC-cell">
    <xsl:attribute name="padding">0.2em</xsl:attribute>
    <!--<xsl:attribute name="display-align">after</xsl:attribute>-->
  </xsl:template>
  
  <!--<tr id="tableC-ac-2.10" class="enhancement-summary-withdrawn">
    <td class="control-no">
      <xref rid="ac-2.10" ref-type="sec">AC-2(10)</xref>
    </td>
    <td class="control-enhancement-title" style="font-size: smaller">
      <sc>Shared and Group Account Credential Change</sc>
    </td>
    <td colspan="2" class="withdrawn-notice">W: Incorporated into <a href="#ac-2">AC-2</a>.</td>
  </tr>
  -->
  
  
  
</xsl:stylesheet>