<cfcomponent persistent="true" entityname="language" table="language">
    <cfproperty name="id" fieldtype="id" column="language_id">
    <cfproperty name="default_flag">
    <cfproperty name="active">
    <cffunction name="getDefault">
        <cfreturn entityload("language",{default_flag=1, active=1},"true")>
    </cffunction>
    <cffunction name="getCurrentLanguage">
        <cfreturn this.getDefault()>
    </cffunction>
</cfcomponent>