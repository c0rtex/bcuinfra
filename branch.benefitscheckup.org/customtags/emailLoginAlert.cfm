<cfparam name="attributes.failure" type="boolean" default="false">
<cfparam name="attributes.from" type="string" default="datacollector@benefitscheckup.org">
<cfparam name="attributes.to" type="string" default="kiryl@benefitscheckup.org;bill@benefitscheckup.org">
<cfparam name="attributes.user" type="string" default="">

<cfif Not IsDefined('session.email') Or session.email eq true>
	<cfif attributes.failure>
		<cfmail from="#attributes.from#" to="#attributes.to#" subject="Failed attempt to log in to DC">
Username:    #attributes.user#
IP address:  #cgi.REMOTE_HOST#
		</cfmail>
	<cfelse>
		<cfmail from="#attributes.from#" to="#attributes.to#" subject="User #session.user# logged in to DC">
User level:  #session.usertype#
IP address:  #cgi.REMOTE_HOST#
		</cfmail>
	</cfif>
</cfif>