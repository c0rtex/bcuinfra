
<cfcomponent>
    <cffunction name="getById" access="remote" returnformat="plain">
        <cfargument name="id" type="any">
        <cfset qrs = entityload(getMetaData(this).entity,id)>
        <cfset retVal = structNew()>
        <cfif arraylen(qrs) neq 0>
            <cfset retVal =qrs[1]>
        </cfif>
        <cfreturn this.prepareOutput(retVal)>
    </cffunction>

    <cffunction name="getList" access="remote" returnformat="plain">
        <cfargument name="orderBy" type="string" default="">
        <cfargument name="limit" type="numeric" default="10" >
        <cfargument name="offset" type="numeric" default="1">
        <cfif orderBy neq "">
            <cfset orderBy = "order by #orderBy#">
        </cfif>
        <cfset retVal = ormExecuteQuery("from #getMetaData(this).entity# #orderBy#", false, {offset=offset, maxresults=limit})>
        <cfreturn this.prepareOutput(retVal)>
    </cffunction>

    <cffunction name="prepareOutput">
        <cfargument name="outputStruct">
        <cfif structKeyExists(arguments, "callback")>
            <cfreturn arguments.callback & "(" & serializeJSON(outputStruct) & ");">
        <cfelseif structKeyExists(arguments, "jsonp")>
            <cfreturn "jsonp(" & serializeJSON(outputStruct) & ");">
        <cfelse>
            <cfreturn serializeJSON(outputStruct)>
        </cfif>
    </cffunction>
</cfcomponent>
