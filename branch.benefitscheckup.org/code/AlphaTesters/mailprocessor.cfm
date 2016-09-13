<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--- this file processes the email sent to the Alpha Testers of the CSO version of BenefitsCheckUp --->
<CFQUERY NAME="getall" DATASOURCE="alphatesters-test">
Select * From Test1</CFQUERY>

<CFQUERY NAME="ExtEvalMail1Batch1" DATASOURCE="2ndEvalMailing">

SELECT Usr_Fname, Usr_Lname, Usr_Email, Login_ID, Usr_Password, Usr_NCOA_ID
From Test1
</CFQUERY> 


<HTML>
<HEAD>
	<TITLE>First External</TITLE>
</HEAD
<BODY>
<CFOUTPUT QUERY="getall">
UserFirstName = #Usr_Fname# --
UserLastName = #Usr_Lname# --
Email = #Usr_Email# --
LoginID = #Login_ID# --
Password = #Usr_Password# --
NCOAID = #Usr_NCOA_ID#<BR>
</CFOUTPUT>


<!--- <!--- first we check mail to let the server know who we are --->
<CFPOP ACTION="GETALL" NAME="test" MAXROWS="1" SERVER="mail.flashcom.net" USERNAME=rem PASSWORD="3825">
<!--- next we send the mail --->
<CFMAIL
QUERY="ExtEvalMail1Batch1"
FROM="Evaluation@ncoadc.com"
TO="#email#"
SUBJECT="Thank you for Evaluating our Software"
SERVER="smtp.flashcom.net">
Dear #first_name#:

Happy New Year!  

Thank you for your time and effort in evaluating the application, Your Public Program Counselor. Your feedback was especially valuable. It's a pleasure to report that the majority of the evaluators rated the application favorably.  There were also many helpful comments. As the feedback is reviewed, it may be necessary to call you to clarify some of your comments.  This process should be completed by the end of January.

Because some of the evaluators received notification of the testing dates late, the evaluation period has been extended to Friday, January 7th, 2000.  If you have the opportunity, please go through the application again and provide any additional comments or suggestions. A lot of feedback helps to build a better, more useful application.

For your convenience, here is your login information:
Your user name is: #user_name#
Your password is: #password#

The Web Site Address: http://www.ncoadc.com/StateEval/

If you have any questions, please send us an email message to support@ncoadc.com

Once again, thank you for your generosity and kindness. 

All the very best for a marvelous millennium,
David Dring
NCOA Development Corporation
</CFmail>

<CFOUTPUT QUERY="ExtEvalMail1Batch1">#email#</CFOUTPUT> --->

It's done!
</BODY>
</HTML>
