<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
	       xmlns:h="http://www.w3.org/1999/xhtml"
	       xmlns:xlink="http://www.w3.org/1999/xlink"
	       xmlns="http://www.tei-c.org/ns/1.0"
	       version="2.0">

  <xsl:template match="/">
    <TEI>
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
	  <sourceDesc><p/></sourceDesc>
	</fileDesc>
      </teiHeader>
      <text>
	<body>
	  <xsl:apply-templates select="h:p"/>
	</body>
      </text>
    </TEI>
  </xsl:template>

  <xsl:template match="h:a">  
    <xsl:apply-templates select="doc(@href)/a:alto">
      <xsl:with-param name="href" select="@href"/>
      <xsl:with-param name="file" select="position()"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="a:alto">
    <xsl:param name="href" select="''"/>
    <xsl:param name="file" select="''"/>
    <xsl:apply-templates select="a:Layout">
      <xsl:with-param name="href" select="$href"/>
      <xsl:with-param name="file" select="$file"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="a:Layout">
    <xsl:param name="href" select="''"/>
    <xsl:param name="file" select="''"/>
    <div>
      <xsl:apply-templates>
	<xsl:with-param name="href" select="$href"/>
	<xsl:with-param name="file" select="$file"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="a:Page">
    <xsl:param name="href" select="''"/>
    <xsl:param name="file" select="''"/>
    <pb xml:id="{concat('file',$file,@ID)}"/>
    <xsl:apply-templates>
      <xsl:with-param name="href" select="$href"/>
      <xsl:with-param name="file" select="$file"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="a:TextBlock">
    <xsl:param name="href" select="''"/>
    <xsl:param name="file" select="''"/>
    <p>
      <xsl:apply-templates>
	<xsl:with-param name="href" select="$href"/>
	<xsl:with-param name="file" select="$file"/>
      </xsl:apply-templates>
    </p>
  </xsl:template>

  <xsl:template match="a:TextLine">
    <xsl:param name="href" select="''"/>
    <xsl:param name="file" select="''"/>
    <xsl:apply-templates>
      <xsl:with-param name="href" select="$href"/>
      <xsl:with-param name="file" select="$file"/>
    </xsl:apply-templates>
    <lb/>
  </xsl:template>

  <xsl:template match="a:SP">
    <xsl:text>
    </xsl:text>
  </xsl:template>

  <xsl:template match="a:String">
    <xsl:param name="href" select="''"/>
    <xsl:param name="file" select="''"/>
    <xsl:variable name="id">
      <xsl:value-of select="concat('file',$file,'H',@HEIGHT,'W',@WIDTH,'V',@VPOS,'H',@HPOS)"/>
    </xsl:variable>
    <w xml:id="{$id}"><xsl:apply-templates select="@CONTENT"/></w>
  </xsl:template>

</xsl:transform>