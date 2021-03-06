function mkdir(path)
{  
    showPrompt('/doxee-internal/servlet?command=mkdirPrompt&path=' + encodeURIComponent(path), '/doxee-internal/xsl/createFolder.xsl', 320, 190);

    setBundleResources();
    
    document.mkdirForm.NewDirName.focus();
    
    document.mkdirForm.NewDirName.select();
}

function deleteDir(path, domId)
{
    deleteFolder(path, 'false');
}

function renameDir(path)
{
    showPrompt('/doxee-internal/servlet?command=renDirPrompt&path=' + encodeURIComponent(path), '/doxee-internal/xsl/renameDir.xsl', 320, 190);

    setBundleResources();

    document.mkdirForm.NewDirName.focus();
    
    document.mkdirForm.NewDirName.select();
}

function zip(path)
{
    window.location.href="/doxee-internal/servlet?command=zipDir&actPath=" + encodeURIComponent(path);
}

function paste(path)
{
    window.location.href="/doxee-internal/servlet?command=pasteFiles&actpath=" + encodeURIComponent(path) + "&random=" + (new Date().getTime());
}

function statistics(path)
{
    statWin=open("/doxee-internal/servlet?command=statistics&actpath=" + encodeURIComponent(path) + "&random=" + (new Date()).getTime(),"Statistics","scrollbars=yes,resizable=yes,width=580,height=590");
    statWin.focus();
}

function search(path)
{
    searchWin=open("/doxee-internal/servlet?command=search&actpath=" + encodeURIComponent(path),"Search","scrollbars=yes,resizable=yes,width=500,height=480,left=80,top=20,screenX=80,screenY=20");
    searchWin.focus();
    searchWin.opener=self;
}

function mkfile(path)
{
    showPrompt('/doxee-internal/servlet?command=mkfilePrompt&path=' + encodeURIComponent(path), '/doxee-internal/xsl/createFile.xsl', 320, 190);
    
    setBundleResources();
    
    document.mkfileForm.NewFileName.focus();
    
    document.mkfileForm.NewFileName.select();
}

function upload(path)
{
    window.parent.frames['FileList'].location.href = "/doxee-internal/servlet?command=uploadParms&actpath=" + encodeURIComponent(path);
}

function publish(path,mailEnabled)
{
    if (parent.mailEnabled == 'true')
    {
         publishWin=window.open("/doxee-internal/servlet?command=publishForm&actPath=" + encodeURIComponent(path) + "&type=common","publish","status=no,toolbar=no,menu=no,width=620,height=550,resizable=yes,scrollbars=no,left=30,top=20,screenX=40,screenY=20");
    }
    else
    {
         publishWin=window.open("/doxee-internal/servlet?command=publishParms&actPath=" + encodeURIComponent(path) + "&type=common","publish","status=no,toolbar=no,menu=no,width=620,height=290,resizable=yes,scrollbars=no,left=30,top=80,screenX=40,screenY=80");
    }

    publishWin.focus();
}

function description(path)
{
    window.location.href="/doxee-internal/servlet?command=editMetaInf&relPath=" + encodeURIComponent(path) + "&geoTag=true";
}

function driveInfo(path)
{
    propWin=window.open("/doxee-internal/servlet?command=driveInfo&path=" + encodeURIComponent(path) + "&random=" + (new Date().getTime()),"propWin","status=no,toolbar=no,location=no,menu=no,width=400,height=200,resizable=yes,left=100,top=200,screenX=100,screenY=200");
    propWin.focus();
}

function refresh(path)
{
    window.location.href="/doxee-internal/servlet?command=refresh&path=" + encodeURIComponent(path);
}


function rights(path)
{
    window.location.href="/doxee-internal/servlet?command=unixRights&actpath=" + encodeURIComponent(path) + "&isDirectory=true&random=" + (new Date()).getTime();
}

function deleteFolder(path, confirmed)
{
    url = "/doxee-internal/servlet?command=deleteDir&path=" + encodeURIComponent(path) + "&confirmed=" + confirmed;

    var responseXml = xmlRequestSynchron(url);
   
    if (!responseXml)
    {
        window.parent.parent.location.href = '/doxee-internal/servlet?command=mobile&cmd=folderFileList';

        return;
    }
    
    hideMenu();

    var successItem = responseXml.getElementsByTagName("success")[0];            
    var success = successItem.firstChild.nodeValue;
                 
    var messageItem = responseXml.getElementsByTagName("message")[0];            
    var message = "";
             
    if (messageItem.firstChild)
    {
        message = messageItem.firstChild.nodeValue;
    }
             
    if (success == "notEmpty")
    {
        if (confirm(message))
        {
            deleteFolder(path, "true");
        }
    }
    else
    {
        if (success == "deleted")
        {
            window.location.href = '/doxee-internal/servlet?command=mobile&cmd=folderFileList';
        }       
        else
        {
            alert(path + '\n' + message);
        }
    }
}

