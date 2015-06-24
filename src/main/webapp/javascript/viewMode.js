function viewModeList()
{
    window.location.href='/doxee-internal/servlet?command=listFiles&viewMode=1';
}

function viewModeThumbs()
{
    window.location.href='/doxee-internal/servlet?command=thumbnail&initial=true&zoom=no&random=' + new Date().getTime() + '&screenWidth=' + screen.width + '&screenHeight=' + screen.height;
}

function viewModeAlbum()
{
    window.location.href='/doxee-internal/servlet?command=album&initial=true&random=' + new Date().getTime() + '&screenWidth=' + screen.width + '&screenHeight=' + screen.height;
}

function viewModeStory()
{
    window.location.href='/doxee-internal/servlet?command=storyInFrame&random=' + new Date().getTime() + '&screenWidth=' + screen.width + '&screenHeight=' + screen.height;
}

function viewModeSlideshow()
{
    window.location.href='/doxee-internal/servlet?command=slideShowInFrame&windowWidth=' + getWinWidth() + '&windowHeight=' + getWinHeight() + '&screenWidth=' + screen.width + '&screenHeight=' + screen.height + '&random=' + new Date().getTime();
}

function fileStats()
{
    window.location.href='/doxee-internal/servlet?command=fileStats&initial=true&random=' + new Date().getTime();
}

function viewModePictureBook()
{
    window.location.href='/doxee-internal/servlet?command=storyInFrame&mode=pictureBook&initial=true&random=' + new Date().getTime() + '&screenWidth=' + screen.width + '&screenHeight=' + screen.height;
}

function viewModeAlbumSlideshow()
{
    window.location.href='/doxee-internal/servlet?command=albumSlideShow&windowWidth=' + getWinWidth() + '&windowHeight=' + getWinHeight() + '&screenWidth=' + screen.width + '&screenHeight=' + screen.height + '&random=' + new Date().getTime();
}
