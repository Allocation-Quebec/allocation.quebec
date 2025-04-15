<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl">

	<xsl:key name="footnotes-by-text" match="section[contains(@class, 'footnotes')]//li" use="normalize-space(.)"/>

	<xsl:variable name="dupes">
		<xsl:for-each select="//section[contains(@class, 'footnotes')]//li">
			<xsl:variable name="text" select="normalize-space(.)"/>
			<xsl:variable name="first" select="key('footnotes-by-text', $text)[1]"/>
			<xsl:if test="generate-id() != generate-id($first)">
				<map from="{@id}" to="{$first/@id}"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>

	<!-- Suppress the after-footnotes block for now -->

	<xsl:template match="*[@data-after='footnotes']"/>

	<xsl:template match="*[@data-after='footnotes']" mode="after-footnotes">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="section[@id='footnotes']">
		<section>
			<xsl:attribute name="class">as-fullbleed dark</xsl:attribute>
			<xsl:attribute name="id">footnotes</xsl:attribute>

			<link rel="stylesheet" href="/assets/css/4.regions/footnotes.css"/>
			<xsl:choose>
				<xsl:when test="root[@lang='fr']">
					<h2 class="h3">Références</h2>
				</xsl:when>
				<xsl:otherwise>
					<h2 class="h3">References</h2>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates/>
		</section>
		<xsl:apply-templates select="//*[@data-after='footnotes']" mode="after-footnotes" />
	</xsl:template>

	<xsl:template name="copy-p-without-backlinks">
		<xsl:param name="p"/>
		<xsl:for-each select="$p/node()">
			<xsl:choose>
				<xsl:when test="self::a[starts-with(@href, '#fnref')] or self::a[starts-with(@href, 'http')]">
					<!-- skip backlinks -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="." />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="a[starts-with(@href, '#fn')]">
		<xsl:variable name="target" select="substring-after(@href, '#')"/>
		<xsl:variable name="replacement" select="exsl:node-set($dupes)/map[@from = $target]/@to"/>

		<a>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:choose>
					<xsl:when test="$replacement">
						<xsl:value-of select="$replacement"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$target"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="@*[name() != 'href'] | node()"/>
		</a>
	</xsl:template>

	<xsl:template match="section[@id='footnotes']/hr" />

	<xsl:template match="section[contains(@class, 'footnotes')]//li[generate-id() != generate-id(key('footnotes-by-text', normalize-space(.))[1])]"/>

	<xsl:template match="section[contains(@class, 'footnotes')]//li[generate-id() = generate-id(key('footnotes-by-text', normalize-space(.))[1])]">
		<xsl:variable name="text" select="normalize-space(.)"/>
		<xsl:variable name="all-li" select="key('footnotes-by-text', $text)"/>
		<xsl:variable name="this-id" select="@id"/>
		<xsl:variable name="p" select="p[1]"/>

		<li id="{$this-id}">
			<span>
				<xsl:call-template name="copy-p-without-backlinks">
					<xsl:with-param name="p" select="$p"/>
				</xsl:call-template>
			</span>

			<!-- Copy the external URL link separately -->
			<xsl:for-each select="$p/a[not(starts-with(@href, '#fnref'))]">
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:for-each>

			<!-- Append backlinks inside their own <span> -->
				<span>
					<xsl:text>↩︎ </xsl:text>
					<xsl:for-each select="$all-li//a[starts-with(@href, '#fnref')]">
						<xsl:variable name="href" select="@href"/>
						<xsl:variable name="num" select="substring-after($href, '#fnref')"/>
						<a href="{$href}">
							<xsl:value-of select="$num"/>
						</a>
						<xsl:text> </xsl:text>
					</xsl:for-each>
				</span>
			</li>
		</xsl:template>
	</xsl:stylesheet>

