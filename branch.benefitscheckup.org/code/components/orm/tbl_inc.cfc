<!---
	Template Name: tbl_inc
	Component Purpose: Component mapped to database table tbl_inc via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: tbl_inc

--->

<cfcomponent persistent="true" entityname="tbl_inc" table="tbl_inc_new" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="tbl_id">
	<cfproperty name="proc_id">
    <cfproperty name="moddate">
	<cfproperty name="county">
	<cfproperty name="state" column="st">
	<cfproperty name="tbl_nm">
	<cfproperty name="mem1">
	<cfproperty name="mem2">
	<cfproperty name="mem3">
	<cfproperty name="mem4">
	<cfproperty name="mem5">
	<cfproperty name="mem6">
	<cfproperty name="mem7">
	<cfproperty name="mem8">
</cfcomponent>
