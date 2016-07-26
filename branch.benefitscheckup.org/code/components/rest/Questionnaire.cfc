<cfcomponent rest="true" restpath="/questionnaire">
  <cffunction name="prescreen" access="remote" restpath="/prescreen" returnType="String" httpMethod="GET">
    <cfreturn "Hello World">
  </cffunction>
</cfcomponent>