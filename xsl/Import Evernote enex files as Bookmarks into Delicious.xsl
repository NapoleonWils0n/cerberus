<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/> 
    <xsl:template match="/">
        <!--This is an automatically generated file.
            It will be read and overwritten.
            Do Not Edit! -->
        <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8" />
        <Title>Bookmarks</Title>
        <H1>Bookmarks</H1>
        <DL>
            <xsl:apply-templates />    
        </DL>    
    </xsl:template>
    
    <xsl:template match="note">
        
        <DT>
            <A>
                <xsl:attribute name="HREF"><xsl:value-of select="note-attributes/source-url"/></xsl:attribute>
                <xsl:attribute name="ADD_DATE"><xsl:value-of select="updated" /></xsl:attribute>
                <xsl:attribute name="PRIVATE"><xsl:value-of select="1"/></xsl:attribute>
                               
                <xsl:variable name="tags"><xsl:for-each select="tag"><xsl:value-of select="."/>,</xsl:for-each></xsl:variable>
                
                <xsl:attribute name="TAGS"><xsl:value-of select="$tags"/></xsl:attribute>
                <xsl:value-of select="title"/>
            </A>
        </DT>

        <DD>
            <xsl:value-of select="title"/>
        </DD>
    </xsl:template>
    
</xsl:stylesheet>
