<cfoutput>
    <cfset cf = ormExecuteQuery("from question where id in (27,433,87,16,15,101,65)")>
    <cfset retVal = arrayNew(1)>
    <cfloop array="#cf#" index="it">
        <cfset arrayAppend(retVal,it.returnStruct())>
    </cfloop>

    #serializeJSON(retVal)#

</cfoutput>


