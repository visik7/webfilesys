<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
<xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" 
    doctype-public="html" />

<xsl:strip-space elements="fileComments" />

<!-- root node-->
<xsl:template match="/">

<script language="javascript">
  function limitText()
  {  
      if (document.form1.newComment.value.length > 2048)
      {  
          document.form1.newComment.value=document.form1.newComment.value.substring(0,2048);
      }
  }
  
  function confirmDelete()
  {  
      if (confirm(resourceBundle["confirm.delcomments"]))
      { 
          window.location.href='/doxee-internal/servlet?command=delComments&amp;actPath=<xsl:value-of select="/fileComments/encodedPath" />';
      }
  }
  
</script>

<div class="blogComments">

  <div class="commentContHead">
    <span resource="label.commentList"></span>
  </div>

  <form accept-charset="utf-8" id="blogCommentForm" name="blogCommentForm" method="post" action="/doxee-internal/servlet">
  
    <input type="hidden" name="command" value="blog" />
    <input type="hidden" name="cmd" value="addComment" />
    
    <input type="hidden" name="filePath">
      <xsl:attribute name="value"><xsl:value-of select="/fileComments/path" /></xsl:attribute>
    </input>

    <div class="blogCommentList">

      <table class="blogCommentForm" width="100%">
   
        <xsl:if test="not(/fileComments/comments) or not(/fileComments/comments/comment)">
          <tr>
            <td class="formParm1" resource="label.nocomments"></td>
          </tr>
        </xsl:if>

        <xsl:if test="/fileComments/comments and /fileComments/comments/comment">
            
          <xsl:for-each select="/fileComments/comments/comment">
            <tr>
              <td class="formParm1">
                <xsl:value-of select="user" />,&#160;
                <xsl:value-of select="date" />
              </td>
            </tr>
              
            <tr>
              <td class="formParm2">
                <xsl:value-of select="msg" />
              </td>
            </tr>
   
            <tr><td class="formParm1">&#160;</td></tr>
    
          </xsl:for-each>

        </xsl:if>
    
        <xsl:if test="/fileComments/modifyPermission">
          <tr>
            <td class="formParm1">
              <span resource="label.addcomment"></span>:
            </td>
          </tr>

          <tr>
            <td class="formParm2">
              <textarea id="newComment" name="newComment" cols="100" rows="4" wrap="virtual" class="commentText" 
                  onKeyup="limitCommentText()" onChange="limitCommentText()"></textarea>
            </td>
          </tr>

		  <xsl:if test="/fileComments/virtualUser">
            <tr>
              <td class="formParm1">
                <span resource="label.commentAuthor"></span>:
                &#160;
                <input type="text" name="author" style="width:150px" />
              </td>
            </tr>
          </xsl:if>
        </xsl:if>
	  
        <tr>
          <td>
            <div class="buttonCont">
        
              <xsl:if test="/fileComments/modifyPermission">
			
                <input type="button" resource="button.addComment">
                  <xsl:attribute name="onclick">javascript:submitComment()</xsl:attribute>
                </input>              

                <xsl:if test="not(/fileComments/readonly)">
                  <xsl:if test="/fileComments/comments and /fileComments/comments/comment"> 
                    <input type="button" resource="button.delComments">
                      <xsl:attribute name="onclick">javascript:confirmDelComments('<xsl:value-of select="/fileComments/pathForScript" />')</xsl:attribute>
                    </input>              
                  </xsl:if>  
                </xsl:if>  
              
              </xsl:if>              

              <input type="button" resource="button.closewin">
                <xsl:attribute name="onclick">closeBlogComments()</xsl:attribute>
              </input>

		    </div>
          </td>
        </tr>
      </table>
    
    </div>
    
  </form>

</div>

</xsl:template>

</xsl:stylesheet>
