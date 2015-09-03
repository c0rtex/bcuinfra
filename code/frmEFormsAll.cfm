<!----=======================================
DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user
	qualifies
CALLED BY: procEligibility.cfm
GOES TO: frmDetails.cfm
REQUIRED: session.prg_list
============================================---->
<cf_sessioncheck>
<cfif IsDefined('application.serverPathOE')>
<script language="JavaScript1.1">
<!--
function openMain() {
		setTimeout('window.close()', 1000);
		window.open('http://<cfoutput>#application.serverPathOE#</cfoutput>/menu.do', 'main');
		main.focus();
}

function exitQuestionnaire() {
	if (document.layers) {
		if (window.opener.closed) {
			openMain();
		} else {
			window.opener.focus();
			window.close();
		}
	} else {
		window.onerror = openMain;
		if (!(window.opener.closed)) {
			window.opener.focus();
			window.close();
		}
	}
}
// -->
</script>
</cfif>
<cf_tagHeader>

<cfoutput><table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#"></cfoutput>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<!--- Pull in eForm-enabled programs from session.prg_list--->
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prgs">
	SELECT p.prg_id, p.prg_nm, pa.ag_code
	FROM tbl_prg_agcode pa, tbl_prg_all p
	WHERE pa.prg_id=p.prg_id
	ORDER BY p.order_num DESC, p.prg_nm DESC, pa.ag_code
</CFQUERY> 

 <!--- table width="550"><tr><td --->
<!--- set session client variable for questions 12/12/2000 --->
<cfset person="#session.StrClient#">
<cfswitch expression="#session.StrClient#">
   <cfcase value="self"><cfset person="You">
   </cfcase>
   <cfcase value="brother"><cfset person="Your Brother">
   </cfcase>
   <cfcase value="sister"><cfset person="Your Sister">
   </cfcase>
   <cfcase value="father"><cfset person="Your Father">
   </cfcase>
   <cfcase value="mother"><cfset person="Your Mother">
   </cfcase>
   <cfcase value="client"><cfset person="Your Client">
   </cfcase>
</cfswitch>
<FONT face="Arial"><FONT SIZE=+2><B>e-Forms Available</B></FONT>
<hr>
<!--- output the lead paragraph for the page --->

<FONT FACE="Arial"><FONT SIZE="+1">

<b>Programs with available e-Forms</b>.  Click the checkbox beside each program for which you would like to fill out and print an electronic form.  Then click "Access e-Forms."  The applications will open in a new browser window.
<br><br>

<cfoutput><form action="#request.eFormURL#" method="post" target="_blank"></cfoutput>

<!--- The actual output for the visible screen this is the list of programs numbered --->
<TABLE border="0"><FONT FACE="Arial" SIZE="+1">
	<cfset prgnum = 1>
	
      <CFOUTPUT QUERY="prgs">
      
      <TR>
	  <td valign="top"><input type="checkbox" name="#ag_code#" checked>&nbsp;</td>
	  <TD align="right" valign="top"><FONT FACE="arial" ><b>#prgnum#.</b>&nbsp;</FONT></TD>
      <td align="left" valign="top"><FONT FACE="arial"><b>
      <!A HREF="frmdetails.cfm?prg_id=#prgs.prg_id#&CFID=#session.cfid#&CFTOKEN=#session.cftoken#">#prgs.prg_nm#<!/A></b><br><font size="-1"><i>#ag_code#</i></font>
      </FONT></TD></TR>
      
		<!--- set program number and finish loop through prg_id --->
		<CFSET prgnum = prgnum + 1>

      </CFOUTPUT>
</font>
</TABLE><br>

<cf_genAssistGuideXML>
<cfoutput><input type="hidden" name="startxml" value="#startAssistGuideXML#">
<input type="hidden" name="endxml" value="#endAssistGuideXML#">
<input type="hidden" name="xml" value="">
<input type="button" value="Access e-Forms" onClick="var countChex = 0; this.form.xml.value = this.form.startxml.value; for (x = 0; x < this.form.elements.length; x++) {if (this.form.elements[x].type == 'checkbox' && this.form.elements[x].checked) {this.form.xml.value = this.form.xml.value + '<Form>' + this.form.elements[x].name + '</Form>\n'; countChex++;}} this.form.xml.value = this.form.xml.value + this.form.endxml.value; if (countChex > 0) {this.form.submit();} else {alert('You didn\'t mark any programs');}">
</form></cfoutput>

<FORM>
<CFOUTPUT>
   	<font face="Arial" size="3">
       <b><INPUT TYPE="button" NAME="prev" VALUE="Back to Results" ONCLICK="history.go(-1);"></b>
       </font>
</CFOUTPUT>
</FORM>

</FONT></TD></TR></TABLE>

<!--- call footer tag --->
<cf_tagFooter>
