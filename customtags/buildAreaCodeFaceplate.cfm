<cfparam name="attributes.code" type="string">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.objectType" type="string" default="">

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>

<!---<cfset locallight = Evaluate("application.color.areacodes.light")>
<cfset localmed = Evaluate("application.color.areacodes.med")>
<cfset localdark = Evaluate("application.color.areacodes.dark")>--->

<cfset locallight = "##B1E1C6">
<cfset localmed = "##77CA9C">
<cfset localdark = "##3CB371">


<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

function clearFileInputField(tagId) {
    document.getElementById(tagId).innerHTML = 
                    document.getElementById(tagId).innerHTML;
}


function checkFields(pcounter) {                    

 	var vquery; /***** a string type place holder to build string ****/

 	var vfileuploadvalue; /* this will store the vaue of fileupload for the correct form ****/

	var verr = ""; /***** error variable to decide to submit or not ****/

	
	vquery = "vfileuploadvalue = document.uploadForm_" + pcounter + ".fileUpload.value;"; 

 	/******* so if the 1st form's upload button was clicked then the value of vquery now will be

 	vfileuploadvalue = document.uploadForm_1.fileUpload.value; *******/

 	eval(vquery); /***** this will evaluate what's in vquery and will set vfileuploadvalue to what is in fileUpload field for the form *****/

	/***** now use the vfileuploadvalue variable instead *****/

	if (vfileuploadvalue==""){ 

  		alert("Please browse to the file that you would like to upload.");

  		vquery = "document.uploadForm_" + pcounter + ".fileUpload.focus();";

  		eval(vquery); /**** will set the focus for the correct form ******/

 	}

 	else {  

   		if(vfileuploadvalue.lastIndexOf(".csv")==-1) {

     			alert("Please upload only files with the .csv extension");
			
			vquery="";
     			vquery = "clearFileInputField('uploadFile_div" + pcounter +"')";
			eval(vquery);
			
			vquery="";
     			vquery = "document.uploadForm_" + pcounter + ".fileUpload.focus();";
    			eval(vquery);

   		}

		else { 

     			vquery = "document.uploadForm_" + pcounter + ".submit();";
     			eval(vquery); 

   		}

 	}

 
}

</script>

	
<cfoutput>
<table border="0" cellpadding="3" cellspacing="3">
<cfif attributes.title neq ''>
	<cfquery name="getLastUpdate" datasource="#application.dbSrc#">
    	Select last_updated from areacodes_import
        where areacode_id = '1'
    </cfquery>
    <tr bgcolor="#localdark#">
		<td><font size="+2"><b>#attributes.title#</b>
	<cfif getLastUpdate.RecordCount NEQ 0>
    	<cfset theDate = getLastUpdate.last_updated> 
    <font size="+1">&nbsp;-&nbsp;Last Updated on #theDate#</font>
    </cfif>
    </font></td>
	</tr>
</cfif>
	<tr bgcolor="#localmed#">
		<td colspan="2">
			<font size="+1">
				<cfif IsDefined('ThisTag.AssocAttribs') and ArrayLen(ThisTag.AssocAttribs) eq 1>This button<cfelse>These buttons</cfif> will let you upload the current #attributes.objectType# data in CSV format.
			</font>
		</td>
	</tr>
	<tr bgcolor="#locallight#">
		<td><ul><br />
	<cfif IsDefined('ThisTag.AssocAttribs')>
		<!--- Array to hold unsuccessful insert references --->
		<cfset notInserted = ArrayNew(1)>
		<cfset arrayIndex = 0>
		<cfset numLine = 0>
		<cfif isDefined("fileUpload")>
			<cfset dest = "areacode_csv\" & "#fileName#" & ".csv">
			<cffile action="upload" fileField="fileUpload" destination="#dest#" accept="application/csv,text/comma-separated-values,text/csv,application/excel,application/vnd.ms-excel,application/vnd.msexcel,text/anytext,application/octet-stream" nameConflict="overwrite">
			<cfif fileName IS "areacodeimport">
				<cfquery name="purgeTbl" datasource="#application.dbSrc#">
					DELETE FROM areacodes_import
				</cfquery>
				<cfset firstLine = "yes">
                <cfset lineNum = 1>
                <cfset areacode_id = 0>
				<cfloop file="#dest#" index="line">
                	<cfset counter = 1>
					<!-- File Columns -->
                    <cfset str_zipcode="">
					<!---<cfset str_zipcode_type="">
					<cfset str_city="">
					<cfset str_city_type="">
					<cfset str_county="">
					<cfset str_county_fip="">
					<cfset str_state="">
					<cfset str_state_code="">
					<cfset str_state_fip="">
					<cfset str_msa="">--->
					<cfset str_areacode="">
					<!---<cfset str_time_zone="">
					<cfset str_gmt_offset="">
					<cfset str_dst="">
					<cfset str_lat="">
					<cfset str_long="">--->
					<cfset str_last_updated="#DateFormat(Now())#">
					<cfif firstLine NEQ "yes">
                    <cfset areacode_id = areacode_id + 1>
					<cfloop list="#line#" index="fielddata" delimiters=",">
                    	<cfscript>
                			if (counter EQ 1){
								str_zipcode = trim(fielddata);
							}
							else if (counter EQ 11){
								str_areacode = trim(fielddata);
							}
							
							counter = counter + 1;	   
						</cfscript>
                    </cfloop>
					<cftry>
						<cfset numLine = numLine + 1>
						<cfquery name="updateACI" datasource="#application.dbSrc#">
          						INSERT INTO areacodes_import
                                (areacode_id,zipcode,areacode,last_updated)
     							VALUES 			
                                (#areacode_id#,'#str_zipcode#','#str_areacode#','#str_last_updated#')
						</cfquery>	
						<cfcatch>
							<cfset arrayIndex = arrayIndex + 1>
							<cfset notInserted[#arrayIndex#] =  "#lineNum#">
							<cfset lineNum = lineNum + 1>
						</cfcatch>
					</cftry>
					<cfelse>
						<cfset firstLine = "no">
					</cfif>
				</cfloop>		
			</cfif>
			<cfif #ArrayLen(notInserted)# eq 0>
				<p><b><i>The #fileType# uploaded successfully.</i></b>
			<cfelseif ((#ArrayLen(notInserted)# LT #numLine#)&&(#ArrayLen(notInserted)# GT 0))>
				<p><b><i>The #fileType# uploaded successfully except for row(s):<BR>
				|&nbsp;<cfloop index="x" array="#notInserted#">#x#&nbsp;|&nbsp;</cfloop>in the #fileName#.csv</i></b>
			<cfelseif #ArrayLen(notInserted)# eq #numLine#>
				<p><b><i>The #fileType# WAS NOT uploaded. Please verify the data and upload again.
			</cfif>
            <!--- Put in query to compare uploaded data to--->
            <cfquery name="mergePhoneEntry" datasource="#application.dbSrc#">
    			SELECT * FROM phone_temp INNER JOIN
        		entrypoint_temp ON phone_temp.entrypoint_id = entrypoint_temp.entrypoint_id INNER JOIN
        		areacodes_import ON entrypoint_temp.zipcode = areacodes_import.zipcode
				WHERE entrypoint_temp.zipcode = areacodes_import.zipcode    
    		</cfquery>
            <cfset vphoneid = 0>
            <cfset numUpdated = 0>
            <cfif (mergePhoneEntry.recordcount NEQ 0)>
        		<cfloop query="mergePhoneEntry">
          			<cfif vphoneid neq #phone_id#>
           				<cfset strPhone = #Trim(number)#>
						<!--- Extract the area code from phone.number --->
						<cfset Phone_AreaCode = Mid( strPhone, 2, 3 )>
						<cfset Phone_MinusAreaCode = Mid(strPhone, 6, 9)>
            			<!--- Compare area code in ImportedArea Codes to the one in phone --->
            			<cfif (areacode IS NOT Phone_AreaCode)>
                			<cfset updatedPhone = "(" & #Trim(areacode)# & ")" & Phone_MinusAreaCode>
							<cfquery name="updateNumber" datasource="#application.dbSrc#">
                				UPDATE phone_temp SET phone_temp.number = '#updatedPhone#'
								WHERE phone_temp.phone_id = #phone_id#
							</cfquery>
                			<cfset vphoneid = #phone_id#>
                			<cfset numUpdated = numUpdated + 1>
                		</cfif>
              		</cfif>
				</cfloop>
    		</cfif>
            <BR />#numUpdated# Phone Numbers were updated.</p>
    	</cfif>
		<cfset vcounter = 0> 

		<cfloop index="x" from="1" to="#ArrayLen(ThisTag.AssocAttribs)#">

   			<cfset vcounter = vcounter + 1> 

   			<cfset goto = ThisTag.AssocAttribs[x].goto>

   			<cfset text = ThisTag.AssocAttribs[x].text>

   			<cfset section = ThisTag.AssocAttribs[x].section>

   			<cfif section neq ''>

    				<cfset goto = "../#section#/#goto#">

   			</cfif>

   			<cfif text eq ''>

    				<cfset text = goto>

   			</cfif>

   			<cfset dest = "#Trim(goto)#" & ".cfm">

   			<li>

    				<form name="uploadForm_#vcounter#" enctype="multipart/form-data" method="post">
					<div id="uploadFile_div#vcounter#">
		     				#text#<BR>
	     					<input type="hidden" name="fileName" value="#Trim(goto)#">
		     				<input type="hidden" name="fileType" value="#text#">
	     					<input type="file" name="fileUpload" />&nbsp;
	     					<input type="button" name="sub#vcounter#" value="Upload" onclick="javascript:checkFields(#vcounter#);"/>
					</div>				
    				</form>

   			</li>
		 </cfloop>
	</cfif>
		</ul></td>
	</tr>
	<tr bgcolor="#locallight#">
		<td>
			Download the ZipCode Download file locally on a monthly basis.<BR>
            Extract the files locally if needed.<BR />
			To upload the ZipCode Download CSV file:
			<ol>
			<li>Browse to the ZipCode Download CSV file by clicking on the <b>'Browse'</b> button above</li>
			<li>Click on the <b>'Upload'</b> button <b>once</b>.</li>
			<li>It may take a few minutes for the file to be uploaded.</li>
			</ol>
			<br />
			
		</td>
	</tr>
</table>
</cfoutput>

</cfif>