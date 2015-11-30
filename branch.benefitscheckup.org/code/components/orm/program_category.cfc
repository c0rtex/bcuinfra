<cfcomponent persistent="true" entityname="program_category" table="programcategory">
	<cfproperty name="id" fieldtype="id" column="programcategory_id">
	<cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
	<cfproperty name="code">
	<cfproperty name="description">
	<cfproperty name="legacy_code">
	<cfproperty name="sort">
</cfcomponent>