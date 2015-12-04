<cfparam name="isauthorized" type="integer" default="0">
<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="session.autologin" default="false">
<cfset loginlist = "ibis,8775:test,test:ccarm,4165:coms,1070:cpr,7988:debtlogic,3200vfms,8707:hrs,4533:paragon,2244:agate,2525:aspen,3822:cccsa,3169:cccsd,6708:cchr,0088:ccoa,4598:cnc,2752:cmax,6306:cmaster,8600:debtplus,9380:gbls,1601:hats,7037:hcdms,7554:hco,2612:kcw,8888:mms,3703:nstep,8473:pika,7452:rmcs,5353:indisoft,3642">
<cfloop list="#loginlist#" index="vendor" delimiters=":">
<cfset finduser = findnocase(form.username, vendor)>
<cfif finduser gt 0 and form.username neq "">
<cfset findpass = findnocase(form.password, vendor)> 
<cfif findpass gt 0>
	<cfset isauthorized  = "true">
</cfif>
</cfif>
</cfloop>


<cfif isauthorized >
	<cfset session.autologin = true>
	<cfset session.autouser = form.username>
	<cfset session.autpassword = form.password>
	<cfset session.fitpartner = form.username >
	<cflocation url="/cf/fit/" AddToken="yes">
<cfelse>
<cfset session.autologin = false>
<h3>Invalid vendor security credentials, contact your Client
Management System vendor. Please make sure you are using our updated vendor access url.</h3>

</cfif>