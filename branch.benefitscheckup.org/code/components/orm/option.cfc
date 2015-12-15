<cfcomponent persistent="true" entityname="option" table="option">
    <cfproperty name="id" fieldtype="id" column="option_id">
    <cfproperty name="code" column="option_code">
    <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
    <cfproperty name="include_flag">
</cfcomponent>