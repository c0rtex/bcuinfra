<!--- check to make sure household members is between 1 and 8 --->
<cfif Not IsDefined('session.no_hh_members') or session.no_hh_members eq 0>
	<cfset session.no_hh_members = 1>
<cfelseif session.no_hh_members GT 8>
	<cfset session.no_hh_members = 8>
</cfif>
<cfset householdcount =  session.no_hh_members>
<cfif IsDefined('session.hh_depend')>
	<cfset session.hh_depend = val(session.hh_depend)>
	<cfif session.hh_depend eq "" or session.hh_depend lt 1>
   		<cfset session.hh_depend = 1>
	<cfelseif session.hh_depend GT 8>
   		<cfset session.hh_depend = 8>
	</cfif>
	<!---<cfset householdcount = session.hh_depend>--->
	<cfset dependcount = session.hh_depend>
<cfelse>
	<cfset dependcount = 1>
</cfif>
<!--- 4/4/10 MH: Removed per Bug 5139
<cfif IsDefined('session.hh_depend') and IsDefined('session.no_hh_members') and (session.hh_depend gt 1 or session.no_hh_members gt 1)>
	<cfif session.no_hh_members gt session.hh_depend>
		<cfset householdcount =  session.no_hh_members>
	<cfelse>
		<cfset householdcount = session.hh_depend>
	</cfif>
</cfif> --->
<cfif IsDefined('session.no_hh_children')>
	<cfif session.no_hh_children lt 1>
		<cfset childcount = 1>
	<cfelseif session.no_hh_children gt 8>
		<cfset childcount = 8>
	<cfelse>
		<cfset childcount = session.no_hh_children>
	</cfif>
<cfelse>
	<cfset childcount = 1>
</cfif>

<!---=========================================================================
The following section of code, takes the income tables and sets them to 
the proper variables....first the section 8, then the public housing, then the other
income tables that are not within those categories
========================================================================--->
<!--- pulling the figure from the income table for the number in the household for section 8 in the state of the client --->
<cfquery name="sec8" datasource = "#application.dbSrc#">
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='Section 8' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset sec8table = sec8.tbl>

<!--- pulling the figure from the income table for the number in the household for public housing in the state of the client --->
<cfquery name="ph" datasource = "#application.dbSrc#">
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='Public Housing' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset PHtable = ph.tbl>
   
<!--- pulling the figure from the income table for weatherization for the number in the household for public housing in the state of the client --->
<cfquery name="weather" datasource = "#application.dbSrc#">
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='WEATHER' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset WEATHERTABLE = weather.tbl>
   
<!--- pulling the figure from the income table for liheap the number in the household for public housing in the state of the client --->
<cfquery name="liheap" datasource = "#application.dbSrc#">
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LIHEAP' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset LIHEAPTABLE = liheap.tbl>
   
<!--- pulling the figure from the income table for liheapASSET the number in the household for public housing in the state of the client --->
<cfquery name="lasset" datasource = "#application.dbSrc#">
SELECT mem#householdcount# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LASSET' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset LASSETTABLE = lasset.tbl>
   
<!--- loading TANF figure --->
<cfif childcount gt 0>
	<cfquery name="tanf" datasource = "#application.dbSrc#">
		SELECT mem#childcount# AS tbl
		FROM tbl_inc_new
		WHERE tbl_nm='TANF'
			AND st='#session.st#'
	</cfquery>
	<!--- set the figure pulled in the query to the variable --->
	<cfset TANFTABLE = tanf.tbl>
<cfelse>
	<cfset TANFTABLE = 0>
</cfif>
   
<!--- this section queries the inc_table in the db and puts them into an array.  then the rules
   will reference the line item in the array.....because cold fusion starts its arrays
   with line item 1 (and not zero) the index of the array will match the RecID in the table. --->

<!--- *********************************** --->
<!--- *********************************** --->
<!--- *********************************** --->
<!--- 07/09/2002 REM  WE NEED TO GO THROUGH THE CODE AND REPLACE ALL INSTANCES OF proc_id WITH tbl_id, BOTH HERE AND IN THE DATACOLLECTOR--THERE'S A POTENTIAL FOR THOSE TWO ID VALUES TO GET OUT OF SYNCH, WHICH COULD LEAD TO struct_memXX RULES THAT REFERENCE THE WRONG INCOME TABLE. --->

<!--- 07/09/2002 REM  THE NEW WAY: We don't take the tables we've already gotten, and we only take the mem value that corresponds to our no_hh_members val. ---> 
<cfquery name = "build_income_array" datasource = "#application.dbSrc#">
SELECT mem#householdcount# AS mem, mem#dependcount# AS depmem, mem#childcount# AS chdmem, proc_id
FROM tbl_inc_new
WHERE tbl_nm not in ('liheap','lasset','weather','public housing','section 8','TANF')
ORDER BY proc_id
</cfquery>

<cfset struct_mem = structNew()>
<cfset listable = structNew()>
<cfset childtable = structNew()>

<!--- loop through query results and place each row of data in a structure, one structure for each column --->
<cfloop query = "build_income_array">
   <cfset Result = StructInsert(struct_mem, #proc_id#, #mem#, "true")>
   <cfset Result = StructInsert(listable, #proc_id#, #depmem#, "true")>
   <cfset Result = StructInsert(childtable, #proc_id#, #chdmem#, "true")>
</cfloop>