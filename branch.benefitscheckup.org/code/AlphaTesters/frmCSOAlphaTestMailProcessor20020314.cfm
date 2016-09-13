<cfset localSrc="BCU_NonApp">
<cfset mailTable="tbl_CSOAlphaTestersPhase2">
<!--- this file processes the email sent to the Alpha Testers of the CSO version of BenefitsCheckUp --->

<CFQUERY NAME="testers" DATASOURCE="#localSrc#">
	select Usr_Fname, Usr_Lname, Usr_Email, Login_ID, Usr_Password, Usr_NCOA_ID
	from #mailTable#
	where Usr_NCOA_ID=122
</CFQUERY>

<html>
<head>
	<title>Send E-Mail to Alpha Testers - 14 March 2002</TITLE>
</head>
<body>

<CFOUTPUT QUERY="testers">
UserFirstName = #Usr_Fname# --
UserLastName = #Usr_Lname# --
Email = #Usr_Email# --
LoginID = #Login_ID# --
Password = #Usr_Password# --
NCOAID = #Usr_NCOA_ID#<BR>
</CFOUTPUT>
<br>

<!--- Loop through query results, sending email to each tester --->
<cfmail query="testers" to="#Usr_Email#" from="cso@benefitscheckup.org" subject="Testing period extended for the CSO version of BenefitsCheckUp" server="smtp.vitalaging.com">Hello, #Usr_Fname#--

I hope that you're well.   The alpha-testing of the organizational version of BenefitsCheckUp is almost complete.  However, in order to capture any last-minute comments, we've extended the testing period until Wednesday, March 20, 2002.  We would really like to hear your feedback on the service.  I hope this extension will enable you to go through the application.  Your access information is below for quick reference.

Web Site Address:  http://csotest.benefitscheckup.org
User Id: #Login_Id#
Password: #Usr_Password#

We're very excited about the possibilities of the organizational version of BenefitsCheckUp.  Your input will help us make our dreams a reality.  Thanks so much for your assistance in improving older adults' access to public benefits.

David Dring
National Technical Director of BenefitsCheckUp

p.s. We've also extended the raffle drawing of four $50 gift certificates until 3/20.</cfmail>

<CFOUTPUT QUERY="testers">#Usr_Email#<br></CFOUTPUT>
<br>

It's done!
</body>
</html>
