<cfcomponent>
    <cffunction name="retQues" access="remote" returnFormat="plain">
        <cfset cf = ormExecuteQuery("from question where id in (433,431,13)")>
        <cfset retVal = arrayNew(1)>
        <cfloop array="#cf#" index="it">
            <cfset arrayAppend(retVal,it.returnStruct())>
        </cfloop>
        <cfset data = serializeJSON(retVal)>

        <cfif structKeyExists(arguments, "callback")>
            <cfset data = arguments.callback & "(" & data & ");">
        <cfelseif structKeyExists(arguments, "jsonp")>
            <cfset data= "jsonp(" & data & ");">
        </cfif>
        <cfreturn data>
    </cffunction>
</cfcomponent>