<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--- this file processes the email sent to the Alpha Testers of the CSO version of BenefitsCheckUp --->

<CFQUERY NAME="ExtEvalMailBatch1" DATASOURCE="#session.datasrc#">
SELECT Usr_Fname, Usr_Lname, Usr_Email, Login_ID, Usr_Password, Usr_NCOA_ID
From tbl_CSOAlphaTestersPhase3
</CFQUERY> 


<HTML>
<HEAD>
	<TITLE>First External</TITLE>
</HEAD
<BODY>

<CFOUTPUT QUERY="ExtEvalMailBatch1">
UserFirstName = #USR_FNAME# --
UserLastName = #Usr_Lname# --
Email = #Usr_Email# --
LoginID = #Login_ID# --
Password = #Usr_Password# --
NCOAID = #Usr_NCOA_ID#<BR>
</CFOUTPUT>

<!--- autorespond to the user who sent mail --->
<cfmail query="ExtEvalMailBatch1" to="#Usr_Email#" from="cso@benefitscheckup.org" subject="Your Help is Needed in Testing the CSO version of BenefitsCheckUp" server="smtp.vitalaging.com">

Dear #Usr_Fname#:

Jeff Rubin, State Project Director for BenefitsCheckUp, suggested that I contact you. As you may know, he's working with The National Council on the Aging to develop an organizational version of the BenefitsCheckUp technology.  This version provides additional features and functionality to organizations that serve older adults and their families.  We are conducting "Alpha Tests" of this new version, which we call the Community Service Organization version (CSO).

We need your help to test it out.  To evaluate it.  To poke it and prod it before we release to organizations across the country.  Can you help us by going through the application and completing an evaluation survey?

We'd like you to go through it as if you were setting up the service for your organization, inputting your organization's co-branding and local program information, going through the CSO version of BenefitsCheckUp screening service, and reviewing statistical output options.

We hope that you (and/or let me know of others within your organization and/or community that might be interested in evaluating) can help us today and in exchange we promise a discount to this service when it's made available later this year.  In addition, you can continue to use the service after the testing period is over.  Please note: that the system may be down periodically as we make modifications based upon your (and other evaluators') recommendations.

So join us in an historic event in social services...the creation of the nation's first single entry point for organizations into federal and state-wide benefit programs for older adults...and be forever known as a "Alpha Tester" of the CSO version.  

As a way of saying thanks, we will hold a raffle at the conclusion of this testing period of all those that completed and submitted the evaluator's survey before midnight on March 15, 2002.  We will award four fifty dollar ($50) gift certificates from American Express to be used personally or given to your favorite charity.

Thank you and if you have any questions, please don't hesitate to send us an email (cso@benefitscheckup.org) or give me a call 877.766.5220 (toll free).

These are exciting times and we sincerely appreciate your assistance in enabling NCOA to realize our dream of increasing older adults' access to public benefits! 

Access the site today with the information below and  be apart of the revolution in aging services.

Web site: http://csotest.benefitscheckup.org/
Your Login information is as follows:
User Id: #Login_ID#
Password: #Usr_Password#

Thanks so much!
The CSO Development Team</cfmail>

<CFOUTPUT QUERY="ExtEvalMailBatch1">#Usr_Email#</CFOUTPUT>

It's done!
</BODY>
</HTML>
