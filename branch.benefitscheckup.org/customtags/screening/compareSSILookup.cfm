<cfparam name="attributes.table" type="string">
<cfparam name="attributes.state_id" type="string" default="FD">
<cfparam name="attributes.count" type="numeric" default="1">
<cfparam name="attributes.childIncome" type="numeric" default="0">
<cfparam name="attributes.parentsIncome" type="numeric" default="0">
<cfparam name="attributes.checkHighIncome" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="result">

<cfif attributes.checkHighIncome and attributes.table neq 'child' and session.skipinc EQ 'N'>
	<cfset output = 'NO'>
<cfelse>
	<cfset totalIncome = attributes.childIncome + attributes.parentsIncome>
	<cfswitch expression="#attributes.table#">
		<cfcase value="child">
			<cfquery name="inctab" datasource="#application.dbSrc#">
				SELECT mem#attributes.count# AS mem
				FROM tbl_inc_new
				<cfif attributes.state_id eq 'MA'>
					<cfif session.ch_blind eq 'Y'>
						WHERE tbl_nm = 'Child SSI - Child Only (blind)'
					<cfelse>
						WHERE tbl_nm = 'Child SSI - Child Only (disabled)'
					</cfif>
				<cfelse>
					WHERE tbl_nm LIKE 'Child SSI - Child Only%'
				</cfif>
					AND st=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">
			</cfquery>
		</cfcase>
		<cfcase value="single">
			<cfquery name="inctab" datasource="#application.dbSrc#">
				SELECT mem#attributes.count# AS mem
				FROM tbl_inc_new
				<cfif attributes.state_id eq 'MA'>
					<cfif session.ch_blind eq 'Y'>
						WHERE tbl_nm = 'Child SSI - 1 Parent (blind)'
					<cfelse>
						WHERE tbl_nm = 'Child SSI - 1 Parent (disabled)'
					</cfif>
				<cfelse>
					WHERE tbl_nm LIKE 'Child SSI - 1 Parent%'
				</cfif>
					AND st=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">
			</cfquery>
		</cfcase>
		<cfcase value="married">
			<cfquery name="inctab" datasource="#application.dbSrc#">
				SELECT mem#attributes.count# AS mem
				FROM tbl_inc_new
				<cfif attributes.state_id eq 'MA'>
					<cfif session.ch_blind eq 'Y'>
						WHERE tbl_nm = 'Child SSI - 2 Parent (blind)'
					<cfelse>
						WHERE tbl_nm = 'Child SSI - 2 Parent (disabled)'
					</cfif>
				<cfelse>
					WHERE tbl_nm LIKE 'Child SSI - 2 Parent%'
				</cfif>
					AND st=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">
			</cfquery>
		</cfcase>
	</cfswitch>
	<cfif totalIncome lte inctab.mem>
		<cfset output = 'YES'>
	<cfelse>
		<cfset output = 'NO'>
	</cfif>
</cfif>
<cfset "caller.#attributes.var#" = output>