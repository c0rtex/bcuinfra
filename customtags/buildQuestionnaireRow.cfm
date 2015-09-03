<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.type" type="string" default="spacer">
<cfparam name="attributes.colspan" type="numeric" default="9">
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfoutput>
<cfswitch expression="#attributes.type#">
	<cfcase value="spacer">
<tr>
	<td colspan="#attributes.colspan#" class="question-space"></td>
</tr>
	</cfcase>
</cfswitch>
</cfoutput>