<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3"
	xmlns:premis="http://www.loc.gov/standards/premis/v1"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="CONTENT_MODEL_HREF">/cmm/content-model/</xsl:variable>
	<xsl:variable name="ITEM_HREF">/ir/item/</xsl:variable>

	<xsl:template match="escidocVersions:version">
               	<xsl:copy>
			<xsl:for-each select="@*">
                                <xsl:choose>
       	                                <xsl:when test="name ()= 'xlink:href'">
						<xsl:attribute name="{name()}" namespace="{namespace-uri()}">
							<xsl:value-of select="replace(., $ITEM_HREF, $CONTENT_MODEL_HREF)" />
						</xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
						<xsl:copy-of select="." copy-namespaces="no"/>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </xsl:for-each>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="premis:eventIdentifierValue">
		<xsl:element name="{name()}" namespace="{namespace-uri()}">
			<xsl:value-of select="replace(., $ITEM_HREF, $CONTENT_MODEL_HREF)" />
		</xsl:element>
	</xsl:template>

	<xsl:template name="contentModelTemplate">
		<xsl:apply-templates />
	</xsl:template>

</xsl:stylesheet>

