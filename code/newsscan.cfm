<h1>NCOA News Page Scanner</h1>

<cfhttp url="http://www.ncoa.org/bcunews/" method="get">

<cfset html = cfhttp.FileContent>

<cfscript>
findCp = findnocase("Current Press Releases", html);
findTableBodyStart = findnocase("<tbody>", html, findCp);
findTableBodyEnd = findnocase("</tbody>", html, findTableBodyStart);
newsTable = mid(html, findTableBodyStart, findTableBodyEnd - findTableBodyStart);
</cfscript>


<cfset rowRegex = CreateObject(
	"java",
	"java.util.regex.Pattern"
	).Compile('(?i)(?s)(?m)[<TR vAlign=top align=left>].{0,400}</TR>')>	
	
<cfset idRegex = CreateObject(
	"java",
	"java.util.regex.Pattern"
	).Compile('(?i)(?s)(?m)(?<=href="index.cfm\?article_id=).{1,100}(?=")')>	
	
<cfset dateRegex = CreateObject(
	"java",
	"java.util.regex.Pattern"
	).Compile('(?i)(?s)(?m)(?<=<STRONG>).{6,10}(?=</STRONG>)')>		
	
<cfset hedRegex = CreateObject(
	"java",
	"java.util.regex.Pattern"
	).Compile('(?i)(?s)(?m)(?<=<TD.width=\"79%\">.{1,200}\">).{1,300}(?=</A>)')>			
	
	
			
<cfset rowMatch = rowRegex.Matcher(newsTable)>

<cfloop condition="rowMatch.Find()">
	<cfset id = 0>
	<cfset hed = "">
	<cfset row = rowMatch.Group()>
	
	<cfset idMatch = idRegex.Matcher(row)>
	<cfloop condition="idMatch.Find()">
		<cfset id = idMatch.Group()>
	</cfloop>
	<!--- <cfoutput>#id#</cfoutput> --->
	
	<cfif id IS NOT 0>
		<cfset dateMatch = dateRegex.Matcher(row)>
		<cfloop condition="dateMatch.Find()">
			<cfset date = dateMatch.Group()>
		</cfloop>
		<!--- <cfoutput>#date#</cfoutput> --->

		<cfset hedMatch = hedRegex.Matcher(row)>
		<cfloop condition="hedMatch.Find()">
			<cfset hed = trim(hedMatch.Group())>
		</cfloop>
		<!--- <cfoutput>#hed#</cfoutput> --->

		<cfquery name="findNews" datasource="#application.dbSrc#">
			SELECT * FROM news 
			WHERE news_ncoa_id = #id#
		</cfquery>
		
		<cfif findNews.recordcount IS 0>
			<cfquery name="findNews" datasource="#application.dbSrc#">
				INSERT INTO news 
				(news_dte, news_ncoa_id, news_hed, news_status, news_added) VALUES ('#date#', #id#, '#hed#', 1, #now()#)
			</cfquery>
			<cfset rebuildNewsPanel = 1>
		</cfif>

	</cfif>
	
	<!--- <hr> --->
</cfloop>		

<cfparam name="rebuildNewsPanel" default="0">

<cfif rebuildNewsPanel IS 1>
ALERT!  New article found on NCOA! Rebuilding news panel!

		<cfquery name="news" datasource="#application.dbSrc#">
			SELECT * FROM news 
			ORDER BY news_dte DESC limit 0,3
		</cfquery>

		<cfsavecontent variable="newsPanel">
		<cfoutput query="news">
		<li><a href="http://www.ncoa.org/bcunews/index.cfm?article_id=#news_ncoa_id#">#news_hed#</a></li>
		</cfoutput>
		</cfsavecontent>
		
		<cffile action="write" file="#ExpandPath("./")#/newsPanel.cfm" nameconflict="overwrite" output="#newsPanel#">
<cfelse>
No news is good news, er, I didn't find anything new on the NCOA news page, so I'm not going to do anything!
</cfif>
