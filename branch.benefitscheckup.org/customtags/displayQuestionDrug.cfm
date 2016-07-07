<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.form" type="string" default="bcuQuestionnaire">
<cfparam name="attributes.aflistvarname" type="string" default="">
<cfset debug = false>
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode eq 'print'>
	<cfset stripTags = true>
<cfelse>
	<cfset stripTags = false>
</cfif>
<cfset qobj = application.QuestionPool.getQuestion(attributes.code)>
</cfsilent><cfoutput><tr class="question-print">
	<td colspan="3"></td>
	<td colspan="6">
    <cf_loopPoolStruct struct="qobj" index="afrx">
    <cfset ansObj = application.answerfieldPool.getAnswerfield(afrx)>
	<cfset type = ansObj.type> 
	<cfif type eq 'druglist'><cfif attributes.mode eq 'print'><table align="left" border="0" cellspacing="8" cellpadding="0">
	<cfloop from="1" to="12" index="x">
		<tr>
			<td class="q-text"><cfoutput>#RepeatString('_', 32)#</cfoutput></td>
			<td></td>
			<td class="q-text"><cfoutput>#RepeatString('_', 32)#</cfoutput></td>
		</tr>
	</cfloop>
	</table><cfelse><cfsilent>
<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
	<cfset boxColor = "##cccc99">
	<cfset boxColorDark = "##999966">
<cfelseif IsDefined('session.partner_id') And session.partner_id eq 89>
	<cfset boxColor = "##b2d8e5">
	<cfset boxColorDark = "##b2d8e5">
<cfelseif IsDefined('session.partner_id') And session.partner_id eq 90>
	<cfset boxColor = "##b2d8e5">
	<cfset boxColorDark = "##b2d8e5">
<cfelse>
	<cfset boxColor = "##d4dfdb">
	<cfset boxColorDark = "##bdcfc8">
</cfif>
<cfif session.screening.prepopulate and not session.screening.dview>
	<cfset session.screening.dview eq 1>
	<cfset session.selectedDrugs = ''>
	<cfset drugload = true>
<cfelse>
	<cfset drugload = false>
	<cfif Not IsDefined('session.selectedDrugs')>
		<cfset session.selectedDrugs = ''>
	</cfif>
</cfif>
</cfsilent>
	<br />
	<table width="100%" align="left" cellpadding="0" cellspacing="0" border="0"><!--- inner --->
	<tr><td align="center">

		<table align="center" border="0" cellspacing="0" cellpadding="5" width="515">
			<tr>
				<td align="center" width="250" bgcolor="<cfoutput>#boxColor#</cfoutput>"><font face="Arial" size="3"><b>Available Medications</b></font></td>
				<td width="15" rowspan="5"><img src="images/pixel.gif" width="15" height="1" border="0" name="rxPixel" alt="" onLoad="rxInit()"></td>
				<td align="center" width="250" bgcolor="<cfoutput>#boxColorDark#</cfoutput>"><font face="Arial" size="3"><img src="images/pixel.gif" width="1" height="7" border="0" name="rxPixel" alt="" onLoad="rxInit()"><b>My Medications</b></td>
				<td width="15" rowspan="5"><img src="images/pixel.gif" width="15" height="1" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="center" valign="top" bgcolor="<cfoutput>#boxColor#</cfoutput>"><font face="Arial" size="2">To find your medications, scroll through the list below.  <script language="JavaScript">
<!--

if (navigator.userAgent.indexOf("Firefox")==-1)
	document.writeln("Locate a specific medication in the list by typing its name into the box below.");
else

	document.writeln("Click in the list box and press a letter key to jump to medications beginning with that letter.");
// -->
				</script></font></td>
				<td align="center" valign="top" rowspan="2" bgcolor="<cfoutput>#boxColorDark#</cfoutput>"><font face="Arial" size="2">If you accidentally select an incorrect medication, you can click on it below and then click on the "I don't take this" button to remove it.<cfif session.partner_id EQ 0>  When all your medications appear in this list, click "Next" below to continue.</cfif></center></font></td>
			</tr>
			<tr>
				<td align="center" valign="bottom" bgcolor="<cfoutput>#boxColor#</cfoutput>">

<script language="JavaScript">
<!--
if (navigator.userAgent.indexOf("Firefox")==-1) {
	var initText = "-- Click here and type medication name --";
	document.writeln('<input type="text" name="typeDrugNm" value="' + initText + '" size="30" style="width: 250px; font-family: Arial, Helvetica; font-size: 8pt;" onFocus="if (this.value == initText) {this.value = \'\'; this.form.avlDrugNm.selectedIndex = 0}" onKeyUp="matchElement(document.#attributes.form#.avlDrugNm, this.value); this.focus()"><br>');
}
// -->
</script>
				</td>
			</tr>
			
			<tr>
				<td align="center" bgcolor="<cfoutput>#boxColor#</cfoutput>">
				<cfif session.partner_id eq 0 >
					<select multiple name="avlDrugNm" size="10" width="250" style="width: 250px; font-family: Arial, Helvetica; font-size: 8pt;">
				<cfelse>
                	<script type="text/javascript">
						if (navigator.userAgent.indexOf("Firefox")!=-1){
							document.write('<select multiple name="avlDrugNm" size="10" width="250" style="font-family: Arial, Helvetica; font-size: 8pt; height:145px;">');
						}
						else {
							document.write('<select multiple name="avlDrugNm" size="10" width="250" style="font-family: Arial, Helvetica; font-size: 8pt;">');
						}
					</script>
				</cfif>
				<cfset selectedRxAccum = ''>
				<cf_loopRxStruct grouplist="rx,generic" chop="50" object="rxobj">
					<cfif session.screening.prepopulate And StructKeyExists(session.screening.a, rxobj.code)>
						<cf_handleScreeningAnswerfield action="get" code="#rxobj.code#" element="pre" var="matchVal">
						<cfif drugload and matchVal neq ''>
							<cfset session.selectedDrugs = ListAppend(session.selectedDrugs, rxobj.code)>
						</cfif>
						<cfset debugStr = " - '#matchVal#'">
					<cfelse>
						<cfset debugStr = ''>
					</cfif>
					<option value="#rxobj.code#">#rxobj.text#<cfif debug>#debugStr#</cfif></option>
					<cfif ListFind(session.selectedDrugs, rxobj.code)>
						<cfset selectedRxAccum = selectedRxAccum & "<option value=""#rxobj.code#"">#rxobj.text#</option>
">
					</cfif>
				</cf_loopRxStruct>
				</select></td>
				<td align="center" bgcolor="<cfoutput>#boxColorDark#</cfoutput>"><script type="text/javascript">
					if (navigator.userAgent.indexOf("Firefox")!=-1){
						document.write('<select multiple name="selDrugNm" size="10" width="250" style="width: 300px; font-family: Arial, Helvetica; font-size: 8pt; height:145px;">');
					}
					else {
						document.write('<select multiple name="selDrugNm" size="10" width="250" style="width: 300px; font-family: Arial, Helvetica; font-size: 8pt;">');
					}
				</script>#selectedRxAccum#</select></td>
			</tr>			
			<tr>
				<td align="center" valign="top" bgcolor="<cfoutput>#boxColor#</cfoutput>"><input type="button" name="avlDrugNmBtn" value="I take this" onClick="copyElements(this.form.avlDrugNm, this.form.selDrugNm, this.form.selDrugNm, this.form.#afrx#); if (ie) {this.form.typeDrugNm.value = ''; this.form.typeDrugNm.focus()}"><br>
				<img src="images/pixel.gif" width="1" height="10" border="0" alt=""><br>
				<input type="button" name="popup" value="Medication not in list" onClick="javascript:help2('RxNotListed.cfm')"></td>
				<td align="center" valign="top" bgcolor="<cfoutput>#boxColorDark#</cfoutput>"><input type="<cfif debug>text<cfelse>hidden</cfif>" name="#afrx#" value="<cfoutput>#HTMLEditFormat(session.selectedDrugs)#</cfoutput>">
				<input type="button" name="selDrugNmBtn" value="I don't take this" onClick="removeElements(this.form.selDrugNm, this.form.selDrugNm, this.form.#afrx#)"></td>
			</tr>
			<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "d-#afrx#")>
		</table>
</td></tr></table>
</cfif></cfif></cf_loopPoolStruct></td>
</cfoutput>