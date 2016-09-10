<cfcomponent rest="true" restpath="/questionnaire">

  <cffunction name="sayHello" access="remote" returnType="String" httpMethod="GET">
    <cfheader name="Access-Control-Allow-Origin" value="*">
    <cfreturn "Hello World">
  </cffunction>
</cfcomponent>