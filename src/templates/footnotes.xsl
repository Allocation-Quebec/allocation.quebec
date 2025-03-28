<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:key name="footnotes-by-text" match="section[contains(@class, 'footnotes')]//li" use="normalize-space(.)"/>

  <xsl:template match="section[@id='footnotes']">
    <footer class="footnotes">
		 <xsl:apply-templates select="@*"/>
		 <xsl:choose>
			 <xsl:when test="root[@lang='fr']">
				 <h2 class="h3">Références</h2>
			 </xsl:when>
			 <xsl:otherwise>
				 <h2 class="h3">References</h2>
			 </xsl:otherwise>
		 </xsl:choose>
      <xsl:apply-templates/>
    </footer>
  </xsl:template>

  <xsl:template match="section[@id='footnotes']/hr" />

  <xsl:template match="section[contains(@class, 'footnotes')]//li[generate-id() != generate-id(key('footnotes-by-text', normalize-space(.))[1])]"/>

  <!-- Remove duplicate footnotes and show all backlinks -->
  <xsl:template match="section[contains(@class, 'footnotes')]//li[generate-id() = generate-id(key('footnotes-by-text', normalize-space(.))[1])]">
	  <xsl:variable name="this-text" select="normalize-space(.)"/>
	  <xsl:variable name="all-li" select="key('footnotes-by-text', $this-text)"/>
	  <xsl:variable name="this-id" select="@id"/>

	  <li id="{$this-id}">
		  <p>
        <!-- Copy everything inside the first <p> except the original backlinks -->
        <xsl:for-each select="p[1]/node()">
          <xsl:choose>
            <xsl:when test="self::a[starts-with(@href, '#fnref')]">
              <!-- skip original backlink -->
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="." />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>

        <!-- Append all backlinks at the end -->
        <xsl:text> </xsl:text>
        <xsl:for-each select="$all-li//a[starts-with(@href, '#fnref')]">
          <xsl:variable name="href" select="@href"/>
          <xsl:variable name="num" select="substring-after($href, '#fnref')"/>
          <a href="{$href}">↩︎ <xsl:value-of select="$num"/></a>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </p>
	  </li>
  </xsl:template>
</xsl:stylesheet>

