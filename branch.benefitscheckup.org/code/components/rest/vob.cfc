<cfcomponent rest="true" restpath="/vob">

    <cffunction name="vobCountPeople" access="remote" restpath="/countpeople" returnType="String" httpMethod="GET">




        <cfset retVal = 5000004>



        <cfreturn serializeJSON(retVal)>


    </cffunction>

 
    <cffunction name="countVob" access="remote" restpath="/countvob" returnType="String" httpMethod="GET">

	  <cfset retVal = 1600000007>


        <cfreturn serializeJSON(retVal)>

    </cffunction>
</cfcomponent>
