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
				<!-- falls DC, dann nichts machen -->
				<xsl:when
					test="foxml:datastreamVersion/foxml:xmlContent/oai_dc:dc" />


				<!-- falls Escidoc, dann Inhalt kopieren  -->

				<xsl:when test="@ID='escidoc'">
					<xsl:element name="foxml:datastream"
						namespace="info:fedora/fedora-system:def/foxml#">
						<xsl:for-each select="@*">
							<xsl:variable name="name"
								select="local-name()" />
							<!-- die ID muss hier analog zum Tagging in datastreamVersion in DC geändert werden, die restlichen Attribute übernehmen -->
							<xsl:choose>
								<xsl:when test="$name = 'ID'">
									<xsl:attribute name="ID">DC</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="{$name}"><xsl:value-of
											select="." />
											</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each
							select="foxml:datastreamVersion">
							<xsl:variable name="counter"
								select="position() -1" />
							<!-- zunächst XML umbauen -->
							<xsl:element name="foxml:datastreamVersion"
								namespace="info:fedora/fedora-system:def/foxml#">
								<xsl:attribute name="CREATED"
									select="@CREATED" />
								<xsl:attribute name="ID"
									select="concat('DC.',$counter)" />
								<xsl:attribute name="LABEL" select="''" />
								<xsl:attribute name="MIMETYPE"
									select="'text/xml'" />
								<xsl:call-template
									name="contentDigestTemplate" />
								<xsl:element name="foxml:xmlContent"
									namespace="info:fedora/fedora-system:def/foxml#">

									<xsl:for-each
										select="foxml:xmlContent">
										<xsl:choose>
											<xsl:when
												test="*[namespace-uri() = 'http://escidoc.mpg.de/metadataprofile/schema/0.1/']">
												<xsl:call-template
													name="mpdlMapping" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template
													name="genericMapping" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
					<!-- escidoc data stream einfach kopieren -->
					<xsl:call-template
						name="elementWithCorrectContentDigestTemplate" />
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
								<xsl:call-template
									name="contentDigestTemplate" />
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
							select="foxml:datastreamVersion">
							<xsl:variable name="versionDate"
								select="foxml:xmlContent/rdf:RDF/rdf:Description/item:latest-version.date" />
							<xsl:variable name="publicStatus"
								select="foxml:xmlContent/rdf:RDF/rdf:Description/item:public-status" />
							<!--  dann das Tagging teilweise original übernehmen -->
							<xsl:element name="foxml:datastreamVersion"
								namespace="info:fedora/fedora-system:def/foxml#">
								<!-- Attribute übernehmen -->
								<xsl:for-each select="@*">
									<xsl:copy />
								</xsl:for-each>
								<!-- diesen Tag original übernehmen -->
								<xsl:call-template
									name="contentDigestTemplate" />
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
													<xsl:element
														name="prop:build"
														namespace="http://escidoc.de/core/01/system/">
														<xsl:value-of
															select="'299'" />
															</xsl:element>
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
													<xsl:if
														test=".='pending'">
														<xsl:element
															name="prop:public-status-comment"
															namespace="http://escidoc.de/core/01/properties/">
															<xsl:value-of
																select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history/escidocVersions:version[position()=last()]/escidocVersions:events/premis:event/premis:eventDetail" />
														</xsl:element>
													</xsl:if>
													<xsl:if
														test=".='submitted'">
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
													<xsl:choose>
														<xsl:when
															test="$publicStatus='withdrawn'">

															<xsl:variable
																name="versionStatus"
																select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history/escidocVersions:version[position()=1]/escidocVersions:events/premis:event[position()=2]/premis:eventType" />

															<xsl:variable
																name="count"
																select="count(/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history/escidocVersions:version[position()=1]/escidocVersions:events/premis:event)" />
															<xsl:choose>
																<xsl:when
																	test="$count > 2">
																	<xsl:element
																		name="version:status"
																		namespace="http://escidoc.de/core/01/properties/version/">
																		<xsl:value-of
																			select="$versionStatus" />
																	</xsl:element>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:element
																		name="version:status"
																		namespace="http://escidoc.de/core/01/properties/version/">
																		<xsl:value-of
																			select="'pending'" />
																	</xsl:element>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:otherwise>
															<xsl:element
																name="version:status"
																namespace="http://escidoc.de/core/01/properties/version/">
																<xsl:value-of
																	select="." />
															</xsl:element>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>

												<xsl:if
													test="$name='latest-version.comment'">
													<xsl:variable
														name="versionComment"
														select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history/escidocVersions:version[position()=1]/escidocVersions:events/premis:event[position()=2]/premis:eventDetail" />
													<xsl:choose>
														<xsl:when
															test="$publicStatus='withdrawn'">
															<xsl:element
																name="version:comment"
																namespace="http://escidoc.de/core/01/properties/version/">
																<xsl:value-of
																	select="$versionComment" />
															</xsl:element>
														</xsl:when>
														<xsl:otherwise>
															<xsl:element
																name="version:comment"
																namespace="http://escidoc.de/core/01/properties/version/">
																<xsl:value-of
																	select="." />
															</xsl:element>
														</xsl:otherwise>
													</xsl:choose>
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
	<xsl:template name="mpdlMapping">
		<xsl:element name="oai_dc:dc"
			namespace="http://www.openarchives.org/OAI/2.0/oai_dc/">

			<xsl:copy-of select="*/dc:title" copy-namespaces="no" />
			<xsl:call-template name="creators" />
			<xsl:copy-of select="*/dc:subject" copy-namespaces="no" />
			<xsl:copy-of select="*/dc:description" copy-namespaces="no" />
			<xsl:copy-of
				select="*/*[local-name() = 'publishing-info']/dc:publisher"
				copy-namespaces="no" />
			<xsl:call-template name="contributors" />
			<xsl:choose>
				<xsl:when test="*/dc:date">
					<xsl:element name="dc:date"
						namespace="http://purl.org/dc/elements/1.1">
						<xsl:value-of select="*/dc:date" />
					</xsl:element>
				</xsl:when>
				<xsl:when test="*/dcterms:created">
					<dc:date>
						<xsl:value-of select="*/dcterms:created" />
					</dc:date>
				</xsl:when>
				<xsl:when test="*/dcterms:modified">
					<xsl:element name="dc:date"
						namespace="http://purl.org/dc/elements/1.1">

						<xsl:value-of select="*/dcterms:modified" />
					</xsl:element>
				</xsl:when>
				<xsl:when test="*/dcterms:dateSubmitted">
					<xsl:element name="dc:date"
						namespace="http://purl.org/dc/elements/1.1">
						<xsl:value-of select="*/dcterms:dateSubmitted" />
					</xsl:element>
				</xsl:when>
				<xsl:when test="*/dcterms:dateAccepted">
					<xsl:element name="dc:date"
						namespace="http://purl.org/dc/elements/1.1">
						<xsl:value-of select="*/dcterms:dateAccepted" />
					</xsl:element>
				</xsl:when>
				<xsl:when test="*/dcterms:issued">
					<xsl:element name="dc:date"
						namespace="http://purl.org/dc/elements/1.1">
						<xsl:value-of select="*/dcterms:issued" />
					</xsl:element>
				</xsl:when>
			</xsl:choose>
			<!--
				type => will be defined later
				format => will be defined later
			-->
			<xsl:copy-of select="*/dc:identifier" copy-namespaces="no" />
			<dc:identifier>
				<xsl:value-of select="/foxml:digitalObject/@PID" />
			</dc:identifier>
			<xsl:call-template name="source" />
			<xsl:copy-of select="*/dc:language" copy-namespaces="no" />
			<!--
				relation => will be defined later
				coverage => will be defined later
				rights => will be defined later
			-->
		</xsl:element>

	</xsl:template>
	<xsl:template name="creators">
		<xsl:for-each
			select="*/*[local-name() = 'creator' and @role='author'][1]">
			<xsl:element name="dc:creator"
				namespace="http://purl.org/dc/elements/1.1">
				<xsl:choose>
					<xsl:when test="./types:person">
						<xsl:value-of
							select="./types:person/types:given-name" />
						<xsl:text> </xsl:text>
						<xsl:value-of
							select="./types:person/types:family-name" />
					</xsl:when>
					<xsl:when test="./types:organization">
						<xsl:value-of
							select="./types:organization/types:organization-name" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="." />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="contributors">
		<xsl:for-each
			select="*/*[local-name() = 'creator' and @role!='author']">
			<xsl:element name="dc:contributor"
				namespace="http://purl.org/dc/elements/1.1">
				<xsl:choose>
					<xsl:when test="./types:person">
						<xsl:value-of
							select="./types:person/types:given-name" />
						<xsl:text> </xsl:text>
						<xsl:value-of
							select="./types:person/types:family-name" />
					</xsl:when>
					<xsl:when test="./types:organization">
						<xsl:value-of
							select="./types:organization/types:organization-name" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="." />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="source">
		<xsl:for-each select="*/*[local-name() = 'source'][1]">
			<xsl:element name="dc:source"
				namespace="http://purl.org/dc/elements/1.1">
				<xsl:for-each select="./dc:title/@*">
					<xsl:copy />
				</xsl:for-each>
				<xsl:value-of select="./dc:title" />
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="genericMapping">
		<!-- if there is an element in the dc-elements namespace, do something -->
		<xsl:if
			test=".//*[namespace-uri() = 'http://purl.org/dc/elements/1.1/']">
			<oai_dc:dc
				xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
				xmlns:dc="http://purl.org/dc/elements/1.1/">
				<!-- select a value for dc:title, fallback is "eSciDoc Object [id]" -->
				<xsl:choose>
					<xsl:when test=".//dc:title">
						<xsl:copy-of select=".//dc:title"
							copy-namespaces="no" />
					</xsl:when>
					<xsl:when test="./*/*[local-name() = 'name']">
						<xsl:element name="dc:title"
							namespace="http://purl.org/dc/elements/1.1">
							<xsl:value-of
								select="./*/*[local-name() = 'name']" />
						</xsl:element>
					</xsl:when>
					<xsl:when test="./*/*[local-name() = 'title']">
						<xsl:element name="dc:title"
							namespace="http://purl.org/dc/elements/1.1">
							<xsl:value-of
								select="./*/*[local-name() = 'title']" />
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:element name="dc:title"
							namespace="http://purl.org/dc/elements/1.1">
							eSciDoc Object
							<xsl:value-of
								select="/foxml:digitalObject/@PID" />
						</xsl:element>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
					<xsl:when test=".//dc:description">
						<xsl:copy-of select=".//dc:description"
							copy-namespaces="no" />
					</xsl:when>
					<xsl:when
						test="./*/*[local-name() = 'description']">
						<xsl:element name="dc:description"
							namespace="http://purl.org/dc/elements/1.1">
							<xsl:value-of
								select="./*/*[local-name() = 'description']" />
						</xsl:element>
					</xsl:when>
				</xsl:choose>
				<xsl:element name="dc:identifier"
					namespace="http://purl.org/dc/elements/1.1">
					<xsl:value-of select="/foxml:digitalObject/@PID" />
				</xsl:element>
				<xsl:copy-of
					select="./*/*[namespace-uri() = 'http://purl.org/dc/elements/1.1/' and local-name() != 'title' and local-name() != 'description']"
					copy-namespaces="no" />
			</oai_dc:dc>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

