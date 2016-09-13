<cfsetting showdebugoutput="no" enablecfoutputonly="yes">
<cfparam name="program_id" type="numeric" default="0">
<cfparam name="suppressOfficesLink" default="false" type="boolean">
<cfparam name="eplimit" default="3" type="numeric">
<cfparam name="zip" default="" type="any">
<cfparam name="mode" default="screen" type="string">
<cfparam name="source" default="" type="string">
<cfparam name="city_id" default="">
<cfparam name="county" default="">
<cfparam name="state" default="">



<cfset rtn = "">
<cfset outstr = "">
<cfquery name="eps" datasource="#application.dbSrc#">
	SELECT entrypoint.*
	FROM entrypoint 
    	INNER JOIN
        	entrypoint_entrypointgroup ON entrypoint.entrypoint_id = entrypoint_entrypointgroup.entrypoint_id 
        INNER JOIN
        	program_entrypointgroup ON entrypoint_entrypointgroup.entrypointgroup_id = program_entrypointgroup.entrypointgroup_id
    WHERE  program_entrypointgroup.program_id = #program_id#
</cfquery>
<cfif eps.recordcount is 0>
<cfoutput>
	NO RECORDS..
</cfoutput>
<cfelseif program_id is 1933>
	<cfif session.mZip NEQ "">
        <cf_proximityZip entrypointgroup_id="83" program_id="#attributes.program_id#" zipcode="#attributes.zipcode#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#attributes.suppressOfficesLink#" google="#attributes.google#">
    <cfelse>
        <cfset outStr = "To find your local Medicaid office, please enter a zip below.">
    </cfif>
    <cfoutput>
		#outStr#
	</cfoutput>
<cfelse>
	<cfoutput query="eps">
        <cf_displayEntrypoint entrypoint_id="#eps.entrypoint_id#" mode="screen" var="outstr" append="false">
        #outStr#
    </cfoutput>
</cfif>
<!---
Medicare Part D (program name changed from initial bug entries)
id=1931, code=rxgov_fd_partd_mapping_short
id=1934, code=rxgov_fd_partd_mapping_long
- Changed entry point association to only have 1 entry point group associated
(entrypointgroup_id=986). This entry point is not driven by zip or state, so it
should show up automatically when the program is selected.  Set proximity
method to "local."

Part D Low-Income Subsidy (program name changed from initial bug entries)
id=1932, code=rxgov_fd_lis_mapping_short   
id=1935, code=rxgov_fd_lis_mapping_long
- Changed entry point association to only have 1 entry point group associated
(entrypointgroup_id=1047). This entry point is not driven by zip or state, so
it should show up automatically when the program is selected.  Set proximity
method to "local."

Medicare Savings Programs
id=1933, code=health_fd_msp_mapping_short
id=1936, code=health_fd_msp_mapping_long
- Changed entry point association to only have 1 entry point group associated
(entrypointgroup_id=17). This entry point IS dependent on zip to be entered to
display an entry point. Set proximity method to "zip" then "county."
 More info below on what to do for this.

As mentioned in original bug comment and comment #1, I orginally associated 2
entry point groups to the program but wasn't sure if this would work as it
doesn't in regular BCU.  As such, the second entry point group that needs to be
display is:

entrypointgroup_id=83, State Health Insurance Program (SHIP) - MIPPA Offices
* This entry point group depends on a state/zip selection to be able to
determine the office.  There is at least one entry point per state.  

SO...ALL programs should ultimately display two entrypoints based upon the
program selected:
FIRST the entry points within the entry point group associated to the program
SECOND the State Health Insurance Program (SHIP - MIPPA Offices) entry points

Now on to how this should work based on the Mapping tool:

- Once a program is selected, remove this language:
"This section provides the location and contact information for an agency that
can provide more information about the benefit that you have chosen. In
addition, you can search for other organizations near you by using the Zip Code
search box."

- If either the "Part D" or "Part D Low-Income Subsidy" is selected from the
drop down and no other action item is taken in the mapping tool, the single
entry points show up, which is good.  However, in this case, we need the SHIP
entry point to show up as well which will be driven based upon the zip/state
entered.  Please include this language if no SHIP is shown as no state/zip is
selected yet:

To find your State Health Insurance Program and contact information, please
select your state on the map or enter a zip below.

Once a state/zip is selected, show the SHIP for that given state.

- Now onto the more complicated one..."Medicare Savings Programs".  As noted
above, the entry point group associated with this program requires a user to
input a zip to determine an office.  Thus, if this program is selected, but no
zip is entered, please display this text:

To find your local Medicaid office, please enter a zip below.

Once a zip is selected, display the first entry point returned.

Similar to "Part D" and "Part D Low-Income Subsidy", show this language for
SHIP if no state/zip is selected:

To find your State Health Insurance Program and contact information, please
select your state on the map or enter a zip below.

PLEASE let me know if you have any questions on this!  I think I got it all in
but I am more than happy to answer questions to provide clarity.

Lastly, Marlene, Wynn and I are going to have a call shortly regarding
navigating back and forth in the tool and what should happen with the state/zip
information once it's been entered.
--->