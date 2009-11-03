<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
	<xsl:variable name="objectType"
		select="/foxml:digitalObject/foxml:datastream/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description/rdf:type/@rdf:resource" />

	<xsl:variable name="objectId" select="/foxml:digitalObject/@PID" />
	<xsl:output encoding="utf-8" method="xml" />
	<xsl:template match="/">
		<xsl:if
			test="($objectType = 'http://escidoc.de/core/01/resources/ContentModel') 
	 or ($objectType = 'http://escidoc.de/core/01/resources/Context')
	 or ($objectType = 'http://escidoc.de/core/01/resources/OrganizationalUnit')
	 or ($objectType = 'http://escidoc.de/core/01/resources/Item') 
	 or ($objectType = 'http://escidoc.de/core/01/resources/Container') 
	 or ($objectType = 'http://escidoc.de/core/01/resources/Component')">
			<xsl:for-each select="foxml:digitalObject">
				<xsl:element name="foxml:digitalObject"
					namespace="info:fedora/fedora-system:def/foxml#">
					<!-- alle Attribute und Namespaces ans Root-Element anhängen -->
					<!-- alle Attribute und Namespaces ans Root-Element anhängen -->
				<xsl:namespace name="fedoraxsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
				<xsl:namespace name="foxml" select="'info:fedora/fedora-system:def/foxml#'"/>
				<xsl:attribute name="VERSION"><xsl:value-of select="@VERSION" /></xsl:attribute>
			<xsl:attribute name="PID">
															<xsl:value-of
																select="@PID" />
														</xsl:attribute>	
														<xsl:attribute
														name="fedoraxsi:schemaLocation"
															namespace="http://www.w3.org/2001/XMLSchema-instance"><xsl:value-of
																select="@xsi:schemaLocation" />
														</xsl:attribute>
					<xsl:for-each select="foxml:objectProperties">
						<xsl:element name="foxml:objectProperties"
							namespace="info:fedora/fedora-system:def/foxml#">
							<xsl:for-each
								select="foxml:property[@NAME!='info:fedora/fedora-system:def/model#contentModel' and @NAME!='http://www.w3.org/1999/02/22-rdf-syntax-ns#type']">
								<xsl:element name="foxml:property"
									namespace="info:fedora/fedora-system:def/foxml#">
									<xsl:for-each select="@*">
										<xsl:copy />
									</xsl:for-each>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:for-each>
					<!-- alle datastreams kopieren  -->
					<xsl:for-each select="foxml:datastream">
						<xsl:choose>
							<!-- bereits im Ausgangsdokument enthaltene Ergebnis-Tags ignorieren -->
							<xsl:when test="@ID!='RELS-EXT'">
								<xsl:copy-of select="."
									copy-namespaces="no" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:element name="foxml:datastream"
									namespace="info:fedora/fedora-system:def/foxml#">
									<!-- Attribute übernehmen -->
									<xsl:for-each select="@*">
										<xsl:copy />
									</xsl:for-each>
									<xsl:for-each
										select="foxml:datastreamVersion">
										<!--  dann das Tagging teilweise original übernehmen -->
										<xsl:element
											name="foxml:datastreamVersion"
											namespace="info:fedora/fedora-system:def/foxml#">
											<!-- Attribute übernehmen -->
											<xsl:for-each select="@*">
												<xsl:copy />
											</xsl:for-each>
											<xsl:for-each
												select="foxml:contentDigest">
												<xsl:copy-of select="."
													copy-namespaces="no" />
											</xsl:for-each>
											<xsl:element
												name="foxml:xmlContent"
												namespace="info:fedora/fedora-system:def/foxml#">
												<xsl:element
													name="rdf:RDF"
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
															name="system:build"
															namespace="http://escidoc.de/core/01/system/">
															<xsl:value-of
																select="'304'" />
														</xsl:element>

														<xsl:for-each
															select="foxml:xmlContent/rdf:RDF/rdf:Description/*">
															<xsl:copy-of
																select="." copy-namespaces="no" />
														</xsl:for-each>
													</xsl:element>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:for-each>

				</xsl:element>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>