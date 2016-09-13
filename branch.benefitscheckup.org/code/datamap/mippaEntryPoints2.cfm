<cfsetting showdebugoutput="no" enablecfoutputonly="yes">
<cfparam name="program_id" default="0">
<cfparam name="suppressOfficesLink" default="true">
<cfparam name="zipcode" default="">
<cfparam name="mode" default="screen">
<cfparam name="source" default="">
<cfparam name="city_id" default="">
<cfparam name="county" default="">
<cfparam name="state" default="">
<cfparam name="outStr" default="">
<cfparam name="proximityOverride" default="">
<cfparam name="radius" default="100">
<cfparam name="limit" default="3">
<cfparam name="append" default="false">
<cfparam name="suppressText" default="false">
<cfparam name="google" default="false">
<cfparam name="wrapUrl" default="true">
<cfif session.mZip NEQ "">
	<cfset zipcode = session.mZip>
</cfif>
<cfif session.mState NEQ "">
	<cfset state = session.mState>
</cfif>
<cfif session.mCounty NEQ "">
	<cfset county_id = session.mCounty>
</cfif>

<cfquery name="epgroup" datasource="#application.dbSrc#">
	select pe.entrypointgroup_id, g.name, pe.sort, count(eg.entrypoint_id) c, max(eg.entrypoint_id) id
	from program_entrypointgroup pe, entrypointgroup g, entrypoint_entrypointgroup eg, entrypoint e
	where pe.program_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#program_id#" maxlength="64">
		and pe.entrypointgroup_id=g.entrypointgroup_id
		and g.active_flag=1
		and g.entrypointgroup_id=eg.entrypointgroup_id
		and eg.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
	group by pe.entrypointgroup_id, g.name, pe.sort
	order by pe.sort
</cfquery>
<cfquery name="prgprox" datasource="#application.dbSrc#">
	select x.code
	from program_proximity px, proximity x
	where px.program_id=#program_id#
		and px.proximity_id=x.proximity_id
	order by px.sort
</cfquery>

<cfset methodSuccess = false>
<cfif session.mZip is "" and program_id is 1933>
	<cfset outStr = "To find your local Medicaid and State Health Insurance Program offices, please enter a zip below.">
<cfelse>
    <cfloop query="epgroup">
        <cfset egid = entrypointgroup_id>
        <cfif NOT methodSuccess>
        <!--- IF there's only one entrypoint in group, display that one --->
            <cfif c eq 1>
                <cfset methodSucceeded = true>
                <cf_displayEntrypoint entrypoint_id="#id#" mode="#mode#" var="outstr" append="true" wwrapurl="true">
            <cfelse>
                <cfif proximityOverride is "county">
                    <cf_proximityCountyOverride entrypointgroup_id="#egid#" program_id="#program_id#" county_id="#county_id#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSuccess" suppressOfficesLink="#suppressOfficesLink#" google="#google#" wrapUrl="true">
                <cfelse>
                    <!--- LOOP through program's proximity methods in sort order --->
                    <cfloop query="prgprox">
                        <cfif NOT methodSuccess>
                            <cfswitch expression="#code#">
                                <cfcase value="local">
                                    <cf_proximityLocal entrypointgroup_id="#egid#" program_id="#program_id#" zipcode="#zipcode#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSuccess" suppressOfficesLink="#suppressOfficesLink#">
                                </cfcase>
                                <cfcase value="county">
                                    <cf_proximityCounty entrypointgroup_id="#egid#" program_id="#program_id#" zipcode="#zipcode#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSuccess" suppressOfficesLink="#suppressOfficesLink#" google="#google#">
                                </cfcase>
                                <cfcase value="city">
                                    <cf_proximityCity entrypointgroup_id="#egid#" program_id="#program_id#" city_id="#city_id#" zipcode="#zipcode#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSuccess" suppressOfficesLink="#suppressOfficesLink#">
                                </cfcase>
                                <cfcase value="zip">
                                    <cf_proximityZip entrypointgroup_id="#egid#" program_id="#program_id#" zipcode="#zipcode#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSuccess" suppressOfficesLink="#suppressOfficesLink#" google="#google#">
                                </cfcase>
                                <cfcase value="radius">
                                    <cf_proximityRadius entrypointgroup_id="#egid#" program_id="#program_id#" zipcode="#zipcode#" radius="#radius#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSuccess" suppressOfficesLink="#suppressOfficesLink#">
                                </cfcase>
                            </cfswitch>
                        </cfif>
                    </cfloop>
                </cfif>
                <!--- IF no method has succeeded --->
                <cfif not methodSuccess>
                    <cf_proximityRadius entrypointgroup_id="#egid#" program_id="#program_id#" zipcode="#zipcode#" radius="#radius#" mode="#mode#" limit="#limit#" var="outstr" append="true" successvar="methodSuccess">
                </cfif>
            </cfif>
        </cfif>
    </cfloop>
</cfif>
<cfoutput>
#outStr#
</cfoutput>