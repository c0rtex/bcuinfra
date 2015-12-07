<cfcomponent persistent="true" entityname="program_group" table="programgroup">
	<cfproperty name="id" fieldtype="id" column="programgroup_id">
	<cfproperty name="code">
	<cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
	<cfproperty name="blurb_display" fieldtype="many-to-one" fkcolumn="blurb_display_id" cfc="display">
	<cfproperty name="description">
	<cfproperty name="sort">
</cfcomponent>