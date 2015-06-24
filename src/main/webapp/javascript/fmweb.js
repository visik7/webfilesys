function selectAll() {
    var allSelected = true;
	
	var fileCheckboxes = new Array();
	
    for (var i = document.form1.elements.length - 1; i >= 0; i--) {
        if ((document.form1.elements[i].type == "checkbox") &&
		    (document.form1.elements[i].name != "cb-confirm") &&
            (document.form1.elements[i].name != "cb-setAll")) {
			fileCheckboxes.push(document.form1.elements[i]);
	        if ((!document.form1.elements[i].checked) &&
	            (!document.form1.elements[i].disabled)) {
		        allSelected = false;
	        }
	    } 
    }
	
    if (allSelected) {
	    for (var i = 0; i < fileCheckboxes.length; i++) {
		    fileCheckboxes[i].checked = false;
	    }
    } else {
	    for (var i = 0; i < fileCheckboxes.length; i++) {
		    if (!fileCheckboxes[i].disabled) {
		        fileCheckboxes[i].checked = true;
			}
	    }
		document.getElementById("cb-setAll").checked = true;
    }	
}

function multiDownload() {
    document.form1.command.value = 'multiDownload';
    document.form1.submit();
}

function setDependendCheckbox(prereq,dependent)
{
   if (prereq.checked==false)
   {
       dependent.checked=false;
   }
}

function setRelatedCheckbox(master,dependent)
{
   if (master.checked)
   {
       dependent.checked=true;
   }
}

function anySelected() {
    for (var i = document.form1.elements.length - 1; i >= 0; i--) {
        if ((document.form1.elements[i].type == "checkbox") &&
            document.form1.elements[i].checked &&
            (document.form1.elements[i].name != 'cb-confirm')) {
	        return(true);
	    }
    }

    return(false);
}

function resetSelected() {
    for (var i = document.form1.elements.length - 1; i >= 0; i--) {
	    if ((document.form1.elements[i].type == "checkbox") && document.form1.elements[i].checked) {
	        document.form1.elements[i].checked = false;
        }
    }
}

function multiFileCopyMove()
{
    document.form1.command.value='multiFileCopyMove';

    xmlRequestPost("/doxee-internal/servlet", getFormData(document.form1), showCopyResult);
    
    document.form1.command.value='multiFileOp';
}

function diffCompare() {
    if (checkTwoFilesSelected()) {
	    var compareWin = window.open('/doxee-internal/servlet?command=blank','compareWin','width=' + (screen.width - 20) + ',height=' + (screen.height - 80) + ',scrollbars=yes,resizable=yes,status=no,menubar=no,toolbar=no,location=no,directories=no,screenX=0,screenY=0,left=0,top=0');
        compareWin.focus();
        document.form1.command.value = 'diff';
        document.form1.target = 'compareWin';
        
	    document.form1.submit();
        document.form1.target = '';
    }
}

function checkTwoFilesSelected() {
    var numChecked = 0;
    
    for (var i = document.form1.elements.length - 1; i >= 0; i--) {
         if ((document.form1.elements[i].type == "checkbox") && 
		     (document.form1.elements[i].name != "cb-setAll") &&
		     document.form1.elements[i].checked) {
	         numChecked++;
         }
    }
    
    if (numChecked != 2) {
        alert(selectTwoFiles);
	    return(false);
    }
    
    return(true);
}

function selectedFileFunction(unhighlight) {
    if (!anySelected()) {
        alert(noFileSelected + '!');
        document.form1.cmd.selectedIndex = 0;
        return;
    }

    var idx = document.form1.cmd.selectedIndex;

    var cmd = document.form1.cmd.options[idx].value;

    if (cmd == 'delete') {
        var delConfirmMsg = resourceBundle["confirm.deleteFiles"];
        
        if (confirm(delConfirmMsg)) {
            document.form1.submit();
            return;
        }
    }

    if ((cmd == 'zip') || (cmd == 'tar')) {
        document.form1.submit();
        return;
    }

    if ((cmd == 'copy') || (cmd == 'copyAdd') || (cmd == 'move') || (cmd == 'moveAdd')) {
        multiFileCopyMove();
    } else if (cmd == 'download') {
	    multiDownload();
    } else if (cmd == 'diff') {
	    diffCompare();
    }
     
    document.form1.command.value = 'multiFileOp';
    document.form1.cmd.selectedIndex = 0;
		
    resetSelected();

    if (unhighlight) {
        setAllFilesUnselected();
    }
}

function licenseReminder()
{
     msgBox1 = document.getElementById("msg1");
        
     if (window.ActiveXObject !== undefined) 
     {
         windowWidth = document.body.clientWidth;
         windowHeight = document.body.clientHeight;
         yScrolled = document.body.scrollTop;
         xScrolled = document.body.scrollLeft;
     }
     else
     {
         windowWidth = window.innerWidth;
         windowHeight = window.innerHeight;
         yScrolled = window.pageYOffset;
         xScrolled = window.pageXOffset;
     }
        
     msgXpos = 30 + xScrolled;
        
     msgBox1.style.left = msgXpos + 'px';

     msgYpos = (windowHeight - 100) / 2 + yScrolled;
     if (msgYpos < 10)
     {
         msgYpos = 10;
     }

     msgBox1.style.top = msgYpos + 'px';
        
     msgBox1.style.visibility = "visible";
             
     msgBox1.innerHTML = 'This copy of WebFileSys has not been registered.<br><br>Register for free by sending an e-mail to the author!';
             
     setTimeout("hideMsgBox()", 10000);
}

function showMsgCentered(message, boxWidth, boxHeight, duration)
{
    var msgBox1 = document.getElementById("msg1");
      
    var windowWidth;
    var windowHeight;
    var yScrolled;
    var xScrolled;
        
    if (window.ActiveXObject !== undefined) 
    {
        windowWidth = document.body.clientWidth;
        windowHeight = document.body.clientHeight;
        yScrolled = document.body.scrollTop;
        xScrolled = document.body.scrollLeft;
    }
    else
    {
        windowWidth = window.innerWidth;
        windowHeight = window.innerHeight;
        yScrolled = window.pageYOffset;
        xScrolled = window.pageXOffset;
    }
        
    msgXpos = (windowWidth - boxWidth) / 2 + xScrolled;
       
    msgBox1.style.left = msgXpos + 'px';

    msgYpos = (windowHeight - boxHeight) / 2 + yScrolled;

    msgBox1.style.top = msgYpos + 'px';
        
    msgBox1.style.visibility = "visible";
             
    msgBox1.innerHTML = message;
             
    setTimeout("hideMsgBox()", duration);
}

function hideMsgBox()
{
     msgBox1 = document.getElementById("msg1");
     msgBox1.style.visibility = "hidden";
}

function checkFileNameSyntax(str)
{
    var prevIsDot = false;

    for (i = 0; i < str.length; i++) 
    {
        c = str.charAt(i);
       
        if ((c == '\'') || (c == '\"') || (c == '*') || (c == '/') || (c == '\\') ||
            (c == '%') || (c == ':') || (c == '+')  || (c == '#') || (c == ';') ||
            (c == ',') || (c == '�') || (c == '&') || (c == '?') || (c == '@'))
        {
            return(false);
        } 
        
        if (c == '.')
        {
            if (prevIsDot)
            {
                return false;
            }
            prevIsDot = true;
        }
        else
        {
            prevIsDot = false;
        }
    }

    return(true);
}

function validateNewFileName(oldFileName, errorMsg1, errorMsg2) {
    var newFileName = document.getElementById('renameForm').newFileName.value;

    if (newFileName == oldFileName) {
        alert(errorMsg1);
    } else {
        if (!checkFileNameSyntax(newFileName)) {
            alert(errorMsg2);
        } else {
            if (newFileName != '') {
                document.renameForm.submit();
            }
        }
    }
}

function validateNewFolderName(errorMsg) {
    var newDirName = document.mkdirForm.NewDirName.value;

    if (checkFileNameSyntax(newDirName)) {
        if (newDirName != '') {
            document.mkdirForm.submit();
        }
        return;
    }
    
    alert(errorMsg);

    document.mkdirForm.NewDirName.focus();

    document.mkdirForm.NewDirName.select();
}

function validateBookmarkName(errorMsg) {
    var bookmarkName = document.bookmarkForm.bookmarkName.value;

    if (bookmarkName != '') {
        var createBookmarkUrl = '/doxee-internal/servlet?command=createBookmark&path=' + encodeURIComponent(document.bookmarkForm.currentPath.value) + '&bookmarkName=' + encodeURIComponent(document.bookmarkForm.bookmarkName.value);
        xmlRequestSynchron(createBookmarkUrl);   
        hidePrompt();
        return;
    }
    
    alert(errorMsg);
    document.bookmarkForm.bookmarkName.focus();
    document.bookmarkForm.bookmarkName.select();
}

function validateCreateFileName(errorMsg) {
    var newFileName = document.mkfileForm.NewFileName.value;

    if (checkFileNameSyntax(newFileName)) {
        if (newFileName != '') {
            document.mkfileForm.submit();
        }
        return;
    }
    
    alert(errorMsg);
    document.mkfileForm.NewFileName.focus();
    document.mkfileForm.NewFileName.select();
}

function submitSwitchReadWrite()
{
    document.swtichReadWriteForm.submit();
}

function switchFolderWatch(path)
{
    var url = "/doxee-internal/servlet?command=switchFolderWatch&path=" + encodeURIComponent(path);
    
    xmlRequestSynchron(url);    
    
    hidePrompt();
}

function enableDisablePatternInput()
{
    var excludePattern = document.getElementById('excludePattern');
    if (!excludePattern)
    {
        return;
    }

    if (excludePattern.disabled)
    {
        excludePattern.disabled = false;
    }
    else
    {
        excludePattern.disabled = true;
    }
}

function bookmark(path)
{
    if (path && (path.length > 0))
    {
        showPrompt('/doxee-internal/servlet?command=addBookmark&path=' + encodeURIComponent(path), '/doxee-internal/xsl/addBookmark.xsl', 320, 190);
    }
    else
    {
        showPrompt('/doxee-internal/servlet?command=addBookmark', '/doxee-internal/xsl/addBookmark.xsl', 320, 190);
    }
    
    document.bookmarkForm.bookmarkName.focus();
    
    document.bookmarkForm.bookmarkName.select();
}

function hidePrompt() {
     var promptBox = document.getElementById("prompt");
     
     if (!promptBox) {
         return;
     }

     promptBox.style.visibility = "hidden";
     promptBox.style.width = "100px";
}

function showPrompt(xmlUrl, xslUrl, boxWidth, boxHeight) {
    var promptBox = document.getElementById("prompt");
        
    if (!promptBox) {
        alert('promptBox is not defined');
        return;
    }
        
    hideMenu();        
    
    var windowWidth = getWinWidth();
    var windowHeight = getWinHeight();
    
	var yScrolled;
	var xScrolled;
	
    if (browserMSIE) {
        yScrolled = (document.documentElement.scrollTop || document.body.scrollTop);
        xScrolled =(document.documentElement.scrollLeft || document.body.scrollLeft);
    } else {
        yScrolled = window.pageYOffset;
        xScrolled = window.pageXOffset;
        
        if (yScrolled > 0) {
            // scrollbar exists 
            windowWidth = windowWidth - 20;
        }
    }
        
    if (boxWidth) {
        if (boxWidth > windowWidth - 10) {
            boxWidth = windowWidth - 10;
        }
        promptBox.style.width = boxWidth + 'px';
    }

    if (boxHeight) {
        promptBox.style.height = boxHeight + 'px';
    }
        
    promptBoxWidth = promptBox.offsetWidth;
    
    xoffset = (windowWidth - promptBoxWidth) / 2;
    
    if (xoffset < 2) {
        xoffset = 2;
    }
        
    var promptXpos = xoffset + xScrolled;

    promptBox.style.left = promptXpos + 'px';

    if (!boxHeight) {
        boxHeight = 100;
    }

    var promptYpos = (windowHeight - boxHeight) / 2 + yScrolled;
    if (promptYpos < 10) {
        promptYpos = 10;
    }

    promptBox.style.top = promptYpos + 'px';
        
    promptBox.innerHTML = browserXslt(xmlUrl, xslUrl)

    promptBox.style.visibility = "visible";
}

function showPromptDialog(htmlFragmentURL, boxWidth, boxHeight) {
    var promptBox = document.getElementById("prompt");
        
    hideMenu();        
    
    if (!promptBox) {
        alert('promptBox is not defined');
        return;
    }
        
    var windowWidth = getWinWidth();
    var windowHeight = getWinHeight();
		
	var yScrolled;
	var xScrolled;
	
    if (browserMSIE) {
        yScrolled = (document.documentElement.scrollTop || document.body.scrollTop);
        xScrolled =(document.documentElement.scrollLeft || document.body.scrollLeft);
    } else {
        yScrolled = window.pageYOffset;
        xScrolled = window.pageXOffset;
        
        if (yScrolled > 0) {
            // scrollbar exists 
            windowWidth = windowWidth - 20;
        }
    }
        
    if (boxWidth) {
        promptBox.style.width = boxWidth + 'px';
    }

    if (boxHeight) {
        promptBox.style.height = boxHeight + 'px';
    }
        
    var promptBoxWidth = promptBox.offsetWidth;
    
    var xoffset = (windowWidth - promptBoxWidth) / 2;
	
    if (xoffset < 2) {
        xoffset = 2;
    }
        
    var promptXpos = xoffset + xScrolled;

    promptBox.style.left = promptXpos + 'px';

    if (!boxHeight) {
        boxHeight = 100;
    }

    promptYpos = (windowHeight - boxHeight) / 2 + yScrolled;
    if (promptYpos < 10) {
        promptYpos = 10;
    }

    promptBox.style.top = promptYpos + 'px';
        
    promptBox.innerHTML = xmlRequestSynchron(htmlFragmentURL, true);
        
    setBundleResources(promptBox);
        
    promptBox.style.visibility = "visible";

    return promptBox;
}

function renameLink(linkName)
{
	var promptDialog = showPromptDialog("/doxee-internal/html/renameLink.html", 360);	
	
	document.getElementById("oldLinkName").value = linkName;
	document.getElementById("oldLinkNameShort").innerHTML = shortText(linkName, 35);

	var newLinkName = document.getElementById("newLinkName");
	newLinkName.value = linkName;
	newLinkName.focus();
	newLinkName.select();
}

function validateNewLinkName() {
	var newLinkName = document.getElementById("newLinkName").value;
	
	if (trim(newLinkName).length == 0) {
		alert(resourceBundle["alert.newLinkNameEmpty"]);
		document.getElementById("newLinkName").focus()
		return;
	}
	
	var oldLinkName = document.getElementById("oldLinkName").value;
		
	if (oldLinkName == newLinkName) {
		alert(resourceBundle["alert.destEqualsSource"]);
		document.getElementById("newLinkName").focus()
		return;
	}
		
	if (!checkFileNameSyntax(newLinkName)) {
		alert(resourceBundle["alert.illegalCharInFilename"]);
		document.getElementById("newLinkName").focus()
		return;
	}
	
	document.getElementById("renameLinkForm").submit();
}

function validateEmail(elementValue) {      
   var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
   
   return emailPattern.test(elementValue); 
}

function validateEmailList(addressList) {
    var addressArr = addressList.split(",");
    
    for (var i = 0; i < addressArr.length; i++) {
        if (!validateEmail(addressArr[i])) {
            return false;
        }
    }
    
    return true;
}

