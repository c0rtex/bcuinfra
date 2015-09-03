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


<BR>
<cfoutput>#cgi.server_name#</cfoutput>

<BR>

<cfoutput>#cgi.http_host#</cfoutput>

<br>

<cfset inet = CreateObject("java", "java.net.InetAddress")>
<cfset inet = inet.getLocalHost()>
<cfoutput>#inet.getHostName()#</cfoutput>
<BR>Breaking News<BR>
<cfoutput>#application.serverPath#</cfoutput>
<BR>


<cfset inet = createObject("java", "java.net.InetAddress") />
<cfset hostName = inet.getLocalHost().getHostName() />
 
<cfoutput>This computer's name is #hostName#</cfoutput>
<BR>

<cftry>
	<cfset j2eeService = createObject("java", "jrun.naming.NamingService") />
 
<cfcatch>
	<cfset j2eeService = createObject("java", "org.apache.catalina.ServerFactory").getServer() />
</cfcatch>
</cftry>
 
<cfset port = j2eeService.getPort() />
<BR>
 
<cfoutput>This instance is running against port #port# </cfoutput>
<BR>

<cfset oErrorJRun = createObject("java","jrunx.kernel.JRun")/>
<cfset strServerName = oErrorJRun.ServerName />

<cfoutput>This instance name is  #strServerName#</cfoutput>

