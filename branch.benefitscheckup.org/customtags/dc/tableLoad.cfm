<cfsilent>
<cfparam name="attributes.table" type="string" default="">
<cfparam name="attributes.var" type="string" default="tableList">

<cfif attributes.table eq ''>
	<cfset "caller.#attributes.var#" = 'alt_url_partner,answerfield,answerfield_option,answerfield_relationship,answerfield_subset_partner,answerfieldtype,city,city_zip,county,display,display_language,displaygroup,entrypoint,entrypointgroup,entrypoint_city,entrypoint_county,entrypoint_entrypointgroup,entrypoint_zip,error,form,form_formtype,format,formclass,formtag,formtype,funder,gridcolumn,gridrow,gridrow_gridcolumn_answerfield,hardrule,hardrule_answerfield,help,helptype,image,language,option,option_subset_partner,page,partnertype,phone,phonetype,program,program_answerfield,program_entrypointgroup,program_form,program_parent,program_proximity,program_requisite,program_rule,programcategory,programgroup,programtext,programvalue,protocol,proximity,question,question_answerfield,question_gridcolumn,question_gridrow,question_help,questioncategory,questionheader,questiontype,quote,recap,reference,relationship,requisite,resultpage,rule,rule_answerfield,sitetext,source,state,state_snap,statecarrier,statetype,subset,subset_answerfield,subset_content,subset_gridrow,subset_partner,subset_partner_shadow,subset_program,subset_program_base,subset_program_sum,subset_programcategory,subset_question,subset_requisite,subsettype,tbl_answerfield_list,tbl_generic,tbl_inc_new,tbl_major_cat_list,tbl_mx_asset,tbl_mx_income,tbl_opt,tbl_partner,tbl_prg_all,tbl_questions_new,tbl_rules,tbl_RX_Detail,tbl_RX_MFR,tbl_RX_PrgDetail,tbl_RX_Scenarios,tbl_st,tbl_zip,tblCookCountyCities,template,url,user,validation,wrapper,xassettype,xincass,xincometype,xsubset,xsubset_answerfield,xsubset_xincass,xsubset_program,xsubset_xassettype,xsubset_xincometype,zip'>
<cfelse>

	<cfset caller.columns = ''>
	<cfset caller.keys = ''>
	<cfset caller.unique = ''>
	<cfset caller.identity = false>
	<cfset caller.tag = ''>
	<cfset caller.name = ''>
	<cfset caller.view = false>

	<cfswitch expression="#attributes.table#">

		<cfcase value="alt_url_partner">
			<cfset caller.columns = 'alt_url_partner_id|ID|n|1,url_id|URL|n|1,partner_id|Partner|n|1,alt_url_id|Alternate&nbsp;URL|n|1'>
			<cfset caller.keys = 'alt_url_partner_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = true>
			<cfset caller.tag = 'aup'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="answerfield">
			<cfset caller.columns = 'answerfield_id|ID|n|1,answerfieldtype_id|Type|n|1,answerfield|Answerfield|s|1,display_id|Display&nbsp;Text|n|0,short_display_id|Recap&nbsp;Text|n|0,spq_display_id|Alt.&nbsp;SPQ&nbsp;Text|n|0,print_display_id|Alt.&nbsp;Printed&nbsp;Text|n|0,max_length|Max&nbsp;Chars|n|0,default_value|Interactive&nbsp;Default|s|0,spq_default_value|SPQ&nbsp;Default|s|0,oe_default_value|OE&nbsp;Default|s|0,required_flag|Required?|n|1,rule_id|Rule|n|0,validation_id|Validation|n|0,state_id|State|s|0,answerfield_desc|Description|s|0,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'answerfield_id'>
			<cfset caller.unique = 'answerfield'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'a'>
			<cfset caller.name = 'answerfield'>
		</cfcase>

		<cfcase value="answerfield_option">
			<cfset caller.columns = 'answerfield_id|Answerfield|n|1,option_id|Option|n|1,sort|Sort|n|1'>
			<cfset caller.keys = 'answerfield_id,option_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="answerfield_relationship">
			<cfset caller.columns = 'left_answerfield_id| |n|1,right_answerfield_id| |n|1,relationship_id| |n|1'>
			<cfset caller.keys = 'left_answerfield_id,right_answerfield_id,relationship_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="answerfield_subset_partner">
			<cfset caller.columns = 'answerfield_id|Answerfield|n|1,subset_id|Subset|n|0,partner_id|Partner|n|0,default_value|Default|s|0,background_flag|Set&nbsp;Value&nbsp;in&nbsp;Background?|n|1'>
			<cfset caller.keys = 'answerfield_id,subset_id,partner_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'asp'>
		</cfcase>

		<cfcase value="answerfieldtype">
			<cfset caller.columns = 'answerfieldtype_id|ID|n|1,code|Code|s|1,name|Name|s|1,description|Description|s|0'>
			<cfset caller.keys = 'answerfieldtype_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'at'>
			<cfset caller.name = 'name'>
		</cfcase>

		<cfcase value="city">
			<cfset caller.columns = 'city_id|ID|s|1,city_name|City|s|1,state_id|State|s|1,pref_city_id|Preferred&nbsp;Name|s|0,exclude_flag|Excluded?|n|0,valid|Valid?|n|1'>
			<cfset caller.keys = 'city_id'>
			<cfset caller.unique = 'city_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'c'>
			<cfset caller.name = 'city_name'>
		</cfcase>

		<cfcase value="city_zip">
			<cfset caller.columns = 'city_id|City|s|1,zipcode|Zip|s|1,postal_city_id|Post&nbsp;Office|s|0,valid|Valid?|n|1'>
			<cfset caller.keys = 'city_id,zipcode'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="county">
			<cfset caller.columns = 'county_id|ID|s|1,county_name|County|s|1,state_id|State|s|1,valid|Valid?|n|1'>
			<cfset caller.keys = 'county_id'>
			<cfset caller.unique = 'county_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'cy'>
			<cfset caller.name = 'county_name'>
		</cfcase>

		<cfcase value="display">
			<cfset caller.columns = 'display_id|ID|n|1,displaygroup_id|Display&nbsp;Group|n|0,display_code|Code|s|1,display_name|Name|s|1,display_desc|Description|s|0,active_flag|Active|n|1'>
			<cfset caller.keys = 'display_id'>
			<cfset caller.unique = 'display_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'd'>
			<cfset caller.name = 'display_name'>
		</cfcase>

		<cfcase value="display_language">
			<cfset caller.columns = 'display_id|Display&nbsp;ID|n|1,language_id|Language&nbsp;ID|s|1,display_text|Text|s|1,update_flag|Needs&nbsp;Update|n|1'>
			<cfset caller.keys = 'display_id,language_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'dl'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="displaygroup">
			<cfset caller.columns = 'displaygroup_id|ID|n|1,displaygroup_code|Code|s|1,displaygroup_name|Name|s|1,displaygroup_desc|Description|s|0'>
			<cfset caller.keys = 'displaygroup_id'>
			<cfset caller.unique = 'displaygroup_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'dg'>
			<cfset caller.name = 'displaygroup_name'>
		</cfcase>

		<cfcase value="entrypoint">
			<cfset caller.columns = 'entrypoint_id|ID|n|1,code|Code|s|1,name|Name|s|1,subname|Subname|s|0,address1|Address&nbsp;Line&nbsp;1|s|0,address2|Address&nbsp;Line&nbsp;2|s|0,address3|Address&nbsp;Line&nbsp;3|s|0,city|City|s|0,state_id|State|s|0,zipcode|Zip|s|0,zipcode_plus4|Plus+4|s|0,email|Email|s|0,url|URL|s|0,hours_display_id|Hours|n|0,info_display_id|Other&nbsp;Info|n|0,contact_title|Contact&nbsp;Title|s|0,contact_first|Contact&nbsp;First&nbsp;Name|s|0,contact_middle|Contact&nbsp;Middle|s|0,contact_last|Contact&nbsp;Last&nbsp;Name|s|0,contact_suffix|Contact&nbsp;Suffix|s|0,privatephone|Private&nbsp;Phone|s|0,last_update|Last&nbsp;Update|s|0,active_flag|Active?|n|1,notes|Internal&nbsp;Notes|s|0,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'entrypoint_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'e'>
			<cfset caller.name = 'name'>
		</cfcase>

		<cfcase value="entrypoint_city">
			<cfset caller.columns = 'entrypoint_id|Entry&nbsp;Point|n|1,city_id|City|s|1'>
			<cfset caller.keys = 'entrypoint_id,city_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'ec'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="entrypoint_county">
			<cfset caller.columns = 'entrypoint_id|Entry&nbsp;Point|n|1,county_id|County|s|1'>
			<cfset caller.keys = 'entrypoint_id,county_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'ey'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="entrypoint_entrypointgroup">
			<cfset caller.columns = 'entrypoint_id|Entry&nbsp;Point|n|1,entrypointgroup_id|Entry&nbsp;Point&nbsp;Group|s|1'>
			<cfset caller.keys = 'entrypoint_id,entrypointgroup_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'epg'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="entrypoint_zip">
			<cfset caller.columns = 'entrypoint_id|Entry&nbsp;Point|n|1,zipcode|Zip&nbsp;Code|s|1'>
			<cfset caller.keys = 'entrypoint_id,zipcode'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'ez'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="entrypointgroup">
			<cfset caller.columns = 'entrypointgroup_id|ID|n|1,name|Name|s|1,state_id|State|s|0,active_flag|Active?|n|1,notes|Internal&nbsp;Notes|s|0'>
			<cfset caller.keys = 'entrypointgroup_id'>
			<cfset caller.unique = 'name'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'eg'>
			<cfset caller.name = 'name'>
		</cfcase>

		<cfcase value="error">
			<cfset caller.columns = 'error_id|ID|n|1,error_code|Code|s|1,display_id|Error&nbsp;Text|n|1,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'error_id'>
			<cfset caller.unique = 'error_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'er'>
			<cfset caller.name = 'error_code'>
		</cfcase>

		<cfcase value="form">
			<cfset caller.columns = 'form_id|ID|n|1,formtag_id|Tag|n|1,form_name|Name|s|1,description|Description|s|0,state_id|State|s|0'>
			<cfset caller.keys = 'form_id'>
			<cfset caller.unique = 'form_name'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'f'>
			<cfset caller.name = 'form_name'>
		</cfcase>

		<cfcase value="form_formtype">
			<cfset caller.columns = 'form_id|Form|n|1,formtype_id|Type|n|1,string|Filename|s|1,active|Active?|n|0,form_date|Rev.&nbsp;Date|s|0,form_day_ignore_flag|Ignore&nbsp;Rev.&nbsp;Day?|n|0,entry_date|Last&nbsp;Update|s|0,entry_day_ignore_flag|Ignore&nbsp;Update&nbsp;Day?|n|0'>
			<cfset caller.keys = 'form_id,formtype_id'>
			<cfset caller.unique = 'string'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'ffy'>
			<cfset caller.name = 'string'>
		</cfcase>

		<cfcase value="format">
			<cfset caller.columns = 'format_id|ID|n|1,format_code|Code|s|1,format_name|Name|s|1,format_desc|Description|s|0'>
			<cfset caller.keys = 'format_id'>
			<cfset caller.unique = 'format_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'fa'>
			<cfset caller.name = 'format_name'>
		</cfcase>

		<cfcase value="formclass">
			<cfset caller.columns = 'formclass_id|ID|n|1,class_code|Code|s|1,class_name|Name|s|1'>
			<cfset caller.keys = 'formclass_id'>
			<cfset caller.unique = 'class_code,class_name'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'fc'>
			<cfset caller.name = 'class_code'>
		</cfcase>

		<cfcase value="formtag">
			<cfset caller.columns = 'formtag_id|ID|n|1,formclass_id|Form&nbsp;Class|n|1,tag_name|Name|s|1'>
			<cfset caller.keys = 'formtag_id'>
			<cfset caller.unique = 'tag_name'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'ft'>
			<cfset caller.name = 'tag_name'>
		</cfcase>

		<cfcase value="formtype">
			<cfset caller.columns = 'formtype_id|ID|n|1,type_code|Code|s|1,type_name|Name|s|1'>
			<cfset caller.keys = 'formtype_id'>
			<cfset caller.unique = 'type_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'fy'>
			<cfset caller.name = 'type_code'>
		</cfcase>

		<cfcase value="funder">
			<cfset caller.columns = 'funder_id|ID|n|1,name|Name|s|1,legacy_code|Legacy&nbsp;ID|n|0'>
			<cfset caller.keys = 'funder_id'>
			<cfset caller.unique = 'name'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'fu'>
			<cfset caller.name = 'name'>
		</cfcase>

		<cfcase value="gridcolumn">
			<cfset caller.columns = 'gridcolumn_id|ID|n|1,code|Code|s|1,display_id|Column&nbsp;Name|n|1,help_id|Definition|n|0,description|Description|s|0,exclude_flag|Exclude?|n|1,sort|Sort|n|1'>
			<cfset caller.keys = 'gridcolumn_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'gc'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="gridrow">
			<cfset caller.columns = 'gridrow_id|ID|n|1,code|Code|s|1,display_id|Row&nbsp;Header|n|1,help_id|Definition|n|0,description|Description|s|0,exclude_flag|Exclude?|n|1,sort|Sort|n|1'>
			<cfset caller.keys = 'gridrow_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'gr'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="gridrow_gridcolumn_answerfield">
			<cfset caller.columns = 'gridrow_id|Grid&nbsp;Row|n|1,gridcolumn_id|Grid&nbsp;Column|n|1,answerfield_id|Answerfield|n|1'>
			<cfset caller.keys = 'gridrow_id,gridcolumn_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'grca'>
		</cfcase>

		<cfcase value="hardrule">
			<cfset caller.columns = 'hardrule_id|ID|n|1,code|Code|s|1'>
			<cfset caller.keys = 'hardrule_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'hr'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="hardrule_answerfield">
			<cfset caller.columns = 'hardrule_id|Hardcoded&nbsp;Rule|n|1,answerfield_id|Answerfield|n|1'>
			<cfset caller.keys = 'hardrule_id,answerfield_id'>
			<cfset caller.unique = 'hardrule_id,answerfield_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'hra'>
		</cfcase>

		<cfcase value="help">
			<cfset caller.columns = 'help_id|ID|n|1,helptype_id|Type|n|1,help_code|Code|s|1,keyword|Keyword|s|0,title_display_id|Title&nbsp;Text|n|0,display_id|Help&nbsp;Text|n|1,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'help_id'>
			<cfset caller.unique = 'help_code,keyword'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'h'>
			<cfset caller.name = 'help_code'>
		</cfcase>

		<cfcase value="helptype">
			<cfset caller.columns = 'helptype_id|ID|n|1,code|Code|s|1,name|Name|s|1,description|Description|s|0'>
			<cfset caller.keys = 'helptype_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'ht'>
			<cfset caller.name = 'name'>
		</cfcase>

		<cfcase value="image">
			<cfset caller.columns = 'image_id|ID|n|1,code|Code|s|1,filename|Filename|s|1,width|Width|n|0,height|Height|n|0,alt_display_id|Alt&nbsp;Text|n|0,description|Description|s|0'>
			<cfset caller.keys = 'image_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'i'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="language">
			<cfset caller.columns = 'language_id|2-Letter&nbsp;Code|s|1,display_id|Language&nbsp;Name|n|1,default_flag|Default|n|1,active|Active|n|1'>
			<cfset caller.keys = 'language_id'>
			<cfset caller.unique = 'language_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'l'>
			<cfset caller.name = 'language_id'>
		</cfcase>

		<cfcase value="option">
			<cfset caller.columns = 'option_id|ID|n|1,option_code|Code|s|1,display_id|Display&nbsp;Text|n|1,include_flag|Always&nbsp;Include?|n|1,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'option_id'>
			<cfset caller.unique = 'option_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'o'>
			<cfset caller.name = 'option_code'>
		</cfcase>

		<cfcase value="option_subset_partner">
			<cfset caller.columns = 'option_id|Option|n|1,subset_id|Subset|n|0,partner_id|Partner|n|0,include_flag|Include?|n|1'>
			<cfset caller.keys = 'option_id,subset_id,partner_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'osp'>
		</cfcase>

		<cfcase value="page">
			<cfset caller.columns = 'page_id|ID|n|1,page_code|Code|s|1,subset_id|Subset|n|0,title_display_id|Title|n|0,display_id|Page&nbsp;Text|n|0,page_desc|Description|s|0,postrecap|After&nbsp;Recap?|n|1,sort|Sort|n|0'>
			<cfset caller.keys = 'page_id'>
			<cfset caller.unique = 'page_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'pg'>
			<cfset caller.name = 'page_code'>
		</cfcase>

		<cfcase value="partnertype">
			<cfset caller.columns = 'partnertype_id|ID|n|1,code|Code|s|1,name|Name|s|1,description|Description|s|0'>
			<cfset caller.keys = 'partnertype_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'pty'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="phone">
			<cfset caller.columns = 'phone_id|ID|n|1,entrypoint_id|Entry&nbsp;Point|n|1,phonetype_id|Type|n|1,number|Number|s|1,sort|Sort|n|1'>
			<cfset caller.keys = 'phone_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = true>
			<cfset caller.tag = 'ph'>
			<cfset caller.name = 'number'>
		</cfcase>

		<cfcase value="phonetype">
			<cfset caller.columns = 'phonetype_id|ID|n|1,code|Code|s|1,display_id|Name|n|1'>
			<cfset caller.keys = 'phonetype_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'phy'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="program">
			<cfset caller.columns = 'program_id|ID|n|1,programcategory_id|Category|n|1,programgroup_id|Group|n|0,state_id|State|s|0,program_code|Code|s|1,name_display_id|Name|n|1,desc_display_id|External&nbsp;Description|n|1,url|URL|s|0,exclude_flag|Exclude?|n|1,significant_flag|Significant?|n|1,active_flag|Active?|n|1,funder_id|Funder|n|0,reference_id|Source&nbsp;Reference|n|0,supersort|Super&nbsp;Sort|n|0,sort|Sort&nbsp;Order|n|1,last_update|Last&nbsp;Update|s|0,notes|Program&nbsp;Notes|s|0,legacy_prg_id|Legacy&nbsp;ID&nbsp;(prg_id)|s|0,legacy_pri_sec|Legacy&nbsp;Prisec&nbsp;(pri_sec)|n|0,create_user_id|Created&nbsp;By|n|1,create_date|Created&nbsp;On|s|1,modify_user_id|Modified&nbsp;By|n|1,modify_date|Modified&nbsp;On|s|1'>
			<cfset caller.keys = 'program_id'>
			<cfset caller.unique = 'program_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'p'>
			<cfset caller.name = 'program_code'>
		</cfcase>

		<cfcase value="program_answerfield">
			<cfset caller.columns = 'program_id|Program|n|1,answerfield_id|Answerfield|n|1,rule_flag|Rule?|n|1'>
			<cfset caller.keys = 'program_id,answerfield_id'>
			<cfset caller.unique = 'program_id,answerfield_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'pa'>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="program_entrypointgroup">
			<cfset caller.columns = 'program_id|Program|n|1,entrypointgroup_id|Entry&nbsp;Point&nbsp;Group|n|1,sort|Sort|n|1'>
			<cfset caller.keys = 'program_id,entrypointgroup_id'>
			<cfset caller.unique = 'program_id,entrypointgroup_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'pe'>
		</cfcase>

		<cfcase value="program_form">
			<cfset caller.columns = 'program_id| |n|1,form_id| |n|1,sort| |n|0,formula| |s|0'>
			<cfset caller.keys = 'program_id,form_id'>
			<cfset caller.unique = 'program_id,form_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'pf'>
		</cfcase>

		<cfcase value="program_parent">
			<cfset caller.columns = 'program_id| |n|1,parent_program_id| |n|1'>
			<cfset caller.keys = 'program_id,parent_program_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="program_proximity">
			<cfset caller.columns = 'program_id|Program|n|1,proximity_id|Proximity|n|1,sort|Sort&nbsp;Order|n|1'>
			<cfset caller.keys = 'program_id,proximity_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="program_requisite">
			<cfset caller.columns = 'program_id|Program|n|1,requisite_id|Requisite&nbsp;Item|n|1,sort|Sort&nbsp;Order|n|1'>
			<cfset caller.keys = 'program_id,requisite_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="program_rule">
			<cfset caller.columns = 'program_id|Program|n|1,rule_id|Rule|n|1,sort|Sort&nbsp;Order|n|1'>
			<cfset caller.keys = 'program_id,rule_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="programcategory">
			<cfset caller.columns = 'programcategory_id|ID|n|1,display_id|Category&nbsp;Name|n|1,code|Code|s|1,description|Description|s|0,legacy_code|Legacy&nbsp;ID|n|0,sort|Sort&nbsp;Order|n|1'>
			<cfset caller.keys = 'programcategory_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'pc'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="programgroup">
			<cfset caller.columns = 'programgroup_id|ID|n|1,code|Code|s|1,display_id|Group&nbsp;Title|n|1,blurb_display_id|Blurb|n|1,description|Description|s|0,sort|Sort&nbsp;Order|n|1'>
			<cfset caller.keys = 'programgroup_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'pgp'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="programtext">
			<cfset caller.columns = 'programtext_id|ID|n|1,rec|Rec|s|0,summary|Summary|s|0,program_id|Program|n|0,type|Type|s|0,benefit|Benefit|n|0,answerfield|Answerfield|s|0,template|Template|s|0,actions|Actions|s|0,sortorder|Sort&nbsp;Order|n|0,Active|Active?|n|0,alt_rec|Alt.&nbsp;Rec|s|0,alt_summary|Alt.&nbsp;Summary|s|0,enrollment_flag|Enrollment&nbsp;Flag|s|0'>
			<cfset caller.keys = 'programtext_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = true>
			<cfset caller.tag = 'pt'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="programvalue">
			<cfset caller.columns = 'programvalue_id|ID|n|1,program_id|Program|n|1,state_id|State|s|0,dollarvalue|Dollar&nbsp;Value|n|1,start_date|Start&nbsp;Date|s|1,end_date|End&nbsp;Date|s|0,rule_text|Rule|s|0'>
			<cfset caller.keys = 'programvalue_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = true>
			<cfset caller.tag = 'pv'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="protocol">
			<cfset caller.columns = 'protocol_id| |n|1,protocol| |s|1'>
			<cfset caller.keys = 'protocol_id'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="proximity">
			<cfset caller.columns = 'proximity_id|ID|n|1,code|Code|s|1,description|Description|s|0'>
			<cfset caller.keys = 'proximity_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'px'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="question">
			<cfset caller.columns = 'question_id|ID|n|1,dep_question_id|Depends&nbsp;On|n|0,question_code|Code|s|1,questioncategory_id|Category|n|1,questionheader_id|Header|n|0,questiontype_id|Type|n|1,display_id|Question&nbsp;Text|n|1,short_display_id|Short&nbsp;Text|n|0,spq_display_id|Alt.&nbsp;SPQ&nbsp;Text|n|0,print_display_id|Alt.&nbsp;Printed&nbsp;Text|n|0,format_id|Format|n|0,rule_id|Rule|n|0,include_flag|Always&nbsp;Ask?|n|1,exclude_flag|Always&nbsp;Omit?|n|1,suppress_qno_flag|Suppress&nbsp;Question&nbsp;No.?|n|1,spq_exclude_flag|Always&nbsp;Omit&nbsp;from&nbsp;SPQ?|n|1,sort|Sort&nbsp;Order|n|1,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'question_id'>
			<cfset caller.unique = 'question_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'q'>
			<cfset caller.name = 'question_code'>
		</cfcase>

		<cfcase value="question_answerfield">
			<cfset caller.columns = 'question_id|Question|n|1,answerfield_id|Answerfield|n|1,state_id|State|s|0,rule_id|Rule|n|0,sort|Sort|n|1'>
			<cfset caller.keys = 'question_id,answerfield_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="question_gridcolumn">
			<cfset caller.columns = 'question_id|Question|n|1,gridcolumn_id|Grid&nbsp;Column|n|1'>
			<cfset caller.keys = 'question_id,gridcolumn_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'qgc'>
		</cfcase>

		<cfcase value="question_gridrow">
			<cfset caller.columns = 'question_id|Question|n|1,gridrow_id|Grid&nbsp;Row|n|1'>
			<cfset caller.keys = 'question_id,gridrow_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'qgr'>
		</cfcase>

		<cfcase value="question_help">
			<cfset caller.columns = 'question_id|Question|n|1,help_id|Help&nbsp;Item|n|1,state_id|State|s|0,rule_id|Rule|n|0,sort|Sort|n|1'>
			<cfset caller.keys = 'question_id,help_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="questioncategory">
			<cfset caller.columns = 'questioncategory_id|ID|n|1,display_id|Category&nbsp;Name|n|1,questioncategory_code|Code|s|1,questioncategory_desc|Description|s|0,sort|Sort&nbsp;Order|n|1'>
			<cfset caller.keys = 'questioncategory_id'>
			<cfset caller.unique = 'questioncategory_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'qc'>
			<cfset caller.name = 'questioncategory_code'>
		</cfcase>

		<cfcase value="questionheader">
			<cfset caller.columns = 'questionheader_id|ID|n|1,code|Code|s|1,display_id|Header&nbsp;Text|n|1,description|Description|s|0'>
			<cfset caller.keys = 'questionheader_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'qh'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="questiontype">
			<cfset caller.columns = 'questiontype_id|ID|n|1,code|Code|s|1,name|Name|s|1,description|Description|s|0'>
			<cfset caller.keys = 'questiontype_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'qt'>
			<cfset caller.name = 'name'>
		</cfcase>

		<cfcase value="quote">
			<cfset caller.columns = 'quote_id|ID|n|1,quote_code|Code|s|1,display_id|Quote&nbsp;Text|n|1,active|Active?|n|1'>
			<cfset caller.keys = 'quote_id'>
			<cfset caller.unique = 'quote_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'qq'>
			<cfset caller.name = 'quote_code'>
		</cfcase>

		<cfcase value="recap">
			<cfset caller.columns = 'recap_id|ID|n|1,recap_code|Code|s|1,display_id|Recap&nbsp;Label|n|0,formula|Formula|s|1,recap_desc|Description|s|0'>
			<cfset caller.keys = 'recap_id'>
			<cfset caller.unique = 'recap_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'rc'>
			<cfset caller.name = 'recap_code'>
		</cfcase>

		<cfcase value="reference">
			<cfset caller.columns = 'reference_id|ID|n|1,name|Name|s|1'>
			<cfset caller.keys = 'reference_id'>
			<cfset caller.unique = 'name'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'rf'>
			<cfset caller.name = 'name'>
		</cfcase>

		<cfcase value="relationship">
			<cfset caller.columns = 'relationship_id| |n|1,name| |s|1,description| |s|0'>
			<cfset caller.keys = 'relationship_id'>
			<cfset caller.tag = 'rp'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="requisite">
			<cfset caller.columns = 'requisite_id|ID|n|1,code|Code|s|1,display_id|Item&nbsp;Name|n|1,def_display_id|Definition|n|0,description|Internal&nbsp;Description|s|0'>
			<cfset caller.keys = 'requisite_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'rq'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="resultpage">
			<cfset caller.columns = 'resultpage_id|ID|n|1,code|Code|s|1,filename|Filename|s|1,display_id|Title|n|1,resultpage_desc|Description|s|0'>
			<cfset caller.keys = 'resultpage_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'rs'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="rule">
			<cfset caller.columns = 'rule_id|ID|n|1,code|Code|s|1,description|Description|s|0,rule_text|Rule|s|1,rx_program_id|Dedicated|n|0,legacy_pri_sec|Legacy&nbsp;Prisec&nbsp;(pri_sec)|n|0'>
			<cfset caller.keys = 'rule_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'r'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="rule_answerfield">
			<cfset caller.columns = 'rule_id|Rule|n|1,answerfield_id|Answerfield|n|1'>
			<cfset caller.keys = 'rule_id,answerfield_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="sitetext">
			<cfset caller.columns = 'sitetext_id|ID|n|1,sitetext_code|Code|s|1,display_id|Site&nbsp;Text|n|1,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'sitetext_id'>
			<cfset caller.unique = 'sitetext_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'sx'>
			<cfset caller.name = 'sitetext_code'>
		</cfcase>

		<cfcase value="source">
			<cfset caller.columns = 'source_id|ID|n|1,source_code|Code|s|1,source_name|Name|s|1'>
			<cfset caller.keys = 'source_id'>
			<cfset caller.unique = 'source_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'src'>
			<cfset caller.name = 'source_code'>
		</cfcase>

		<cfcase value="state">
			<cfset caller.columns = 'state_id|Abbrev.|s|1,state_name|State|s|1,statetype_id|Type|n|1'>
			<cfset caller.keys = 'state_id'>
			<cfset caller.unique = 'state_name'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'st'>
			<cfset caller.name = 'state_name'>
		</cfcase>

		<cfcase value="state_snap">
			<cfset caller.columns = 'state_snap_id|ID|n|0,state_id|State ID|s|1,Year|Year|n|1,snap_seniors|Number&nbsp;of&nbsp;SNAP&nbsp;seniors|n|1'>
			<cfset caller.keys = 'state_snap_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'stsn'>
			<cfset caller.name = 'state_id'>
		</cfcase>


		<cfcase value="statecarrier">
			<cfset caller.columns = 'state_id|State|s|1,name|Name|s|1,star_rating|Star&nbsp;Rating|n|1,isAHN|isAHN|n|0,havePDP|havePDP|n|0,haveMSP|haveMSP|n|0,haveMA|haveMA|n|0,phone_new|Phone&nbsp;New|s|0,phone_existing|Phone&nbsp;Existing|s|0,statecarrier_id|ID|n|0,website|Website|s|0'>
			<cfset caller.keys = 'statecarrier_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sc'>
			<cfset caller.name = 'post_code'>
		</cfcase>


		<cfcase value="statetype">
			<cfset caller.columns = 'statetype_id|ID|n|1,statetype_name|Name|s|1,statetype_desc|Description|s|0'>
			<cfset caller.keys = 'statetype_id'>
			<cfset caller.unique = 'statetype_name'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'stt'>
			<cfset caller.name = 'statetype_name'>
		</cfcase>

		<cfcase value="subset">
			<cfset caller.columns = 'subset_id|ID|n|1,subsettype_id|Type|n|1,code|Code|s|1,description|Internal&nbsp;Description|s|0,display_id|Name|n|1,alt_display_id|Display&nbsp;Name|n|0,spq_display_id|Alternate&nbsp;Q''aire&nbsp;Name|n|0,oe_name|Alternate&nbsp;OE&nbsp;Name|s|0,intro_display_id|Display&nbsp;Description|n|0,resultpage_id|Result&nbsp;Page|n|0,shadow_subset_id|Shadow&nbsp;Subset|n|0,branding_partner_id|Branding&nbsp;Override|n|0,active_flag|Active?|n|1,test_flag|Test&nbsp;Only?|n|1,eform_flag|Eforms?|n|1,report_flag|Include&nbsp;in&nbsp;Reports?|n|1,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'subset_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 's'>
			<cfset caller.name = 'code'>
		</cfcase>

		<cfcase value="subset_answerfield">
			<cfset caller.columns = 'subset_id|Subset|n|1,answerfield_id|Answerfield|n|1,required|Required?|n|1,recap_id|Recap?|n|1,preset_value|Preset&nbsp;Value|s|0'>
			<cfset caller.keys = 'subset_id,answerfield_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sa'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="subset_content">
			<cfset caller.columns = 'subset_id|Subset|n|1,post_code|Post&nbsp;Code|s|1,sort_order|Sort&nbsp;Order|n|1,section_code|Section&nbsp;Code|s|1,programcategory_id|Program&nbsp;Category&nbsp;ID|n|0'>
			<cfset caller.keys = 'subset_id,post_code,section_code'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sc'>
			<cfset caller.name = 'post_code'>
		</cfcase>



		<cfcase value="subset_gridrow">
			<cfset caller.columns = 'subset_id|Subset|n|1,gridrow_id|Grid&nbsp;Row|n|1,exclude_flag|Exclude?|n|1'>
			<cfset caller.keys = 'subset_id,gridrow_id'>
			<cfset caller.unique = 'subset_id,gridrow_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sg'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="subset_partner">
			<cfset caller.columns = 'subset_id|Subset|n|1,partner_id|Partner|n|1,resultpage_id|Result&nbsp;Page|n|0'>
			<cfset caller.keys = 'subset_id,partner_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sp'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="subset_partner_shadow">
			<cfset caller.columns = 'subset_id|Subset|n|1,partner_id|Partner|n|1,shadow_subset_id|Shadow&nbsp;Subset|n|1'>
			<cfset caller.keys = 'subset_id,partner_id'>
			<cfset caller.unique = ''>
			<cfset caller.identity = false>
			<cfset caller.tag = 'spw'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="subset_program">
			<cfset caller.columns = 'subset_id|Subset|n|1,program_id|Program|n|1,exclude_flag|Exclude?|n|1'>
			<cfset caller.keys = 'subset_id,program_id'>
			<cfset caller.unique = 'subset_id,program_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'spr'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="subset_program_base">
			<cfset caller.columns = 'subset_id| |n|1,program_id| |n|1'>
			<cfset caller.keys = 'subset_id,program_id'>
			<cfset caller.unique = 'subset_id,program_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'spb'>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="subset_program_sum">
			<cfset caller.columns = 'subset_id| |n|1,program_id| |n|1'>
			<cfset caller.keys = 'subset_id,program_id'>
			<cfset caller.unique = 'subset_id,program_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sps'>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="subset_programcategory">
			<cfset caller.columns = 'subset_id|Subset|n|1,programcategory_id|Category|n|1,exclude_flag|Exclude?|n|1'>
			<cfset caller.keys = 'subset_id,programcategory_id'>
			<cfset caller.unique = 'subset_id,programcategory_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sprc'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="subset_question">
			<cfset caller.columns = 'subset_id|Subset|n|1,question_id|Question|n|1,page_id|Page|n|0,sort|Sort&nbsp;Order|n|0,required_flag|Required?|n|1,exclude_flag|Exclude?|n|1,options_flag|Options?|n|1'>
			<cfset caller.keys = 'subset_id,question_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'sq'>
		</cfcase>

		<cfcase value="subset_requisite">
			<cfset caller.columns = 'subset_id|Subset|n|1,requisite_id|Requisite&nbsp;Item|n|1,sort|Sort&nbsp;Order|n|1'>
			<cfset caller.keys = 'subset_id,requisite_id'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="subsettype">
			<cfset caller.columns = 'subsettype_id|ID|n|1,subsettype_name|Name|s|1,subsettype_description|Description|s|0'>
			<cfset caller.keys = 'subsettype_id'>
			<cfset caller.unique = 'subsettype_name'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'sty'>
			<cfset caller.name = 'subsettype_name'>
		</cfcase>

		<cfcase value="tbl_answerfield_list">
			<cfset caller.columns = 'answerfield| |s|1,RecID| |n|1,answerfieldtype_id| |n|0'>
			<cfset caller.keys = 'RecID'>
			<cfset caller.identity = true>
		</cfcase>

	    <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_entry, tbl_entry_grp, tbl_funding_list which are being archived 
		<cfcase value="tbl_entry">
			<cfset caller.columns = 'group_id|Group|n|0,org_name|Name|s|0,org_name2|Name&nbsp;2|s|0,address|Address|s|0,address1|Address&nbsp;1|s|0,address2|Address&nbsp;2|s|0,city|City|s|0,st|State|s|0,zip|Zip|s|0,county|County|s|0,counties_served|Counties&nbsp;Served|s|0,cities_served|Cities&nbsp;Served|s|0,zips_served|Zips&nbsp;Served|s|0,phone_no|Phone|s|0,fax|Fax|s|0,email|Email|s|0,web_site|URL|s|0,hours|Hours|s|0,contact_title|Contact&nbsp;Title|s|0,private_ph|Private&nbsp;Phone|s|0,contact_frstnm|Contact&nbsp;First&nbsp;Name|s|0,contact_lstnm|Contact&nbsp;Last&nbsp;Name|s|0,added_by|Added&nbsp;By|s|0,added_dt|Added&nbsp;At|s|0,mod_by|Modified&nbsp;By|s|0,mod_dt|Modified&nbsp;At|s|0,org_id|Org&nbsp;ID|n|1,RecID|ID|n|1'>
			<cfset caller.keys = 'RecID'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'tble'>
			<cfset caller.name = ''>
		</cfcase>

		<cfcase value="tbl_entry_grp">
			<cfset caller.columns = 'group_name|Name|s|0,group_id|Group&nbsp;ID|n|0,RecID|ID|n|1,mod_dt|Modified&nbsp;At|s|0'>
			<cfset caller.keys = 'group_id'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'tbleg'>
			<cfset caller.name = 'group_name'>
		</cfcase>

		<cfcase value="tbl_funding_list">
			<cfset caller.columns = 'funding_type| |s|0,id_number| |s|0,added_by| |s|0,added_dt| |s|0,mod_by| |s|0,mod_dt| |s|0,RecID| |n|1'>
			<cfset caller.keys = 'RecID'>
			<cfset caller.identity = true>
		</cfcase>--->

		<cfcase value="tbl_generic">
			<cfset caller.columns = 'generic_id|ID|n|1,generic_name|Name|s|1'>
			<cfset caller.keys = 'generic_id'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="tbl_inc_new">
			<cfset caller.columns = 'tbl_nm| |s|0,mem1| |s|0,mem2| |s|0,mem3| |s|0,mem4| |s|0,mem5| |s|0,mem6| |s|0,mem7| |s|0,mem8| |s|0,st| |s|0,county| |s|0,moddate| |s|0,tbl_id| |n|1,proc_id| |n|0'>
			<cfset caller.keys = 'tbl_id'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="tbl_major_cat_list">
			<cfset caller.columns = 'major_cat|Name|s|0,code|Code|s|1,id_number|Code&nbsp;No.|n|0,added_by| |s|0,added_dt| |s|0,mod_by| |s|0,mod_dt| |s|0,RecID|ID|n|1,Sort_order|Sort|n|0'>
			<cfset caller.keys = 'RecID'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="tbl_mx_asset">
			<cfset caller.columns = 'tbl_id|ID|n|1,tbl_nm|Name|s|0,st|State|s|0,single|Single|n|0,couple|Couple|n|0'>
			<cfset caller.keys = 'tbl_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'mxa'>
			<cfset caller.name = 'tbl_nm'>
		</cfcase>

		<cfcase value="tbl_mx_income">
			<cfset caller.columns = 'tbl_id|ID|n|1,tbl_nm|Name|s|0,st|State|s|0,single_max|Single&nbsp;Max|n|0,single_min| Single&nbsp;Min|n|0,couple_max|Couple&nbsp;Max|n|0,couple_min|Couple&nbsp;Min|n|0'>
			<cfset caller.keys = 'tbl_id'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'mxi'>
			<cfset caller.name = 'tbl_nm'>
		</cfcase>

		<cfcase value="tbl_opt">
			<cfset caller.columns = 'option_nm| |s|0,field_nm| |s|0,fieldtext| |s|0,validation| |s|0,opt_type| |s|0,opt_id| |n|1,sort_id| |n|0'>
			<cfset caller.keys = 'opt_id'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="tbl_partner">
			<cfset caller.columns = 'partner_id|ID|n|1,partner_code|Code|s|1,partner_name|Name|s|1,partner_url|URL|s|0,alt_name|Alternate&nbsp;Name|s|0,partnertype_id|Type|n|1,bcu_display_id|Site&nbsp;Name&nbsp;Override|n|0,partner_wrapper|Wrapper&nbsp;File|s|0,partner_header|Header?|s|0,partner_footer|Footer?|s|0,partner_css|CSS File|s|0,partner_titlebar|Title&nbsp;Bar|s|0,wrapper_id|Wrapper|n|0,cms_doc_no|CMS&nbsp;Document&nbsp;No.|s|0,login_only_flag|Login&nbsp;Only?|n|1,report_flag|Include&nbsp;in&nbsp;Reports?|n|1,learn_flag|Learn?|n|1,race_flag|Race?|n|1,hispanic_flag|Hispanic?|n|1,links_flag|Prepop&nbsp;links?|n|1,pdf_logo_flag|PDF&nbsp;logo?|n|1,demo|Demo?|n|0,parent|Parent ID?|n|0,notes|Notes|s|0'>
			<cfset caller.keys = 'partner_id'>
			<cfset caller.unique = 'partner_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'pr'>
			<cfset caller.name = 'partner_code'>
		</cfcase>

		<cfcase value="tbl_prg_all">
			<cfset caller.columns = "prg_id|prgID|s|0,code|Code|s|0,order_num|Sort|n|0,pri_sec|PriSec|n|0,prg_nm|Name|s|0,prg_desc|Description|s|0,st|State|s|0,proximity| |s|0,firstproximity| |s|0,comment| |s|0,added_dt| |s|0,added_by| |s|0,mod_by| |s|0,mod_dt| |s|0,id| |n|0,include| |n|1,source| |s|0,dollar_amount| |n|1,RecID|ID|n|1,Cat_ID|Category|n|0,exclude_flag|Exclude?|n|1,inactive_flag|Inactive?|n|0,significant_flag|Significant?|n|0,childrens_flag|Children's?|n|0">
			<cfset caller.keys = 'prg_id'>
			<cfset caller.unique = 'code'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'tblprg'>
			<cfset caller.name = 'code'>
			<cfset caller.view = true>
		</cfcase>

	    <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_prg_entry which is being archived
		<cfcase value="tbl_prg_entry">
			<cfset caller.columns = 'group_id| |n|0,org_id| |n|0,prg_id| |s|0,added_by| |s|0,added_dt| |s|0,RecID| |n|1'>
			<cfset caller.keys = 'RecID'>
			<cfset caller.identity = true>
		</cfcase>--->

		<cfcase value="tbl_questions_new">
			<cfset caller.columns = 'question_id|ID|n|1,answerfield| |s|0,category| |s|0,order_num| |s|0,pri_sec| |s|0,question| |s|0,type| |s|0,validation| |s|0,client| |s|0,textlength| |n|0,dep_field| |s|0,dep_op| |s|0,dep_criteria| |s|0,dep_formula| |s|0'>
			<cfset caller.keys = 'question_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		 <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_req_mat, tbl_req_mat_list which are being archived
    <cfcase value="tbl_req_mat">
			<cfset caller.columns = 'prg_id| |s|0,req_mat| |s|0,added_by| |s|0,added_dt| |s|0,mod_by| |s|0,mod_dt| |s|0,mat_id| |s|0,req_id| |n|1'>
			<cfset caller.keys = 'req_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="tbl_req_mat_list">
			<cfset caller.columns = 'code|Code|s|0,req_mat|Requisite|s|0,added_by|Adder|s|0,added_dt|On|s|0,mod_by|Modified|s|0,mod_dt|On|s|0,mat_id|ID|n|1,definition|Definition|s|0'>
			<cfset caller.keys = 'mat_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>--->

		<cfcase value="tbl_rules">
			<cfset caller.columns = 'prg_id| |s|1,elig_rule| |s|1,RecID| |n|1,pri_sec| |s|0'>
			<cfset caller.keys = 'RecID'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="tbl_RX_Detail">
			<cfset caller.columns = 'RXDetail_ID| |n|1,answerfield_id| |n|1,Opt_ID| |n|0,MFR_ID| |n|0,Price| |n|0,PriceRating| |n|0'>
			<cfset caller.keys = 'RXDetail_ID'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="tbl_RX_MFR">
			<cfset caller.columns = 'MFR_ID|ID|n|1,MFR_Name| |s|0,Discount_Amount| |n|0'>
			<cfset caller.keys = 'MFR_ID'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="tbl_RX_PrgDetail">
			<cfset caller.columns = 'RXPrg_ID| |n|1,PRG_ID| |s|0,DNumber| |s|0,StateList| |s|0,CardName| |s|0,SponsorName| |s|0,Address| |s|0,LocatorEnable| |n|0,CMSEnable| |n|0'>
			<cfset caller.keys = 'RXPrg_ID'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="tbl_RX_Scenarios">
			<cfset caller.columns = 'State| |s|0,Template_name| |s|0,Scenario| |s|0,SortOrder| |n|0,Display_level| |n|0,Program| |s|0,RxScenario_ID| |n|1'>
			<cfset caller.keys = 'RxScenario_ID'>
			<cfset caller.identity = true>
		</cfcase>
		<!--- MH: 5/12/10 Removed reference to tbl_snap since table is being archived on BCUQA
		<cfcase value="tbl_snap">
			<cfset caller.columns = 'id|ID|n|1,snap_state|State|s|1,snap_url|URL|s|0,snap_online_app|Online&nbsp;Application|s|0,snap_program_names|Program&nbsp;Names|s|0'>
			<cfset caller.keys = 'id'>
			<cfset caller.identity = true>
			<cfset caller.tag = 't'>			
			<cfset caller.name = 'tbl_snap'>
		</cfcase>--->	


		<cfcase value="tbl_st">
			<cfset caller.columns = 'st| |s|1,include| |s|1'>
			<cfset caller.keys = 'st'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="tbl_zip">
			<cfset caller.columns = 'ID|ID|n|1,Detail| |s|0,Zip| |s|0,CountofCity| |n|0,CityStName| |s|0,LastLineCity| |s|0,State| |s|0,County| |s|0,Lat_degree| |n|0,Lon_degree| |n|0,Lat| |n|0,Lon| |n|0,AreaCode| |s|0,TimeZone| |s|0,H| |n|0,V| |n|0,FromCensus| |n|1'>
			<cfset caller.keys = 'ID'>
			<cfset caller.identity = false>
		</cfcase>

		<cfcase value="tblCookCountyCities">
			<cfset caller.columns = 'RecID|ID|n|1,Zip| |n|0,PostalCity| |s|0'>
			<cfset caller.keys = 'RecID'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="template">
			<cfset caller.columns = 'template_id|ID|n|1,filename|Path&nbsp;and&nbsp;filename|s|1,name|Name|s|0,canonical_flag|Canonical?|n|1,source_flag|source_id?|n|1,prev_flag|prev_id?|n|1,org_flag|org_id?|n|1,partner_flag|partner_id?|n|1,subset_flag|subset_id?|n|1,language_flag|language_id?|n|1,access_flag|access_id?|n|1,client_flag|client_id?|n|1,user_flag|user_id?|n|1,state_flag|state_id?|n|1,test_flag|test_id?|n|1,description|Description|s|0'>
			<cfset caller.keys = 'template_id'>
			<cfset caller.unique = 'filename'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'tm'>
			<cfset caller.name = 'filename'>
		</cfcase>

		<cfcase value="url">
			<cfset caller.columns = 'url_id|ID|n|1,protocol_id|Protocol|n|0,url|URL|s|1,url_code|Code|s|1,url_description|Description|s|0,link_text|Link&nbsp;Text|s|0,target_flag|Target?|n|1,active_flag|Active|n|1'>
			<cfset caller.keys = 'url_id'>
			<cfset caller.unique = 'url_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'ur'>
			<cfset caller.name = 'url_code'>
		</cfcase>

		<cfcase value="user">
			<cfset caller.columns = 'user_id|ID|n|1,usertype_id|Level|n|1,username|Username|s|1,password|Password|s|1,firstname|First&nbsp;Name|s|1,lastname|Last&nbsp;Name|s|1,email|Email&nbsp;Address|s|1,active|Active|n|1,last_login_date|Last&nbsp;Login|s|0,create_user_id|Creator|n|1,create_date|Created|s|1,modify_user_id|Modifier|n|1,modify_date|Last&nbsp;Modified|s|1'>
			<cfset caller.keys = 'user_id'>
			<cfset caller.unique = 'username'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'u'>
			<cfset caller.name = 'username'>
		</cfcase>

		<cfcase value="usertype">
			<cfset caller.columns = 'usertype_id|ID|n|1,usertype_code|Code|s|1,usertype_name|Name|s|1,usertype_desc|Description|s|0'>
			<cfset caller.keys = 'usertype_id'>
			<cfset caller.unique = 'usertype_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'ut'>
			<cfset caller.name = 'usertype_name'>
		</cfcase>

		<cfcase value="validation">
			<cfset caller.columns = 'validation_id|ID|n|1,validation_code|Code|s|1,formula|Formula|s|1,display_id|Error&nbsp;Text|n|1,validation_desc|Description|s|0'>
			<cfset caller.keys = 'validation_id'>
			<cfset caller.unique = 'validation_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'v'>
			<cfset caller.name = 'validation_code'>
		</cfcase>
		
		<cfcase value="wrapper">
			<cfset caller.columns = 'wrapper_id|ID|n|1,wrapper_partner_id|Partner|n|0,wrapper_type|Type|n|0,wrapper_code|Code|s|1,wrapper_description|Description|s|0,wrapper_index|Index|s|0,wrapper_template|Template|s|1,wrapper_css|Style&nbsp;Sheet|s|1,wrapper_menu_css|Menu&nbsp;Style&nbsp;Sheet|s|0,wrapper_header|Header|s|0,wrapper_footer|Footer|s|0,wrapper_left_col|Left?|s|0,wrapper_right_col|Right?|s|0,wrapper_cover_image|Cover&nbsp;Image|s|0,wrapper_logo|Logo|s|0,wrapper_logo_alt_text|Logo&nbsp;Alt&nbsp;Text|s|0,wrapper_logo_link|Logo&nbsp;Link|s|0,wrapper_title|Title|s|0,wrapper_link|Link|s|0,wrapper_custom_subset|Custom&nbsp;Subset|n|0,wrapper_custom_title|Custom&nbsp;Title|s|0,wrapper_custom_time|Custom&nbsp;Time|s|0,wrapper_comprehensive|Comp?|n|0,wrapper_pda|PDA?|n|0,wrapper_rx|Rx?|n|0,wrapper_disaster|Disaster?|n|0,wrapper_pap|PAP?|n|0,wrapper_more_programs|More&nbsp;Programs|s|0,wrapper_moreprograms_template|More&nbsp;Template|s|0,wrapper_afc|AFC|s|0,wrapper_external|External?|n|0,wrapper_external_title|External&nbsp;Title|s|0,wrapper_external_title_graphic|External&nbsp;Title&nbsp;Graphic|s|0,wrapper_external_text|External&nbsp;Text|s|0,wrapper_external_time|External&nbsp;Time|s|0,wrapper_external_link|External&nbsp;Link|s|0,wrapper_optional_box_text|Optional&nbsp;Box&nbsp;Text|s|0,wrapper_status|Status|n|0,wrapper_deployment_status|Deployment&nbsp;Status|n|0,wrapper_get_started_now|Get&nbsp;Started&nbsp;Now|s|0,wrapper_bcu_logo|BCU&nbsp;Logo|s|0,wrapper_bcu_logo_alt_text|BCU&nbsp;Logo&nbsp;Alt.&nbsp;Text|s|0,wrapper_bcu_link|BCU&nbsp;Link|s|0,wrapper_checksum|Checksum|s|0,wrapper_changes|Changes|s|0,wrapper_logo_margin_top|Logo&nbsp;Margin&nbsp;Top|n|0,wrapper_logo_margin_right|Logo&nbsp;Margin&nbsp;Right|n|0,wrapper_menu|Menu|n|0,wrapper_top_menu|Top&nbsp;Menu|s|0,wrapper_footer_custom|Footer&nbsp;Custom|s|0,wrapper_printed_text|Printed&nbsp;Text|s|0,wrapper_menu_ie_css|Menu&nbsp;IE&nbsp;CSS|s|0,wrapper_additional_css|Additional&nbsp;CSS|s|0,wrapper_special_link|Special&nbsp;Link|s|0,wrapper_special_text|Special&nbsp;Text|s|0,wrapper_special|Special?|n|0,wrapper_tag1|Tag&nbsp;1|s|0,wrapper_tag2|Tag&nbsp;2|s|0,wrapper_tag3|Tag&nbsp;3|s|0,wrapper_custom_js|Custom&nbsp;JavaScript|s|0,wrapper_lis_link_direct|Skip&nbsp;LIS&nbsp;Intro?|n|0'>
			<cfset caller.keys = 'wrapper_id'>
			<cfset caller.unique = 'wrapper_code'>
			<cfset caller.identity = true>
			<cfset caller.tag = 'w'>
			<cfset caller.name = 'wrapper_code'>
		</cfcase>
		
		<cfcase value="xassettype">
			<cfset caller.columns = 'assettype_id| |n|1,assettype_name| |s|1,assettype_varname| |s|1,sort| |n|1,definition| |s|0,exclude_flag|Exclude?|n|1'>
			<cfset caller.keys = 'assettype_id'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="xincass">
			<cfset caller.columns = 'incass_id| |n|1,incass_name| |s|1,incass_varname| |s|1,self_single_text| |s|1,self_married_text| |s|1,other_single_text| |s|1,other_married_text| |s|1,exclude| |s|0,work_flag| |n|0,sort| |n|1'>
			<cfset caller.keys = 'incass_id'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="xincometype">
			<cfset caller.columns = 'incometype_id| |n|1,incometype_name| |s|1,incometype_varname| |s|1,sort| |n|1,definition| |s|0,exclude_flag|Exclude?|n|1'>
			<cfset caller.keys = 'incometype_id'>
			<cfset caller.identity = true>
		</cfcase>

		<cfcase value="xsubset">
			<cfset caller.columns = 'subset_id| |n|1,subsettype_id| |n|1,subset_name| |s|1,subset_longname| |s|0,subset_description| |s|0,subset_text| |s|0,qaire_name|Q''aire&nbsp;Name|s|0,alt_name|Alternate&nbsp;Name|s|0,all_flag| |n|0,drug_flag| |n|0,grid_flag| |n|0,optional_flag| |n|0,rec_flag| |n|0,eform_flag| |n|0,schip_flag| |n|0,state_flag| |n|0,report_flag|Include&nbsp;in&nbsp;Reports?|n|1'>
			<cfset caller.keys = 'subset_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="xsubset_answerfield">
			<cfset caller.columns = 'subset_id| |n|1,answerfield_id| |n|1,value| |s|1'>
			<cfset caller.keys = 'subset_id,answerfield_id'>
			<cfset caller.identity = false>
		</cfcase>

		<!--- MH: 5/12/10 Removed reference to xsubset_category since it is being archived on BCUQA 
        <cfcase value="xsubset_category">
			<cfset caller.columns = 'subset_id| |n|1,category_id| |n|1,exclude_flag| |n|0'>
			<cfset caller.keys = 'subset_id,category_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>--->
		<cfcase value="xsubset_program">
			<cfset caller.columns = 'subset_id| |n|1,program_id| |n|1,exclude_flag| |n|0'>
			<cfset caller.keys = 'subset_id,program_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="xsubset_xassettype">
			<cfset caller.columns = 'subset_id| |n|1,assettype_id| |n|1'>
			<cfset caller.keys = 'subset_id,assettype_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="xsubset_xincass">
			<cfset caller.columns = 'subset_id| |n|1,incass_id| |n|1'>
			<cfset caller.keys = 'subset_id,incass_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="xsubset_xincometype">
			<cfset caller.columns = 'subset_id| |n|1,incometype_id| |n|1'>
			<cfset caller.keys = 'subset_id,incometype_id'>
			<cfset caller.identity = false>
			<cfset caller.view = true>
		</cfcase>

		<cfcase value="zip">
			<cfset caller.columns = 'zipcode|Zip&nbsp;Code|s|1,state_id|State|s|1,county_id|County|s|0,latitude|Latitude|n|0,longitude|Longitude|n|0,valid|Valid?|n|1'>
			<cfset caller.keys = 'zipcode'>
			<cfset caller.unique = 'zipcode'>
			<cfset caller.identity = false>
			<cfset caller.tag = 'z'>
			<cfset caller.name = 'zipcode'>
		</cfcase>
		
		<cfdefaultcase>
			<cf_viewLoad view="#attributes.table#">
			<cfset caller.columns = columns>
			<cfset caller.keys = keys>
			<cfset caller.unique = unique>
			<cfset caller.identity = identity>
			<cfset caller.tag = tag>
			<cfset caller.name = name>
			<cfset caller.view = view>
		</cfdefaultcase>

	</cfswitch>

</cfif>
</cfsilent>
