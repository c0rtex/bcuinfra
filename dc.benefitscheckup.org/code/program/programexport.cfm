<cfparam name="format" type="string" default="csv"><cf_exportQuery query="
	select p.program_id, pc.code as category, pg.code as `group`, p.state_id as state, p.program_code as code,
		dl1.display_text as name, dl2.display_text as description, p.url, p.exclude_flag as exclude,
		p.significant_flag as significant, p.active_flag as active, f.name as funder, r.name as reference,
		p.last_update, p.notes, p.supersort, p.sort, p.legacy_prg_id, p.legacy_pri_sec
	from program p inner join programcategory pc
			on p.programcategory_id=pc.programcategory_id
		left outer join programgroup pg
			on p.programgroup_id=pg.programgroup_id
		left outer join display_language dl1
			on p.name_display_id=dl1.display_id
				and dl1.language_id='EN'
		left outer join display_language dl2
			on p.desc_display_id=dl2.display_id
				and dl2.language_id='EN'
		left outer join funder f
			on p.funder_id=f.funder_id
		left outer join reference r
			on p.reference_id=r.reference_id
	order by p.program_id
" columnList="program_id,category,group,state,code,name,description,url,exclude,significant,active,funder,reference,last_update,notes,supersort,sort,legacy_prg_id,legacy_pri_sec" format="#format#">