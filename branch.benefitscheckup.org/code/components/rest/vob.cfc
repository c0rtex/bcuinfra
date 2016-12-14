<cfcomponent rest="true" restpath="/vob">

    <cffunction name="vobCountPeople" access="remote" restpath="/countpeople" returnType="String" httpMethod="GET">




        <cfset retVal = 5490418>



        <cfreturn serializeJSON(retVal)>


    </cffunction>

 
    <cffunction name="countVob" access="remote" restpath="/countvob" returnType="String" httpMethod="GET">

	  <cfset retVal = 17700000000>


        <cfreturn serializeJSON(retVal)>

    </cffunction>
</cfcomponent>
