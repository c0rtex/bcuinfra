<cfparam name="source" type="string" default="#application.dbSrcQA#">
<cfparam name="target" type="string" default="#application.dbSrc#">
<cfparam name="details" type="boolean" default="false">
<cfparam name="object" type="string" default="">
<cfparam name="table" type="string" default="">
<cfparam name="view" type="string" default="">
<cfparam name="db" type="string" default="">
<cfparam name="drop" type="boolean" default="false">


<cfquery name="types" datasource="#application.dbSrc#">
	select displaygroup_id as dgid, displaygroup_code as dgcode
	from displaygroup
	order by dgcode
</cfquery>


<cf_tableLoad>
<cf_viewLoad>
<cf_sprocLoad>

<cf_buildPage section="upload" title="Upload Tables"><cfoutput>

<cfif object eq 'sproc'>
	<cfif sproc neq '' and db eq ''>
		<span style="font-weight: bold; color: ##800000'">Specify database for stored proc create</span><br><br>
	<cfelseif sproc eq '' and db neq ''>
		<span style="font-weight: bold; color: ##800000'">Specify stored proc name for table create</span><br><br>
	<cfelseif sproc neq '' and db neq ''>
		<cf_sprocCreate sproc="#sproc#" source="#db#" drop="#drop#">
		<span style="font-weight: bold; color: ##800000'">Created stored proc #sproc# in database #db#, drop=#drop#</span><br><br>
	</cfif>
<cfelseif object eq 'view'>
	<cfif view neq '' and db eq ''>
		<span style="font-weight: bold; color: ##800000'">Specify database for view create</span><br><br>
	<cfelseif view eq '' and db neq ''>
		<span style="font-weight: bold; color: ##800000'">Specify view name for table create</span><br><br>
	<cfelseif view neq '' and db neq ''>
		<cf_viewCreate view="#view#" source="#db#" drop="#drop#">
		<span style="font-weight: bold; color: ##800000'">Created view #view# in database #db#, drop=#drop#</span><br><br>
	</cfif>
<cfelse>
	<cfif table neq '' and db eq ''>
		<span style="font-weight: bold; color: ##800000'">Specify database for table create</span><br><br>
	<cfelseif table eq '' and db neq ''>
		<span style="font-weight: bold; color: ##800000'">Specify table name for table create</span><br><br>
	<cfelseif table neq '' and db neq ''>
		<cf_tableCreate table="#table#" source="#db#" drop="#drop#">
		<span style="font-weight: bold; color: ##800000'">Created table #table# in database #db#, drop=#drop#</span><br><br>
	</cfif>
</cfif>


<form action="upload.cfm" method="post">
<input type="hidden" name="source" value="#source#">
<input type="hidden" name="target" value="#target#">
<input type="hidden" name="details" value="#details#">
<input type="submit" value="regular upload">
</form>


<form action="upload.cfm" method="post">
<b>source table:</b>
<input type="text" name="source" value="#source#" size="10">
&nbsp;
<b>target table:</b>
<input type="text" name="target" value="#target#" size="10">
&nbsp;
<b>show details:</b>
<select name="details">
<option value="false"<cfif not details> selected</cfif>>off
<option value="true"<cfif details> selected</cfif>>on
</select>
&nbsp;
<input type="submit" value="change">
</form>

<cfloop query="types">

	<h2>#dgcode#</h2>
	<font size="+1"><ol>
	<cfloop list="display,display_language" index="table">
		<cf_tableLoad table="#table#">
		<cfif view>
		<li><i>[view_]<a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#&group=#dgid#" target="_blank">#table#</a></i> &nbsp;&nbsp; <font size="-2"><i><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#&nonidentity=true&group=#dgid#" target="_blank">non-identity</a></i></font>
		<cfelse>
		<li><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#&group=#dgid#" target="_blank">#table#</a> &nbsp;&nbsp; <font size="-2"><i><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#&nonidentity=true&group=#dgid#" target="_blank">non-identity</a></i></font>
		</cfif>
	</cfloop>
	</ol></font>

</cfloop>

</cfoutput></cf_buildPage>