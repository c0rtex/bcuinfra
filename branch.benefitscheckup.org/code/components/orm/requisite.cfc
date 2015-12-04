<cfcomponent persistent="true" entityname="requisite" table="requisite">
    <cfproperty name="id" fkcolumn="id" column="requisite_id">
    <cfproperty name="code">
    <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
    <cfproperty name="def_display" fieldtype="many-to-one" fkcolumn="def_display_id" cfc="display">
    <cfproperty name="description">
</cfcomponent>