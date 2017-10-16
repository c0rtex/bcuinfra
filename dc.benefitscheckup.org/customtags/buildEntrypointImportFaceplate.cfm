<cfparam name="attributes.code" type="string">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.objectType" type="string" default="">

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>

<cfset locallight = Evaluate("application.color.entrypoint.light")>
<cfset localmed = Evaluate("application.color.entrypoint.med")>
<cfset localdark = Evaluate("application.color.entrypoint.dark")>

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
			<tr bgcolor="#localdark#">
				<td><font size="+2"><b>#attributes.title#</b></font></td>
			</tr>
		</cfif>
		<tr bgcolor="#localmed#">
			<td colspan="2">
				<font size="+1">
					This import tool enables entry point additions and updates that are associated with one or more entrygroups.
				</font>
			</td>
		</tr>
		<tr bgcolor="#locallight#">
			<td>
				<cfif IsDefined('ThisTag.AssocAttribs')>
					<!--- Array to hold unsuccessful insert references --->
					<cfset notInserted = ArrayNew(1)>
					<cfset arrayIndex = 0>
					<cfset numLine = 0>
					<cfset lineNum = 2>
					<cfif isDefined("fileUpload")>
						<cfset dest = "importCSVs\" & "#fileName#" & ".csv">
                        <cffile action="upload" fileField="fileUpload" destination="#dest#" accept="application/csv,text/comma-separated-values,text/csv,application/excel,application/vnd.ms-excel,application/vnd.msexcel,text/anytext,application/octet-stream" nameConflict="overwrite">
						<cfset firstLine = 'yes'>
						<cfloop file="#dest#" index="line">
							<cfset myString = "#trim(line)#">
							<cfset update = "yes">
							<cfset numCommas = 0>
							<cfset numBars = 0>
							<cfloop index="idx" from="1" to="#len(myString)#">
								<cfset character = mid(myString,idx,1)>
								<cfif character eq ",">
									<cfset numCommas = numCommas + 1>
								</cfif>
								<cfif character eq "|">
									<cfset numBars = numBars + 1>
								</cfif>
							</cfloop>
							<!---<cfif (numCommas neq 29) or (numBars gt 0)>
								<cfset update = "no">
								<cfset arrayIndex = arrayIndex + 1>
								<cfset notInserted[#arrayIndex#] =  "#lineNum#">
							</cfif>--->				
							<cfset counter = 1>
							<cfset str_entrpointgroup_id = "">
       						<cfset str_entrypoint_id="">
							<cfset str_name="">
                            <cfset str_subname="">
                            <cfset str_address1="">
                            <cfset str_address2="">
                            <cfset str_address3="">
                            <cfset str_city="">
                            <cfset str_state_id="">
                            <cfset str_zipcode="">
                            <cfset str_zipcode_plus4="">
                            <cfset str_email="">
                            <cfset str_url="">
                            <cfset str_hours_display_id="">
                            <cfset str_hours="">
                            <cfset str_info_display_id="">
                            <cfset str_info="">
                            <cfset str_contact_title="">
                            <cfset str_contact_first="">
                            <cfset str_contact_middle="">
                            <cfset str_contact_last="">
                            <cfset str_contact_suffix="">
                            <cfset str_privatephone="">
                            <cfset str_notes="">
                            <cfset str_voice="">
                            <cfset str_fax="">
                            <cfset str_tty="">
                            <cfset str_toll_free="">
                            <cfset str_translation="">
                            <cfset str_spanish="">
                            <cfset str_create_user_id="">
                            <cfset str_create_date=""> 
                            <cfset str_modify_user_id="">
                            <cfset str_modify_date="">
                            <cfset str_active_flag="">
							<cfif (firstLine NEQ "yes") and (update eq "yes")>
								<cfset line = Replace(trim(line),',,',',|,','ALL')> 
                                <cfset line = Replace(trim(line),',,',',|,','ALL')>
								<cfloop list="#line#" index="fielddata" delimiters=",">
									<cfscript>
                						if (counter EQ 1){
											str_entrypointgroup_id = Replace(trim(fielddata),'|','',"ALL");
											str_entrypointgroup_id = Replace(trim(str_entrypointgroup_id),'^',',',"ALL");
										}
										else if (counter EQ 2){
											str_entrypoint_id = Replace(trim(fielddata),'|','',"ALL");
											str_entrypoint_id = Replace(trim(str_entrypoint_id),'^',',',"ALL");
										}
										else if (counter EQ 3){
											str_name = Replace(trim(fielddata),'|','',"ALL");
											str_name = Replace(trim(str_name),'^',',',"ALL");
										}
										else if (counter EQ 4){
											str_subname = Replace(trim(fielddata),'|','',"ALL");
											str_subname = Replace(trim(str_subname),'^',',',"ALL");
										}
										else if (counter EQ 5){
											str_address1 = Replace(trim(fielddata),'|','',"ALL");
											str_address1 = Replace(trim(str_address1),'^',',',"ALL");
										}
										else if (counter EQ 6){
											str_address2 = Replace(trim(fielddata),'|','',"ALL");
											str_address2 = Replace(trim(str_address2),'^',',',"ALL");
										}
										else if (counter EQ 7){
											str_address3 = Replace(trim(fielddata),'|','',"ALL");
											str_address3 = Replace(trim(str_address3),'^',',',"ALL");
										}
										else if (counter EQ 8){
											str_city = Replace(trim(fielddata),'|','',"ALL");
											str_city = Replace(trim(str_city),'^',',',"ALL");
										}
										else if (counter EQ 9){
											str_state_id = Replace(trim(fielddata),'|','',"ALL");
											str_state_id = Replace(trim(str_state_id),'^',',',"ALL");
											str_state_id = UCase(str_state_id);
										}
										else if (counter EQ 10){
											str_zipcode = Replace(trim(fielddata),'|','',"ALL");
											str_zipcode = Replace(trim(str_zipcode),'^',',',"ALL");
										}
										else if (counter EQ 11){
											str_zipcode_plus4 = Replace(trim(fielddata),'|','',"ALL");
											str_zipcode_plus4 = Replace(trim(str_zipcode_plus4),'^',',',"ALL");
										}
										else if (counter EQ 12){
											str_email = Replace(trim(fielddata),'|','',"ALL");
											str_email = Replace(trim(str_email),'^',',',"ALL");
										}
										else if (counter EQ 13){
											str_url = Replace(trim(fielddata),'|','',"ALL");
											str_url = Replace(trim(str_url),'^',',',"ALL");
										}
										else if (counter EQ 14){
											str_hours_display_id = Replace(trim(fielddata),'|','',"ALL");
											str_hours_display_id = Replace(trim(str_hours_display_id),'^',',',"ALL");
										}
										else if (counter EQ 15){
											str_hours = Replace(trim(fielddata),'|','',"ALL");
											str_hours = Replace(trim(str_hours),'^',',',"ALL");
										}
										else if (counter EQ 16){
											str_info_display_id = Replace(trim(fielddata),'|','',"ALL");
											str_info_display_id = Replace(trim(str_info_display_id),'^',',',"ALL");
										}
										else if (counter EQ 17){
											str_info = Replace(trim(fielddata),'|','',"ALL");
											str_info = Replace(trim(str_info),'^',',',"ALL");
										}
										else if (counter EQ 18){
											str_contact_title = Replace(trim(fielddata),'|','',"ALL");
											str_contact_title = Replace(trim(str_contact_title),'^',',',"ALL");
										}
										else if (counter EQ 19){
											str_contact_first = Replace(trim(fielddata),'|','',"ALL");
											str_contact_first = Replace(trim(str_contact_first),'^',',',"ALL");
										}
										else if (counter EQ 20){
											str_contact_middle = Replace(trim(fielddata),'|','',"ALL");
											str_contact_middle = Replace(trim(str_contact_middle),'^',',',"ALL");
										}
										else if (counter EQ 21){
											str_contact_last = Replace(trim(fielddata),'|','',"ALL");
											str_contact_last = Replace(trim(str_contact_last),'^',',',"ALL");
										}
										else if (counter EQ 22){
											str_contact_suffix = Replace(trim(fielddata),'|','',"ALL");
											str_contact_suffix = Replace(trim(str_contact_suffix),'^',',',"ALL");
										}
										else if (counter EQ 23){
											str_privatephone = Replace(trim(fielddata),'|','',"ALL");
											str_privatephone = Replace(trim(str_privatephone),'^',',',"ALL");
										}
										else if (counter EQ 24){
											str_notes = Replace(trim(fielddata),'|','',"ALL");
											str_notes = Replace(trim(str_notes),'^',',',"ALL");
										}
										else if (counter EQ 25){
											str_voice = Replace(trim(fielddata),'|','',"ALL");
											str_voice = Replace(trim(str_voice),'^',',',"ALL");
										}
										else if (counter EQ 26){
											str_fax = Replace(trim(fielddata),'|','',"ALL");
											str_fax = Replace(trim(str_fax),'^',',',"ALL");
										}
										else if (counter EQ 27){
											str_tty = Replace(trim(fielddata),'|','',"ALL");
											str_tty = Replace(trim(str_tty),'^',',',"ALL");
										}
										else if (counter EQ 28){
											str_toll_free = Replace(trim(fielddata),'|','',"ALL");
											str_toll_free = Replace(trim(str_toll_free),'^',',',"ALL");
										}
										else if (counter EQ 29){
											str_translation = Replace(trim(fielddata),'|','',"ALL");
											str_translation = Replace(trim(str_translation),'^',',',"ALL");
										}
										else if (counter EQ 30){
											str_spanish = Replace(trim(fielddata),'|','',"ALL");
											str_spanish = Replace(trim(str_spanish),'^',',',"ALL");
										}
										else if (counter EQ 31){
											str_active_flag = Replace(trim(fielddata),'|','',"ALL");
											str_active_flag = Replace(trim(str_active_flag),'^',',',"ALL");
										}
										counter = counter + 1;    
									</cfscript>
                                    <!--- To be used for last_update, create_date for new entrypoints, and modify_date --->
                                    <cfset str_date="#DateFormat(Now())# #Timeformat(NOW(),"hh:mm:ss")#">
                                </cfloop>
								<cfset numLine = numLine + 1>
								<!--- GENERAL ERROR CHECK 
									- If required entrypointgroup_id, name and/or active_flag is/are blank
									- if name is not defined or is blank
									force this entrypoint to be skipped--->
                                <cfif str_entrypointgroup_id neq "" and IsNumeric(str_entrypointgroup_id) and str_name neq "" and str_active_flag neq "">
                                	<cfquery name="validateEPG" datasource="#application.dbSrc#">
                                	    Select * from entrypointgroup where entrypointgroup_id = #str_entrypointgroup_id#
                                	</cfquery>
                                    
                                    <!--- If entrypoint_id value is not empty and it doesn't contain numbers only, skip entrypoint--->
                                	<cfif str_entrypoint_id neq "" and Not IsNumeric(str_entrypoint_id)>
                                	    <cfset update = "no">
                                	    <!--- Add ln to array as skipped --->
                                	    <cfset arrayIndex = arrayIndex + 1>
                                	    <cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                   </cfif>
                                	<!--- If active_flag value is not 0 or 1 skip entrypoint. If EPG is not valid skip entrypoint--->
                                	<cfif (str_active_flag neq 0 and str_active_flag neq 1) or validateEPG.RecordCount neq 1>
                                	    <cfset update = "no">
                                	    <!--- Add ln to array as skipped --->
                                	    <cfset arrayIndex = arrayIndex + 1>
                                	    <cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                   </cfif>
                                   <!--- If state_id value is not empty and it doesn't contain 2 letters skip entrypoint--->
                                	<cfif (str_state_id neq "" and (len(trim(str_state_id)) neq 2 or Not REFindNoCase("[A-Za-z]", str_state_id)))>
                                	    <cfset update = "no">
                                	    <!--- Add ln to array as skipped --->
                                	    <cfset arrayIndex = arrayIndex + 1>
                                	    <cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                   </cfif>
                                   <!--- If zipcode value is not empty and it doesn't contain 5 numbers skip entrypoint--->
                                	<cfif (str_zipcode neq "" and (len(trim(str_zipcode)) neq 5 or Not IsNumeric(str_zipcode)))>
                                	    <cfset update = "no">
                                	    <!--- Add ln to array as skipped --->
                                	    <cfset arrayIndex = arrayIndex + 1>
                                	    <cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                   </cfif>
                                    <!--- If zipcode_plus4 value is not empty and it doesn't contain 4 numbers skip entrypoint--->
                                	<cfif (str_zipcode_plus4 neq "" and (len(trim(str_zipcode_plus4)) neq 4 or Not IsNumeric(str_zipcode_plus4)))>
                                	    <cfset update = "no">
                                	    <!--- Add ln to array as skipped --->
                                	    <cfset arrayIndex = arrayIndex + 1>
                                	    <cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                   </cfif>
                                <cfelse>
                                	<cfset update = "no">
                                	<!--- Add ln to array as skipped --->
                                	<cfset arrayIndex = arrayIndex + 1>
                                	<cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                </cfif>
                                <cfif update eq "yes">
                                	<cfif str_entrypoint_id eq "" and str_hours_display_id eq "" and str_info_display_id eq "">
                                    	<!--- BEGIN Handlers for new entrypoint --->
                                        <!--- Generate display_code for inserting into hours and info display record--->
                                        <cfset newcode="">
                                        <cfif IsDefined('str_state_id') and str_state_id neq ''>
                                            <cfset newcode = "#LCase(str_state_id)#_">
                                        <cfelse>
                                            <cfset newcode = 'null_'>
                                        </cfif>
                                        <cfif IsDefined('str_zipcode') and str_zipcode neq ''>
                                            <cfset newcode = "#newcode##str_zipcode#_">
                                        <cfelse>
                                            <cfset newcode = "#newcode#null_">
                                        </cfif>
                                        <cfset randomSrc = 'abcdefghijklmnopqrstuvwxyz0123456789'>
                                        <cfset randomLen = RandRange(7, 13)>
                                        <cfloop from="1" to="#randomLen#" index="rrindex">
                                            <cfset randomPos = RandRange(1, Len(randomSrc))>
                                            <cfset newcode = newcode & Mid(randomSrc, randomPos, 1)>
                                        </cfloop>
                                        <!--- Insert new hours_display_id--->
                                        <cfquery name="insertNewHoursDisplay" datasource="#application.dbSrc#">

                                            INSERT INTO display
                                                (displaygroup_id
                                                ,display_code
                                                ,display_name
                                                ,active_flag)
                                            VALUES
                                                (46, 'ephours_#newcode#', 'Entry Point Hours Text: #newcode#', #str_active_flag#);
                                          	SELECT LAST_INSERT_ID() as newHDid

                                        </cfquery>
                                        <cfif insertNewHoursDisplay.newHDid neq "">
                                        	<cfoutput><cfset str_hours_display_id="#insertNewHoursDisplay.newHDid#"></cfoutput>
                                        <cfelse>
                                        	<cfset update="no">
                                        </cfif>
                                        <cfif update neq "no">    
                                        	<cfquery name="insertNewHoursDisplayLang_EN" datasource="#application.dbSrc#">
                                            	INSERT INTO display_language
                                               		(display_id
                                               		,language_id
                                               		,display_text
                                               		,update_flag)
                                            	VALUES
                                               		(#str_hours_display_id#, 'EN', '#str_hours#', 1)
                                            </cfquery>
                                            <cfquery name="insertNewHoursDisplayLang_ES" datasource="#application.dbSrc#">
                                            	INSERT INTO display_language
                                               		(display_id
                                               		,language_id
                                               		,display_text
                                               		,update_flag)
                                            	VALUES
                                               		(#str_hours_display_id#, 'ES', '', 0)
                                            </cfquery>
                                            <cfquery name="chkNewHoursDisplayLang" datasource="#application.dbSrc#">
                                            	Select count(*) from display_language
                                                where display_id = #str_hours_display_id# and language_id = 'EN'
                                            </cfquery>
											<cfif chkNewHoursDisplayLang.recordCount eq 0>
												<cfset update="no">
                                        	</cfif>
                                        </cfif>
                                        <cfif update neq "no">                                    
											<!--- Insert new info_display_id --->
                                            <cfquery name="insertNewInfoDisplay" datasource="#application.dbSrc#">
                                                INSERT INTO display
                                                    (displaygroup_id
                                                    ,display_code
                                                    ,display_name
                                                    ,active_flag)
                                                VALUES
                                                    (46, 'epinfo_#newcode#', 'Entry Point Other Info Text: #newcode#', #str_active_flag#);
                                               	SELECT LAST_INSERT_ID() as newIDid
                                            </cfquery>
                                            <cfif insertNewInfoDisplay.newIDid neq "">
                                            	<cfoutput><cfset str_info_display_id="#insertNewInfoDisplay.newIDid#"></cfoutput>
                                            <cfelse>
                                            	<cfset update="no">
                                            </cfif>     
                                  		</cfif>
                                        <cfif update neq "no">
                                            <cfquery name="insertNewInfoDisplayLang_EN" datasource="#application.dbSrc#">
                                            	INSERT INTO display_language
                                                   (display_id
                                                   ,language_id
                                                   ,display_text
                                                   ,update_flag)
                                                VALUES
                                                   (#str_info_display_id#, 'EN', '#str_info#', 1)
                                            </cfquery>
                                            <cfquery name="insertNewInfoDisplayLang_ES" datasource="#application.dbSrc#">
                                            	INSERT INTO display_language
                                                   (display_id
                                                   ,language_id
                                                   ,display_text
                                                   ,update_flag)
                                                VALUES
                                                   (#str_info_display_id#, 'ES', '', 0)
                                            </cfquery>
                                            <cfquery name="chkNewInfoDisplayLang" datasource="#application.dbSrc#">
                                            	Select count(*) from display_language
                                                where display_id = #str_info_display_id# and language_id = 'EN'
                                            </cfquery>
											<cfif chkNewInfoDisplayLang.recordCount eq 0>
												<cfset update="no">
                                        	</cfif>
										</cfif>             
                                        <cfif update neq "no">                           
											<!--- Insert New entrypoint --->
                                            <cfquery name="insertNewEntrypoint" datasource="#application.dbSrc#">
                                                INSERT INTO entrypoint
                                                   (code
                                                   ,name
                                                   ,subname
                                                   ,address1
                                                   ,address2
                                                   ,address3
                                                   ,city
                                                   ,state_id
                                                   ,zipcode
                                                   ,zipcode_plus4
                                                   ,email
                                                   ,url
                                                   ,hours_display_id
                                                   ,info_display_id
                                                   ,contact_title
                                                   ,contact_first
                                                   ,contact_middle
                                                   ,contact_last
                                                   ,contact_suffix
                                                   ,privatephone
                                                   ,last_update
                                                   ,active_flag
                                                   ,notes
                                                   ,create_user_id
                                                   ,create_date
                                                   ,modify_user_id
                                                   ,modify_date)
                                                VALUES
                                                   ('#newcode#'
                                                   ,'#str_name#'
                                                   ,'#str_subname#'
                                                   ,'#str_address1#'
                                                   ,'#str_address2#'
                                                   ,'#str_address3#'
                                                   ,'#str_city#'
                                                   ,'#str_state_id#'
                                                   ,'#str_zipcode#'
                                                   ,'#str_zipcode_plus4#'
                                                   ,'#str_email#'
                                                   ,'#str_url#'
                                                   ,#str_hours_display_id#
                                                   ,#str_info_display_id#
                                                   ,'#str_contact_title#'
                                                   ,'#str_contact_first#'
                                                   ,'#str_contact_middle#'
                                                   ,'#str_contact_last#'
                                                   ,'#str_contact_suffix#'
                                                   ,'#str_privatephone#'
                                                   ,'#str_date#'
                                                   ,#str_active_flag#
                                                   ,'#str_notes#'
                                                   ,#session.user_id#
                                                   ,'#str_date#'
                                                   ,#session.user_id#
                                                   ,'#str_date#');
                                            	SELECT LAST_INSERT_ID() as newEPid
                                            </cfquery>
                                           <cfif insertNewEntrypoint.newEPid neq "">
                                            	<cfoutput><cfset str_entrypoint_id="#insertNewEntrypoint.newEPid#"></cfoutput>
                                            <cfelse>
                                            	<cfset update="no">
                                            </cfif> 
                                        </cfif> 
                                                
                                        <cfif update neq "no">
                                        	<cfquery name="getPreCT" datasource="#application.dbSrc#">
                                            	Select count(entrypoint_id) as preCT
                                                from entrypoint_entrypointgroup
                                            </cfquery>
											<!--- Insert New entrypoint / entrypoint group association --->
                                            <cfquery name="insertEp_GrpAssoc" datasource="#application.dbSrc#">
                                            	INSERT INTO entrypoint_entrypointgroup
                                                   (entrypoint_id
                                                   ,entrypointgroup_id)
                                                VALUES
                                                   (#str_entrypoint_id#, #str_entrypointgroup_id#)
                                            </cfquery>
                                            <cfquery name="getPostCT" datasource="#application.dbSrc#">
                                            	Select count(entrypoint_id) as postCT
                                                from entrypoint_entrypointgroup
                                            </cfquery>
											<cfset diff = #getPostCT.postCT# - #getPreCT.preCT#>
                                            <cfif diff eq 0>
                                               	<cfset update="no">
                                            </cfif>
                                        </cfif>
                                        <cfif update neq "no">
											<!--- Insert New Phone Data --->
                                            <cfif str_voice neq ''>
                                                <cfquery name="insertNewPhone_Type1" datasource="#application.dbSrc#">
                                                    INSERT INTO `phone`
                                                       (entrypoint_id
                                                       ,phonetype_id
                                                       ,number
                                                       ,`sort`)
                                                     VALUES
                                                       (#str_entrypoint_id#, 1, '#str_voice#', 2);
                                                    SELECT LAST_INSERT_ID() as newPHid_1;
                                                </cfquery>
                                                <cfif insertNewPhone_Type1.newPHid_1 eq "">
                                               		<cfset update="no">
                                            	</cfif>
                                            </cfif>
                                        </cfif>
                                        
                                        <cfif update neq "no">
											<cfif str_fax neq ''>
                                                <cfquery name="insertNewPhone_Type2" datasource="#application.dbSrc#">
                                                    INSERT INTO `phone`
                                                       (entrypoint_id
                                                       ,phonetype_id
                                                       ,number
                                                       ,`sort`)
                                                     VALUES
                                                       (#str_entrypoint_id#, 2, '#str_fax#', 6);
                                               		SELECT LAST_INSERT_ID() as newPHid_2
                                                </cfquery>
                                                <cfif insertNewPhone_Type2.newPHid_2 eq "">
                                                	<cfset update="no">
                                            	</cfif>
                                            </cfif>
                                        </cfif>
                                        
                                        <cfif update neq "no">
											<cfif str_tty neq ''>
                                                <cfquery name="insertNewPhone_Type3" datasource="#application.dbSrc#">
                                                    INSERT INTO `phone`
                                                       (entrypoint_id
                                                       ,phonetype_id
                                                       ,number
                                                       ,`sort`)
                                                     VALUES
                                                       (#str_entrypoint_id#, 3, '#str_tty#', 3);
                                                  	SELECT LAST_INSERT_ID() as newPHid_3
                                                </cfquery>
                                                <cfif insertNewPhone_Type3.newPHid_3 eq "">
                                               		<cfset update="no">
                                            	</cfif>
                                            </cfif>
                                        </cfif>
                                        
                                        <cfif update neq "no">
											<cfif str_toll_free neq ''>
                                                <cfquery name="insertNewPhone_Type4" datasource="#application.dbSrc#">
                                                    INSERT INTO `phone`
                                                       (entrypoint_id
                                                       ,phonetype_id
                                                       ,number
                                                       ,`sort`)
                                                     VALUES
                                                       (#str_entrypoint_id#, 4, '#str_toll_free#', 1);
                                                	SELECT LAST_INSERT_ID() as newPHid_4
                                                </cfquery>
                                                <cfif insertNewPhone_Type4.newPHid_4 eq "">
                                               		<cfset update="no">
                                            	</cfif>
                                            </cfif>
										</cfif>
                                        <cfif update neq "no">
											<cfif str_translation neq ''>
                                                <cfquery name="insertNewPhone_Type5" datasource="#application.dbSrc#">
                                                    INSERT INTO `phone`
                                                       (entrypoint_id
                                                       ,phonetype_id
                                                       ,number
                                                       ,`sort`)
                                                    VALUES
                                                       (#str_entrypoint_id#, 5, '#str_translation#', 5);
                                                    SELECT LAST_INSERT_ID() as newPHid_5
                                                </cfquery>
                                                <cfif insertNewPhone_Type5.newPHid_5 eq "">
                                               		<cfset update="no">
                                            	</cfif>
                                            </cfif>
                                     	</cfif>
                                        <cfif update neq "no">
                                            <cfif str_spanish neq ''>
                                                <cfquery name="insertNewPhone_Type6" datasource="#application.dbSrc#">
                                                    INSERT INTO `phone`
                                                       (entrypoint_id
                                                       ,phonetype_id
                                                       ,number
                                                       ,`sort`)
                                                     VALUES
                                                       (#str_entrypoint_id#, 6, '#str_spanish#', 4);
                                                     SELECT LAST_INSERT_ID() as newPHid_6
                                                </cfquery>
                                                <cfif insertNewPhone_Type6.newPHid_6 eq "">
                                               		<cfset update="no">
                                            	</cfif>
                                            </cfif>
                                        </cfif>
                                        <cfif update eq "no">
                                        	<!--- Add ln to array as skipped --->
                                	    	<cfset arrayIndex = arrayIndex + 1>
                                	    	<cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                            <cfoutput>ln 650: |#lineNum#| added to notInserted array</cfoutput>
                                        </cfif>
                                        <!--- END Handlers for new entrypoint --->
                                    <cfelseif str_entrypoint_id neq "" and str_hours_display_id neq "" and str_info_display_id neq "">
                                        <!--- BEGIN entrypoint updates --->
                                        <cfset updateEP = "yes">
                                        <!--- GENERAL ERROR CHECK - entrypoint_id--->
                                        <cfquery name="validateEP" datasource="#application.dbSrc#">
                                	    	Select * from entrypoint where entrypoint_id = #str_entrypoint_id#
                                		</cfquery>
                                		<!--- If entrypoint_display_id is not valid skip entrypoint--->
                                		<cfif validateEP.RecordCount neq 1>
                                	    	<cfset updateEP = "no">
                                	    	<!--- Add ln to array as skipped --->
                                	    	<cfset arrayIndex = arrayIndex + 1>
                                	    	<cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                		</cfif>
                                        
										<!--- GENERAL ERROR CHECK - hours_display_id--->
                                        <cfquery name="validateHD" datasource="#application.dbSrc#">
                                	    	Select * from display where display_id = #str_hours_display_id#
                                		</cfquery>
                                		<!--- If hours_display_id is not valid skip entrypoint--->
                                		<cfif validateHD.RecordCount neq 1>
                                	    	<cfset updateEP = "no">
                                	    	<!--- Add ln to array as skipped --->
                                	    	<cfset arrayIndex = arrayIndex + 1>
                                	    	<cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                		</cfif>   
                                                            
                                        <!--- GENERAL ERROR CHECK - info_display_id--->
                                        <cfquery name="validateID" datasource="#application.dbSrc#">
                                	    	Select * from display where display_id = #str_info_display_id#
                                		</cfquery>
                                		<!--- If info_display_id is not valid skip entrypoint--->
                                		<cfif validateID.RecordCount neq 1>
                                	    	<cfset updateEP = "no">
                                	    	<!--- Add ln to array as skipped --->
                                	    	<cfset arrayIndex = arrayIndex + 1>
                                	    	<cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                		</cfif>            
                                        
                                        <!--- Update entrypoint --->
                                        <cfif updateEP eq "yes">
                                            <cfquery name="updateEP" datasource="#application.dbSrc#">
                                            	UPDATE entrypoint
                                               	SET `name` = '#str_name#'
                                                  ,subname = '#str_subname#'
                                                  ,address1 = '#str_address1#'
                                                  ,address2 = '#str_address2#'
                                                  ,address3 = '#str_address3#'
                                                  ,city = '#str_city#'
                                                  ,state_id = '#str_state_id#'
                                                  ,zipcode = '#str_zipcode#'
                                                  ,zipcode_plus4 = '#str_zipcode_plus4#'
                                                  ,email = '#str_email#'
                                                  ,url = '#str_url#'
                                                  ,hours_display_id = #str_hours_display_id#
                                                  ,info_display_id = #str_info_display_id#
                                                  ,contact_title = '#str_contact_title#'
                                                  ,contact_first = '#str_contact_first#'
                                                  ,contact_middle = '#str_contact_middle#'
                                                  ,contact_last = '#str_contact_last#'
                                                  ,contact_suffix = '#str_contact_suffix#'
                                                  ,privatephone = '#str_privatephone#'
                                                  ,last_update = '#str_date#'
                                                  ,active_flag = '#str_active_flag#'
                                                  ,notes = '#str_notes#'
                                                  ,modify_user_id = '#session.user_id#'
                                                  ,modify_date = '#str_date#'
                                             	WHERE entrypoint_id = #str_entrypoint_id#;
                                               	Select ROW_COUNT() as updateEPct;
                                            </cfquery>
                                            <cfif updateEP.updateEPct neq 1>
												<cfset update = "no">
                                            </cfif>
                                            
                                            <!--- Check if EP_EPG record exists. If not exists, insert one. --->
                                            <cfif update neq "no">
                                        		<!--- Check if EP_EPG record exists--->
                                                <cfquery name="getEP_EPG_assocCT" datasource="#application.dbSrc#">
                                            		Select count(entrypoint_id) as assocCT
                                                	from entrypoint_entrypointgroup
                                                    where entrypoint_id = #str_entrypoint_id# and entrypointgroup_id = #str_entrypointgroup_id#
                                            	</cfquery>
												<!--- Insert New entrypoint / entrypoint group association if one doesn't already exisit --->
                                                <cfif getEP_EPG_assocCT.assocCT eq 0>
                                            		<cfquery name="getPreCT2" datasource="#application.dbSrc#">
                                            			Select count(entrypoint_id) as preCT2 
                                                		from entrypoint_entrypointgroup
                                            		</cfquery>
                                                    <cfquery name="insertEp_GrpAssoc2" datasource="#application.dbSrc#">
                                                        INSERT INTO entrypoint_entrypointgroup
                                                            (entrypoint_id
                                                            ,entrypointgroup_id)
                                                        VALUES
                                                            (#str_entrypoint_id#, #str_entrypointgroup_id#)
                                                    </cfquery>
                                                    <cfquery name="getPostCT2" datasource="#application.dbSrc#">
                                                        Select count(entrypoint_id) as postCT2
                                                        from entrypoint_entrypointgroup
                                                    </cfquery>
                                                    <cfset diff2 = #getPostCT2.postCT2# - #getPreCT2.preCT2#>
                                                    <cfif diff2 eq 0>
                                                        <cfset update="no">
                                                    </cfif>
												</cfif>
                                            </cfif>
                                            
                                            <cfif update neq "no">
                                            	<!--- Update info_display text--->
                                            	<cfquery name="updateInfoText" datasource="#application.dbSrc#">
                                                    UPDATE display_language
                                                   	SET display_text = '#str_info#'
                                                      	, update_flag = 1
                                                 	WHERE display_id = #str_info_display_id# and language_id = 'EN';
                                                    Select ROW_COUNT() as updateInfoTextct
                                                </cfquery>
                                                <cfif updateInfoText.updateInfoTextct neq 1>
                                                	<cfset update = "no">
                                                </cfif>
                                            </cfif>
                                            
                                            <cfif update neq "no">
                                            	<!--- Update hours_display text--->
                                            	<cfquery name="updateHoursText" datasource="#application.dbSrc#">
                                                    UPDATE display_language
                                                   	SET display_text = '#str_hours#'
                                                      	,update_flag = 1
                                                 	WHERE display_id = #str_hours_display_id# and language_id = 'EN';
                                                    Select ROW_COUNT() as updateHoursTextct
                                                </cfquery>
                                                <cfif updateHoursText.updateHoursTextct neq 1>
                                                	<cfset update = "no">
                                                </cfif>
                                            </cfif>
                                            
                                            <!--- Update/Insert Phone Data --->
                                            <cfif update neq "no">
                                            	<cfquery name="chkPhone_Type1" datasource="#application.dbSrc#">
                                                    select * from phone
                                                    where entrypoint_id = #str_entrypoint_id# and phonetype_id = 1
                                                </cfquery>   
                                                <cfif chkPhone_Type1.RecordCount eq 1>
                                                	<cfif str_voice eq ''>
                                                    	<cfquery name="delPhone_Type1" datasource="#application.dbSrc#">
                                                    		Delete from `phone` 
                                                    		where entrypoint_id = #str_entrypoint_id# and phonetype_id = 1
                                                		</cfquery>  
                                                	<cfelse>
                                                    	<cfquery name="updatePhone_Type1" datasource="#application.dbSrc#">	
                                                            UPDATE `phone`
                                                          	SET `number` = '#str_voice#'
                                                            	, `sort` = 2
                                                          	WHERE entrypoint_id = #str_entrypoint_id# and phonetype_id = 1;
                                                            Select ROW_COUNT() as updatePhone1ct
                                                       	</cfquery>
                                                        <cfif updatePhone_Type1.updatePhone1ct neq 1>
                                                			<cfset update = "no">
                                                		</cfif>                                                 
                                                    </cfif>
                                                <cfelseif chkPhone_type1.RecordCount eq 0>
                                                	<cfif str_voice neq ''>
                                                        <cfquery name="insertPhone_Type1" datasource="#application.dbSrc#">
                                                            INSERT INTO `phone`
                                                               (entrypoint_id
                                                               ,phonetype_id
                                                               ,number
                                                               ,`sort`)
                                                             VALUES
                                                               (#str_entrypoint_id#, 1, '#str_voice#', 2);
                                                             SELECT LAST_INSERT_ID() as newPhone1id;
                                                        </cfquery>
                                                        <cfif insertPhone_Type1.newPhone1id eq "">
                                               				<cfset update="no">
                                            			</cfif>
                                                    </cfif>
                                                </cfif>
                                            </cfif>
                                            
											<cfif update neq "no">
                                            	<cfquery name="chkPhone_Type2" datasource="#application.dbSrc#">
                                                    select * from phone
                                                    where entrypoint_id = #str_entrypoint_id# and phonetype_id = 2
                                                </cfquery>   
                                                <cfif chkPhone_Type2.RecordCount eq 1>
                                                	<cfif str_fax eq ''>
                                                    	<cfquery name="delPhone_Type2" datasource="#application.dbSrc#">
                                                    		Delete from `phone` 
                                                    		where entrypoint_id = #str_entrypoint_id# and phonetype_id = 2
                                                		</cfquery>  
                                                	<cfelse>
                                                    	<cfquery name="updatePhone_Type2" datasource="#application.dbSrc#">	
                                                            UPDATE `phone`
                                                          	SET `number` = '#str_fax#'
                                                            	, `sort` = 6
                                                          	WHERE entrypoint_id = #str_entrypoint_id# and phonetype_id = 2;
                                                            Select ROW_COUNT() as updatePhone2ct
                                                       	</cfquery>
                                                        <cfif updatePhone_Type2.updatePhone2ct neq 1>
                                                			<cfset update = "no">
                                                		</cfif>                                                 
                                                    </cfif>
                                                <cfelseif chkPhone_type2.RecordCount eq 0>
                                                	<cfif str_fax neq ''>
                                                        <cfquery name="insertPhone_Type2" datasource="#application.dbSrc#">
                                                            INSERT INTO `phone`
                                                               (entrypoint_id
                                                               ,phonetype_id
                                                               ,`number`
                                                               ,`sort`)
                                                             VALUES
                                                               (#str_entrypoint_id#, 2, '#str_fax#', 6);
                                                             SELECT LAST_INSERT_ID() as newPhone2id
                                                        </cfquery>
                                                        <cfif insertPhone_Type2.newPhone2id eq "">
                                               				<cfset update="no">
                                            			</cfif>
                                                    </cfif>
                                                </cfif>
                                            </cfif>
                                            
                                            <cfif update neq "no">
                                            	<cfquery name="chkPhone_Type3" datasource="#application.dbSrc#">
                                                    select * from phone
                                                    where entrypoint_id = #str_entrypoint_id# and phonetype_id = 3
                                                </cfquery>   
                                                <cfif chkPhone_Type3.RecordCount eq 1>
                                                	<cfif str_tty eq ''>
                                                    	<cfquery name="delPhone_Type3" datasource="#application.dbSrc#">
                                                    		Delete from `phone` 
                                                    		where entrypoint_id = #str_entrypoint_id# and phonetype_id = 3
                                                		</cfquery>  
                                                	<cfelse>
                                                    	<cfquery name="updatePhone_Type3" datasource="#application.dbSrc#">	

                                                            UPDATE `phone`
                                                          	SET `number` = '#str_tty#'
                                                            	, `sort` = 3
                                                          	WHERE entrypoint_id = #str_entrypoint_id# and phonetype_id = 3;
                                                            Select ROW_COUNT() as updatePhone3ct
                                                       	</cfquery>
                                                        <cfif updatePhone_Type3.updatePhone3ct neq 1>
                                                			<cfset update = "no">
                                                		</cfif>                                                 
                                                    </cfif>
                                                <cfelseif chkPhone_type3.RecordCount eq 0>
                                                	<cfif str_tty neq ''>
                                                        <cfquery name="insertPhone_Type3" datasource="#application.dbSrc#">

                                                            INSERT INTO `phone`
                                                               (entrypoint_id
                                                               ,phonetype_id
                                                               ,`number`
                                                               ,`sort`)
                                                             VALUES
                                                               (#str_entrypoint_id#, 3, '#str_tty#', 3);
                                                             SELECT LAST_INSERT_ID() as newPhone3id

                                                        </cfquery>
                                                        <cfif insertPhone_Type3.newPhone3id eq "">
                                               				<cfset update="no">
                                            			</cfif>
                                                    </cfif>
                                                </cfif>
                                            </cfif>
                                            
                                            <cfif update neq "no">
                                            	<cfquery name="chkPhone_Type4" datasource="#application.dbSrc#">
                                                    select * from phone 
                                                    where entrypoint_id = #str_entrypoint_id# and phonetype_id = 4
                                                </cfquery>   
                                                <cfif chkPhone_Type4.RecordCount eq 1>
                                                	<cfif str_toll_free eq ''>
                                                    	<cfquery name="delPhone_Type4" datasource="#application.dbSrc#">
                                                    		Delete from `phone` 
                                                    		where entrypoint_id = #str_entrypoint_id# and phonetype_id = 4
                                                		</cfquery>  
                                                	<cfelse>
                                                    	<cfquery name="updatePhone_Type4" datasource="#application.dbSrc#">	

                                                            UPDATE `phone`
                                                          	SET `number` = '#str_toll_free#'
                                                            	, `sort` = 1
                                                          	WHERE entrypoint_id = #str_entrypoint_id# and phonetype_id = 4;
                                                            Select ROW_COUNT() as updatePhone4ct

                                                       	</cfquery>
                                                        <cfif updatePhone_Type4.updatePhone4ct neq 1>
                                                			<cfset update = "no">
                                                		</cfif>                                                 
                                                    </cfif>
                                                <cfelseif chkPhone_type4.RecordCount eq 0>
                                                	<cfif str_toll_free neq ''>
                                                        <cfquery name="insertPhone_Type4" datasource="#application.dbSrc#">

                                                            INSERT INTO `phone`
                                                               (entrypoint_id
                                                               ,phonetype_id
                                                               ,`number`
                                                               ,`sort`)
                                                             VALUES
                                                               (#str_entrypoint_id#, 4, '#str_toll_free#', 1);
                                                             SELECT LAST_INSERT_ID() as newPhone4id
                                                        </cfquery>
                                                        <cfif insertPhone_Type4.newPhone4id eq "">
                                               				<cfset update="no">
                                            			</cfif>
                                                    </cfif>
                                                </cfif>
                                            </cfif>
                                            
                                            <cfif update neq "no">
                                            	<cfquery name="chkPhone_Type5" datasource="#application.dbSrc#">
                                                    select * from phone
                                                    where entrypoint_id = #str_entrypoint_id# and phonetype_id = 5
                                                </cfquery>   
                                                <cfif chkPhone_Type5.RecordCount eq 1>
                                                	<cfif str_translation eq ''>
                                                    	<cfquery name="delPhone_Type5" datasource="#application.dbSrc#">
                                                    		Delete from `phone` 
                                                    		where entrypoint_id = #str_entrypoint_id# and phonetype_id = 5
                                                		</cfquery>  
                                                	<cfelse>
                                                    	<cfquery name="updatePhone_Type5" datasource="#application.dbSrc#">	

                                                            UPDATE `phone`
                                                          	SET `number` = '#str_translation#'
                                                            	, `sort` = 5
                                                          	WHERE entrypoint_id = #str_entrypoint_id# and phonetype_id = 5;
                                                            Select ROW_COUNT() as updatePhone5ct

                                                       	</cfquery>
                                                        <cfif updatePhone_Type5.updatePhone5ct neq 1>
                                                			<cfset update = "no">
                                                		</cfif>                                                 
                                                    </cfif>
                                                <cfelseif chkPhone_type5.RecordCount eq 0>
                                                	<cfif str_translation neq ''>
                                                        <cfquery name="insertPhone_Type5" datasource="#application.dbSrc#">

                                                            INSERT INTO `phone`
                                                               (entrypoint_id
                                                               ,phonetype_id
                                                               ,`number`
                                                               ,`sort`)
                                                             VALUES
                                                               (#str_entrypoint_id#, 5, '#str_translation#', 5);
                                                             SELECT LAST_INSERT_ID() as newPhone5id

                                                        </cfquery>
                                                        <cfif insertPhone_Type5.newPhone5id eq "">
                                               				<cfset update="no">
                                            			</cfif>
                                                    </cfif>
                                                </cfif>
                                            </cfif>
                                            
                                            <cfif update neq "no">
                                            	<cfquery name="chkPhone_Type6" datasource="#application.dbSrc#">
                                                    select * from phone
                                                    where entrypoint_id = #str_entrypoint_id# and phonetype_id = 6
                                                </cfquery>   
                                                <cfif chkPhone_Type6.RecordCount eq 1>
                                                	<cfif str_spanish eq ''>
                                                    	<cfquery name="delPhone_Type6" datasource="#application.dbSrc#">
                                                    		Delete from `phone` 
                                                    		where entrypoint_id = #str_entrypoint_id# and phonetype_id = 6
                                                		</cfquery>  
                                                	<cfelse>
                                                    	<cfquery name="updatePhone_Type6" datasource="#application.dbSrc#">	

                                                            UPDATE `phone`
                                                          	SET `number` = '#str_spanish#'
                                                            	, `sort` = 4
                                                          	WHERE entrypoint_id = #str_entrypoint_id# and phonetype_id = 6;
                                                            Select ROW_COUNT() as updatePhone6ct

                                                       	</cfquery>
                                                        <cfif updatePhone_Type6.updatePhone6ct neq 1>
                                                			<cfset update = "no">
                                                		</cfif>                                                 
                                                    </cfif>
                                                <cfelseif chkPhone_type6.RecordCount eq 0>
                                                	<cfif str_spanish neq ''>
                                                        <cfquery name="insertPhone_Type6" datasource="#application.dbSrc#">

                                                            INSERT INTO `phone`
                                                               (entrypoint_id
                                                               ,phonetype_id
                                                               ,`number`
                                                               ,`sort`)
                                                             VALUES
                                                               (#str_entrypoint_id#, 6, '#str_spanish#', 4);
                                                             SELECT LAST_INSERT_ID() as newPhone6id

                                                        </cfquery>
                                                        <cfif insertPhone_Type6.newPhone6id eq "">
                                               				<cfset update="no">
                                            			</cfif>
                                                    </cfif>
                                                </cfif>
                                            </cfif>
                                            <cfif update eq "no">
                                        		<!--- Add ln to array as skipped --->
                                	    		<cfset arrayIndex = arrayIndex + 1>
                                	    		<cfset notInserted[#arrayIndex#] =  "#lineNum#">
                                        	</cfif>
                                            <!--- END entrypoint updates --->   
                                    	</cfif> 
                                    <cfelse>
                                    	<cfset noactionMsg="The file was not uploaded successfully! Please verify entrypointgroup_id, entrypoint_id, hours_display_id and info_display_id exist as specified and are accurate for those entrypoints you wish to insert/update.">
                                    </cfif>
                                </cfif>
                                <cfset lineNum = lineNum + 1>     
                            <cfelse>
								<cfset firstLine = "no">
							</cfif>
						</cfloop>
                    </cfif>    
					<!--- Interface Handlers --->		
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
                        <form name="uploadForm_#vcounter#" enctype="multipart/form-data" method="post">
                        	<div id="uploadFile_div#vcounter#" align="center">
                            	<BR />
                            	<input type="hidden" name="fileName" value="importEP">
                                <input type="hidden" name="fileType" value="#text#">
                                <input type="file" name="fileUpload" />&nbsp;
                                <input type="button" name="sub#vcounter#" value="Upload" onclick="javascript:checkFields(#vcounter#);"/>
                                <BR />
                            </div>				
                        </form>
                 	</cfloop>
	            </cfif>    
           	</td>
        </tr>
        <!--- Show CSV rows that were skipped --->
        <cfset numSkipped = #ArrayLen(notInserted)#>
        <cfif isDefined("fileUpload")>
        	<tr bgcolor="#localmed#">
                <td>
					<cfif numSkipped gt 0><BR />
                    	The entrypoint file upload is complete.<BR />
                        Rows that are skipped are caused by one or more of the following issues:<BR />
                        <ol>
                            <li>entrypointgroup_id is not a number or does not exist in DC</li>
                            <li>required name is missing</li>
                            <li>active_flag is not 1 or 0</li>
                            <li>hours_display_id does not exist in DC or was omitted</li>
                            <li>info_display_id does not exist in DC or was omitted</li>
                            <li>entrypoint_id is not a number or does not exist in DC</li>
                            <li>state_id provided does not contain letters only and/or does not have 2 characters (state_id is NOT required)</li>
                            <li>zipcode provided does not contain numbers only and/or does not have 5 digits (zipcode is NOT required)</li>
                            <li>zipcode_plus4 provided does not contain numbers only and/or does not have 4 digits (zipcode_plus4 is NOT required)</li>
                        </ol>
                        <table border='1' cellspacing="5">
                        	<tr>
                            	<td width='75%' valign="top">Click on the green rectangle labelled <b><i>array</i></b> below to view the rows that were skipped.<BR />
                        			The 1st column in <b><i>array</i></b> is a count of the rows skipped.<BR />
                        			The 2nd column in <b><i>array</i></b> corresponds to the row in the uploaded CSV that was skipped.<BR /> </td>
                        		<td width='25%' align='center' valign="top"><cfdump var=#notInserted#></td>
                           	</tr>
                      	</table>
   					<cfelse>
                    	<font size="+1"><BR />
                        	<cfif Not IsDefined("noactionMsg")>
                            	The entrypoint file upload was 100% successful.<BR />No rows were skipped.
                             <cfelse>
                             	#Trim(noactionMsg)#
                             </cfif>
                             </font><BR /><BR />
                	</cfif>
                </td>
            </tr>
        </cfif>
        <cfif Not isDefined("fileUpload")>
            <tr bgcolor="#locallight#">
                <td>
                    This tool accepts CSV files only.<BR />
                    It is assumed that the first row/line in the CSV contains field names.<BR>
                    The tool can be used to insert, update and make active entrypoints inactive.<BR><BR />
                    To prepare the CSV file to be imported you will need to do the following:<BR />
                    <ol>
						<li>Prepare the import CSV as defined in <a href="importDefinition.htm" target="_blank">Entry Point Import CSV Column Definitions</a>.</li>
						<li>Open the CSV in Excel. Select all of the active cells and replace all commas (,) with the caret symbol (^). Search on the<BR />active_flag column for blanks correcting them as appropriate (active_flag cannot be blank).<BR />Save and close the csv file.</li>
						<li>Then, open the CSV in Notepad. Use Ctrl + H to open up the Find/Replace tool. Replace ,, with ,|, by clicking on the 'Replace<BR />All' button TWICE. Save and close the csv file.</li>
						<li>The CSV file should be ready to be uploaded.</li>
                    </ol>
                    <u>To upload a new entry point data set:</u>
                    <ol>
                        <li>Browse to the CSV file that you wish to upload.</li>
                        <li>Click the <i>'Upload'</i> button <b>once</b>.</li>
                        <li>Clicking multiple times will cause the data to load with errors.</li>
                        <li>Upload times will vary depending upon the size of the data and<BR />the number of new entrypoints included in the CSV being uploaded.</li>
                        <li>Once the upload process is complete, a message will appear<BR />summarizing the rows added/updated and an expandable list of the<BR />rows that were skipped.</li>
                    </ol><BR />
                </td>
            </tr>
        </cfif>
    </table>
</cfoutput>
</cfif>