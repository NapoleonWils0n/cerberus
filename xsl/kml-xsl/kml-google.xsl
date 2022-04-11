<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:kml="http://www.opengis.net/kml/2.2"
                xmlns:gx="http://www.google.com/kml/ext/2.2"
                exclude-result-prefixes="xsl fo kml gx">

<xsl:output method="html" indent="yes" />

<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
<html>
    <head lang="en">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <style>
        body {
        	margin: 0 8px;
        	padding: 0;
        	background: #ffffff;
        	font: 16px/1.5 "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif;
        	color: #333333;
        	}
         p {width: 50%;}
         img {border: solid 1px #cccccc;}
        </style>
        <title>
        <xsl:value-of disable-output-escaping="yes" select="kml:kml/kml:Document/kml:name"/>
        </title>
    </head>
    <body>
        <h1>Locations</h1>
            <xsl:for-each select="kml:kml/kml:Document/kml:Folder/kml:Placemark">

             <!-- name -->
             <h2><xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:name)"/></h2>

             <!-- description -->
             <p><xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'description')])"/></p>


             <!-- image -->
             <img alt="image" width="640" height="480">
             <xsl:attribute name="src">
                    <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'Image URL')])"/>
             </xsl:attribute>
             </img>


             <!-- category -->
             <ul>
               <li>
               <xsl:text>Category: </xsl:text>
               <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'Category')])"/>
               </li>

             <!-- site -->
             <li>
               <xsl:text>Site: </xsl:text>
               <a>
                 <xsl:attribute name="href">
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'Site')])"/>
                 </xsl:attribute>
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'Site')])"/>
               </a>
             </li>


             <!-- wikipedia -->
             <li>
               <xsl:text>Wikipedia: </xsl:text>
               <a>
                 <xsl:attribute name="href">
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'Wikipedia')])"/>
                 </xsl:attribute>
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'Wikipedia')])"/>
               </a>
             </li>


             <!-- More info -->
             <li>
               <xsl:text>More info: </xsl:text>
               <a>
                 <xsl:attribute name="href">
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'More info')])"/>
                 </xsl:attribute>
                 <xsl:value-of disable-output-escaping="yes" select="normalize-space(kml:ExtendedData/kml:Data[(@name = 'More info')])"/>
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
