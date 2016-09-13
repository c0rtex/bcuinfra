<cfquery name="spiders" datasource="#application.dbSrc#">
	SELECT * FROM spider 
	LEFT JOIN spider_query ON spider_query_spider_id = spider_id
	WHERE spider_id = #spider_id#
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<style type="text/css">
	.code {
	border: 1px solid #000033;
	background-color:#FFFFCC;
}
</style>


<title>BCU File Spider</title>
</head>

<body>



<cfoutput query="spiders" group="spider_id">
<h2>#spider_queries# <cfif spider_queries IS 1>query<cfelse>queries</cfif> found in #spider_path#</h2>

<form action="templateu.cfm" method="post">
<input type="hidden" name="spider_id" value="#spider_id#" />
<p>Assigned To: <input type="text" size="40" name="spider_assigned_to" value="#spider_assigned_to#" /> Status: <select size="1" name="spider_status">
<option value="0" <cfif spider_status IS 0>SELECTED</cfif>>Unassigned</option>
<option value="1" <cfif spider_status IS 1>SELECTED</cfif>>Assigned - Pending</option>
<option value="3" <cfif spider_status IS 3>SELECTED</cfif>>Complete</option>
<option value="2" <cfif spider_status IS 2>SELECTED</cfif>>Problem</option>
</select> <input type="submit" value="Update" />
</p>
</form>

	<cfoutput>
		<cfset code = replacenocase(spider_query_query, "#chr(13)##chr(10)##chr(13)##chr(10)#", "#chr(13)##chr(10)#", "all")>
		<h2>Query #spider_query_no#:</h2>
		<div class="code">
		<pre>#htmleditformat(code)#</pre>
		</div>
		<h3>Tables:</h3>
		<cfloop list="#spider_query_tables#" index="tbl" delimiters="|">
		#tbl#<br />
		</cfloop>
		<h3>Params:</h3>
		<cfloop list="#spider_query_params#" index="prm" delimiters="|">
		#prm#<br />
		</cfloop>
		<hr size="1" noshade="noshade" />
	</cfoutput>


<h2>Source Code:</h2>
<div class="code">
<cfset source = replacenocase(spider_source, "#chr(13)##chr(10)##chr(13)##chr(10)#", "#chr(13)##chr(10)#", "all")>
<pre>#htmleditformat(source)#</pre>
</div>

</cfoutput>

</body>
</html>
