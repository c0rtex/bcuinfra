<!---
	Template Name: UserTypeEntity
	Component Purpose: Component mapped to database table usertype via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: usertype

--->

<cfcomponent persistent="true" entityname="user_type" table="usertype">
	<cfproperty name="id" fieldtype="id" column="usertype_id">
	<cfproperty name="code" column="usertype_code">
	<cfproperty name="name" column="usertype_name">
	<cfproperty name="description" column="usertype_desc">
</cfcomponent>