<!---=====================================================================
        Begin Mir: This  is a Update or Delete form where user can can update or delete 
		 Note by selecting the recID  from note_search2.cfm
		 CALLED BY: Note_search2.cfm
		 GOES TO: Note_search.cfm
       ======================================================================---> 
<CFQUERY DATASOURCE="#application.dbSrc#"  NAME="details1">
	select * from tbl_notes
	where recID='#RecID#'
</CFQUERY>
<HTML>

<HEAD>
	<TITLE>Details</TITLE>
</HEAD>
<cfmodule template="../header.cfm">

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<cfoutput query="details1">
<form action="note_proc.cfm"  method="POST">
<table>
	  <tr>
	      <td width="100%" rowspan="4"><TEXTAREA NAME="note" COLS="100" ROWS="10">#note#</TEXTAREA>
		<!---input type="text" name="note" value="#note#" size="90"---> 
		  </td>
      </tr>
 </table>
	  <input type="hidden" name="RecId" value="#RecId#">
  </CFOUTPUT>
  
    <CFIF  "#session.user#" IS  "READUSER">
	       <H3> You are a Read Only User </H3>
     <cfelse> 
<br>
<input TYPE="SUBMIT" NAME="Update" VALUE="Update"> 
  	</cfif>
</form>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">