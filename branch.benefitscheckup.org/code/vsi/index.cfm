<cfparam name="refresh" type="numeric" default="60">
<cfparam name="cache" type="numeric" default="0">
<cfparam name="tote" type="numeric" default="0">
<cfparam name="datemask" type="string" default="d mmmm yyyy">
<cfparam name="timemask" type="string" default="h:mm:ss tt">
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="refresh" content="#refresh#; url=./" />
<title>Variable Space Inspector</title>
</head>

<body>

<cfset runtime = CreateObject("java","java.lang.Runtime").getRuntime()>
<cfset freeMemory = runtime.freeMemory() / 1024 / 1024>
<cfset totalMemory = runtime.totalMemory() / 1024 / 1024>
<cfset maxMemory = runtime.maxMemory() / 1024 / 1024>

<cfoutput>
    Free Allocated Memory: #Round(freeMemory)#mb<br>
    Total Memory Allocated: #Round(totalMemory)#mb<br>
    Max Memory Available to JVM: #Round(maxMemory)#mb<br>
</cfoutput>

<cfset percentFreeAllocated = Round((freeMemory / totalMemory) * 100)>
<cfset percentAllocated = Round((totalMemory / maxMemory ) * 100)>
<cfoutput>
    % of Free Allocated Memory: #percentFreeAllocated#%<br>
    % of Available Memory Allocated: #percentAllocated#%<br>
</cfoutput>



<h2>variable space inspector for #application.serverPath#</h2>

<i>display refreshes every #refresh# seconds<cfif cache eq 1><span style="color: ##009900;">&##151;application data cache refreshed and CF caches flushed</span><cfelseif cache eq 2><span style="color: ##009900;">&##151;CF query cache flushed</span><cfelseif cache eq 3><span style="color: ##009900;">&##151;CF template cache flushed</span><cfelseif tote><span style="color: ##009900;">&##151;toteboard cache refreshed</span></cfif></i>

<ul>

<li style="font-size: 15pt; font-weight: bold;">application scope&nbsp; <i>( <a href="applicationScope.cfm">inspect</a> )</i></li>

<li style="font-size: 15pt; font-weight: bold;">session scope&nbsp; <i>( <a href="sessionScope.cfm">inspect</a> )</i>
<ul style="font-size: 12pt; font-weight: normal;">
<cfif IsDefined('session.cfid')>
	<li><b>cfid:</b>&nbsp; #session.cfid#</li>
</cfif>
<cfif IsDefined('session.cftoken')>
	<li><b>cftoken:</b>&nbsp; #session.cftoken#</li>
</cfif>
<cfif IsDefined('session.sessionid')>
	<li><b>sessionid:</b>&nbsp; #session.sessionid#</li>
</cfif>
</ul>
</li>

<li style="font-size: 15pt; font-weight: bold;">application data cache&nbsp; <i>( <a href="refreshCache.cfm">refresh</a> )</i>
<ul style="font-size: 12pt; font-weight: normal;">
<cfif IsDefined('application.lastRefresh')>
	<li><b>last refreshed:</b>&nbsp; #LCase(TimeFormat(application.lastRefresh, timemask))#, #DateFormat(application.lastRefresh, datemask)#</li>
</cfif>
	<li><b>template cache:</b>&nbsp; <i>( <a href="refreshCache.cfm?reset=false&flush=template">flush</a> )</i></li>
	<li><b>query cache:</b>&nbsp; <i>( <a href="refreshCache.cfm?reset=false&flush=query">flush</a> )</i></li>
</ul>
</li>

<li style="font-size: 15pt; font-weight: bold;">toteboard cache&nbsp; <i>( <a href="refreshToteboard.cfm">refresh</a> )</i>
<ul style="font-size: 12pt; font-weight: normal;">
<cfif IsDefined('application.bcuToteboard.screenings') and application.bcuToteboard.screenings neq ''>
	<li><b>screenings:</b>&nbsp; #application.bcuToteboard.screenings#</li>
</cfif>
<cfif IsDefined('application.bcuToteboard.dollars') and application.bcuToteboard.dollars neq ''>
	<li><b>dollars:</b>&nbsp; #application.bcuToteboard.dollars#</li>
</cfif>
<cfif IsDefined('application.bcuToteboard.users') and application.bcuToteboard.users neq ''>
	<li><b>users:</b>&nbsp; #application.bcuToteboard.users#</li>
</cfif>
<cfif IsDefined('application.bcuToteboard.lastRefresh')>
	<li><b>last refreshed:</b>&nbsp; #LCase(TimeFormat(application.bcuToteboard.lastRefresh, timemask))#, #DateFormat(application.bcuToteboard.lastRefresh, datemask)#</li>
</cfif>
<cfif IsDefined('application.bcuToteboard.refreshDateTime')>
	<li><b>next refresh:</b>&nbsp; first access at or after #LCase(TimeFormat(application.bcuToteboard.refreshDateTime, timemask))#, #DateFormat(application.bcuToteboard.refreshDateTime, datemask)#</li>
</cfif>
</ul>
</li>

<li style="font-size: 15pt; font-weight: bold;">standard bcu session variables
<ul style="font-size: 12pt; font-weight: normal;">
<cfloop list="source_id,prev_id,org_id,partner_id,subset_id,language_id,access_id,client_id,user_id,state_id,test_id" index="id">
	<li><b>#id#:</b>&nbsp;
	<cfif IsDefined("session.#id#")>
		#Evaluate("session.#id#")#
	</cfif>
	</li>
</cfloop>
</ul>
</li>

<li style="font-size: 15pt; font-weight: bold;">current screening&nbsp; <i>( <a href="screeningStruct.cfm">inspect</a> )</i>
<ul style="font-size: 12pt; font-weight: normal;">
<cfif IsDefined('session.screening')>
	<li><b>id:</b>&nbsp; #session.screening.id#</li>
<cfelse>
	<li><i>no active screening in current session</i></li>
</cfif>
</ul>
</li>

<li style="font-size: 15pt; font-weight: bold;">other tools</i>
<ul style="font-size: 12pt; font-weight: normal;">
	<li><a href="screeningList.cfm">screening response inspector</a></li>
	<li><a href="entrypointTest.cfm">program entry point test page</a></li>
</ul>
</li>

</ul>

</body>
</cfoutput>
</html>
