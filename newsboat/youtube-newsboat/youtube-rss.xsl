<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:media="http://search.yahoo.com/mrss/"
                xmlns:content="http://purl.org/rss/1.0/modules/content/"
                xmlns="http://purl.org/rss/1.0/">

<xsl:output method="xml" indent="yes" cdata-section-elements="description" />

<xsl:template match="/">
	<xsl:apply-templates select="atom:feed" />
</xsl:template>

<xsl:template match="atom:feed">
	<rdf:RDF>
		<channel>
			<xsl:attribute name="rdf:about"><xsl:value-of select="atom:link[@rel='service.feed']/@href" /></xsl:attribute>
			<title><xsl:value-of select="normalize-space(atom:title)" /></title>
			<link><xsl:value-of select="atom:link/@href" /></link>
			<description><xsl:value-of select="normalize-space(atom:info)" /></description>
			<items>
				<rdf:Seq>
					<xsl:apply-templates select="atom:entry" mode="rdfitem"/>
				</rdf:Seq>
			</items>
		</channel>
		<xsl:apply-templates select="atom:entry" mode="rssitem" />
	</rdf:RDF>
</xsl:template>

<xsl:template match="atom:entry" mode="rdfitem">
	<rdf:li>
		<xsl:attribute name="rdf:resource">
			<xsl:value-of select="normalize-space(atom:id)" />
		</xsl:attribute>
	</rdf:li>
</xsl:template>

<xsl:template match="atom:entry" mode="rssitem">
	<item>
		<xsl:attribute name="rdf:about">
			<xsl:value-of select="normalize-space(atom:id)" />
		</xsl:attribute>
		<title><xsl:value-of select="normalize-space(atom:title)" /></title>
		<link><xsl:value-of select="atom:link/@href" /></link>
		<xsl:if test="atom:issued">
			<dc:date><xsl:value-of select="normalize-space(atom:issued)" /></dc:date>
		</xsl:if>
                <!-- change cd creator to match author/name -->
		<xsl:if test="atom:author">
			<dc:creator><xsl:value-of select="normalize-space(atom:author/child::*)" /></dc:creator>
		</xsl:if>
        <xsl:choose>
            <xsl:when test="atom:content">
    			<description><xsl:value-of select="normalize-space(atom:content)" /></description>
    		</xsl:when>
    		<xsl:when test="atom:summary">
    			<description><xsl:value-of select="normalize-space(atom:summary)" /></description>
    		</xsl:when>
               <!-- match media:group -->
            <xsl:when test="media:group">
              <content:encoded>
               <!-- cdata -->
              <xsl:text disable-output-escaping="yes"><![CDATA[<![CDATA[]]></xsl:text>

               <!-- youtube thumbnail -->
             <div>
               <img alt="image" width="640" height="480">
                    <xsl:attribute name="src">
                        <xsl:value-of select='media:group/media:thumbnail/@url'/>
                   </xsl:attribute>
               </img>
             </div>
             <br/>

               <!-- youtube link -->
             <h1>
               <a>
                <xsl:attribute name="href">
                   <!-- <xsl:value-of select="media:group/media:content/@url"/> -->
                    <xsl:value-of select="atom:link/@href"/>
                </xsl:attribute>
                <xsl:value-of select="media:group/media:title"/>
               </a>
             </h1>

               <!-- youtube description -->
              <description>
               <p>
                <xsl:value-of select="media:group/media:description" />
               </p>
              </description>

               <!-- youtube views, likes -->
             <ul>
             <li>
             <span>
               <xsl:text>Views: </xsl:text>
               <xsl:value-of select="media:group/media:community/media:statistics/@views" />
             </span>
             </li>
             <li>
             <span>
               <xsl:text>Likes: </xsl:text>
               <xsl:value-of select="media:group/media:community/media:starRating/@count" />
             </span>
             </li>
             </ul>
               <!-- cdata closing tag -->
               <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
              </content:encoded>
            </xsl:when>
        </xsl:choose>
	</item>
</xsl:template>
</xsl:stylesheet>
