<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: Add required material
CALLED BY: req_mat.cfm
GOES TO: req_mat.cfm
=====================================================--->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="req">
	SELECT req_mat,mat_id
	FROM tbl_req_mat_list
	ORDER BY req_mat
</CFQUERY>
<!--- select and display choices of req materials ---->
<HTML>
<HEAD>
	<TITLE>Add Req Mat</TITLE>
</HEAD>

<BODY>
<FORM ACTION="req_mat.cfm" METHOD="post">
Please choose a required material from the list below. Please be as specific as possible.
If you need something added to this list, please see Marlene.
<P>
<SELECT NAME="req_mat">
	<CFOUTPUT query="req">
		<OPTION VALUE="#mat_id#">#req_mat#
	</CFOUTPUT>
</SELECT>
<CF_tagHidden level=#session.user_level#><br>
<!---- Mir Begin To prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER"> 
<H3> You are a Read Only User </H3>
<CFELSE><!---  Mir End  --->
<INPUT TYPE="submit" NAME="add" VALUE="Add">
</cfif>
<INPUT TYPE="submit" VALUE="Cancel" ONCLICK="history.go(-1)">
</FORM>
</BODY>
</HTML>
