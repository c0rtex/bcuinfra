<cfparam name="error1" default="">
<cfparam name="error2" default="">
<cfparam name="error3" default="">
<cfparam name="errors" default="">


<cfif trim(email1) IS '' OR find('@',  email1) IS 0 OR find('.',  email1) IS 0>
	<cfset error1 = 1>
	<cfset errors = 1>
<cfelse>
</cfif>

<cfif trim(your_name) IS ''>
	<cfset error2 = 1>
	<cfset errors = 1>
<cfelse>
</cfif>

<cfif trim(your_email) IS '' OR find('@',  your_email) IS 0 OR find('.',  your_email) IS 0>
	<cfset error3 = 1>
	<cfset errors = 1>
<cfelse>
</cfif>





<cfif errors IS 1>

	<cflocation url="refer.cfm?error1=#error1#&error2=#error2#&error3=#error3#&your_name=#urlencodedformat(your_name)#&email1=#urlencodedformat(email1)#&your_email=#urlencodedformat(your_email)#&friends_name=#urlencodedformat(friends_name)#&message=#urlencodedformat(message)#">
	
<cfelse>

<cfmail 
	to="#email1#" 
	from="#your_email#" 
	replyto="#your_email#"
	subject="I've found a helpful site!" 
	type="html"
><html><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
<strong><strong>#message#</strong></strong>
</p>
<p>I think you'll find the BenefitsCheckUp website very helpful.</p>
<p>
Just go to <a href="http://www.BenefitsCheckUp.org "><strong>http://www.BenefitsCheckUp.org</strong></a> to learn about benefit programs you may be eligible for.  You could receive help paying for prescription drugs, energy bills, property taxes, and more.  If you are eligible for Medicare and have limited income and resources, you can also apply online for Extra Help available through Medicare's Prescription Drug Coverage.  It's simple, it's fast, and it's free!
</p>
<p>
This email was sent to you by #your_name#. BenefitsCheckUp respects your privacy and will not contact you. 
</p>
</font>
</html>
	</cfmail>
	
		<cflocation url="refer.cfm?your_name=#urlencodedformat(your_name)#&your_email=#urlencodedformat(your_email)#&thanks=y&email2=#urlencodedformat(email1)#">
 </cfif>