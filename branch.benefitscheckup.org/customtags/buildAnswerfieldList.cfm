<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.type" type="string" default="">
<cfparam name="attributes.format" type="string" default="">
<cfparam name="attributes.listvar" type="string" default="saflist">
<cfparam name="attributes.debug" type="string" default="">
<cfparam name="attributes.errorgroup" type="string" default="error">
<cfparam name="attributes.errorcode" type="string" default="">
<cfparam name="attributes.errortext" type="string" default="">

<cfif attributes.debug neq ''>
	<cfquery name="getAF" datasource="#application.dbSrc#">
	select q.question_id, '' + cast( a.answerfield_id as char(32)) + ': ' + a.answerfield as munge
	from question q, question_answerfield qa, answerfield a
	where q.question_code=<cfqueryparam  cfsqltype="cf_sql_varchar" maxlength="32" value="#attributes.debug#">
		and q.question_id=qa.question_id
		and qa.answerfield_id=a.answerfield_id
	order by qa.sort
	</cfquery>
	<cfoutput>
	<b>question:</b>&nbsp; #getAF.question_id#: <a href="https://data.benefitscheckup.org/question/questionview.cfm?id=#getAF.question_id#&action=edit" target="dc">#attributes.debug#</a><br>
	<b>answerfields:</b>&nbsp; #ValueList(getAF.munge, '; ')#
	</cfoutput>
<cfelse>


<cfset qobj = application.QuestionPool.getQuestion(attributes.code)>
<cfset templist = ''>
<cfif ListLen(attributes.errorcode, '|') eq 2>
    <cfset afobj = application.AnswerfieldPool.getAnswerfield("#ListGetAt(attributes.errorcode, 2, '|')#")>
	<cfset session.numlimit = afobj.length>
	<cfset attributes.errorcode = ListGetAt(attributes.errorcode, 1, '|')>
</cfif>
<cfoutput>
	<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
		<td colspan="2"></td>
		<!--- MH: 2/15/10 Align fit general information section like questions--->
		<cfif attributes.code neq "fit_header1">
			<td width="35">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td<cfif attributes.errorcode neq '' or attributes.errortext neq ''> style="background: pink;"><span style="font-weight: bold; font-size: 9pt;"><cfif attributes.errortext neq ''>#attributes.errortext#<cfelse><cf_displayText code="#attributes.errorgroup#_#attributes.errorcode#" group="#attributes.errorgroup#"></cfif><br><br></span><cfelse>></cfif>
		<cfelse>
			<td colspan="2"<cfif attributes.errorcode neq '' or attributes.errortext neq ''> style="background: pink;"><span style="font-weight: bold; font-size: 9pt;"><cfif attributes.errortext neq ''>#attributes.errortext#<cfelse><cf_displayText code="#attributes.errorgroup#_#attributes.errorcode#" group="#attributes.errorgroup#"></cfif><br><br></span><cfelse>></cfif>
		</cfif>
		
		<cfswitch expression="#attributes.type#">
			<cfcase value="date">
				<cfloop collection="#qobj#" item="answerfield">
                    				<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
					<cftry>
					<cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display="answerfield_#answerfield#">
					<cfcatch><cfdump var="#afobj#"></cfcatch>
					</cftry><cfabort>
					<cfset templist = ListAppend(templist, safitem)>
				</cfloop>
			</cfcase>
			<cfcase value="multi_horizontal">
				<table border="0" cellspacing="2">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
                    <cf_loopPoolStruct struct="qobj" index="answerfield">
                        <cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<td><table border="0" cellpadding="0" cellspacing="0"><tr><td><cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""></td></tr>
						<tr style="font-size: 9pt;"><td><cf_displayText code="answerfield_#answerfield#" group="answerfield"></td></tr></table></td>
						<cfset templist = ListAppend(templist, safitem)>
					</cf_loopPoolStruct>
					</tr>
				</table>
			</cfcase>
			<cfcase value="multi_vertical">
				<table border="0" cellspacing="2">
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
							<td align="right" style="font-size: 9pt;"><cf_displayText code="answerfield_#answerfield#" group="answerfield"></td>
							<td><cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""></td>
							<cfset templist = ListAppend(templist, safitem)>
						</tr>
					</cf_loopPoolStruct>
				</table>
			</cfcase>
            <cfcase value="multi_vertical_rev">
				<table border="0" cellspacing="2" width="90%">
                	<tr>
                    	<td style="font-size:12px;">
							<cf_loopPoolStruct struct="qobj" index="answerfield">
                                <cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
                                <div style="padding:2px 0 2px 0;">
                                    <span>
                                        <cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""><cf_displayText code="answerfield_#answerfield#" group="answerfield">
                                    </span>
                                </div>
								<cfset templist = ListAppend(templist, safitem)>
							</cf_loopPoolStruct>
						</td>
                    </tr>
                </table>
			</cfcase>
			<cfcase value="name_simple_phone">
				<table border="0" cellspacing="2">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
					<cfset brTrack = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfif brTrack eq 2>
					</tr>
				</table>
				<table border="0" cellspacing="2">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
						</cfif>
						<td><table border="0" cellpadding="0" cellspacing="0"><tr><td><cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""></td></tr>
						<tr style="font-size: 9pt;"><td><cf_displayText code="answerfield_#answerfield#" group="answerfield"></td></tr></table></td>
						<cfset templist = ListAppend(templist, safitem)>
						<cfset brTrack = brTrack + 1>
					</cf_loopPoolStruct>
					</tr>
				</table>
			</cfcase>
			<cfcase value="radio_string_x3_specify_crncy_x1">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					<cfloop from="0" to="#Evaluate(row - 1)#" step="2" index="x">
						<cfset afa = "af#x#">
						<cfset afb = "af#Evaluate("x + 1")#">
						<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
							<td>
								<cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_radio_hide'>
                                	<cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true">
                                </cfif>
                                <cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" format="radio_string" display="" onClick="this.blur();" onChange0="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) {this.form.#Evaluate("#afb#_answerfield")#.value = ''; objrow.style.display = 'none';}" onChange1="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) {objrow.style.display = '';}" onChange2="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) {this.form.#Evaluate("#afb#_answerfield")#.value = ''; objrow.style.display = 'none';}">
                            </td>
						<cfif safitem neq ''>
							<cfset templist = ListAppend(templist, safitem)>
						</cfif>
					</tr>
					<tr id="tr_#Evaluate("#afb#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true"><br><cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="#Evaluate("#afb#_max_length")#" format="#attributes.format#" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var obj0 = document.getElementById('radio_0_#Evaluate("#afa#_answerfield")#'); var obj1 = document.getElementById('radio_1_#Evaluate("#afa#_answerfield")#'); var obj2 = document.getElementById('radio_2_#Evaluate("#afa#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (obj0.checked || obj0.type == 'hidden' || obj2.checked) {obj0.form.#Evaluate("#afb#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					</cfloop>
				</table>
			</cfcase>
			<cfcase value="select_drilldown">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					
						<cfset afa = "af0">
						<cfset afb = "af1">
						<cfset afc = "af2">
						<cfset afd = "af3">
						<cfset afe = "af4">
						<cfset aff = "af5">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><cfif CGI.SCRIPT_NAME NEQ '/questions.cfm' AND CGI.SCRIPT_NAME NEQ '/esi_questions.cfm'><br></cfif><cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></cfif>
<cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" maxlength="#Evaluate("#afa#_max_length")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) objrow.style.display = '';" onChangeNo="var objno = document.getElementById('radio_no_#Evaluate("#afb#_answerfield")#'); var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked && objno.checked) {this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><br><cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="#Evaluate("#afb#_max_length")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) objrow.style.display = '';" onChangeNo="var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked && objno.checked) {this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afc#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cfif Evaluate("#afc#_code") neq 'currency' or (attributes.format neq 'text_rep_cur_ih' and attributes.format neq 'text_rep_cur_ih_hide_others')><cf_displayText code="#Evaluate("#afc#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afc#_answerfield")#" type="#Evaluate("#afc#_code")#" maxlength="#Evaluate("#afc#_max_length")#" format="#attributes.format#" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objyes2 = document.getElementById('radio_yes_#Evaluate("#afb#_answerfield")#'); var objno2 = document.getElementById('radio_no_#Evaluate("#afb#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (objyes.checked || objyes2.checked) objtr.style.display = ''; else if (objno.checked && objno2.checked) {objyes.form.#Evaluate("#afc#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afd#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cfif Evaluate("#afd#_code") neq 'currency' or (attributes.format neq 'text_rep_cur_ih' and attributes.format neq 'text_rep_cur_ih_hide_others')><cf_displayText code="#Evaluate("#afd#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afd#_answerfield")#" type="#Evaluate("#afd#_code")#" maxlength="#Evaluate("#afd#_max_length")#" format="radio_stack" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objyes2 = document.getElementById('radio_yes_#Evaluate("#afb#_answerfield")#'); var objno2 = document.getElementById('radio_no_#Evaluate("#afb#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afd#_answerfield")#'); if (objyes.checked || objyes2.checked) objtr.style.display = ''; else if (objno.checked && objno2.checked) {objyes.form.#Evaluate("#afd#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afe#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cfif Evaluate("#afe#_code") neq 'currency' or (attributes.format neq 'text_rep_cur_ih' and attributes.format neq 'text_rep_cur_ih_hide_others')><cf_displayText code="#Evaluate("#afe#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afe#_answerfield")#" type="#Evaluate("#afe#_code")#" maxlength="#Evaluate("#afe#_max_length")#" format="#attributes.format#" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objyes2 = document.getElementById('radio_yes_#Evaluate("#afb#_answerfield")#'); var objno2 = document.getElementById('radio_no_#Evaluate("#afb#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afe#_answerfield")#'); if (objyes.checked || objyes2.checked) objtr.style.display = ''; else if (objno.checked && objno2.checked) {objyes.form.#Evaluate("#afe#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#aff#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cfif Evaluate("#aff#_code") neq 'currency' or (attributes.format neq 'text_rep_cur_ih' and attributes.format neq 'text_rep_cur_ih_hide_others')><cf_displayText code="#Evaluate("#aff#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#aff#_answerfield")#" type="#Evaluate("#aff#_code")#" maxlength="#Evaluate("#aff#_max_length")#" format="radio_stack" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objyes2 = document.getElementById('radio_yes_#Evaluate("#afb#_answerfield")#'); var objno2 = document.getElementById('radio_no_#Evaluate("#afb#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#aff#_answerfield")#'); if (objyes.checked || objyes2.checked) objtr.style.display = ''; else if (objno.checked && objno2.checked) {objyes.form.#Evaluate("#aff#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					
				</table>
			</cfcase>
            <cfcase value="fit_basic_questions">
            <table border="0" cellspacing="2" width="100%">
            <cfset row = 0>
            <cfset allAf = structNew()>
            <cf_loopPoolStruct struct="qobj" index="answerfield">
                <cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
                <cfset "allAf.#answerfield#" = structNew()>
                <cfset "allAf.#answerfield#.answerfield_id" = afobj.id>
                <cfset "allAf.#answerfield#.answerfield" = answerfield>
                <cfset "allAf.#answerfield#.code" = afobj.type>
                <cfset "allAf.#answerfield#.maxLength" = afobj.length>
                <cfset "allAf.#answerfield#.display_code" = "answerfield_#answerfield#">
                <cfset row = row + 1>
            </cf_loopPoolStruct>
				<tr>
                <td class="q-text">
					<div style="padding:2px 0 2px 0;">
                    	<div style="float:left;">
                        	<span><cf_displayText code="answerfield_fit_agency_id" group="answerfield"><cf_buildAnswerfield name="fit_agency_id" type="#allAf["fit_agency_id"].code#" maxlength="#allAf["fit_agency_id"].maxLength#" format="#attributes.format#" display=""></span>
                        	<cfset templist = ListAppend(templist, safitem)>
                        </div>
                        <!--- <div style="float:left;padding-left:15px;">
                        	<span><cf_displayText code="answerfield_fit_intermediary" group="answerfield"><cf_buildAnswerfield name="fit_intermediary" type="#allAf["fit_intermediary"].code#" maxlength="#allAf["fit_intermediary"].maxLength#" format="#attributes.format#" display=""></span>
                        	<cfset templist = ListAppend(templist, safitem)>
                        </div> --->
                        <div style="clear:both;"></div>
                    </div>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
                    	<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
                        <cfif answerfield NEQ "fit_agency_id" AND answerfield NEQ "fit_intermediary">
                        <div style="padding:2px 0 2px 0;">
                        	<span><cf_displayText code="answerfield_#answerfield#" group="answerfield"><cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""></span>
                        </div>
                        <cfset templist = ListAppend(templist, safitem)>
                        </cfif>
					</cf_loopPoolStruct>
            	</td>
                </tr>
            </table>
            </cfcase>
			<cfcase value="radio_string_x3_specify_crncy_x2">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					<cfloop from="0" to="#Evaluate(row - 1)#" step="3" index="x">
						<cfset afa = "af#x#">
						<cfset afb = "af#Evaluate("x + 1")#">
						<cfset afc = "af#Evaluate("x + 2")#">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_radio_hide'><cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" format="radio_string" display="" onClick="this.blur();" onChange0="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); var objrow2 = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) {this.form.#Evaluate("#afb#_answerfield")#.value = ''; this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow.style.display = 'none'; objrow2.style.display = 'none';}" onChange1="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); var objrow2 = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) {objrow.style.display = ''; this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow2.style.display = 'none';}" onChange2="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); var objrow2 = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) {objrow2.style.display = ''; this.form.#Evaluate("#afb#_answerfield")#.value = ''; objrow.style.display = 'none';}"></td>
						<cfif safitem neq ''>
							<cfset templist = ListAppend(templist, safitem)>
						</cfif>
					</tr>
					<tr id="tr_#Evaluate("#afb#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="#Evaluate("#afb#_max_length")#" format="#attributes.format#" display=""></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afc#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cf_displayText code="#Evaluate("#afc#_display_code")#" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="#Evaluate("#afc#_answerfield")#" type="#Evaluate("#afc#_code")#" maxlength="#Evaluate("#afc#_max_length")#" format="#attributes.format#" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var obj0 = document.getElementById('radio_0_#Evaluate("#afa#_answerfield")#'); var obj1 = document.getElementById('radio_1_#Evaluate("#afa#_answerfield")#'); var obj2 = document.getElementById('radio_2_#Evaluate("#afa#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); var objtr2 = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (obj0.checked || obj0.type == 'hidden') {obj0.form.#Evaluate("#afb#_answerfield")#.value = ''; obj0.form.#Evaluate("#afc#_answerfield")#.value = ''; objtr.style.display = 'none'; objtr2.style.display = 'none';} else if (obj1.checked) {obj0.form.#Evaluate("#afc#_answerfield")#.value = ''; objtr2.style.display = 'none';} else if (obj2.checked) {obj0.form.#Evaluate("#afb#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					</cfloop>
				</table>
			</cfcase>
			<cfcase value="select_other_specify">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><cf_displayText code="#af0_display_code#" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="#af0_answerfield#" type="#af0_code#" maxlength="#af0_max_length#" format="#attributes.format#" display="" onChange="var objrow = document.getElementById('tr_#af1_answerfield#'); if (this.selectedIndex == this.options.length - 1) objrow.style.display = ''; else {this.form.#af1_answerfield#.value = ''; objrow.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					<tr id="tr_#af1_answerfield#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;<cfif row eq 2> display: none;</cfif>">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cf_displayText code="#af1_display_code#" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="#af1_answerfield#" type="#af1_code#" maxlength="#af1_max_length#" format="#attributes.format#" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objitem = document.getElementById('select_#af0_answerfield#'); var objtr = document.getElementById('tr_#af1_answerfield#'); if (objitem.selectedIndex == objitem.options.length - 1) objtr.style.display = ''; else {objitem.form.#af1_answerfield#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
				</table>
			</cfcase>
			<cfcase value="yn_currency_text">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					<cfloop from="0" to="#Evaluate(row - 1)#" step="3" index="x">
						<cfset afa = "af#x#">
						<cfset afb = "af#Evaluate("x + 1")#">
						<cfset afc = "af#Evaluate("x + 2")#">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); var objrow2 = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) {objrow.style.display = ''; objrow2.style.display = '';}" onChangeNo="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); var objrow2 = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) {this.form.#Evaluate("#afb#_answerfield")#.value = ''; this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow.style.display = 'none'; objrow2.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afb#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="#Evaluate("#afb#_max_length")#" format="#attributes.format#" display=""></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afc#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cf_displayText code="#Evaluate("#afc#_display_code")#" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="#Evaluate("#afc#_answerfield")#" type="#Evaluate("#afc#_code")#" maxlength="#Evaluate("#afc#_max_length")#" format="#attributes.format#" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); var objtr2 = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (objyes.checked) {objtr.style.display = ''; objtr2.style.display = '';} else if (objno.checked) {objyes.form.#Evaluate("#afb#_answerfield")#.value = ''; objyes.form.#Evaluate("#afc#_answerfield")#.value = ''; objtr.style.display = 'none'; objtr2.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					</cfloop>
				</table>
			</cfcase>
			<cfcase value="yn_month_year">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					<cfloop from="0" to="#Evaluate(row - 1)#" step="3" index="x">
						<cfset afa = "af#x#">
						<cfset afb = "af#Evaluate("x + 1")#">
						<cfset afc = "af#Evaluate("x + 2")#">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" maxlength="#Evaluate("#afa#_max_length")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) objrow.style.display = '';" onChangeNo="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) {this.form.#Evaluate("#afb#_answerfield")#.value = ''; this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afb#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" format="#attributes.format#" display=""><cfset templist = ListAppend(templist, safitem)> <cf_buildAnswerfield name="#Evaluate("#afc#_answerfield")#" type="#Evaluate("#afc#_code")#" format="mon_yearnow_pm" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (objyes.checked) objtr.style.display = ''; else if (objno.checked || objyes.type == 'hidden') {objyes.form.#Evaluate("#afb#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfif safitem neq ''>
							<cfset templist = ListAppend(templist, safitem)>
						</cfif>
					</tr>
					</cfloop>
				</table>
			</cfcase>
			<cfcase value="yn_specify">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					<cfloop from="0" to="#Evaluate(row - 1)#" step="2" index="x">
						<cfset afa = "af#x#">
						<cfset afb = "af#Evaluate("x + 1")#">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td>
                        <cfif attributes.format IS "fit_specify_on_no">
                        	<!--- --->
                        	<cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" maxlength="#Evaluate("#afa#_max_length")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) {this.form.#Evaluate("#afb#_answerfield")#.value = ''; objrow.style.display = 'none';}" onChangeNo="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) objrow.style.display = '';"></td>
                        <cfelse>
							<cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" maxlength="#Evaluate("#afa#_max_length")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) objrow.style.display = '';" onChangeNo="var objrow = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (this.checked) {this.form.#Evaluate("#afb#_answerfield")#.value = ''; objrow.style.display = 'none';}"></td>
						</cfif>
						<cfif safitem neq ''>
							<cfset templist = ListAppend(templist, safitem)>
						</cfif>
					</tr>
					<tr id="tr_#Evaluate("#afb#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id is 61>12px<cfelse>11pt</cfif>; color: black;">
						<td>
                        <img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br>
						<cfif Evaluate("#afb#_code") neq 'currency' or (attributes.format neq 'text_rep_cur_ih' and attributes.format neq 'text_rep_cur_ih_hide_others')>
                        	<cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true">
                        </cfif>
                        <cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="#Evaluate("#afb#_max_length")#" format="#attributes.format#" display="">
                        <cfif attributes.format IS "fit_specify_on_no">
                        	<img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afb#_answerfield")#'); if (objno.checked) {objtr.style.display = ''; }else if (objyes.checked || objno.type == 'hidden' || (!objyes.checked && !objno.checked)) {objno.form.#Evaluate("#afb#_answerfield")#.value = ''; objtr.style.display = 'none';}else{}">
                        <cfelse>
                        	<img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#');var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afb#_answerfield")#');if (objyes.checked){objtr.style.display = ''; }else if (objno.checked || objyes.type == 'hidden' || (!objyes.checked && !objno.checked)){objyes.form.#Evaluate("#afb#_answerfield")#.value = '';objtr.style.display = 'none';}">
                        </cfif>
                        </td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					</cfloop>
				</table>
			</cfcase>
			<cfcase value="yn_x2_specify">
				<table border="0" cellspacing="2">
					<cfset row = 0>
					<cf_loopPoolStruct struct="qobj" index="answerfield">
						<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
						<cfset "af#row#_answerfield_id" = afobj.id>
						<cfset "af#row#_answerfield" = answerfield>
						<cfset "af#row#_code" = afobj.type>
						<cfset "af#row#_max_length" = afobj.length>
						<cfset "af#row#_display_code" = "answerfield_#answerfield#">
						<cfset row = row + 1>
					</cf_loopPoolStruct>
					<cfloop from="0" to="#Evaluate(row - 1)#" step="3" index="x">
						<cfset afa = "af#x#">
						<cfset afb = "af#Evaluate("x + 1")#">
						<cfset afc = "af#Evaluate("x + 2")#">
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" maxlength="#Evaluate("#afa#_max_length")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) objrow.style.display = '';" onChangeNo="var objno = document.getElementById('radio_no_#Evaluate("#afb#_answerfield")#'); var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked && objno.checked) {this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'><cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="#Evaluate("#afb#_max_length")#" format="#attributes.format#" display="" onClick="this.blur();" onChangeYes="var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked) objrow.style.display = '';" onChangeNo="var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objrow = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (this.checked && objno.checked) {this.form.#Evaluate("#afc#_answerfield")#.value = ''; objrow.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					<tr id="tr_#Evaluate("#afc#_answerfield")#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" title=""><br><cfif Evaluate("#afc#_code") neq 'currency' or (attributes.format neq 'text_rep_cur_ih' and attributes.format neq 'text_rep_cur_ih_hide_others')><cf_displayText code="#Evaluate("#afc#_display_code")#" group="answerfield" spaceafter="true"></cfif><cf_buildAnswerfield name="#Evaluate("#afc#_answerfield")#" type="#Evaluate("#afc#_code")#" maxlength="#Evaluate("#afc#_max_length")#" format="#attributes.format#" display=""><img src="images/pixel.gif" width="1" height="1" border="0" alt="" title="" onLoad="var objyes = document.getElementById('radio_yes_#Evaluate("#afa#_answerfield")#'); var objno = document.getElementById('radio_no_#Evaluate("#afa#_answerfield")#'); var objyes2 = document.getElementById('radio_yes_#Evaluate("#afb#_answerfield")#'); var objno2 = document.getElementById('radio_no_#Evaluate("#afb#_answerfield")#'); var objtr = document.getElementById('tr_#Evaluate("#afc#_answerfield")#'); if (objyes.checked || objyes2.checked) objtr.style.display = ''; else if (objno.checked && objno2.checked) {objyes.form.#Evaluate("#afc#_answerfield")#.value = ''; objtr.style.display = 'none';}"></td>
						<cfset templist = ListAppend(templist, safitem)>
					</tr>
					</cfloop>
				</table>
			</cfcase>
            <cfcase value="yn_multi_checkbox">
				<table border="0" cellspacing="2">
                	<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
						<td>
							<cfset row = 0>
                            <cf_loopPoolStruct struct="qobj" index="answerfield">
                                <cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
                                <cfset "af#row#_answerfield_id" = afobj.id>
                                <cfset "af#row#_answerfield" = answerfield>
                                <cfset "af#row#_code" = afobj.type>
                                <cfset "af#row#_max_length" = afobj.length>
                                <cfset "af#row#_display_code" = "answerfield_#answerfield#">
                                <cfset row = row + 1>
                            </cf_loopPoolStruct>
                            <cfset tempId = "xtr_#Evaluate("af0_answerfield")#">
                            <script type="text/javascript">
								function ynMultiCheckShowHide(id){
									var yesEl = jQuery("##radio_yes_#Evaluate("af0_answerfield")#");
									var noEl = jQuery("##radio_no_#Evaluate("af0_answerfield")#");
									if(jQuery(noEl).is(":checked")){
										jQuery("##" + id).css("display","none");
									}else if(jQuery(yesEl).is(":checked")){
										jQuery("##" + id).fadeIn('slow',function(){
											if($.browser.msie){this.style.removeAttribute('filter');}
										});
									}else{
										jQuery("##" + id).css("display","none");
									}
								}
								jQuery(document).ready(function(){
									ynMultiCheckShowHide("#tempId#");
								});
							</script>
                            <div style="padding:2px 0 2px 0;font-size:12px;font-family: verdana, arial, helvetica, sans-serif;">
                            	<span>
								<cfif attributes.format neq 'text_hide' and attributes.format neq 'text_rep_cur_ih_hide_others' and attributes.format neq 'text_yn_hide'>
                                	<cf_displayText code="#Evaluate("af0_display_code")#" group="answerfield" spaceafter="true">
                             	</cfif>
                             	<cf_buildAnswerfield name="#Evaluate("af0_answerfield")#" type="#Evaluate("af0_code")#" maxlength="#Evaluate("af0_max_length")#" format="#attributes.format#" display="" onClick="ynMultiCheckShowHide('#tempId#');">
                             	</span>
                             </div>
							<cfif safitem neq ''>
								<cfset templist = ListAppend(templist, safitem)>
							</cfif>
                            <div id="xtr_#Evaluate("af0_answerfield")#" style="margin:2px 0 0 50px;padding:2px;font-family: verdana, arial, helvetica, sans-serif;">
                                <cf_loopPoolStruct struct="qobj" index="answerfield">
                                    <cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
                                    <cfif afobj.type NEQ "ny" OR answerfield NEQ "fit_mortgage_use">
                                        <div style="padding:2px 0 2px 0;color:black;font-size:12px;font-family: verdana, arial, helvetica, sans-serif;">
                                            <cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""><cf_displayText code="answerfield_#answerfield#" group="answerfield">
                                        </div>
                                    </cfif>
                                    <cfset templist = ListAppend(templist, safitem)>
                                </cf_loopPoolStruct>
                            </div>
                         </td>
					</tr>
				</table>
			</cfcase>
            <cfcase value="fit_multi_checkbox_specify">
			<!---2/12/10 MH: First clause of if statement is a Hardcoded handler for question code fit_difficulty_nxt12  --->
				<cfif attributes.code eq "fit_difficulty_nxt12">
					<cfsavecontent variable="Q14JS">
						<script type="text/javascript">
							function checkNoneJS_14(){
								var vcount4 = 0;
								for(a=0; a<document.fitForm.elements.length; a++) {
									if(document.fitForm.mthly_exp.checked == true||document.fitForm.med_health_exp.checked == true||document.fitForm.proptax_homeins.checked == true||document.fitForm.other_mthly_needs_spec.checked == true){
										vcount4++;
									};
								};
								if(vcount4 == 0){
									document.fitForm.fit_none_of_the_above4.checked = false;
									alert("Q14 None of the above is UNCHECKED");
								}else{
									document.fitForm.fit_none_of_the_above4.checked = true;
									alert("Q14 None of the above is CHECKED");
								};

							};
	
						</script>
					</cfsavecontent>
					<cfhtmlhead text="#Q14JS#">
				</cfif>
            	<cfset row = 0>
				<cf_loopPoolStruct struct="qobj" index="answerfield">
					<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
					<cfset "af#row#_answerfield_id" = afobj.id>
					<cfset "af#row#_answerfield" = answerfield>
					<cfset "af#row#_code" = afobj.type>
					<cfset "af#row#_max_length" = afobj.length>
					<cfset "af#row#_display_code" = "answerfield_#answerfield#">
					<cfset row = row + 1>
				</cf_loopPoolStruct>
                <script type="text/javascript">
					function multiCheckHideShow(el,id){
						if(typeof(el) != "undefined" && typeof(id) != "undefined"){
							if(jQuery(el).is(":checked")){
								jQuery("##fit_invisible_q14").val("n");
								jQuery("##" + id).fadeIn('slow',function(){
									if($.browser.msie){this.style.removeAttribute('filter');}
								});
							}else{
								jQuery("##" + id).css("display","none");
								jQuery('##' + id + " input:text").val("");
							}
						}else{
							jQuery('div.ynMultiCheckMain').each(function(){
								var tempID = jQuery(this).attr("id").substring(2);
								var tempXtrID = "xtr_" + tempID;
								if(jQuery("##" + tempID).is(":checked")){
									jQuery("##fit_invisible_q14").val("n");
									jQuery("##" + tempXtrID).fadeIn('slow',function(){
										if($.browser.msie){this.style.removeAttribute('filter');}
									});
								}else{
									jQuery("##" + tempXtrID).css("display","none");
									jQuery('##' + tempXtrID + " input:text").val("");
								};
							});
						};
					};
					jQuery(document).ready(function(){
							multiCheckHideShow();
					});
				</script>
				<div class="nota_check_#qobj.sort[qobj.sort.size()]#">
                	<cfloop from="0" to="#Evaluate(row - 1)#" step="2" index="x">
                		<cfset afa = "af#x#">
                		<cfset afb = "af#Evaluate("x + 1")#">
                        <cfif Evaluate("#afb#_answerfield") is "fit_none_of_the_above4" AND evaluate("#afa#_answerfield") is "fit_invisible_q14">
                        	<cfset lastAf = qobj.sort.size()>
                            <!--- <cf_handleScreeningAnswerfield action="get" code="#Evaluate("#afa#_answerfield")#" element="val" var="mymatchval">
                            "#mymatchval#"<input type="hidden" id="#Evaluate("#afa#_answerfield")#" name="#Evaluate("#afa#_answerfield")#" value="<cfif mymatchval is 0 or mymatchVal is ""><cfelse>1</cfif>" /> --->
                            <cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="hiddenfield" maxlength="#Evaluate("#afa#_max_length")#" format="#attributes.format#" display="">
                            <!--- <cfset safitem = "c-" & #Evaluate("#afa#_answerfield")#> --->
                        	<cfset templist = ListAppend(templist, safitem)>
                            <div class="ynMultiCheckMain" id="xtra_#qobj.sort[qobj.sort.size()]#" style="padding:2px 0 2px 0;font-size:12px;font-family: verdana, arial, helvetica, sans-serif;">
                				<span><cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="#Evaluate("#afb#_max_length")#" format="#attributes.format#" display="" onClick="multiCheckHideShow(this,'xtr_#Evaluate("#afa#_answerfield")#');rmAllCheck(this);">
                				<cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true"></span>
                			</div>
                			<cfset templist = ListAppend(templist, safitem)>
                		<cfelse>
                			<div class="ynMultiCheckMain" id="t_#Evaluate("#afa#_answerfield")#" style="padding:2px 0 2px 0;font-size:12px;font-family: verdana, arial, helvetica, sans-serif;">
                				<span><cf_buildAnswerfield name="#Evaluate("#afa#_answerfield")#" type="#Evaluate("#afa#_code")#" maxlength="#Evaluate("#afa#_max_length")#" format="#attributes.format#" display="" onClick="multiCheckHideShow(this,'xtr_#Evaluate("#afa#_answerfield")#');rmNoneCheck(this,'xtra_#qobj.sort[qobj.sort.size()]#');">
               					<cf_displayText code="#Evaluate("#afa#_display_code")#" group="answerfield" spaceafter="true"></span>
                				<cfset templist = ListAppend(templist, safitem)>
                			</div>
                			<div class="ynMultiCheck" id="xtr_#Evaluate("#afa#_answerfield")#" style="margin-left:4px;font-family: verdana, arial, helvetica, sans-serif;padding:2px 0 2px 20px;font-size:12px;display:none;">
                				<span><cf_displayText code="#Evaluate("#afb#_display_code")#" group="answerfield" spaceafter="true">
                				<cf_buildAnswerfield name="#Evaluate("#afb#_answerfield")#" type="#Evaluate("#afb#_code")#" maxlength="10" format="currency" display=""></span>
                				<cfset templist = ListAppend(templist, safitem)>
                			</div>
                		</cfif>
            		</cfloop>
            	</div>
            	<cfset lastAf = qobj.sort.size()>
            	<cfset afCounter = 1>
            </cfcase>
			<cfcase value="fit_mutiple_checkbox_other">
				<!---2/11/10 MH: First clause of if statement is a Hardcoded handler for question code fit_reasons, fit_difficulty, fit_needs_help  --->
				<cfif attributes.code eq "fit_reasons" OR attributes.code eq "fit_difficulty" OR attributes.code eq "fit_needs_help">
					<cfsavecontent variable="Q1JS">
						<script type="text/javascript">
							function checkNoneJS_1(){
								var vcount = 0;
								for(i=0; i<document.fitForm.elements.length; i++) {
									if(document.fitForm.elements[i].name.substring(0,10) == "fit_reason"){
										if(document.fitForm.elements[i].checked == true){
											vcount++;
										};
									};
								};
								if(vcount == 0){
									document.fitForm.fit_none_of_the_above3.checked = false;
								}else{
									document.fitForm.fit_none_of_the_above3.checked = true;
								};
							};
							
							function checkNone_and_Invisible(question){
								if (question == 9){
									if(document.fitForm.fit_none_of_the_above.checked == true){
										document.fitForm.bath_dress.checked = false;
										document.fitForm.see_hear.checked = false;
										document.fitForm.chores.checked = false;
										document.fitForm.fit_invisible_q9.checked = true;
									}
									else{
										if(document.fitForm.bath_dress.checked == false && document.fitForm.see_hear.checked == false && document.fitForm.chores.checked == false){
											document.fitForm.fit_none_of_the_above.checked = true;
											document.fitForm.fit_invisible_q9.checked = true;
										}
									}
								}
								if (question == 11){
									if(document.fitForm.fit_none_of_the_above2.checked == true){
										document.fitForm.fit_friend.checked = false;
										document.fitForm.fit_paid_helper_caregiver.checked = false;
										document.fitForm.fit_invisible_q11.checked = true;
									}
									else{
										if(document.fitForm.fit_friend.checked == false && document.fitForm.fit_paid_helper_caregiver.checked == false && document.fitForm.chores.checked == false){
											document.fitForm.fit_none_of_the_above2.checked = true;
											document.fitForm.fit_invisible_q11.checked = true;
										}
									}
								}
							}
							
							function checkNoneJS_9(){
  								var vcount2 = 0;
  								if (document.fitForm.bath_dress.checked) {
									if (document.fitForm.fit_none_of_the_above.checked){
										document.fitForm.fit_none_of_the_above.checked = false;
									}
									document.fitForm.fit_invisible_q9.checked = true;	
    									vcount2++;
								}
								if (document.fitForm.see_hear.checked) {
									if (document.fitForm.fit_none_of_the_above.checked){
										document.fitForm.fit_none_of_the_above.checked = false;
									}		
    									document.fitForm.fit_invisible_q9.checked = true;
									vcount2++;
								}
								if (document.fitForm.chores.checked) {
									if (document.fitForm.fit_none_of_the_above.checked){
										document.fitForm.fit_none_of_the_above.checked = false;
									}		
									document.fitForm.fit_invisible_q9.checked = true;
    									vcount2++;
								}
    								if (vcount2 > 0) {
    									document.fitForm.fit_invisible_q9.checked = true; 
  								}
								else{
									if(vcount2 == 0) {
										document.fitForm.fit_none_of_the_above.checked = true;
										document.fitForm.fit_invisible_q9.checked = true; 
									}		
								}
							}

							function checkNoneJS_11(){
  								var vcount3 = 0;
  								if (document.fitForm.fit_friend.checked) {
									if (document.fitForm.fit_none_of_the_above2.checked){
										document.fitForm.fit_none_of_the_above2.checked = false;
									}
									document.fitForm.fit_invisible_q11.checked = true;		
    									vcount3++;
								}
								if (document.fitForm.fit_paid_helper_caregiver.checked) {
									if (document.fitForm.fit_none_of_the_above2.checked){
										document.fitForm.fit_none_of_the_above2.checked = false;
									}	
									document.fitForm.fit_invisible_q11.checked = true;	
    									vcount3++;
								}
								if (vcount3 > 0) {
    									document.fitForm.fit_invisible_q11.checked = true; 
  								}
								else{
									if(vcount3 == 0) {
										document.fitForm.fit_none_of_the_above2.checked = true;
										document.fitForm.fit_invisible_q11.checked = true; 
									}
								}
							}
	
						</script>
					</cfsavecontent>
					<cfhtmlhead text="#Q1JS#">
					<div class="fit_answerfield nota_check_#qobj.sort[qobj.sort.size()]#" class="fit_answerfield">
                        			<cf_loopPoolStruct struct="qobj" index="answerfield">
							<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
							<!--- set row to invisible if it's fit_none_of_the_above* --->
							<cfif Left(answerfield, 13) eq "fit_invisible" or answerfield eq 'fit_none_of_the_above3'>
								<div style="display:none;">
									<cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display="">
									<cf_displayText code="answerfield_#answerfield#" group="answerfield">
                                				</div>
							<cfelse>
								<div style="padding:2px 0 2px 0;font-family: verdana, arial, helvetica, sans-serif;">
									<cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""  checkNone="true">
									<cf_displayText code="answerfield_#answerfield#" group="answerfield">
                                				</div>
                            				</cfif>
							<cfset templist = ListAppend(templist, safitem)>
                        			</cf_loopPoolStruct>
					</div>
				<cfelse>					
                                        <cfset lastAf = qobj.sort.size()>
					<cfset afCounter = 1>
					<div class="fit_answerfield nota_check_#qobj.sort[qobj.sort.size()]#" class="fit_answerfield">
						<cf_loopPoolStruct struct="qobj" index="answerfield">
							<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
							<div id="xtra_#answerfield#" style="padding:2px 0 2px 0;font-family: verdana, arial, helvetica, sans-serif;">
								<cfif afCounter EQ lastAf>
									<cf_buildAnswerfield onclick="rmAllCheck(this);" name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""><cf_displayText code="answerfield_#answerfield#" group="answerfield">
								<cfelse>
									<cf_buildAnswerfield onclick="rmNoneCheck('xtra_#qobj.sort[qobj.sort.size()]#');" name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display=""><cf_displayText code="answerfield_#answerfield#" group="answerfield">
								</cfif>
							</div>
							<cfset templist = ListAppend(templist, safitem)>
							<cfset afCounter++>
						</cf_loopPoolStruct>
					</div>
				</cfif>
			</cfcase>
	    <cfcase value="grid">
		<cfif attributes.code eq "esi_grossmonthlyincome_question">
			<cfset gridcode="incomegrid">
		<cfelseif attributes.code eq "esi_totalassets_question">
			<cfset gridcode="assetgrid">
		<cfelse> 
			<cfset gridcode=attributes.code>
		</cfif>
		<cf_displayQuestionGrid code="#gridcode#" aflistvarname="saflist">
	    </cfcase>
            <cfcase value="fit_marital_multi_specify">
            	<script type="text/javascript">
					function myShowHide(id){
						jQuery(".showme").css("display","none");
						jQuery("##" + id).fadeIn('slow',function(){
							if($.browser.msie){this.style.removeAttribute('filter');}
						});
					};
					jQuery(document).ready(function(){
						jQuery(".marriedRadios").each(function(){
							var currentID = jQuery(this).attr('id');
							var currentHTML = jQuery('##xtra_' + currentID).html();
							jQuery(this).click(function(){
								jQuery(".showme").css("display","none").html("");
								jQuery('##xtra_' + currentID).html(currentHTML).fadeIn('slow',function(){
									if($.browser.msie){this.style.removeAttribute('filter');}
								});
								//console.log(currentHTML);
							});
						});
						var myYesEl = jQuery(".marriedRadios:checked");	
						jQuery(myYesEl).each(function(){
							var myYesID = jQuery(myYesEl).attr("id");
							jQuery("##xtra_" + myYesID).fadeIn('slow',function(){
								if($.browser.msie){this.style.removeAttribute('filter');}
							});
						});
						
					});
				</script>
            	<cfset row = 0>
                <cf_loopPoolStruct struct="qobj" index="answerfield">
                    <cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
                    <cfset "af#row#_answerfield_id" = afobj.id>
                    <cfset "af#row#_answerfield" = answerfield>
                    <cfset "af#row#_code" = afobj.type>
                    <cfset "af#row#_max_length" = afobj.length>
                    <cfset "af#row#_display_code" = "answerfield_#answerfield#">
                    <cfset row = row + 1>
                    <!--- #row# : #answerfield# : type-#afobj.type#<br /> --->
                    <cfif afobj.type IS "select" AND answerfield NEQ "fit_married_partner">
						<cfset safitem = "o-#answerfield#">
                        <cfset templist = ListAppend(templist, "o-#answerfield#")>
                    	<cf_loopPoolStruct struct="afobj" index="option">
							<!--- <cf_cacheOptionPool action="get" code="#option#" var="optobj"> --->
                            <cfset optobj = application.OptionPool.getOption(option)>
                    		<div style="padding:2px 0 2px 0;font-size:12px;font-family: verdana, arial, helvetica, sans-serif;">
                      			<span>
                                <cfset tempID = "xtra_#option#">
                                <cf_handleScreeningAnswerfield action="get" code="#answerfield#" element="val" var="mymatchval">
                                <!--- MH: Bug 5221 5/9/10 Special handler to repopulate fit_marital_stus from prev screening --->
                                <cfif mymatchval eq '' and answerfield eq 'fit_marital_stus'>
                                	<cfquery name="getfitmarital" datasource="#application.dbSrc#">
                                		SELECT option_id
  										FROM screening_answerfield
  										where screening_id = #session.prev_id# and answerfield_id = 6347
                                    </cfquery>
                                    <cfif getfitmarital.RecordCount neq 0><cfset mymatchval = #getfitmarital.option_id#></cfif>
                                    <!---cfif IsDefined('debug')>
                                    	MH - BUG 5221 DEBUG<BR />
                                    	screening_id: #session.prev_id#<BR />
                                        recordcount: #getfitmarital.RecordCount#<BR />
                                        mymatchval: #getfitmarital.option_id#<BR />
                                    </cfif--->
                                </cfif>
                                <!--- End special handler --->
                                <input class="marriedRadios" type="radio" id="#option#" name="#answerfield#" value="#optobj.id#-#option#" onclick="myShowHide('#tempId#');" <cfif mymatchval eq optobj.id> checked</cfif>>
							
								<cf_displayText group="option" code="option_#option#">
                    			</span>
                    		</div>
                            <cfif option IS "fit_married_partner">
                            	<div id="#tempId#" class="showme" style="display:none;font-family: verdana, arial, helvetica, sans-serif;padding-top:4px;">
                                    <cfset married = application.AnswerfieldPool.getAnswerfield("fit_married_partner")>
                                    <div style="font-size:12px;margin-left:25px;">
                                        <div style="margin-bottom:3px;">
                                        <cf_displayText code="answerfield_fit_married_partner" group="answerfield" spaceafter="true">
                                        </div>
                                        
                                        <cf_buildAnswerfield name="fit_married_partner" type="#married.type#" maxlength="#married.length#" format="radio_stack" display="">
										<cfif safitem neq ''><cfset templist = ListAppend(templist, safitem)></cfif>
                                        <cfset templist = listAppend(templist, "n-fit_married_partner_ins_yes")>
                                     </div>
                                     <cfsavecontent variable="marriedJscript">
									<script type="text/javascript">
											function myNewShowHide(id){
												var yesEl = jQuery("##radio_yes_fit_married_partner_ins:checked");
												var noEl = jQuery("##radio_no_fit_married_partner_ins");
												if(jQuery(noEl).is(":checked")){
													jQuery("##" + id).css("display","none");
												}else if(jQuery(yesEl).is(":checked")){
													jQuery("##" + id).fadeIn('slow',function(){
														if ($.browser.msie){this.style.removeAttribute('filter');}
													});
												}else{
													jQuery("##" + id).css("display","none");
												}
											}
											jQuery(document).ready(function(){
												myNewShowHide("partner_ins");
											});
									</script>
                                    </cfsavecontent>
                                    <cfhtmlhead text="#marriedJscript#">
                                    <div style="font-size:12px;margin-left:25px;padding-top:4px;">
                                        <cfset partIns = application.AnswerfieldPool.getAnswerfield("fit_married_partner_ins")>
                                        <div style="padding-bottom:3px;">
                                        <cf_displayText code="answerfield_fit_married_partner_ins" group="answerfield" spaceafter="true">
                                        </div>
                                        <cf_buildAnswerfield name="fit_married_partner_ins" type="#partIns.type#" maxlength="#partIns.length#" display="" onClick="myNewShowHide('partner_ins');">
                                        <cfif safitem neq ''>
                                            <cfset templist = ListAppend(templist, safitem)>
                                        </cfif>
                                    </div>
                                    
                                </div>
                            </cfif>
                            <cfif option IS "widowed" OR option IS "fit_div_sep" OR option IS "single">
                            	<cfsavecontent variable="#option#_subs">
                            	<div id="#tempId#" class="showme" style="display:none;font-family: verdana, arial, helvetica, sans-serif;">
                                	<cfif option NEQ "single">
                                    <cfset past12 = application.AnswerfieldPool.getAnswerfield("fit_past12_#option#")>
                                    <div style="font-size:12px;margin-left:25px;">
                                        <span>
                                        <cf_displayText code="answerfield_fit_past12_#option#" group="answerfield" spaceafter="true">
                                        <cf_buildAnswerfield name="fit_past12_#option#" type="#past12.type#" maxlength="#past12.length#" format="#option#" display="">
                                        <cfif safitem neq ''><cfset templist = ListAppend(templist, safitem)></cfif>
                                        </span>
                                     </div>
                                     </cfif>
                                     <cfset livealone = application.AnswerfieldPool.getAnswerfield("live_alone_#option#")>
                                    <div style="font-size:12px;margin-left:25px;">
                                        <span>
                                        <cf_displayText code="answerfield_live_alone_#option#" group="answerfield" spaceafter="true">
                                        <cf_buildAnswerfield name="live_alone_#option#" type="#livealone.type#" maxlength="#livealone.length#" format="#option#" display="">
                                        <cfif safitem neq ''><cfset templist = ListAppend(templist, safitem)></cfif>
                                        </span>
                                     </div>
                                     <cfset fitgender = application.AnswerfieldPool.getAnswerfield("fit_homeowner_gender_#option#")>
                                    <div style="padding:2px 0 2px 0;font-size:12px;margin-left:25px;">
                                        <span>
                                        <cf_displayText code="answerfield_fit_homeowner_gender_#option#" group="answerfield" spaceafter="true">
                                        <cf_buildAnswerfield name="fit_homeowner_gender_#option#" type="#fitgender.type#" maxlength="#fitgender.length#" format="gender" display="">
                                        <cfif safitem neq ''><cfset templist = ListAppend(templist, safitem)></cfif>
                                        </span>
                                     </div>
                                 </div>
                                 </cfsavecontent>
                                 <cfoutput>#evaluate("#option#_subs")#</cfoutput>
                            </cfif>
                        </cf_loopPoolStruct>
                    </cfif>
                </cf_loopPoolStruct>
            </cfcase>
			<cfdefaultcase>
				<cf_loopPoolStruct struct="qobj" index="answerfield">
					<cfset afobj = application.AnswerfieldPool.getAnswerfield("#answerfield#")>
					<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="balTempState">
					<cfif afobj.rule eq ''>
						<cfset afRuleEval = 2>
					<cfelse>
						<cf_testCondition code="#afobj.rule#" var="afRuleEval">
					</cfif>
					<cfif afRuleEval eq 2 and (afobj.state_id eq '' or afobj.state_id eq balTempState)>
						<cf_buildAnswerfield name="#answerfield#" type="#afobj.type#" maxlength="#afobj.length#" format="#attributes.format#" display="answerfield_#answerfield#"><br />
						<cfif safitem neq ''><cfset templist = ListAppend(templist, safitem)></cfif>
					</cfif>
				</cf_loopPoolStruct>
			</cfdefaultcase>
		</cfswitch>
		</td>
	</tr>
	<cfif CGI.SCRIPT_NAME NEQ '/cf/questions.cfm' AND CGI.SCRIPT_NAME NEQ '/cf/esi_questions.cfm'>
		<tr style="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
			<td colspan="4">&nbsp;</td>
		</tr>
	</cfif>
</cfoutput>
<cfset "caller.#attributes.listvar#" = templist>

</cfif>