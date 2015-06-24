<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
<xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" 
    doctype-public="html" />

<xsl:strip-space elements="fileList file" />

<xsl:variable name="apos">'</xsl:variable>

<!-- root node-->
<xsl:template match="/">

<html>
<head>

<meta http-equiv="expires" content="0" />
<meta http-equiv="Content-Type" name="text/html; charset=UTF-8" />

<link rel="stylesheet" type="text/css" href="/doxee-internal/styles/common.css" />

<link rel="stylesheet" type="text/css">
  <xsl:attribute name="href">/doxee-internal/styles/skins/<xsl:value-of select="/fileList/css" />.css</xsl:attribute>
</link>

<xsl:if test="not(fileList/browserXslEnabled)">
  <script src="/doxee-internal/javascript/ajaxslt/util.js" type="text/javascript"></script>
  <script src="/doxee-internal/javascript/ajaxslt/xmltoken.js" type="text/javascript"></script>
  <script src="/doxee-internal/javascript/ajaxslt/dom.js" type="text/javascript"></script>
  <script src="/doxee-internal/javascript/ajaxslt/xpath.js" type="text/javascript"></script>
  <script src="/doxee-internal/javascript/ajaxslt/xslt.js" type="text/javascript"></script>
</xsl:if>

<script src="/doxee-internal/javascript/browserCheck.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/util.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/fmweb.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/viewMode.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/ajaxCommon.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/ajax.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/fileContextMenu.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/linkContextMenu.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/contextMenuMouse.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/jsFileMenu.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/keyFileList.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/crypto.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/videoAudio.js" type="text/javascript"></script>
<script src="/doxee-internal/javascript/resourceBundle.js" type="text/javascript"></script>
<script type="text/javascript">
  <xsl:attribute name="src">/doxee-internal/servlet?command=getResourceBundle&amp;lang=<xsl:value-of select="/fileList/language" /></xsl:attribute>
</script>

<script language="javascript">

  var noFileSelected = resourceBundle["alert.nofileselected"];
  
  var selectTwoFiles = resourceBundle["selectTwoFilesForDiff"];
  
  var path = '<xsl:value-of select="/fileList/menuPath" />';
  
  var addCopyAllowed = false;
  var addMoveAllowed = false;
  
  <xsl:if test="not(/fileList/clipBoardEmpty)">
    <xsl:if test="/fileList/copyOperation">
      addCopyAllowed = true;
    </xsl:if>
    <xsl:if test="not(/fileList/copyOperation)">
      addMoveAllowed = true;
    </xsl:if>
  </xsl:if>
  
  function setSortField(sortBy)
  {
      document.sortform.sortBy.value = sortBy;
      document.sortform.submit();
  }
  
  <xsl:for-each select="/fileList/file">
    <xsl:if test="@link">
      function lm<xsl:value-of select="position()" />()
      {
          jsLinkMenu('<xsl:value-of select="@name" />','<xsl:value-of select="@linkMenuPath" />');     
      }
    </xsl:if>
    <xsl:if test="not(@link)">
      function cm<xsl:value-of select="position()" />()
      {
          contextMenu('<xsl:value-of select="@name" />');     
      }
    </xsl:if>
  </xsl:for-each>  
  
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
        var padding = 260;
      </xsl:if>
      <xsl:if test="not(/fileList/description)">
        var padding = 230;
      </xsl:if>
  
      document.getElementById('fileListTable').style.height = (windowHeight - padding) + 'px';
  }

  <xsl:if test="/fileList/linksExist">
    function copyLinks()
    {
        if (confirm(resourceBundle["confirm.copyLinks"]))
        {
            document.form1.command.value = 'copyLinks';
            document.form1.submit();
        }
    }
  </xsl:if>
  
  function uploadParms()
  {
      window.location.href='/doxee-internal/servlet?command=uploadParms&amp;actpath='+encodeURIComponent('<xsl:value-of select="/fileList/menuPath" />');  
  }
  
  function addBookmark()
  {
      bookmark('<xsl:value-of select="/fileList/menuPath" />');
  }
  
  document.onkeypress = handleFileListKey;
  
</script>

<xsl:if test="/fileList/maintananceMode">
  <script language="javascript">
    alert(resourceBundle["alert.maintanance"]);
  </script>
</xsl:if>

<xsl:if test="/fileList/dirNotFound">
  <script language="javascript">
    alert(resourceBundle["alert.dirNotFound"]);
  </script>
</xsl:if>

<xsl:if test="/fileList/errorMsg">
  <script language="javascript">
    alert('<xsl:value-of select="/fileList/errorMsg" />');
  </script>
</xsl:if>

</head>

<body onload="setFileListHeight()">

<xsl:apply-templates />

</body>

<script type="text/javascript">
  setBundleResources();
</script>

</html>

<div id="contextMenu" bgcolor="#c0c0c0" style="position:absolute;top:0px;left:0px;border-style:ridge;border-width:3px;border-color:#c0c0c0;visibility:hidden"></div>

<div id="msg1" class="msgBox" style="visibility:hidden;position:absolute;top:0px;left:0px;" />

<div id="prompt" class="promptBox" style="visibility:hidden;position:absolute;top:0px;left:0px;" />

</xsl:template>
<!-- end root node-->

<xsl:template match="fileList">

  <xsl:for-each select="/fileList/currentTrail">
    <div class="headline">
      <xsl:call-template name="currentTrail" />
    </div>
  </xsl:for-each>

  <xsl:if test="description">
    <div class="fileListDesc">
      <font class="small">
        <xsl:value-of select="description" disable-output-escaping="yes" />
      </font>
    </div>
  </xsl:if>

  <!-- tabs start -->
  <table class="tabs" cellspacing="0">
    <tr>
      <td class="tabSpacer" style="min-width:13px;"></td>
      
      <td class="tabActive" resource="label.modelist" />
 
      <td class="tabSpacer"></td>

      <td class="tabInactive">
        <a class="tab" href="javascript:viewModeThumbs()" resource="label.modethumb" />
      </td>
      
      <td class="tabSpacer"></td>

      <td class="tabInactive">
        <a class="tab" href="javascript:viewModeStory()" resource="label.modestory" />
      </td>
   
      <td class="tabSpacer"></td>

      <td class="tabInactive">
        <a class="tab" href="javascript:viewModeSlideshow()" resource="label.modeSlideshow" />
      </td>

      <xsl:if test="not(/fileList/readonly)">
        <td class="tabSpacer"></td>

        <td class="tabInactive">
          <a class="tab" href="javascript:fileStats()" resource="label.fileStats" />
        </td>
      </xsl:if>

      <td class="tabSpacer" style="width:90%"></td>
    </tr>
  </table>
  <!-- tabs end -->
  

  <form accept-charset="utf-8" name="sortform" method="get" action="/doxee-internal/servlet" style="padding:0px;margin:0px;">
    <input type="hidden" name="command" value="listFiles" />
  
    <table class="topLess" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-bottom-style:none">
      <input type="hidden">
        <xsl:attribute name="actpath">
          <xsl:value-of select="currentPath" />
        </xsl:attribute>
      </input>

      <tr>
        <td colspan="5" class="fileListFunctCont">
            
          <table border="0" cellpadding="2" width="100%">
            <tr>
              <td class="fileListFunct fileFilter">
                <label resource="label.mask"></label>:
                <input type="text" name="mask" size="8" maxlength="256">
                  <xsl:attribute name="value">
                    <xsl:value-of select="filter" />
                  </xsl:attribute>
                </input>
              </td>

              <td class="fileListFunct fileRefresh">
                <input type="button" resource="label.refresh">
                  <xsl:attribute name="onclick">javascript:document.sortform.submit()</xsl:attribute>
                </input> 
              </td>
                
              <xsl:if test="/fileList/file">
  
                <td width="30%">&#160;</td>  
                
                <td class="fileListFunct fileCount">
                  <xsl:value-of select="fileNumber" />
                  <label resource="label.files" style="margin-left:5px"></label>
                </td>

                <td class="fileListFunct fileCount">
                  <xsl:value-of select="sizeSumInt" />
                  <xsl:if test="sizeSumFract">
                    <label resource="decimalFractPoint"></label>
                    <xsl:value-of select="sizeSumFract" />
                  </xsl:if>
                  <label style="margin-left:5px"><xsl:value-of select="sizeSumUnit" /></label>
                </td>

                <td width="30%">&#160;</td>  
                
                <td class="fileListFunct fileSort">
                  <select name="sortBy" size="1" onChange="document.sortform.submit();">
                    <option value="1" resource="sort.name.ignorecase">
                      <xsl:if test="sortBy='1'">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                    </option>
                  
                    <option value="2" resource="sort.name.respectcase">
                      <xsl:if test="sortBy='2'">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                    </option>
                  
                    <option value="3" resource="sort.extension">
                      <xsl:if test="sortBy='3'">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                    </option>
                  
                    <option value="4" resource="sort.size">
                      <xsl:if test="sortBy='4'">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                    </option>
                  
                    <option value="5" resource="sort.date">
                      <xsl:if test="sortBy='5'">
                        <xsl:attribute name="selected">true</xsl:attribute>
                      </xsl:if>
                    </option>
                  </select>
                </td>

              </xsl:if>
              <xsl:if test="not(/fileList/file)">
                <td width="90%">&#160;</td>  
                
                <td class="fileListFunct fileCountZero">
                  0 <label resource="label.files"></label>
                </td>
              </xsl:if>
              
            </tr>
          </table>
        </td>
      </tr>
      
    </table>    
  </form>

  <form accept-charset="utf-8" name="form1" method="post" action="/doxee-internal/servlet" style="padding:0px;margin:0px;">

    <input type="hidden" name="command" value="multiFileOp" />

    <input type="hidden" name="actpath">
      <xsl:attribute name="value">
        <xsl:value-of select="currentPath" />
      </xsl:attribute>
    </input>

    <!-- table for list of files -->

    <table class="fileListHead">

      <xsl:if test="file">
      
        <tr>
          <th class="fileList fileListSelector">
            <input type="checkbox" class="cb4" id="cb-setAll" name="cb-setAll" onClick="javascript:setAllFilesSelected();" />
          </th>
          <th class="fileList fileListIcon">
            <img border="0" width="16" height="16">
              <xsl:attribute name="src">/doxee-internal/images/space.gif</xsl:attribute>
            </img>
          </th>
          <th class="fileList fileListName">
            <xsl:if test="/fileList/sortBy='1'">
              <xsl:attribute name="resource">label.filename</xsl:attribute>
            </xsl:if>
            <xsl:if test="/fileList/sortBy!='1'">
              <a class="listHead" href="javascript:setSortField('1')" resource="label.filename" />
            </xsl:if>
          </th>
          
          <th class="fileList fileListModified">
            <xsl:if test="/fileList/sortBy='5'">
              <xsl:attribute name="resource">label.lastModified</xsl:attribute>
            </xsl:if>
            <xsl:if test="/fileList/sortBy!='5'">
              <a class="listHead" href="javascript:setSortField('5')" resource="label.lastModified" />
            </xsl:if>
          </th>
          <th class="fileList fileListSize">
            <xsl:if test="/fileList/sortBy='4'">
              <xsl:attribute name="resource">label.fileSize</xsl:attribute>
            </xsl:if>
            <xsl:if test="/fileList/sortBy!='4'">
              <a class="listHead" href="javascript:setSortField('4')" resource="label.fileSize" />
            </xsl:if>
          </th>
        </tr>
     
      </xsl:if>
       
    </table>
    
    <div id="fileListTable" class="fileListScrollDiv">
    
    <table id="tableFileList" class="fileList" cellspacing="0" cellpadding="0">

      <xsl:if test="file">

        <xsl:for-each select="file">
 
          <tr onmouseup="handleRowClick(event)">
            <td>
              <xsl:attribute name="class">fileList fileListSelector <xsl:if test="not(description)">sepBot</xsl:if></xsl:attribute>
              <input type="checkbox" class="cb2">
                <xsl:attribute name="name">
                  <xsl:value-of select="@name" />
                </xsl:attribute>
                <xsl:if test="@link">
                  <xsl:attribute name="disabled">true</xsl:attribute>
                </xsl:if>
              </input>
            </td>
  
            <td>
              <xsl:attribute name="class">fileList fileListIcon <xsl:if test="not(description)">sepBot</xsl:if></xsl:attribute>
              <img border="0" width="16" height="16">
                <xsl:attribute name="src">/doxee-internal/icons/<xsl:value-of select="@icon" /></xsl:attribute>
              </img>
            </td>
            
            <td>
              <xsl:attribute name="class">fileList fileListName <xsl:if test="not(description)">sepBot</xsl:if></xsl:attribute>
              <xsl:if test="@link">
                <a class="link">
                  <xsl:if test="@outsideDocRoot">
                    <xsl:attribute name="href">#</xsl:attribute>
                    <xsl:attribute name="title">access forbidden</xsl:attribute>
                  </xsl:if>
                  <xsl:if test="not(@outsideDocRoot)">
                    <xsl:attribute name="href">javascript:lm<xsl:value-of select="position()" />()</xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:value-of select="'--&gt; '"/>
                      <xsl:value-of select="linkPath"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test="@displayName">
                    <xsl:value-of select="@displayName" />
                  </xsl:if>
                  <xsl:if test="not(@displayName)">
                    <xsl:value-of select="@name" />
                  </xsl:if>
                </a>
              </xsl:if>
              <xsl:if test="not(@link)">
                <a class="fn">
                  <xsl:attribute name="href">javascript:cm<xsl:value-of select="position()" />()</xsl:attribute>
                  <xsl:if test="@displayName">
                    <xsl:value-of select="@displayName" />
                  </xsl:if>
                  <xsl:if test="not(@displayName)">
                    <xsl:value-of select="@name" />
                  </xsl:if>
                </a>
              </xsl:if>
            </td>
            
            <td>
              <xsl:attribute name="class">fileList fileListModified <xsl:if test="not(description)">sepBot</xsl:if></xsl:attribute>
              <font class="fixed">
                <xsl:value-of select="@lastModified" />
              </font>
            </td>
            
            <td>
              <xsl:attribute name="class">fileList fileListSize <xsl:if test="not(description)">sepBot</xsl:if></xsl:attribute>
              <font class="fixed">
                <xsl:value-of select="@size" />
              </font>
            </td>

          </tr>
          
          <xsl:if test="description">
            <tr>
              <td colspan="2" class="fileListDesc">&#160;</td>
              <td colspan="3" class="fileListDesc">
                <font class="small">
                  <xsl:value-of select="description" />
                </font>
              </td>
            </tr>
          </xsl:if>
      
        </xsl:for-each>

      </xsl:if>

    </table>

    </div>
    
    <!-- function buttons and actions -->
    
    <table class="topLess" border="0" cellpadding="0" cellspacing="0" width="100%">

      <xsl:if test="file">

        <tr>
          <td class="fileListFunct">
            <label resource="label.selectedFiles"></label>:
            &#160;
            <select name="cmd" size="1" onchange="javascript:selectedFileFunction(true)">
              <option resource="label.selectFunction" />
              <xsl:if test="not(/fileList/readonly)">
                <option value="delete" resource="button.delete" />
                <option value="copy" resource="label.copyToClip" />
                
                <option value="copyAdd" resource="label.copyToClipAdd" id="copyAddOption">
                  <xsl:if test="(/fileList/clipBoardEmpty) or not(/fileList/copyOperation)">
                    <xsl:attribute name="style">display:none</xsl:attribute>
                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                  </xsl:if>
                </option>
                      
                <option value="move" resource="label.cutToClip" />

                <option value="moveAdd" resource="label.cutToClipAdd" id="moveAddOption">
                  <xsl:if test="(/fileList/clipBoardEmpty) or (/fileList/copyOperation)">
                    <xsl:attribute name="style">display:none</xsl:attribute>
                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                  </xsl:if>
                </option>

                <option value="zip" resource="button.zip" />
                <xsl:if test="resources/msg[@key='button.tar']">
                  <option value="tar" resource="button.tar" />
                </xsl:if>
              </xsl:if>
              <option value="download" resource="button.downloadAsZip" />
              <option value="diff" resource="action.diff" />
            </select>
          </td>
        </tr>
        
      </xsl:if>      

      <xsl:if test="not(/fileList/readonly)">
        <tr>
          <td class="fileListFunct">
          
            <div class="buttonCont">

              <input type="button" resource="button.upload">
                <xsl:attribute name="onclick">javascript:uploadParms();</xsl:attribute>
              </input> 
              
              <input type="button" resource="button.paste" id="pasteButton">
                <xsl:attribute name="onclick">javascript:window.location.href='/doxee-internal/servlet?command=pasteFiles';</xsl:attribute>
                <xsl:if test="/fileList/clipBoardEmpty">
                  <xsl:attribute name="style">display:none</xsl:attribute>
                </xsl:if>
              </input> 
        
              <input type="button" resource="button.pasteLink" id="pasteLinkButton">
                <xsl:attribute name="onclick">javascript:window.location.href='/doxee-internal/servlet?command=pasteLinks';</xsl:attribute>
                <xsl:if test="not(/fileList/copyOperation) or (/fileList/clipBoardEmpty)">
                  <xsl:attribute name="style">display:none</xsl:attribute>
                </xsl:if>
              </input> 
                
              <input type="button" resource="button.bookmark" titleResource="title.bookmarkButton">
                <xsl:attribute name="onclick">javascript:addBookmark();</xsl:attribute>
              </input> 
              
              <xsl:if test="/fileList/linksExist">
                <input type="button" resource="button.copyLinks" titleResource="tooltip.copyLinks">
                  <xsl:attribute name="onclick">javascript:copyLinks()</xsl:attribute>
                </input> 
              </xsl:if>

            </div>
       
          </td>
        </tr>
      </xsl:if>
      
      <xsl:if test="/fileList/readonly">
        <xsl:if test="not(file)">
          <tr><td class="fileListFunct">&#160;</td></tr>
        </xsl:if>
      </xsl:if>

    </table>

  </form>

</xsl:template>

<xsl:include href="currentTrail.xsl" />

</xsl:stylesheet>