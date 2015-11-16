<!--- disable tag with giant if statement --->
<cfif false>

<!--- Created by BShunn 2005/08/31 --->
<cfparam name="attributes.redirect" type="boolean" default="false">
<cfparam name="attributes.source_id" type="any" default="">
<cfparam name="attributes.prev_id" type="any" default="">
<cfparam name="attributes.org_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.language_id" type="any" default="">
<cfparam name="attributes.access_id" type="any" default="">
<cfparam name="attributes.client_id" type="any" default="">
<cfparam name="attributes.user_id" type="any" default="">
<cfparam name="attributes.state_id" type="any" default="">
<cfparam name="attributes.test_id" type="any" default="">

<!--- 2005/09/06 BShunn  Only log pageview details first time through --->
<cfif Not IsDefined('session.sessionDetailsLogged')>
	<cfset session.sessionDetailsLogged = False>
</cfif>

<!--- 2005/09/06 BShunn  Only log pageview if session.EnableLogFeature is set --->
<cfif session.EnableLogFeature eq 1>

<!--- Load database IDs for session variables and environment variables into
      application scope, if not already done --->
<cf_loadApplicationVars hashname="sessionvars">
<cf_loadApplicationVars hashname="envvars">

<!--- Insert main entry into pageview table --->
<cfstoredproc procedure="sequence" datasource="#application.dbSrc#">
	<cfprocparam type="in" value="pageview" cfsqltype="cf_sql_varchar">
	<cfprocparam type="out" variable="pageviewID" cfsqltype="cf_sql_numeric">
	<cfprocresult name="nextkey" resultset="1">
</cfstoredproc>
<cfquery name="insertpageview" datasource="#application.dbSrc#">
	INSERT INTO pageview  
		(pageview_id, server_id, cfid, cftoken, is_redirect, pageview_datetime)
	VALUES
		(#pageviewID#, #session.server_id#, #IIf(IsDefined('session.cfid'), session.cfid, 'NULL')#, #IIf(IsDefined('session.cftoken'), session.cftoken, 'NULL')#, #IIf(attributes.redirect, 1, 0)#, #Now()#)
</cfquery>

<cfif Not session.sessionDetailsLogged> <!--- Only log details on first pageview for session --->
	<!--- Insert relevant session variables into sessionvar table --->
	<cfloop index="itemID" list="source_id,prev_id,org_id,partner_id,subset_id,language_id,access_id,client_id,user_id,state_id,test_id">
		<cfif attributes.redirect Is True>
			<cfset useID="attributes.#itemID#">
		<cfelse>
			<cfset useID="session.#itemID#">
		</cfif>
		<cfif IsDefined(useID) And Evaluate(useID) Neq ''>
			<cfif StructKeyExists(application.sessionvars, itemID)>
				<cfset sessionvarID = StructFind(application.sessionvars, itemID)>
			<cfelse>
				<cfstoredproc procedure="sequence" datasource="#application.dbSrc#">
					<cfprocparam type="in" value="sessionvar" cfsqltype="cf_sql_varchar">
					<cfprocparam type="out" variable="sessionvarID" cfsqltype="cf_sql_numeric">
					<cfprocresult name="nextkey" resultset="1">
				</cfstoredproc>
				<cfset StructInsert(application.sessionvars, itemID, sessionvarID)>
				<cfquery name="insertsessionvarid" datasource="#application.dbSrc#">
					INSERT INTO sessionvar  
						(sessionvar_id, sessionvar_name)
					VALUES
						(#sessionvarID#, '#itemID#')
				</cfquery>
			</cfif>
			<cfset sessionVarVal = Left(Evaluate(useID), 16)>
			<cfset sessionVarVal = "'" & Replace(sessionVarVal, "'", "''", 'ALL') & "'">
			<cfquery name="insertsessionvarid" datasource="#application.dbSrc#">
				INSERT INTO pageview_sessionvar  
					(pageview_id, sessionvar_id, var_value)
				VALUES
					(#pageviewID#, #sessionvarID#, #PreserveSingleQuotes(sessionVarVal)#)
			</cfquery>
		</cfif>
	</cfloop>
</cfif>

<!--- Insert relevant environment variables into envvar table --->
<cfloop index="itemID" list="#ListSort(StructKeyList(CGI), 'Textnocase')#">
	<cfif Not session.sessionDetailsLogged Or itemID eq 'SCRIPT_NAME'>
	<!--- Only log details on first pageview for session, or for SCRIPT_NAME environment var --->
		<cfset varval = StructFind(CGI, itemID)>
		<cfif varval Neq ''>
			<cfif StructKeyExists(application.envvars, itemID)>
				<cfset envvarID = StructFind(application.envvars, itemID)>
			<cfelse>
				<cfstoredproc procedure="sequence" datasource="#application.dbSrc#">
					<cfprocparam type="in" value="envvar" cfsqltype="cf_sql_varchar">
					<cfprocparam type="out" variable="envvarID" cfsqltype="cf_sql_numeric">
					<cfprocresult name="nextkey" resultset="1">
				</cfstoredproc>
				<cfset StructInsert(application.envvars, itemID, envvarID)>
				<cfquery name="insertenvvarid" datasource="#application.dbSrc#">
					INSERT INTO envvar  
						(envvar_id, envvar_name)
					VALUES
						(#envvarID#, '#itemID#')
				</cfquery>
			</cfif>
			<cfquery name="insertenvvarid" datasource="#application.dbSrc#">
				INSERT INTO pageview_envvar  
					(pageview_id, envvar_id, var_value)
				VALUES
					(#pageviewID#, #envvarID#, '#Left(varval, 255)#')
			</cfquery>
		</cfif>
	</cfif>
</cfloop>

<cfset session.sessionDetailsLogged = True>

</cfif>

</cfif>