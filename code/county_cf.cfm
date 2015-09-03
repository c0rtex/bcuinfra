<cfquery name="county" datasource="#application.dbSrc#">
	SELECT *
	FROM county
	WHERE county_id = #county_id#
	ORDER BY county_name
</cfquery>

<cfset countyName = "#ucase(left(county.county_name, 1))##lcase(mid(county.county_name, 2, len(county.county_name)))#">

<cfquery name="entry_points" datasource="#application.dbSrc#">
	SELECT *, pt.code AS phonetype_code
	FROM entrypoint_county ec
	LEFT JOIN entrypoint e ON e.entrypoint_id = ec.entrypoint_id
	LEFT JOIN phone p ON p.entrypoint_id = ec.entrypoint_id
	LEFT JOIN phonetype pt ON pt.phonetype_id = p.phonetype_id
	WHERE county_id = #county_id#
	ORDER BY e.name, e.city
</cfquery>

<!--- <cfquery name="programs" datasource="#application.dbSrc#">
	SELECT *	
	FROM entrypoint_county ec	
	LEFT JOIN entrypoint_entrypointgroup ecg ON ecg.entrypoint_id = ec.entrypoint_id	
	LEFT JOIN entrypointgroup epg ON epg.entrypointgroup_id = ecg.entrypointgroup_id
	LEFT JOIN program_entrypointgroup pe ON pe.entrypointgroup_id = ecg.entrypointgroup_id
<!--- 	LEFT JOIN program p ON p.program_id = pe.program_id --->
	
	WHERE ec.county_id = #county_id# LIMIT 0, 100
</cfquery>

<cfdump var="#programs#">
<cfabort>
 --->
<cfoutput>

<script language="Javascript1.2">
	var message = "Print this Page";

	function printpage() {
		window.print();  
		return false;
	}

</script>

<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td class="text1"><span style="float:left; margin-right:4px;"><cf_sessionPassVars href="snap.cfm" prev_id="0" class="snapLink"><cf_displayImage code="img_arrow_left_gif" hspace="0" vspace="0"></cf_sessionPassVars></span> <span style="float:left; padding-bottom:4px;"><cf_sessionPassVars href="counties.cfm" prev_id="0" class="snapLink">Back to State Page</cf_sessionPassVars></span></td>
<td align="right" class="text1"> <span style="float:right; padding-bottom:4px;"><a href="##" onClick="printpage();" class="snapLink">Print this Page</a></span> <span style="float:right; margin-right:4px;"><a href="##" onClick="printpage();" class="snapLink"><cf_displayImage code="img_printer_gif" hspace="0" vspace="0"></a></span></td>
</tr>
</table>


<table cellpadding="0" cellspacing="0" border="0">
<tr>

<td class="text1" valign="top" <!--- width="49%" ---> valign="top">
<h1 class="snapH1" style="margin-top:0px;">Entry Points for #countyName# County</h1>
</cfoutput>

<cfoutput query="entry_points" group="entrypoint_id">
<p><strong>#name#</strong><br />
<cfif trim(address1) IS NOT "">
	#address1#<br />
	<cfif trim(address2) IS NOT "">
		#address2#<br />
	</cfif>
	
	<cfif trim(address3) IS NOT "">
		#address3#<br />
	</cfif>
	#city#, #state_id# &nbsp;#zipcode#<br />
</cfif>
<cfoutput>
#phonetype_code# #number#<br />
</cfoutput>
</p>
</cfoutput>
</td>

<!--- <td width="2%"></td>
<cfoutput>
<td class="text1" valign="top" width="49%" valign="top">

<h1 class="snapH1" style="margin-top:0px;">Entry Points for #countyName# County</h1>

</cfoutput><cfoutput query="entry_points" group="entrypoint_id">
<p><strong>#name#</strong><br />
<cfif trim(address1) IS NOT "">
	#address1#<br />
	<cfif trim(address2) IS NOT "">
		#address2#<br />
	</cfif>
	
	<cfif trim(address3) IS NOT "">
		#address3#<br />
	</cfif>
	#city#, #state_id# &nbsp;#zipcode#<br />
</cfif>
<cfoutput>
#phonetype_code# #number#<br />
</cfoutput>
</p>
</cfoutput>
</td> --->
</table>

