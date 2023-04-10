<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:o="http://csrc.nist.gov/ns/oscal/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://csrc.nist.gov/ns/oscal/1.0"
    xmlns:o="http://csrc.nist.gov/ns/oscal/1.0"
    exclude-result-prefixes="xs math"
    version="3.0">
    
<!-- XSLT rides on top of logic in 53A catalog providing for customization layer
    
    supporting Rev 5 Errata Update
    
    to do:
      x suppress Assessment methods
      x suppress superfluous properties
      x provide Appendix C tables
      o rectify bibliography
      x tune up l/f for VP
      o link to line in Table C for each control/enhancement
      
    -->
    
    <xsl:import href="sp800-53A-catalog_html.xsl"/>
    
    <xsl:template match="catalog">
        <xsl:apply-templates select="metadata/title"/>
        <main class="catalog">
            <xsl:apply-templates/>
        </main>
        <xsl:apply-templates select="back-matter" mode="back-matter"/>
        <xsl:apply-templates select="." mode="table-C"/>
    </xsl:template>
    
    <xsl:template match="back-matter"/>
    
    <xsl:template match="back-matter" mode="back-matter">
        <xsl:if test="exists(resource)">
            <section class="references" id="references">
                <details open="open">
                    <summary class="h3">References</summary>
                    <xsl:call-template name="make-resource-table"/>
                 </details>
            </section>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="back-matter/resource">
        <tr class="resource" id="resource-{@uuid}">
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template name="make-resource-table">
        <table class="resources">
            <xsl:apply-templates select="resource">
                <xsl:sort select="title/string() => o:zero-pad()" order="ascending"/>
            </xsl:apply-templates>
        </table>
    </xsl:template>
    
    <!-- Pads numeric substrings with zeroes to five (5) digits -->
    <xsl:function name="o:zero-pad" as="xs:string">
        <xsl:param name="n" as="xs:string"/>
        <xsl:variable name="padstr" select="'00000'"/>
        <xsl:value-of><!-- the instruction delivers a single text node, castable to a string -->
            <xsl:analyze-string select="$n" regex="\d+">
                <xsl:matching-substring>
                    <xsl:value-of select="number(.) => format-number($padstr)"/>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:value-of>
    </xsl:function>
    
    <xsl:template match="resource[empty(citation)]">
        <xsl:message expand-text="true">dropping resource { title }</xsl:message>
    </xsl:template>
    
    <xsl:template name="control-label">
        <span class="label">
            <a href="#tableC-{ @id }">
              <xsl:apply-templates mode="part-number" select="prop[@name = 'label'][1]"/>
            </a>
        </span>
    </xsl:template>
    
    
    <!-- Dropping RMF props from display in default traversal -->
    <xsl:template match="prop[@ns='http://csrc.nist.gov/ns/rmf']"/>
    
<!-- Dropping 53A contents as well -->
    <xsl:template match="part[@name='assessment-objective']"/>
    
    <xsl:template match="part[@name='assessment-method']"/>
    
    <xsl:template name="guidance-links" expand-text="true">
        <xsl:param name="links" select="link[@rel = 'related']"/>
        <p>
                <span class="inline-head">Related { if (count($links) eq 1) then 'control' else 'controls' }</span>
                <xsl:text>: </xsl:text>
                <xsl:if test="empty($links)">None</xsl:if>
                <xsl:for-each select="$links">
                    <xsl:if test="position() gt 1">, </xsl:if>
                    <xsl:apply-templates select="." mode="link-as-link"/>
                </xsl:for-each>
                <xsl:text>.</xsl:text>
        </p>
    </xsl:template>
    
    <xsl:template match="link[@rel='reference'][starts-with(@href,'#')]" mode="link-as-link"  expand-text="true">
        <xsl:variable name="target" select="key('cross-reference-targets', @href)"/>
        <xsl:if test="empty($target)">
          <xsl:message expand-text="true">can't find target for link { @href }</xsl:message>
        </xsl:if>
        <xsl:text>[</xsl:text>
        <a href="{ replace(@href,'^#','#resource-') }">{ $target/title }</a>
        <xsl:text>]</xsl:text>
        <!--<xsl:text>{ if (not(position() eq last())) then '], ' else ']' }</xsl:text>-->
    </xsl:template>
    
    <xsl:template match="a[key('by-id',@href => substring-after('#'))/self::resource]" expand-text="true">
        <xsl:message>matching inline resource reference </xsl:message>
        <a href="{@href}">[{ . }]</a>
    </xsl:template>
    
    <!--<xsl:template match="resource" mode="link-as-link">
        <xsl:param name="link" select="()"/>
        <a href="{ child::rlink[1]/@href }">
            <xsl:for-each select="$link[exists(text)]">
                <span class="ref-label">
                    <xsl:apply-templates/>
                </span>
                <xsl:text>: </xsl:text>
            </xsl:for-each>
            <xsl:sequence>
                <xsl:apply-templates select="." mode="link-text"/>
                <xsl:on-empty expand-text="true">{ child::rlink[1]/@href }{ child::rlink[1]/@media-type ! ( ' (' || . || ')' ) }</xsl:on-empty>
            </xsl:sequence>
        </a>
    </xsl:template>-->
    
    <xsl:template match="/catalog" mode="table-C">
        <section class="appendix">           
          <xsl:apply-templates select="group" mode="#current"/>
        </section>
    </xsl:template>
    
    <xsl:template match="catalog/group" mode="table-C" expand-text="true">
        <div id="AppendixC-{@id}" class="family-tableC">
            <xsl:apply-templates select="title" mode="#current"/>
            <table class="assuranceTable" id="{@id}-tableC" border="1" rules="all">
                <col width="15%"/>
                <col width="55%"/>
                <col width="15%"/>
                <col width="15%"/>
                <thead>
                    <tr class="control-matrix-header">
                        <th class="label">Control Number</th>
                        <th class="control-title">Control Name<br class="br"/><span class="smallcaps">control enhancement name</span></th>
                        <th>Implemented<br class="br"/>By</th>
                        <th>Assurance</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates select="group | control" mode="table-C"/>
                </tbody>
            </table>
        </div>
    </xsl:template>
    
    <xsl:template match="group/title" mode="table-C" expand-text="true">
        <h4 class="tableC-head">
            <span class="tableC-no">C.{ count(../(.|preceding-sibling::group)) }.</span>
            <xsl:apply-templates/>
            <xsl:text> ({ ../@id/upper-case(.) }) Family</xsl:text>
        </h4>
        <p>
            <xsl:text>See section </xsl:text>
            <a href="#{../@id}">
                <xsl:apply-templates/>
            </a>
            <xsl:text> for control definitions.</xsl:text>
        </p>
    </xsl:template>
    
    <xsl:template match="control" mode="table-C">
        <xsl:variable name="is-enhancing" select="exists(parent::control)"/>
        <xsl:variable name="withdrawn" select="prop[@name='status']/@value='withdrawn'"/>
        <tr class="{ if ($is-enhancing) then 'enhancement' else 'control' }-summary{ '-withdrawn'[$withdrawn] }">
            <td class="control-no" id="tableC-{@id}">
                <a href="#{ @id }" ref-type="sec">
                    <xsl:apply-templates mode="#current" select="prop[@name = 'label']"/>
                </a>
            </td>
            <td class="control{'-enhancement'[$is-enhancing]}-title">
                <xsl:apply-templates select="." mode="style-td"/>
                <xsl:apply-templates mode="#current" select="title"/>
            </td>
            <xsl:choose>
                <xsl:when test="$withdrawn">
                    <td colspan="2" class="withdrawn-notice">
                        <xsl:call-template name="annotate-withdrawn-control">
                            <xsl:with-param name="label">W</xsl:with-param>
                            <xsl:with-param name="withdrawn-to" select="link[@rel = ('moved-to', 'incorporated-into')]"/>
                        </xsl:call-template>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td align="center">
                        <xsl:apply-templates select="." mode="mark-implementors"/>
                    </td>
                    <td align="center">
                        <xsl:apply-templates select="." mode="mark-assurance"/>
                    </td>        
                </xsl:otherwise>
            </xsl:choose>
        </tr>
        <xsl:apply-templates mode="#current" select="control"/>
    </xsl:template>
    
    
    <xsl:template name="annotate-withdrawn-control">
        <xsl:param name="label" as="xs:string">Withdrawn</xsl:param>
        <xsl:param name="withdrawn-to" select="()"/>
        <xsl:param name="statement" select="()"/>
        <xsl:variable name="withdrawn-statement">
            <xsl:value-of select="$label"/>
            <xsl:choose>
                <xsl:when test="empty($withdrawn-to)">. </xsl:when>
                <xsl:when test="$withdrawn-to/@rel = 'incorporated-into'">: Incorporated into </xsl:when>
                <xsl:otherwise>: Moved to </xsl:otherwise>
            </xsl:choose>
            <xsl:for-each-group select="$withdrawn-to" group-by="true()">
                <xsl:for-each select="current-group()">
                    <xsl:if test="position() gt 1">, </xsl:if>
                    <xsl:apply-templates select="." mode="link-as-link"/>
                </xsl:for-each>
            </xsl:for-each-group>
            <xsl:for-each select="$statement/*">
                <xsl:apply-templates/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="$withdrawn-statement"/>
        <!-- add a period if not already there -->
        <xsl:if test="not(matches(string($withdrawn-statement), '\.\s*$'))">.</xsl:if>
    </xsl:template>
    
    
    <xsl:template priority="2" match="control/control/title" mode="table-C" expand-text="true">
        <sc>
            <xsl:apply-templates/>
        </sc>
    </xsl:template>
    
    <!-- already inside td -->
    <xsl:template match="control/title" mode="table-C" expand-text="true">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template mode="table-C" match="prop"/>
    
    
    <xsl:template mode="table-C" match="prop[@name='label'][not(@class='sp800-53a')]">
        <xsl:value-of select="@value"/>
    </xsl:template>
    
    
    <xsl:template match="control" mode="mark-implementors">
        <xsl:variable name="my" select="."/>
        <xsl:text expand-text="true">{ ('o'[$my/prop[@name='implementation-level']/@value='organization'],
            's'[$my/prop[@name='implementation-level']/@value='system']) => string-join('/') => upper-case() }</xsl:text>
    </xsl:template>
    
    <xsl:template match="control" mode="mark-assurance">
        <xsl:if test="prop[@name='contributes-to-assurance']/@value = 'true'">√</xsl:if>
    </xsl:template>
    
    <xsl:template match="control" mode="style-td" expand-text="true">
        <xsl:attribute name="style">font-weight: bold</xsl:attribute>
    </xsl:template>
    
    <xsl:template priority="2" match="control/control" mode="style-td" expand-text="true">
        <xsl:attribute name="style">font-size: smaller</xsl:attribute>
    </xsl:template>
    
    
</xsl:stylesheet>