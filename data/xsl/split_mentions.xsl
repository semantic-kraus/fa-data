<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:output method="xml" encoding="UTF-8" media-type="text/plain" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="split-amount" select="10"/>
        <xsl:variable name="mention" select="//mention" as="item()*"/>
        <xsl:variable name="count" select="count($mention)"/>
        <xsl:for-each select="$mention[position() &lt;= $split-amount]">
            <xsl:call-template name="split">
                <xsl:with-param name="seq" select="position()"/>
                <xsl:with-param name="calc" select="$split-amount"/>
                <xsl:with-param name="count-mentions" select="$count"/>
                <xsl:with-param name="mention" select="$mention"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="split">
        <xsl:param name="seq"/>
        <xsl:param name="calc"/>
        <xsl:param name="count-mentions"/>
        <xsl:param name="mention"/>
        <xsl:result-document method="xml" href="../data/indices/mentions{$seq}.xml">
            <list>
            <xsl:for-each select="$mention">
                <xsl:variable name="text-id" select="./text_id/text()"/>
                <xsl:variable name="text-pos" select="count(preceding-sibling::mention[text_id/text() = $text-id]) + 1"/>
                <xsl:if test="position() &lt;= ($count-mentions div $calc) * $seq and position() &gt; ($count-mentions div $calc) * ($seq - 1)">
                    <xsl:copy>
                        <xsl:attribute name="n" select="$text-pos"/>
                        <xsl:apply-templates select="node()|@*" />
                    </xsl:copy>
                </xsl:if>
            </xsl:for-each>
            </list>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
