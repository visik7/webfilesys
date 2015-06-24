<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
<xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8" 
    doctype-public="html" />

<xsl:strip-space elements="geoTag" />

<!-- root node-->
<xsl:template match="/">

<html style="height:100%">
<head>

<meta http-equiv="expires" content="0" />

<link rel="stylesheet" type="text/css" href="/doxee-internal/styles/common.css" />

<link rel="stylesheet" type="text/css">
  <xsl:attribute name="href">/doxee-internal/styles/skins/<xsl:value-of select="/geoTag/css" />.css</xsl:attribute>
</link>
  
<title>
  <xsl:value-of select="/geoTag/shortPath" />
</title>

<script type="text/javascript" src="/doxee-internal/javascript/geoMap.js"></script>

<script language="javascript">
  
    function handleGoogleMapsApiReady()
    {
        var latitude = '<xsl:value-of select="/geoTag/latitude" />';
        var longitude = '<xsl:value-of select="/geoTag/longitude" />';
        var zoomFactor = <xsl:value-of select="/geoTag/zoomFactor" />;

        var infoText = '<xsl:value-of select="/geoTag/infoText" />';
  
        var mapCenter = new google.maps.LatLng(latitude, longitude);
    
        var myOptions = {
            zoom: zoomFactor,
            center: mapCenter,
            mapTypeId: google.maps.MapTypeId.HYBRID
        }
      
        var map = new google.maps.Map(document.getElementById("map"), myOptions);      
    
        var marker = new google.maps.Marker({
            position: mapCenter,
        });

        marker.setMap(map);    
    
        if (infoText != '')
        {
            var infowindow = new google.maps.InfoWindow({
                content: '<div style="width:160px;height:30px;overflow-x:auto;overflow-y:auto">' + infoText + '</div>'
            });

            infowindow.open(map, marker);
        }    
    }  
    
    function loadGoogleMapsAPIScriptCode() {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = "http://maps.google.com/maps/api/js?sensor=false&amp;callback=handleGoogleMapsApiReady";
        document.body.appendChild(script);
    }
    
</script>

</head>

<body onload="loadGoogleMapsAPIScriptCode()" style="margin:0px;height:100%;">

  <div id="map" style="width:100%;height:100%;"></div>

</body>

</html>

</xsl:template>

</xsl:stylesheet>
