<cfparam name="source" type="string" default="#application.dbSrcQA#">
<cfparam name="target" type="string" default="#application.dbSrc#">
<cfparam name="details" type="boolean" default="false">
<cfparam name="object" type="string" default="">
<cfparam name="table" type="string" default="">
<cfparam name="view" type="string" default="">
<cfparam name="db" type="string" default="">
<cfparam name="drop" type="boolean" default="false">

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


<form action="selective.cfm" method="post">
<input type="hidden" name="source" value="#source#">
<input type="hidden" name="target" value="#target#">
<input type="hidden" name="details" value="#details#">
<input type="submit" value="selective display text upload">
</form>
<br />


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

<font size="+1"><ol>
<cfloop list="#tableList#" index="table">
	<cf_tableLoad table="#table#">
	<cfif view>
	<li><i>[view_]<a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#" target="_blank">#table#</a></i> &nbsp;&nbsp; <font size="-2"><i><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#&nonidentity=true" target="_blank">non-identity</a></i></font>
	<cfelse>
	<li><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#" target="_blank">#table#</a> &nbsp;&nbsp; <font size="-2"><i><a href="update.cfm?table=#table#&source=#source#&target=#target#&details=#details#&nonidentity=true" target="_blank">non-identity</a></i></font>
	</cfif>
</cfloop>
</ol></font>

<form action="upload.cfm" method="post">
<b>create table:</b>
<select name="table"><option value="">-- select table --<cfloop index="table" list="#tableList#">
	<option value="#table#">#table#
</cfloop></select>
&nbsp;
<b>in database:</b>
<select name="db"><option value="">-- select db --
	<option value="#target#">#target#
	<option value="#source#">#source#
</select>
&nbsp;
<b>drop first:</b>
<select name="drop">
<option value="false">no
<option value="true">yes
</select>
<input type="hidden" name="object" value="table">
<input type="hidden" name="source" value="#source#">
<input type="hidden" name="target" value="#target#">
<input type="hidden" name="details" value="#details#">
&nbsp;
<input type="submit" value="create">
</form>

<form action="upload.cfm" method="post">
<b>create view:</b>
<select name="view"><option value="">-- select view --<cfloop index="view" list="#viewList#">
	<option value="#view#">#view#
</cfloop></select>
&nbsp;
<b>in database:</b>
<select name="db"><option value="">-- select db --
	<option value="#target#">#target#
	<option value="#source#">#source#
</select>
&nbsp;
<b>drop first:</b>
<select name="drop">
<option value="false">no
<option value="true">yes
</select>
<input type="hidden" name="object" value="view">
<input type="hidden" name="source" value="#source#">
<input type="hidden" name="target" value="#target#">
<input type="hidden" name="details" value="#details#">
&nbsp;
<input type="submit" value="create">
</form>

<form action="upload.cfm" method="post">
<b>create stored proc:</b>
<select name="sproc"><option value="">-- select stored proc --<cfloop index="sproc" list="#sprocList#">
	<option value="#sproc#">#sproc#
</cfloop></select>
&nbsp;
<b>in database:</b>
<select name="db"><option value="">-- select db --
	<option value="#target#">#target#
	<option value="#source#">#source#
</select>
&nbsp;
<b>drop first:</b>
<select name="drop">
<option value="false">no
<option value="true">yes
</select>
<input type="hidden" name="object" value="sproc">
<input type="hidden" name="source" value="#source#">
<input type="hidden" name="target" value="#target#">
<input type="hidden" name="details" value="#details#">
&nbsp;
<input type="submit" value="create">
</form>

</cfoutput></cf_buildPage>