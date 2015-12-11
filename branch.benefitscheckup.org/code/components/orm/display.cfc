<!---
	Template Name: DisplayEntity
	Component Purpose: Component mapped to database table display via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: display

--->

<cfcomponent persistent="true" entityname="display" table="display">
	<cfproperty name="id" fieldtype="id" column="display_id">
	<cfproperty name="code" column="display_code">
	<cfproperty name="display_text" persistent="false" getter="true">

<!---
	Method returns display text at language set in session
--->

	<cffunction name="getDisplay_text">
        <cfset displ=ORMExecuteQuery("from display_language where display_id=:display_id and language_id=:language_id", {display_id=this.getId(), language_id=session.language.getId()})>
		<cfreturn displ[1].getDisplay_text()>
	</cffunction>
</cfcomponent>