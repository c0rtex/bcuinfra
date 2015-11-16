<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Untitled</TITLE>
</HEAD>

<BODY>
<CFQUERY NAME="complete" DATASOURCE="ToCain">
Select user_name, first_name, password, email
From mailtest
</CFQUERY>

<!--- first we check mail to let the server know who we are --->
		<!---CFPOP ACTION="GETALL" NAME="test" MAXROWS="1" SERVER="mail.flashcom.net" USERNAME=rem PASSWORD="3825"--->
		<CFPOP ACTION="GETALL" NAME="test" MAXROWS="1" SERVER="mail164513.popserver.pop.net" USERNAME=mail164513 PASSWORD="vac">
<!--- next we send the mail --->
<CFMAIL
QUERY="complete"
FROM="Evaluation@ncoadc.com"
TO="#email#"
SUBJECT="Thank you for Evaluating our Software"
SERVER="mail164513.smtpserver.pop.net">
<CFMAILPARAM NAME="Reply-To" VALUE="mking@vitalaging.com">
Dear #first_name#:

Earlier this year you  helped evaluate a beta version of Your Public Program Counselor (YPPC).  As you may recall, YPPC is the first nationwide online screening tool for older adult benefit/entitlement programs.  Evaluators responded with valuable feedback, which helped to enhance the product significantly.  Now, we'd like to ask for your help again.  

We want to be sure that the changes we've implemented are the correct and appropriate ones.  Specifically, we want to know if you find the application easy to use and if it returns accurate results for your state.  Therefore, we'd like to ask you to review the application again. 

In previous testing, users found it most helpful to respond using three different scenarios, completing the application as if it were for 1) a parent or other loved one; 2) oneself; and 3) as a case worker within a community facility.  In each scenario it is helpful to try it twice; once entering information that should return benefits, to be sure that you are returned the appropriate benefits, and a second time trying to fool the system, entering information that is either too high or too low to get specific program results.

While you are reviewing the software, you should keep two things in mind:

PROGRAMS ARE AGE-BASED: We learned from the feedback to be more specific in describing YPPC.  It is a service addressing the needs of older adults (those 55 and over).  This version of the software does not address the needs of children, therefore it does not screen for such programs as WIC or TANF. 

PROGRAMS ARE FEDERAL & STATE ONLY:  It was also clear from your feedback that we needed to clarify that YPPC only screens Federal and State public programs.  Some state experts expected to find private and county-based programs, which are not currently included in YPPC.

Once again, there is a button to link to the evaluation form at the end of the results page. You can fill out a new evaluation each time you go through the software, or simply save up all of your comments until you have completed reviewing and submit a single form, whichever is most convenient for you.  Please make sure to click on the "done" button  on the evaluation form to submit your comments to us when you have completed it.  As before, your comments and critiques are greatly appreciated!   PLEASE EVALUATE BEFORE FRIDAY, MARCH 10th.

Here is your access information:
Username = #user_name#
Password =  #password#
Site Address = http://www.ncoadc.com/StateEval/

If you have any questions, don't hesitate to contact us via email at evaluation@ncoadc.com. MOST IMPORTANTLY, let us know if you will not be able to test the software, so that we can contact other experts in your state to take your place.   We will be following up with all of our state evaluators by phone within a week to ensure that you are able to successfully navigate the software.

Thanks again for sharing your expertise with us. We look forward to your feedback.  If you have any questions, you can reach us via email at support@ncoadc.com or 212.766.5220.
David Dring
NCOA Development Corporation

NCOA Development Corporation, a subsidiary of the National Council on Aging, is a business incubator creating new products and services in the field of aging.  For more information, please visit our web site at www.ncoadc.com.

</CFmail>





<CFOUTPUT QUERY="complete">
These were notified on 2/28
#first_name#, #user_name#, #password#,  #email#<BR></CFOUTPUT>
did it work?


</BODY>
</HTML>
