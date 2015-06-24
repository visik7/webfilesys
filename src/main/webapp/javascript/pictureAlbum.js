function albumImg(imgName, fromStory) 
{
    var url = '/doxee-internal/servlet?command=bookPicture&imgName=' + encodeURIComponent(imgName) + '&windowWidth=' + getWinWidth() + '&windowHeight=' + getWinHeight();
    if (fromStory) 
    {
        url = url + "&fromStory=true";
    }
    window.location.href = url;
}

function albumLinkedImg(realPath)
{
    window.location.href = '/doxee-internal/servlet?command=bookPicture&realPath=' + encodeURIComponent(realPath) + '&windowWidth=' + getWinWidth() + '&windowHeight=' + getWinHeight();
}

function jsComments(path)
{
    var commentWin = window.open("/doxee-internal/servlet?command=listComments&actPath=" + encodeURIComponent(path),"commentWin","status=no,toolbar=no,location=no,menu=no,scrollbars=yes,width=550,height=400,resizable=yes,left=80,top=100,screenX=80,screenY=100");
    commentWin.focus();
}
    