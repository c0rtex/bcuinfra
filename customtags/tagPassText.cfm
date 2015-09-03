<cfparam name="attributes.outputvar" type="string" default="strOutData">
<cfif ThisTag.ExecutionMode is 'end'>
	<cfif not IsDefined("caller.#attributes.outputvar#")>
		<cfset "caller.#attributes.outputvar#" = "">
	</cfif>
   <cfset "caller.#attributes.outputvar#" = Evaluate("caller.#attributes.outputvar#") & thistag.generatedcontent>
</cfif>