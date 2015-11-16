<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: shows income tables. allows user to edit or add
CALLED BY: sidebar.cfm
GOES TO: add_inc_tbl.cfm
=====================================================--->
<!--- variable table == "ind"=user sees all individual tables, "county"=user sees list of all possible county tables,
"county2" = user sees all county tables within selected table--->
<cfparam name="tbl_id" type="numeric" default="0">
<cfparam name="tbl_nm" type="string">
<cfparam name="st" type="string" default="">
<cfparam name="county" type="string" default="">
<cfparam name="hh_1" type="numeric" default=0>
<cfparam name="hh_2" type="numeric" default=0>
<cfparam name="hh_3" type="numeric" default=0>
<cfparam name="hh_4" type="numeric" default=0>
<cfparam name="hh_5" type="numeric" default=0>
<cfparam name="hh_6" type="numeric" default=0>
<cfparam name="hh_7" type="numeric" default=0>
<cfparam name="hh_8" type="numeric" default=0>

<cf_checkAccess level="3">

<cfif Trim(st) eq ''>
	<cfset st = "NULL">
<cfelse>
	<cfset st = "'" & Replace(Trim(st), "'", "''", 'ALL') & "'">
</cfif>
<cfif Trim(county) eq ''>
	<cfset county = "NULL">
<cfelse>
	<cfset county = "'" & Replace(Trim(county), "'", "''", 'ALL') & "'">
</cfif>
<CFIF IsDefined('form.edit')><!-- if editing update table with changes -->
	<CFQUERY DATASOURCE="#application.dbSrc#">
		UPDATE tbl_inc_new
		set st=#PreserveSingleQuotes(st)#,
			county=#PreserveSingleQuotes(county)#,
			tbl_nm='#Trim(tbl_nm)#',
			mem1 = #Trim(hh_1)#,
			mem2 = #Trim(hh_2)#,
			mem3 = #Trim(hh_3)#,
			mem4 = #Trim(hh_4)#,
			mem5 = #Trim(hh_5)#,
			mem6 = #Trim(hh_6)#,
			mem7 = #Trim(hh_7)#,
			mem8 = #Trim(hh_8)#
		WHERE tbl_id = #tbl_id#
	</CFQUERY>
<CFELSE><!--- Inserting new --->
	<CFQUERY name="getmax" DATASOURCE="#application.dbSrc#">
		select max(proc_id) as maxpid
		from tbl_inc_new
	</cfquery>
	<cfif getmax.RecordCount eq 0>
		<cfset proc_id = 1>
	<cfelse>
		<cfset proc_id = getmax.maxpid + 1>
	</cfif>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		insert into tbl_inc_new
			(proc_id, tbl_nm, county, st, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8)
		values
			(#proc_id#, '#tbl_nm#', #PreserveSingleQuotes(county)#, #PreserveSingleQuotes(st)#,
				#hh_1#, #hh_2#, #hh_3#, #hh_4#, #hh_5#, #hh_6#, #hh_7#, #hh_8#)
	</CFQUERY>
	<CFQUERY name="getnewid" DATASOURCE="#application.dbSrc#">
		select tbl_id
		from tbl_inc_new
		where proc_id=#proc_id#
	</cfquery>
	<cfset tbl_id = getnewid.tbl_id>
</CFIF>
<CFLOCATION URL="inc_tbl2.cfm?tbl_id=#tbl_id#">