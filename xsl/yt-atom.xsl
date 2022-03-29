<?xml version="1.0" encoding="UTF-8"?>
<!-- youtube rss with images -->

<!-- stylesheets -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.w3.org/2005/Atom"
                xmlns:media="http://search.yahoo.com/mrss/">

<xsl:output method="xml" indent="yes" cdata-section-elements="media:description" encoding="UTF-8" />

<!-- copy all nodes and attributes -->
<xsl:template match="@* | node()">
  <xsl:copy>
    <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
</xsl:template>


<!-- description template -->
<xsl:template match="d:entry/media:group">
<media:description>

<!--
      <xsl:copy-of select="@*"/>
      <xsl:copy-of select="node()"/>
-->

<!-- image -->
<content type="html">
<div>
        <img alt="image" width="640" height="480">
             <xsl:attribute name="src">
                 <xsl:value-of select='media:thumbnail/@url'/>
            </xsl:attribute>
        </img>
</div>
</content>

<!-- youtube video link -->
<h1>
  <a>
   <xsl:attribute name="href">
       <xsl:value-of select="media:content/@url"/>
   </xsl:attribute>
   <xsl:value-of select="media:title"/>
  </a>
</h1>

<!-- description -->
<p>
  <xsl:value-of select="media:description/text()" disable-output-escaping="yes" />
</p>


<!-- likes, views -->
<ul>
<li>
<span>
  <xsl:text>Likes: </xsl:text>
  <xsl:value-of select="media:community/media:starRating/@count" />
</span>
</li>
<li>
<span>
  <xsl:text>Views: </xsl:text>
  <xsl:value-of select="media:community/media:statistics/@views" />
</span>
</li>
</ul>

</media:description>
</xsl:template>
</xsl:stylesheet>
