<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/"
  extension-element-prefixes="saxon">

<xsl:output method="text"/>

<xsl:template match="/">
  <xsl:variable name="prepped">
    <xsl:apply-templates select="*"/>
  </xsl:variable>
  <xsl:apply-templates select="$prepped/documents/*" mode="output"/>
</xsl:template>

<xsl:template match="document" mode="output">
  <xsl:result-document href="file:///{@href}" method="{@method}">
    <xsl:if test="@dtd">
      <xsl:value-of select="@dtd" disable-output-escaping="yes"/>
    </xsl:if>
    <xsl:copy-of select="node()"/>
  </xsl:result-document>
</xsl:template>

<xsl:template match="dir" mode="output">
  <xsl:if test="ends-with(@name,'out')">
    <!-- awfull turn-around to create log directories, that are empty, but must be created for tests -->
    <xsl:result-document href="file:///{@name}/fake.out" method="text">.</xsl:result-document>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>

