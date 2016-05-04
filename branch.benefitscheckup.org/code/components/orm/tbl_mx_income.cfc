<!---
  Created by raukasov on 18/04/16.
--->
<cfcomponent persistent="true" entityname="tbl_mx_income" table="tbl_mx_income" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="tbl_id">
    <cfproperty name="tbl_nm">
    <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="st" cfc="state">
    <cfproperty name="single_max">
    <cfproperty name="single_min">
    <cfproperty name="couple_max">
    <cfproperty name="couple_min">
</cfcomponent>
