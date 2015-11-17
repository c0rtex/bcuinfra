<!--========================================================================
Description: This Code displays all the data depending on search criteria, lists contact name
							 and associated program names, that match search criteria
Called By: Contact_srch.cfm
Goes TO : Contact_details.cfm
==========================================================================--->

<cfmodule template="../header.cfm">
<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">

<CFIF isdefined("contact_id")>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="contact">
select *
from tbl_contacts
where contact_id = #contact_id#
</CFQUERY>
<CFFORM ACTION="contact_action.cfm" METHOD="POST">
<CFOUTPUT QUERY="contact">
	<table border="0" width="100%" BGCOLOR="SILVER">
    <tr>
      <td width="20%" align="right">First Name</td>
      <td width="20%"><input type="text" name="firstname" value="#firstname#" size="20"></td>
      <td width="20%" align="right" colspan="2">Last Name</td>
      <td width="20%"><input type="text" name="lastname" value="#lastname#" size="20"></td>
      <td width="20%" align="right" colspan="2">Category</td>
      <td width="20%"><input type="text" name="category" value="#category#" size="20"></td>
    </tr>
    <tr>
      <td width="20%" align="right">Phone</td>
      <td width="20%"><input type="text" name="phone" value="#phone#" size="20"></td>
      <td width="20%" align="right" colspan="2">Phone 2</td>
      <td width="20%"><input type="text" name="phone2" value="#phone2#" size="20"></td>
      <td width="20%" align="right" colspan="2">State</td>
      <td width="20%"><input type="text" name="state" value="#state#" size="20"></td>
    </tr>
    <tr>
      <td width="20%" align="right">Fax</td>
      <td width="20%"><input type="text" name="fax" value="#fax#" size="20"></td>
      <td width="20%" align="right" colspan="2">E-mail</td>
      <td width="20%"><input type="text" name="email" value="#email#" size="20"></td>
      <td width="20%" align="right" colspan="2">Title</td>
      <td width="20%"><input type="text" name="title" value="#title#" size="20"></td>
    </tr>
    <tr>
      <td width="20%" align="right">Organization</td>
      <td width="100%" colspan="7"><input type="text" name="org" value="#org#" size="75"></td>
    </tr>
    <tr>
      <td width="20%" align="right">Address</td>
      <td width="40%" colspan="3"><input type="text" name="address" value="#address#" size="30"></td>
      <td width="20%"><div align="right"><p>Address2</td>
      <td width="40%" colspan="3"><input type="text" name="address2" value="#address2#" size="30"></td>
    </tr>
    <tr>
      <td width="20%" align="right">City</td>
      <td width="20%"><input type="text" name="city" value="#city#" size="20"></td>
      <td width="20%" align="right" colspan="2">Zip</td>
      <td width="20%"><input type="text" name="zip" value="#zip#" size="20"></td>
      <td width="20%" colspan="2" align="right">Website</td>
      <td width="20%"><input type="text" name="website" value="#web_site#" size="20"></td>
    </tr>
    <tr>
      <td width="20%" align="right">Notes</td>
      <td width="100%" colspan="7"><input type="text" name="notes" value="#notes#" size="75"></td>
    </tr>
  </table>
	<INPUT TYPE="Hidden" NAME="contact_id" VALUE="#contact_id#">
	<input TYPE="SUBMIT" NAME="Update" VALUE="Update">
</CFOUTPUT>
</CFFORM>
</CFIF>



<CFQUERY DATASOURCE="#application.dbSrc#" NAME="contact">
select contact_id,firstname,lastname,category,state
from tbl_contacts
where contact_id = contact_id

<CFIF isdefined("search")>

<CFIF #firstname# is not "">
and firstname like '%#firstname#%'
</CFIF>
<CFIF #lastname# is not "">
and lastname like '%#lastname#%'
</CFIF>
<CFIF #state# is not "">
and state like '%#state#%'
</CFIF>
order by state, lastname

</CFIF>
</CFQUERY>

<FORM>
<table border="0" width="100%" BGCOLOR="SILVER">
<tr>
<td>Last Name</TD>
<td>First Name</TD>
<td>Category</TD>
<td>State</TD>
<td>&nbsp;</TD>
</TR>
<TR BGCOLOR="WHITE"><TD COLSPAN="5"><HR></TD></TR>
<CFOUTPUT query="contact">
<tr>
<td>#lastname#</TD>
<td>#firstname#</TD>
<td>#category#</TD>
<td>#state#</TD>
<td><a href="contact_srch2.cfm?contact_id=#contact_id#">SHOW</a></TD>
</TR>
</CFOUTPUT>
</table>
<CFIF "#session.user#" IS  "READUSER">
<H3> You are a Read Only User </H3>
</cfif> 
<CFIF contact.recordcount is 0>Sorry, no matches found.</CFIF>
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">