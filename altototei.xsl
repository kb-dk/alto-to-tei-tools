<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
	       xmlns:h="http://www.w3.org/1999/xhtml"
	       xmlns:xlink="http://www.w3.org/1999/xlink"
	       xmlns="http://www.tei-c.org/ns/1.0"
	       xmlns:t="http://www.tei-c.org/ns/1.0"
	       version="2.0">

  <xsl:import href="do_alto_pages.xsl"/>

  <!-- this one is set as an argument when running -->

  <xsl:param name="alto_file"  select="'alto_file_lists/1_001.xml'"/>

  <!-- I believe that this can be replaced with ./ but haven't dared to test -->
  
  <xsl:param name="root" select="'../trykkefrihedsskrifter/'"/>
  <xsl:param name="pages"  select="document($alto_file)"/>
  <xsl:param name="volume" select="substring-before(substring-after($alto_file,'file_lists/'),'.xml')"/>

  <xsl:output indent="no" />

  <xsl:template match="/">
    <xsl:message>Doing volume <xsl:value-of select="$volume"/></xsl:message>
    <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="root">
      <teiHeader>
	<fileDesc>
	  <titleStmt>
	    <title>
	      <xsl:apply-templates select="//t:fileDesc/t:titleStmt/t:title"/><xsl:text>: </xsl:text>
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
		 <xsl:attribute name="decls"><xsl:value-of select="concat('#',@xml:id)"/></xsl:attribute>
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
