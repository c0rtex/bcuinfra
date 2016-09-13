<cfparam name="src" default="">
<cfparam name="url.reportType" type="string" default="">
<cf_tagHeader guts="frmHowBCUWorks.cfm" popupwarning="1" >
<table width=100% border="0" align="center" cellpadding="12" cellspacing="2">
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area-->
<h2>How BenefitsCheckUp Works</h2>
	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
	<cfelseif src eq 'ec'>
		<cf_buttons goText="Back to Application Forms Center" goURL="javascript:history.go(-1)" printText="Print This Page Now For Your Records">
		<br>
	<cfelseif src eq 'turbo'>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&src=turbo">
	<cfelseif src neq 'frame'>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
	</cfif>
<br><br>
<h3>About BenefitsCheckUp</h3>
<p>BenefitsCheckUp is a service of the National Council on Aging (NCOA).  NCOA is a national charitable organization with a mission of improving the health, independence and continuing contributions of older people.  
 </p>
<p>The goal of BenefitsCheckUp is to help consumers make the best decisions about the public and private programs that are available to help them save money on prescription drugs and other health care costs.</p>
<h3>How the information in BenefitsCheckUp is kept current.</h3>
<p>NCOA has an experienced staff of experts who are constantly collecting and updating information about federal, state and private benefit programs and how they will relate to Medicare Prescription Drug Coverage. We research the eligibility rules for each program, descriptions of the benefits provided, and collect the most current application forms (when available). We are in regular contact with officials from each of these programs to make sure that we have the most current information. Updates are made to the computer system on a weekly basis.</p>
<h3><strong>Why BenefitsCheckUp asks the questions that it does?</strong></h3>
<p> BenefitsCheckUp does not ask every question that government agencies would use to determine eligibility for all of the benefits because this would be too time-consuming and difficult for people to answer. Instead, we collect the information about each individual user that we believe is most important to determine whether a person is likely to be eligible for each benefit and whether or not they should go ahead and apply for it. We are not making an official determination of eligibility (which only a government agency can do). Because we cannot be 100% certain whether a person will be found eligible for a particular benefit, we encourage people to apply for a benefit that we think they are likely to be eligible for, even if there is a chance they may not be. </p>

<h3>What you should do if you think the recommendations you received are incorrect</h3>
<p>Try using the service again and make sure that you answer every question.    This is the most common reason for receiving incorrect recommendations. If you still think the information you receive is incorrect, please send us an e-mail at support@benefitscheckup.org.</p>
<h3>What to do if you have questions or concerns or you know of information that you think should be updated</h3>
<p>Please send us an e-mail at support@benefitscheckup.org. Thank you for working together with us to help people get the benefits they need! 
</p>

	<cfif src eq 'eforms'>
		<cf_buttons goText="Back to Application Guide" goURL="frmAccess.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'elig'>
		<cf_buttons goText="Back to Results" goURL="frmeligibility.cfm?sr=#sr#&cfid=#session.cfid#&cftoken=#session.cftoken#">
	<cfelseif src eq 'ec'>
		<cf_buttons goText="Back to Application Forms Center" goURL="javascript:history.go(-1)">
		<br>
	<cfelseif src eq 'turbo'>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#&src=turbo">
	<cfelseif src neq 'frame'>
		<cf_buttons goText="Back to Recommendations" goURL="frmRecommend.cfm?cfid=#session.cfid#&cftoken=#session.cftoken#" printText="Print This Page Now For Your Records">
	</cfif>
</td></tr></Table>
</td></tr></Table>
<cf_tagfooter>