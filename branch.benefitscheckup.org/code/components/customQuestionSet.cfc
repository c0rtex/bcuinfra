<cfcomponent>

	<cffunction name="getQuestionSet" access="remote" returnFormat="plain">
		<cfargument name="state_id" type="string" required="no" default="">
		<cfargument name="subset_id" type="numeric" required="no" default="0">
		<cfargument name="partner_id" type="numeric" required="no" default="0">
		<cfargument name="org_id" type="numeric" required="no" default="0">

		<cfset _in = this.getQuestionsId(state_id,subset_id,partner_id,org_id)>

		<cfset cf = ormExecuteQuery("from question as q where q.id in (#_in#)")>

		<cfset retVal = arrayNew(1)>

		<cfloop array="#cf#" index="it">
			<cfset arrayAppend(retVal,it.returnStruct(state_id))>
		</cfloop>

		<cfset data = serializeJSON(retVal)>

		<cfif structKeyExists(arguments, "callback")>
			<cfset data = arguments.callback & "(" & data & ");">
			<cfelseif structKeyExists(arguments, "jsonp")>
			<cfset data= "jsonp(" & data & ");">
		</cfif>

		<cfreturn data>
	</cffunction>


</cfcomponent>