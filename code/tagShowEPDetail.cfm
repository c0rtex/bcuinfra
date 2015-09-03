<cfprocessingdirective suppresswhitespace="Yes">
<cfoutput>
<BR>
#org_name#<BR>
<CFIF trim(org_name2) IS NOT "">#trim(org_name2)#<BR></CFIF>
<CFIF trim(address) IS NOT "">#trim(address)#<BR></CFIF>
<CFIF trim(address1) IS NOT "">#trim(address1)#<BR></CFIF>
<CFIF trim(address2) IS NOT "">#trim(address2)#<BR></CFIF>
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
   #trim(city)#, #trim(st)# #trim(strZip)#<BR>
</CFIF>
<CFIF trim(phone_no) IS NOT "">Phone: #trim(phone_no)# &nbsp;
   <CFIF trim(fax) IS NOT "">Fax: #trim(fax)#</CFIF><BR>
   <!--- if no address is showing --->
   <CFIF trim(address) IS "" and trim(address1) IS "" and trim(address2) IS "">
      The office that administers this program does not provide address information. 
      Please call the phone number(s) listed above.<BR>
   </CFIF>
</CFIF>
<CFIF trim(email) IS NOT "">Email: <cfif caller.boolReport>#trim(email)#<cfelse><A HREF="mailto:#trim(email)#">#trim(email)#</A></cfif><BR></CFIF>
<CFIF trim(web_site) IS NOT "">Web address: <cfif caller.boolReport>#trim(web_site)#<cfelse><A HREF="http://#trim(web_site)#" target="_blank">#trim(web_site)#</A></cfif><BR></CFIF>
<CFIF trim(hours) IS NOT "">Hours: #trim(hours)#<BR></CFIF>
<CFIF trim(contact_title) IS NOT "">Contact: #trim(contact_title)#<BR></CFIF>
</cfoutput>
</cfprocessingdirective>
