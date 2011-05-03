<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	 xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3">


	<xsl:output encoding="utf-8" method="xml" />
	<!--
		<xsl:template match="/"> <xsl:call-template name="dcTemplate"
		/> </xsl:template>
	-->
	<xsl:template name="dcTemplate">
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
															<xsl:variable name="name" select="local-name()" />
															<xsl:element name="dc:{$name}"
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
						
	</xsl:template>
</xsl:stylesheet>
