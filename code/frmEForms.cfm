<!----=======================================
DESCRIPTION: takes possible programs, pulls the rules, then checks the answers to see if the user
	qualifies
CALLED BY: procEligibility.cfm
GOES TO: frmDetails.cfm
REQUIRED: session.prg_list
============================================---->
<cfparam name="src" type="string" default="">
<cfparam name="RxPrgList" type="string" default="">
<cfparam name="eflist" type="string" default="">
<cfparam name="efnums" type="string" default="">
<cfset naImgTag = '<img src="images/n-a.gif" width="19" height="19" border="0" align="baseline" alt="not applicable">'>
<cfif IsDefined('session.org_id') And session.org_id gt 0>
	<cfset isOE = True>
	<cfset typeLimit = 2>
<cfelse>
	<cfset isOE = False>
	<cfset typeLimit = 1>
</cfif>
<cfif session.partner_id eq 7>
	<cfset theColor = '##999966'>
<cfelse>
	<cfset theColor = '##00594b'>
</cfif>
<cfif RxPrgList neq ''>
	<cfset session.RxPrgList = RxPrgList>
	<cfset session.pdfids = ''>
	<cfif StructKeyExists(session, 'codelist')>
		<cfset StructDelete(session, 'codelist')>
	</cfif>
</cfif>
<cfif IsDefined('session.returnFromGuide') And session.returnFromGuide eq 'elig'>
	<cfset returnToElig = true>
<cfelse>
	<cfset returnToElig = false>
</cfif>
<cfif IsDefined('session.guideMode') And session.guideMode eq 'rx'>
	<cfset RxRecommend = true>
<cfelse>
	<cfset RxRecommend = false>
</cfif>
<cfif IsDefined('session.codelist') And ListLen(session.codelist) gt 0>
	<cfset preset = true>
	<cfset onLoadCommand = ''>
<cfelse>
	<cfset preset = false>
	<cfset onLoadCommand = 'markRadio(0);'>
</cfif>
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

function markCheckbox(val) {
	for (var i = 0; i < document.guide.elements.length; i++)
		if (document.guide.elements[i].type == 'checkbox')
			document.guide.elements[i].checked = val;
}

function markRadio(val) {
	if (val != 0)
		markRadio(0);
	for (var i = document.guide.elements.length - 1; i >= 0; i--) {
		if (document.guide.elements[i].type == 'radio' && (document.guide.elements[i].value == val || (document.guide.elements[i].value.length > 1 && document.guide.elements[i].value.substr(document.guide.elements[i].value.length - 1) == val)))
			document.guide.elements[i].checked = true;
	}
}
// -->
</script>
</cfif>
<cf_tagHeader onLoad="#onLoadCommand#">

<cfoutput><table width=100% border="0" align="center" cellpadding="#session.cellpadding#" cellspacing="#session.cellspacing#"></cfoutput>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<cfif RxRecommend>
	<cfif Find('(', session.RxPrgList) gt 0>
		<cfset tempList = ''>
		<cfset inSubList = False>
		<cfloop list="#session.RxPrgList#" index="item">
			<cfif Find('(', item) eq 1>
				<cfset inSubList = True>
				<cfset listItem = Right(item, Len(item) - 1)>
			<cfelseif Find(')', item) eq Len(item)>
				<cfset inSubList = False>
				<cfset listItem = Left(item, Len(item) - 1)>
			<cfelse>
				<cfset listItem = item>
			</cfif>
			<cfif inSubList>
				<cfset tempList = tempList & listItem & '|'>
			<cfelse>
				<cfset tempList = tempList & listItem & ','>
			</cfif>
		</cfloop>
		<cfset session.RxPrgList = Left(tempList, Len(tempList) - 1)>
	</cfif>
	<cfset tempList = "'" & ListChangeDelims(session.RxPrgList, "','", '|,') & "'">
	<cfset otherList = ListChangeDelims(session.RxPrgList, ",", '|,')>
	<CFQUERY NAME="programs" DATASOURCE="#application.dbSrc#">
		SELECT prg_id, prg_nm
		FROM tbl_prg_all
		WHERE prg_id IN (#PreserveSingleQuotes(tempList)#)
	</CFQUERY>
	<CFQUERY NAME="forms" DATASOURCE="#application.dbSrc#">
		select p.prg_id, pf.sort, ft.formtype_id, t.formclass_id, t.tag_name
		from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
		where p.prg_id IN (#PreserveSingleQuotes(tempList)#)
			and p.recid=pf.program_id
			and pf.form_id=f.form_id
			and (f.state_id is null or f.state_id='#session.st#')
			and f.form_id=ft.form_id
			<cfif Not isOE>and ft.formtype_id <= <cfqueryparam cfsqltype="cf_sql_integer" value="#typeLimit#" maxlength="1"></cfif>
			and ft.active=1
			and f.formtag_id=t.formtag_id
		order by p.prg_id, pf.sort, ft.formtype_id
	</CFQUERY>
	<cfset majorList = Replace(session.RxPrgList, "'", '', 'ALL')>
<cfelse>
	<!--- Pull in eForm-enabled programs from session.prg_list--->
	<CFQUERY NAME="programs" DATASOURCE="#application.dbSrc#">
		SELECT prg_id, prg_nm
		FROM tbl_prg_all
		WHERE prg_id IN (#PreserveSingleQuotes(session.prg_list)#)
	</CFQUERY>
	<CFQUERY NAME="forms" DATASOURCE="#application.dbSrc#">
		select p.prg_id, pf.sort, ft.formtype_id, t.formclass_id, t.tag_name
		from tbl_prg_all p, program_form pf, form f, form_formtype ft, formtag t
		where p.prg_id IN (#PreserveSingleQuotes(session.prg_list)#)
			and p.recid=pf.program_id
			and pf.form_id=f.form_id
			and (f.state_id is null or f.state_id='#session.st#')
			and f.form_id=ft.form_id
			<cfif Not isOE>and ft.formtype_id <= <cfqueryparam cfsqltype="cf_sql_integer" value="#typeLimit#" maxlength="1"></cfif>
			and ft.active=1
			and f.formtag_id=t.formtag_id
		order by p.prg_id, pf.sort, ft.formtype_id
	</CFQUERY>
	<CFQUERY NAME="order" DATASOURCE="#application.dbSrc#">
		SELECT prg_id AS eachPrg
		FROM tbl_prg_all
		WHERE prg_id IN (#PreserveSingleQuotes(session.prg_list)#)
		ORDER BY order_num, prg_nm
	</CFQUERY>
	<cfset majorList = ''>
	<cfloop query="order">
		<cfif ListGetAt(eachPrg, 2, '-') neq '333' And ListGetAt(eachPrg, 2, '-') neq '334'>
			<cfset majorList = ListAppend(majorList, eachPrg)>
		</cfif>
	</cfloop>
</cfif>

<cfset programName = StructNew()>
<cfset programChain = StructNew()>
<cfset programLinkName = StructNew()>
<cfloop query="programs">
	<cfset StructInsert(programName, prg_id, prg_nm)>
</cfloop>
<cfloop query="forms">
	<cfset link = sort & '-' & formclass_id>
	<cfset chain = link & '-' & formtype_id>
	<cfset prgLink = prg_id & '-' & link>
	<cfif StructKeyExists(programChain, prg_id)>
		<cfset StructUpdate(programChain, prg_id, ListAppend(StructFind(programChain, prg_id), chain))>
	<cfelse>
		<cfset StructInsert(programChain, prg_id, chain)>
	</cfif>
	<cfif Not StructKeyExists(programLinkName, prgLink)>
		<cfset StructInsert(programLinkName, prgLink, tag_name)>
	</cfif>
</cfloop>


<cfif RxRecommend>
	<cfset testListContents = session.RxPrgList>
<cfelse>
	<cfset testListContents = session.prg_list>
</cfif>
<cfif ListFind(testListContents, 'XXX-311-2387-FD-FD') gt 0>
	<cfset hasGenericPrg = true>
<cfelse>
	<cfset hasGenericPrg = false>
</cfif>
<cfif ListFind(testListContents, '103-311-2588-FD-FD') gt 0 Or ListFind(testListContents, '103-311-2592-FD-FD') gt 0 Or ListFind(testListContents, '103-311-2593-FD-FD') gt 0>
	<cfset hasPartDPrg = true>
<cfelse>
	<cfset hasPartDPrg = false>
</cfif>

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
<FONT face="Arial"><FONT SIZE=+2><B>Application Guide</B></FONT>
<hr>
<!--- output the lead paragraph for the page --->

<FONT FACE="Arial"><FONT SIZE="+1">

<!--- The actual output for the visible screen this is the list of programs numbered --->
<cfoutput>

<cfset tempList = "'" & ListChangeDelims(session.RxPrgList, "','", '|,') & "'">

Below is the list of programs we recommend for you to help with your prescription drug costs.  For your recommended programs, you can get <b>fact sheets</b> and/or <b>application forms</b>.  We recommend you select a fact sheet and an application form (if available) for each program you want to apply for.  Beneath the list there are buttons to help you print and/or fill out your selections.<br><br>

<cf_hasMedicareCards list="#tempList#">
<cfif hasMedicareCards>
<blockquote>
<hr size="2" color="#theColor#">
<b>Now apply for your Medicare-approved drug discount card online!&nbsp;</b>
<a href="dspMedicareEnroll.cfm?src=frame&cfid=#cfid#&cftoken=#cftoken#">Click here</a>.
<hr size="2" color="#theColor#">
</blockquote>
</cfif>

Click the following links to receive helpful instructions on:

<ul><li><a href="javascript:help2('hlpEForms.cfm')">How to use this Application Guide</a>
<li><a href="applicationinfo.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&src=guide">What to do after you have printed your applications</a></ul>

<cfif hasPartDPrg AND 1 eq 1>
Also, to sign up to learn more about new Medicare drug benefits (available in 2006), <a href="##study">click here</a>.<br><br>
<cfelseif 1 eq 0>
Also, <cfif hasPartDPrg>to sign up to learn more about new Medicare drug benefits (available in 2006) </cfif>to participate in our important research study, <a href="##study">click here</a>.<br><br>
</cfif>
<form action="printforms.cfm" method="post" name="guide">
<table bgcolor="##ffffff" cellpadding="0" cellspacing="3" border="0">

	<tr>
		<td colspan="8" align="center" valign="top" bgcolor="#theColor#"><img src="img/pixel.gif" width="1" height="2" alt=""></td>
	</tr>

	<tr></tr>

	<tr>
		<td bgcolor="white" valign="bottom" align="center"><b>Fact<br>Sheet</b><br><span style="font-size: 9pt;"><a href="javascript:markCheckbox(true)">on</a>&nbsp;|&nbsp;<a href="javascript:markCheckbox(false)">off</a></span></td>
		<td align="center" valign="middle"><table height="100%" width="1" border="0" cellspacing="0" cellpadding="0"><tr><td>&nbsp;</td><td bgcolor="#theColor#"><img src="img/pixel.gif" width="2" height="50" alt=""></td><td>&nbsp;</td></tr></table></td>
		<td bgcolor="white" valign="bottom" align="center"><b>Blank<br>Form</b><br><span style="font-size: 9pt;"><a href="javascript:markRadio(1)">all</a></span></td>
		<cfif isOE><td bgcolor="white" valign="bottom" align="center"><b>e-Form</b><br><span style="font-size: 9pt;"><a href="javascript:markRadio(2)">all</a></span></td></cfif>
		<td bgcolor="white" valign="bottom" align="center"><b>None</b><br><span style="font-size: 9pt;"><a href="javascript:markRadio(0)">all</a></span></td>
		<td align="center" valign="middle"><table height="100%" width="1" border="0" cellspacing="0" cellpadding="0"><tr><td>&nbsp;</td><td bgcolor="#theColor#"><img src="img/pixel.gif" width="2" height="50" alt=""></td><td>&nbsp;</td></tr></table></td>
		<td colspan="2" bgcolor="white" valign="bottom" align="center"><b>Programs</b><br><span style="font-size: 9pt;">&nbsp;</span></td>
	</tr>
					
	<tr></tr>

	<cfset prgnum = 1>
	<cfset codeList = ''>
	<cfloop list="#majorList#" index="subList">
		<tr>
			<td colspan="8" align="center" valign="top" bgcolor="#theColor#"><img src="img/pixel.gif" width="1" height="2" alt=""></td>
		</tr>


		<cfif ListLen(subList, '|') gt 1>
			<tr>
				<td colspan="#Evaluate("2 + typeLimit")#">
				<td align="center" valign="top"><input type="radio" name="r-#prgnum#" value="0"></td>
				<td></td>
				<TD align="right" valign="top"><FONT FACE="arial" ><b>#prgnum#.</b>&nbsp;</FONT></TD>
				<td align="left" valign="top"><FONT FACE="arial"><b>Choose one of the following:</b></FONT></TD>
			</tr>
			<cfset codeList = ListAppend(codeList, "r-#prgnum#")>
			<cfset subnum = 1>
			<cfset radioButtonSetInGroup = false>
			<cfloop list="#subList#" index="thisPrg" delimiters="|">
				<cfif subnum gt 1>
					<tr>
						<td></td>
						<td colspan="7" align="center" valign="top" bgcolor="#theColor#"><img src="img/pixel.gif" width="1" height="1" alt=""></td>
					</tr>
				</cfif>
			<tr>
				<td align="center" valign="top"><input type="checkbox" name="fact-#thisPrg#" value="1"<cfif preset And ListFind(session.codelist, "fact-#thisPrg#")> checked</cfif>></td>
				<cfset codeList = ListAppend(codeList, "fact-#thisPrg#")>


			<cfif StructKeyExists(programChain, thisPrg)>
				<cfif ListLen(StructFind(programChain, thisPrg)) gt 1>
					<cfset subChain = StructNew()>
					<cfset subLinkList = ''>
					<cfloop index="sub" list="#StructFind(programChain, thisPrg)#">
						<cfif ListGetAt(sub, 2, '-') eq 1>
							<cfset subType = ListGetAt(sub, 3, '-')>
							<cfset subLink = ListDeleteAt(sub, 3, '-')>
							<cfif StructKeyExists(subChain, subLink)>
								<cfset StructUpdate(subChain, subLink, ListAppend(StructFind(subChain, subLink), subType))>
							<cfelse>
								<cfset StructInsert(subChain, subLink, subType)>
								<cfset subLinkList = ListAppend(subLinkList, subLink)>
							</cfif>
						</cfif>
					</cfloop>

					<cfset seenForm = false>
					<cfset firstRow = true>
					<cfloop index="subLink" list="#subLinkList#">
						<cfif firstRow and ListLen(subLinkList) gt 1>
								<td colspan="<cfif isOE>6<cfelse>5</cfif>"></td>
								<td align="left" valign="top"><FONT FACE="arial">#StructFind(programName, thisPrg)#</FONT></TD>
							</tr>
						</cfif>
						<cfif (firstRow and ListLen(subLinkList) gt 1) Or Not firstRow>
							<tr>
								<td colspan="2"></td>
						</cfif>
						<cfif ListLen(subLinkList) eq 1>
							<td></td>
						</cfif>
							<cfloop index="i" from="1" to="#typeLimit#">
							<td align="center" valign="top"><cfif ListFind(StructFind(subChain, subLink), i) gt 0><input type="radio" name="r-#prgnum#" value="form-#thisPrg#-#subLink#-#i#"<cfif (Not preset And Not radioButtonSetInGroup) or (preset And ListFind(session.codelist, "form-#thisPrg#-#subLink#-#i#"))> checked</cfif>><cfelse>#naImgTag#</cfif></td>
								<cfset radioButtonSetInGroup = true>
							</cfloop>
							<td colspan="3"></td>
							<cfif firstRow and ListLen(subLinkList) eq 1>
							<td align="left" valign="top"><FONT FACE="arial">#StructFind(programName, thisPrg)#</FONT></TD>
							<cfelse>
							<td align="left" valign="center"><FONT FACE="arial"><span style="font-size: 8pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#UCase(StructFind(programLinkName, thisPrg & '-' & subLink))#</span></FONT></TD>
							</cfif>
						</tr>
						<cfif ListGetAt(subLink, 2, '-') eq 1>
							<cfset seenForm = true>
						</cfif>
						<cfset firstRow = false>
					</cfloop>
				<cfelse>
					<cfset grabType = ListGetAt(StructFind(programChain, thisPrg), 3, '-')>
					<cfset grabLink = ListDeleteAt(StructFind(programChain, thisPrg), 3, '-')>
						<td></td>
						<cfloop index="i" from="1" to="#typeLimit#">
						<td align="center" valign="top"><cfif grabType eq i><input type="radio" name="r-#prgnum#" value="form-#thisPrg#-#grabLink#-#i#"<cfif (Not preset And Not radioButtonSetInGroup) Or (preset And ListFind(session.codelist, "form-#thisPrg#-#grabLink#-#i#"))> checked</cfif>></cfif></td>
								<cfset radioButtonSetInGroup = true>
						</cfloop>
						<td colspan="3"></td>
						<td align="left" valign="top"><FONT FACE="arial">#StructFind(programName, thisPrg)#</FONT></TD>
					</tr>
				</cfif>
			<cfelse>
					<td colspan="6">
					<td align="left" valign="top"><FONT FACE="arial">#StructFind(programName, thisPrg)#</FONT></TD>
				</tr>
			</cfif>



				<cfset subnum = subnum + 1>
			</cfloop>
		<cfelse>  <!--- Not a multiple choicer --->
			<cfif StructKeyExists(programChain, subList)>
				<cfif ListLen(StructFind(programChain, subList)) gt 1>
					<cfset subChain = StructNew()>
					<cfset subLinkList = ''>
					<cfloop index="sub" list="#StructFind(programChain, subList)#">
						<cfset subType = ListGetAt(sub, 3, '-')>
						<cfset subLink = ListDeleteAt(sub, 3, '-')>
						<cfif StructKeyExists(subChain, subLink)>
							<cfset StructUpdate(subChain, subLink, ListAppend(StructFind(subChain, subLink), subType))>
						<cfelse>
							<cfset StructInsert(subChain, subLink, subType)>
							<cfset subLinkList = ListAppend(subLinkList, subLink)>
						</cfif>
					</cfloop>
					<tr>
						<td align="center" valign="top"><input type="checkbox" name="fact-#subList#" value="1"<cfif preset And ListFind(session.codelist, "fact-#subList#")> checked</cfif>></td>
						<cfset codeList = ListAppend(codeList, "fact-#subList#")>
						<td colspan="#Evaluate("3 + typeLimit")#"></td>
						<TD align="right" valign="top"><FONT FACE="arial" ><b>#prgnum#.</b>&nbsp;</FONT></TD>
						<td align="left" valign="top"><FONT FACE="arial"><b>#StructFind(programName, subList)#</b></FONT></TD>
					</tr>
					<cfset seenForm = false>
					<cfloop index="subLink" list="#subLinkList#">
						<tr>
							<td></td>
							<td colspan="7" align="center" valign="top" bgcolor="#theColor#"><img src="img/pixel.gif" width="1" height="1" alt=""></td>
						</tr>
						<tr>
							<td colspan="2"></td>
							<cfloop index="i" from="1" to="#typeLimit#">
							<td align="center" valign="top"><cfif ListFind(StructFind(subChain, subLink), i) gt 0><input type="radio" name="form-#subList#-#subLink#" value="#i#"<cfif (Not preset And Not seenForm And (i Eq 2 Or (i Eq 1 And ListFind(StructFind(subChain, subLink), 2) Eq 0))) or (preset And ListFind(session.codelist, "form-#subList#-#subLink#-#i#"))> checked</cfif>><cfelse>#naImgTag#</cfif></td>
							</cfloop>
							<td align="center" valign="top"><input type="radio" name="form-#subList#-#subLink#" value="0"<cfif (Not preset And seenForm) Or (preset And ListFind(session.codelist, "form-#subList#-#subLink#-1") eq 0 And ListFind(session.codelist, "form-#subList#-#subLink#-2") eq 0)> checked</cfif>></td>
							<cfset codeList = ListAppend(codeList, "form-#subList#-#subLink#")>
							<td colspan="2"></td>
							<td align="left" valign="top"><FONT FACE="arial">#StructFind(programLinkName, subList & '-' & subLink)#</FONT></TD>
						</tr>
						<cfif ListGetAt(subLink, 2, '-') eq 1>
							<cfset seenForm = true>
						</cfif>
					</cfloop>
				<cfelse>
					<cfset grabType = ListGetAt(StructFind(programChain, subList), 3, '-')>
					<cfset grabLink = ListDeleteAt(StructFind(programChain, subList), 3, '-')>
					<tr>
						<td align="center" valign="top"><input type="checkbox" name="fact-#subList#" value="1"<cfif preset And ListFind(session.codelist, "fact-#subList#")> checked</cfif>></td>
						<cfset codeList = ListAppend(codeList, "fact-#subList#")>
						<td></td>
						<cfloop index="i" from="1" to="#typeLimit#">
						<td align="center" valign="top"><cfif grabType eq i><input type="radio" name="form-#subList#-#grabLink#" value="#i#"<cfif Not preset Or (preset And ListFind(session.codelist, "form-#subList#-#grabLink#-#i#"))> checked</cfif>><cfelse>#naImgTag#</cfif></td>
						</cfloop>
						<td align="center" valign="top"><input type="radio" name="form-#subList#-#grabLink#" value="0"<cfif preset And ListFind(session.codelist, "form-#subList#-#grabLink#-1") eq 0 And ListFind(session.codelist, "form-#subList#-#grabLink#-2") eq 0> checked</cfif>></td>
						<cfset codeList = ListAppend(codeList, "form-#subList#-#grabLink#")>
						<td></td>
						<TD align="right" valign="top"><FONT FACE="arial" ><b>#prgnum#.</b>&nbsp;</FONT></TD>
						<td align="left" valign="top"><FONT FACE="arial"><b>#StructFind(programName, subList)#</b></FONT></TD>
					</tr>
				</cfif>
			<cfelse>
				<tr>
					<td align="center" valign="top"><input type="checkbox" name="fact-#subList#" value="1"<cfif preset And ListFind(session.codelist, "fact-#subList#")> checked</cfif>></td>
					<cfset codeList = ListAppend(codeList, "fact-#subList#")>
					<td></td>
					<cfloop index="loopx" from="0" to="#typeLimit#">
						<td align="center" valign="top">#naImgTag#</td>
					</cfloop>
					<td></td>
					<TD align="right" valign="top"><FONT FACE="arial" ><b>#prgnum#.</b>&nbsp;</FONT></TD>
					<td align="left" valign="top"><FONT FACE="arial"><b>#StructFind(programName, subList)#</b></FONT></TD>
				</tr>
			</cfif>
		</cfif>
		<CFSET prgnum = prgnum + 1>
	</cfloop>
	
	<tr>
		<td colspan="8" align="center" valign="top" bgcolor="#theColor#"><img src="img/pixel.gif" width="1" height="2" alt=""></td>
	</tr>

	<tr></tr>

	<tr>
		<td bgcolor="white" valign="top" align="center"><span style="font-size: 9pt;"><a href="javascript:markCheckbox(true)">on</a>&nbsp;|&nbsp;<a href="javascript:markCheckbox(false)">off</a></span><br><img src="img/pixel.gif" width="1" height="2" alt=""><br><b>Fact<br>Sheet</b></td>
		<td align="center" valign="middle"><table height="100%" width="1" border="0" cellspacing="0" cellpadding="0"><tr><td>&nbsp;</td><td bgcolor="#theColor#"><img src="img/pixel.gif" width="2" height="50" alt=""></td><td>&nbsp;</td></tr></table></td>
		<td bgcolor="white" valign="top" align="center"><span style="font-size: 9pt;"><a href="javascript:markRadio(1)">all</a></span><br><img src="img/pixel.gif" width="1" height="2" alt=""><br><b>Blank<br>Form</b></td>
		<cfif isOE><td bgcolor="white" valign="top" align="center"><span style="font-size: 9pt;"><a href="javascript:markRadio(2)">all</a></span><br><img src="img/pixel.gif" width="1" height="2" alt=""><br><b>e-Form</b></td></cfif>
		<td bgcolor="white" valign="top" align="center"><span style="font-size: 9pt;"><a href="javascript:markRadio(0)">all</a></span><br><img src="img/pixel.gif" width="1" height="2" alt=""><br><b>None</b></td>
		<td align="center" valign="middle"><table height="100%" width="1" border="0" cellspacing="0" cellpadding="0"><tr><td>&nbsp;</td><td bgcolor="#theColor#"><img src="img/pixel.gif" width="2" height="50" alt=""></td><td>&nbsp;</td></tr></table></td>
		<td colspan="2" bgcolor="white" valign="top" align="center"><span style="font-size: 9pt;">&nbsp;</span><br><img src="img/pixel.gif" width="1" height="2" alt=""><br><b>Programs</b></td>
	</tr>
					
	<tr></tr>

	<tr>
		<td colspan="8" align="center" valign="top" bgcolor="#theColor#"><img src="img/pixel.gif" width="1" height="2" alt=""></td>
	</tr>

</table><br>
<input type="hidden" name="codelist" value="#codeList#">
<input type="submit" name="single" value="Download and Fill Out All Marked Items"> &nbsp;
<input type="button" name="singlehelp" value="Help" onClick="help2('hlpDownload.cfm')"><br><br>
<input type="submit" name="fact" value="Print All Marked Fact Sheets at Once"> &nbsp;
<input type="button" name="facthelp" value="Help" onClick="help2('hlpPrintFact.cfm')"><br><br>
<input type="submit" name="merge" value="Print All Marked Forms at Once"> &nbsp;
<input type="button" name="mergehelp" value="Help" onClick="help2('hlpPrintMarked.cfm')">
</form>
<cfif returnToElig>
<FORM method="post" action="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" target="_top">
<cfelse>
<FORM method="post" action="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" target="_top">
</cfif>
<a name="fact"></a>
   	<font face="Arial" size="3">
       <b><INPUT TYPE="submit" NAME="prev" VALUE="Back to <cfif returnToElig>Results<cfelse>ABC Recommendations</cfif>"></b>
	   <cfif Not returnToElig>
	    &nbsp;
<input type="button" name="mergehelp" value="Help" onClick="help2('hlpReturn.cfm')">
	   </cfif>
       </font>
</FORM>
<cfif hasPartDPrg>
<hr><br>
</cfif>
</cfoutput>

<!--------------- START MEDICARE PART D and RESEARCH STUDY ------------------->

<cfif hasPartDPrg>
<cfoutput>
<a name="study"></a>
<b>Sign Up for Medicare Part D Notification<!---s and Surveys---></b><br><br>

We urge you to sign up now to receive updates from the Access to Benefits Coalition about the new Medicare Part D prescription drug benefits that begin in January 2006.  You may be able to apply for this coverage beginning in July 2005.  Click the button below to sign up.<br><br>

<form action="printforms.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
<input type="hidden" name="code" value="Medicare_Part_D_Notify_FF">
<input type="submit" name="special" value="Sign Up for Medicare Part D Notification">
</form>

<!---
Also, t<cfelse>T</cfif>o better serve people like you, the National Council on Aging is sponsoring a brief telephone survey to see if people ask for and get the benefits for which they might qualify.  To thank you for your time, you will be sent <b>$10</b> after completing the phone survey.  Click the button below to sign up.<br><br>

<form action="printforms.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" method="post">
<input type="hidden" name="code" value="NCOA_Research_Study_001_FF">
<input type="submit" name="special" value="Sign Up for Research Study">
</form>
--->
</cfoutput>

<CFOUTPUT>
<cfif returnToElig>
<FORM method="post" action="frmeligibility.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" target="_top">
<cfelse>
<FORM method="post" action="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" target="_top">
</cfif>
   	<font face="Arial" size="3">
       <b><INPUT TYPE="submit" NAME="prev" VALUE="Back to <cfif returnToElig>Results<cfelse>ABC Recommendations</cfif>"></b>
       </font>

</CFOUTPUT>
</FORM>
</cfif>

<!---------------- END MEDICARE PART D and RESEARCH STUDY -------------------->

</FONT></TD></TR></TABLE>

<!--- call footer tag --->
<cf_tagFooter>
