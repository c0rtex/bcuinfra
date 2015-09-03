<cfsilent>
<cfparam name="attributes.form" type="string" default="bcuQuestionnaire">
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.type" type="string" default="">
<cfparam name="attributes.showText" type="boolean" default="true">
<cfparam name="attributes.stripTags" type="boolean" default="false">
<cfparam name="attributes.aflistvarname" type="string" default="">
<cfparam name="attributes.tables" type="boolean" default="true">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cf_handleScreeningAnswerfield code="#attributes.code#">
<cfif attributes.showText>
	<cf_displayTextAnswerfield code="#attributes.code#" stripTags="#attributes.stripTags#" var="answerfieldText">
</cfif>
</cfsilent><cfif attributes.showText and answerfieldText neq '' ><cfoutput><cfif attributes.code neq 'fit_counseling_session_type'>#answerfieldText#&nbsp;</cfif></cfoutput></cfif><cfsilent>
</cfsilent>
<cfsetting enablecfoutputonly="yes">
<cfswitch expression="#attributes.type#">
	<cfcase value="asset,currency,income">
    	<cf_displayAnswerfieldCurrency code="#attributes.code#" tables="#attributes.tables#" type="#attributes.type#" aflistvarname="caller.#attributes.aflistvarname#">
    </cfcase>
	<cfcase value="checkbox"><cf_displayAnswerfieldCheckbox code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="gender"><cf_displayAnswerfieldGender code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="integer"><cf_displayAnswerfieldInteger code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="month"><cf_displayAnswerfieldMonth code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="select"><cf_displayAnswerfieldSelect code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="state"><cf_displayAnswerfieldState code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="text"><cf_displayAnswerfieldText code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="year"><cf_displayAnswerfieldYear code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="yn"><cf_displayAnswerfieldYesNo code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfcase value="zipcode"><cf_displayAnswerfieldZipCode form="#attributes.form#" code="#attributes.code#" aflistvarname="caller.#attributes.aflistvarname#"></cfcase>
	<cfdefaultcase><cfoutput><strong>#attributes.type#</strong></cfoutput></cfdefaultcase>
</cfswitch>
<cfsetting enablecfoutputonly="no">