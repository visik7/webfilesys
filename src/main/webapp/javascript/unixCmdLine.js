function submitCmd()
{
    var ajaxUrl = '/doxee-internal/servlet';

    xmlRequestPost(ajaxUrl, getFormData(document.form1), showCmdOutput);
}

function showCmdOutput()
{
    if (req.readyState == 4)
    {
        if (req.status == 200)
        {
            var item = req.responseXML.getElementsByTagName("cmdOutput")[0];            
            var stdout = item.firstChild.nodeValue;
             
            var cmdOutDiv = document.getElementById('cmdOutput');
            cmdOutDiv.innerHTML = '<pre>' + stdout + '</pre>';
        }
    }
}