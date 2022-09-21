<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
               xmlns:b="http://www.loc.gov/standards/alto/ns-v2#"
               xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
               xmlns:xlink="http://www.w3.org/1999/xlink"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       exclude-result-prefixes="xlink  a"
	       version="2.0">

  <xsl:output
      method="xml"
      encoding="UTF-8"/>

  <xsl:template match="/b:alto">
    <a:alto  xmlns="http://www.loc.gov/standards/alto/ns-v3#"
             xmlns:xs="http://www.w3.org/2001/XMLSchema-instance"
             xmlns:xlink="http://www.w3.org/1999/xlink"
             xs:schemaLocation="http://www.loc.gov/standards/alto/ns-v3# https://www.loc.gov/standards/alto/v3/alto-3-1.xsd">
      <xsl:apply-templates select="node()"/>
    </a:alto>
  </xsl:template>

  <xsl:template match="b:*">
    <xsl:variable name="element"><xsl:value-of select="concat('a:',local-name(.))"/></xsl:variable>
    <xsl:element name="{$element}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
 </xsl:template>

 <xsl:template match="@*">
   <xsl:variable name="attribute" select="name(.)"/>
   <xsl:attribute name="{$attribute}">
     <xsl:value-of select="."/>
   </xsl:attribute>
 </xsl:template>

</xsl:transform>
