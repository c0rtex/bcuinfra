<!---
	Template Name: TblPrgAllEntity
	Component Purpose: Component mapped to database table subset_program via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: tbl_prg_all

!--->

<cfcomponent persistent="true" entityname="tbl_prg_all" table="tbl_prg_all" extends="ToStructConverter">
    <cfproperty name="rec_id" column="RecId" fieldtype="id">
    <cfproperty name="code">
    <cfproperty name="prg_id">
    <cfproperty name="order_num">
    <cfproperty name="pri_sec">
    <cfproperty name="prg_nm">
    <cfproperty name="prg_desc">
    <cfproperty name="st">
    <cfproperty name="proximity">
    <cfproperty name="first_proximity" column="firstproximity">
    <cfproperty name="comment">
    <cfproperty name="added_dt">
    <cfproperty name="added_by">
    <cfproperty name="mod_by">
    <cfproperty name="mod_dt">
    <cfproperty name="id">
    <cfproperty name="include">
    <cfproperty name="source">
    <cfproperty name="dollar_amount">
    <cfproperty name="cat_id">
    <cfproperty name="exclude_flag">
    <cfproperty name="inactive_flag">
    <cfproperty name="significant_flag">
    <cfproperty name="childrens_flag">
    <cfproperty name="program" fieldtype="many-to-one" fkcolumn="recId" cfc="program" insert="false" update="false">
    <cfproperty name="subset_program_bases" fieldtype="one-to-many" cfc="subset_program_base" fkcolumn="program_id">
</cfcomponent>