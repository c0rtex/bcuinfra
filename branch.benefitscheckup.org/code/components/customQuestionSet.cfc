<!---
	Template Name: CustomQuestionSet
	Component Purpose: Abstract root component for web services, that returns questionnaires question sets in json format

	Data Tables: component doesn't use database tables directly

--->

<cfcomponent>

<!---
	Method is implemented for use in web service call to child components that returns questionaaires question sets
--->

	<cffunction name="getQuestionSet" access="remote" returnFormat="plain">
		<cfargument name="state_id" type="string" required="no" default="">
		<cfargument name="subset_id" type="numeric" required="no" default="0">
		<cfargument name="partner_id" type="numeric" required="no" default="0">
		<cfargument name="prev_id" type="numeric" required="no" default="0">

		<cfset cf = ormExecuteQuery("from question as q where #this.getFilter(state_id=state_id,subset_id=subset_id,partner_id=partner_id)# order by sort asc")>

		<cfset retVal = arrayNew(1)>

		<cfloop array="#cf#" index="it">
			<cfset arrayAppend(retVal,it.toStructure(state_id=state_id,subset_id=subset_id,partner_id=partner_id))>
		</cfloop>

		<cfset data = structNew()>

		<cfset data.prevService = this.getPrevService()>

		<cfset data.nextService = this.getNextService()>

		<cfset data.questions = retVal>

		<cfif structKeyExists(arguments, "callback")>
			<cfset data = arguments.callback & "(" & serializeJSON(data) & ");">
			<cfelseif structKeyExists(arguments, "jsonp")>
			<cfset data= "jsonp(" & data & ");">
		</cfif>

		<cfreturn data>
	</cffunction>

	<cffunction name="getPrevService">
		<cfreturn "">
	</cffunction>

	<cffunction name="getNextService">
		<cfreturn "">
	</cffunction>

	<cffunction name="getFilter">
		<cfargument name="state_id" type="string" required="no" default="">
		<cfargument name="subset_id" type="numeric" required="no" default="0">
		<cfargument name="partner_id" type="numeric" required="no" default="0">
		<cfreturn "1=1">
	</cffunction>

</cfcomponent>