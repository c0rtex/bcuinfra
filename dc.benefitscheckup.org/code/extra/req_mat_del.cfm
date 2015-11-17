<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!-- delete req material -->
<HTML>
<HEAD>
	<TITLE>Delete</TITLE>
</HEAD>

<BODY>
<FORM ACTION="req_mat_del2.cfm" METHOD="post">
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="req">
	SELECT req_mat,req_id
	FROM tbl_req_mat
	WHERE prg_id = '#prg_id#'
</CFQUERY>
<CFIF req.recordcount IS 0>
	No required materials to delete.
	<CFABORT>
</CFIF>
Please choose which required materials you would like to delete.<BR>
<SELECT NAME="req_id" SIZE="10" MULTIPLE>
	<CFOUTPUT QUERY="req">
		<OPTION VALUE="#req_id#">#req_mat#
	</CFOUTPUT>
</SELECT>
<!---- begin Mir To prevent the Read only user from inserting or updating the data base ---->
 <CFIF "#session.user#" IS  "READUSER">  
<H3> You are a Read Only User </H3>
<CFELSE> 
<INPUT TYPE="submit" VALUE="Delete">
</cfif>
<CF_tagHidden level="yes">
</FORM>
</BODY>
</HTML>
