<!---
	Template Name: ToteboardPoolCache
	Component Purpose: Component manages local cache of user tote boards

	Data Tables: Screening, Oe_org

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuToteboardComponent">

<!---
	Method initialises and clears local cache container
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>

	<cfinvoke component="#this#" method="actionrefreshtoteboard">
</cffunction>

<!---
	Method initialises and clears local cache container
--->

<cffunction name="actionRefreshToteboard" output="no">
	<cfset refreshDate = DateAdd('h', 20, Now())>
	<cfset this.internalContent.refreshDateTime = CreateDateTime(Year(refreshDate), Month(refreshDate), Day(refreshDate), 4, 0, 0)>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.screenings = ''>
	<cfset this.internalContent.users = ''>
	<cfset this.internalContent.dollars = ''>
</cffunction>

<!--
	Method return screening tote board with passed precision
--->

<cffunction name="getScreenings" output="no">
	<cfargument name="writerounded" type="boolean" default="false">

	<cfif  this.internalContent.screenings eq '' or DateCompare(Now(), this.internalContent.refreshDateTime) gt -1>
		<cfquery name="whscr" datasource="#application.dbSrcWarehouse#">
			select count(s.id) AS c
			from screening s join oe_org o
				on s.oe_org_id=o.id
			where s.subset_id not in (41, 53)
		</cfquery>
		<cfinvoke component="#this#" method="actionRefreshToteboard">
		<cfset this.internalContent.screenings = whscr.c + 9500>
	</cfif>

	<cfreturn this.formatValue(this.internalContent.screenings,writerounded)>
</cffunction>

<!---
	Method returns user tote board with passed precision
--->

<cffunction name="getUsers" output="no">
	<cfargument name="writerounded" type="boolean" default="false">

	<cfif this.internalContent.users eq '' or DateCompare(Now(), this.internalContent.refreshDateTime) gt -1>
		<cfinvoke component="#this#" method="actionRefreshToteboard">
		<cfset this.internalContent.users = Day(Now()) * 1000000 + Month(Now()) * 10000 + Year(Now())>
	</cfif>

	<cfreturn this.formatValue(this.internalContent.users,writerounded)>
</cffunction>

<!---
	Method returns dollars tote board with passed precision
--->

<cffunction name="getDollars" output="no">
	<cfargument name="writerounded" type="boolean" default="false">

	<cfif this.internalContent.dollars eq '' or DateCompare(Now(), this.internalContent.refreshDateTime) gt -1>
		<cfquery name="whdlr" datasource="#application.dbSrcWarehouse#">
			select sum(dollarvalue) as s
                   from screening s join oe_org o on s.oe_org_id = o.id
                   where (s.subset_id != 41 or
                   ((s.source_id = 7 or s.partner_id in (47,51))
                   and s.submission_status in (1,222,999)))
                   and s.subset_id != 53;
		</cfquery>
		<cfinvoke component="#this#" method="actionRefreshToteboard">
		<cfset this.internalContent.dollars = whdlr.s + 300000000>
	</cfif>

	<cfreturn "$"&this.formatValue(this.internalContent.dollars,writerounded)>
</cffunction>

<!---
	Method return value formated to passed precision
--->

<cffunction name="formatValue">
	<cfargument name="value" type="any" default="">
	<cfargument name="writerounded" type="boolean" default="false">

	<cfif writerounded>
		<cf_integerWriteRounded num="#value#" var="outstr">
	<cfelse>
		<cf_integerSeparate num="#value#" round="true" var="outstr">
	</cfif>

	<cfreturn outstr>
</cffunction>

</cfcomponent>
