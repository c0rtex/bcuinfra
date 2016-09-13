<script type="text/javascript" src="includes/yui/build/connection/connection.js"></script>
<script type="text/javascript" src="includes/yui/build/animation/animation.js"></script> 
<script type="text/javascript" src="includes/yui/build/dom/dom.js"></script>
<script type="text/javascript" src="includes/yui/build/dragdrop/dragdrop.js"></script>
<script type="text/javascript" src="includes/yui/examples/treeview/js/log.js"></script>
<!-- this is the overlay stuff -->
<link rel="stylesheet" type="text/css" href="includes/yui/build/fonts/fonts.css" />
<!-- <link rel="stylesheet" type="text/css" href="includes/yui/examples/container/css/example.css" /> -->
<link rel="stylesheet" type="text/css" href="includes/yui/build/container/assets/container.css" />
<script type="text/javascript" src="includes/yui/build/container/container.js"></script>

<div id="dlg">
    <form name="dlgForm">
        <span id="formContent"></span>
    </form>
</div>
<style type="text/css">

.formQuestion {
	background-color:#d0e3f5;
	padding:0.3em;
	font-weight:900;
	font-family:Verdana, Arial, sans-serif;
	font-size:0.8em;
	color:#5a5a5a;
}
.formAnswer {
	background-color:#f5eede;
	padding:0.3em;
	margin-bottom:1em;
}

.small {
	width: 2.5em;
	zIndex= -1000;
}
.medium {
	width: 10em;
}
.long {
	width: 20em;
}
</style>
<div class="formQuestion">
	<span class="emphasise">Upload Batch Enrollments</span>
</div>
<cfif  isdefined('form.processxml') and processxml eq 'y'>
		<cftry>
		<cffile    
		action = "upload"   
		fileField = "form.xmlfile"   
		destination = "/var/www/html/BCU/pdf/batch.xml"   
		nameConflict = "overwrite"  
		mode = 644 
		>
		<cfcatch type="any" >
			Error: The uploaded file must be a valid xml file.
		</cfcatch>
		</cftry>
		<cfset application.tmpXMLFile = cffile.serverFile>
		<cfset application.tmpXMLFileDirectory = cffile.serverDirectory>
		<cfoutput>#application.tmpXMLFile# uploaded. <br /></cfoutput>
		<cffile action="read" file="#application.tmpXMLFileDirectory#/batch.xml" variable="application.tmpXMLFile" >
		<cfif #findnocase('ct_receive_medicare_xnd',application.tmpXMLFile)# eq 0>
			Error: The uploaded file must be a LIS Application Batch xml file. <br /> 
		<cfelse>	
					<cfif isdefined('cffile.serverFile') >
						<cflocation url="upload_xml.cfm">
					</cfif>
		</cfif>
<cfelse>
<cfoutput >
<form method="post" action="load_xml.cfm" enctype="multipart/form-data" name="upload_form.cfm">
<table class="formAnswer" style="width: 100%;">
	<tr>
		<td class="emphasise">XML File</td>
		<td>
				<input type="file" name="xmlfile">
				<input type="hidden" name="processxml" value="y" />
		</td>
	</tr>
	<tr>
	     <td colspan=2><input type="submit" value="Upload File"></td>
	</tr>
</table>
</cfoutput>
</form>
</cfif>