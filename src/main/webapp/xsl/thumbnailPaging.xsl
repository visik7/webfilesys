<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
  <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"/>

  <xsl:template name="paging">

      <xsl:if test="/fileList/fileGroup">
 
        <tr>
          <td class="fileListFunctCont">

            <table border="0" cellpadding="2" width="100%">
              <tr>
            
                <xsl:if test="paging/currentPage &gt; 1">
                  <td class="fileListFunct" valign="center" nowrap="true">
                    <a href="/doxee-internal/servlet?command=thumbnail&amp;startIdx=0"><img src="/doxee-internal/images/first.gif" border="0" /></a>
                    &#160;
                    <a>
                      <xsl:attribute name="href">/doxee-internal/servlet?command=thumbnail&amp;startIdx=<xsl:value-of select="paging/prevStartIdx" /></xsl:attribute>
                      <img src="/doxee-internal/images/previous.gif" border="0" />
                    </a>
                  </td>
                </xsl:if>
            
                <td class="fileListFunct" valign="center" nowrap="true">
                  <label resource="label.files"></label>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="paging/firstOnPage" />
                  ...
                  <xsl:value-of select="paging/lastOnPage" />
                  <xsl:text> </xsl:text>
                  <label resource="label.of"></label>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="fileNumber" />
                </td>
              
                <xsl:if test="fileNumber &gt; paging/pageSize">
              
                  <td class="fileListFunct" valign="center" nowrap="true">
                    <label resource="label.page"></label>

                    <xsl:for-each select="paging/page">
                      <xsl:if test="@num=../currentPage">
                        <div class="pagingPage pagingPageCurrent">
                          <xsl:value-of select="@num" />
                        </div>
                      </xsl:if>
                      <xsl:if test="not(@num=../currentPage)">
                        <div class="pagingPage pagingPageOther">
                          <xsl:attribute name="onclick">window.location.href='/doxee-internal/servlet?command=thumbnail&amp;startIdx=<xsl:value-of select="@startIdx" />'</xsl:attribute>
                          <xsl:value-of select="@num" />
                        </div>
                      </xsl:if>
                    </xsl:for-each>
                  </td>

                  <xsl:if test="paging/nextStartIdx">
              
                    <td class="fileListFunct" align="right" valign="center" nowrap="true">
                      <a>
                        <xsl:attribute name="href">/doxee-internal/servlet?command=thumbnail&amp;startIdx=<xsl:value-of select="paging/nextStartIdx" /></xsl:attribute>
                        <img src="/doxee-internal/images/next.gif" border="0" />
                      </a>
                      &#160;
                      <a>
                        <xsl:attribute name="href">/doxee-internal/servlet?command=thumbnail&amp;startIdx=<xsl:value-of select="paging/lastStartIdx" /></xsl:attribute>
                        <img src="/doxee-internal/images/last.gif" border="0" />
                      </a>
                    </td>
                  </xsl:if>
                
                </xsl:if>
              </tr>
            </table>
          </td>
        </tr>
      
      </xsl:if>
      
  </xsl:template>

</xsl:stylesheet>
