<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" doctype-system="about:legacy-compat" />

	<xsl:include href="body.xsl" />
	<!-- Identity transform -->
	<!-- Primordial. Permet à la machine de fonctionner. -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:variable name="lang">
		<xsl:value-of select="/root/@lang" />
	</xsl:variable>

	<!-- On démarre la machine -->
	<xsl:template match="/">
		<html lang="{$lang}">
			<head>
				<link rel="preload" href="/assets/fonts/Aleo.woff2" as="font" type="font/woff2" crossorigin=""/>
				<link rel="preload" href="/assets/fonts/Aleo-Italic.woff2" as="font" type="font/woff2" crossorigin=""/>
				<link rel="preload" href="/assets/fonts/PPNeueMontreal-Variable-subset.woff2" as="font" type="font/woff2" crossorigin=""/>
				<link rel="preload" href="/assets/fonts/PPRightGrotesk-CompactDark-subset.woff2" as="font" type="font/woff2" crossorigin=""/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<xsl:choose>
					<xsl:when test="$lang='en'">
						<meta name="description" content="Allocation Québec is a participatory platform designed to engage the public in developing a plan for a subsistence allowance in Quebec. Explore ideas, economic data, and proposals for a more fair and sustainable future." />
						<title>Allocation Québec</title>
					</xsl:when>
					<xsl:otherwise>
						<meta name="description" content="Allocation Québec est une plateforme participative visant à engager le public dans l’élaboration d’un plan pour une allocation de subsistance au Québec. Explorez des idées, des données économiques et des propositions pour un avenir plus solidaire et durable." />
						<title>Allocation Québec</title>
					</xsl:otherwise>
				</xsl:choose>
				<link rel="stylesheet" href="/assets/css/e.css"/>
				<link rel="stylesheet" href="/assets/css/6.components/signature.css"/>
			</head>
			<xsl:call-template name="body" />
		</html>
	</xsl:template>
</xsl:stylesheet>

