<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"
	xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3"
	xmlns:java="de.escidoc.core.om.business.CallJavaFromXslt"
	exclude-result-prefixes="fedoraxsi xsl java">

	<xsl:output encoding="utf-8" method="xml" />
	<xsl:variable name="creationDateRelsExt"
		select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion[position()=last()]/@CREATED" />
	<xsl:variable name="creationDateVersionHistory"
		select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion/@CREATED" />
	<xsl:variable name="objectId" select="/foxml:digitalObject/@PID" />
	<xsl:variable name="fileName" select="java:getFileName($objectId)" />
	<xsl:variable name="pathEscidocRelsExt" select="java:getNewPath($creationDateRelsExt)" />
	<xsl:variable name="pathVersionHistory"
		select="java:getNewPath($creationDateVersionHistory)" />


	<!--
		<xsl:template match="/"> <xsl:call-template name="containerTemplate"
		/> </xsl:template>
	-->
	<xsl:template name="containerTemplate">

		<!-- hier wird das neue XML erzeugt -->
		<xsl:for-each select="foxml:datastream">
			<xsl:choose>
				<!-- bereits im Ausgangsdokument enthaltene Ergebnis-Tags ignorieren -->
				<xsl:when test="@ID='RELS-EXT'">
					<xsl:variable name="countVersions"
						select="count(foxml:datastreamVersion) div 2 -1" />
					<xsl:element name="foxml:datastream"
						namespace="info:fedora/fedora-system:def/foxml#">
						<!-- Attribute übernehmen -->
						<xsl:for-each select="@*">
							<xsl:variable name="name" select="local-name()" />
							<!--  changed a value of the attribute 'VERSIONABLE' to 'false' -->
							<xsl:choose>
								<xsl:when test="$name = 'VERSIONABLE'">
									<xsl:attribute name="VERSIONABLE">false</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="{$name}"><xsl:value-of
										select="." />
											</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="foxml:datastreamVersion[position()=last()]">

							<xsl:element name="foxml:datastreamVersion"
								namespace="info:fedora/fedora-system:def/foxml#">
								<!-- Attribute übernehmen -->
								<xsl:for-each select="@*">
									<xsl:variable name="name" select="local-name()" />
									<!--  changed a value of the attribute 'ID' -->
									<xsl:choose>
										<xsl:when test="$name = 'ID'">
											<xsl:attribute name="ID"
												select="concat('RELS-EXT.', $countVersions)" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="{$name}"><xsl:value-of
												select="." />
											</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
								<!-- diesen Tag original übernehmen -->
								<xsl:element name="foxml:xmlContent"
									namespace="info:fedora/fedora-system:def/foxml#">
									<xsl:element name="rdf:RDF"
										namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
										<xsl:element name="rdf:Description"
											namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
											<xsl:attribute name="rdf:about"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of
												select="foxml:xmlContent/rdf:RDF/rdf:Description/@rdf:about" />
													</xsl:attribute>
											<xsl:for-each select="foxml:xmlContent/rdf:RDF/rdf:Description/*">
												<xsl:variable name="name" select="name()" />
												<xsl:choose>
													<xsl:when test="$name = 'system:build'">
														<xsl:element name="system:build"
															namespace="http://escidoc.de/core/01/system/">
															<xsl:value-of select="'1.2beta1'" />
														</xsl:element>
													</xsl:when>
													<xsl:otherwise>
														<xsl:copy-of select="." copy-namespaces="no" />
													</xsl:otherwise>
												</xsl:choose>
											</xsl:for-each>
										</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
					<xsl:element name="foxml:datastream"
						namespace="info:fedora/fedora-system:def/foxml#">
						<!-- Attribute übernehmen -->
						<xsl:for-each select="@*">
							<xsl:variable name="name" select="local-name()" />
							<!--  changed a value of the attribute 'ID' -->
							<xsl:choose>
								<xsl:when test="$name = 'ID'">
									<xsl:attribute name="ID">ESCIDOC_RELS_EXT</xsl:attribute>
								</xsl:when>
								<!--  changed a value of the attribute 'CONTROL_GROUP' -->
								<xsl:when test="$name = 'CONTROL_GROUP'">
									<xsl:attribute name="CONTROL_GROUP">M</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="{$name}"><xsl:value-of
										select="." />
											</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="foxml:datastreamVersion[(position() mod 2) != 0]">
							<xsl:variable name="counter" select="position() -1" />
							<xsl:element name="foxml:datastreamVersion"
								namespace="info:fedora/fedora-system:def/foxml#">
								<!-- Attribute übernehmen -->
								<xsl:for-each select="@*">
									<xsl:variable name="name" select="local-name()" />
									<!--  changed a value of the attribute 'ID' to 'ESCIDOC_RELS_EXT.X' -->
									<xsl:choose>
										<xsl:when test="$name = 'ID'">
											<xsl:attribute name="ID"
												select="concat('ESCIDOC_RELS_EXT.', $counter)" />
										</xsl:when>
										<xsl:when test="$name = 'SIZE'" />
										<xsl:otherwise>
											<xsl:attribute name="{$name}"><xsl:value-of
												select="." />
											</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
								<xsl:element name="foxml:contentLocation"
									namespace="info:fedora/fedora-system:def/foxml#">
									<xsl:attribute name="TYPE" select="'INTERNAL_ID'" />
									<xsl:attribute name="REF"
										select="concat($fileName,'+ESCIDOC_RELS_EXT+ESCIDOC_RELS_EXT.',$counter)" />
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>

					<xsl:for-each select="foxml:datastreamVersion[(position() mod 2) != 0]">
						<xsl:variable name="counter" select="position() -1" />
						<xsl:result-document
							href="file:///{$pathEscidocRelsExt}/{$fileName}+ESCIDOC_RELS_EXT+ESCIDOC_RELS_EXT.{$counter}">

							<xsl:for-each select="foxml:xmlContent/rdf:RDF">

								<xsl:element name="rdf:RDF"
									namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
									<xsl:element name="rdf:Description"
										namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
										<xsl:attribute name="rdf:about"
											namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of select="rdf:Description/@rdf:about" />
													</xsl:attribute>
										<xsl:for-each select="rdf:Description/*">
											<xsl:variable name="name" select="name()" />
											<xsl:choose>
												<xsl:when test="$name = 'system:build'">
													<xsl:element name="system:build"
														namespace="http://escidoc.de/core/01/system/">
														<xsl:value-of select="'1.2beta1'" />
													</xsl:element>
												</xsl:when>
												<xsl:otherwise>
													<xsl:copy-of select="." copy-namespaces="no" />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
									</xsl:element>
								</xsl:element>
							</xsl:for-each>
						</xsl:result-document>
					</xsl:for-each>
				</xsl:when>

				<xsl:when test="@ID='version-history'">
					<xsl:variable name="versionNumber" select="foxml:datastreamVersion/@ID" />
					<xsl:element name="foxml:datastream"
						namespace="info:fedora/fedora-system:def/foxml#">
						<!-- Attribute übernehmen -->
						<xsl:for-each select="@*">
							<xsl:variable name="name" select="local-name()" />
							<!--  changed a value of the attribute 'ID' -->
							<xsl:choose>
								<!--  changed a value of the attribute 'CONTROL_GROUP' -->
								<xsl:when test="$name = 'CONTROL_GROUP'">
									<xsl:attribute name="CONTROL_GROUP">M</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="{$name}"><xsl:value-of
										select="." />
											</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<!--  <xsl:for-each select="foxml:datastreamVersion[position()=1]"> -->
						<xsl:for-each select="foxml:datastreamVersion">
							<xsl:element name="foxml:datastreamVersion"
								namespace="info:fedora/fedora-system:def/foxml#">
								<!-- Attribute übernehmen -->
								<xsl:for-each select="@*">
									<xsl:variable name="name" select="local-name()" />
									<!--  changed a value of the attribute 'ID' to 'ESCIDOC_RELS_EXT.X' -->
									<xsl:choose>
										<xsl:when test="$name = 'SIZE'" />
										<xsl:otherwise>
											<xsl:attribute name="{$name}"><xsl:value-of
												select="." />
											</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
								<xsl:element name="foxml:contentLocation"
									namespace="info:fedora/fedora-system:def/foxml#">
									<xsl:attribute name="TYPE" select="'INTERNAL_ID'" />
									<xsl:attribute name="REF"
										select="concat($fileName,'+version-history+',$versionNumber)" />
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>

					<xsl:result-document
						href="file:///{$pathVersionHistory}/{$fileName}+version-history+{$versionNumber}">
						<xsl:element name="escidocVersions:version-history"
							namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
							<!-- Attribute übernehmen -->
							<xsl:for-each
								select="foxml:datastreamVersion[1]//escidocVersions:version-history/@*">
								<xsl:copy />
							</xsl:for-each>
							<!--
								<xsl:for-each
								select="foxml:datastreamVersion[1]//escidocVersions:version-history/escidocVersions:version[1]">
							-->
							<xsl:for-each
								select="foxml:datastreamVersion[1]//escidocVersions:version-history/escidocVersions:version">
								<xsl:copy-of select="." copy-namespaces="no" />
							</xsl:for-each>
						</xsl:element>
					</xsl:result-document>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="." copy-namespaces="no" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

