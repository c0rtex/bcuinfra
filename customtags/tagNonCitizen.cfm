<cfparam name="attributes.var" type="string" default="">
<cfset outstr="<b>Please note:</b>  You indicated that you are not a U.S. citizen. As long as you currently have Medicare or are eligible for Medicare, you will also be eligible for Medicare's new prescription drug benefits.  However, the rules about whether non-citizens are eligible for certain state programs (such as Medicaid and Medicare Savings Programs) vary widely from state to state.  This report may include information about certain state benefits programs because you may be eligible for them.  However, you should check with the state office listed on the fact sheets to determine if a person of your immigration status is, in fact, eligible for these programs.  <b>If you believe you received this message in error, please make sure you properly answered the question regarding U.S. citizenship/immigration status.</b>">
<cfif attributes.var eq "">
	<cfoutput>#outstr#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outstr>
</cfif>