function formatDecimalNumber(nStr)
{
  nStr += '';
  x = nStr.split('.');
  x1 = x[0];
  x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1))
  {
      x1 = x1.replace(rgx, '$1' + '.' + '$2');
  }
  return x1 + x2;
}

function getWinHeight() 
{
    var h;
    if (window.innerWidth) 
    {
        h = window.innerHeight; 
    } 
    else if (document.body)
    {
        h = document.body.clientHeight;
        if ((document.body.offsetHeight == h) && document.documentElement && document.documentElement.clientHeight)
        {
            h = document.documentElement.clientHeight;
        }
    }
    return h;
}    
  
function getWinWidth() 
{
    var w;
    if (window.innerWidth) 
    {
        w = window.innerWidth; 
    } 
    else if (document.body)
    {
        w = document.body.clientWidth;
        if ((document.body.offsetWidth == w) && document.documentElement && document.documentElement.clientWidth)
        {
            w = document.documentElement.clientWidth;
        }
    }
    return w;
}  

/*
  Places a box centered vertically and horizontally on the browser window.
  @param box a DOM element of type div
*/
function centerBox(box)
{
    box.style.visibility = "hidden";

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
        
        if (yScrolled > 0)
        {
            // scrollbar exists 
            windowWidth = windowWidth - 20;
        }
    }
        
    boxWidth = box.offsetWidth;
    
    xoffset = (windowWidth - boxWidth) / 2;
    
    if (xoffset < 2)
    {
        xoffset = 2;
    }
        
    xpos = xoffset + xScrolled;

    box.style.left = xpos + 'px';

    boxHeight = box.offsetHeight;

    ypos = (windowHeight - boxHeight) / 2 + yScrolled;
    if (ypos < 2)
    {
        ypos = 2;
    }

    box.style.top = ypos + 'px';

    box.style.visibility = "visible";
}
  
function removeAllChildNodes(parentElementId)
{
	var parentNode = document.getElementById(parentElementId);

	if (parentNode && parentNode.hasChildNodes())
	{
	    while (parentNode.childNodes.length >= 1)
	    {
	    	parentNode.removeChild(parentNode.firstChild);       
	    } 
	}
}

function shortText(origText, maxLength)
{
	if (origText.length <= maxLength)
	{
		return origText;
	}
	
	return (origText.substring(0, maxLength - 4) + " ...");
}

function getFileNameExt(fileName)
{
    fileExt="";

    extStart=fileName.lastIndexOf('.');

    if (extStart > 0)
    {
	fileExt=fileName.substring(extStart).toUpperCase();
    }
    
    return(fileExt);
}

function insertDoubleBackslash(source)
{
    return(source.replace(/\\/g,"\\\\"));
}

function trim(str) 
{
    return str.replace (/^\s+/, '').replace (/\s+$/, '');
}

function getAbsolutePos(obj) {
	var curleft = 0;
	var curtop = 0;
	if (obj.offsetParent) {
		do {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		} while (obj = obj.offsetParent);			
	}
	return [curleft, curtop];
}

function removeCSSRecursive(domNode, cssClassName)
{
    if (domNode.nodeType != 1) 
	{
	    return;
	}

    var cssValue = domNode.getAttribute("class");
	if (cssValue)
	{
	    var newCssValue = cssValue.replace(cssClassName, "");
		if (newCssValue != cssValue) 
		{
		    domNode.setAttribute("class", newCssValue);
		}
    }

	var children = domNode.childNodes;
	if (children) 
	{
	    for (var i = 0; i < children.length; i++) 
		{
		    removeCSSRecursive(children.item(i), cssClassName);
		}
	}
}

function validateEmail(emailAddress) {  
    return (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(emailAddress));
}

function toast(message, duration) {
   	toastBox = document.createElement("div");
   	toastBox.id = "toastBox";
   	toastBox.setAttribute("class", "toastBox");
   	document.documentElement.appendChild(toastBox);
   	
   	toastBox.style.top = (getWinHeight() / 2 - 75) + "px";
   	toastBox.style.left = (getWinWidth() / 2 - 125) + "px";

   	toastText = document.createElement("span");
   	toastText.innerHTML = message;
   	toastBox.appendChild(toastText);
   	
   	setTimeout(hideToast, duration);
}

function hideToast() {
	var toastBox = document.getElementById("toastBox");
	document.documentElement.removeChild(toastBox);
}