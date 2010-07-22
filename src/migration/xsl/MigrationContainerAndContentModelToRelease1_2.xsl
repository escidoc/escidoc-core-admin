<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3"
	xmlns:system="http://escidoc.de/core/01/system/" xmlns:java="de.escidoc.core.admin.business.FoxmlMigrationTool">
	<xsl:import href="ContainerToRelease1_2.xsl" />
	<xsl:import href="ContentModelToRelease1_2.xsl" />
	<xsl:import href="VersionHistoryTemplate.xsl" />
	<xsl:variable name="objectType"
		select="/foxml:digitalObject/foxml:datastream/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description/rdf:type/@rdf:resource" />


	<xsl:output encoding="utf-8" method="xml" />
	<xsl:template match="/">
		<xsl:variable name="buildNr"
			select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion[position()=last()]/foxml:xmlContent/rdf:RDF/rdf:Description/system:build" />

		<xsl:variable name="frameworkRank" select="java:getFrameworkRank($buildNr)" />

		<xsl:for-each select="foxml:digitalObject">
						
			<xsl:variable name="createdDate">
				<xsl:variable name="millis" select="number(substring(/foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#createdDate']/@VALUE, 21, 3))"/>
				<xsl:choose>
					<xsl:when test="$millis = 999 and /foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#createdDate']/@VALUE = /foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/view#lastModifiedDate']/@VALUE">
						<!-- createdDate and lmDate are the same and have 999 millis, so decrement createdDate -->
						<xsl:value-of select="substring(/foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#createdDate']/@VALUE, 1, 20)"/>
						<xsl:value-of select="$millis - 1"/>
						<xsl:text>Z</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#createdDate']/@VALUE"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="lmDate">
				<xsl:choose>
					<xsl:when test="/foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/view#lastModifiedDate']/@VALUE = $createdDate">
						<!-- create new lmDate which is after createdDate -->
						<xsl:value-of select="substring($createdDate, 1, 20)"/>
						<xsl:value-of select="number(substring($createdDate, 21, 3)) + 1"/>
						<xsl:text>Z</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/view#lastModifiedDate']/@VALUE"/> 
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:element name="foxml:digitalObject" namespace="info:fedora/fedora-system:def/foxml#">
				<!-- alle Attribute und Namespaces ans Root-Element anhängen -->
				<xsl:namespace name="fedoraxsi"
					select="'http://www.w3.org/2001/XMLSchema-instance'" />
				<xsl:for-each select="@*">
					<xsl:variable name="name" select="name()" />
					<!--  changed a value of the attribute 'ID' -->
					<xsl:choose>
						<!--  changed a value of the attribute 'CONTROL_GROUP' -->
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

				<foxml:objectProperties>
					<xsl:for-each select="foxml:objectProperties/@*">
						<xsl:copy/>
					</xsl:for-each>
					<xsl:for-each select="foxml:objectProperties/foxml:property">
						<xsl:choose>
							<xsl:when test="@NAME = 'info:fedora/fedora-system:def/model#createdDate'">
								<foxml:property NAME="info:fedora/fedora-system:def/model#createdDate">
									<xsl:attribute name="VALUE"><xsl:value-of select="$createdDate"/></xsl:attribute>
								</foxml:property>
							</xsl:when>
							<xsl:when test="@NAME = 'info:fedora/fedora-system:def/view#lastModifiedDate'">
								<foxml:property NAME="info:fedora/fedora-system:def/view#lastModifiedDate">
									<xsl:attribute name="VALUE"><xsl:value-of select="$lmDate"/></xsl:attribute>
								</foxml:property>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="." copy-namespaces="no" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</foxml:objectProperties>
				<xsl:choose>
					<xsl:when test="$frameworkRank != '1.2'">
						<xsl:choose>
							<xsl:when
								test="$objectType = 'http://escidoc.de/core/01/resources/Container'">
								<xsl:call-template name="containerTemplate" />
							</xsl:when>
							<xsl:when
								test="$objectType = 'http://escidoc.de/core/01/resources/ContentModel'">
								<xsl:call-template name="cmTemplate">
									<xsl:with-param name="createdDate" select="$createdDate"/>
									<xsl:with-param name="lmDate" select="$lmDate"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="foxml:datastream">
									<xsl:choose>
										<!-- bereits im Ausgangsdokument enthaltene Ergebnis-Tags ignorieren -->
										<xsl:when test="@ID='DC'">
											<xsl:call-template name="dcTemplate" />
										</xsl:when>
										<xsl:when test="@ID='version-history'">
											<xsl:element name="foxml:datastream"
												namespace="info:fedora/fedora-system:def/foxml#">
												<!-- Attribute übernehmen -->
												<xsl:for-each select="@*">
													<xsl:copy />
												</xsl:for-each>
												<xsl:for-each select="foxml:datastreamVersion[1]">
													<xsl:element name="foxml:datastreamVersion"
														namespace="info:fedora/fedora-system:def/foxml#">
														<xsl:for-each select="@*">
															<xsl:copy />
														</xsl:for-each>
														<xsl:for-each select="foxml:xmlContent">
															<xsl:element name="foxml:xmlContent"
																namespace="info:fedora/fedora-system:def/foxml#">
																<xsl:call-template name="versionHistoryTemplate" />
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
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="foxml:datastream">
							<xsl:copy-of select="." copy-namespaces="no" />
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>


			</xsl:element>
		</xsl:for-each>

	</xsl:template>

</xsl:stylesheet>
