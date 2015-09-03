<cf_populateTableFromView table="subset_program_base" subset_id="1">
<cf_populateTableFromView table="subset_program_base" subset_id="8">
<cf_populateTableFromView table="subset_program_base" subset_id="9">
<cf_populateTableFromView table="subset_program_base" subset_id="12">
<cfparam name="st" default="">
<cfset url.st = st>
<cfset session.state_id = st>
<cfoutput>
</cfoutput>
<cfquery datasource="#application.dbSrc#" name="qryForms">
SELECT distinct(f.form_id), p.recid, p.prg_id, p.prg_nm, f.state_id as st, f.form_name, ft.type_code, ftg.tag_name, fft.string, fft.entry_date, fft.form_date, p.cat_id, fft.formtype_id, p.ST,pf.sort 
FROM
form f, formtype ft, form_formtype fft, program_form pf, tbl_prg_all p, formtag ftg, subset_program_base sp
WHERE 
f.form_id = fft.form_id 
and ft.formtype_id = fft.formtype_id
and pf.program_id=p.recid
and pf.form_id = f.form_id
and ftg.formtag_id = f.formtag_id
and ft.formtype_id <> 2
AND sp.program_id=p.RecID
AND (p.inactive_flag = 0 or p.inactive_flag is null)


<cfif isdefined('url.cat') and url.cat EQ 'PAP'>

and sp.subset_id=19
and p.CAT_ID = 331

<cfelseif isdefined('url.cat') and url.cat EQ 'MSP'>
and sp.subset_id=1
and p.CAT_ID = 309

<cfelseif isdefined('url.cat') and url.cat EQ 'QMB'>
and sp.subset_id=1
and (  p.prg_id = '103-309-1031-FD-FD' or  p.prg_id = '103-309-2681-AZ-ST')
<cfelseif isdefined('url.cat') and url.cat EQ 'QI'>
and sp.subset_id=1
and (  p.prg_id = '103-309-1071-FD-FD' or p.prg_id = '103-309-2683-AZ-ST' )
<cfelseif isdefined('url.cat') and url.cat EQ 'SLMB'>
and sp.subset_id=1
and ( p.prg_id = '103-309-1032-FD-FD' or p.prg_id = '103-309-2682-AZ-ST')
<cfelseif isdefined('url.cat') and url.cat EQ 'MEDAPROV'>
and sp.subset_id=12
<cfelseif isdefined('url.cat') and url.cat EQ 'MED'>
and sp.subset_id=8
<cfelseif isdefined('url.cat') and url.cat EQ 'OTH'>
and sp.subset_id=1
and p.CAT_ID = 332
<cfelseif isdefined('url.cat') and url.cat EQ 'STRX'>
and sp.subset_id=9
<cfelseif isdefined('url.cat') and (url.cat EQ 'Entered' or url.cat EQ 'PUB')>
and sp.subset_id=1
<cfelseif isdefined('url.ST') and url.ST neq ''>
and sp.subset_id=1
and  (f.state_id = '#url.ST#') 
</cfif>



<cfif isdefined('url.cat') and url.cat EQ 'DRUG'>
<cfif isdefined('session.ecPrgList') and len(session.ecPrgList) gt 1 >
and (sp.subset_id=1 or sp.subset_id=19)
and p.prg_id IN (#preserveSingleQuotes(session.ecPrgList)#)
<cfelse>
and sp.subset_id=10000
</cfif>
</cfif>

<cfif isdefined('url.sortorder') and isdefined ('url.sortby')>
	order by #url.sortby# #url.sortorder#, pf.sort
<cfelseif isdefined('url.ST') and url.ST neq '' >
	order by p.prg_nm,p.CAT_ID, pf.sort
<cfelseif isdefined('url.cat') and url.cat eq 'PUB'>
	order by  p.prg_nm, pf.sort 
<cfelseif isdefined('url.cat') and url.cat eq 'ENTERED'>
	order by p.prg_nm, pf.sort
<cfelseif isdefined('url.cat') and url.cat eq 'DRUG'>
	order by p.CAT_ID asc, p.prg_nm, pf.sort
<cfelseif isdefined('url.cat') and (url.cat EQ 'SLMB' or url.cat EQ 'QMB' or url.cat EQ 'QI' or url.cat EQ 'MED' or url.cat EQ 'MSP' or url.cat EQ 'STRX') >
	order by p.ST, p.prg_nm, pf.sort
<cfelse>
	order by p.prg_nm, pf.sort
</cfif>
</cfquery>

<cfif not isdefined('url.sortorder')>
	<cfset sortorder= 'asc'>
<cfelse>
	<cfif url.sortorder eq 'asc'>
		<cfset sortorder= 'desc'>
	<cfelse>
		<cfset sortorder= 'asc'>
	</cfif>
</cfif>
<cfif not isdefined('url.cat')>
	<cfset url.cat = "">
</cfif>

<cfif not isdefined('url.st')>
	<cfset url.st = "">
</cfif>