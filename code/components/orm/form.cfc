<cfcomponent persistent="true" entityname="form" table="form">
    <cfproperty name="id" fieldtype="id" column="form_id">
    <cfproperty name="form_tag" fieldtype="many-to-one" fkcolumn="formtag_id" cfc="form_tag">
    <cfproperty name="name" column="form_name">
    <cfproperty name="description">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
</cfcomponent>