<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
	       xmlns:xlink="http://www.w3.org/1999/xlink"
	       xmlns:t="http://www.tei-c.org/ns/1.0" 
	       version="2.0">

  <xsl:variable name="styles">
    <xsl:copy-of select="//a:Styles"/>
  </xsl:variable>
  
  <xsl:template match="/">
    <table>
      <xsl:for-each select="//a:String">
        <tr>
          <td><xsl:value-of select="@ID"/></td>
          <xsl:variable name="ref" select="@STYLEREFS/string()"/>
          <td><xsl:value-of select="$ref"/></td>
          <td><xsl:value-of select="$styles//a:TextStyle[@ID=$ref]/@FONTSIZE"/></td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  
</xsl:transform>

               
