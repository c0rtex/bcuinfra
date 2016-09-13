<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Alpha Tester Survey</title>
</head>

<body>
<cfform action="ProcessCSOAlphaTestAnswers.cfm" method="GET" name="AlphaFeedback">
<b>Alpha Tester Survey</b><br>

Thanks for taking the time to go through and evaluate the “alpha version” of The National Council on the Aging’s Community Service Organization (CSO) Version of BenefitsCheckUp.  These are exciting times and we appreciate your assistance in helping us make this service more usable and productive for community-based organizations across the country. Please complete the survey, as many times as you’d like, and provide as many details as possible to clearly describe your experiences and any suggestions.  As always, we can be reached for comment/help via email at: <a href="mailto:cso@benefitscheckup.org">cso@benefitscheckup.org</a>

<table><!--- I am the outer table --->
<tr><td>
<table><!--- I am the second table, dammit --->
<tr><td><br>
	<table border="1"><!--- I am the first of many tables, inside the second table, that contain individual questions / user answer fields --->
		<tr>
			<td>Name (Required):</td>
			<td><cfinput type="text" name="username" maxlength="50" size="20" required="Yes" message="Your name is required."> </td>
			<td>&nbsp;&nbsp;&nbsp;Email (Required):</td>
			<td><cfinput type="text" name="useremail" maxlength="50" size="20" required="Yes" message="Your email is required."> </td>
		</tr>
	</table><br>
	<table><!--- Section ONE --->		
		<tr bgcolor="#f0f0f0"><td><B>General Overall Reactions; please rate the following:</B></td></tr>
		<tr><td>&nbsp;</td></tr><!--- filler row --->
		<tr><td>
			<table border="1"><!--- we'll put the questions into own table, who know what future formatting will be required --->
				<tr>
					<td>&nbsp;</td>
					<td colspan="5">Completely Satisfied (1) --- Very Dis-satisfied (5)</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">1</td><td align="center">2</td><td align="center">3</td><td align="center">4</td><td align="center">5</td>
				</tr>
				<tr>
					<td>The "Look & Feel"</td>
					<td align="center"><input type="radio" name="lookfeel" value=1></td>
					<td align="center"><input type="radio" name="lookfeel" value=2></td>
					<td align="center"><input type="radio" name="lookfeel" value=3></td>
					<td align="center"><input type="radio" name="lookfeel" value=4></td>
					<td align="center"><input type="radio" name="lookfeel" value=5></td>
				</tr>
				<tr>
					<td>Ease of Use</td>
					<td align="center"><input type="radio" name="easeofuse" value=1></td>
					<td align="center"><input type="radio" name="easeofuse" value=2></td>
					<td align="center"><input type="radio" name="easeofuse" value=3></td>
					<td align="center"><input type="radio" name="easeofuse" value=4></td>
					<td align="center"><input type="radio" name="easeofuse" value=5></td>
				</tr>
				<tr>
					<td>Navigation: Flow between pages</td>
					<td align="center"><input type="radio" name="navigationflow" value=1></td>
					<td align="center"><input type="radio" name="navigationflow" value=2></td>
					<td align="center"><input type="radio" name="navigationflow" value=3></td>
					<td align="center"><input type="radio" name="navigationflow" value=4></td>
					<td align="center"><input type="radio" name="navigationflow" value=5></td>
				</tr>
				<tr>
					<td>Online Assistance</td>
					<td align="center"><input type="radio" name="OnlineAssistance" value=1></td>
					<td align="center"><input type="radio" name="OnlineAssistance" value=2></td>
					<td align="center"><input type="radio" name="OnlineAssistance" value=3></td>
					<td align="center"><input type="radio" name="OnlineAssistance" value=4></td>
					<td align="center"><input type="radio" name="OnlineAssistance" value=5></td>
				</tr>
				<tr>
					<td>Login Process</td>
					<td align="center"><input type="radio" name="LoginProcess" value=1></td>
					<td align="center"><input type="radio" name="LoginProcess" value=2></td>
					<td align="center"><input type="radio" name="LoginProcess" value=3></td>
					<td align="center"><input type="radio" name="LoginProcess" value=4></td>
					<td align="center"><input type="radio" name="LoginProcess" value=5></td>
				</tr>
				<tr>
					<td>Creating an Organizational Profile</td>
					<td align="center"><input type="radio" name="OrgProfile" value=1></td>
					<td align="center"><input type="radio" name="OrgProfile" value=2></td>
					<td align="center"><input type="radio" name="OrgProfile" value=3></td>
					<td align="center"><input type="radio" name="OrgProfile" value=4></td>
					<td align="center"><input type="radio" name="OrgProfile" value=5></td>
				</tr>
				<tr>
					<td>Establishing Users</td>
					<td align="center"><input type="radio" name="EstablishingUsers" value=1></td>
					<td align="center"><input type="radio" name="EstablishingUsers" value=2></td>
					<td align="center"><input type="radio" name="EstablishingUsers" value=3></td>
					<td align="center"><input type="radio" name="EstablishingUsers" value=4></td>
					<td align="center"><input type="radio" name="EstablishingUsers" value=5></td>
				</tr>
				<tr>
					<td>Adding Local Benefit Information</td>
					<td align="center"><input type="radio" name="AddingLocal" value=1></td>
					<td align="center"><input type="radio" name="AddingLocal" value=2></td>
					<td align="center"><input type="radio" name="AddingLocal" value=3></td>
					<td align="center"><input type="radio" name="AddingLocal" value=4></td>
					<td align="center"><input type="radio" name="AddingLocal" value=5></td>
				</tr>
				<tr>
					<td>Accessing Statistical Information</td>
					<td align="center"><input type="radio" name="AccessingStats" value=1></td>
					<td align="center"><input type="radio" name="AccessingStats" value=2></td>
					<td align="center"><input type="radio" name="AccessingStats" value=3></td>
					<td align="center"><input type="radio" name="AccessingStats" value=4></td>
					<td align="center"><input type="radio" name="AccessingStats" value=5></td>
				</tr>
				<tr>
					<td>Viewing the Printable Questionnaire</td>
					<td align="center"><input type="radio" name="ViewingPrintable" value=1></td>
					<td align="center"><input type="radio" name="ViewingPrintable" value=2></td>
					<td align="center"><input type="radio" name="ViewingPrintable" value=3></td>
					<td align="center"><input type="radio" name="ViewingPrintable" value=4></td>
					<td align="center"><input type="radio" name="ViewingPrintable" value=5></td>
				</tr>
			</table><!--- we'll put the questions into own table, who know what future formatting will be required --->
		</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>Please provide any general comments and/or suggestions about your above reactions:</td></tr>
		<tr><td><textarea cols="40" rows="3" name="generalreactions" id="generalreactions"></textarea></td></tr>
		
	</table><!--- Section ONE --->	<br>
	<table><!--- Section TWO --->		
		<tr bgcolor="#f0f0f0"><td colspan="2"><B>Integrating the CSO Version Into Your Organization:</b></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">Does the CSO version have the functionality needed to be a beneficial and valuable tool in your organization?</td></tr>
		<tr>
			<td align="right"><input type="radio" name="neededfunctionality" value="1"></td>
			<td>Yes, we need this right-a-way</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="neededfunctionality" value="2"></td>
			<td>Yes, this is something we could use </td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="neededfunctionality" value="3"></td>
			<td>Maybe</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="neededfunctionality" value="4"></td>
			<td>Need more information before we could make this determination</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="neededfunctionality" value="5"></td>
			<td>No, we already have a tool like this</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td colspan="2">Please comment, in general, about functionality/features/services that are important to you and your organization in a benefit screening service.</td></tr>
		<tr><td colspan="2"><textarea cols="40" rows="3" name="functionalityservices"></textarea></td></tr>
</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td colspan="2">What, if any, supplementary information (such as brochures, training packets, workshops, user groups, etc.) would be needed to successfully integrate the CSO version into your organization?</td></tr>
		<tr><td colspan="2"><textarea cols="40" rows="3" name="supplementinfo"></textarea></td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td colspan="2">How many people per month would you expect to screen for public benefits using BenefitsCheckUp?</td></tr>
		<tr><td><cfinput type="Text" name="numberscreened" message="Number of people you would expect to screen should be entered as a number." validate="integer" size="5" maxlength="6"></td></tr>
	</table><!--- Section TWO --->	<br>
	<table><!--- Section THREE --->		
		<tr bgcolor="#f0f0f0"><td colspan="2"><B>Understanding the Value of the CSO Version</b></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">Please indicate which of the items belows are most likely to sway key decision makers in subscribing to the CSO version of BenefitsCheckUp.  To do so, identify your top five items and rank them from 1 (most important) to 5. Note that you can add an item (see other box below), if we missed one, to include among your top five.</td></tr>
		<tr>
			<td align="right"><cfinput type="Text" name="comppublic" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>Comprehensive set of public benefits (Federal and State-wide benefits only)</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="compdata" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>Data set must include local public benefits to be valuable</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="fastdata" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>A fast screening procedure</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="detailedonline" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>Detailed online assistance (FAQs, Tips on Use, and clear instructions)</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="readilyavailable" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>Readily available technical support (during business hours) </td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="availableprintable" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>The availability of a printable questionnaire</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="accessstats" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>Access to statistical reports</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="abilitytoshare" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>The ability to “share” your organization's data and access other organizations’ data</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="abilitytocobrand" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>The ability to co-brand the service with your organization's information</td>
		</tr>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="availableresults" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>Availability of a printable report of the user’s results</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="manageaccess" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>The ability to manage your staff’s access to different areas of the service</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="managenews" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>The ability to manage and distribute news and other information to staff</td>
		</tr>
		<tr>
			<td align="right"><cfinput type="Text" name="rankofother" message="Please enter an integer for the rankings." validate="integer" required="no" size="2" maxlength="2"></td>
			<td>Other: <input type="text" name="otherRanked" size="70" maxlength="250"></td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">What is the biggest benefit to you (or your organization) in using this Community Service Organization version of BenefitsCheckUp?</td></tr>
		<tr><td colspan="2"><textarea cols="40" rows="3" name="biggestbenefit"></textarea></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">What would make the CSO version even more helpful to you?</td></tr>
		<tr><td colspan="2"><textarea cols="40" rows="3" name="morehelpful"></textarea></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">Would you recommend that your organization subscribe to the CSO version?</td></tr>
		<tr>
			<td align="right"><input type="radio" name="recommendorg" value="1"></td>
			<td>yes, for the entire organization</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="recommendorg" value="2"></td>
			<td>yes, but specifically for case managers/social workers within the organization</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="recommendorg" value="3"></td>
			<td>yes, but I would be the only user</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="recommendorg" value="4"></td>
			<td>not sure</td>
		</tr>
		<tr>
			<td align="right"><input type="radio" name="recommendorg" value="5"></td>
			<td>would not recommend the service</td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">On a yearly basis, what price for BenefitsCheckUp would be so inexpensive you would doubt its quality? &nbsp;&nbsp;&nbsp;&nbsp; $<cfinput type="Text" name="soinexpensive" message="Please enter money amounts in whole dollars, no cents. " validate="integer" required="No" size="5" maxlength="6"> </td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">On a yearly basis, what price for BenefitsCheckUp would be just about right for this service? &nbsp;&nbsp;&nbsp;&nbsp;  $ <cfinput type="Text" name="aboutrightprice" message="Please enter a whole number of dollars, no cents. " validate="integer" required="No" size="5" maxlength="6"> </td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">On a yearly basis, what price for BenefitsCheckUp would be just becoming so expensive that you might not think it was worth it? &nbsp;&nbsp;&nbsp;&nbsp; $<cfinput type="Text" name="tooexpensive" message="Please enter a whole number of dollars, no cents. " validate="integer" required="No" size="5" maxlength="6"> </td></tr>
	</table><!--- Section THREE ---><br>
	<table><!--- Section FOUR --->		
		<tr bgcolor="#f0f0f0"><td colspan="2"><B>Promoting and Communicating about the CSO Version</b></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">What are the three top message/communication points about the CSO version that would most likely convince your colleagues that they should use the service?</td></tr>
		<tr><td align="center">Most Compelling Point</td>
			<td><input type="text" name="compelling1" size="70" maxlength="255"> </td>
		</tr>
		<tr><td align="center">2nd Compelling Point</td>
			<td><input type="text" name="compelling2" size="70" maxlength="255"> </td>
		</tr>
		<tr><td align="center">3rd Compelling Point</td>
			<td><input type="text" name="compelling3" size="70" maxlength="255"> </td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">Which of the following channels would you use to effectively communicate the availability of the CSO version to organizations in your community?  (check all that apply)</td></tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveMouth" value="yes"></td>
			<td align="">Word of mouth</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectivePoster" value="yes"></td>
			<td align="">Poster or flyer</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveNewsArticle" value="yes"></td>
			<td align="">Newspaper/magazine/newsletter article</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveNewsAd" value="yes"></td>
			<td align="">Newspaper/magazine/newsletter advertisement</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveRadioShow" value="yes"></td>
			<td align="">Radio show (talk/news)</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveRadioAd" value="yes"></td>
			<td align="">Radio show (talk/news) advertisement</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveProfRef" value="yes"></td>
			<td align="">Professional referral</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectivePresentationCommunity" value="yes"></td>
			<td align="">Presentations at Community Meetings</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveSeminarCommunity" value="yes"></td>
			<td align="">Presentations/Seminars at Community Events</td>
		</tr>
		<tr><td align="right"><input type="checkbox" name="EffectiveOther" value="yes"></td>
			<td align="">Other: <input type="text" size="50" maxlength="255" name="OtherEffectiveChannel" </td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">Would you help NCOA inform members of your community about the CSO version?  That is, distribute flyers, hang posters, present the CSO version at meetings, appear on local radio and/or TV stations and otherwise serve as a central information distribution vehicle for the CSO version for your community?</td></tr>
		<tr><td colspan="2">
			Yes &nbsp;<input type="radio" name="willingtohelp" value="1"> &nbsp;&nbsp;&nbsp;&nbsp;
			No &nbsp;<input type="radio" name="willingtohelp" value="0"> &nbsp;&nbsp;&nbsp;&nbsp;
		</td>		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">Any additional comments and/or suggestions?</td></tr>
		<tr><td colspan="2"><textarea cols="40" rows="3" name="AnyAdditional"></textarea></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2"><b>Your efforts are appreciated!</b>  As a small way of saying thanks for taking the time to complete this survey, you will be entered into a drawing for one of five $50 American Express Gift Certificates.  Your completed survey must be received into our database by midnight on February 28, 2002 to be included in this drawing.</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2" align="center">
        <font face=arial size=3><b>
        <input type="submit" name="submitAlpha" value="Submit">
        </b></font></td></tr>
	</table><!--- Section FOUR --->		
</table><!--- I am the second table, dammit --->

</td></tr>
</table><!--- I am the outer table --->
</cfform>

</body>
</html>
