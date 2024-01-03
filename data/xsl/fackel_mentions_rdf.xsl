<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
    <xsl:output method="text" encoding="UTF-8" media-type="text/plain" indent="no"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:call-template name="get-header"/>

        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="list">
        <!--
        <xsl:for-each select="mention[position() &lt; 10000]">
        -->
        <xsl:for-each select="mention">
            <xsl:call-template name="create-INT1-textpassage">
                <xsl:with-param name="n" select="@n"/>
            </xsl:call-template>
            <xsl:call-template name="create-E42-id-identifier">
                <xsl:with-param name="n" select="@n"/>
            </xsl:call-template>
            <xsl:call-template name="create-E42-permalink-identifier">
                <xsl:with-param name="n" select="@n"/>
            </xsl:call-template>
            <xsl:call-template name="create-INT16-segment">
                <xsl:with-param name="n" select="@n"/>
            </xsl:call-template>
            <xsl:call-template name="create-INT2-actualized-feature">
                <xsl:with-param name="n" select="@n"/>
            </xsl:call-template>
            <xsl:call-template name="create-INT18-reference">
                <xsl:with-param name="n" select="@n"/>
            </xsl:call-template>
            <!-- 
            -->
        </xsl:for-each>

    </xsl:template>

    <!-- functions aka. named templates -->

    <xsl:template name="get-header">
        <xsl:text>@prefix cidoc: &lt;http://www.cidoc-crm.org/cidoc-crm/&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix dcterms: &lt;http://purl.org/dc/terms/&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix frbroo: &lt;https://cidoc-crm.org/frbroo/sites/default/files/FRBR2.4-draft.rdfs#&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix lk: &lt;https://sk.acdh.oeaw.ac.at/project/legal-kraus&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix ns1: &lt;https://w3id.org/lso/intro/beta202304#&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix schema: &lt;https://schema.org/&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix sk: &lt;https://sk.acdh.oeaw.ac.at/&gt;</xsl:text>
        <xsl:call-template name="newline-dot"/>
        <xsl:text>@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt;</xsl:text>
        <xsl:call-template name="newline-dot-newline"/>
    </xsl:template>

    <xsl:template name="create-INT1-textpassage">
        <xsl:param name="n"/>

        <xsl:if test="string-length(text_id) &gt; 0">
            <xsl:call-template name="comment">
                <xsl:with-param name="text" select="'#INT1 textpassage'"/>
            </xsl:call-template>

            <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="text_id"/>
            <xsl:text>/passage/</xsl:text>
            <xsl:value-of select="$n"/>
            <xsl:text>&gt; a ns1:INT1_TextPassage</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  rdfs:label &quot;Text passage from: </xsl:text>
            <xsl:value-of select="text_title"/>
            <xsl:text>&quot;@en</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:if test="string-length(mention_id) &gt; 0">
                <xsl:text>  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
                <xsl:value-of select="mention_id"/>
                <xsl:text>/identifier/idno/0&gt;</xsl:text>
                <xsl:call-template name="newline-semicolon"/>

                <xsl:text>  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
                <xsl:value-of select="mention_id"/>
                <xsl:text>/identifier/idno/1&gt;</xsl:text>
                <xsl:call-template name="newline-semicolon"/>
            </xsl:if>

            <xsl:if test="string-length(text_id) &gt; 0">
                <xsl:text>  ns1:R10_is_Text_Passage_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
                <xsl:value-of select="text_id"/>
                <xsl:text>&gt;</xsl:text>
                <xsl:call-template name="newline-semicolon"/>

                <xsl:text>  ns1:R18_shows_actualization &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
                <xsl:value-of select="text_id"/>
                <xsl:text>/actualization/</xsl:text>
                <xsl:value-of select="$n"/>
                <xsl:text>&gt;</xsl:text>
                <xsl:call-template name="newline-semicolon"/>
            </xsl:if>

            <xsl:text>  ns1:R44_has_wording &quot;</xsl:text>
            <xsl:value-of
                select="replace(translate(mention_text, '&#x9;&#xa;&#xd;', ' '), '(\s)+', ' ')"/>
            <xsl:text>&quot;</xsl:text>
            <xsl:call-template name="newline-dot-newline"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="create-INT16-segment">
        <xsl:param name="n"/>

        <xsl:if test="string-length(text_id) &gt; 0">
            <xsl:call-template name="comment">
                <xsl:with-param name="text" select="'#INT16 segment'"/>
            </xsl:call-template>

            <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="text_id"/>
            <xsl:text>/segment/</xsl:text>
            <xsl:value-of select="$n"/>
            <xsl:text>&gt; a ns1:INT16_Segment</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  rdfs:label &quot;Segment from: </xsl:text>
            <xsl:value-of select="text_title"/>
            <xsl:text>"@en</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:if test="string-length(text_id) &gt; 0">
                <xsl:text>  ns1:R16_incorporates &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
                <xsl:value-of select="text_id"/>
                <xsl:text>/passage/</xsl:text>
                <xsl:value-of select="$n"/>
                <xsl:text>&gt;</xsl:text>
                <xsl:call-template name="newline-semicolon"/>
            </xsl:if>

            <xsl:text>  ns1:R25_is_segment_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="issue_id"/>
            <xsl:text>/published-expression&gt;</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:variable name="url">
                <xsl:call-template name="create-fackel-url">
                    <xsl:with-param name="facs" select="facs"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:text>  ns1:R41_has_location &quot;S. </xsl:text>
            <xsl:value-of select="mention_page"/>
            <xsl:text>&quot;^^xsd:string, &quot;</xsl:text>
            <xsl:value-of select="$url"/>
            <xsl:text>&quot;^^xsd:string</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  ns1:R44_has_wording &quot;</xsl:text>
            <xsl:value-of
                select="replace(translate(mention_text, '&#x9;&#xa;&#xd;', ' '), '(\s)+', ' ')"/>
            <xsl:text>&quot;</xsl:text>
            <xsl:call-template name="newline-dot-newline"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="create-E42-id-identifier">
        <xsl:param name="n"/>

        <xsl:if test="string-length(mention_id) &gt; 0 and string-length(text_id) &gt; 0">
            <xsl:call-template name="comment">
                <xsl:with-param name="text" select="'#E42 id identifier'"/>
            </xsl:call-template>

            <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="mention_id"/>
            <xsl:text>/identifier/idno/0&gt; a cidoc:E42_Identifier</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  rdfs:label &quot;Identifier: </xsl:text>
            <xsl:value-of select="mention_id"/>
            <xsl:text>&quot;@en</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/idno/xml-id&gt;</xsl:text>

            <xsl:if test="string-length(text_id) &gt; 0">
                <xsl:call-template name="newline-semicolon"/>
                <xsl:text>  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
                <xsl:value-of select="text_id"/>
                <xsl:text>/passage/</xsl:text>
                <xsl:value-of select="$n"/>
                <xsl:text>&gt;</xsl:text>
                <xsl:call-template name="newline-semicolon"/>

                <xsl:text>  rdf:value &quot;</xsl:text>
                <xsl:value-of select="mention_id"/>
                <xsl:text>&quot;</xsl:text>
            </xsl:if>
            <xsl:call-template name="newline-dot-newline"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="create-E42-permalink-identifier">
        <xsl:param name="n"/>

        <xsl:if test="string-length(mention_id) &gt; 0 and string-length(text_id) &gt; 0">
            <xsl:call-template name="comment">
                <xsl:with-param name="text" select="'#E42 permalink identifier'"/>
            </xsl:call-template>

            <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="mention_id"/>
            <xsl:text>/identifier/idno/1&gt; a cidoc:E42_Identifier</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  rdfs:label &quot;Identifier: </xsl:text>
            <xsl:call-template name="permalink"/>
            <xsl:text>&quot;@en</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/idno/URL/fackel&gt;</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:if test="string-length(text_id) &gt; 0">
                <xsl:text>  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
                <xsl:value-of select="text_id"/>
                <xsl:text>/passage/</xsl:text>
                <xsl:value-of select="$n"/>
                <xsl:text>&gt;</xsl:text>
                <xsl:call-template name="newline-semicolon"/>
            </xsl:if>

            <xsl:text>  rdf:value &quot;</xsl:text>
            <xsl:call-template name="permalink"/>
            <xsl:text>&quot;</xsl:text>
            <xsl:call-template name="newline-dot-newline"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="create-INT2-actualized-feature">
        <xsl:param name="n"/>

        <xsl:if test="string-length(text_id) &gt; 0">
            <xsl:call-template name="comment">
                <xsl:with-param name="text" select="'#INT2 actualized feature'"/>
            </xsl:call-template>

            <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="text_id"/>
            <xsl:text>/actualization/</xsl:text>
            <xsl:value-of select="$n"/>
            <xsl:text>&gt; a ns1:INT2_ActualizationOfFeature</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  rdfs:label &quot;Actualization on: </xsl:text>
            <xsl:value-of select="text_title"/>
            <xsl:text>&quot;@en</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  ns1:R17_actualizes_feature &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="text_id"/>
            <xsl:text>/reference/</xsl:text>
            <xsl:value-of select="$n"/>
            <xsl:text>&gt;</xsl:text>
            <xsl:call-template name="newline-dot-newline"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="create-INT18-reference">
        <xsl:param name="n"/>

        <xsl:if test="string-length(text_id) &gt; 0">
            <xsl:call-template name="comment">
                <xsl:with-param name="text" select="'#INT18 reference'"/>
            </xsl:call-template>

            <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="text_id"/>
            <xsl:text>/reference/</xsl:text>
            <xsl:value-of select="$n"/>
            <xsl:text>&gt; a ns1:INT18_Reference</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  rdfs:label &quot;Reference on: </xsl:text>
            <xsl:value-of select="text_title"/>
            <xsl:text>&quot;@en</xsl:text>
            <xsl:call-template name="newline-semicolon"/>

            <xsl:text>  cidoc:P67_refers_to &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
            <xsl:value-of select="person_id"/>
            <xsl:text>&gt;</xsl:text>
            <xsl:call-template name="newline-dot-newline"/>
        </xsl:if>
    </xsl:template>

    <!-- helpers -->

    <xsl:template name="comment">
        <xsl:param name="text"/>
        <xsl:value-of select="$text"/>
        <xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template name="newline-semicolon">
        <xsl:text> ;
</xsl:text>
    </xsl:template>

    <xsl:template name="newline-dot">
        <xsl:text> .
</xsl:text>
    </xsl:template>

    <xsl:template name="newline-dot-newline">
        <xsl:text> .

</xsl:text>
    </xsl:template>

    <xsl:template name="permalink">
        <!-- n_59833 - https://fackel.oeaw.ac.at/?globId=fackeln59833 -->
        <xsl:variable name="globId" select="mention_id"/>
        <xsl:choose>
            <xsl:when test="contains($globId, 'n_')">
                <xsl:value-of
                    select="replace($globId, 'n_', 'https://fackel.oeaw.ac.at/?globId=fackeln')"/>
            </xsl:when>
            <xsl:when test="contains($globId, 'n2_')">
                <xsl:value-of
                    select="replace($globId, 'n2_', 'https://fackel.oeaw.ac.at/?globId=fackelx')"/>
            </xsl:when>
            <xsl:when test="contains($globId, 'name_')">
                <xsl:value-of
                    select="replace($globId, 'name_', 'https://fackel.oeaw.ac.at/?globId=fackely')"
                />
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="create-fackel-url">
        <xsl:param name="facs"/>
        <!-- 
              1234567890123456789
        <facs>FK-36-890_n0215.xml</facs>
        http://fk01dev.arz.oeaw.ac.at/f/890,215
        -->
        <xsl:variable name="page-no"
            select="upper-case(substring(substring-before($facs, '.xml'), 13))"/>
        <xsl:variable name="page-type" select="substring($facs, 11, 1)"/>

        <xsl:value-of select="concat('https://fackel.oeaw.ac.at/F/', substring($facs, 7, 3), ',')"/>
        <xsl:choose>
            <xsl:when test="$page-type = 'n'">
                <xsl:value-of select="$page-no"/>
            </xsl:when>
            <xsl:when test="$page-type = 'a'">
                <xsl:choose>
                    <xsl:when test="$page-no = '001'">
                        <xsl:text>0U1</xsl:text>
                    </xsl:when>
                    <xsl:when test="$page-no = '002'">
                        <xsl:text>0U2</xsl:text>
                    </xsl:when>
                    <xsl:when test="$page-no = '002_A'">
                        <xsl:text>0U2A</xsl:text>
                    </xsl:when>
                    <xsl:when test="$page-no = '002_B'">
                        <xsl:text>0U2B</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$page-type = 'u'">
                <xsl:choose>
                    <xsl:when test="$page-no = '001'">
                        <xsl:text>0U3</xsl:text>
                    </xsl:when>
                    <xsl:when test="$page-no = '002'">
                        <xsl:text>0U4</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>

    </xsl:template>
</xsl:stylesheet>
