<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: Adds a new entry point. 
CALLED BY: add_spons.cfm
GOES TO: if individual entry point... ind_entry.cfm
		 if grouped entry point... add_spons.cfm
=====================================================--->


<CFIF IsDefined("cancel")>
	<CFABORT>
</CFIF>
<!--- insert new entry point --->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="updateid">
	SELECT max(org_id) as updateid
	FROM tbl_entry
</CFQUERY>
<CFSET newid = updateid.updateid + 1>

<CFQUERY DATASOURCE="#application.dbSrc#">
	INSERT INTO tbl_entry
		(org_id, org_name, org_name2, address, address1, address2, 
         city, zip, st, counties_served, cities_served, 
         zips_served, phone_no, fax, email, web_site, 
         added_by, mod_by, group_id, hours)
	VALUES 
		(#newid#, '#form.org_name#', '#form.org_name2#', '#form.address#', '#form.address1#',
		'#form.address2#', '#form.city#', '#form.zip#', '#form.st#', '#form.counties_served#', 
		'#form.cities_served#', '#form.zips_served#', '#form.phone_no#', '#form.fax#', '#form.email#', 
		'#form.web_site#', '#session.user#', '#session.user#', #form.group_id#, '#form.hours#')
</CFQUERY>
<!---CFSET orgid = "#updateid.updateid#"--->
<!---CFQUERY DATASOURCE="#datasrc" NAME="addtophonelookup"--->
<!--	INSERT INTO tbl_phone_lookup (org_id,phone_no,a_area,a_number,a_note,b_area,b_number,b_note,c_area,c_number,--->
<!---c_note,f_area,f_number,additional)--->
<!---	VALUES (#orgid#,#Form.phone_no#,#Form.a_area#,#Form.a_number#,#Form.a_note#,#Form.b_area#,#Form.b_number#,#Form.b_note#,#Form.c_area#,#Form.c_number#,#Form.c_note#,#Form.f_area#,#Form.f_number#,#Form.additional#) </CFQUERY--->


<CFIF IsDefined("prg_id")>
	<CFLOCATION URL="ind_entry.cfm?prg_id=#prg_id#">
<CFELSE>
	<CFLOCATION URL="add_spons.cfm?group_id=#group_id#&zip=#zip#">
</CFIF>
<cfmodule template="../footer.cfm">