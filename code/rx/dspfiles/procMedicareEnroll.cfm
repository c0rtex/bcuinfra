
<!--- SourceID Assigned by CMS/TogetherRx --->
<cfset SourceID = form.SourceID >
<!--- ReturnURL --->
<cfset ReturnURL = "session.servername/frmRecommend.cfm?cfid=#cfide#&cftoken=#cftoken#" >
<!--- SponsorID --->
<cfset SponsorID = form.SponsorID >
<!--- TALevel --->
<cfset TALevel = form.TALevel >
<!--- MaritalStatus --->
<cfset MaritalStatus = form.MaritalStatus >
<!--- Zip --->
<cfset Zip = form.Zip >
<!--- Recently --->
<cfset Recently = form.Recently>
<!--- StatePay --->
<cfset StatePay = form.StatePay >
<!--- Referring ID --->
<cfset ReferringID = session.partner_id >
<!--- Trans ID --->
<cfset TransID = session.clientnum >
<cfoutput>
<cflocation addtoken="no" url="http://qa.benefitscheckup.org?SourceID=#SourceID#&ReturnURL=#ReturnURL#&SponsorID=#SponsorID#&TALevel=#TALevel#&MaritalStatus=#MaritalStatus#&Zip=#Zip#"&Recently=#Recently#&StatePay=#StatePay#&ReferringID=#ReferringID#&TransID=#TransID#
</cfoutput>