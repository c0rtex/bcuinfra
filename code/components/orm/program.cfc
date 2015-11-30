<cfcomponent persistent="true" entityname="program" table="program">
	<cfproperty name="id" fieldtype="id" column="program_id">
	<cfproperty name="program_category" fieldtype="many-to-one" fkcolumn="programcategory_id" cfc="program_category">
	<cfproperty name="program_group" fieldtype="many-to-one" fkcolumn="programgroup_id" cfc="program_group">
	<cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
	<cfproperty name="code" column="program_code">
	<cfproperty name="name_display" fieldtype="many-to-one" fkcolumn="name_display_id" cfc="display">
	<cfproperty name="desc_display" fieldtype="many-to-one" fkcolumn="desc_display_id" cfc="display">
	<cfproperty name="url">
	<cfproperty name="exclude_flag">
	<cfproperty name="significant_flag">
	<cfproperty name="active_flag">
	<cfproperty name="funder" fieldtype="many-to-one" fkcolumn="funder_id" cfc="funder">
	<cfproperty name="reference" fieldtype="many-to-one" fkcolumn="reference_id" cfc="reference">
	<cfproperty name="last_update">
	<cfproperty name="notes">
	<cfproperty name="supersort">
	<cfproperty name="sort">
	<cfproperty name="legacy_prg_id">
	<cfproperty name="legacy_pri_sec">
</cfcomponent>