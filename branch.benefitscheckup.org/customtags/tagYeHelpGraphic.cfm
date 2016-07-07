<!----=======================================
DESCRIPTION: This takes the keyword and formats the related hint.
CALLED BY: frmQuestions.cfm
GOES TO: frmQuestions.cfm
REQUIRED: attributes.keyword, session.strclient, session.gender
============================================---->
<!--- puts linked "hint" graphic. uses question_id as keyword --->
<cfparam name="attributes.keyword" type="string" default="undefined">

<!--- Query added by Chaim 1/14/00 --->
<CFQUERY datasource="#application.dbSrc#" NAME="QryCntHints">
	SELECT definition, id, keyword
	FROM tbl_hints
	WHERE keyword = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="50" value=#attributes.keyword#">	
</CFQUERY>
 
<CFIF QryCntHints.recordcount GT 0>
	<CFIF qryCntHints.keyword GT 0>
		<CFOUTPUT>
		 &nbsp;<font size="2"><A HREF="javascript:help('frmHelp.cfm?keyword=#attributes.keyword#&type=Hint')">HELP</font></A>
		</CFOUTPUT>
	</CFIF>
</CFIF>