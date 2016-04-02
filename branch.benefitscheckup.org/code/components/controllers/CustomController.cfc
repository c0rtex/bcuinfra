
<cfcomponent>
    <cffunction name="getById" access="remote" returnformat="plain">
        <cfargument name="id" type="any">
        <cfset qrs = entityload(getMetaData(this).entity,id)>
        <cfreturn this.prepareOutput(qrs)>
    </cffunction>

    <cffunction name="getList" access="remote" returnformat="plain">
        <cfargument name="orderBy" type="string" default="">
        <cfargument name="limit" type="numeric" default="10" >
        <cfargument name="offset" type="numeric" default="0">
        <!---<cfif orderBy neq "">
            <cfset orderBy = "order by #orderBy#">
        </cfif>
        <cfset retVal = ormExecuteQuery("from #getMetaData(this).entity# #orderBy#", true, {offset=offset, maxresults=limit})>
        <cfreturn this.prepareOutput(retVal)>--->
        <cfreturn this.getFiltered(orderBy=orderBy,limit=limit,offset=offset)>
    </cffunction>

    <cffunction name="getFiltered" access="remote" returnformat="plain">
        <cfargument name="filter" type="string" default="">
        <cfargument name="orderBy" type="string" default="">
        <cfargument name="limit" type="numeric" default="10" >
        <cfargument name="offset" type="numeric" default="0">

        <cfif filter neq "">
            <cfset filterStruct = deserializeJSON(filter)>
            <cfset filter = "where 1=1">
            <cfset filterParams = structNew()>
            <cfloop array="#filterStruct#" index="fi">
                <cfset filter = "#filter# #fi.operator# #fi.name# #fi.condition# :#fi.name#">
                <cfset filterParams[fi.name]=fi.value>
            </cfloop>
        </cfif>

        <cfif orderBy neq "">
            <cfset orderBy = "order by #orderBy#">
        </cfif>
        <cfif filter eq "">
            <cfset retVal = ormExecuteQuery("from #getMetaData(this).entity# #orderBy#", true, {offset=offset, maxresults=limit})>
        <cfelse>
            <cfset retVal = ormExecuteQuery("from #getMetaData(this).entity# #filter# #orderBy#", filterParams, {offset=offset, maxresults=limit})>
        </cfif>
        <cfreturn this.prepareOutput(retVal)>
    </cffunction>

    <cffunction name="prepareOutput">
        <cfargument name="aStruct">

        <cfset outputStruct = structNew()>

        <cfset obj = entityNew(getMetaData(this).entity)>

        <cfset outputStruct["metaData"] = obj.returnMetadata()>

        <cfset outputStruct["data"] = arrayNew(1)>

        <cfloop array="#aStruct#" index="i">
            <cfset arrayAppend(outputStruct.data,i.toDatabaseRepresentation())>
        </cfloop>

        <cfif structKeyExists(arguments, "callback")>
            <cfreturn arguments.callback & "(" & serializeJSON(outputStruct) & ");">
        <cfelseif structKeyExists(arguments, "jsonp")>
            <cfreturn "jsonp(" & serializeJSON(outputStruct) & ");">
        <cfelse>
            <cfreturn serializeJSON(outputStruct)>
        </cfif>
    </cffunction>

    <cffunction name="prepareStructure">
        <cfargument name="aObject">
        <cfset sRetVal = structNew()>
        <cfset metaData = getMetadata(this)>
        <cfif structKeyExists(metaData,"properties")>
            <cfloop array="#metaData.properties#" index="p">
                <cfif structKeyExists(p,"fieldtype")>
                    <cfset retVal[p.name]=evaluate("this.get#p.name#()")>
                <cfelse>

                </cfif>
            </cfloop>
        </cfif>
        <cfreturn retVal>
    </cffunction>
</cfcomponent>
