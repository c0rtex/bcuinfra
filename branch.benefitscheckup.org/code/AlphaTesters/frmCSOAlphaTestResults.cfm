<cfquery name="GetRecs" datasource="#session.datasrc#">
SELECT *
FROM tbl_CSOAlphaTestFeedback
</cfquery>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
   <title>CSO Alpha Tester Survey Results</title>
</head>

<body>
<h2>CSO Alpha Tester Survey Results</h2>
<p>Number of Surveys: <cfoutput><b>#GetRecs.RecordCount#</b></cfoutput></p>
<hr width="100%" size="3" color="##ff0000" noshade>      
<cfoutput query="GetRecs">
<table>
   <tr>
      <td><b>#CurrentRow#.</b></td>
      <td>Name:</td>
      <td><b>#username#</b></td>
      <td>Email:</td>
      <td><b>#useremail#</b></td>
   </tr>
</table><br>
   
<table><!--- Section ONE --->      
   <tr bgcolor="##f0f0f0"><td colspan="2"><B>General Overall Reactions; please rate the following:</B></td></tr>
   <tr>
      <td colspan="2">Completely Satisfied (1) --- Very Dis-satisfied (5)</td>
   </tr>
   <tr>
      <td>The "Look & Feel"</td>
      <td align="center"><b>#lookfeel#</b></td>
   </tr>
   <tr>
      <td>Ease of Use</td>
      <td align="center"><b>#easeofuse#</b></td>
   </tr>
   <tr>
      <td>Navigation: Flow between pages</td>
      <td align="center"><b>#navigationflow#</b></td>
   </tr>
   <tr>
      <td>Online Assistance</td>
      <td align="center"><b>#OnlineAssistance#</b></td>
   </tr>
   <tr>
      <td>Login Process</td>
      <td align="center"><b>#LoginProcess#</b></td>
   </tr>
   <tr>
      <td>Creating an Organizational Profile</td>
      <td align="center"><b>#OrgProfile#</b></td>
   </tr>
   <tr>
      <td>Establishing Users</td>
      <td align="center"><b>#EstablishingUsers#</b></td>
   </tr>
   <tr>
      <td>Adding Local Benefit Information</td>
      <td align="center"><b>#AddingLocal#</b></td>
   </tr>
   <tr>
      <td>Accessing Statistical Information</td>
      <td align="center"><b>#AccessingStats#</b></td>
   </tr>
   <tr>
      <td>Viewing the Printable Questionnaire</td>
      <td align="center"><b>#ViewingPrintable#</b></td>
   </tr>
   <tr><td colspan="2">Please provide any general comments and/or suggestions about your above reactions:</td></tr>
   <tr><td colspan="2"><b>#generalreactions#</b></td></tr>
</table><!--- Section ONE --->   <br>

<table><!--- Section TWO --->      
   <tr bgcolor="##f0f0f0"><td colspan="2"><b>Integrating the CSO Version Into Your Organization:</b></td></tr>
   <tr>
      <td colspan="2">Does the CSO version have the functionality needed to be a beneficial and valuable tool in your organization? <b>#neededfunctionality#</b></td>
   </tr>

<!--- <tr>
      <td>Yes, we need this right-a-way</td>
   </tr>
 --->
 <!--- <tr>
         <td align="right"><b>#neededfunctionality" value="2"></td>
         <td>Yes, this is something we could use </td>
      </tr>
      <tr>
         <td align="right"><b>#neededfunctionality" value="3"></td>
         <td>Maybe</td>
      </tr>
      <tr>
         <td align="right"><b>#neededfunctionality" value="4"></td>
         <td>Need more information before we could make this determination</td>
      </tr>
      <tr>
         <td align="right"><b>#neededfunctionality" value="5"></td>
         <td>No, we already have a tool like this</td>
      </tr>
 --->   
   <tr>
      <td colspan="2">Please comment, in general, about functionality/features/services that are important to you and your organization in a benefit screening service.</td>
   </tr>
   <tr>
      <td colspan="2"><b>#functionalityservices#</b></td>
   </tr>
   <tr>
      <td colspan="2">What, if any, supplementary information (such as brochures, training packets, workshops, user groups, etc.) would be needed to successfully integrate the CSO version into your organization?</td>
   </tr>
   <tr>
      <td colspan="2"><b>#supplementinfo#</b></td>
   </tr>
   <tr>
      <td colspan="2">How many people per month would you expect to screen for public benefits using BenefitsCheckUp? <b>#numberscreened#</b></td>
   </tr>
</table><!--- Section TWO --->   <br>
<table><!--- Section THREE --->      
   <tr bgcolor="##f0f0f0"><td colspan="2"><b>Understanding the Value of the CSO Version</b></td></tr>
   <tr><td colspan="2">Please rank the following features and functionality as what is most important (mark 1 as the most important; 13 least) to you and your organization.</td></tr>
   <tr>
      <td align="right"><b>#comppublic#</b></td>
      <td>Comprehensive set of public benefits (Federal and State-wide benefits only)</td>
   </tr>
   <tr>
      <td align="right"><b>#compdata#</b></td>
      <td>Data set must include local public benefits to be valuable</td>
   </tr>
   <tr>
      <td align="right"><b>#fastdata#</b></td>
      <td>A fast screening procedure</td>
   </tr>
   <tr>
      <td align="right"><b>#detailedonline#</b></td>
      <td>Detailed online assistance (FAQs, Tips on Use, and clear instructions)</td>
   </tr>
   <tr>
      <td align="right"><b>#readilyavailable#</b></td>
      <td>Readily available technical support (during business hours) </td>
   </tr>
   <tr>
      <td align="right"><b>#availableprintable#</b></td>
      <td>The availability of a printable questionnaire</td>
   </tr>
   <tr>
      <td align="right"><b>#accessstats#</b></td>
      <td>Access to statistical reports</td>
   </tr>
   <tr>
      <td align="right"><b>#abilitytoshare#</b></td>
      <td>The ability to “share” your organization's data and access other organizations’ data</td>
   </tr>
   <tr>
      <td align="right"><b>#abilitytocobrand#</b></td>
      <td>The ability to co-brand the service with your organization's information</td>
   </tr>
   <tr>
      <td align="right"><b>#availableresults#</b></td>
      <td>Availability of a printable report of the user’s results</td>
   </tr>
   <tr>
      <td align="right"><b>#manageaccess#</b></td>
      <td>The ability to manage your staff’s access to different areas of the service</td>
   </tr>
   <tr>
      <td align="right"><b>#managenews#</b></td>
      <td>The ability to manage and distribute news and other information to staff</td>
   </tr>
   <tr>
      <td align="right"><b>#rankofother#</b></td>
      <td>Other: #otherRanked#</b></td>
   </tr>
   <tr><td colspan="2">What is the biggest benefit to you (or your organization) in using this Community Service Organization version of BenefitsCheckUp?</td></tr>
   <tr><td colspan="2"><b>#biggestbenefit#</b></td></tr>
   <tr><td colspan="2">What would make the CSO version even more helpful to you?</td></tr>
   <tr><td colspan="2"><b>#morehelpful#</b></td></tr>
   <tr>
      <td colspan="2">Would you recommend that your organization subscribe to the CSO version? <b><b>#recommendorg#</b></b></td>
   </tr>
      <!--- <td>yes, for the entire organization</td> --->
   <!--- <tr>
      <td align="right"><b>#recommendorg#</b></td>
      <td>yes, but specifically for case managers/social workers within the organization</td>
   </tr>
   <tr>
      <td align="right"><b>#recommendorg#</b></td>
      <td>yes, but I would be the only user</td>
   </tr>
   <tr>
      <td align="right"><b>#recommendorg#</b></td>
      <td>not sure</td>
   </tr> 
   <tr>
      <td align="right"><b>#recommendorg#</b></td>
      <td>would not recommend the service</td>
   </tr>--->
   <tr><td colspan="2">On a yearly basis, what price for BenefitsCheckUp would be so inexpensive you would doubt its quality? &nbsp;&nbsp;&nbsp;&nbsp; <b>$#soinexpensive#</b></td></tr>
   <tr><td colspan="2">On a yearly basis, what price for BenefitsCheckUp would be just about right for this service? &nbsp;&nbsp;&nbsp;&nbsp;  <b>$#aboutrightprice#</b></td></tr>
   <tr><td colspan="2">On a yearly basis, what price for BenefitsCheckUp would be just becoming so expensive that you might not think it was worth it? &nbsp;&nbsp;&nbsp;&nbsp; <b>$#tooexpensive#</b></td></tr>
</table><!--- Section THREE ---><br>
<table><!--- Section FOUR --->      
   <tr bgcolor="##f0f0f0"><td colspan="2"><B>Promoting and Communicating about the CSO Version</b></td></tr>
   <tr><td colspan="2">What are the three top message/communication points about the CSO version that would mostly likely convince your colleagues that they should use the service?</td></tr>
   <tr><td align="center">Most Compelling Point</td>
      <td><b>#compelling1#</b></td>
   </tr>
   <tr><td align="center">2nd Compelling Point</td>
      <td><b>#compelling2#</b></td>
   </tr>
   <tr><td align="center">3rd Compelling Point</td>
      <td><b>#compelling3#</b></td>
   </tr>
   <tr><td colspan="2">What are the most effective channels to effectively communicate the availability of the CSO version to organizations in your community?  (check all that apply)</td></tr>
   <tr><td colspan="2"><b>#Replace(Effective,",",", ","all")#</b></td>
   </tr>
<!---       <tr><td align="right"><b>#EffectiveMouth#</b></td>
      <td align="">Word of mouth</td>
   </tr>
   <tr><td align="right"><b>#EffectivePoster#</b></td>
      <td align="">Poster or flyer</td>
   </tr>
   <tr><td align="right"><b>#EffectiveNewsArticle#</b></td>
      <td align="">Newspaper/magazine/newsletter article</td>
   </tr>
   <tr><td align="right"><b>#EffectiveNewsAd#</b></td>
      <td align="">Newspaper/magazine/newsletter advertisement</td>
   </tr>
   <tr><td align="right"><b>#EffectiveRadioShow#</b></td>
      <td align="">Radio show (talk/news)</td>
   </tr>
   <tr><td align="right"><b>#EffectiveRadioAd#</b></td>
      <td align="">Radio show (talk/news) advertisement</td>
   </tr>
   <tr><td align="right"><b>#EffectiveProfRef#</b></td>
      <td align="">Professional referral</td>
   </tr>
   <tr><td align="right"><b>#EffectivePresentationCommunity#</b></td>
      <td align="">Presentations at Community Meetings</td>
   </tr>
   <tr><td align="right"><b>#EffectiveSeminarCommunity#</td>
      <td align="">Presentations/Seminars at Community Events</td>
   </tr>
   <tr><td align="right"><b>#EffectiveOther#</b></td>
      <td align="">Other: #OtherEffectiveChannel#</b></td>
   </tr>
--->   
   <tr><td colspan="2">Would you be willing to help NCOA inform members of your community about the CSO Version?  That is, distribute flyers, hang posters, present the CSO Version at meetings, appear on local radio and/or TV stations and otherwise serve as a central information distribution vehicle for the CSO version for your community? <b>#IIF(willingtohelp EQ 0,DE("NO"),DE("YES"))#</b></td></tr>
   <tr><td colspan="2">Any additional comments and/or suggestions?</td></tr>
   <tr><td colspan="2"><b>#AnyAdditional#</b></td></tr>
</table><!--- Section FOUR --->   
<hr width="100%" size="3" color="##ff0000" noshade> 
</cfoutput>
</body>
</html>
