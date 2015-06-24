<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
<xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" 
    doctype-public="html" />

<xsl:strip-space elements="fileList file" />

<xsl:template name="insDoubleBackslash">
  <xsl:param name="string" />
  <xsl:if test="contains($string, '\')">
    <xsl:value-of select="substring-before($string, '\')" />%5C%5C<xsl:call-template name="insDoubleBackslash"><xsl:with-param name="string"><xsl:value-of select="substring-after($string, '\')" /></xsl:with-param></xsl:call-template>
  </xsl:if>
  <xsl:if test="not(contains($string, '\'))">
    <xsl:value-of select="$string" />
  </xsl:if>
</xsl:template>

<!-- root node-->
<xsl:template match="/">

<html>
<head>

<meta http-equiv="Content-Type" name="text/html; charset=UTF-8" />

<link rel="stylesheet" type="text/css" href="/doxee-internal/styles/common.css" />

<link rel="stylesheet" type="text/css">
  <xsl:attribute name="href">/doxee-internal/styles/skins/<xsl:value-of select="/fileList/css" />.css</xsl:attribute>
</link>

<script src="/doxee-internal/javascript/browserCheck.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/util.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/fmweb.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/viewMode.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/graphicsContextMenu.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/fileListStats.js" type="text/javascript"></script>

<script src="/doxee-internal/javascript/resourceBundle.js" type="text/javascript"></script>
<script type="text/javascript">
  <xsl:attribute name="src">/doxee-internal/servlet?command=getResourceBundle&amp;lang=<xsl:value-of select="/fileList/language" /></xsl:attribute>
</script>

<script type="text/javascript" language="JavaScript">
  function setFileListHeight()
  {
      if (browserMSIE)
      {
          setTimeout('setHeightInternal()', 200);
      }
      else
      {
          setHeightInternal();
      }
  }
  
  function setHeightInternal()
  {
      var windowHeight;
      if (!browserFirefox)
      {
          // windowHeight = document.body.clientHeight;
          windowHeight = document.documentElement.clientHeight;
      }
      else
      {
          windowHeight = window.innerHeight;
      }
      
      <xsl:if test="/fileList/description">
        var padding = 220;
      </xsl:if>
      <xsl:if test="not(/fileList/description)">
        var padding = 180;
      </xsl:if>
      
      document.getElementById('fileListTable').style.height = windowHeight - padding + 'px';
  }

  function setSortField(sortBy)
  {
      window.location.href='/doxee-internal/servlet?command=fileStats&amp;initial=true&amp;sortBy=' + sortBy;
  }
</script>

</head>

<body onload="setBundleResources();setFileListHeight()">

  <xsl:call-template name="fileList" />

</body>
</html>

</xsl:template>
<!-- end root node-->

<xsl:template name="fileList">

  <div class="headline">
    <xsl:value-of select="fileList/headLine" />
  </div>

  <xsl:if test="/fileList/description">
    <div class="fileListDesc">
      <font class="small">
        <xsl:value-of select="/fileList/description" disable-output-escaping="yes" />
      </font>
    </div>
  </xsl:if>

  <!-- tabs start -->
  <table class="tabs" cellspacing="0">
    <tr>
      <td class="tabSpacer" style="min-width:13px;"></td>
      
      <td class="tabInactive" nowrap="true">
        <a class="tab" href="javascript:viewModeList()" resource="label.modelist" />
      </td>
 
      <td class="tabSpacer"></td>

      <td class="tabInactive" nowrap="true">
        <a class="tab" href="javascript:viewModeThumbs()" resource="label.modethumb" />
      </td>
      
      <td class="tabSpacer"></td>

      <td class="tabInactive" nowrap="true">
        <a class="tab" href="javascript:viewModeStory()" resource="label.modestory" />
      </td>
   
      <td class="tabSpacer"></td>

      <td class="tabInactive" nowrap="true">
        <a class="tab" href="javascript:viewModeSlideshow()" resource="label.modeSlideshow" />
      </td>

      <td class="tabSpacer"></td>

      <td class="tabActive" nowrap="true" resource="label.fileStats" />

      <td class="tabSpacer" style="width:90%"></td>
    </tr>
  </table>
  <!-- tabs end -->
  
  <xsl:if test="/fileList/file">
  
  <form accept-charset="utf-8" name="resetForm" method="get" action="/doxee-internal/servlet" style="margin:0">
    <input type="hidden" name="command" value="resetStatistics" />
    <input type="hidden" name="actPath">
      <xsl:attribute name="value"><xsl:value-of select="/fileList/currentPath" /></xsl:attribute>
    </input>
    
    <table class="fileListHead" width="100%">
      <tr>
        <td colspan="5" class="fileListFunct sepBot">&#160;</td>
      </tr>
      
      <tr>
        <th class="fileListHead" style="padding-left:30px;text-align:left">
          <xsl:if test="/fileList/sortBy = '1'">
            <span resource="label.filename"></span>
          </xsl:if>
          <xsl:if test="not(/fileList/sortBy = '1')">
            <a href="javascript:setSortField('1')" class="listHead" resource="label.filename" />
          </xsl:if>
        </th>
        <th class="fileListHead" style="width:170px;padding-right:5px;text-align:right;white-space:nowrap;">
          <xsl:if test="/fileList/sortBy = '8'">
            <span resource="label.downloads"></span>
          </xsl:if>
          <xsl:if test="not(/fileList/sortBy = '8')">
            <a href="javascript:setSortField('8')" class="listHead" resource="label.downloads" />
          </xsl:if>
          <xsl:if test="/fileList/lastResetDate">
            <br/>
            <span class="plaintext" resource="label.since"></span>
            <span class="plaintext" style="margin-left:5px"><xsl:value-of select="/fileList/lastResetDate" /></span>              
          </xsl:if>
        </th>
        <th class="fileListHead" style="width:80px;padding-left:5px;padding-right:5px;text-align:right;white-space:nowrap;">
          <xsl:if test="/fileList/sortBy = '7'">
            <span resource="rating.count"></span>
          </xsl:if>
          <xsl:if test="not(/fileList/sortBy = '7')">
            <a href="javascript:setSortField('7')" class="listHead" resource="rating.count" />
          </xsl:if>
        </th>
        <th class="fileListHead" style="width:70px;padding-left:5px;padding-right:5px;text-align:right;white-space:nowrap;">
          <xsl:if test="/fileList/sortBy = '10'">
            <span resource="rating.starSum"></span>
          </xsl:if>
          <xsl:if test="not(/fileList/sortBy = '10')">
            <a href="javascript:setSortField('10')" class="listHead" resource="rating.starSum" />
          </xsl:if>
        </th>
        <th class="fileListHead" style="width:90px;padding-left:5px;padding-right:5px;text-align:right;white-space:nowrap;">
          <xsl:if test="/fileList/sortBy = '9'">
            <span resource="label.comments"></span>
          </xsl:if>
          <xsl:if test="not(/fileList/sortBy = '9')">
            <a href="javascript:setSortField('9')" class="listHead" resource="label.comments" />
          </xsl:if>
        </th>
      </tr>
    </table>
    
    <div id="fileListTable" class="fileListScrollDiv">
      
      <table class="fileList" cellspacing="0" cellpadding="0">
      
        <xsl:for-each select="/fileList/file">
      
          <tr>
            <td class="fileList sepBot" style="padding-left:5px;width:22px">
              <img border="0" width="16" height="16">
                <xsl:if test="@icon">
                  <xsl:attribute name="src">/doxee-internal/icons/<xsl:value-of select="@icon" /></xsl:attribute>
                </xsl:if>
                <xsl:if test="not(@icon)">
                  <xsl:attribute name="src">webfilesys/images/space.gif</xsl:attribute>
                </xsl:if>
              </img>
            </td>

            <td class="fileList sepBot" style="padding-right:5px">
              <a class="fn">
			    <xsl:attribute name="href">javascript:previewFile('<xsl:value-of select="/fileList/pathForScript"/>/<xsl:value-of select="@name" />')</xsl:attribute>
                <xsl:if test="@displayName">
                  <xsl:value-of select="@displayName" />
                </xsl:if>
                <xsl:if test="not(@displayName)">
                  <xsl:value-of select="@name" />
                </xsl:if>
              </a>
            </td>
            
            <td class="fileList sepBot" align="right" style="width:170px;padding-right:30px" nowrap="nowrap">
              <xsl:value-of select="viewCount"/>
            </td>
            
            <td class="fileList sepBot" align="right" style="width:80px;padding-right:10px" nowrap="nowrap">
              <xsl:value-of select="voteCount"/>
            </td>

            <td class="fileList sepBot" align="right" style="width:70px;padding-right:10px" nowrap="nowrap">
              <xsl:value-of select="voteStarSum"/>
            </td>

            <td class="fileList sepBot" align="right" style="width:80px;padding-right:20px" nowrap="nowrap">
              <xsl:if test="commentCount != '0'">
                <a class="fn">
                  <xsl:attribute name="href">javascript:jsComments('<xsl:value-of select="pathForScript" />')</xsl:attribute>
                  <xsl:value-of select="commentCount"/>
                </a>
              </xsl:if>
              <xsl:if test="commentCount = '0'">
                <xsl:value-of select="commentCount"/>
              </xsl:if>
            </td>
          </tr>
      
        </xsl:for-each>
      
      </table>
      
    </div>
    
    <table class="topLess" border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td class="fileListFunct">
          <div class="buttonCont">
            <input type="button" onclick="document.resetForm.submit()" resource="button.resetStats" />
          </div>
        </td>
      </tr>
    </table>
    
  </form>
  
  </xsl:if>
  
  <xsl:if test="not(/fileList/file)">
    <table class="fileListHead" cellspacing="0" cellpadding="0">
      <tr>
        <td class="fileList sepBot" style="padding:10px">0 <span resource="label.files"></span></td>
      </tr>
    </table>
  </xsl:if>
  
</xsl:template>
  
</xsl:stylesheet>
