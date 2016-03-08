<!---
	Template Name: ZipEntity
	Component Purpose: Component mapped to database table state via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: zip
--->
<cfcomponent persistent="true" entityname="zip" table="zip" extends="ToStructConverter">
    <cfproperty name="zipcode" fieldtype="id">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="State">
    <cfproperty name="county" fieldtype="many-to-one" fkcolumn="county_id" column="county_id" cfc="County">
    <cfproperty name="latitude">
    <cfproperty name="longitude">
    <cfproperty name="valid">

    <cffunction name="getStateFromZip" access="remote" returnFormat="plain">
        <cfargument name="zipCode" type="string" required="yes">
        <cfset vZip = entityload("zip",zipCode)>
        <cfif arraylen(vzip) neq 0>
            <cfreturn vzip[1].getState()>
        <cfelse>
            <cfreturn structNew()>
        </cfif>
    </cffunction>

    <cffunction name="validateZip" access="remote" returnFormat="plain">
        <cfargument name="zipcode" required="yes" type="string">
        <cfargument name="state_id" required="no" type="string" default="">
        <cfset validzip = ormExecuteQuery("from zip z where z.zipcode=? and z.state.id=?",[zipcode,state_id])>

        <cfif structKeyExists(arguments, "callback")>
            <cfreturn arguments.callback & "({result:""#arraylen(validzip) neq 0#""});">
        <cfelseif structKeyExists(arguments, "jsonp")>
            <cfreturn "jsonp({result:""#arraylen(validzip) neq 0#""});">
        </cfif>

        <cfreturn {result=arraylen(validzip) neq 0}>
    </cffunction>
</cfcomponent>
