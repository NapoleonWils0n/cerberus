<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:kml="http://www.opengis.net/kml/2.2"
                xmlns:gx="http://www.google.com/kml/ext/2.2"
                exclude-result-prefixes="xsl fo kml gx">

<xsl:output method="html" indent="yes" />

<xsl:template match="/">
<html>
    <head>
        <title/>
    </head>
    <body>
        <h1>Locations</h1>
            <xsl:for-each select="kml:kml/kml:Document/kml:Placemark">
             <!-- name -->
             <h2><xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:name)"/></h2>

             <!-- description -->
             <p><xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[1])"/></p>


             <!-- image -->
             <img alt="image" width="640" height="480">
             <xsl:attribute name="src">
                    <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[6])"/>
             </xsl:attribute>
             </img>


             <!-- category -->
             <ul>
               <li>
               <xsl:text>Category: </xsl:text>
               <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[2])"/>
               </li>

             <!-- site -->
             <li>
               <xsl:text>Site: </xsl:text>
               <a>
                 <xsl:attribute name="href">
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[3])"/>
                 </xsl:attribute>
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[3])"/>
               </a>
             </li>

             <!-- wikipedia -->
             <li>
               <xsl:text>Wikipedia: </xsl:text>
               <a>
                 <xsl:attribute name="href">
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[4])"/>
                 </xsl:attribute>
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[4])"/>
               </a>
             </li>

             <!-- More info -->
             <li>
               <xsl:text>More info: </xsl:text>
               <a>
                 <xsl:attribute name="href">
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[5])"/>
                 </xsl:attribute>
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/*[5])"/>
               </a>
             </li>

             <!-- coordinates -->
             <li>
               <xsl:text>Co ordinates: </xsl:text>
               <xsl:value-of select="normalize-space(kml:Point/kml:coordinates)"/>
             </li>
             </ul>
            </xsl:for-each>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>
