<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"
	xmlns:audit="info:fedora/fedora-system:def/audit#"
	xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#"
	xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:types="http://escidoc.mpg.de/metadataprofile/schema/0.1/types"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3"
	xmlns:premis="http://www.loc.gov/standards/premis/v1"
	xmlns:item="http://www.escidoc.de/schemas/item/0.3/"
	exclude-result-prefixes="fedoraxsi xsl types rdf dcterms audit">
	<xsl:import href="ElementWithCorrectContentDigest.xsl" />
	<xsl:import href="VersionHistory.xsl" />
	<xsl:import href="contentDigest.xsl" />
	<xsl:output encoding="utf-8" method="xml" />
	<!--  
		<xsl:template match="/">
		
		<xsl:call-template name="itemTemplate" />
		</xsl:template>
	-->
	<xsl:template name="itemTemplate">
		<!-- hier wird das neue XML erzeugt -->
		<xsl:for-each select="foxml:datastream">
			<xsl:choose>
				<!-- falls DC, dann Inhalt kopieren -->
				<xsl:when
					test="foxml:datastreamVersion/foxml:xmlContent/oai_dc:dc">
					<xsl:call-template name="elementWithCorrectContentDigestTemplate" />
				</xsl:when>

				<!-- falls Escidoc, dann Inhalt kopieren  -->
				<xsl:when test="@ID='escidoc'">
					<!-- escidoc data stream einfach kopieren -->
					<xsl:call-template name="elementWithCorrectContentDigestTemplate" />
				</xsl:when>
				<!-- falls content-model-specific, dann Inhalt bis auf Element content-model-specific kopieren  -->
				<xsl:when test="@ID='content-model-specific'">
					<xsl:copy copy-namespaces="no">
						<xsl:for-each select="@*">
							<xsl:copy />
						</xsl:for-each>
						<xsl:for-each
							select="foxml:datastreamVersion">
							<xsl:copy copy-namespaces="no">
								<xsl:for-each select="@*">
									<xsl:copy />
								</xsl:for-each>
								<xsl:call-template name="contentDigestTemplate" />
								<xsl:element name="foxml:xmlContent"
									namespace="info:fedora/fedora-system:def/foxml#">
									<xsl:for-each
										select="foxml:xmlContent/*">
										<xsl:element
											name="prop:content-model-specific"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:for-each select="@*">
												<xsl:copy />
											</xsl:for-each>
											<xsl:copy-of select="*"
												copy-namespaces="no" />
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:copy>
						</xsl:for-each>
					</xsl:copy>
				</xsl:when>
				<!-- falls version-history, dann Inhalt der letzten Version kopieren  -->
				<xsl:when test="@ID='version-history'">
					<xsl:call-template name="VersionHistoryTemplate" />
				</xsl:when>
				<!-- falls RELS-EXT, dann Inhalt anpassen  -->
				<xsl:when
					test="foxml:datastreamVersion/foxml:xmlContent/rdf:RDF">
					<xsl:element name="foxml:datastream"
						namespace="info:fedora/fedora-system:def/foxml#">
						<!-- Attribute übernehmen -->
						<xsl:for-each select="@*">
							<xsl:copy />
						</xsl:for-each>
						<xsl:for-each
							select="foxml:datastreamVersion"><xsl:variable name="versionDate" select="foxml:xmlContent/rdf:RDF/rdf:Description/item:latest-version.date" />
							<xsl:variable name="publicStatus" select="foxml:xmlContent/rdf:RDF/rdf:Description/item:public-status" />
							<!--  dann das Tagging teilweise original übernehmen -->
							<xsl:element name="foxml:datastreamVersion"
								namespace="info:fedora/fedora-system:def/foxml#">
								<!-- Attribute übernehmen -->
								<xsl:for-each select="@*">
									<xsl:copy />
								</xsl:for-each>
								<!-- diesen Tag original übernehmen -->
								<xsl:call-template name="contentDigestTemplate" />
								<xsl:element name="foxml:xmlContent"
									namespace="info:fedora/fedora-system:def/foxml#">
									<xsl:element name="rdf:RDF"
										namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
										<xsl:element
											name="rdf:Description"
											namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
											<xsl:attribute
												name="rdf:about"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of
													select="foxml:xmlContent/rdf:RDF/rdf:Description/@rdf:about" />
													</xsl:attribute>
											<xsl:for-each
												select="foxml:xmlContent/rdf:RDF/rdf:Description/*">
												<xsl:variable
													name="name" select="local-name()" />
												<xsl:variable
													name="fullname" select="name()" />
												<xsl:if
													test="starts-with($fullname,'nsCR')">
													<xsl:copy-of
														select="." copy-namespaces="no" />
												</xsl:if>
												<xsl:if
													test="$name='hasComponent'">
													<xsl:element
														name="srel:component"
														namespace="http://escidoc.de/core/01/structural-relations/">
														<xsl:attribute
															name="rdf:resource"
															namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of
																select="@rdf:resource" />
																</xsl:attribute>
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='public-status'">
													<xsl:element
														name="prop:public-status"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="." />
													</xsl:element>
													<xsl:if test =".='pending'">
													<xsl:element
														name="prop:public-status-comment"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history/escidocVersions:version[position()=last()]/escidocVersions:events/premis:event/premis:eventDetail" />
													</xsl:element>
													</xsl:if>
													<xsl:if test =".='submitted'">
													<xsl:element
														name="prop:public-status-comment"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history/escidocVersions:version[escidocVersions:events[count(premis:event)>1]]/escidocVersions:events/premis:event[position()=1]/premis:eventDetail" />
													</xsl:element>
													</xsl:if>
												</xsl:if>
												<xsl:if
													test="$name='context-title'">
													<xsl:element
														name="prop:context-title"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='context'">
													<xsl:element
														name="srel:context"
														namespace="http://escidoc.de/core/01/structural-relations/">
														<xsl:attribute
															name="rdf:resource"
															namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of
																select="@rdf:resource" />
																</xsl:attribute>
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='content-model-title'">
													<xsl:element
														name="prop:content-model-title"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='content-model'">
													<xsl:element
														name="srel:content-model"
														namespace="http://escidoc.de/core/01/structural-relations/">
														<xsl:attribute
															name="rdf:resource"
															namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of
																select="@rdf:resource" />
																</xsl:attribute>
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='created-by'">
													<xsl:element
														name="srel:created-by"
														namespace="http://escidoc.de/core/01/structural-relations/">
														<xsl:attribute
															name="rdf:resource"
															namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of
																select="@rdf:resource" />
																</xsl:attribute>
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-version.user'">
													<xsl:element
														name="srel:modified-by"
														namespace="http://escidoc.de/core/01/structural-relations/">
														<xsl:attribute
															name="rdf:resource"
															namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">info:fedora/<xsl:value-of
																select="." />
																</xsl:attribute>
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-version.user.title'">
													<xsl:element
														name="prop:modified-by-title"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='created-by-title'">
													<xsl:element
														name="prop:created-by-title"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='objectType'">
													<xsl:element
														name="rdf:type"
														namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
														<xsl:attribute
															name="rdf:resource"
															namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">http://escidoc.de/core/01/resources/Item</xsl:attribute>
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-version.date'">
													<xsl:element
														name="version:date"
														namespace="http://escidoc.de/core/01/properties/version/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-version.number'">
													<xsl:element
														name="version:number"
														namespace="http://escidoc.de/core/01/properties/version/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-version.status'">
													<xsl:element
														name="version:status"
														namespace="http://escidoc.de/core/01/properties/version/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-version.comment'">
													<xsl:element
														name="version:comment"
														namespace="http://escidoc.de/core/01/properties/version/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-release.pid'">
													<xsl:element
														name="release:pid"
														namespace="http://escidoc.de/core/01/properties/release/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='latest-release.number'">
													<xsl:variable
													name="releaseNumber" select="." />
													<xsl:element
														name="release:number"
														namespace="http://escidoc.de/core/01/properties/release/">
														<xsl:value-of
															select="." />
													</xsl:element>
													<xsl:if
													test="$publicStatus='released' or $publicStatus='withdrawn'">
													<xsl:element
														name="prop:public-status-comment"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history/escidocVersions:version[escidocVersions:version-number=$releaseNumber]/escidocVersions:events/premis:event[position()= 1]/premis:eventDetail" />
													</xsl:element>
													</xsl:if>
												</xsl:if>
												<xsl:if
													test="$name='latest-release.date'">
													<xsl:element
														name="release:date"
														namespace="http://escidoc.de/core/01/properties/release/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
												<xsl:if
													test="$name='pid'">
													<xsl:element
														name="prop:pid"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="." />
													</xsl:element>
												</xsl:if>
											</xsl:for-each>
										</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>

