<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="UTF-8" media-type="text/plain" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/">
        <xsl:variable name="count-mentions" select="count(//mention)"/>
        <xsl:result-document method="xml" href="../data/indices/mentions1.xml">
            <list>
            <xsl:for-each select="//mention">
                <xsl:if test="position() &lt;= $count-mentions div 2">
                    <xsl:copy>
                        <xsl:apply-templates select="node()|@*" />
                    </xsl:copy>
                </xsl:if>
            </xsl:for-each>
            </list>
        </xsl:result-document>
        <xsl:result-document method="xml" href="../data/indices/mentions2.xml">
            <list>
            <xsl:for-each select="//mention">
                <xsl:if test="position() &gt; $count-mentions div 2">
                    <xsl:copy>
                        <xsl:apply-templates select="node()|@*" />
                    </xsl:copy>
                </xsl:if>
            </xsl:for-each>
            </list>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
