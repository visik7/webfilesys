       var svgNS = "http://www.w3.org/2000/svg";	

	   var centerX = 390;
	   var centerY = 335;
	
	   var chartColors = ["#f44", "#4f4", "#66f", "#f4f", "#4ff", "#ff4", "#ffaa00", "#00ffaa", "#aa00ff", "#aaff00", "#00aaff", "#ff00aa", "#ffccaa", "#aaffcc", "#ccaaff" , "#aaccff", "#ffaacc", "#ccffaa"];

	   var ROOT_FILES_COLOR = "#b0b0b0";
	   
	   function showTitle(titleText, sectorColor)
	   {
	       var titleBox = document.getElementById("titleBox");
		   if (!titleBox)
		   {
		       return;
		   }
		   titleBox.innerHTML = titleText;
           titleBox.style.backgroundColor = sectorColor;
	       titleBox.style.visibility = "visible";
	   }
	   
	   function hideTitleText()
	   {
	       var titleBox = document.getElementById("titleBox");
		   if (!titleBox)
		   {
		       return;
		   }
	       titleBox.style.visibility = "hidden";
	   }

	   function pieChartSector(startAngle, endAngle, sectorColor, chartRadius, titleText, path) 
	   {
		   if (endAngle - startAngle > 180)
		   {
			   pieChartSectorInternal(startAngle, startAngle + 180, sectorColor, chartRadius, titleText, path, 1);
			   pieChartSectorInternal(startAngle + 180, endAngle, sectorColor, chartRadius, titleText, path, 2);
		   }
		   else 
		   {
			   pieChartSectorInternal(startAngle, endAngle, sectorColor, chartRadius, titleText, path);
		   }
	   }
	   
	   function pieChartSectorInternal(startAngle, endAngle, sectorColor, chartRadius, titleText, path, splitPart) 
	   {
	       var startRadiant = startAngle * Math.PI / 180;
	       var endRadiant = endAngle * Math.PI / 180;
	   
           var startX = centerX + (Math.cos(startRadiant) * chartRadius);
		   var startY = centerY + (Math.sin(startRadiant) * chartRadius);
		   var endX = centerX + (Math.cos(endRadiant) * chartRadius);
		   var endY = centerY + (Math.sin(endRadiant) * chartRadius);
		   
		   var largeArcFlag = 0;
		   if (endAngle - startAngle > 180) 
		   {
		       largeArcFlag = 1;
		   }
		   
		   var pathData;
		   
		   pathData = "M " + centerX + "," + centerY;

		   if ((!splitPart) || (splitPart == 1))
		   {
			   pathData = pathData + " L " + startX + "," + startY;
		   }
		   else
		   {
			   pathData = pathData + " M " + startX + "," + startY;
		   }

		   pathData = pathData + " A " + chartRadius + " " + chartRadius + " 0 " + largeArcFlag + ",1 " + endX + "," + endY;
		   
		   if (!splitPart)
		   {
			   pathData = pathData + " Z";
		   }
		   else if (splitPart == 1)
		   {
			   pathData = pathData + " M " + centerX + "," + centerY
		   }
		   else if (splitPart == 2)
		   {
			   pathData = pathData + " L " + centerX + "," + centerY
		   }
		   
    	   var pathElem = document.createElementNS(svgNS, "path");
		   pathElem.setAttribute("d", pathData);
		   pathElem.setAttribute("stroke", "black");
		   pathElem.setAttribute("style", "fill: " + sectorColor + ";cursor:pointer");
		   
           pathElem.addEventListener("mouseover", 
		       function () {
                   showTitle(titleText, sectorColor);
               }, false);

           if (path && path.length > 0)
           {
               pathElem.addEventListener("click",
            	   function () {
                       window.location.href = "/webfilesys/servlet?command=folderTreeStats&path=" + encodeURIComponent(path) + "&random=" + (new Date()).getTime();
                   }, false);
           }
           
		   pathElem.addEventListener("mouseout", hideTitleText);

		   document.getElementById("svgChart").appendChild(pathElem);
	   }
	   
	   function shellSector(startAngle, endAngle, sectorColor, innerRadius, outerRadius, titleText)
	   {
		   if (endAngle - startAngle > 180)
		   {
			   shellSectorInternal(startAngle, startAngle + 180, sectorColor, innerRadius, outerRadius, titleText, 1);
			   shellSectorInternal(startAngle + 180, endAngle, sectorColor, innerRadius, outerRadius, titleText, 2);
		   }
		   else 
		   {
			   shellSectorInternal(startAngle, endAngle, sectorColor, innerRadius, outerRadius, titleText);
		   }
	   }

	   function shellSectorInternal(startAngle, endAngle, sectorColor, innerRadius, outerRadius, titleText, splitPart)
	   {
	       var startRadiant = startAngle * Math.PI / 180;
	       var endRadiant = endAngle * Math.PI / 180;

           var innerStartX = centerX + (Math.cos(startRadiant) * innerRadius);
		   var innerStartY = centerY + (Math.sin(startRadiant) * innerRadius);
		   var innerEndX = centerX + (Math.cos(endRadiant) * innerRadius);
		   var innerEndY = centerY + (Math.sin(endRadiant) * innerRadius);

           var outerStartX = centerX + (Math.cos(startRadiant) * outerRadius);
		   var outerStartY = centerY + (Math.sin(startRadiant) * outerRadius);
		   var outerEndX = centerX + (Math.cos(endRadiant) * outerRadius);
		   var outerEndY = centerY + (Math.sin(endRadiant) * outerRadius);

		   var largeArcFlag = 0;
		   if (endAngle - startAngle > 180) 
		   {
		       largeArcFlag = 1;
		   }
		   
		   var pathData = "M " + innerStartX + "," + innerStartY + " A " + innerRadius + " " + innerRadius + " 0 " + largeArcFlag + ",1 " + innerEndX + "," + innerEndY;
           
		   if (splitPart && (splitPart == 1))
		   {
			   pathData = pathData + " M " + outerEndX + "," + outerEndY;
		   }
		   else
		   {
			   pathData = pathData + " L " + outerEndX + "," + outerEndY;
		   }
		   
		   pathData = pathData + " A " + outerRadius + " " + outerRadius + " 0 " + largeArcFlag + ",0 " + outerStartX + "," + outerStartY;
		   
		   if (!splitPart)
		   {
			   pathData = pathData + " Z";
		   }
		   else if (splitPart == 1)
		   {
			   pathData = pathData + " L " + innerStartX + "," + innerStartY
		   }

    	   var pathElem = document.createElementNS(svgNS, "path");
		   pathElem.setAttribute("d", pathData);
		   pathElem.setAttribute("stroke", "black");
		   pathElem.setAttribute("style", "fill: " + sectorColor);
		   
           pathElem.addEventListener("mouseover", 
		       function () {
                   showTitle(titleText, sectorColor);
               }, false);
			   
		   pathElem.addEventListener("mouseout", hideTitleText);

		   document.getElementById("svgChart").appendChild(pathElem);
	   }
	   
	   function testSunBurstChart()
	   {
  	       pieChartSector(0, 30, "#f00", 100, "red"); 
	       pieChartSector(30, 60, "#0f0", 100, "green"); 
	       pieChartSector(60, 90, "#00f", 100, "blue"); 
	       pieChartSector(90, 160, "#f0f", 100, "magenta"); 
	       pieChartSector(160, 235, "#0ff", 100, "cyan"); 
	       pieChartSector(235, 270, "#ff0", 100, "yellow"); 
	       pieChartSector(270, 360, "#a0a0a0", 100, "gray"); 
	   
	       shellSector(0, 30, "#f00", 100, 150, "red"); 
	       shellSector(30, 60, "#0f0", 100, 150, "green"); 
	       shellSector(60, 90, "#00f", 100, 150, "blue"); 
	       shellSector(100, 110, "#f0f", 100, 150, "magenta1"); 
	       shellSector(130, 155, "#f0f", 100, 150, "magenta2"); 
	       shellSector(160, 235, "#0ff", 100, 150, "cyan"); 
	       shellSector(235, 270, "#ff0", 100, 150, "yellow"); 
	       shellSector(290, 310, "#a0a0a0", 100, 150, "gray"); 
	       shellSector(330, 345, "#a0a0a0", 100, 150, "gray"); 
	   }