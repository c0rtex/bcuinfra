<cfcomponent rest="true" restpath="/materials">

    <cffunction name="forProgram" access="remote" restpath="/required/forProgram/{programCode}" returnType="String" httpMethod="GET">
        <cfargument name="programCode" required="true" restargsource="Path" type="string"/>

        <cfset retVal = arrayNew(1)>

        <cfset pobj = entityload("program",{code=programCode})>

        <cfif (arraylen(pobj) neq 0)>
            <cfset pobj = pobj[1]>
        <cfelse>
            <cfreturn serializeJSON(retVal)>
        </cfif>

        <cfset forms = ormExecuteQuery("from program_requisite pr where pr.program=? order by sort",[pobj])>

        <cfloop array="#forms#" index="i">
            <cfset item = structNew()>
            <cfset item["code"] = i.getRequisite().getCode()>
            <cfset item["title"] = i.getRequisite().getDisplay().getDisplay_text()>
            <cfset item["description"] = i.getRequisite().getDef_display().getDisplay_text()>
            <cfset arrayAppend(retVal,item)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>

</cfcomponent>