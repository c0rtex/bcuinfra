<cfparam name="error1" default="">
<cfparam name="error2" default="">
<cfparam name="errors" default="">


<cfif trim(email) IS '' OR find('@',  email) IS 0 OR find('.',  email) IS 0>
	<cfset error1 = 1>
	<cfset errors = 1>
<cfelse>
</cfif>

<cfif trim(name) IS ''>
	<cfset error2 = 1>
	<cfset errors = 1>
<cfelse>
</cfif>


<cfif errors IS 1>
	<cflocation url="refer.cfm?error1=#error1#&error2=#error2#&name=#urlencodedformat(name)#&email=#urlencodedformat(email)#">
<cfelse>
	<cfmail from="webmaster@benefitscheckup.org" 
	subject="A friend has invited you to visit Benefitscheckup.org" 
	replyto="webmaster@benefitscheckup.org">
#name# has invited you to visit http://www.benefitscheckup.org
	</cfmail>
	
		<cflocation url="refer_thanks.cfm?name=#urlencodedformat(name)#&email=#urlencodedformat(email)#">
	
</cfif>

