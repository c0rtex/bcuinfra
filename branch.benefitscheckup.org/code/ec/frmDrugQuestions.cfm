<!----=======================================
This template displays a list of drugs for users to select.
============================================---->
<cfsilent>
<cfset session.partner_id = 11>
<cfset defaultSearchString = "a">
<cfparam name="drugs" type="string" default="all">
<cfparam name="ltr" type="string" default="#defaultSearchString#">
<cfparam name="drg" type="string" default="">
<cfparam name="udrg" type="string" default="">
<cfparam name="clr" type="numeric" default="0">
<cfparam name="sym" type="numeric" default="0">
<cfparam name="shownumber" type="numeric" default="1">
<cfparam name="org_id" default="">
<cfparam name="user_id" default="">

<cfif ltr eq defaultSearchString or sym eq 1>
	<cfset ltr = 'a'>
	<cfset includeSymbols = true>
	<cfset sym = ',sym=1'>
<cfelse>
	<cfset includeSymbols = false>
	<cfset sym = ''>
</cfif>
<cfswitch expression="#drugs#">
	<cfcase value="brand">
		<cfset grouplist = 'rx'>
		<cfset grouptitle = 'Brand Name'>
	</cfcase>
	<cfcase value="gen">
		<cfset grouplist = 'generic'>
		<cfset grouptitle = 'Generic Drugs'>
	</cfcase>
	<cfdefaultcase>
		<cfset grouplist = 'rx,generic'>
		<cfset grouptitle = 'All Drugs'>
	</cfdefaultcase>
</cfswitch>
<cfif shownumber gt 0>
	<cfset session.shownumber = 1>
</cfif>
<cfif not IsDefined('session.selectedAFCDrugs')>
	<cfset session.selectedAFCDrugs=''>
</cfif>
<cfif not isDefined('session.language_id')>
	<cfset session.language_id='EN'>
</cfif>

<cfif IsDefined('session.partner_id') And session.partner_id eq 7>
	<cfset boxColor = "##cccc99">
<cfelse>
	<cfset boxColor = "##EAEAD2">
</cfif>

<cfif drg neq '' and ListFindNoCase(session.selectedAFCDrugs, drg) eq 0>
	<cfset session.selectedAFCDrugs = ListAppend(session.selectedAFCDrugs, drg)>
<cfelseif udrg neq '' and ListFindNoCase(session.selectedAFCDrugs, udrg)>
	<cfset session.selectedAFCDrugs = ListDeleteAt(session.selectedAFCDrugs, ListFindNoCase(session.selectedAFCDrugs, udrg))>
</cfif>

</cfsilent>

<cf_buildHTML expires="true" jsInclude="true" guts="frmDrugQuestion" show_title="yes" content_title_override="Application Forms Center" show_left_col="n">
<style type=text/css>@import url( ../ec/themes/EC/style.css );
</style>
<table width="100%" border="0" align="center" cellpadding=0 cellspacing=0>
	<tr>
	<td bgcolor=#ffffff>
<!--- Dynamic Area --->

<cfoutput>

<br>
<table border="0" align="center" width="100%"><!--- outer --->
<tr>
<td style="PADDING-RIGHT: 8px; PADDING-LEFT: 0px" valign=top  width="20%"><cfinclude template="dspFormMenu.cfm"></td>
<td>
<font face="Arial" size="3"><b>Your Medications</b></font><br><br>
</cfoutput>
<table align="center" width="100%" border="0">
<tr>
		<td width="10" valign="top">
		</td><td valign="top">
<cfoutput>
	 <font face="Arial" size="3">Find each medication you take by searching below.  Click a letter to get a list of all supported medications beginning with that letter, or enter the first few letters of a medication name in the search box and click "Find."  When you have found each medication, click its name to add it to the green "Selected Medications" box below right.  When all your medications appear in the green box, click "View Forms."&nbsp;</font><br><br>


<font face="Arial" size="3">

<b><cfloop list="##,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z" index="letter">
	<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=#drugs#&ltr=#UCase(letter)#">#UCase(letter)#</a>
<!---<cf_sessionPassVars href="ec/frmDrugQuestions.cfm" extralist="menu_tab=drug,drugs=#drugs#,ltr=#URLEncodedFormat(letter)#">#UCase(letter)#</cf_sessionPassVars>--->&nbsp;
</cfloop></b><br><br>

<form action="procGetPrg.cfm?cat=DRUG,menu_tab=drug,drugs=<cfoutput>#drugs#</cfoutput>" method="post" name="formDrug">
<table cellpadding="5" align="right" bgcolor="#boxColor#" width="250">
<tr><td style="font-size: 8pt;"><b>Selected Medications</b><cfif session.selectedAFCDrugs neq ''><br>
<i>Click medication name to remove from list</i>
<ul>
<cf_loopRxStruct grouplist="rx,generic" form="true" object="rx">
	<cfif ListFindNoCase(session.selectedAFCDrugs, rx.code)>
		<li>
			<cfif rx.code eq drg>
				<strong>
			</cfif>
			<a href="frmDrugQuestions.cfm?menu_tab=drug&drugs=#drugs#&ltr=#URLEncodedFormat(ltr)#&udrg=#rx.code##sym#">#rx.text#</a>
			<!---<cf_sessionPassVars 
					href="ec/frmDrugQuestions.cfm"
					extralist="menu_tab=drug,drugs=#drugs#,ltr=#URLEncodedFormat(ltr)#,udrg=#rx.code##sym#">#rx.text#
				</cf_sessionPassVars>--->
			<cfif rx.code eq drg>
				</strong>
			</cfif>
	</cfif>
</cf_loopRxStruct>
</ul>
<cfelse><br><br>
<i>Click a drug name to add it to this list.<br><br>
</cfif>
<input type="hidden" name="selectedDrugNm" value="#session.selectedAFCDrugs#">
<input type="hidden" name="shownumber" value="#Evaluate("session.shownumber + 1")#">
<input type="submit" value="View Forms"></td></tr>
</table></form>

<cf_sessionPassVars action="/ec/frmDrugQuestions.cfm" extralist="menu_tab=drug,drugs=#drugs#" method="get">
	<input type="text" name="ltr" value="<cfif Len(ltr) gt 1 or (Len(ltr) eq 1 and ltr neq '##' and (ltr lt 'a' or ltr gt 'z'))>#HTMLEditFormat(ltr)#</cfif>" size="40" />
	<input type="submit" value="Find" /><br />
	<span style="font-size: 7pt; font-weight: bold;">#UCase(grouptitle)#</span>
</cf_sessionPassVars>

<ul>
<cfset rxCount = 0>
<cfif ltr neq ''>
	<cfif includeSymbols>
		<cf_loopRxStruct grouplist="#grouplist#" letter="##" form="true" object="rx">
			<cfset rxCount = rxCount + 1>
			<li>
				<!---<cf_sessionPassVars href="ec/frmDrugQuestions.cfm" extralist="menu_tab=drug,drugs=#drugs#,ltr=#URLEncodedFormat(ltr)#,drg=#rx.code##sym#">#rx.text#</cf_sessionPassVars>--->
			<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=#drugs#&ltr=#URLEncodedFormat(ltr)#&drg=#rx.code##sym#"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=#drugs#&ltr=#URLEncodedFormat(ltr)#&drg=#rx.code##sym#';">
			#rx.text#
			</a>
			</li>
		</cf_loopRxStruct>
	</cfif>
	<cf_loopRxStruct grouplist="#grouplist#" letter="#ltr#" form="true" object="rx">
		<cfset rxCount = rxCount + 1>
		<li>
		<a href="frmDrugQuestions.cfm??menu_tab=drug&drugs=#drugs#&ltr=#URLEncodedFormat(ltr)#&drg=#rx.code##sym#"
			onclick="this.href='frmDrugQuestions.cfm?menu_tab=drug&drugs=#drugs#&ltr=#URLEncodedFormat(ltr)#&drg=#rx.code##sym#';">
			#rx.text#
		</a>
		<!---<cf_sessionPassVars href="ec/frmDrugQuestions.cfm" extralist="menu_tab=drug,drugs=#drugs#,ltr=#URLEncodedFormat(ltr)#,drg=#rx.code##sym#">#rx.text#</cf_sessionPassVars>--->
		</li>
	</cf_loopRxStruct>
</cfif>
<cfif not rxCount><li style="font-size: 10pt; font-style: italic;">no result</li></cfif>
</ul>

<form>
<input type="button" name="popup" value="Medication not in list?" onclick="javascript:help2('../RxNotListed.cfm')"><br><br>
</form>

</td></tr></table>

</cfoutput>

</font></td></tr>	
</table>
</form>

</td></tr>
</table>

</cf_buildHTML>