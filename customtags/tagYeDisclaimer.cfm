<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.ltcc" type="boolean" default="true">
<cfset outstr = ''>
<cfif session.subset_id neq 22 
	and session.subset_id neq 35 
	and session.subset_id neq 40 
	and session.subset_id neq 49 
	and session.subset_id neq 49 
	and session.subset_id neq 56
	and session.subset_id neq 63
	and session.subset_id neq 67 and session.subset_id neq 76 and session.subset_id neq 77 >
	
	<cfset outstr = outstr & "">
	
	<cfif Not IsDefined('session.citizen') Or session.citizen neq 'Citizen'>
			<cf_tagNonCitizen var="noncitstr">
			<cfset outstr = outstr & "<span class='strong'>FOR THOSE WHO ARE NOT US CITIZENS:</span>
		#noncitstr#">
	</cfif>
	
	<cfif (Not IsDefined('session.partner_id') 
		Or (session.partner_id neq 5 
		AND session.partner_id neq 17) ) 
		And attributes.ltcc 
		and session.subset_id neq 3 
		and session.subset_id neq 19 
		and session.subset_id neq 27
		and session.subset_id neq 39 
		and session.subset_id neq 57 
		and session.subset_id neq 59 
		and session.subset_id neq 64
		and session.subset_id neq 68
		and session.subset_id neq 70 
		and session.subset_id neq 76 
		and session.subset_id neq 77 
		and session.subset_id neq 78
		and session.partner_id neq 77>
		
		<cfset outstr = outstr & "<hr><p><span class='strong'>FOR THOSE NEEDING LONG-TERM CARE:</span><br>
	If you need financial assistance to pay for long-term care, either at home, in a residential care/assisted living setting or in a nursing home, several options may be available in addition to those identified in this screening program.  You might be eligible for an income supplement through your state social services or human services agency.  Or you might be eligible for Medicaid to pay for nursing home care.  Although the program you have just used screens you for eligibility for Medicaid long-term care coverage, your state's rules may be more generous than those of this screen.  Go to <a href=""http://www.nasmd.org/links/state_medicaid_links.asp"">http://www.nasmd.org/links/state_medicaid_links.asp</a> for information on how to contact your state Medicaid agency.  Also, if you have given away any assets, including cash, for less than fair value, in the past three years, you should seek legal assistance before applying for long-term care benefits.  Contact your local bar association and ask for an attorney who specializes in Medicaid or medical assistance.</p>">
		
		
	</cfif>

</cfif>

<cfif attributes.var eq "">
	<cfoutput>#outstr#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outstr>
</cfif>