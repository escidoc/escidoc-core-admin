<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd" xmlns:audit="info:fedora/fedora-system:def/audit#" xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:context="http://www.escidoc.de/schemas/context/0.3/" xmlns:escidocRelations="http://www.nsdl.org/ontologies/relationships/" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
	<xsl:import href="contentDigest.xsl" />
	<xsl:output encoding="utf-8" method="xml" exclude-result-prefixes="#default fedoraxsi context"/>
	<xsl:template match="/">
		<xsl:call-template name="contextTemplate"/>
	</xsl:template>
	<xsl:template name="contextTemplate">
		
			<!-- hier wird das neue XML erzeugt -->
			<xsl:for-each select="foxml:datastream">
				<xsl:choose>
					<!-- bereits im Ausgangsdokument enthaltene Ergebnis-Tags ignorieren -->
					<xsl:when test="foxml:datastreamVersion/foxml:xmlContent/oai_dc:dc"/>
					<xsl:when test="foxml:datastreamVersion/foxml:xmlContent/rdf:RDF">
						<xsl:element name="foxml:datastream" namespace="info:fedora/fedora-system:def/foxml#">
							<xsl:for-each select="@*">
								<xsl:variable name="name" select="local-name()"/>
								<!-- die ID muss hier analog zum Tagging in datastreamVersion in DC geändert werden, die restlichen Attribute übernehmen -->
								<xsl:choose>
									<xsl:when test="$name = 'ID'">
										<xsl:attribute name="ID">DC</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="{$name}"><xsl:value-of select="."/></xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
							<xsl:for-each select="foxml:datastreamVersion">
								<xsl:variable name="counter" select="position() -1"/>
								<!-- zunächst XML umbauen -->
								<xsl:element name="foxml:datastreamVersion" namespace="info:fedora/fedora-system:def/foxml#">
									<xsl:attribute name="CREATED" select="@CREATED"/>
									<xsl:attribute name="ID" select="concat('DC.',$counter)"/>
									<xsl:attribute name="LABEL" select="''"/>
									<xsl:attribute name="MIMETYPE" select="'text/xml'"/>
									<xsl:call-template name="contentDigestTemplate" />
									<xsl:element name="foxml:xmlContent" namespace="info:fedora/fedora-system:def/foxml#">
										<xsl:element name="oai_dc:dc" namespace="http://www.openarchives.org/OAI/2.0/oai_dc/">
										
											<xsl:element name="dc:title" namespace="http://purl.org/dc/elements/1.1/">
												<xsl:value-of select="foxml:xmlContent/rdf:RDF/rdf:Description/context:name"/>
											</xsl:element>
											<xsl:element name="dc:description" namespace="http://purl.org/dc/elements/1.1/">
												<xsl:value-of select="foxml:xmlContent/rdf:RDF/rdf:Description/context:description"/>
											</xsl:element>
											<xsl:element name="dc:identifier" namespace="http://purl.org/dc/elements/1.1/">
												<xsl:value-of select="/foxml:digitalObject/@PID"/>
											</xsl:element>
										</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:when>
					<!-- den Rest einfach 1:1 kopieren -->
				</xsl:choose>
			</xsl:for-each>
			<!-- hier wird das alte XML leicht verändert ausgegeben -->
			<xsl:for-each select="foxml:datastream">
				<xsl:choose>
					<!-- bereits im Ausgangsdokument enthaltene Ergebnis-Tags ignorieren -->
					<xsl:when test="foxml:datastreamVersion/foxml:xmlContent/oai_dc:dc"/>
					<!-- falls RDF, dann umformen sowie den Tag kopieren, aber die Elemente dabei löschen, die schon in der umgeformeten Version stehen -->
					<xsl:when test="foxml:datastreamVersion/foxml:xmlContent/rdf:RDF">
						<xsl:element name="foxml:datastream" namespace="info:fedora/fedora-system:def/foxml#">
							<!-- Attribute übernehmen -->
							<xsl:for-each select="@*">
								<xsl:copy/>
							</xsl:for-each>
							<xsl:for-each select="foxml:datastreamVersion">
								<!--  dann das Tagging teilweise original übernehmen -->
								<xsl:element name="foxml:datastreamVersion" namespace="info:fedora/fedora-system:def/foxml#">
									<!-- Attribute übernehmen -->
									<xsl:for-each select="@*">
										<xsl:copy/>
									</xsl:for-each>
									<xsl:call-template name="contentDigestTemplate" />
									<xsl:element name="foxml:xmlContent" namespace="info:fedora/fedora-system:def/foxml#">
										<xsl:element name="rdf:RDF" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
											<xsl:element name="rdf:Description" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
												<xsl:attribute name="rdf:about" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of select="foxml:xmlContent/rdf:RDF/rdf:Description/@rdf:about"/></xsl:attribute>
												<xsl:element
														name="prop:build"
														namespace="http://escidoc.de/core/01/properties/">
														<xsl:value-of
															select="'297'" />
															</xsl:element>
												<xsl:for-each select="foxml:xmlContent/rdf:RDF/rdf:Description/*">
													<xsl:variable name="name" select="local-name()"/>
													
													<xsl:if test="$name='organizational-unit'">
														<xsl:element name="srel:organizational-unit" namespace="http://escidoc.de/core/01/structural-relations/">
															<xsl:attribute name="rdf:resource" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of select="@rdf:resource"/></xsl:attribute>
														</xsl:element>
													</xsl:if>
													<xsl:if test="$name='public-status'">
														<xsl:element name="prop:public-status" namespace="http://escidoc.de/core/01/properties/">
															<xsl:value-of select="."/>
														</xsl:element>
													</xsl:if>
													<xsl:if test="$name='type'">
														<xsl:element name="prop:type" namespace="http://escidoc.de/core/01/properties/">
															<xsl:value-of select="."/>
														</xsl:element>
													</xsl:if>
													<xsl:if test="$name='created-by'">
														<xsl:element name="srel:created-by" namespace="http://escidoc.de/core/01/structural-relations/">
															<xsl:attribute name="rdf:resource" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of select="@rdf:resource"/></xsl:attribute>
														</xsl:element>
													</xsl:if>
													<xsl:if test="$name='modified-by'">
														<xsl:element name="srel:modified-by" namespace="http://escidoc.de/core/01/structural-relations/">
															<xsl:attribute name="rdf:resource" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of select="@rdf:resource"/></xsl:attribute>
														</xsl:element>
													</xsl:if>
													<xsl:if test="$name='modified-by-title'">
														<xsl:element name="prop:modified-by-title" namespace="http://escidoc.de/core/01/properties/">
															<xsl:value-of select="."/>
														</xsl:element>
													</xsl:if>
													<xsl:if test="$name='created-by-title'">
														<xsl:element name="prop:created-by-title" namespace="http://escidoc.de/core/01/properties/">
															<xsl:value-of select="."/>
														</xsl:element>
													</xsl:if>
													<xsl:if test="$name='objectType'">
														<xsl:element name="rdf:type" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
															<xsl:attribute name="rdf:resource" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">http://escidoc.de/core/01/resources/Context</xsl:attribute>
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
