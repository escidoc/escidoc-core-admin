<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes=" xsl">
	<xsl:output encoding="utf-8" method="xml" />

	<xsl:template name="contentDigetsTemplate">
		<xsl:copy copy-namespaces="no">
			<xsl:for-each select="@*">
				<xsl:copy />
			</xsl:for-each>
			<xsl:for-each select="foxml:datastreamVersion">
				<xsl:copy copy-namespaces="no">
					<xsl:for-each select="@*">
						<xsl:copy />
					</xsl:for-each>
					<xsl:element name="foxml:contentDigest"
						namespace="info:fedora/fedora-system:def/foxml#">
						<xsl:for-each select="foxml:contentDigest/@*">
							<xsl:variable name="name"
								select="local-name()" />
							<!-- das Attribute "TYPE" muss auf dem Wert "DISABLED" gesetzt werden -->
							<xsl:choose>
								<xsl:when test="$name = 'TYPE'">
									<xsl:attribute name="TYPE">DISABLED</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="{$name}"><xsl:value-of
											select="." />
											</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:element>
					<xsl:for-each
						select="*[local-name() != 'contentDigest']">
						<xsl:copy-of select="." copy-namespaces="no" />
					</xsl:for-each>
				</xsl:copy>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>