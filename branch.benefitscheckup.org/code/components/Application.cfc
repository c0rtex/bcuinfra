<cfcomponent>
    <cfset this.name = "bcubackend">
    <cfset this.datasource = "dbSrc">
    <cfset application.dbSrc = this.datasource>
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

   <cffunction
        name="onRequestStart"
        access="public"
        returntype="boolean"
        output="true"
        hint="Intialize these settings on each request.">

        <!---
            Check to see if the refresh of rebuild flag is
            present. If it is, then we need to reload the ORM
            mappings and configuration.
        --->
        <cfif (
            !isNull( url.rebuildORM ) ||
            !isNull( url.refreshORM ) ||
            !isNull( form.refreshORM )

            )>

            <!--- Reload the ORM configuration and mappings. --->
            <cfset ORMReload() />
		<cfoutput><h1>Orm Reloaded!</h1></cfoutput>	
        </cfif>

        <!--- Return true so that the page can run. --->
        <cfreturn true />
    </cffunction>	 
</cfcomponent>