<!--- check to make sure household members is between 1 and 8 --->
<cfif session.no_hh_members IS 0>
   <cfset session.no_hh_members = 1>
<cfelseif session.no_hh_members GT 8>
   <cfset session.no_hh_members = 8>
</cfif>

<!---=========================================================================
The following section of code, takes the income tables and sets them to 
the proper variables....first the section 8, then the public housing, then the other
income tables that are not within those categories
========================================================================--->
<!--- pulling the figure from the income table for the number in the household for section 8 in the state of the client --->
<cfquery name="sec8" datasource = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='Section 8' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset sec8table = sec8.tbl>

<!--- pulling the figure from the income table for the number in the household for public housing in the state of the client --->
<cfquery name="ph" datasource = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='Public Housing' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset PHtable = ph.tbl>
   
<!--- pulling the figure from the income table for weatherization for the number in the household for public housing in the state of the client --->
<cfquery name="weather" datasource = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='WEATHER' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset WEATHERTABLE = weather.tbl>
   
<!--- pulling the figure from the income table for liheap the number in the household for public housing in the state of the client --->
<cfquery name="liheap" datasource = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LIHEAP' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset LIHEAPTABLE = liheap.tbl>
   
<!--- pulling the figure from the income table for liheapASSET the number in the household for public housing in the state of the client --->
<cfquery name="lasset" datasource = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS tbl
FROM tbl_inc_new
WHERE tbl_nm='LASSET' AND st='#session.st#'
</cfquery>
<!--- set the figure pulled in the query to the variable --->
<cfset LASSETTABLE = lasset.tbl>
   
<!--- this section queries the inc_table in the db and puts them into an array.  then the rules
   will reference the line item in the array.....because cold fusion starts its arrays
   with line item 1 (and not zero) the index of the array will match the RecID in the table. --->

<!--- *********************************** --->
<!--- *********************************** --->
<!--- *********************************** --->
<!--- 07/09/2002 REM  WE NEED TO GO THROUGH THE CODE AND REPLACE ALL INSTANCES OF proc_id WITH tbl_id, BOTH HERE AND IN THE DATACOLLECTOR--THERE'S A POTENTIAL FOR THOSE TWO ID VALUES TO GET OUT OF SYNCH, WHICH COULD LEAD TO struct_memXX RULES THAT REFERENCE THE WRONG INCOME TABLE. --->

<!--- 07/09/2002 REM  THE NEW WAY: We don't take the tables we've already gotten, and we only take the mem value that corresponds to our no_hh_members val. ---> 
<cfquery name = "build_income_array" datasource = "#application.dbSrc#">
SELECT mem#session.no_hh_members# AS mem, proc_id
FROM tbl_inc_new
WHERE tbl_nm not in ('liheap','lasset','weather','public housing','section 8')
ORDER BY proc_id
</cfquery>

<cfset struct_mem = structNew()>

<!--- loop through query results and place each row of data in a structure, one structure for each column --->
<cfloop query = "build_income_array">
   <cfset Result = StructInsert(struct_mem, #proc_id#, #mem#, "true")>
</cfloop>
