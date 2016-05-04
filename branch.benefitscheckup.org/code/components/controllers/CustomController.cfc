
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
        <cfreturn this.getFiltered(orderBy=orderBy,limit=limit,offset=offset)>
    </cffunction>

    <cffunction name="getListCount" access="remote" returnformat="plain">
        <cfreturn this.getFilteredCount()>
    </cffunction>

    <cffunction name="getFilteredCount" access="remote" returnformat="plain">
        <cfargument name="filter" type="string" default="">

        <cfif filter neq "">
            <cfset filterStruct = deserializeJSON(filter)>
            <cfset filter = "where 1=1">
            <cfset filterParams = structNew()>
            <cfloop array="#filterStruct#" index="fi">
                <cfset filter = "#filter# #fi.operator# #fi.name# #fi.condition# :#fi.name#">
                <cfset filterParams[fi.name]=fi.value>
            </cfloop>
        </cfif>

        <cfif filter eq "">
            <cfset retVal = ormExecuteQuery("select count(*) from #getMetaData(this).entity#")>
        <cfelse>
            <cfset retVal = ormExecuteQuery("select count(*) from #getMetaData(this).entity# #filter#", filterParams)>
        </cfif>
        <cfreturn this.prepareOutput(retVal)>
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

        <cfset os = arrayNew(1)>

        <cfloop array="#retVal#" index="i">
            <cfset arrayAppend(os,i.toDatabaseRepresentation())>
        </cfloop>
        <cfreturn this.prepareOutput(os)>
    </cffunction>

    <cffunction name="save" access="remote" returnformat="plain">
        <cfargument name="entity" required="yes">

        <cfset entity = deserializeJSON(entity)>

        <cfset aEntity = entityNew(getMetaData(this).entity)>

        <cfset metaData = aEntity.returnMetadata()>

        <cfloop collection="#metaData#" item="i">
            <cfif structKeyExists(entity,i)>
                <cfif metaData[i].fieldtype eq "many-to-one">
                    <cfset mto = entityLoadByPK(metaData[i].master,entity[i])>
                    <cfif !isNull(mto)>
                        <cfset evaluate("aEntity.set#metaData[i].name#(mto)")>
                    </cfif>
                <cfelse>
                    <cfset evaluate("aEntity.set#metaData[i].name#(entity[i])")>
                </cfif>
            </cfif>
        </cfloop>

        <cfset entitySave(aEntity)>

        <cfreturn this.prepareOutput([aEntity])>

    </cffunction>

    <cffunction name="prepareOutput">
        <cfargument name="aStruct">

        <cfset outputStruct = structNew()>

        <cfset obj = entityNew(getMetaData(this).entity)>

        <cfset outputStruct["metaData"] = obj.returnMetadata()>

        <cfset outputStruct["data"] = aStruct>

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
