<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
	       xmlns:h="http://www.w3.org/1999/xhtml"
	       xmlns:xlink="http://www.w3.org/1999/xlink"
	       xmlns="http://www.tei-c.org/ns/1.0"
	       xmlns:t="http://www.tei-c.org/ns/1.0"
	       version="2.0">

  <xsl:import href="do_alto_pages.xsl"/>

  <xsl:param name="volume">1_001</xsl:param>
  <xsl:param name="pages" select="document(concat($volume,'.xml'))"/>

  

  <xsl:template match="/">
    <TEI xmlns="http://www.tei-c.org/ns/1.0">
      <teiHeader>
	<fileDesc>
	  <titleStmt>
	    <title>
	    </title>
	  </titleStmt>
	  <publicationStmt>
	    <publisher>
	    </publisher>
	  </publicationStmt>
	  <sourceDesc>
	    <xsl:copy-of select="//t:listBibl[contains(@xml:id,$volume)]"/>
	  </sourceDesc>
	</fileDesc>
      </teiHeader>
      <text>
	<body>
	  <xsl:for-each select="//t:listBibl[contains(@xml:id,$volume)]">
	     <xsl:for-each select="t:bibl">
	       <xsl:element name="div">
		 <xsl:attribute name="xml:id"><xsl:value-of select="concat('workid',substring-after(@xml:id,'bibl'))"/></xsl:attribute>
		 <xsl:attribute name="decls"><xsl:value-of select="@xml:id"/></xsl:attribute>
		 <xsl:variable name="work" select="substring-after(@xml:id,'bibl')"/>
		 <xsl:for-each select="$pages//h:a[contains(@href,$work)]">
		   <xsl:variable name="alto" select="document(@href)"/>
		   <xsl:apply-templates select="$alto/a:alto"/>
		 </xsl:for-each>
	       </xsl:element>
	     </xsl:for-each>
	  </xsl:for-each>
	</body>
      </text>
    </TEI>
  </xsl:template>


</xsl:transform>