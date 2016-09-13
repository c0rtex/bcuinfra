<cfset root_path = "/CustomTags/BCU/">

<cf_directoryTree>

<style type="text/css">
	.code {
	border: 1px solid #000033;
	background-color:#FFFFCC;
	max-width: 800px;
}
</style>

<cfset findtable = CreateObject(
	"java",
	"java.util.regex.Pattern"
	).Compile("(?<=(from|FROM|INNER JOIN|inner join|left outer join|LEFT OUTER JOIN) *)(.*?)(?=[ \t\r\n])")>
    
<cfset param = CreateObject(
	"java",
	"java.util.regex.Pattern"
	).Compile("##[^##\r\n]*##|'##[^##\r\n]*##'|""##[^##\r\n]*##""")>
    
<cfoutput>
<cfset count = 0>
<cfset queryCount = 0>

<cfloop list="#imageList#" index="i">
	<cffile action="read" variable="t" file="j:\bcu\CustomTags\bcu\#i#">
    
	<cfset queries =  reMatchNoCase('</cfquery>', t)>
		<cfif arraylen(queries) GT 0>
		
				<cfquery name="findSpider" datasource="#application.dbSrc#">
					SELECT * FROM spider 
					WHERE spider_path = '#i#'
				</cfquery>
				
				
				<cfset source = replacenocase(t, "'", "''", "all")>
				
				<cfif findSpider.recordcount IS 0>
					<cfset uuid = createuuid()>
					<cfquery name="insertSpider" datasource="#application.dbSrc#">
						INSERT INTO spider 
						(spider_uuid, spider_path, spider_template, spider_queries, spider_source, spider_status) 
						VALUES 
						('#uuid#', '#root_path##i#', '#root_path##i#', #arraylen(queries)#, '#source#', 0)
					</cfquery>
					
					<cfquery name="findSpider" datasource="#application.dbSrc#">
						SELECT * FROM spider 
						WHERE spider_uuid ='#uuid#'
					</cfquery>
					
				<cfelse>
					<cfquery name="updateSpider" datasource="#application.dbSrc#">
						UPDATE spider 
						SET spider_path = '#root_path##i#', 
						spider_template = '#root_path##i#', 
						spider_queries = #arraylen(queries)#,
						spider_source = '#source#'
						WHERE spider_id = #findSpider.spider_id# 
					</cfquery>
				</cfif>

		
			<cfset queryCount = queryCount + arraylen(queries)><h2>#arraylen(queries)# queries found in #root_path##i#!</h2>
			<cfset queryList =  reMatchNoCase('(<cfquery)(.*?)(</cfquery>)', t)>
			<cfset loop = 1>
			<cfloop array="#querylist#" index="q">
				<div class="code">
				<cfset code = replacenocase(q, "#chr(13)##chr(10)##chr(13)##chr(10)#", "#chr(13)##chr(10)#", "all")>
				<pre>#htmleditformat(code)#</pre>
				</div>
				<cfset tables = findtable.Matcher(q)>
				<cfset tableList = "">
				<cfloop condition="tables.Find()">
					<cfif trim(tables.Group()) IS NOT "(">
						<cfif listfindnocase(tableList, tables.Group(), "|") IS 0>
							<cfset tableList = listAppend(tableList, tables.Group(), "|")>
						</cfif>
					</cfif>
				</cfloop>
				<strong>Tables:<br /></strong>
				<cfset tableList = listSort(tableList, "text", "asc", "|")>
				<cfloop list="#tableList#" index="tbl" delimiters="|">
					#tbl#<br />
				</cfloop>
				
				<cfset params = param.Matcher(q)>
				<cfset paramsList = "">

				<cfloop condition="params.Find()">
					<cfif listfindnocase(paramsList, params.Group(), "|") IS 0>
						<cfset paramsList = listAppend(paramsList, params.Group(), "|")>
					</cfif>
				</cfloop>
				<strong>Params:</strong><br>
				<cfset paramsList = listSort(paramsList, "text", "asc", "|")>
				<cfloop list="#paramsList#" index="prm" delimiters="|">
					#prm#<br />
				</cfloop>

				<cfquery name="findQuery" datasource="#application.dbSrc#">
					SELECT * FROM spider_query 
					WHERE spider_query_spider_id = #findSpider.spider_id# AND spider_query_no = #loop#
				</cfquery>
				
				<cfif findQuery.recordcount IS 0>
					<cfquery name="insertQuery" datasource="#application.dbSrc#">
						INSERT INTO spider_query 
						(spider_query_spider_id, spider_query_no, spider_query_query, spider_query_tables, spider_query_params, spider_query_status) 
						VALUES 
						(#findSpider.spider_id#, #loop#, '#code#', '#tableList#', '#paramsList#', 0)
					</cfquery>
				<cfelse>
					<cfquery name="updateQuery" datasource="#application.dbSrc#">
						UPDATE spider_query 
						SET spider_query_query = '#code#', 
						spider_query_tables = '#tableList#', 
						spider_query_params = '#paramsList#'
						WHERE spider_query_id = #findQuery.spider_query_id# 
					</cfquery>
				</cfif>

			<hr>
			<cfset loop = loop + 1>
			</cfloop>
			<cfflush>		  
		</cfif>
	
	<cfset count = count + 1>
</cfloop>
<b>
#count# templates<br>
#queryCount# queries<br>
</b>
</cfoutput>
