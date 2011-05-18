<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd">

	<xsl:import href="ContentModel-INFR-942.xsl" />

	<xsl:variable name="objectType"
		select="/foxml:digitalObject/foxml:datastream/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description/rdf:type/@rdf:resource" />

	<xsl:output encoding="UTF-8" method="xml" />

	<xsl:template match="/">
		<xsl:for-each select="foxml:digitalObject">
			<xsl:element name="foxml:digitalObject" namespace="info:fedora/fedora-system:def/foxml#">

				<xsl:for-each select="@*">
					<xsl:variable name="name" select="name()" />
                                        <xsl:choose>
                                                <xsl:when test="$name = 'xsi:schemaLocation'">
                                                        <xsl:attribute name="fedoraxsi:schemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance" select="." />
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <xsl:attribute name="{$name}">
								<xsl:value-of select="." />
							</xsl:attribute>
                                                </xsl:otherwise>
                                        </xsl:choose>
				</xsl:for-each>

				<xsl:for-each select="foxml:objectProperties">
					<xsl:copy-of select="." copy-namespaces="no" />
				</xsl:for-each>

				<xsl:choose>
					<xsl:when test="$objectType = 'http://escidoc.de/core/01/resources/ContentModel'">
						<xsl:call-template name="cmTemplate" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="foxml:datastream">
							<xsl:copy-of select="." copy-namespaces="no" />
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:element>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
