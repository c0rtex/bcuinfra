<cf_checkAccess level="5">
<cf_buildPage title="Served Errors" section="entrypoint">

<h2>Served Errors</h2>
<h4><i>checks for errors in entry points and their *_served fields</i></h4>

<cfquery name="serve" datasource="#application.dbSrc#">
	select e.recid, e.org_name, e.st, e.zip, e.cities_served, e.counties_served, e.zips_served,
		z.zipcode, z.valid zip_valid, z.state_id as zip_state_id, s.state_id, s.statetype_id
	from tbl_entry e left outer join zip z
			on substring(e.zip, 1, 5)=z.zipcode
		left outer join state s
			on e.st=s.state_id
	order by e.recid
</cfquery>

<cfif not IsDefined('application.dcCountyCache')>
	<cfset application.dcCountyCache = StructNew()>
	<cfquery name="cc" datasource="#application.dbSrc#">
		select state_id, county_name
		from county
		order by state_id, county_name
	</cfquery>
	<cfloop query="cc">
		<cfset StructInsert(application.dcCountyCache, "#Trim(state_id)#:#Trim(county_name)#", 1)>
		<cfif StructKeyExists(application.dcCountyCache, county_name)>
			<cfset StructUpdate(application.dcCountyCache, county_name, ListAppend(StructFind(application.dcCountyCache, county_name), state_id))>
		<cfelse>
			<cfset StructInsert(application.dcCountyCache, county_name, state_id)>
		</cfif>
	</cfloop>
</cfif>

<cfoutput>

<cfset count = 0>
<cfset ncount = 0>
<cfset serr = 0>
<cfset ziperr = 0>
<cfset ccount = 0>
<cfset cerr = 0>
<cfset ycount = 0>
<cfset yerr = 0>
<cfset zcount = 0>
<cfset zerr = 0>
<cfloop query="serve">
	<cfset count = count + 1>
	<cfset s = Trim(st)>
	<cfset zc = Left(Trim(zip), 5)>
	<cfset c = Trim(cities_served)>
	<cfset y = Trim(counties_served)>
	<cfset z = Trim(zips_served)>
	<cfif c eq '' and y eq '' and z eq ''>
		<cfset ncount = ncount + 1>
	</cfif>
	<cfset serrmsg = ''>
	<cfif st neq '' and state_id eq ''>
		<cfset serrmsg = serrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> state '#st#' does not exist</font><br>">
		<cfset serr = serr + 1>
	</cfif>
	<cfset ziperrmsg = ''>
	<cfif zip_valid eq 0>
		<cfset ziperrmsg = ziperrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#zip#' has become invalid</font><br>">
		<cfset ziperr = ziperr + 1>
	<cfelseif zip neq '' and zipcode eq ''>
		<cfset ziperrmsg = ziperrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#zip#' does not exist</font><br>">
		<cfset ziperr = ziperr + 1>
	<cfelseif zip_state_id neq '' and state_id neq '' and zip_state_id neq state_id>
		<cfset ziperrmsg = ziperrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#zip#' belongs in state '#zip_state_id#', not '#state_id#'</font><br>">
		<cfset ziperr = ziperr + 1>
	</cfif>
	<cfset cerrmsg = ''>
	<cfif c neq ''>
		<cfset ccount = ccount + 1>
		<cfif s eq ''>
			<cfset cerrmsg = cerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> cities could not be checked because state is unknown</font><br>">
			<cfset cerr = cerr + 1>
		<cfelse>
			<cfloop list="#c#" index="xx">
				<cfset x = Trim(xx)>
				<cfquery name="epc" datasource="#application.dbSrc#">
					select city_name, valid
					from city
					where city_name='#x#'
						and state_id='#s#'
				</cfquery>
				<cfif not epc.RecordCount>
					<cfset cerrmsg = cerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> city '#x#' does not exist in state '#s#'</font><br>">
					<cfset cerr = cerr + 1>
				<cfelseif epc.valid eq 0>
					<cfset cerrmsg = cerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> city '#x#' has become invalid</font><br>">
					<cfset cerr = cerr + 1>
				</cfif>
			</cfloop>
		</cfif>
	</cfif>
	<cfset yerrmsg = ''>
	<cfif y neq ''>
		<cfset ycount = ycount + 1>
		<cfif s eq ''>
			<cfquery name="epst" datasource="#application.dbSrc#">
				select p.state_id
				from tbl_entry e, tbl_prg_entry pe, tbl_prg_all po, program p
				where e.recid=#recid#
					and e.org_id=pe.org_id
					and pe.prg_id=po.prg_id
					and po.recid=p.program_id
					and p.state_id is not null
				union
				select p.state_id
				from tbl_entry e, tbl_prg_entry pe, tbl_prg_all po, program p
				where e.recid=#recid#
					and e.group_id=pe.group_id
					and pe.prg_id=po.prg_id
					and po.recid=p.program_id
					and p.state_id is not null
			</cfquery>
			<cfif epst.RecordCount eq 1>
				<cfset s = epst.state_id>
				<cfset yerrmsg = yerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""blue""><strong>extrapolation:</strong> state determined from associated programs as #epst.state_id#</font><br>">
			<cfelse>
				<cfif zc neq ''>
					<cfquery name="epzip" datasource="#application.dbSrc#">
						select z.state_id
						from zip z
						where z.zipcode='#zc#'
					</cfquery>
					<cfif epzip.RecordCount eq 1>
						<cfset s = epzip.state_id>
						<cfset yerrmsg = yerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""blue""><strong>extrapolation:</strong> state determined from zipcode as #epzip.state_id#</font><br>">
					</cfif>
				</cfif>
				<cfif s eq ''>
					<cfset foundcounty = false>
					<cfset loopcounty = 1>
					<cfloop condition="not foundcounty and loopcounty lte ListLen(y)">
						<cfquery name="epcy" datasource="#application.dbSrc#">
							select c.state_id
							from county c
							where c.county_name='#ListGetAt(y, loopcounty)#'
						</cfquery>
						<cfif epcy.RecordCount eq 1>
							<cfset foundcounty = true>
							<cfset s = epcy.state_id>
							<cfset yerrmsg = yerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""blue""><strong>extrapolation:</strong> state determined from county name as #epcy.state_id#</font><br>">
						</cfif>
						<cfset loopcounty = loopcounty + 1>
					</cfloop>
				</cfif>
				<cfif s eq ''>
					<cfset yerrmsg = yerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> state not specified</font><br>">
					<cfset yerr = yerr + 1>
				</cfif>
			</cfif>
		</cfif>
		<cfif ListFindNoCase(y, 'all') and ListLen(y) gt 1>
			<cfset yerrmsg = yerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> 'ALL' not specified alone</font><br>">
			<cfset yerr = yerr + 1>
		<cfelseif y neq 'all'>
			<cfloop list="#y#" index="xx">
				<cfset x = Trim(xx)>
				<cfif not StructKeyExists(application.dcCountyCache, "#s#:#x#")>
					<cfif StructKeyExists(application.dcCountyCache, x)>
						<cfset hint = " <em>(could be #ListChangeDelims(StructFind(application.dcCountyCache, x), ', ')#?)</em>">
					<cfelse>
						<cfset hint = ''>
					</cfif>
					<cfset yerrmsg = yerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> county '#x#' not found in state '#s#'#hint#</font><br>">
					<cfset yerr = yerr + 1>
				</cfif>
			</cfloop>
		</cfif>
	</cfif>
	<cfset zerrmsg = ''>
	<cfif z neq ''>
		<cfset zcount = zcount + 1>
		<cfloop list="#z#" index="xx">
			<cfset x = Trim(xx)>
			<cfquery name="epzip" datasource="#application.dbSrc#">
				select zipcode, valid
				from zip
				where zipcode='#x#'
			</cfquery>
			<cfif not epzip.RecordCount>
				<cfset zerrmsg = zerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#x#' does not exist</font><br>">
				<cfset zerr = zerr + 1>
			<cfelseif epzip.valid eq 0>
				<cfset zerrmsg = zerrmsg & "&nbsp; &nbsp; &nbsp; &nbsp; <font color=""red""><strong>error:</strong> zipcode '#x#' has become invalid</font><br>">
				<cfset zerr = zerr + 1>
			</cfif>
		</cfloop>
	</cfif>
	<cfif serrmsg neq '' or ziperrmsg neq '' or cerrmsg neq '' or yerrmsg neq '' or zerrmsg neq ''>
		<strong>#recid#: <cf_checkAccessLink level="5" href="entrypointview.cfm?id=#recid#" target="_blank">#org_name#</cf_checkAccessLink></strong><br>
		&nbsp; &nbsp; state: #st#<br>
		&nbsp; &nbsp; zip: #zip#<br>
		<cfif serrmsg neq ''>
			#serrmsg#
		</cfif>
		<cfif ziperrmsg neq ''>
			#ziperrmsg#
		</cfif>
		<cfif cerrmsg neq ''>
			&nbsp; &nbsp; cities served: #c#<br>
			#cerrmsg#
		</cfif>
		<cfif yerrmsg neq ''>
			&nbsp; &nbsp; counties served: #y#<br>
			#yerrmsg#
		</cfif>
		<cfif zerrmsg neq ''>
			&nbsp; &nbsp; zips served: #z#<br>
			#zerrmsg#
		</cfif>
	<br>
	</cfif>
</cfloop>
<strong>e.p.'s:</strong> #count#<br>
<strong>e.p. state errors:</strong> #serr#</em><br>
<strong>e.p. zipcode errors:</strong> #ziperr#</em><br>
<strong>e.p.'s w/cities served fields:</strong> #ccount#&nbsp; <em>(#cerr# w/errors)</em><br>
<strong>e.p.'s w/counties served fields:</strong> #ycount#&nbsp; <em>(#yerr# w/errors)</em><br>
<strong>e.p.'s w/zips served fields:</strong> #zcount#&nbsp; <em>(#zerr# w/errors)</em><br>
<strong>e.p.'s w/no "served" field:</strong> #ncount#<br>

</cfoutput>

</cf_buildPage>