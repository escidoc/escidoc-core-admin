<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#"
	exclude-result-prefixes="foxml xsl">
	<xsl:import href="contentDigest.xsl" />
	<xsl:output encoding="utf-8" method="xml" />

	<xsl:template name="elementWithCorrectContentDigestTemplate">
		<xsl:copy copy-namespaces="no">
			<xsl:for-each select="@*">
				<xsl:copy />
			</xsl:for-each>
			<xsl:for-each select="foxml:datastreamVersion">
				<xsl:copy copy-namespaces="no">
					<xsl:for-each select="@*">
						<xsl:copy />
					</xsl:for-each>
					<xsl:call-template name="contentDigestTemplate" />
					<xsl:for-each
						select="*[local-name() != 'contentDigest']">
						<xsl:copy-of select="." copy-namespaces="no" />
					</xsl:for-each>
				</xsl:copy>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>