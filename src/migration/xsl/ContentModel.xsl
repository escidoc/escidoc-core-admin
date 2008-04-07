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
	xmlns:content-type="http://www.escidoc.de/schema/contenttype/0.2"
	xmlns:dcterms="http://purl.org/dc/terms/"
	exclude-result-prefixes="fedoraxsi xsl types rdf dcterms audit content-type">
	<xsl:import href="contentDigest.xsl" />
	<xsl:output encoding="utf-8" method="xml" />
	<!--  
		<xsl:template match="/">
		
		<xsl:call-template name="cmTemplate" />
		</xsl:template>
	-->
	<xsl:template name="cmTemplate">
		<!-- hier wird das neue XML erzeugt -->
		<xsl:for-each select="foxml:datastream">
			<xsl:choose>
				<!-- falls DC, dann Inhalt kopieren -->
				<xsl:when
					test="foxml:datastreamVersion/foxml:xmlContent/oai_dc:dc">
					<xsl:copy-of select="." copy-namespaces="no" />
				</xsl:when>


				<!-- falls content-model-specific, dann Inhalt bis auf Element content-model-specific kopieren  -->
				<xsl:when test="@ID='datastream'">
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
										select="foxml:xmlContent/content-type:content-type">

										<xsl:element
											name="content-model:content-model"
											namespace="http://www.escidoc.de/schema/contenttype/0.2">
											<xsl:for-each select="@*">
												<xsl:copy
													copy-namespaces="no" />
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
											<xsl:for-each
												select="foxml:xmlContent/rdf:RDF/rdf:Description/*">
												<xsl:variable
													name="name" select="local-name()" />
												<xsl:if
													test="$name='title'">
													<xsl:element
														name="prop:title"
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
															namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">http://escidoc.de/core/01/resources/ContentModel</xsl:attribute>
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

