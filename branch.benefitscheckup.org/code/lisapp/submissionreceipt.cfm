<!---
Template Name: submissionreceipt.cfm 
Component Purpose: This file contains informational content for lisapp submission and receipt of the data by ssa
Data Tables: screening_submission , screening
--->

  <style type="text/css" media="screen">

        a:visited 

{

	color: #00018C;

}



a:hover 

{

	color: #C60000;

	text-decoration: underline;

}



a:active 

{

	color: #FF0000;

	text-decoration: underline;

}



a.bar 

{

	background: #333366;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 12px;

	font-weight: bold;

	line-height: normal;

	text-align: left;

	text-decoration: none;

	vertical-align: baseline;

}



a.bar:visited 

{

	background: #333366;

	color: #FFFFFF;

	font-weight: bold;

}



a.bar:hover 

{

	background: #333366;

	color: #FFFFAA;

	font-weight: bold;

	text-decoration: underline;

}



a.bar:active 

{

	color: #FFFF80;

	font-weight: bold;

	text-decoration: underline;

}



a.bluebar 

{

	background: #333366;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 90%;

	font-weight: bold;

	line-height: normal;

	text-align: left;

	text-decoration: none;

	vertical-align: baseline;

}



a.bluebar:visited 

{

	background: #333366;

	color: #FFFFFF;

	font-weight: bold;

}



a.bluebar:hover 

{

	background: #333366;

	color: #FFFFAA;

	font-weight: bold;

	text-decoration: underline;

}



a.bluebar:active 

{

	color: #FFFF80;

	font-weight: bold;

	text-decoration: underline;

}



a.blueskipnav 

{

	color: #333366;

	font-size: 1%;

}



a.blueskipnav:visited 

{

	color: #333366;

	font-size: 1%;

}



a.blueskipnav:hover 

{

	color: #FFFFAA;

	font-size: 80%;

}



a.blueskipnav:active 

{

	color: #FFFFAA;

	font-size: 80%;

}



a.grayskipnav 

{

	color: #EEEEEE;

	font-size: 1%;

}



a.grayskipnav:visited 

{

	color: #EEEEEE;

	font-size: 1%;

}



a.grayskipnav:hover 

{

	color: #0000FF;

	font-size: 80%;

	text-decoration: underline;

}



a.grayskipnav:active

{

	color: #0000FF;

	font-size: 80%;

}



a.redskipnav

{

 	font-family: sans-serif;

	color: #CC3333;

	font-size: 1%;

}



a.redskipnav:visited

{

	color: #CC3333;

	font-size: 1%;

}



a.redskipnav:hover

{

	color: #FFFFAA;

	font-size: 80%;

}



a.redskipnav:active

{

	color: #FFFFAA;

	font-size: 80%;

}



a.whiteskipnav

{

	color: #FFFFFF;

	font-size: 1%;

}



a.whiteskipnav:visited

{

	color: #FFFFFF;

	font-size: 1%;

}



a.whiteskipnav:hover

{

	color: #0000FF;

	font-size: 80%;

	text-decoration: underline;

}



a.whiteskipnav:active

{

	color: #0000FF;

	font-size: 80%;

}



body 

{

	background-color: #FFFFFF;

	color: #000000;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 100%;

}



h1 

{

	font-size: 130%;

	line-height: normal;

	margin-bottom: 2px;

	margin-top: 2px;

}



h2 

{

	font-size: 115%;

	font-weight: normal;

	margin-bottom: 2px;

	margin-top: 2px;

}



h3 

{

	font-size: 105%;

	font-weight: bold;

	margin-bottom: 2px;

	margin-top: 2px;

}



h4 

{

	font-size: 100%;

	font-style: italic;

	font-weight: normal;

	margin-bottom: 2px;

}



hr.gray-hr 

{

	color: #EEEEEE;

	height: 2px;

	margin-bottom: 0px;

}



td 

{

	font-family: Arial, Helvetica, sans-serif;

	vertical-align: top;

}



.blackborder-td 

{

	border: 1px #000000 solid;

}



.blueborder-td 

{

	border: 1px #333366 solid;

}



.blueruled2-td 

{

	border-bottom: 2px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.blueruled-td {

	border-bottom: 1px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.eightypercent {

	font-size: 80%;

}



.fiftypercent {

	font-size: 50%;

}



.fortypercent {

	font-size: 40%;

}



.grayborder-td {

	border: 1px #EEEEEE solid;

}



.graycellblueruled2-td {

	background-color: #EEEEEE;

	border-bottom: 2px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.graycellblueruled-td {

	background-color: #EEEEEE;

	border-bottom: 1px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.graycellredruled2-td {

	background-color: #EEEEEE;

	border-bottom: 2px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.graycellredruled-td {

	background-color: #EEEEEE;

	border-bottom: 1px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.grayruled2-td {

	border-bottom: 2px none #EEEEEE;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.grayruled3-td {

	border-bottom: 3px none #EEEEEE;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.grayruled-td {

	border-bottom: 1px none #EEEEEE;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.greycell {

	background-color: #EEEEEE;

}



.hundredfiveypercent {

	font-size: 105%;

}



.linkbar {

	background-color: #333366;

	color: #FFFFFF;

	vertical-align: middle;

}



.linkbarsmall {

	background-color: #333366;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 12px;

	font-weight: normal;

	margin-top: 0px;

	padding-top: 0px;

	vertical-align: top;

}



.ninetypercent {

	font-size: 90%;

}



.pagebar {

	background-color: #CC3333;

	vertical-align: bottom;

}



.redborder-td {

	border: 1px #CC3333 solid;

}



.redruled2-td {

	border-bottom: 2px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.redruled-td {

	border-bottom: 1px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.seventypercent {

	font-size: 70%;

}



.sixtypercent {

	font-size: 60%;

}



.sstop {

	background-color: #CC3333;

	color: #FFFFFF;

	font-family: Georgia, "Times New Roman", Times, serif;

	font-size: 18px;

	letter-spacing: -1px;

	padding-bottom: 1px;

	vertical-align: bottom;

}



.titletext {

	background:url(../images/redstarback.gif) #CC3333;

	color: #FFFFFF;

	font-family: Georgia, "Times New Roman", Times, serif;

	font-size: 32px;

	font-weight: normal;

	letter-spacing: -1px;

	vertical-align: bottom;	

}



.whiteruled2-td {

	background-color: #EEEEEE;

	border-bottom: 2px none #FFFFFF;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.whiteruled-td {

	background-color: #EEEEEE;

	border-bottom: 1px none #FFFFFF;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}





    </style>

    <style type="text/css" media="print">

        a:visited {

	color: #00018C;

}



a:hover {

	color: #C60000;

	text-decoration: underline;

}



a:active {

	color: #FF0000;

	text-decoration: underline;

}



a.bar {

	background: #333366;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 12px;

	font-weight: bold;

	line-height: normal;

	text-align: left;

	text-decoration: none;

	vertical-align: baseline;

}



a.bar:visited {

	background: #333366;

	color: #FFFFFF;

	font-weight: bold;

}



a.bar:hover {

	background: #333366;

	color: #FFFFAA;

	font-weight: bold;

	text-decoration: underline;

}



a.bar:active {

	color: #FFFF80;

	font-weight: bold;

	text-decoration: underline;

}



a.bluebar {

	background: #333366;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 90%;

	font-weight: bold;

	line-height: normal;

	text-align: left;

	text-decoration: none;

	vertical-align: baseline;

}



a.bluebar:visited {

	background: #333366;

	color: #FFFFFF;

	font-weight: bold;

}



a.bluebar:hover {

	background: #333366;

	color: #FFFFAA;

	font-weight: bold;

	text-decoration: underline;

}



a.bluebar:active {

	color: #FFFF80;

	font-weight: bold;

	text-decoration: underline;

}



a.blueskipnav{

	color: #333366;

	font-size: 1%;

}



a.blueskipnav:visited{

	color: #333366;

	font-size: 1%;

}



a.blueskipnav:hover{

	color: #FFFFAA;

	font-size: 80%;

}



a.blueskipnav:active{

	color: #FFFFAA;

	font-size: 80%;

}



a.grayskipnav{

	color: #EEEEEE;

	font-size: 1%;

}



a.grayskipnav:visited{

	color: #EEEEEE;

	font-size: 1%;

}



a.grayskipnav:hover{

	color: #0000FF;

	font-size: 80%;

	text-decoration: underline;

}



a.grayskipnav:active{

	color: #0000FF;

	font-size: 80%;

}



a.redskipnav{

 	font-family: sans-serif;

	color: #CC3333;

	font-size: 1%;

	font-family: sans-serif;

}



a.redskipnav:visited{

	color: #CC3333;

	font-size: 1%;

}



a.redskipnav:hover{

	color: #FFFFAA;

	font-size: 80%;

	font-family: sans-serif;

}



a.redskipnav:active{

	color: #FFFFAA;

	font-size: 80%;

	font-family: sans-serif;

}



a.whiteskipnav{

	color: #FFFFFF;

	font-size: 1%;

}



a.whiteskipnav:visited{

	color: #FFFFFF;

	font-size: 1%;

}



a.whiteskipnav:hover{

	color: #0000FF;

	font-size: 80%;

	text-decoration: underline;

}



a.whiteskipnav:active{

	color: #0000FF;

	font-size: 80%;

}



body {

	background-color: #FFFFFF;

	color: #000000;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 100%;

}



h1 {

	font-family: Arial, Helvetica, sans-serif;

	font-size: 130%;

	line-height: normal;

	margin-bottom: 2px;

	margin-top: 2px;

}



h2 {

	font-family: Arial, Helvetica, sans-serif;

	font-size: 115%;

	font-weight: normal;

	margin-bottom: 2px;

	margin-top: 2px;

}



h3 {

	font-size: 105%;

	font-weight: bold;

	margin-bottom: 2px;

	margin-top: 2px;

}



h4 {

	font-size: 100%;

	font-style: italic;

	font-weight: normal;

	margin-bottom: 2px;

}



hr.gray-hr {

	color: #EEEEEE;

	height: 2px;

	margin-bottom: 0px;

}



td {

	font-family: Arial, Helvetica, sans-serif;

	vertical-align: top;

}



.blackborder-td {

	border: 1px #000000 solid;

}



.blueborder-td {

	border: 1px #333366 solid;

}



.blueruled2-td {

	border-bottom: 2px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.blueruled-td {

	border-bottom: 1px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.eightypercent {

	font-size: 80%;

}



.fiftypercent {

	font-size: 50%;

}



.fortypercent {

	font-size: 40%;

}



.grayborder-td {

	border: 1px #EEEEEE solid;

}



.graycellblueruled2-td {

	background-color: #EEEEEE;

	border-bottom: 2px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.graycellblueruled-td {

	background-color: #EEEEEE;

	border-bottom: 1px none #333366;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.graycellredruled2-td {

	background-color: #EEEEEE;

	border-bottom: 2px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.graycellredruled-td {

	background-color: #EEEEEE;

	border-bottom: 1px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.grayruled2-td {

	border-bottom: 2px none #EEEEEE;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.grayruled3-td {

	border-bottom: 3px none #EEEEEE;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.grayruled-td {

	border-bottom: 1px none #EEEEEE;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.greycell {

	background-color: #EEEEEE;

}



.hundredfiveypercent {

	font-size: 105%;

}



.linkbar {

	background-color: #333366;

	color: #FFFFFF;

	vertical-align: middle;

}



.linkbarsmall {

	background-color: #333366;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 12px;

	font-weight: normal;

	margin-top: 0px;

	padding-top: 0px;

	vertical-align: top;

}



.ninetypercent {

	font-size: 90%;

}



.pagebar {

	background-color: #CC3333;

	vertical-align: bottom;

}



.redborder-td {

	border: 1px #CC3333 solid;

}



.redruled2-td {

	border-bottom: 2px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.redruled-td {

	border-bottom: 1px none #CC3333;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.seventypercent {

	font-size: 70%;

}



.sixtypercent {

	font-size: 60%;

}



.sstop {

	background-color: #CC3333;

	color: #FFFFFF;

	font-family: Georgia, "Times New Roman", Times, serif;

	font-size: 18px;

	letter-spacing: -1px;

	padding-bottom: 1px;

	vertical-align: bottom;

}



.titletext {

	background:url(../images/redstarback.gif) #CC3333;

	color: #FFFFFF;

	font-family: Georgia, "Times New Roman", Times, serif;

	font-size: 32px;

	font-weight: normal;

	letter-spacing: -1px;

	vertical-align: bottom;	

}



.whiteruled2-td {

	background-color: #EEEEEE;

	border-bottom: 2px none #FFFFFF;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}



.whiteruled-td {

	background-color: #EEEEEE;

	border-bottom: 1px none #FFFFFF;

	border-left: 0px;

	border-right: 0px;

	border-style: solid;

	border-top: 0px;

}

.printhide {

	display: none;

}





    </style>

    <style type="text/css" media="all">

        /* Social Security Administration              */

/* Generic Internet Style Sheet                */

/* Compatible with all CSS-enabled user agents */

/* ----- XHTML Elements ----- */



a.bar:active {

	color: #FFFF80;

	font-weight: bold;

	text-decoration: underline;

}



a.errorlink {

	background: #FFFFFF;

	color: #CC3333;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 80%;

	font-weight: bold;

	line-height: normal;

	text-align: left;

	text-decoration: underline;

	vertical-align: baseline;

}



a.errorlink:visited {

	background: #FFFFFF;

	color: #CC3333;

	font-weight: bold;

}



a.errorlink:hover {

	background: #FFFFAA;

	color: #CC3333;

	font-weight: bold;

	text-decoration: underline;

}



a.menu{

	background-color: #333366;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 10px;

	text-align: center;

	text-decoration: none;

	vertical-align: middle;

	width: 100%;

}



a.menu:link {

	background: #333366;

	border: 3px outset;

	color: #FFFFFF;

	font-family: Verdana, Arial, Helvetica, sans-serif;

	font-size: 9px;

	font-weight: bold;

	text-decoration: none;

}



a.menu:visited {

	font-family: Verdana, Arial, Helvetica, sans-serif;

	background: #333366;

	border: 3px outset;

	color: #FFFFFF;

	font-size: 9px;

	font-weight: bold;

	text-decoration: none;

}



a.menu:hover {

	font-family: Verdana, Arial, Helvetica, sans-serif;

	background: #000000;

	border: 3px inset;

	border-color: #D7D7FF #CCCCFF #CCCCFF;

	color: #FFFFCC;

	font-size: 9px;

	font-weight: bold;

	text-decoration: none;

}



a.menu:active {

	font-family: Verdana, Arial, Helvetica, sans-serif;

	background: #333366;

	border: 3px outset;

	border-color: #D8CAFF #CCCCFF #CCCCFF;

	color: #FFFFFF;

	font-size: 9px;

	font-weight: bold;

	text-decoration: none;

}



a.navbar {

	color: #FFFFFF;

	font-family: Verdana, Arial, Helvetica, sans-serif;

	font-size: 9px;

	font-weight: bold;

	text-decoration: none;

}



a.navbar:link {

	color: #FFFFFF;

	font-family: Verdana, Arial, Helvetica, sans-serif;

	font-size: 9px;

	font-weight: bold;

}



a.navbar:visited {

	color: #FFFFFF;

	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;

	font-weight: bold;

}



a.navbar:hover {

	color: #FFFFFF;

	font-family: Verdana, Arial, Helvetica, sans-serif;

	font-size: 9px;

	font-weight: bold;

	text-decoration: underline;

}



a.navbar:active {

	color: #FFFF80;

	font-family: Verdana, Arial, Helvetica, sans-serif;

	font-size: 9px;

	font-weight: bold;

	text-decoration: underline;

}



a.skipnav {

	color: #CC3333;

	cursor: crosshair;

	font-size: .1em;

	text-decoration: none;

}



a.skipnav:hover {

	border: none;

	color: #FFFFFF;

	cursor: crosshair;

	font-size: 14px;

	text-decoration: none;

}



a.skipnav:active {

	border: none;

	color: #FFFFFF;

	cursor: crosshair;

	font-size: 14px;

	text-decoration: none;

}



body {

	background-attachment: scroll;

	

	background-repeat: no-repeat;

	color: #000000; /* Black */

	font-family: Arial, Helvetica, sans-serif;

	margin: 0px 0px 0px 0px;

}



input {

  font-family: Arial, Helvetica, sans-serif;

	color: #333333;

  font-weight: normal;

}



input.addanother {

	background-color: #CCCCCC;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 75%;

	font-weight: bold;

}



input.back {

	background: #CCCCCC;

	color: #333333;

	font-weight: normal;

}



input.continue {

	background: #CCCCCC;

	color: #333333;

	font-weight: bold;

}



input.delete {

  float: left;

}



input.edit {

	font-family: "Courier New", sans-serif;

}



input.editbutton {

	background: #CCCCCC;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 75%;

	font-weight: bold;

}



input.plain {

	background: #CCCCCC;

	color: #333333;

	font-weight: normal;

}



input.reset {

	background-color: #CCCCCC;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 75%;

	font-weight: bold;

}



input.topbar {

	background-color: #CCCCCC;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 10px;

	font-weight: bold;

	vertical-align: top;

}



input.topbaractive {

	background-color: #CC3333;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 10px;

	font-weight: bold;

}



select {

	font-family: "Courier New", sans-serif;

}



td.main{

	padding: 0px 0px 0px 0px;

	text-align: left;

}



td.nav{

	padding: 0px 0px 0px 0px;

}



textarea {

	font-family: "Courier New", sans-serif;

}



/* ----- Custom Classes ----- */

.activetab {

	background: #CC3333;

	border-bottom-color: #CC3333;

	border-left-color: #EEEEEE;

	border-right-color: #EEEEEE;

	border-style: solid solid solid solid;

	border-top-color: #EEEEEE;

	color: #FFFFFF;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 13px;

	font-style: normal;

	font-weight: bold;

	text-decoration: none;

	vertical-align: middle;

}



.alert {

	color: #CC3333;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 80%;

	font-weight: bold;

	text-align: left;

}



.critical {

	background-image: url(../images/warning.gif);

	background-repeat: no-repeat;

	padding-left: 55px;

	display : list-item;

	list-style-type : none;

	height: 42px;

  margin-bottom: 30px;

}



.grouplabel {

	border-bottom: 1px solid;

	display: block;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 100%;

	font-weight: bold;

	margin-top: 15px;

	text-align: left;

}



.headerfooter {

	font-family: Arial, Helvetica, sans-serif;

	font-size: 75%;

	font-weight: normal;

}



.hide {

	position: absolute;

  left: 0px;

  top: -100px;

  width: 0px;

  height: 0px;

  overflow: hidden;

}



.instructions {

	font-family: Arial, Helvetica, sans-serif;

	font-size: 90%;

	font-weight: normal;

}



.label {

	font-family: Arial, Helvetica, sans-serif;

	font-size: 100%;

	font-weight: bold;

	text-align: left;

}



.labelsmaller {

	font-family: Arial, Helvetica, sans-serif;

	font-size: 90%;

	font-weight: bold;

	text-align: left;

}



.labelsmaller2 {

	font-family: Verdana, Georgia, Arial, Helvetica, sans-serif;

	font-size: 90%;

	font-weight: normal;

	text-align: left;

}



.labelsmallerright {

	font-family: Arial, Helvetica, sans-serif;

	font-size: 90%;

	font-weight: bold;

	text-align: right;

}



.labelsmallerindent {

	FONT-FAMILY: Arial, Helvetica, sans-serif;

	FONT-SIZE: 90%;

	FONT-WEIGHT: bold;

	TEXT-INDENT: 15pt;

}



.noanchor {

	color: #000000;

	cursor: text;

	text-decoration: none;

}



.nonselectabletab {

	background: #999999;

	border-bottom-color: #999999;

	border-left-color: #EEEEEE;

	border-right-color: #EEEEEE;

	border-style: solid solid solid solid;

	border-top-color: #EEEEEE;

	color: #eeeeee;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 12px;

	font-style: normal;

	font-weight: bold;

	text-decoration: none;

	vertical-align: middle;

}



.pagetitlepreface {

	font-family: Arial, Helvetica, sans-serif;

	font-style: italic;

	font-weight: normal;

}



.propagated {

	background-color: #FBFBFB;

	border-style: none;

	font-family: "Times New Roman", Times, serif;

	font-weight: bold;

}



.propagatederror {

	color: #CC3333;

	font-family: Arial, Helvetica, sans-serif;

	font-size: 80%;

	font-weight: bold;

}



.pushedmenu {

	background: #FFFFFF;

	border: inset;

	border-color: #D7D7FF #CCCCFF #CCCCFF;

	border-width: 2px 2px 0px;

	color: #000000;

	font-family: Verdana, Arial, Helvetica, sans-serif;

	font-size: 9px;

	font-weight: bold;

	text-decoration: none;

}



.reentrynumber {

	background-color: #FBFBFB;

	font-family: Georgia,"Times New Roman", Times, serif;

	font-size: 200%;

	font-weight: bold;

	text-align: left;

}



.rowbackgrnd {

	background-color: #E4E4F2;

}



.rowbackgrnd2 {

	background-color: #EEEEEE;

}



.tabbackgrnd {

	background-color: #333366;

}



.warning {

	color: #000000;

	font-family: Verdana, Georgia, Arial, Helvetica, sans-serif;

	font-size: 90%;

	font-weight: bold;

	text-align: left;

}

.redasterisk { 

font-size: 110%; 

font-weight : bold; 

color: #cc3333; 

} 



    </style>

    <style type="text/css" media="all">

        /*******************************************************************/

/* Copyright (c) Social Security Administration.                   */

/* All rights reserved.                                            */

/*                                                                 */

/* This software is the confidential and proprietary information of*/

/* Social Security Administration. You shall use it only in        */

/* accordance with the terms of the license agreement you entered  */

/* into with Social Security Administration                        */

/*                                                                 */

/* This style sheet controls the unique page layout elements for   */

/* the i1020 application                                           */

/*******************************************************************/



body {

    width: 100%;

}



h1 {

    clear: none;

    display:inline;

}



h2 {

    clear: none;

    display:inline;

    font-weight: bold; /* modified from normal in Master.css */

}



h3 {

    clear: none;

    display:inline;

}



h4 {

    font-style: normal;/* modified from italics in Master.css */

}



li {

    margin-bottom: 0.5em; /* modified from eDib 10px */

}



input.edit, select {

    /* font size for the fields */

    font-size: 90%;

    margin: 0;

    padding: 0;

}



input.plain, input.continue, input.back {

    /* font size for buttons is not set anywhere, they are too big in Mozilla */

    font-size: 14px;

}



p {

    /* paragraphs to be displayed identically in all browsers */

    margin: 0.2em 0;

    padding: 0.2em 0;

}



h3 {

    /* h3s to be displayed identically in all browsers */

    margin: 0.6em 0;

    padding: 0.6em 0;

}



div#container {

    margin: 0;

    padding: 0;

    width: 100%;

}



ul#errorlist {

    /* bullit color and left padding for the list of errors on top of a page */

    color: #CC3333;

    margin: 0;

    padding: 0 0 0 1em;

}



div.propagatederror {

    color: #CC3333;

    font-family: Arial, Helvetica, sans-serif;

    font-size: 80%;

    font-weight: bold;

    /* the following 3 lines are added for proper alignment of

     red ball error messages across browsers */

    width: 350px;

    padding-left: 20px;

    background: url(../images/redball.gif) top left no-repeat;

}

span.reentrynumber {

    /* large size for reentry number itself */

    font-size : 3em;

}



div#content div#reentry {

    /* box for reentry information, ee004 */

    border: 2px solid #333366;

    text-align: center;

    margin: 0.2em 25% 0.2em 10%;

    padding: 2em 0.2em;

}



input.listlink {

    /* taglib uses it to display Change Answer button. */

    background-color: transparent;

    border: none;

    text-align: left;

    color: #0000FF;

    text-decoration: underline;

    cursor: pointer;

    font-size: 90%; /* Little smaller than in PRO */

}



.bottomborder {

    /* forms "Sections" on the page */

    border-bottom: 2px solid #000066;

    padding: 5px 0;

}



.rowbackgrnd4 {

    background-color: #000066;

    color: #FFFFFF;

}



.critical {

    /* from ssa-internet-standard04a.css */

    /* warnings */

    padding-left: 43px;

    margin: 0;

}



div.pageinstruction {

    /* first paragraph on page */

    display: block;

    text-align: justify;

    margin: 0;

    padding: 0 20% 0 5%;

}



.label {

    /* overridden to be 90 percent. probably not a good idea */

    font-size: 90%;

}



.labelsmallerindent {

    /* from ssa-internet-standard04a.css */

    text-indent: 0;

    padding-left: 15pt;

}



.titletext {

    /* from master */

    background: none;

}



.row, .question, .summaryinfo {

    /* from PRO */

    position: static;

    width: 100%;

    vertical-align: top;

    float: none;

    display: block;

    clear: both;

    padding: 4px 0px;

    margin: 0;

}



div.formlabel {

    /* from PRO */

    position: static;

    float: left;

    width: 45%;

    margin: 0;

    padding: 5px 0.5% 5px 5%;

}



div.formelement, div.instructiontext {

    /* from PRO */

    position: static;

    float: left;

    width: 47%;

    margin: 0;

    padding: 5px 1% 5px 0.5%;

}



.propagatedsummary {

    font-size: 90%;

}



span.phonePlain {

    /* prevents phone numbers from wrapping */

    white-space: nowrap;

    font-weight: normal;

}



span.phoneAccented {

    /* prevents phone numbers from wrapping */

    white-space: nowrap;

    font-weight: bold;

}



.buttons {

    /* placeholder for buttons on question page */

    margin: 0;

    padding: 0 1% 0 5%;

    text-align: right;

}



.buttons-centered {

    /* placeholder for centered buttons on question page */

    margin: 0;

    padding: 0 1% 0 5%;

    text-align: center;

}



.buttons-msg {

    /* placeholder for right-aligned buttons on message page */

    margin: 0;

    padding: 0 20% 0 5%;

    text-align: right;

}



.buttons-msg-centered {

    /* placeholder for centered buttons on message page */

    margin: 0;

    padding: 0 20% 0 5%;

    text-align: center;

}



/* 2004/10/20 we will probably need a new style for inline "Change Answer" button for summary page */



div.formlabel h4 {

    /* not finished, other spacing issues are not addressed yet */

    margin-top: 0.4em; /* 2004/10/27 */

}



a#content:link, a#content:visited, a#content:hover, a#content:active {

    /* this prevents Mozilla from underlining the anchor */

    color: #000;

    text-decoration: none;

}



a.helpAnchor:link, a.helpAnchor:visited, a.helpAnchor:hover, a.helpAnchor:active {

    /* this prevents Mozilla from underlining the anchor */

    color: #000;

    text-decoration: none;

}



input.blinkHelpMeAdd {

    background-color: transparent;

    border-top-width: medium;

    border-right-width: medium;

    border-bottom-width: medium;

    border-left-width: medium;

    border-top-style: none;

    border-right-style: none;

    border-bottom-style: none;

    border-left-style: none;

    border-top-color: -moz-use-text-color;

    border-right-color: -moz-use-text-color;

    border-bottom-color: -moz-use-text-color;

    border-left-color: -moz-use-text-color;

    text-align: left;

    color: rgb(0, 0, 255);

    text-decoration: underline;

    cursor: pointer;

    font-size: 90%;

    font-weight: bold;

}



div.exclamation{

    /* for centered italicized instructions  */

    text-align: right;

    font-style: italic;

    color: red;

    padding: 0.5em 0;

}



span.missingInfo{

    /* alert text on missing information page  */

    color: #CC3333;

    font-weight: bold;

}



div.summaryRedball {

    /* for redballs on summary page  */

    color: #FF0000;

    margin: 0;

    padding: 0.1em;

}



div.attentionMessage {

    /* for boxed messages, see qu004a for example */

    border: 1px solid #000066;

    padding: 1em;

    margin: 1em 5%;

}



div.welcomeFirstColumn {

    /* Welcome page first column, see ee001 */

    position: static;

    float: left;

    clear:none;

    width: 45%;

    margin: 0;

    padding: 5px 2%;

}



div.welcomeSecondColumn {

    /* Welcome page second column, see ee001 */

    position: static;

    float: right;

    clear: none;

    width: 45%;

    margin: 0;

    padding: 5px 2%;

}



div.welcomeBothColumns {

    /* Welcome page both columns, see ee001 */

    margin: 0;

    padding: 5px 2%;

}



div.welcomeTitle {

    /* Welcome page title, see ee001 */

    position: static;

    float: left;

    margin: 0;

    padding: 0 2%;

}



div.welcomeHeader{

    /* paragraph headers */

    display: block;

    width: 100%;

    vertical-align: top;

    margin: 0.2em 0;

    padding: 0.2em 0;

}



div.welcomeGroupHeading{

    /* spreads across both columns */

    margin: 0;

    padding: 0 2%;

}



div.welcomeSubHeader{

    /* omb number under the header */

    display: block;

    width: 100%;

    vertical-align: top;

    text-align: center;

    font-size: 80%;

    margin: 0;

    padding: 0;

}



div.welcomeAttentionMessage {

    /* for boxed messages on Welcome page, see ee001 */

    background-color: #E4E4F2;

    text-align: left;

    border: 1px #333366 solid;

    margin: 1em 0;

    padding: 10px 10px;

}



div.welcomeAttentionMessage input {

    /* adds some space between the buttons */

    margin: 0.2em;

}



div.welcomePrivacyAct {

    /* Privacy Act */

    text-align: center;

}



div.welcomePrivacyAct h3, div.welcomePrivacyAct p{

    /* Privacy Act */

    font-size: 80%;

}



div.page-title {

    /* from SYNC, for page title */

    margin: 0;

    padding: 10px 20% 5px 5%;

}



div.groupheading{

    /* from SYNC, for group headers */

    margin: 0;

    padding: 5px 1% 0 5%;

}



div.signatureCheckboxes{

    /* 20050216 for checkboxes on signature page */

    margin: 0;

    padding: 5px 20% 0 25%;

}



div.summarySectionHeader{

    margin: 0;

    padding: 0 1% 0 1%;

}



a.redskipnav:focus{

    /* for skipnav link, IE is more forgiving, while Gecko is not. */

    color: #FFFFAA;

    font-size: 80%;

}



table.examples ul{

    /* examples in the question, see qu001a.jsp */

    margin: 0 1em 0 1em;

    padding: 0;

    font-weight: bold;

}



table.examples li{

    /* examples in the question, see qu001a.jsp */

    margin-bottom: 0;

    padding: 0.1em;

    list-style-type: disc;

}



table.examples td{

    /* examples in the question, see qu001a.jsp */

    vertical-align: bottom;

}



/* Function bar */

div#functionBar input {

    float: left;

    font-family: Verdana, Arial, Helvetica, sans-serif;

    font-size: 12px;

    font-weight: bold;

    cursor: pointer;

    margin: 5px 5px 5px 5%;

}



div#functionBar span#globalHelp {

    float: right;

    margin: 5px;

    padding: 2px;

}

/* END Function bar */



/* Progress indicator */

.topbottomborder {

    border-top: 1px solid #000066;

    border-bottom: 1px solid #000066;

    padding-bottom: 5px;

    padding-top: 5px;

}



div.progressDescription {

    font-weight: bold;

    font-variant: small-caps;

    margin:0;

    padding: 4px 0 2px 0;

    float: left;

    display: inline;

}



div.progressStep {

    background-image: url(../appimages/progressGrey.gif);

    background-repeat: no-repeat;

    background-position: center left;

    margin:0 0 0 10px;

    padding: 4px 2px 2px 20px;

    float: left;

    display: inline;

}



div.progressStepActive {

    background-image: url(../appimages/progressBlue.gif);

    background-repeat: no-repeat;

    background-position: center left;

    margin:0 0 0 10px;

    padding: 4px 2px 2px 20px;

    font-weight: bold;

    float: left;

    display: inline;

}

/* END Progress indicator */



/* Banner */

div#banner{

    position: static;

    clear: both;

    width: 100%;

    padding: 0;

    margin: 0;

    background-color: transparent;

}



div#banner img{

    position: static;

    clear: both;

    width: 45px;

    height: 46px;

    float: left;

    border-style: solid;

    border-color: white;

    border-top-width: 13px;

    border-right-width: 13px;

    border-bottom-width: 12px;

    border-left-width: 13px;

    background-color: white;

    margin:0;

    padding:0;

}



div#applicationHead {

    background: #CC3333 url(../images/redstarback.gif);

    padding: 0 0 5px 0px;

    margin: 0;

}



div#applicationHead .headSkip{

    position: static;

    line-height: 8px;

    font-size: 14px;

    padding: 0;

    margin: 0;

}



div#applicationHead .headTitle{

    position: static;

    font-family: Georgia, "Times New Roman", Times, serif;

    font-size: 12px;

    text-align: left;

    color: white;

    padding: 0;

    margin: 0;

}



div#applicationHead .redskipnav, div#applicationHead .titletext{

    padding: 0 8px 0 8px;

}



div#applicationMenu {

    position: static;

    font-family: Verdana, Arial, Helvetica, sans-serif;

    font-size: 12px;

    text-align: center;

    vertical-align: baseline;

    color: #FFFFFF;

    background-color: #000066;

    line-height: 16px;

    padding: 3px 0 3px 0;

    margin: 0;

}



/*

#applicationMenu .menu-item {

    letter-spacing: 2px;

}

*/



#applicationMenu input {

    font-family: Verdana, Arial, Helvetica, sans-serif;

    font-size: 12px;

    font-weight: bold;

    text-decoration: underline;

    color: #FFFFFF;

    background-color: transparent;

    border: solid black 0px;

    cursor: pointer;

}



#applicationMenu input#button-sign-out {

    float: left;

}



#applicationMenu input#button-faq {

    float: right;

}

/* END Banner */



/* Summary Page */

input.editbutton {

    /* this is an actual button */

    margin: 0.2em;

    padding: 0 0.4em;

}



div.editfield {

    /* summary page's first column (div) */

    position: relative;

    float: left;

    width: 10%;

    margin: 0;

    padding: 0 0.2em;

}



div.answerfield_1 {

    position: relative;

    float : left;

    width : 30%;

    vertical-align : top;

    text-align : left;

    margin: 0;

    padding: 0 0.2em;

}



div.answerfield_2 {

    position: relative;

    float : left;

    width : 30%;

    vertical-align : top;

    text-align : left;

    margin: 0;

    padding: 0 0.2em;

}



div.answerfields {

    position: relative;

    float : left;

    width : 80%;

    vertical-align : top;

    text-align : left;

    margin: 0;

    padding: 0 0.2em;

}

/* END Summary Page */







div.sectionSubHeader {

    font-weight: bold;

    font-size: 90%;

    background-color: #EEEEEE;

    border: 1px solid #EEEEEE;

    marging: 0;

    padding: 0.3em 0.6em 0.2em 0.6em;

}



div.sectionSubTitle {

    font-size: 90%;

}



div.sectionLabelTitle {

    font-size: 90%;

    text-align: center;

}



div.displayQuestion {

    font-size: 90%;

}



div.displayAnswer {

    font-family: Courier New, Courier, fixed;

    font-size: 96%;

    font-weight: bold;

}



table.printsave {

    border-collapse: collapse;

    width: 100%;

    margin: 0;

    padding: 0;

}



table.printsave td, table.printsave th {

    border: 1px solid #666666;

    margin: 0;

    padding: 0.2em;

}



td.firstColumn {

    text-align: right;

    width: 50%;

}



td.SecondColumn {

    text-align: left;

    width: 25%;

}



td.thirdColumn {

    text-align: left;

    width: 25%;

}



td.bothColumns {

    text-align: left;

    width: 50%;

}

/* END Print/Save page */



/* Help pages */

div#cacheValueChart {

    margin: 0;

    padding: 0 3em;

}



div#cacheValueChart table{

    marging: 0;

    padding: 0;

    border-collapse: collapse;

}



div#cacheValueChart table td, div#cacheValueChart table th{

    margin: 0.2;

    padding: 0.4em;

    border: 1px solid black;

}



div#cacheValueChart table th{

    font-weight: bold;

}



div#cacheValueChart table caption{

    font-weight: bold;

    padding: 0.4em;

    text-align: left;

}

/* END Help pages */



/* Browser Fixes */

/* This fixes the background color problem in DIV structures in Netscape/Mozilla */

.rowbackgrnd:after {

    content: ".";

    display: block;

    height: 0;

    clear: both;

    visibility: hidden;

}



.rowbackgrnd2:after {

    content: ".";

    display: block;

    height: 0;

    clear: both;

    visibility: hidden;

}

/* END Browser Fixes */



/* END stylesheet */



/* TEMP TEMP TEMP TEMP TEMP TEMP TEMP TEMP TEMP TEMP TEMP TEMP TEMP TEMP */

.hidedebug {

    color: #993300;

    background-color: #FFCC66;

}



.restartMessage {

    text-align: center;

    margin-bottom: 15px;

}



    </style>

    

    <style type="text/css" media="all">

        /*******************************************************************/

/* Copyright (c) Social Security Administration.                   */

/* All rights reserved.                                            */

/*                                                                 */

/* This software is the confidential and proprietary information of*/

/* Social Security Administration. You shall use it only in        */

/* accordance with the terms of the license agreement you entered  */

/* into with Social Security Administration                        */

/*                                                                 */

/* This style sheet controls the unique page layout elements for   */

/* the i1020 application                                           */

/*******************************************************************/



    .titletext {

        background:url(images/redstarback.gif) #CC3333;

    }



    .critical {

        background-image: url(images/warning.gif);

    }



    div.summaryMissingInfo{

        background-image: url(images/redball.gif);

    }



    div.progressStep {

        background-image: url(appimages/progressGrey.gif);

    }



    div.progressStepActive {

        background-image: url(appimages/progressBlue.gif);

    }



    div#applicationHead {

        background: #CC3333 url(images/redstarback.gif);

    }

	div.hd, div.bd{
		margin:20px 0px;
	}

    </style>

    

    <style type="text/css" media="print">

        /*******************************************************************/

/* Copyright (c) Social Security Administration.                   */

/* All rights reserved.                                            */

/*                                                                 */

/* This software is the confidential and proprietary information of*/

/* Social Security Administration. You shall use it only in        */

/* accordance with the terms of the license agreement you entered  */

/* into with Social Security Administration                        */

/*                                                                 */

/* This style sheet controls the unique page layout elements for   */

/* the i1020 application                                           */

/*******************************************************************/



    div#banner {

        display: none;

    }

    div#progressIndicator {

        display: none;

    }

    div.sectionSubHeader {

        border: 0px;

    }



    </style>

    

<cfparam name="src" default="">

<cfparam name="url.reportType" type="string" default="">

<cf_tagHeader>

<table width=100% border="0" align="center" cellpadding="12" cellspacing="2">

	<tr>

	<td bgcolor=#FFFFFF colspan=2>

<!--Dynamic Area-->
<font face="arial" size="4" color="#000000">
<span style="font-size:150%; font-weight:bold;">Successful Submission</span>


<hr>

<cf_buttons goText="BenefitsCheckUp Results" goURL="/cf/frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
<!--- Bug 6747 - LIS App - Add Return to BenefitsCheckUp button to confirmation page 
<div style="float:left;clear:both; width:100%;margin-left:0px">
		<cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id NEQ 0>
			<form action="/cf/index.cfm?partner_id=#SESSION.partner_id#&cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
		<cfelse>
			<form action="/index.php" method="post">
		</cfif>
		<input type="submit" value="Return to Home Page" style="font-size: 8pt;">
	</form>
</div>
--->	
		<cfif (session.source_id eq 2 or session.source_id eq 3 or session.org_id gt 0) and session.partner_id neq 26>
			<cfparam name="attributes.fontFace" type="string" default="Arial, Helvetica, Verdana, sans-serif">
			<cfparam name="attributes.fontSize" type="numeric" default="8">
			<cfset fontStyle="font-family: #attributes.fontFace#; font-size: #attributes.fontSize#pt;">
			<cf_displayButton return_oe="true" name="print" style="#fontStyle#">
		</cfif>

<cfinclude template="/cf/rx/qrySubmission.cfm">

<CFOUTPUT query="qrySubmission">

#submission_result#

</CFOUTPUT>

<p>To find out information about additional programs you may be eligible for, click the "BenefitsCheckUp Results" button.</p>

 </font>




		<cf_buttons goText="BenefitsCheckUp Results" goURL="/cf/frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
		<!--- Bug 6747 - LIS App - Add Return to BenefitsCheckUp button to confirmation page 
		<div style="float:left;clear:both; width:100%;margin-left:0px">
				<cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id NEQ 0>
					<form action="/cf/index.cfm?partner_id=#SESSION.partner_id#&cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
				<cfelse>
					<form action="/index.php" method="post">
				</cfif>
				<input type="submit" value="Return to Home Page" style="font-size: 8pt;">
			</form>
		</div>
		--->

		<cfif (session.source_id eq 2 or session.source_id eq 3 or session.org_id gt 0) and session.partner_id neq 26>
			<cfparam name="attributes.fontFace" type="string" default="Arial, Helvetica, Verdana, sans-serif">
			<cfparam name="attributes.fontSize" type="numeric" default="8">
			<cfset fontStyle="font-family: #attributes.fontFace#; font-size: #attributes.fontSize#pt;">
			<cf_displayButton return_oe="true" name="print" style="#fontStyle#">
		</cfif>






</td></tr></Table>

</td></tr></Table>



<cf_tagfooter>