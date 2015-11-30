



<!-- initilize layers //-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Demonstration of rollover menus</title>

<STYLE TYPE="text/css"> 
 
 <cfloop from="1" to="#Attributes.menus#" index="i">
 	#menu<cfoutput>#i#</cfoutput> {position:absolute; left: 0; top: 86; visibility: hidden; z-index:2;}
 </cfloop>
 
 td.test {font-family:verdana,helvetica,sans-serif;font-size:12px;color:white;text-align:top;white-space:nowrap}
 a.test {font-family:verdana,helvetica,sans-serif;font-size:12px;color:white;link:white}
 bodyCopy {  font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; color: #000000}
 .bodyCopy {  font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; color: #000000}
 .bodyCopyBold { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; color: #000000 ; font-weight: bold}
 
 </STYLE>

<!--- source http://www.brainjar.com/dhtml/dhtmllib.html --->
<script language="JavaScript" src="http://dev.vitalaging.com/js/_browserCheck.js"></script>
<script language="JavaScript" src="http://dev.vitalaging.com/js/dhtmllib.js"></script>
<script language="JavaScript" src="http://dev.vitalaging.com/js/dynlayer.js"></script>
<script language="JavaScript" src="http://dev.vitalaging.com/js/mouseevents.js"></script>
<script language="JavaScript" src="http://dev.vitalaging.com/js/drag.js"></script>

<script language="JavaScript">

function init() {
<cfloop from="1" to="#Attributes.menus#" index="i"><cfoutput>
	dynmenu#i# = new DynLayer("menu#i#");
	dynmenu#i#.dragActive = false;
</cfoutput></cfloop>

	initMouseEvents();

}
function hide_em() {
	if (dragging){
		return false;
		}	
		
<cfloop from="1" to="#Attributes.menus#" index="i"><cfoutput>
hide_layer('menu#i#');
</cfoutput></cfloop>

	}


function DynMouseMove(x,y) {
   dragging=0;
	status = "x:"+x+" y:"+y;
<cfoutput>
	menuTop=#Attributes.menuBarTop#;
	menuBottom=#Attributes.menuBarBottom#;
	menuLeft=#Attributes.menuBarLeft#;
	menuRight=#Attributes.menuBarRight#;
</cfoutput>
	
<cfloop from="1" to="#Attributes.menus#" index="i"><cfoutput>
	if (dynmenu#i#.dragActive) {
		dynmenu#i#.moveTo(x-dynmenu#i#.dragOffsetX,y-dynmenu#i#.dragOffsetY)
		dragging=1;
		return false;
		}	
</cfoutput></cfloop>
	if ((x < menuLeft || x > menuRight || y > menuBottom || y < menuTop) && dragging==0){
	//menu specific 

 <cfloop from="1" to="#Attributes.menus#" index="i"><cfoutput>
   var menu#i# = getLayer('menu#i#');
	if (getVisibility(menu#i#)=='visible'){
		Top=getTop(menu#i#);
		Left=getLeft(menu#i#);
		Right=getRight(menu#i#);
		Bottom=getBottom(menu#i#);
	    <cfif #Attributes.rolloff#>
		if (x < Left || x > Right || y > Bottom || y < Top){
			hideLayer(menu#i#);	
			}
		</cfif>
		}
 </cfoutput></cfloop>
		}
	return true;
}

<cfif #Attributes.drag#>
function DynMouseDown(x,y) {
	//menu specific 

<cfloop from="1" to="#Attributes.menus#" index="i"><cfoutput>
   var menu#i# = getLayer('menu#i#');
	if (getVisibility(menu#i#)=='visible'){
		Top = dynmenu#i#.y;
		Left = dynmenu#i#.x;
		Bottom = dynmenu#i#.y + dynmenu#i#.h;
		Right =  dynmenu#i#.x + dynmenu#i#.w;
	    
		if (x < Left || x > Right || y > Bottom || y < Left){
			dynmenu#i#.dragOffsetX = x-Left
			dynmenu#i#.dragOffsetY = y-Top
			dynmenu#i#.dragActive = true
			}
		}
</cfoutput></cfloop>

	return true;
}
function DynMouseUp(x,y) {
	//menu specific 
	
<cfloop from="1" to="#Attributes.menus#" index="i"><cfoutput>
	dynmenu#i#.dragActive = false;
</cfoutput></cfloop>

	return true;
}
</cfif>
</script>
</head>
