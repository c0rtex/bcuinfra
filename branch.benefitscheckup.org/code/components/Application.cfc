<cfcomponent>
    <cfset this.name = "bcubackend">
    <cfset this.datasource = "dbSrc">
    <cfset this.ormenabled = "true">
    <cfset this.ormsettings.cfclocation = "/bcu/orm">
    <cfset this.sessionmanagement = "yes">
    <cfheader name="Access-Control-Allow-Origin" value="*">
    <cfheader name="Access-Control-Allow-Methods" value="GET, POST">
    <cfheader name="Access-Control-Allow-Headers" value="Overwrite, Destination, Content-Type, Depth, User-Agent, X-File-Size, X-Requested-With, If-Modified-Since, X-File-Name, Cache-Control">

    <cffunction name="onApplicationStart" returntype="void" output="no">
        <cfset application.defaultLanguage = createObject("component","bcu.orm.language").getDefault()>
    </cffunction>

    <cffunction  name="OnSessionStart"
            access="public"
            returntype="void"
            output="false"
            hint="Fires ONLY ONCE when session first created and not when session renewed/restarted.">

        <cfset session.language = createObject("component","bcu.orm.language").getDefault()>

    </cffunction>


</cfcomponent>