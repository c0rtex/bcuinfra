<cfset rdOut = rdOut & "#org_name#<BR>">
<CFIF trim(org_name2) IS NOT "">
	<cfset rdOut = rdOut & "#trim(org_name2)#<BR>">
</CFIF>
<CFIF trim(address) IS NOT "">
	<cfset rdOut = rdOut & "#trim(address)#<BR>">
</CFIF>
<CFIF trim(address1) IS NOT "">
	<cfset rdOut = rdOut & "#trim(address1)#<BR>">
</CFIF>
<CFIF trim(address2) IS NOT "">
	<cfset rdOut = rdOut & "#trim(address2)#<BR>">
</CFIF>
<CFIF trim(city) IS NOT "">
   <cfif trim(zip) IS NOT "">
      <CFSET strZip = zip>
      <cfset CharDot = FindNoCase(".",strzip,1)>
      <CFIF CharDot NEQ 0><CFSET strzip = LEFT(strzip, CharDot-1)></cfif>
      <CFSET strZip = "000#StrZip#">
      <CFSET strZip = right(strZip, 5)>
   <cfelse>
      <cfset strZip = "">
   </cfif>
   <cfset rdOut = rdOut & "#trim(city)#, #trim(st)# #trim(strZip)#<BR>">
</CFIF>
<CFIF trim(phone_no) IS NOT ""><cfset rdOut = rdOut & "Phone: #trim(phone_no)# &nbsp;">
   <CFIF trim(fax) IS NOT ""><cfset rdOut = rdOut & "Fax: #trim(fax)#"></CFIF>
   <cfset rdOut = rdOut & "<BR>">
   <!--- if no address is showing --->
   <CFIF trim(address) IS "" and trim(address1) IS "" and trim(address2) IS "">
      <cfset rdOut = rdOut & "The office that administers this program does not provide address information. Please call the phone number(s) listed above.<BR>">
   </CFIF>
</CFIF>
<CFIF trim(email) IS NOT "">
	<cfset rdOut = rdOut & "Email: #trim(email)#<BR>">
</CFIF>
<CFIF trim(web_site) IS NOT "">
	<cfset rdOut = rdOut & "Web Site: #trim(web_site)#<BR>">
</CFIF>
<CFIF trim(hours) IS NOT "">
	<cfset rdOut = rdOut & "Hours: #trim(hours)#<BR>">
</CFIF>
<CFIF trim(contact_title) IS NOT "">
	<cfset rdOut = rdOut & "Contact: #trim(contact_title)#<BR>">
</CFIF>
<cfset rdOut = rdOut & "<BR>">
