<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:foxml="info:fedora/fedora-system:def/foxml#"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3"
	xmlns:premis="http://www.loc.gov/standards/premis/v1" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:prop="http://escidoc.de/core/01/properties/" xmlns:version="http://escidoc.de/core/01/properties/version/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">


	<xsl:output encoding="utf-8" method="xml" />
	<!--
		<xsl:template match="/"> <xsl:call-template name="dcTemplate" />
		</xsl:template>
	-->
	<xsl:template name="versionHistoryTemplate">
		<xsl:element name="escidocVersions:version-history"
			namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
			<!-- Attribute übernehmen -->
			<xsl:for-each select="escidocVersions:version-history/@*">
				<xsl:copy />
			</xsl:for-each>
			<xsl:for-each
				select="escidocVersions:version-history/escidocVersions:version">
				<xsl:variable name="versionNr" select="escidocVersions:version-number" />
				<xsl:element name="escidocVersions:version"
					namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
					<xsl:for-each select="@*">
						<xsl:copy />
					</xsl:for-each>
					<!--					<xsl:for-each-->
					<!--
						select="*[name()!='escidocVersions:events' and
						name()!='escidocVersions:comment']">
					-->
					<!--						<xsl:copy-of select="." copy-namespaces="no" />-->
					<!--					</xsl:for-each>-->
					<xsl:for-each select="escidocVersions:comment">
						<xsl:element name="escidocVersions:comment"
							namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
							<xsl:for-each
								select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description[version:number=$versionNr]">
								<xsl:if test="position()=last()">
									<xsl:for-each select="version:comment">
										<xsl:value-of select="normalize-space()" />
									</xsl:for-each>
								</xsl:if>
							</xsl:for-each>
						</xsl:element>
					</xsl:for-each>
					<xsl:for-each select="escidocVersions:events">
						<xsl:element name="escidocVersions:events"
							namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
							<xsl:variable name="countEvents" select="count(*[name()='premis:event'])" />
							<xsl:for-each select="premis:event">
								<xsl:variable name="eventPosition" select="position()" />
								<xsl:variable name="positionRelsExt">
									<xsl:value-of select="($countEvents - $eventPosition+1)*2" />
								</xsl:variable>
								<xsl:variable name="eventType" select="premis:eventType" />
								<xsl:element name="premis:event"
									namespace="http://www.loc.gov/standards/premis/v1">
									<xsl:for-each select="@*">
										<xsl:copy />
									</xsl:for-each>

									<xsl:for-each
										select="*[name()!='premis:linkingAgentIdentifier' and name()!='premis:linkingObjectIdentifier' and name()!='premis:eventDetail']">
										<xsl:copy-of select="." copy-namespaces="no" />
									</xsl:for-each>
									<xsl:for-each select="premis:eventDetail">
										<xsl:element name="premis:eventDetail"
											namespace="http://www.loc.gov/standards/premis/v1">
											<xsl:choose>
												<!--
													depend on a status, value from RELS-EXT will be taken
													either from element version:comment or from the element
													prop:public-status-comment
												-->
												<xsl:when test="$eventType = 'withdrawn'">
													<xsl:for-each
														select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description[version:number=$versionNr]">
														<xsl:if test="position()=$positionRelsExt">
															<xsl:for-each select="prop:public-status-comment">
																<xsl:value-of select="normalize-space()" />
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<xsl:for-each
														select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description[version:number=$versionNr]">
														<xsl:if test="position()=$positionRelsExt">
															<xsl:for-each select="version:comment">
																<xsl:value-of select="normalize-space()" />
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:otherwise>
											</xsl:choose>

										</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="premis:linkingAgentIdentifier">

										<xsl:element name="premis:linkingAgentIdentifier"
											namespace="http://www.loc.gov/standards/premis/v1">
											<xsl:for-each
												select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description[version:number=$versionNr]">
												<xsl:if test="position()=$positionRelsExt">
													<xsl:for-each select="prop:modified-by-title">

														<xsl:attribute name="xlink:title"
															namespace="http://www.w3.org/1999/xlink">
											<xsl:for-each
															select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description[version:number=$versionNr]">
														<xsl:if test="position()=$positionRelsExt">
															<xsl:for-each select="prop:modified-by-tite">
																<xsl:value-of select="normalize-space()" />
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
																	<xsl:value-of select="normalize-space()" />
															</xsl:attribute>
													</xsl:for-each>
												</xsl:if>
											</xsl:for-each>
											<xsl:for-each select="@*[name()!='xlink:title']">
												<xsl:copy />
											</xsl:for-each>
											<xsl:for-each select="*">
												<xsl:copy-of select="." copy-namespaces="no" />
											</xsl:for-each>
										</xsl:element>
									</xsl:for-each>
									<xsl:for-each select="premis:linkingObjectIdentifier">
										<xsl:copy-of select="." copy-namespaces="no" />
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
