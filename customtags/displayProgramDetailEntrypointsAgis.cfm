
<cfparam name="attributes.program_id" type="numeric" default="0">
<cfparam name="attributes.mode" type="string" default="screen">
<cfparam name="attributes.source" type="string" default="">
<cfparam name="attributes.city_id" type="string" default="">
<cfparam name="attributes.zipcode" type="string" default="">
<cfparam name="attributes.radius" type="numeric" default="100">
<cfparam name="attributes.limit" type="numeric" default="3">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.append" type="boolean" default="false">
<cfparam name="attributes.debugvar" type="string" default="">
<cfparam name="attributes.suppressText" type="string" default="false">
<cfparam name="attributes.suppressOfficesLink" default="false">
<cfparam name="attributes.proximityOverride" type="string" default="">
<cfparam name="attributes.county_id" type="numeric" default="0">
<cfparam name="attributes.google" type="boolean" default="false">
<cfparam name="attributes.wrapUrl" type="boolean" default="false">

<cf_cacheProgramPool action="get" id="#attributes.program_id#" var="pobj">
<cfset prg_id = pobj.legacy>
<cfset printMode = Evaluate("attributes.mode eq 'print'")>
<cfset outstr = "">
<!-- Only insert entry point heading if ep info available - first store as substring and insert into output if ep success -->
	<cfsavecontent variable="strSubHeading">
    <div style="clear:left;">
	<table cellpadding="0" cellspacing="0" border="0" <cfif CGI.SCRIPT_NAME CONTAINS "frmdetails"><cfelse>width="100%"</cfif>>
		<cfif attributes.suppressText IS false>
			<tr>
				<td colspan="2" class="text1" style="height: 30px;">
					<strong class="factSheetH2" style="margin:auto;">For further information about this program:</strong>
				</td>
			</tr>
		</cfif>
		<tr>
		<td colspan="2"> 
	</cfsavecontent>

<cfif attributes.debugvar neq ''>
	<cfset debugStr = ''>
</cfif>

<!--- get the entrypoint groups for this program --->
<cfquery name="epgroup" datasource="#application.dbSrc#">
	select pe.entrypointgroup_id, g.name, pe.sort, count(eg.entrypoint_id) c, max(eg.entrypoint_id) id
	from program_entrypointgroup pe, entrypointgroup g, entrypoint_entrypointgroup eg, entrypoint e
	where pe.program_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.program_id#" maxlength="64">
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
	where px.program_id=#attributes.program_id#
		and px.proximity_id=x.proximity_id
	order by px.sort
</cfquery>

<cfif attributes.debugvar neq ''>
	<cfset debugStr = debugStr & "program_id = #attributes.program_id#<br>no. of entry point groups found = #epgroup.RecordCount#<br>">
</cfif>

<cfset methodSucceeded = false>
<!--- LOOP through entrypoint groups in sort order --->
<cfloop query="epgroup">
	<cfif not methodSucceeded>
		<cfif attributes.debugvar neq ''>
			<cfset debugStr = debugStr & "entrypointgroup_id = #entrypointgroup_id#<br>&nbsp; &nbsp; trying proximity methods<br>&nbsp; &nbsp; &nbsp; &nbsp; single: ">
		</cfif>
	
		<cfset egid = entrypointgroup_id>
		<!--- IF there's only one entrypoint in group, display that one --->
		<cfif c eq 1>
			<cfset methodSucceeded = true>
            <!---cfoutput>ONLY ONE</cfoutput--->
			<!--- Bug 5728 - Allow for users to "view more" offices when more than 10 offices show up in the locator --->
			<cf_displayEntrypoint entrypoint_id="#id#" mode="#attributes.mode#" var="outstr" append="true" google="#attributes.google#">
			<cfif attributes.debugvar neq ''>
				<cfset debugStr = debugStr & "success<br>">
			</cfif>
      
		<cfelse>
		<!--- ELSE --->
			<cfif attributes.debugvar neq ''>
				<cfset debugStr = debugStr & "failure<br>">
			</cfif>
			
			<cfif attributes.proximityOverride is "county">
            	<!---cfoutput>COUNTY OVERRIDE</cfoutput--->
				<cf_proximityCountyOverride entrypointgroup_id="#egid#" program_id="#attributes.program_id#" county_id="#attributes.county_id#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#attributes.suppressOfficesLink#" google="#attributes.google#" wrapUrl="true">
			<cfelse>
				<!--- LOOP through program's proximity methods in sort order --->
				<cfloop query="prgprox">
					<cfif not methodSucceeded>
				
						<cfif attributes.debugvar neq ''>
							<cfset debugStr = debugStr & "&nbsp; &nbsp; &nbsp; &nbsp; #code#: ">
						</cfif>
						<!--- try a proximity method --->
						<cfswitch expression="#code#">
							<cfcase value="local">
                            	<!---cfoutput>LOCAL</cfoutput--->
								<cf_proximityLocal entrypointgroup_id="#egid#" program_id="#attributes.program_id#" zipcode="#attributes.zipcode#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#attributes.suppressOfficesLink#">
							</cfcase>
							<cfcase value="county">
								<cf_proximityCounty entrypointgroup_id="#egid#" program_id="#attributes.program_id#" zipcode="#attributes.zipcode#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#attributes.suppressOfficesLink#" google="#attributes.google#">
                            </cfcase>
							<cfcase value="city">
                            	<!---cfoutput>CITY</cfoutput--->
								<cf_proximityCity entrypointgroup_id="#egid#" program_id="#attributes.program_id#" city_id="#attributes.city_id#" zipcode="#attributes.zipcode#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#attributes.suppressOfficesLink#">
								
							</cfcase>
							<cfcase value="zip">
                            	<!---cfoutput>ZIP</cfoutput--->
								<cf_proximityZip entrypointgroup_id="#egid#" program_id="#attributes.program_id#" zipcode="#attributes.zipcode#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#attributes.suppressOfficesLink#" google="#attributes.google#">
							</cfcase>
							<cfcase value="radius">
                            	<!---cfoutput>RADIUS</cfoutput--->
								<cf_proximityRadius entrypointgroup_id="#egid#" program_id="#attributes.program_id#" zipcode="#attributes.zipcode#" radius="#attributes.radius#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded" suppressOfficesLink="#attributes.suppressOfficesLink#">
							</cfcase>
						</cfswitch>
						
						<cfif attributes.debugvar neq ''>
							<cfif methodSucceeded>
								<cfset debugStr = debugStr & "success<br>">
							<cfelse>
								<cfset debugStr = debugStr & "failure<br>">
							</cfif>
						</cfif>
					</cfif>
				</cfloop>
				<!--- LOOP END --->
			</cfif>		
				<!--- IF no method has succeeded --->
				<cfif not methodSucceeded >
                	<!---cfoutput>NOT SUCCEEDED</cfoutput--->
					<cf_proximityRadius entrypointgroup_id="#egid#" program_id="#attributes.program_id#" zipcode="#attributes.zipcode#" radius="#attributes.radius#" mode="#attributes.mode#" limit="#attributes.limit#" var="outstr" append="true" successvar="methodSucceeded">
					<cfif attributes.debugvar neq ''>
						<cfif methodSucceeded>
							<cfset debugStr = debugStr & "&nbsp; &nbsp; &nbsp; &nbsp; radius (backstop): success<br>">
						<cfelse>
							<cfset debugStr = debugStr & "&nbsp; &nbsp; &nbsp; &nbsp; radius (backstop): failure<br>">
						</cfif>
					</cfif>
				</cfif>
				<!--- IF END --->

		</cfif>		
		<!--- IF END --->
		
	</cfif>
</cfloop>
<!--- LOOP END --->

<cfif NOT methodSucceeded  and attributes.source neq "ec">
	<cf_displayText group="site" code="site_ep_no_office_found" var="msg">
	<cfset outstr = outstr & "#msg#<br>">
</cfif>

<cfif attributes.debugvar neq ''>
	<cfif methodSucceeded>
		<cfset debugStr = debugStr & "finished<br>">
	<cfelse>
		<cfset debugStr = debugStr & "giving up<br>">
	</cfif>
</cfif>

<!-- Only insert entry point heading if ep info available -->
<cfif attributes.source neq "ec" or methodSucceeded >
	<cfset outstr = strSubHeading & outstr & "</td>
</tr>
</table></div>">
</cfif>
<cfif attributes.debugvar neq ''>
	<cfset "caller.#attributes.debugvar#" = debugStr>
</cfif>

<cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelseif attributes.append><cfsilent>
	<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>