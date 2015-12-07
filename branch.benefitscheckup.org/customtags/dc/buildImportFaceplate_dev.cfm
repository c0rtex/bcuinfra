<cfparam name="attributes.code" type="string">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.objectType" type="string" default="">

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>

<cfset locallight = "##F4E3BD">
<cfset localmed = "##F0D79F">
<cfset localdark ="##E8C26C">

<!---<cfset locallight = Evaluate("application.color.export.light")>
<cfset localmed = Evaluate("application.color.export.med")>
<cfset localdark = Evaluate("application.color.export.dark")>--->

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
		<td colspan="2"><font size="+1"><cfif IsDefined('ThisTag.AssocAttribs') and ArrayLen(ThisTag.AssocAttribs) eq 1>This button<cfelse>These buttons</cfif> will let you upload the current #attributes.objectType# data in CSV format:</font></td>
	</tr>
	<tr bgcolor="#locallight#">
		<td><ul><br />
	<cfif IsDefined('ThisTag.AssocAttribs')>
		<!--- Array to hold unsuccessful insert references --->
		<cfset notInserted = ArrayNew(1)>
		<cfset arrayIndex = 0>
		<cfset numLine = 0>
		<cfif isDefined("fileUpload")>
			<cfset dest = "lookup_util_import\" & "#fileName#" & ".csv">
			<cffile action="upload" fileField="fileUpload" destination="#dest#" accept="application/csv,text/comma-separated-values,text/csv,application/excel,application/vnd.ms-excel,application/vnd.msexcel,text/anytext,application/octet-stream" nameConflict="overwrite">
			<cfif fileName IS "lookupimport">
				<cfquery name="purgeTbl1" datasource="#application.dbSrc#">
					DELETE FROM tbl_inc_new_temp
				</cfquery>
				<cfset firstLine = 'yes'>
				<cfloop file="#dest#" index="line">
					<cfset counter = 1>
					<cfset lineNum = 1>
					<cfset tbl_id = 0>
       					<cfset str_proc_id="">
					<cfset str_tbl_nm="">
					<cfset str_st="">
					<cfset str_county="">
					<cfset str_mem1="">
					<cfset str_mem2="">
					<cfset str_mem3="">
					<cfset str_mem4="">
					<cfset str_mem5="">
					<cfset str_mem6="">
					<cfset str_mem7="">
					<cfset str_mem8="">
					<cfset str_moddate="">
					<cfif firstLine NEQ "yes">
					<cfset line = Replace(trim(line),""",""",":|","ALL")> 
					<cfloop list="#line#" index="fielddata" delimiters=":">
						<cfscript>
                					if (counter EQ 1){
								tbl_id = Replace(trim(fielddata),'"','',"ALL");
								tbl_id = Replace(trim(tbl_id),'|','',"ALL");
							}
							else if (counter EQ 2){
								str_proc_id = Replace(trim(fielddata),'"','',"ALL");
								str_proc_id = Replace(trim(str_proc_id),'|','',"ALL");
							}
							else if (counter EQ 3){
								str_tbl_nm = Replace(trim(fielddata),'"','',"ALL");
								str_tbl_nm = Replace(trim(str_tbl_nm),'|','',"ALL");
							}
                    					else if (counter EQ 4){
								str_st = Replace(trim(fielddata),'"','',"ALL");
								str_st = Replace(trim(str_st),'|','',"ALL");
							}
                    					else if (counter EQ 5){
								str_county = Replace(trim(fielddata),'"','',"ALL");
								str_county = Replace(trim(str_county),'|','',"ALL");
							}
							else if (counter EQ 6){
								str_mem1 = Replace(trim(fielddata),'"','',"ALL");
								str_mem1 = Replace(trim(str_mem1),'|','',"ALL");
							}
							else if (counter EQ 7){
								str_mem2 = Replace(trim(fielddata),'"','',"ALL");
								str_mem2 = Replace(trim(str_mem2),'|','',"ALL");
							}
							else if (counter EQ 8){
								str_mem3 = Replace(trim(fielddata),'"','',"ALL");
								str_mem3 = Replace(trim(str_mem3),'|','',"ALL");
							}
							else if (counter EQ 9){
								str_mem4 = Replace(trim(fielddata),'"','',"ALL");
								str_mem4 = Replace(trim(str_mem4),'|','',"ALL");
							}
							else if (counter EQ 10){
								str_mem5 = Replace(trim(fielddata),'"','',"ALL");
								str_mem5 = Replace(trim(str_mem5),'|','',"ALL");
							}
							else if (counter EQ 11){
								str_mem6 = Replace(trim(fielddata),'"','',"ALL");
								str_mem6 = Replace(trim(str_mem6),'|','',"ALL");
							}
							else if (counter EQ 12){
								str_mem7 = Replace(trim(fielddata),'"','',"ALL");
								str_mem7 = Replace(trim(str_mem7),'|','',"ALL");
							}
							else if (counter EQ 13){
								str_mem8 = Replace(trim(fielddata),'"','',"ALL");
								str_mem8 = Replace(trim(str_mem8),'|','',"ALL");
							}
							
							counter = counter + 1;    
						</cfscript>
						<cfset str_moddate="#DateFormat(Now())#">
					</cfloop>
					<cftry>
						<cfset numLine = numLine + 1>
						<cfquery name="updateIncNewTemp" datasource="#application.dbSrc#">
          						INSERT INTO tbl_inc_new_temp
								(proc_id,tbl_nm,st,county,mem1,mem2,mem3,mem4,mem5,mem6,mem7,mem8,moddate)
     							VALUES ('#str_proc_id#','#str_tbl_nm#','#str_st#','#str_county#','#str_mem1#','#str_mem2#','#str_mem3#','#str_mem4#','#str_mem5#','#str_mem6#','#str_mem7#','#str_mem8#','#str_moddate#')
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
			<cfelseif fileName IS "mxincomeimport">
				<cfquery name="purgeTbl2" datasource="#application.dbSrc#">
					DELETE FROM tbl_mx_income_temp
				</cfquery>
				<cfset firstLine = 'yes'>
				<cfset tbl_id = 1>
				<cfloop file="#dest#" index="line">
					<cfset counter = 1>
					<cfset lineNum = 1>
					<cfset str_st="">
					<cfset str_qmb_single_max=0>
					<cfset str_qmb_single_min=0>
					<cfset str_qmb_couple_max=0>
					<cfset str_qmb_couple_min=0>
					<cfset str_slmb_single_max=0>
					<cfset str_slmb_single_min=0>
					<cfset str_slmb_couple_max=0>
					<cfset str_slmb_couple_min=0>
					<cfset str_qi1_single_max=0>
					<cfset str_qi1_single_min=0>
					<cfset str_qi1_couple_max=0>
					<cfset str_qi1_couple_min=0>
					<cfif firstLine NEQ "yes">
					<cfset line = Replace(trim(line),""",""",":|","ALL")> 
        				<cfloop list="#line#" index="fielddata" delimiters=":">
						<cfscript>
                					if (counter EQ 1){
								str_st = Replace(trim(fielddata),'"','',"ALL");
								str_st = Replace(trim(str_st),'|','',"ALL");
							}
							else if (counter EQ 2){
								str_qmb_single_max = Replace(trim(fielddata),'"','',"ALL");
								str_qmb_single_max = Replace(trim(str_qmb_single_max),'|','',"ALL");
							}
							else if (counter EQ 3){
								str_qmb_single_min = Replace(trim(fielddata),'"','',"ALL");
								str_qmb_single_min = Replace(trim(str_qmb_single_min),'|','',"ALL");
							}
                    					else if (counter EQ 4){
								str_qmb_couple_max = Replace(trim(fielddata),'"','',"ALL");
								str_qmb_couple_max = Replace(trim(str_qmb_couple_max),'|','',"ALL");
							}
                    					else if (counter EQ 5){
								str_qmb_couple_min = Replace(trim(fielddata),'"','',"ALL");
								str_qmb_couple_min = Replace(trim(str_qmb_couple_min),'|','',"ALL");
							}
							else if (counter EQ 6){
								str_slmb_single_max = Replace(trim(fielddata),'"','',"ALL");
								str_slmb_single_max = Replace(trim(str_slmb_single_max),'|','',"ALL");
							}
 							else if (counter EQ 7){
								str_slmb_single_min = Replace(trim(fielddata),'"','',"ALL");
								str_slmb_single_min = Replace(trim(str_slmb_single_min),'|','',"ALL");
							}
                    					else if (counter EQ 8){
								str_slmb_couple_max = Replace(trim(fielddata),'"','',"ALL");
								str_slmb_couple_max = Replace(trim(str_slmb_couple_max),'|','',"ALL");
							}
                    					else if (counter EQ 9){
								str_slmb_couple_min = Replace(trim(fielddata),'"','',"ALL");
								str_slmb_couple_min = Replace(trim(str_slmb_couple_min),'|','',"ALL");
							}
							else if (counter EQ 10){
								str_qi1_single_max = Replace(trim(fielddata),'"','',"ALL");
								str_qi1_single_max = Replace(trim(str_qi1_single_max),'|','',"ALL");
							}
							else if (counter EQ 11){
								str_qi1_single_min = Replace(trim(fielddata),'"','',"ALL");
								str_qi1_single_min = Replace(trim(str_qi1_single_min),'|','',"ALL");
							}
                    					else if (counter EQ 12){
								str_qi1_couple_max = Replace(trim(fielddata),'"','',"ALL");
								str_qi1_couple_max = Replace(trim(str_qi1_couple_max),'|','',"ALL");
							}
                    					else if (counter EQ 13){
								str_qi1_couple_min = Replace(trim(fielddata),'"','',"ALL");
								str_qi1_couple_min = Replace(trim(str_qi1_couple_min),'|','',"ALL");
							}
							
							counter = counter + 1;    
						</cfscript>
					</cfloop>
					<cftry>
						<cfset numLine = numLine + 1>					
					<cfquery name="updateMxIncomeTemp_QMB" datasource="#application.dbSrc#">
          					INSERT INTO tbl_mx_income_temp
           						(tbl_id,tbl_nm,st,single_max,single_min,couple_max,couple_min)	
						VALUES (#tbl_id#,'QMB','#str_st#',#str_qmb_single_max#,#str_qmb_single_min#,#str_qmb_couple_max#,#str_qmb_couple_min#)
					</cfquery>
					<cfset tbl_id = tbl_id + 1>
					<cfquery name="updateMxIncomeTemp_SLMB" datasource="#application.dbSrc#">
          					INSERT INTO tbl_mx_income_temp
           						(tbl_id,tbl_nm,st,single_max,single_min,couple_max,couple_min)	
						VALUES (#tbl_id#,'SLMB','#str_st#',#str_slmb_single_max#,#str_slmb_single_min#,#str_slmb_couple_max#,#str_slmb_couple_min#)
					</cfquery>
					<cfset tbl_id = tbl_id + 1>
					<cfquery name="updateMxIncomeTemp_QI1" datasource="#application.dbSrc#">
          					INSERT INTO tbl_mx_income_temp
           						(tbl_id,tbl_nm,st,single_max,single_min,couple_max,couple_min)	
						VALUES (#tbl_id#,'QI1','#str_st#',#str_qi1_single_max#,#str_qi1_single_min#,#str_qi1_couple_max#,#str_qi1_couple_min#)
					</cfquery>
					<cfset tbl_id = tbl_id + 1>
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
			<cfelseif fileName IS "mxassetimport">
				<cfquery name="purgeTb3" datasource="#application.dbSrc#">
					DELETE FROM tbl_mx_asset_temp
				</cfquery>
				<cfset firstLine = 'yes'>
				<cfset tbl_id = 1>
				<cfloop file="#dest#" index="line">
					<cfset counter = 1>
					<cfset lineNum = 1>
					<cfset str_st="">
					<cfset str_qmb_single=0>
					<cfset str_qmb_couple=0>
					<cfset str_slmb_single=0>
					<cfset str_slmb_couple=0>
					<cfset str_qi1_single=0>
					<cfset str_qi1_couple=0>
					<cfset str_qi2_single=0>
					<cfset str_qi2_couple=0>
					<cfif firstLine NEQ "yes">
					<cfset line = Replace(trim(line),""",""",":|","ALL")> 
        				<cfloop list="#line#" index="fielddata" delimiters=":">
						<cfscript>
                					if (counter EQ 1){
								str_st = Replace(trim(fielddata),'"','',"ALL");
								str_st = Replace(trim(str_st),'|','',"ALL");
							}
							else if (counter EQ 2){
								str_qmb_single = Replace(trim(fielddata),'"','',"ALL");
								str_qmb_single = Replace(trim(str_qmb_single),'|','',"ALL");
							}
							else if (counter EQ 3){
								str_qmb_couple = Replace(trim(fielddata),'"','',"ALL");
								str_qmb_couple = Replace(trim(str_qmb_couple),'|','',"ALL");
							}
                    					else if (counter EQ 4){
								str_slmb_single = Replace(trim(fielddata),'"','',"ALL");
								str_slmb_single = Replace(trim(str_slmb_single),'|','',"ALL");
							}
                    					else if (counter EQ 5){
								str_slmb_couple = Replace(trim(fielddata),'"','',"ALL");
								str_slmb_couple = Replace(trim(str_slmb_couple),'|','',"ALL");
							}
							else if (counter EQ 6){
								str_qi1_single = Replace(trim(fielddata),'"','',"ALL");
								str_qi1_single = Replace(trim(str_qi1_single),'|','',"ALL");
							}
 							else if (counter EQ 7){
								str_qi1_couple = Replace(trim(fielddata),'"','',"ALL");
								str_qi1_couple = Replace(trim(str_qi1_couple),'|','',"ALL");
							}
                    					else if (counter EQ 8){
								str_qi2_single = Replace(trim(fielddata),'"','',"ALL");
								str_qi2_single = Replace(trim(str_qi2_single),'|','',"ALL");
							}
                    					else if (counter EQ 9){
								str_qi2_couple = Replace(trim(fielddata),'"','',"ALL");
								str_qi2_couple = Replace(trim(str_qi2_couple),'|','',"ALL");
							}
							
							counter = counter + 1;    
						</cfscript>
					</cfloop>
					<cftry>
						<cfset numLine = numLine + 1>					
					<cfquery name="updateMxAssetTemp_QMB" datasource="#application.dbSrc#">
          					INSERT INTO tbl_mx_asset_temp
           						(tbl_id,tbl_nm,st,single,couple)	
						VALUES (#tbl_id#,'QMB','#str_st#',#str_qmb_single#,#str_qmb_couple#)
					</cfquery>
					<cfset tbl_id = tbl_id + 1>
					<cfquery name="updateMxAssetTemp_SLMB" datasource="#application.dbSrc#">
          					INSERT INTO tbl_mx_asset_temp
           						(tbl_id,tbl_nm,st,single,couple)	
						VALUES (#tbl_id#,'SLMB','#str_st#',#str_slmb_single#,#str_slmb_couple#)
					</cfquery>
					<cfset tbl_id = tbl_id + 1>
					<cfquery name="updateMxAssetTemp_QI1" datasource="#application.dbSrc#">
          					INSERT INTO tbl_mx_asset_temp
           						(tbl_id,tbl_nm,st,single,couple)	
						VALUES (#tbl_id#,'QI1','#str_st#',#str_qi1_single#,#str_qi1_couple#)
					</cfquery>
					<cfset tbl_id = tbl_id + 1>
					<cfquery name="updateMxAssetTemp_QI2" datasource="#application.dbSrc#">
          					INSERT INTO tbl_mx_asset_temp
           						(tbl_id,tbl_nm,st,single,couple)	
						VALUES (#tbl_id#,'QI2','#str_st#',#str_qi2_single#,#str_qi2_couple#)
					</cfquery>
					<cfset tbl_id = tbl_id + 1>
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
				<p><b><i>The #fileType# uploaded successfully.</i></b></p>
			<cfelseif ((#ArrayLen(notInserted)# LT #numLine#)&&(#ArrayLen(notInserted)# GT 0))>
				<p><b><i>The #fileType# uploaded successfully except for row(s):<BR>
				|&nbsp;<cfloop index="x" array="#notInserted#">#x#&nbsp;|&nbsp;</cfloop>in the #fileName#.csv</i></b></p>
			<cfelseif #ArrayLen(notInserted)# eq #numLine#>
				<p><b><i>The #fileType# WAS NOT uploaded. Please verify the data and upload again.</p>
			</cfif>
				<p>ArraySize: #ArrayLen(notInserted)#<BR>number of Lines Read: #numLine#</p>
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
			A CSV is a comma-delimited text file that can be opened in Excel just as if it were a spreadsheet.<BR>
			This upload tool assumes that the first row/line in the CSV contains field names.<BR>
			To upload these files:
			<ol>
			<li>Browse to the CSV file that you wish to upload.</li>
			<li>Click on the appropriate button <b>once</b>.</li>
			<li>It may take up to a minute for the file to be uploaded.</li>
			</ol>
			<br />
			
		</td>
	</tr>
</table>
</cfoutput>

</cfif>