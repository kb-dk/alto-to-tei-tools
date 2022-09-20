<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:t="http://www.tei-c.org/ns/1.0"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               exclude-result-prefixes="xsl t"
               version="2.0">

  <xsl:output method="xml"
              encoding="UTF-8"
              indent="yes"/>
  
  <xsl:template match="/">
    <t:TEI xml:id="root"> 

      <xsl:comment>
        alto naming convention
        kapsel_021/acc-1992_0005_021_Bally_0010_*.xml
      </xsl:comment>
      
      <t:teiHeader>
        <t:fileDesc>
          <t:titleStmt>
            <t:title>Louis Hjelmslev: Documents and Letters</t:title>
            <t:editor>
            </t:editor>
          </t:titleStmt>
          <t:publicationStmt>
            <t:p>
            </t:p>
          </t:publicationStmt>
          <t:sourceDesc>
            <t:p>
            </t:p>
          </t:sourceDesc>
        </t:fileDesc>
        <t:profileDesc>
        </t:profileDesc>
      </t:teiHeader>
      <t:text>
        <t:body>

          <xsl:variable name="dom" select="."/>
          
          <xsl:variable name="folders" as="xs:string *">
            <xsl:for-each select="registry/entry/filePrefix">
              <xsl:value-of select="substring-before(.,'/')"/>
            </xsl:for-each>
          </xsl:variable>

          <xsl:for-each select="distinct-values($folders)">
            <xsl:variable name="folder" as="xs:string" select="."/>
            <t:listBibl>
              <xsl:attribute name="xml:id"><xsl:value-of select="$folder"/></xsl:attribute>
              <xsl:for-each select="$dom/registry/entry[contains(filePrefix,$folder)]">
                <xsl:choose>
                  <xsl:when test="contains(letterDoc,'D')">
                    <t:bibl>
                      <xsl:attribute name="xml:id">
                        <xsl:value-of select="substring-after(filePrefix,'/')"/>
                      </xsl:attribute>
                      <t:author>
		        <xsl:value-of select="sender"/>
                      </t:author>
		      <t:title><xsl:value-of select="docTitle"/></t:title>
                      <t:date>
                        <xsl:if test="isoDate/node()">
                          <xsl:attribute name="when">
                            <xsl:value-of select="isoDate"/>
                          </xsl:attribute>
                        </xsl:if>
 		        <xsl:value-of select="typedDate"/>
                      </t:date>
                      <t:extent>
                        <t:measure unit="pages"><xsl:value-of select="pageCount"/></t:measure>
                      </t:extent>
                      <t:idno><xsl:value-of select="filePrefix"/></t:idno>
                      <t:note>

                        <xsl:value-of select="from"/><xsl:text> </xsl:text><xsl:value-of select="responsible"/>

                      </t:note>
                    </t:bibl>
                  </xsl:when>
                  <xsl:otherwise>
                    <t:bibl>
                      <xsl:attribute name="xml:id">
                        <xsl:value-of select="substring-after(filePrefix,'/')"/>
                      </xsl:attribute>
                      <t:date>
                        <xsl:if test="isoDate/node()">
                          <xsl:attribute name="when">
                            <xsl:value-of select="isoDate"/>
                          </xsl:attribute>
                        </xsl:if>
 		        <xsl:value-of select="typedDate"/>
                      </t:date>
                      <t:respStmt>
                        <t:resp>sender</t:resp>
                        <t:name><xsl:value-of select="sender"/></t:name>
                      </t:respStmt>
                      <t:respStmt>
                        <t:resp>recipient</t:resp>
                        <t:name><xsl:value-of select="recipient"/></t:name>
                      </t:respStmt>
                      <t:idno><xsl:value-of select="filePrefix"/></t:idno>
                      <t:extent>
                        <t:measure unit="pages"><xsl:value-of select="pageCount"/></t:measure>
                      </t:extent>
                      <t:note>
                        <xsl:value-of select="from"/>
                      </t:note>
                    </t:bibl>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
            </t:listBibl>
          </xsl:for-each>
        </t:body>
      </t:text>
    </t:TEI>

  </xsl:template>
  
</xsl:transform>
