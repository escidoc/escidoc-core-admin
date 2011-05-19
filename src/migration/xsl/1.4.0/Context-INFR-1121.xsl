<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:srel="http://escidoc.de/core/01/structural-relations/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="rdf:RDF/rdf:Description/srel:organizational-unit">
		<xsl:choose>
			<xsl:when test="normalize-space(.)">
				<xsl:element name="{name()}" namespace="{namespace-uri()}">
                        		<xsl:for-each select="@*">
                                		<xsl:copy />
                        		</xsl:for-each>
					<xsl:attribute name="rdf:resource">
						<xsl:value-of select="concat('info:fedora/', .)" />
					</xsl:attribute>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="." copy-namespaces="no" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="contextTemplate">
		<xsl:apply-templates />
	</xsl:template>

</xsl:stylesheet>

