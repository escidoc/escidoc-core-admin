<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3"
	xmlns:premis="http://www.loc.gov/standards/premis/v1"
	exclude-result-prefixes="foxml xsl">
	<xsl:import href="contentDigest.xsl" />
	<xsl:output encoding="utf-8" method="xml" />

	<xsl:template name="VersionHistoryTemplate">
		<xsl:copy copy-namespaces="no">
			<xsl:for-each select="@*">
				<xsl:variable name="name" select="local-name()" />
				<!-- das Attribute "TYPE" muss auf dem Wert "DISABLED" gesetzt werden -->
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
			<xsl:for-each
				select="foxml:datastreamVersion[position()= last()]">

				<xsl:copy copy-namespaces="no">
					<xsl:for-each select="@*">
						<xsl:variable name="name" select="local-name()" />
						<!-- das Attribute "TYPE" muss auf dem Wert "DISABLED" gesetzt werden -->
						<xsl:choose>
							<xsl:when test="$name = 'ID'">
								<xsl:attribute name="ID">version-history.1</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="{$name}"><xsl:value-of
										select="." />
											</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:call-template name="contentDigestTemplate" />
					<xsl:element name="foxml:xmlContent"
						namespace="info:fedora/fedora-system:def/foxml#">
						<xsl:for-each
							select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion[position()= last()]/foxml:xmlContent/escidocVersions:version-history">

							
							<xsl:copy copy-namespaces="no">

								<xsl:for-each select="@*">
									<xsl:copy />
								</xsl:for-each>

								<xsl:variable name="versionComment"
									select="escidocVersions:version[position()=1]/escidocVersions:events/premis:event[position()=2]/premis:eventDetail" />
								<xsl:variable name="versionStatus"
									select="escidocVersions:version[position()=1]/escidocVersions:events/premis:event[position()=2]/premis:eventType" />
									
									<xsl:variable name="count"
									select="count(escidocVersions:version[position()=1]/escidocVersions:events/premis:event)" />		
									
								<xsl:choose>
									<xsl:when
										test="escidocVersions:version[position()=1]/escidocVersions:version-status='withdrawn'">
										<xsl:for-each
											select="escidocVersions:version[position()=1]">
											<xsl:copy
												copy-namespaces="no">
												<xsl:for-each
													select="@*">
													<xsl:copy />
												</xsl:for-each>
												<xsl:for-each
													select="*">
													<xsl:choose>
														<xsl:when
															test="local-name()='version-status'">
															<xsl:choose>
															<xsl:when test="$count > 2">
															<xsl:element
																name="escidocVersions:version-status"
																namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
																<xsl:value-of
																	select="$versionStatus" />
																	</xsl:element>
															</xsl:when>
															<xsl:otherwise>
															<xsl:element
																name="escidocVersions:version-status"
																namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
																<xsl:value-of
																	select="'pending'" />
															</xsl:element>
															</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:when
															test="local-name()='comment'">
															<xsl:element
																name="escidocVersions:comment"
																namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
																<xsl:value-of
																	select="$versionComment" />
															</xsl:element>
														</xsl:when>
														<xsl:otherwise>
															<xsl:copy-of
																select="." copy-namespaces="no" />
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</xsl:copy>
										</xsl:for-each>
										<xsl:for-each
											select="escidocVersions:version[position()!=1]">
											<xsl:copy-of select="."
												copy-namespaces="no" />
										</xsl:for-each>

									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each
											select="escidocVersions:version">
											<xsl:copy-of select="."
												copy-namespaces="no" />
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:copy>
						</xsl:for-each>
					</xsl:element>
				</xsl:copy>
			</xsl:for-each>
		</xsl:copy>

	</xsl:template>
</xsl:stylesheet>
