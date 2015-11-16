<cfparam name="group_id" type="numeric" default="0">
<cfmodule template="../header.cfm">
<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: Adds a new entry point
CALLED BY: 
GOES TO: add_spons2.cfm
===================================================== --->

<!---add an entry point to list--->
<CFIF IsDefined("prg_id")>
	<CFSET prg_id = #prg_id#>
<CFELSE>
	<CFSET prg_id = 0>
</CFIF>

<HTML>
<HEAD>
	<TITLE>Add Entry Point</TITLE>
</HEAD>

<BODY>
<font face=arial size=4>Please enter the Organization information</font><BR>
<CFIF IsDefined("zip")>
	<CFOUTPUT>
		<B>Zip of last Entry Point entered:</B>
		<BR>#zip#
	</CFOUTPUT>
</CFIF>
<FORM action="add_spons2.cfm" method="post">
<!---- Mir Begin Passing a Parameter 'ReadUser' to prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER"> 
<H3> You are a Read Only User </H3>
<CFELSE> 
<INPUT TYPE="submit" NAME="add" VALUE="Add">
</cfif> <!--- end Mir --->
<TABLE BORDER="1" WIDTH="100%">
	<TR>
		<TD WIDTH="5%">
			<B>Organization Name</B>
		</TD>
		<TD WIDTH="1%" COLSPAN="3">
			<B><INPUT TYPE="text" NAME="org_name" SIZE="50"></B>
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>Organization Name2</B>
		</TD>
		<TD WIDTH="1%" COLSPAN="3">
			<B><INPUT TYPE="text" NAME="org_name2" SIZE="50"></B>
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>Address</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="address" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>Address1</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="address1" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>Address2</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="address2" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>City</B>
		</TD>
		<TD WIDTH="1%" COLSPAN="3">
			<INPUT TYPE="text" NAME="city" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="1%">
			<B>State</B>
		</TD>
		<TD WIDTH="1%">
			<INPUT TYPE="text" NAME="st" SIZE="2">
		</TD>
		<TD WIDTH="1%">
			<B>Zip</B>
		</TD>
		<TD WIDTH="30%">
			<INPUT TYPE="text" NAME="zip"  SIZE="5">
		</TD>
	</TR>
	<TR>
		<TD>
			<B>Counties Served</B>
		</TD>
		<TD COLSPAN="3">
			<INPUT TYPE="text" NAME="counties_served" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD>
			<B>Cities Served</B>
		</TD>
		<TD COLSPAN="3">
			<INPUT TYPE="text" NAME="cities_served" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD>
			<B>Zips Served</B>
		</TD>
		<TD COLSPAN="3">
			<INPUT TYPE="text" NAME="zips_served" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>Phone</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="phone_no" SIZE="25">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>Fax</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="fax" SIZE="25">
		</TD>
	</TR>
	

	<TR>
		<TD WIDTH="1%">
			<B>1st-area</B>
		</TD>
		<TD WIDTH="1%">
			<INPUT TYPE="text" NAME="a_area" SIZE="3">
		</TD>
		<TD WIDTH="1%">
			<B>1st-number</B>
		</TD>
		<TD WIDTH="30%">
			<INPUT TYPE="text" NAME="a_number"  SIZE="7">
		</TD>
	</TR>
	<TR>
		<TD>
			<B>Notes</B>
		</TD>
		<TD COLSPAN="3">
			<INPUT TYPE="text" NAME="a_note" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="1%">
			<B>2nd-area</B>
		</TD>
		<TD WIDTH="1%">
			<INPUT TYPE="text" NAME="b_area" SIZE="3">
		</TD>
		<TD WIDTH="1%">
			<B>2nd-number</B>
		</TD>
		<TD WIDTH="30%">
			<INPUT TYPE="text" NAME="b_number"  SIZE="7">
		</TD>
	</TR>
	<TR>
		<TD>
			<B>Notes</B>
		</TD>
		<TD COLSPAN="3">
			<INPUT TYPE="text" NAME="b_note" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="1%">
			<B>3rd-area</B>
		</TD>
		<TD WIDTH="1%">
			<INPUT TYPE="text" NAME="c_area" SIZE="3">
		</TD>
		<TD WIDTH="1%">
			<B>3rd-number</B>
		</TD>
		<TD WIDTH="30%">
			<INPUT TYPE="text" NAME="c_number"  SIZE="7">
		</TD>
	</TR>
	<TR>
		<TD>
			<B>Notes</B>
		</TD>
		<TD COLSPAN="3">
			<INPUT TYPE="text" NAME="c_note" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="1%">
			<B>Fax-area</B>
		</TD>
		<TD WIDTH="1%">
			<INPUT TYPE="text" NAME="f_area" SIZE="3">
		</TD>
		<TD WIDTH="1%">
			<B>Fax-number</B>
		</TD>
		<TD WIDTH="30%">
			<INPUT TYPE="text" NAME="f_number"  SIZE="7">
		</TD>
	</TR>
	<TR>
		<TD>
			<B>Additional Notes</B>
		</TD>
		<TD COLSPAN="3">
			<INPUT TYPE="text" NAME="additional" SIZE="50">
		</TD>
	</TR>


	<TR>
		<TD WIDTH="5%">
			<B>E-Mail</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="email" SIZE="50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH="5%">
			<B>Web Site</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="web_site" SIZE="50">
		</TD>
	</TR>
		<TD WIDTH="5%">
			<B>Hours (i.e. 9-5 M-F)</B>
		</TD>
		<TD COLSPAN="3" WIDTH="1%">
			<INPUT TYPE="text" NAME="hours" SIZE="50">
		</TD>
	</TR>
</TABLE>

<!---- Mir Begin Passing a Parameter 'ReadUser' to prevent the Read only user from inserting or updating the data base ---->
<CFIF "#session.user#" IS  "READUSER"> 
<CFELSE> 
<INPUT TYPE="submit" NAME="add" VALUE="Add">
</cfif>
<CFIF IsDefined("group_id")>
	<CFOUTPUT>
	<INPUT TYPE="hidden" NAME="group_id" VALUE="#group_id#">
	</CFOUTPUT>
</CFIF>
</FORM>
</BODY>
<cfmodule template="../footer.cfm">
</HTML>