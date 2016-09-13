<!---
cacheToteboard.cfm

created by Bill Shunn, 27 Oct 2006

This custom tag manages an application-level structure that caches various "toteboard" numbers in memory once a day (or on first access) and permits them to be displayed.  Essentially, when display of a toteboard number is requested, the tag checks to see if it exists in memory.  If not, it fetches it from the database.  If so, it checks to see if the cache time has expired.  If so, it refreshes the number from the database.

Attributes:

field:  string, name of the toteboard field to return (default: 'screenings')
			possible values:
			screenings:  Returns a total of screenings we have run
			users:  Returns a total of unique visitors who have been helped
			dollars:  Returns a total of the value of benefits so far found for users
refresh:  boolean, forces refresh of toteboard values (default: false)
var:  string, if specified, value returned to named variable in caller scope, otherwise value is printed (default: '')

--->
<cfparam name="attributes.field" type="string" default="screenings">
<cfparam name="attributes.refresh" type="boolean" default="false">
<cfparam name="attributes.writerounded" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="">
<!--- Only allow defined fields, force bad input to default value --->
<cfif not ListFind('screenings,users,dollars', attributes.field)>
	<cfset attributes.field = 'screenings'>
</cfif>
<!--- If application structure doesn't exist, create it and set next refresh time --->
<cfif not IsDefined('application.bcuToteboard')>
	<cfset application.bcuToteboard = StructNew()>
	<!--- Since I've arbitrarily chosen 4:00 am as the refresh time, we set the next refresh date by adding 20 hours to the current time --->
	<cfset refreshDate = DateAdd('h', 20, Now())>
	<cfset application.bcuToteboard.refreshDateTime = CreateDateTime(Year(refreshDate), Month(refreshDate), Day(refreshDate), 4, 0, 0)>
	<cfset application.bcuToteboard.lastRefresh = Now()>
</cfif>
<!--- If structure node doesn't exist, create it --->
<cfif not IsDefined("application.bcuToteboard.#attributes.field#")>
	<cfset "application.bcuToteboard.#attributes.field#" = ''>
</cfif>
<!--- If refresh time is past, or refresh is explicitly set, clear the nodes and set new refresh time --->
<cfif attributes.refresh or DateCompare(Now(), application.bcuToteboard.refreshDateTime) gt -1>
	<cfset application.bcuToteboard.screenings = ''>
	<cfset application.bcuToteboard.users = ''>
	<cfset application.bcuToteboard.dollars = ''>
	<cfset refreshDate = DateAdd('h', 20, Now())>
	<cfset application.bcuToteboard.refreshDateTime = CreateDateTime(Year(refreshDate), Month(refreshDate), Day(refreshDate), 4, 0, 0)>
	<cfset application.bcuToteboard.lastRefresh = Now()>
</cfif>
<!--- If desired node is blank, fetch and cache the value --->
<cfif Evaluate("application.bcuToteboard.#attributes.field#") eq ''>
	<cfswitch expression="#attributes.field#">
		<cfcase value="screenings">
			<!--- Call data mine query to count screenings --->
			<cfquery name="whscr" datasource="bcu_warehouse2">
				select count(s.id) AS c
				from screening s join oe_org o
					on s.oe_org_id=o.id
				where s.subset_id not in (41, 53)
			</cfquery>
			<cfset application.bcuToteboard.screenings = whscr.c>
		</cfcase>
		<cfcase value="users">
			<!--- Replace this bit of temporary tomfoolery with a database call!!! --->
			<cfset application.bcuToteboard.users = Day(Now()) * 1000000 + Month(Now()) * 10000 + Year(Now())>
		</cfcase>
		<cfcase value="dollars">
			<!--- Call data mine query to sum dollar value --->
			<cfquery name="whdlr" datasource="bcu_warehouse2">
				    select sum(dollarvalue) as s
                    from screening s join oe_org o on s.oe_org_id = o.id 
                    where (s.subset_id != 41 or              
                    ((s.source_id = 7 or s.partner_id in (47,51)) 
                    and s.submission_status in (1,222,999))) 
                    and s.subset_id != 53;
			</cfquery>
			<cfset application.bcuToteboard.dollars = whdlr.s>
		</cfcase>
	</cfswitch>
</cfif>
<cfif attributes.writerounded>
	<!--- Format the desired value rounded to one decimal place with magnitude written out --->
	<cf_integerWriteRounded num="#Evaluate("application.bcuToteboard.#attributes.field#")#" var="outstr">
<cfelse>
	<!--- Format the desired value with commas --->
	<cf_integerSeparate num="#Evaluate("application.bcuToteboard.#attributes.field#")#" round="true" var="outstr">
</cfif>
<cfif attributes.field eq 'dollars'>
	<cfset outstr = "$#outstr#">
</cfif>
<!--- Either print the value or pass it to specified variable in caller scope --->
<cfif attributes.var eq "">
	<cfoutput>#outstr#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outstr>
</cfif>