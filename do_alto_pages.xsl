<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
	       xmlns:xlink="http://www.w3.org/1999/xlink"
	       xmlns="http://www.tei-c.org/ns/1.0" 
	       xmlns:uuid="java:java.util.UUID"
	       exclude-result-prefixes="a xlink uuid"
	       version="2.0">


  <xsl:template match="a:alto">
    <xsl:param name="img_src" select="a:Description/a:sourceImageInformation/a:fileName"/>
    <xsl:apply-templates select="a:Layout">
      <xsl:with-param name="img_src" select="$img_src"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="a:Layout">
    <xsl:param name="img_src" select="''"/>
    <div>
      <xsl:apply-templates>
	<xsl:with-param name="img_src" select="$img_src"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="a:Page">
    <xsl:param name="img_src" select="''"/>
    <pb xml:id="{concat('pg',uuid:randomUUID())}" facs="{$img_src}"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="a:ComposedBlock">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="a:TextBlock">
    <lb/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="a:TextLine">
    <xsl:apply-templates/><xsl:text>
</xsl:text>
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
    <w><xsl:apply-templates select="@CONTENT"/></w>
  </xsl:template>

</xsl:transform>