<!--- 2/10/00 REM Added the params to keep the page from crashing if the form fields are submitted blank. --->
<CFPARAM NAME="sm" DEFAULT="">
<CFPARAM NAME="other" DEFAULT="">
<CFPARAM NAME="name" DEFAULT="">
<CFPARAM NAME="email" DEFAULT="">
<CFPARAM NAME="comments" DEFAULT="">
<head><title>FEEDBACK</title></head>
<CFINSERT DATASOURCE = "#application.dbSrc#" TABLENAME="tblUserFeedback">



<!--- next we send the mail --->
<CFMAIL bcc="office@BenefitsCheckUp.org" TO="Dave@BenefitsCheckUp.org" FROM="Feedback@BenefitsCheckUp.org" SUBJECT="Feedback submitted from BenefitsCheckUp Demo"  SERVER="smtp.benefitscheckup.com">
Someone submitted a feedback form that said:
Subject Matter: #sm#
(if other): #other#
User's Name: #name#
Email Address: #email#
Comments: #comments#
</CFMAIL>
<!--- autorespond to the user who sent mail --->
<CFMAIL TO="#email#" FROM="Feedback@BenefitsCheckUp.org" SUBJECT="In Response to Your Message to BenefitsCheckUp"  SERVER="smtp.benefitscheckup.com">
 Thank you for your interest in <cf_tagBCU>.  We hope you were able to
 learn about benefits that may help improve your quality of life.   If you
 are a return visitor, we hope that you continue to find our service
 helpful.
 
 We are delighted to report that we have added additional equipment to help
 with the amazing amount of people who choose to use <cf_tagBCU>.  If
 you encountered system delays or application errors in the past, we want
 to apologize again and let you know that we have successfully debugged
 most of the problems.  If you are still encountering any problems, please
 let us know by sending us an email to feedback@benefitscheckup.org, or
 using the "Feedback" link at the bottom of each page.   Kindly include the
  following information: 
  1. Date of problem
  2. State and zip code selected
  3. Where in the application you encountered the problem
  4. Description of problem
  5. If error message was present, please copy and paste it and include
     it in the email to us.

  If you use WebTV to access the Internet, please note that we are having
  some difficulty with that browser.  We are working to resolve these
  issues.  In the meantime, if you would like to send us your email address
  so that we can inform you when <cf_tagBCU> is working within the WebTV
  browser, please send an email to feedback@benefitscheckup.org.
  
  We are working continuously to ensure that the site is easy to use,
  accurate and up-to-date.  Every month we upload new and/or updated
  information and programming improvements to the site.   Additionally,
  please feel free to send us updates on any benefit programs or local
  contacts you feel we should add or modify via the
  feedback@benefitscheckup.org email address. Your help is greatly
  appreciated!
 
  Please keep in mind that <cf_tagBCU> currently screens for public
  benefits for all 50 US States and the District of Columbia.  It does not
  screen for benefits in US territories, such as Puerto Rico, US Virgin
  Islands, Guam, Northern Marina Islands, Republic of Palau, and American
  Samoa as of yet.  Accordingly, it does not screen for benefits in Canada,
  Mexico, or any other foreign countries.  
 
  Should you require additional help locating local resources or have
  specific benefit questions, we recommend you go to the online local
  resources link available by clicking on The National Council on the
  Aging's visitor's center at http://www.ncoa.org/visitor/index.html
  However, if you are looking for something specific or detailed information
  on such programs as home-based services, housing facilities, and/or
  nursing homes, we suggest that you contact the Eldercare Locator at
  1-800-677-1116 or your local area agency on aging for that kind of
  assistance.
  
  Unfortunately, we are not equipped to respond to all inquiries from users
  at this time.  We will try our best to respond to as many users as
  reasonably possible.  
  
  Thank you again for using <cf_tagBCU>.  We value your support.
 
  The <cf_tagBCU> Team
  www.BenefitsCheckUp.org
  Email address: feedback@benefitscheckup.org


</CFMAIL>


<p align="center"><font size="6"><b>Feedback Submitted</b></font></p>
<P><font face="arial" size="3"><b>Thank you for your input.  We are delighted that you and thousands of other users have commented on the site.  Regrettably, we cannot respond to everyone at this time.  We will try our best to respond to as many users as reasonably possible. </P>
</b>
</font>
<cf_tagClose>

