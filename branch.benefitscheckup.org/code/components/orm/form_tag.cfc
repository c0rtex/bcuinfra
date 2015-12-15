<cfcomponent persistent="true" entityname="form_tag" table="formtag">
    <cfproperty name="id" fieldtype="id" column="formtag_id">
    <cfproperty name="form_class" fieldtype="many-to-one" fkcolumn="formclass_id" cfc="form_class">
    <cfproperty name="name" column="tag_name">
</cfcomponent>