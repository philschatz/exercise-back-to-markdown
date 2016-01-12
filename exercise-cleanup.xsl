<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:c="http://cnx.rice.edu/cnxml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:qml="http://cnx.rice.edu/qml/1.0"
  xmlns:mod="http://cnx.rice.edu/#moduleIds"
  xmlns:bib="http://bibtexml.sf.net/"
  xmlns:x="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="c"
  >

<xsl:output omit-xml-declaration="yes" encoding="ASCII"/>
<xsl:strip-space elements="body div"/>

<!-- kramdown sometimes adds a ';' at the end of table heading style= attributes to make them left/center/right justify -->
<xsl:template match="@style">
  <xsl:attribute name="style">
    <xsl:call-template name="string-replace">
      <xsl:with-param name="text" select="."/>
      <xsl:with-param name="pattern">;</xsl:with-param>
      <xsl:with-param name="replace-with"></xsl:with-param>
    </xsl:call-template>
  </xsl:attribute>
</xsl:template>


<xsl:template match="p/text()">
  <xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<!-- divs with latex in them are getting extra whitespace around them -->
<xsl:template match="div/text()">
  <xsl:value-of select="normalize-space(.)"/>
</xsl:template>








<!-- ====================== Uninteresting stuff goes down here =========== -->

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>


<!-- Utility for replacing text in a string -->
<xsl:template name="string-replace">
   <xsl:param name="text" />
   <xsl:param name="pattern" />
   <xsl:param name="replace-with" />
   <xsl:choose>
      <xsl:when test="contains($text, $pattern)">
         <xsl:value-of select="substring-before($text, $pattern)" />
         <xsl:value-of select="$replace-with" />
         <xsl:call-template name="string-replace">
            <xsl:with-param name="text" select="substring-after($text, $pattern)" />
            <xsl:with-param name="pattern" select="$pattern" />
            <xsl:with-param name="replace-with" select="$replace-with" />
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$text" />
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>


</xsl:stylesheet>
