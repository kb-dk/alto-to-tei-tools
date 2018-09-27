<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
	       xmlns:h="http://www.w3.org/1999/xhtml"
	       xmlns:xlink="http://www.w3.org/1999/xlink"
	       xmlns="http://www.tei-c.org/ns/1.0"
	       xmlns:t="http://www.tei-c.org/ns/1.0"
	       version="2.0">

  <xsl:import href="do_alto_pages.xsl"/>

  <xsl:param name="alto_files"  select="alto_file_lists/1_001.xml"/>
  <xsl:param name="root" select="'/home/slu/projects/trykkefrihedsskrifter/'"/>
  <xsl:param name="pages"  select="document($alto_files)"/>
  <xsl:param name="volume" select="substring-before(substring-after($alto_files,'file_lists/'),'.xml')"/>

  <xsl:output indent="yes" />

  <xsl:template match="/">
    <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="root">
      <teiHeader>
	<fileDesc>
	  <titleStmt>
	    <title>
	      <xsl:for-each select="//t:listBibl[contains(@xml:id,$volume)]">
		<xsl:value-of select="t:head"/>
	      </xsl:for-each>
	    </title>
	  </titleStmt>
	  <publicationStmt>
	    <publisher>Det Kgl. Bibliotek</publisher>
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
		   <xsl:variable name="alto" select="document(concat($root,@href))"/>
		   <xsl:apply-templates select="$alto/a:alto">
		     <xsl:with-param name="volume" select="$volume"/>
		     <xsl:with-param name="work" select="$work"/>
		     <xsl:with-param name="n" select="position()"/>
		   </xsl:apply-templates>
		 </xsl:for-each>
	       </xsl:element>
	     </xsl:for-each>
	  </xsl:for-each>
	</body>
      </text>
    </TEI>
  </xsl:template>


</xsl:transform>