<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
  <xsl:output method="text" encoding="UTF-8" media-type="text/plain" indent="no"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <xsl:call-template name="get-header"/>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="root">
    <xsl:call-template name="create-root-F24"/>
    <xsl:call-template name="create-root-F42-identifier"/>
    <xsl:call-template name="create-root-E33_E41"/>
    <xsl:call-template name="create-root-E90-title"/>
    <xsl:call-template name="create-root-E90-date"/>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="issue">
    <xsl:call-template name="create-issue-F22"/>
    <xsl:call-template name="create-issue-E42-identifier"/>
    <xsl:call-template name="create-issue-E42-identifier-idno"/>
    <xsl:call-template name="create-issue-E35"/>
    <xsl:call-template name="create-issue-E28"/>
    <xsl:call-template name="create-issue-E33_E41"/>
    <xsl:call-template name="create-issue-E90-issue-num"/>
    <xsl:call-template name="create-issue-E90-vol-num"/>
    <xsl:call-template name="create-issue-E90-date"/>
    <xsl:call-template name="create-issue-E90-title"/>
    <xsl:call-template name="create-issue-E90-place"/>

    <xsl:call-template name="create-publissue-F24"/>
    <xsl:call-template name="create-publissue-F30"/>
    <xsl:call-template name="create-publissue-E52"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="text">
    <xsl:call-template name="create-text-F22"/>
    <xsl:call-template name="create-text-E42-identifier"/>
    <xsl:call-template name="create-text-E42-identifier-idno"/>
    <xsl:call-template name="create-text-E35"/>
    <xsl:call-template name="create-text-E28"/>
    <xsl:call-template name="create-text-INT16-segment"/>
    <xsl:call-template name="create-text-F22-orig"/>
    <xsl:call-template name="create-text-E28-orig"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- functions aka. named templates -->

  <xsl:template name="get-header">
    <xsl:text>@prefix cidoc: &lt;http://www.cidoc-crm.org/cidoc-crm/&gt; .
@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .    
@prefix frbroo: &lt;https://cidoc-crm.org/frbroo/sites/default/files/FRBR2.4-draft.rdfs#&gt; .
@prefix lk: &lt;https://sk.acdh.oeaw.ac.at/project/legal-kraus&gt; .
@prefix ns1: &lt;https://w3id.org/lso/intro/Vx/#&gt; .
@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
@prefix schema: &lt;https://schema.org/&gt; .
@prefix sk: &lt;https://sk.acdh.oeaw.ac.at/&gt; .
@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix prov: &lt;http://www.w3.org/ns/prov#&gt; .

</xsl:text>
  </xsl:template>

  <xsl:template name="create-root-F24">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/01/published-expression&gt; a frbroo:F24_Publication_Expression ;
  rdfs:label &quot;Published Periodical: Die Fackel;&quot;@en ;
  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/01/identifier/idno/0&gt; ;
  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/01/appellation/0&gt; ;
  frbroo:R5_has_component </xsl:text>

    <xsl:for-each select="year/issue">
      <xsl:choose>
        <xsl:when test="position() = 1">
          <xsl:text/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> ,
    </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>/published-expression&gt;</xsl:text>
    </xsl:for-each>
    <xsl:text> .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-root-F42-identifier">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/01/identifier/idno/0&gt; a cidoc:E42_identifier ;
  rdfs:label &quot;Identifier: https://fackel.oeaw.ac.at/F/001,0u1&quot;@en ;
  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/01/published-expression&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/idno/URL/fackel&gt; ;
  rdf:value &quot;https://fackel.oeaw.ac.at/F/001,0u1&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-root-E33_E41">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/01/appellation/0&gt; a cidoc:E33_E41_Linguistic_Appellation ;
  rdfs:label &quot;Appellation for: Die Fackel&quot;@en ;
  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/01/published-expression&gt; ;
  cidoc:P106_is_composed_of &lt;https://sk.acdh.oeaw.ac.at/01/appellation-title/0&gt; ;  
  cidoc:P106_is_composed_of &lt;https://sk.acdh.oeaw.ac.at/01/appellation-date/0&gt; .  
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-root-E90-title">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/01/appellation-title/0&gt; a cidoc:E90_Symbolic_Object ;
  rdfs:label &quot;Appellation Part: Die Fackel&quot;@en ;
  cidoc:P106i_forms_part_of &lt;https://sk.acdh.oeaw.ac.at/01/appellation/0&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/appellation/title/main&gt; ;
  rdf:value &quot;Die Fackel&quot; .
    
</xsl:text>
  </xsl:template>
  <xsl:template name="create-root-E90-date">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/01/appellation-date/0&gt; a cidoc:E90_Symbolic_Object ;
  rdfs:label &quot;Appellation Part: 1899-1936&quot;@en ;
  cidoc:P106i_forms_part_of &lt;https://sk.acdh.oeaw.ac.at/01/appellation/0&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/appellation/date&gt; ;
  rdf:value &quot;1899-1936&quot; .  
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-F22">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; a frbroo:F22_Self-Contained_Expression ;
  rdfs:label &quot;Issue: Fackel </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot;@en ;
  cidoc:P102_has_title &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/title/0&gt;</xsl:text>
    <xsl:if test="text">
      <xsl:for-each select="text">
        <xsl:text> ;
  cidoc:P165_incorporates &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>&gt;</xsl:text>
      </xsl:for-each>
    </xsl:if>
    <xsl:text> ;
  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/idno/0&gt; ;
  frbroo:R17i_was_created_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/creation&gt; .
    
</xsl:text>
  </xsl:template>
  <xsl:template name="create-publissue-F24">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/published-expression&gt; a frbroo:F24_Publication_Expression ;
  rdfs:label &quot;Published Issue: Fackel </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot;@en ;
  cidoc:P165_incorporates &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation/0&gt; ;
  frbroo:R24i_was_created_through &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/publication&gt; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-publissue-F30">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/publication&gt; a frbroo:F30_Publication_Event ;
  rdfs:label &quot;Publication of: Die Fackel </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot;@en ;
  frbroo:R24_created &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/published-expression&gt; ;
  cidoc:P7_took_place_at &lt;https://sk.acdh.oeaw.ac.at/fa_place00003922&gt; ;
  cidoc:P4_has_time-span &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/publication/time-span&gt; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-publissue-E52">

    <xsl:variable name="date">
      <xsl:call-template name="format-date">
        <xsl:with-param name="year" select="@publYear"/>
        <xsl:with-param name="month" select="@publMonth"/>
        <xsl:with-param name="day" select="@publDay"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="@publDay = '00'">
          <xsl:text>xsd:gYearMonth</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>xsd:date</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/publication/time-span&gt; a cidoc:E52_Time-Span ;
  rdfs:label &quot;</xsl:text>
    <xsl:value-of select="$date"/>
    <xsl:text>&quot;@en ;
  cidoc:P82a_begin_of_the_begin &quot;</xsl:text>
    <xsl:value-of select="$date"/>
    <xsl:text>&quot;^^</xsl:text>
    <xsl:value-of select="$type"/>
    <xsl:text> ;
  cidoc:P82b_end_of_the_end &quot;</xsl:text>
    <xsl:value-of select="$date"/>
    <xsl:text>&quot;^^</xsl:text>
    <xsl:value-of select="$type"/>
    <xsl:text> .    
  
</xsl:text>
  </xsl:template>

  <xsl:template name="format-date">
    <xsl:param name="year"/>
    <xsl:param name="month"/>
    <xsl:param name="day"/>

    <xsl:value-of select="$year"/>
    <xsl:text>-</xsl:text>
    <xsl:if test="string-length($month) = 1">
      <xsl:text>0</xsl:text>
    </xsl:if>
    <xsl:value-of select="$month"/>

    <xsl:if test="$day != '' and $day != '00'">
      <xsl:text>-</xsl:text>
      <xsl:if test="string-length($day) = 1">
        <xsl:text>0</xsl:text>
      </xsl:if>
      <xsl:value-of select="$day"/>
    </xsl:if>


  </xsl:template>

  <xsl:template name="create-issue-E35">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/title/0&gt; a cidoc:E35_Title ;
  rdfs:label &quot;Title: Die Fackel&quot;@en ;
  cidoc:P102i_is_title_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  rdf:value "Die Fackel" .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E42-identifier">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; a cidoc:E42_Identifier ;
  rdfs:label &quot;Identifier: </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot;@en ;
  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/idno/xml-id&gt; ;
  rdf:value "</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>" .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E42-identifier-idno">
    <!-- 
    <xsl:variable name="url" select="concat('https://fackel.oeaw.ac.at/F/',substring(@id,5, 3),',0u1')"/>
    -->

    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/idno/0&gt; a cidoc:E42_Identifier ;
  rdfs:label &quot;Identifier: </xsl:text>
    <xsl:value-of select="@webLink"/>
    <xsl:text>&quot;@en ;
  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/idno/URL/fackel&gt; ;
  rdf:value "</xsl:text>
    <xsl:value-of select="@webLink"/>
    <xsl:text>" .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E28">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/creation&gt; a frbroo:F28_Expression_Creation ;
  rdfs:label &quot;Creation of: Fackel </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot;@en ;
  cidoc:P14_carried_out_by &lt;https://sk.acdh.oeaw.ac.at/p_47565&gt; ;
  frbroo:R17_created &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E33_E41">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation/0&gt; a cidoc:E33_E41_Linguistic_Appellation ;
  rdfs:label &quot;Appellation for: Die Fackel </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot;@en ;
  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/published-expression&gt; ;
  cidoc:P106_is_composed_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-num/0&gt; ,
    &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-num/1&gt; ,
    &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-date/0&gt; ,
    &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-title/0&gt; ,
    &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-place/0&gt; .  
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E90-issue-num">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-num/0&gt; a cidoc:E90_Symbolic_Object ;
  rdfs:label &quot;Appellation Part: </xsl:text>
    <xsl:value-of select="number(@issue)"/>
    <xsl:text>&quot;@en ;
  cidoc:P106i_forms_part_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation/0&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/appellation/num/issue&gt; ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="number(@issue)"/>
    <xsl:text>&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E90-vol-num">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-num/1&gt; a cidoc:E90_Symbolic_Object ;
  rdfs:label &quot;Appellation Part: </xsl:text>
    <xsl:value-of select="parent::year/@yearTitle"/>
    <xsl:text>&quot;@en ;
  cidoc:P106i_forms_part_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation/0&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/appellation/num/volume&gt; ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="parent::year/@yearTitle"/>
    <xsl:text>&quot; ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="parent::year/@num"/>
    <xsl:text>&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E90-date">
    <xsl:variable name="date">
      <xsl:call-template name="format-date">
        <xsl:with-param name="year" select="@publYear"/>
        <xsl:with-param name="month" select="@publMonth"/>
        <xsl:with-param name="day" select="@publDay"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-date/0&gt; a cidoc:E90_Symbolic_Object ;
  rdfs:label &quot;Appellation Part: </xsl:text>
    <xsl:value-of select="@dateWritten"/>
    <xsl:text>&quot;@en ;
  cidoc:P106i_forms_part_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation/0&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/appellation/date&gt; ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="@dateWritten"/>
    <xsl:text>&quot; ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="$date"/>
    <xsl:text>&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E90-title">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-title/0&gt; a cidoc:E90_Symbolic_Object ;
  rdfs:label &quot;Appellation Part: Die Fackel&quot;@en ;
  cidoc:P106i_forms_part_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation/0&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/appellation/title/main&gt; ;
  rdf:value &quot;Die Fackel&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-issue-E90-place">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation-place/0&gt; a cidoc:E90_Symbolic_Object ;
  rdfs:label &quot;Appellation Part: Wien&quot;@en ;
  cidoc:P106i_forms_part_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/appellation/0&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/appellation/place&gt; ;
  rdf:value &quot;Wienl&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-text-F22">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; a frbroo:F22_Self-Contained_Expression ;
  rdfs:label &quot;Expression: </xsl:text>
    <xsl:value-of select="@titleText"/>
    <xsl:text>&quot;@en ;
  cidoc:P102_has_title &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/title/0&gt;</xsl:text>
    <xsl:if test="parent::text">
      <xsl:text> ;
  cidoc:P165i_is_incorporated_in &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
      <xsl:value-of select="parent::text/@id"/>
      <xsl:text>&gt;</xsl:text>
    </xsl:if>
    <xsl:if test="text">
      <xsl:for-each select="text">
        <xsl:text> ;
  cidoc:P165_incorporates &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>&gt;</xsl:text>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="@chiffreShort != ''">
      <xsl:text> ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/text/chiffre/</xsl:text>
      <xsl:value-of select="@chiffreShort"/>
      <xsl:text>&gt;</xsl:text>
    </xsl:if>
    <xsl:if test="@rubricShort != ''">
      <xsl:text> ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/text/rubric/</xsl:text>
      <xsl:value-of select="@rubricShort"/>
      <xsl:text>&gt;</xsl:text>
    </xsl:if>
    <xsl:text> ;
  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  cidoc:P1_is_identified_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/idno/0&gt;</xsl:text>
    <xsl:if test="@authorId != ''">
      <xsl:text> ;
  frbroo:R17i_was_created_by &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>/creation&gt;</xsl:text>
    </xsl:if>
    <xsl:text> .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-text-F22-orig">
    <xsl:if test="@origAuthor != ''">    
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>orig&gt; a frbroo:F22_Self-Contained_Expression ;
  rdfs:label &quot;Original Expression: </xsl:text>
    <xsl:value-of select="@titleText"/>
    <xsl:text>&quot;@en ;
  cidoc:P16i_was_used_for &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/creation&gt;  .
    
</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="create-text-E42-identifier">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; a cidoc:E42_Identifier ;
  rdfs:label &quot;Identifier: </xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot;@en ;
  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/idno/xml-id&gt; ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-text-E42-identifier-idno">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/identifier/idno/0&gt; a cidoc:E42_Identifier ;
  rdfs:label &quot;Identifier: </xsl:text>
    <xsl:value-of select="@webLink"/>
    <xsl:text>&quot;@en ;
  cidoc:P1i_identifies &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/idno/URL/fackel&gt; ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="@webLink"/>
    <xsl:text>&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-text-E35">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/title/0&gt; a cidoc:E35_Title ;
  rdfs:label &quot;Title: </xsl:text>
    <xsl:value-of select="@titleText"/>
    <xsl:text>&quot;@en ;
  cidoc:P102i_is_title_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt;</xsl:text>
    
    <xsl:choose>
      <xsl:when test="@titleSource='titleQuart' or @titleSource='quart' or @titleSource='samek' or @titleSource='titleUllmann' or @titleSource='p' or @titleSource='ullmann' or @titleSource='titleSamek' or @titleSource='fromContItem' or @titleSource='contPage' or @titleSource='sideQuart' or @titleSource='fromContItemuart'">
        <xsl:text> ;
  cidoc:P2_has_Type &lt;https://sk.acdh.oeaw.ac.at/types/title/prov&gt; ;
  prov:wasDerivedFrom &lt;https://sk.acdh.oeaw.ac.at/project/fackel-online&gt;</xsl:text>
      </xsl:when>
      <xsl:when test="@titleSource='pSemKraus' or  @titleSource='semKraus'">
        <xsl:text> ;
  cidoc:P2_has_Type &lt;https://sk.acdh.oeaw.ac.at/types/title/prov&gt; ;
  prov:wasDerivedFrom &lt;https://sk.acdh.oeaw.ac.at/project/semantic-kraus&gt;</xsl:text>
      </xsl:when>
    </xsl:choose>
    
    <xsl:text> ;
  rdf:value &quot;</xsl:text>
    <xsl:value-of select="@titleText"/>
    <xsl:text>&quot; .
    
</xsl:text>
  </xsl:template>

  <xsl:template name="create-text-E28">
    <xsl:if test="@authorId != ''">
      <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>/creation&gt; a frbroo:F28_Expression_Creation ;
  rdfs:label &quot;Creation of: </xsl:text>
      <xsl:value-of select="@titleText"/>
      <xsl:text>&quot;@en</xsl:text>
      <xsl:choose>
        <xsl:when test="contains(@authorId, ' ')">
          <xsl:for-each select="tokenize(normalize-space(@authorId), '\s')">
            <xsl:text> ; 
  cidoc:P14_carried_out_by &lt;https://sk.acdh.oeaw.ac.at/p_</xsl:text>
            <xsl:value-of select="translate(., 'https://fackel.oeaw.ac.at/?p=fackelp', '')"/>
            <xsl:text>&gt;</xsl:text>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> ; 
  cidoc:P14_carried_out_by &lt;https://sk.acdh.oeaw.ac.at/p_</xsl:text>
          <xsl:value-of select="translate(@authorId, 'https://fackel.oeaw.ac.at/?p=fackelp', '')"/>
          <xsl:text>&gt;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      
      <xsl:if test="@origAuthor != ''">
        <xsl:text> ;
  cidoc:P2_has_type &lt;https://sk.acdh.oeaw.ac.at/types/event/translation&gt;</xsl:text>   
      </xsl:if>   
      
      <xsl:text> ; 
  frbroo:R17_created &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>&gt; .
    
</xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="create-text-E28-orig">
    <xsl:if test="@origAuthor != ''">
      <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>orig/creation&gt; a frbroo:F28_Expression_Creation ;
  rdfs:label &quot;Creation of original: </xsl:text>
      <xsl:value-of select="@titleText"/>
      <xsl:text>&quot;@en</xsl:text>
      <xsl:choose>
        <xsl:when test="contains(@authorId, ' ')">
          <xsl:for-each select="tokenize(normalize-space(@origAuthor), '\s')">
            <xsl:text> ; 
  cidoc:P14_carried_out_by &lt;https://sk.acdh.oeaw.ac.at/p_</xsl:text>
            <xsl:value-of select="translate(., 'https://fackel.oeaw.ac.at/?p=fackelp', '')"/>
            <xsl:text>&gt;</xsl:text>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> ; 
  cidoc:P14_carried_out_by &lt;https://sk.acdh.oeaw.ac.at/p_</xsl:text>
          <xsl:value-of select="translate(@origAuthor, 'https://fackel.oeaw.ac.at/?p=fackelp', '')"/>
          <xsl:text>&gt;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      
      <xsl:text> ; 
  frbroo:R17_created &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>orig&gt; .
    
</xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="create-text-INT16-segment">
    <xsl:text>&lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>/segment&gt; a ns1:INT16_Segment ;
  rdfs:label &quot;Segment: </xsl:text>
    <xsl:value-of select="@titleText"/>
    <xsl:text>&quot;@en ;
  ns1:R16_incorporates &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>&gt; ;
  ns1:R25_is_segment_of &lt;https://sk.acdh.oeaw.ac.at/</xsl:text>
    <xsl:value-of select="ancestor::issue/@id"/>
    <xsl:text>/published-expression&gt; ;
  schema:pageStart &quot;</xsl:text>
    <xsl:value-of select="@startPage"/>
    <xsl:text>&quot; ;  
  schema:pageEnd &quot;</xsl:text>
    <xsl:value-of select="@endPage"/>
    <xsl:text>&quot; .
    
</xsl:text>
  </xsl:template>

</xsl:stylesheet>
