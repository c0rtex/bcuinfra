<cfparam name="p" type="string" default="">
<cfparam name="q" type="string" default="">
<cfif (Not IsDefined('session.user') OR session.user eq '') And Not IsDefined('form.user')>
	<cflocation url="login.cfm" addtoken="no">
<cfelse>
	<cfset passthrough = false>
	<cfif IsDefined('form.user')>
		<cfif IsDefined('form.psswrd')>
			<cfquery name="pass" datasource="#application.dbSrc#">
				select u.user_id, u.usertype_id, ut.usertype_code
				from `user` u, usertype ut
				where u.username='#form.user#'
					and u.password='#form.psswrd#'
					and u.active=1
					and u.usertype_id=ut.usertype_id
			</cfquery>
			<cfif pass.RecordCount eq 1>
				<cfset session.user_id = pass.user_id>
				<cfset session.user = form.user>
				<cfset session.level = pass.usertype_id>
				<cfset session.usertype = pass.usertype_code>
				<cfset session.user_level = ''>
				<cfset passthrough = true>
				<cfquery name="loglogin" datasource="#application.dbSrc#">
					update `user`
					set last_login_date=now()
					where user_id=#session.user_id#
				</cfquery>
			<cfelse>
				<cfset session.user_id = 0>
				<cfset session.user = ''>
				<cfset session.level = 999>
				<cfset session.usertype = ''>
				<cfset session.user_level = ''>
			</cfif>
		<cfelse>
			<cfset session.user_id = 0>
			<cfset session.user = ''>
			<cfset session.level = 999>
			<cfset session.usertype = ''>
			<cfset session.user_level = ''>
		</cfif>
	<cfelse>
		<cfset passthrough = true>
	</cfif>
	<cfif passthrough>
		<cfswitch expression="#session.level#">
			<cfcase value="1">
				<cfset session.user_level = 'admin'>
			</cfcase>
			<cfcase value="2">
				<cfset session.user_level = 'admin'>
			</cfcase>
			<cfcase value="3">
				<cfset session.user_level = 'admin'>
			</cfcase>
			<cfcase value="4">
				<cfset session.user_level = 'ReadUser'>
			</cfcase>
			<cfdefaultcase>
				<cfset session.user_level = 'ReadUser'>
			</cfdefaultcase>
		</cfswitch>
		<cf_emailLoginAlert>
		<cfif p eq ''>
			<cf_buildPage>
			<div align="center"><img src="dc2.jpg" border="0" width="768" height="393" alt="BenefitsCheckUp Data Collector"></div>
			</cf_buildPage>
		<cfelse>
			<cfif q neq ''>
				<cfset p = "#p#?#q#">
			</cfif>
			<cflocation url="#p#" addtoken="no">
		</cfif>
	<cfelse>
		<cf_emailLoginAlert user="#form.user#" failure="true">
		<cflocation url="login.cfm?wrong=yes&p=#URLEncodedFormat(p)#&q=#URLEncodedFormat(q)#" addtoken="no">
	</cfif>
</cfif>