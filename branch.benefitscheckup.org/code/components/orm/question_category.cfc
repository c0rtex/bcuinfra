<cfcomponent persistent="true" entityname="question_category" table="questioncategory">
	<cfproperty name="id" fieldtype="id" column="questioncategory_id">
	<cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
	<cfproperty name="code" column="questioncategory_code">
	<cfproperty name="description" column="questioncategory_desc">
	<cfproperty name="sort">
	<cfproperty name="alt" column="alt_title">
</cfcomponent>