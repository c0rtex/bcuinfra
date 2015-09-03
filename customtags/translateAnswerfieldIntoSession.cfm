<cfsilent>
<cfparam name="attributes.scope" type="string" default="session">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.value" type="any">

<cfset afobj = application.AnswerfieldPool.getAnswerfield('#attributes.code#')>
<cfset val = attributes.value>

<cfif val neq ''>
	<cfswitch expression="#afobj.type#">
		<cfcase value="checkbox,yn">
			<cfif val eq 0>
				<cfset val = 'N'>
			<cfelse>
				<cfset val = 'Y'>
			</cfif>
		</cfcase>
		<cfcase value="drug,generic,rxco">
			<cfif val eq 1>
				<cfset val = 'Y'>
			<cfelse>
				<cfset val = ''>
			</cfif>
		</cfcase>
		<cfcase value="select">
			<!--- <cf_cacheOptionPool action="getCodeByID" id="#val#" var="option"> --->
            <cfset option = application.OptionPool.getOptionsById(val)>
			<cf_displayText group="option" code="option_#option#" var="val">
		</cfcase>
	</cfswitch>
</cfif>

<cfif val neq ''>
	<cfset "#attributes.scope#.#attributes.code#" = val>
</cfif>

</cfsilent>