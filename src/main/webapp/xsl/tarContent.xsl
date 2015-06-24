<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
<xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" 
    doctype-public="html" />

<xsl:strip-space elements="folderTree folder" />

<!-- root node-->
<xsl:template match="/">

<html>
<head>

  <meta http-equiv="expires" content="0" />

  <link rel="stylesheet" type="text/css" href="/doxee-internal/styles/common.css" />

  <link rel="stylesheet" type="text/css">
    <xsl:attribute name="href">/doxee-internal/styles/skins/<xsl:value-of select="/folderTree/css" />.css</xsl:attribute>
  </link>

  <style type="text/css">
    img {vertical-align:middle}
  </style>
  
  <title><xsl:value-of select="/folderTree/resources/msg[@key='label.viewzip']/@value" /></title>

</head>

<body>

<xsl:apply-templates />

</body>
</html>


</xsl:template>
<!-- end root node-->

<xsl:template match="folderTree">

  <img src="/doxee-internal/images/space.gif" border="0" width="12" height="17" />
  <img src="/doxee-internal/images/tar.png" border="0" width="16" height="16" />
  <img src="/doxee-internal/images/space.gif" border="0" width="4" height="1" />
  <a class="dirtree">
    <xsl:value-of select="/folderTree/shortZipFileName" />
  </a>
  
  <xsl:for-each select="folder">
    <xsl:call-template name="folder" />
  </xsl:for-each>

</xsl:template>

<xsl:template name="folder"> 

  <div class="last">
      
    <xsl:if test="position()=last()">
      <img src="/doxee-internal/images/branchLast.gif" border="0" width="15" height="17" />
    </xsl:if>
    <xsl:if test="position()!=last()">
      <img src="/doxee-internal/images/branch.gif" border="0" width="15" height="17" />
    </xsl:if>

    <xsl:if test="folder">
      <img src="/doxee-internal/images/folder.gif" border="0" width="17" height="14" />
    </xsl:if>

    <xsl:if test="not(folder)">
      <img border="0" width="16" height="16">
        <xsl:attribute name="src">/doxee-internal/icons/<xsl:value-of select="@icon" /></xsl:attribute>
      </img>
    </xsl:if>

    <img src="images/space.gif" border="0" width="4" height="1" />
    
    <a class="dirtree">
      <xsl:attribute name="href">javascript:void(0)</xsl:attribute>

      <xsl:attribute name="class">
        <xsl:value-of select="'dirtree'"/>
      </xsl:attribute>
    
      <xsl:value-of select="@name" /> 
    </a>
    
    <xsl:if test="not(folder)">
      (<xsl:value-of select="@entrySize" /> bytes, <xsl:value-of select="@lastModified" />)
    </xsl:if>

    <xsl:if test="folder">
      <xsl:if test="position()=last()">
        <div class="indent">
          <xsl:for-each select="folder">
            <xsl:call-template name="folder" />
          </xsl:for-each>
        </div>
      </xsl:if>

      <xsl:if test="position()!=last()">
        <div class="indent">
          <div class="more">
            <xsl:for-each select="folder">
              <xsl:call-template name="folder" />
            </xsl:for-each>
          </div>
        </div>
      </xsl:if>
    </xsl:if>

  </div>
  
</xsl:template>

</xsl:stylesheet>


