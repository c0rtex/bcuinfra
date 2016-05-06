<!---
  Created by raukasov on 17/04/16.
--->
<cfcomponent persistent="true" entityname="tbl_mx_asset" table="tbl_mx_asset" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="tbl_id">
    <cfproperty name="tbl_nm">
    <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="st" cfc="state">
    <cfproperty name="single">
    <cfproperty name="couple">
</cfcomponent>
