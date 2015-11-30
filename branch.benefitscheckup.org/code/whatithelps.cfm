<cfparam name="id" type="numeric" default="0">
<cfparam name="partner_id" type="numeric" default="0">

<cfif Not IsDefined('session.subset_id') OR isnumeric(id)>
	<cfset session.subset_id = id>
</cfif>

<cfif Not IsDefined('session.subset_id') OR partner_id GT 0>
	<cfset session.partner_id = partner_id>
</cfif>


<html>
<head>

<cfif session.subset_id eq 49 OR session.subset_id eq 59>
	<title>What Public Benefits Are Included?</title>
<cfelse>
	<title>What This Service Can Help With</title>
</cfif>



<script language="JavaScript">
<!--
function closeThisWindow() {
	if (!opener.closed)
		opener.focus();
	else
		window.open("index.cfm");
	self.close();
}
// -->
</script>

</head>

<body bgcolor="#FFFFFF" link="#00594B" alink="#00594B" vlink="purple" onLoad="window.focus();">

<font face="arial" size="3">

<cfif session.subset_id eq 49 OR session.subset_id eq 59 OR session.subset_id eq 70>
	<h3>What Public Benefits Are Included?</h3>
<cfelseif session.subset_id eq 68>
	<h3>Information You'll Need </h3>
<cfelse>
	<h3>What This Service Can Help With</h3>
</cfif>

<cfif session.subset_id EQ 19 AND  session.partner_id IS 22>
<cfelse>
<form>
<table cellpadding="0" cellspacing="0" width="100%">
<td align="left"><input type="button" value="Close" onClick="javascript:self.close();"></td>
<td align="right"><input type="button" value="Print this Page" onClick="javascript:print()"></td>
</table>
</form>
</cfif>

<p>

<strong>

<cfif session.subset_id eq 38>
	BenefitsCheckUp's Disaster Recovery service currently helps people to enroll in the following benefits:
<cfelseif session.subset_id eq 35>
	This screening helps people find out if they may be eligible and should apply for following types of programs:
<cfelseif session.subset_id eq 49>
	<cfif session.partner_id IS 22>
		Public Benefits for Older Americans and Their Families provides information on how to find and apply for these programs:
	<cfelse>
		Benefits QuickLINK provides information on how to find and apply for these programs:	
	</cfif>
<cfelseif session.subset_id EQ 68>
	<p>We've found that having the necessary information at your fingertips makes completing the questions easier.</p>
	<p>You'll need the following information about yourself or about the person you are helping and for any children living in the household:</p>
<cfelseif id EQ 57>
	Key Public Benefits helps people find and enroll in the following benefits:

<cfelseif id EQ 59>
Benefits QuickLINK for the U.S. Virgin Islands provides information on how to find and apply for these programs: 
<cfelseif id EQ 0 AND (session.partner_id EQ 58 
OR session.partner_id EQ 59 
OR session.partner_id EQ 60 
OR session.partner_id EQ 61 
OR session.partner_id EQ 62 
OR session.partner_id EQ 63
OR session.partner_id EQ 64 
OR session.partner_id EQ 65 
OR session.partner_id EQ 66 
OR session.partner_id EQ 67 
OR session.partner_id EQ 68
)>	
BenefitsCheckUp helps people find and enroll in the following benefit	
<cfelseif session.subset_id EQ 19 AND  session.partner_id IS 22>
	Private Prescription Drug Programs Offered by Pharmaceutical Companies provides information on how to find and apply for these programs:
<cfelseif session.subset_id EQ 70>
Get information on how to find and apply for these programs:<BR>
<ul>
	<li>Supplemental Nutrition Assistance Program (SNAP)</li>
    <li>Senior Community Service Employment Program (SCSEP)</li>
</ul>
<cfelseif session.subset_id eq 78>
Help for Those Who Have Served helps people find and enroll in the following benefits: 
<cfelse>
<cfif id NEQ 76>
	BenefitsCheckUp <cfif session.subset_id eq 14 or session.subset_id eq 34>for People <cfif session.subset_id eq 34>W<cfelse>w</cfif>ith<cfif session.subset_id eq 34>out</cfif> Medicare </cfif>currently helps people to enroll in the following benefits:
</cfif>

</cfif>

	<ul>
<cfif session.subset_id eq 49>
	</ul>
	
	<p>
		<span style="border-bottom:solid 1px ##000;">
			State and Federal Public Benefits for Older Americans
		</span>
	</p>

	<ul>
    	<li>Medicare Savings Programs</li>
        <li>Medicare Prescription Drug Coverage</li>
        <li>Medicare Rx Extra Help</li>
        <li>State Pharmaceutical Assistance Programs (SPAP)</li>
        <li>Medicaid for Aged, Blind, and Disabled</li>
        <li>Supplemental Nutrition Assistance Program (SNAP)</li>
        <li>Earned Income Tax Credit (EITC)</li>
        <li>Low Income Home Energy Assistance (LIHEAP)</li>
        <li>State Property Tax Relief/Rebates</li>
        <li>Supplemental Security Income (SSI)</li>
        <li>Employment Programs</li>
        <li>Telephone and Cellphone Assistance</li>
        <li>Transportation Assistance</li>
		<li>Veterans Programs</li>
	</ul>
	
	<p>
		<span style="border-bottom:solid 1px ##000;">
			Public Benefits for Families Raising Children
		</span>
	</p>

	<ul>
    	<li>Medicaid for Children</li>
        <li>State Children's Health Insurance Program (SCHIP)</li>
        <li>TANF-Child Only Grants</li>
        <li>Supplemental Security Income for Children</li>
        <li>Child Care Assistance</li>
	</ul>
    
<cfelseif session.subset_id EQ 68>
	<p>
		<span style="border-bottom:solid 1px ##000;">
			State and Federal Public Benefits
		</span>
	</p>
    <ul>
        <li>Medicare Savings Programs</li>
        <li>Medicare Prescription Drug Coverage</li>
        <li>Medicare Rx Extra Help</li>
        <li>State Pharmaceutical Assistance Programs (SPAP)</li>
        <li>Patient Assistance Programs (PAP)</li>
        <li>Medicaid for Aged, Blind, and Disabled</li>
        <li>Supplemental Nutrition Assistance Program (SNAP)</li>
        <li>Earned Income Tax Credit (EITC)</li>
        <li>Low Income Home Energy Assistance (LIHEAP)</li>
        <li>State Property Tax Relief/Rebates</li>
        <li>Supplemental Security Income (SSI)</li>
        <li>Employment Programs</li>
        <li>Telephone and Cellphone Assistance</li>
        <li>Transportation Assistance</li>
	</ul>
	<p>
		<span style="border-bottom:solid 1px ##000;">
			Public Benefits for Families Raising Children
		</span>
	</p>
    <ul>
        <li>Medicaid for Children</li>
        <li>State Children's Health Insurance Program (SCHIP)</li>
        <li>TANF-Child Only Grants</li>
        <li>Supplemental Security Income for Children</li>
        <li>Child Care Assistance</li>
	</ul>
<cfelseif session.subset_id eq 76>
<p>Help with Your Home helps people find and enroll in the following benefits: </p>
<ul>
<li>Housing</li>
<li>Property Tax Relief/Exemptions</li>
<li>	Home Repair</li>
<li>	Utilities Payment Assistance</li>
<li>	Veterans Housing Benefits</li>
</ul>


<cfelseif session.subset_id eq 78>

    	<li>Medicare Prescription Drug Coverage for People with Limited Incomes and Resources (Extra Help)</li>
        <li>Medicare Savings Programs (QMB, SLMB, and QI-1)</li>
        <li>State Pharmacy Assistance Programs (SPAP)</li>
        <li>Patient Assistance Programs</li>
        <li>Drug Discount Cards</li>
	<li>Medicaid</li>
        <li>Supplemental Security Income (SSI), including state supplements</li>
	<li>Supplemental Nutrition Assistance Program (SNAP)</li>
	<li>Low Income Home Energy Assistance Program (LIHEAP)</li>
	<li>State Property Tax Relief/Rebates</li>
	<li>Veterans Benefits</li>
<cfelseif session.subset_id eq 39>
	<li>Medicare Prescription Drug Coverage
	<li>Medicare Prescription Drug Coverage for People with Limited Incomes and Resources (Extra Help)
	<li>Medicare Savings Programs (QMB, SLMB and QI-1)
	<li>Medicaid
	<li>Supplemental Security Income (SSI)
	<li>State Pharmacy Assistance Programs
	<li>Company Patient Assistance Programs
	<li>TRICARE
	<li>VA's Health Care System
<cfelseif session.subset_id IS 51>
	<li>Medicare Prescription Drug Coverage 
	<li>Medicare Prescription Drug Coverage for People with Limited Incomes and Resources (Extra Help) 
	<li>Medicaid 
	<li>Medicare Savings Programs (QMB, SLMB & QI-1) 
	<li>State Pharmacy Assistance Programs 
	<li>Supplemental Security Income (SSI) 
	<li>Energy Assistance 
	<li>Food Stamp Program 
	<li>Housing Assistance 
	<li>Federal Tax Relief Programs 
	<li>VA's Health Care System
<cfelseif session.subset_id eq 38>
	<li>Medicare Prescription Drug Coverage 
	<li>Medicare Prescription Drug Coverage for People with Limited Incomes and Resources (Extra Help)
	<li>Medicaid 
	<li>Medicare Savings Programs (QMB, SLMB & QI-1)
	<li>State Pharmacy Assistance Programs 
	<li>Supplemental Security Income (SSI) 
	<li>Energy Assistance
	<li>Food Stamp Program
	<li>Housing Assistance	
	<li>Company Patient Assistance Programs and Discount Cards
	<li>Federal Tax Relief Programs
	<li>VA's Health Care System 
<cfelseif session.subset_id eq 35>
	<li>Food Stamps
	<li>Housing Programs
	<li>Energy Assistance Programs
<cfelseif session.subset_id eq 27>
	<li>Medicare Prescription Drug Coverage 
	<li>Medicare Prescription Drug Coverage for People with Limited Incomes and Resources (Extra Help) 
	<li>Medicare Savings Programs (QMB, SLMB and QI-1) 
	<li>State Pharmacy Assistance Programs 
<cfelseif session.subset_id eq 19 AND session.partner_id IS 22>
	<li>Over 120 patient assistance programs and discount card programs provided by	private pharmaceutical companies</li>
<cfelseif id eq 57>	
<li>Medicare Prescription Drug Coverage for People with Limited Incomes and Resources (Extra Help)</li>
<li>Medicare Savings Programs (QMB, SLMB, and QI-1)</li>
<li>State Pharmacy Assistance Programs</li>
<li>Medicaid</li>
<li>Supplemental Security Income (SSI), including state supplements</li>
<li>Supplemental Nutrition Assistance Program (SNAP)</li>
<li>Low Income Home Energy Assistance Program (LIHEAP)</li>
<li>State Property Tax Relief/Rebates</li>

<cfelseif id eq 59>	
<li>Aid to the Old Aged, Blind and Disabled</li>
<li>Temporary Assistance for Needy Families (TANF)</li>
<li>Pharmaceutical Assistance to the Aged Program</li>
<li>Homes for the Aged</li>
<li>Supplemental Nutrition Assistance Program (SNAP)</li>
<li>Nutrition Program for the Elderly</li>
<li>Energy Crisis Assistance Program (ECAP)</li>
<li>Telephone Assistance (Link-Up and Lifeline)</li>
<li>Family Caregiver Support Program</li>
<li>Foster Grandparents Program</li>
<cfelseif id EQ 0 AND 
(session.partner_id EQ 58 
OR session.partner_id EQ 59 
OR session.partner_id EQ 60 
OR session.partner_id EQ 61 
OR session.partner_id EQ 62 
OR session.partner_id EQ 63
OR session.partner_id EQ 64 
OR session.partner_id EQ 65 
OR session.partner_id EQ 66 
OR session.partner_id EQ 67 
OR session.partner_id EQ 68
OR session.partner_id EQ 101 OR session.partner_id EQ 105)>   
<li>Medicare Savings Programs</li>
<li>Medicare Prescription Drug Coverage</li>
<li>Medicare Rx Extra Help</li>
<li>State Pharmaceutical Assistance Programs (SPAP)</li>
<li>Patient Assistance Programs</li>
<li>Drug Discount Cards</li>
<li>Medicaid (including: Aged, Blind, and Disabled; Spend-down; Home and Community-Based Waivers; and Nursing Home Medicaid)</li>
<li>Supplemental Nutrition Assistance Program (SNAP) and other Food Supplement Programs</li>
<li>Earned Income Tax Credit (EITC)</li>
<li>Low Income Home Energy Assistance (LIHEAP)</li>
<li>HUD and Section 8</li>
<li>State Property Tax Relief/Rebates</li>
<li>Supplemental Security Income (SSI), including state supplements</li>
<li>General and Cash Assistance</li>
<li>Telephone Assistance (Link-Up and Lifeline)</li>
<li>Long-Term Care Ombudsman</li>
<li>Caregiver Support and Homecare Programs</li>
<li>Health Insurance Information and Counseling (SHIP)</li>
<li>Adult Protective Services</li>
<li>Discount Programs (including recreational, transportation, and utilities)</li>
<li>Education and Information Programs</li>
<li>Vocational Rehabilitation Services</li>
<li>Veterans Benefits</li>
<li>Volunteer Services</li>
<cfelse>
	<cfif session.subset_id neq 70>
	<cfif session.subset_id neq 34>
		<li>Medicare Prescription Drug Coverage</li>
		<li>Medicare Prescription Drug Coverage for People with Limited Incomes and Resources (Extra Help)</li>
		<li>Medicare Savings Programs (QMB, SLMB and QI-1)</li>
	</cfif>
	<li>State Pharmacy Assistance Programs</li>
	<li>Medicaid</li>
	<cfif session.subset_id eq 14 or session.subset_id eq 34>
		<li>Supplemental Security Income (SSI)</li>
		<cfif session.subset_id eq 34>
			<li>Company Patient Assistance Programs</li>
			<li>VA's Health Care System </li>
		</cfif>
	<cfelse>
		<li>Supplemental Security Income (SSI), including state supplements</li>
		<li>Veterans Health Care Benefits</li>
		<li>TriCare</li>
		<li>Medicare-Approved Drug Discount Card with Additional Assistance</li>
		<li>Over <cf_countProgramsRounded subset="pap"> patient assistance programs provided by private pharmaceutical companies</li>
	</cfif>
    </cfif>
</cfif>
</ul>

</strong>

<cfif (session.subset_id EQ 19 OR session.subset_id EQ 49) AND session.partner_id IS 22>
	<cf_tagClose style="table">
<cfelse>
	<cf_tagClose>
</cfif>
</font>
</body>
</html>
