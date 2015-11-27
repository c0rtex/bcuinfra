<cfcomponent persistent="true" entityname="question_header" table="questionheader">
	<cfproperty name="id" fieldtype="id" column="questionheader_id">
	<cfproperty name="code">
	<cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
	<cfproperty name="question_category" fieldtype="many-to-one" fkcolumn="questioncategory_id" cfc="question_category">
	<cfproperty name="description">
</cfcomponent>