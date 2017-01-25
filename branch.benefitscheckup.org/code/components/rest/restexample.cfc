<cfcomponent rest="true" restpath="/restexample">

    <cffunction name="example1" access="remote" restpath="/pathtoexampleone" returnType="String" httpMethod="GET">

        		<cfset retVal = "Here is Your Result in Serialized JSON">

			<cfreturn serializeJSON(retVal)>


    </cffunction>

 

    <cffunction name="example1" access="remote" restpath="/pathtoexampleone/{node}" returnType="String" httpMethod="GET">
        <cfargument name="node" required="true" restargsource="Path" type="string"/>
        <cfargument name="stateId" required="false" restargsource="Query" default="" type="string"/>
        		<cfset retVal = "Here are your inputs:" & node & ":" & stateId>

			<cfreturn serializeJSON(retVal)>


    </cffunction>

</cfcomponent>