<cfcomponent persistent="true" entityname="display" table="display">
	<cfproperty name="id" fieldtype="id" column="display_id">
	<cfproperty name="code" column="display_code">
	<cfproperty name="display_text" persistent="false" getter="true">

	<cffunction name="getDisplay_text">
        <cfset displ=ORMExecuteQuery("from display_language where display_id=:display_id and language_id=:language_id", {display_id=this.getId(), language_id=session.language.getId()})>
		<cfreturn displ[1].getDisplay_text()>
	</cffunction>
</cfcomponent>