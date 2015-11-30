<cfparam name="attributes.firstvar" type="string" default="">
<cfparam name="attributes.initialvar" type="string" default="">
<cfparam name="attributes.lastvar" type="string" default="">
<cfparam name="attributes.suffixvar" type="string" default="">
<cfparam name="attributes.var" type="string" default="">

<cfset output = ''>
<cfif attributes.firstvar neq ''>
	<cf_handleScreeningAnswerfield action="get" code="#attributes.firstvar#" element="val" var="bfnTempName">
	<cfif Trim(bfnTempName) neq ''>
		<cfset output = Trim(bfnTempName)>
	</cfif>
</cfif>
<cfif attributes.initialvar neq ''>
	<cf_handleScreeningAnswerfield action="get" code="#attributes.initialvar#" element="val" var="bfnTempName">
	<cfif Trim(bfnTempName) neq ''>
		<cfif output neq ''>
			<cfset output = output & ' '>
		</cfif>
		<cfset output = output & Trim(bfnTempName) & '.'>
	</cfif>
</cfif>
<cfif attributes.lastvar neq ''>
	<cf_handleScreeningAnswerfield action="get" code="#attributes.lastvar#" element="val" var="bfnTempName">
	<cfif Trim(bfnTempName) neq ''>
		<cfif output neq ''>
			<cfset output = output & ' '>
		</cfif>
		<cfset output = output & Trim(bfnTempName)>
	</cfif>
</cfif>
<cfif attributes.suffixvar neq ''>
	<cf_handleScreeningAnswerfield action="get" code="#attributes.suffixvar#" element="val" var="bfnTempName">
	<cfif Trim(bfnTempName) neq ''>
		<cfif output neq ''>
			<cfset output = output & ' '>
		</cfif>
		<cfset initcode=''>
		<cfswitch expression="#Trim(bfnTempName)#">
			<cfcase value="2349">
				<cfset initcode = 'sfx_junior'>
			</cfcase>
			<cfcase value="2350">
				<cfset initcode = 'sfx_senior'>
			</cfcase>
			<cfcase value="2351">
				<cfset initcode = 'sfx_1'>
			</cfcase>
			<cfcase value="2352">
				<cfset initcode = 'sfx_2'>
			</cfcase>
			<cfcase value="2353">
				<cfset initcode = 'sfx_3'>
			</cfcase>
			<cfcase value="2354">
				<cfset initcode = 'sfx_4'>
			</cfcase>
		</cfswitch>
		<cfif initcode eq ''>
			<cfset inittext=''>
		<cfelse>
			<cf_displayText code="option_#initcode#" group="option" var="inittext">
		</cfif>
		<cfset output = output & inittext>
	</cfif>
</cfif>
<cfset "#attributes.var#" = output>