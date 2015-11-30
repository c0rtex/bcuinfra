<cfcomponent persistent="true" entityname="state" table="state">
	<cfproperty name="id" fieldtype="id" column="state_id">
	<cfproperty name="state_type" fieldtype="many-to-one" fkcolumn="statetype_id" cfc="state_type">
	<cfproperty name="name" column="state_name">
	<cfproperty name="map_code" column="state_map_code">
	<cfproperty name="map_code_2" column="state_map_code2">
</cfcomponent>