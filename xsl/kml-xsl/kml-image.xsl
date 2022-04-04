<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
    <xsl:template match="/">
        <html>
            <head>
                <title/>
            </head>
            <body>
                <h1>Places</h1>
                <table border="1">
                    <tr bgcolor="#cccccc">
                        <th style="text-align:center">Name</th>
                        <th style="text-align:center">Image</th>
                        <th style="text-align:center">Description</th>
                        <th style="text-align:center">Coordinates</th>
                    </tr>
                    <xsl:for-each select="kml:kml/kml:Document/kml:Placemark">
                        <tr>
                            <td>
                                <xsl:value-of disable-output-escaping="yes" select="kml:name"/>
                            </td>
                            <td>
                                <xsl:value-of disable-output-escaping="yes" select="kml:ExtendedData/*[6]"/>
                            </td>
                            <td>
                                <xsl:value-of disable-output-escaping="yes" select="kml:description"/>
                            </td>
                            <td>
                                <xsl:value-of select="kml:Point/kml:coordinates"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
