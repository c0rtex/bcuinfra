<cf_sessionLoadVars>
<cf_buildHTML cellpadding="12" cellspacing="2" jsInclude="true">
<h2>Jump to Questionnaire</h2>

<cf_cacheSubsetPool action="get" var="spool">
<cf_cachePartnerPool action="get" var="ppool">
<cf_cacheStatePool action="get" var="stpool">

<form action="dispatchSPQ.cfm" method="post">

	<b>q'aire:</b>&nbsp;
	<select name="qaire">
		<option value="0">Single-Page</option>
		<option value="1">Printed</option>
		<option value="2">Interactive</option>
	</select><br><br>
	
	<b>subset:</b>&nbsp;
	<select name="subset_id">
		<option value="0">-- select subset --</option>
		<cfloop list="#ListSort(StructKeyList(spool.id), 'numeric')#" index="subsetID">
			<cf_cacheSubsetPool action="get" subset_id="#subsetID#" var="sobj">
			<cf_displayText group="subset" code="subset_#StructFind(spool.id, subsetID)#" stripTags="true" var="stext">
			<cfoutput><option value="#subsetID#">#subsetID# - #stext#</option></cfoutput>
		</cfloop>
	</select><br><br>
	
	<b>partner:</b>&nbsp;
	<select name="partner_id">
		<option value="0">-- select partner --</option>
		<option value="0">none</option>
		<cfloop list="#ListSort(StructKeyList(ppool.id), 'numeric')#" index="partnerID">
			<cfoutput><option value="#partnerID#">#partnerID# - #StructFind(ppool.id, partnerID)#</option></cfoutput>
		</cfloop>
	</select><br><br>
	
	<b>state:</b>&nbsp;
	<select name="state_id">
		<option value="IL">-- select state --</option>
		<cf_loopPoolStruct struct="stpool" index="stateID">
			<cf_cacheStatePool action="get" state_id="#stateID#" var="stateStruct">
			<cfif stateStruct.type eq 'state'>
				<cfoutput><option value="#stateID#">#stateStruct.name#</option></cfoutput>
			</cfif>
		</cf_loopPoolStruct>
	</select><br><br>
	
	<b>zipcode:</b>&nbsp;
	<input type="text" name="zip" value="" size="8" onKeyUp="var stcode = ''; if (this.value.length == 5) stcode = getStateFromZip(this.value); if (stcode != '') this.form.state_id.value = stcode;"><br /><br />
	
	<b>org id:</b>&nbsp;
	<input type="text" name="org_id" value="0" size="5"><br /><br />
	
	<b>prev id:</b>&nbsp;
	<input type="text" name="prev_id" value="0" size="5"><br /><br />
	
	<input type="submit" value=" jump ">

</form>

</cf_buildHTML>