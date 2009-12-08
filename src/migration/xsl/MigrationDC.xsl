<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3">


	<xsl:output encoding="utf-8" method="xml" />
	<xsl:template match="/">

		<xsl:for-each select="foxml:digitalObject">
			<xsl:element name="foxml:digitalObject" namespace="info:fedora/fedora-system:def/foxml#">
				<!-- alle Attribute und Namespaces ans Root-Element anhängen -->
				<xsl:namespace name="fedoraxsi"
					select="'http://www.w3.org/2001/XMLSchema-instance'" />
				<xsl:for-each select="@*">
					<xsl:variable name="name" select="name()" />
					
					<xsl:choose>
						<!--  changed a prefix in the declaration of a name space http://www.w3.org/2001/XMLSchema-instance -->
						<xsl:when test="$name = 'xsi:schemaLocation'">
							<xsl:attribute name="fedoraxsi:schemaLocation"
								namespace="http://www.w3.org/2001/XMLSchema-instance" select="." />
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="{$name}"><xsl:value-of
								select="." />
											</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:for-each select="foxml:objectProperties">
					<xsl:copy-of select="." copy-namespaces="no" />
				</xsl:for-each>
				<xsl:for-each select="foxml:datastream">
					<xsl:choose>
						<xsl:when test="@ID='DC'">
							<xsl:element name="foxml:datastream"
								namespace="info:fedora/fedora-system:def/foxml#">
								<!-- Attribute übernehmen -->
								<xsl:for-each select="@*">
									<xsl:copy />
								</xsl:for-each>
								<xsl:for-each select="foxml:datastreamVersion">
									<xsl:element name="foxml:datastreamVersion"
										namespace="info:fedora/fedora-system:def/foxml#">
										<xsl:for-each select="@*">
											<xsl:copy />
										</xsl:for-each>
										<xsl:for-each select="foxml:xmlContent">
											<xsl:element name="foxml:xmlContent"
												namespace="info:fedora/fedora-system:def/foxml#">
												<xsl:for-each select="oai_dc:dc">
													<xsl:element name="oai_dc:dc"
														namespace="http://www.openarchives.org/OAI/2.0/oai_dc/">
														<xsl:namespace name="xsi"
															select="'http://www.w3.org/2001/XMLSchema-instance'" />
														<xsl:namespace name="dc"
															select="'http://purl.org/dc/elements/1.1/'" />
														<xsl:choose>
															<xsl:when test="@xsi:schemaLocation">

															</xsl:when>
															<xsl:otherwise>
																<xsl:attribute name="xsi:schemaLocation"
																	namespace="http://www.w3.org/2001/XMLSchema-instance"
																	select="'http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd'" />
															</xsl:otherwise>
														</xsl:choose>

														<xsl:for-each select="@*">
															<xsl:copy />
														</xsl:for-each>
														<xsl:for-each
															select="*[namespace-uri() = 'http://purl.org/dc/elements/1.1/']">
															<xsl:variable name="name" select="name()" />
															<xsl:element name="{$name}"
																namespace="http://purl.org/dc/elements/1.1/">
																<xsl:for-each select="@*">
																	<xsl:variable name="name2" select="name()" />
																	<!--  -->
																	<xsl:choose>
																		<xsl:when test="$name2 = 'xml:lang'">
																			<xsl:attribute name="{$name2}">
													<xsl:value-of select="." />
													</xsl:attribute>
																		</xsl:when>
																		<xsl:otherwise>
																		</xsl:otherwise>
																	</xsl:choose>
																</xsl:for-each>
																<xsl:value-of select="." />
															</xsl:element>
														</xsl:for-each>
													</xsl:element>
												</xsl:for-each>
											</xsl:element>
										</xsl:for-each>
									</xsl:element>
								</xsl:for-each>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="." copy-namespaces="no" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
