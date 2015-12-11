<!---
	Template Name: LanguageEntity
	Component Purpose: Component mapped to database table language via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: language

--->

<cfcomponent persistent="true" entityname="language" table="language">
    <cfproperty name="id" fieldtype="id" column="language_id">
    <cfproperty name="default_flag">
    <cfproperty name="active">
    <cffunction name="getDefault">
        <cfreturn entityload("language",{default_flag=1, active=1},"true")>
    </cffunction>
    <cffunction name="getCurrentLanguage">
        <cfreturn this.getDefault()>
    </cffunction>
</cfcomponent>