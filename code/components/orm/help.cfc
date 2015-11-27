<cfcomponent persistent="true" entityname="help" table="help">
    <cfproperty name="id" fieldtype="id" column="help_id">
    <cfproperty name="type" fieldtype="many-to-one" fkcolumn="helptype_id" cfc="help_type">
    <cfproperty name="code" column="help_code">
    <cfproperty name="keyword">
    <cfproperty name="title_display" fieldtype="many-to-one" fkcolumn="title_display_id" cfc="display">
    <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
</cfcomponent>