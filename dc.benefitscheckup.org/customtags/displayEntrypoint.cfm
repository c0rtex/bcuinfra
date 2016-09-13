
<!--- BS 2008-07-24 converted to use new entrypoint table --->
<cfparam name="attributes.entrypoint_id" type="numeric">
<cfparam name="attributes.mode" type="string" default="screen">
<cfparam name="attributes.reduced" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.append" type="boolean" default="false">
<cfparam name="attributes.google" type="boolean" default="true">
<cfparam name="attributes.wrapUrl" type="boolean" default="false">
<cfparam name="attributes.maskUrl" type="boolean" default="false">

<cfset outstr = ''>
<cfset isPrintMode = Evaluate("attributes.mode eq 'print'")>
<cfquery name="ep" datasource="#application.dbSrc#" maxrows="1">
	select e.code, e.name, e.subname, e.address1, e.address2, e.address3,
		e.city, e.state_id, e.zipcode, e.zipcode_plus4, e.email, e.url,
		e.contact_title, e.contact_first, e.contact_middle, e.contact_last,
		e.contact_suffix, dh.display_code hours_code, di.display_code info_code
	from entrypoint e left outer join display dh
			on e.hours_display_id=dh.display_id
		left outer join display di
			on e.info_display_id=di.display_id
	where e.entrypoint_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.entrypoint_id#" maxlength="6">
		and e.active_flag=1
</cfquery>

<cfquery name="ph" datasource="#application.dbSrc#">
	select p.number, d.display_code
	from phone p, phonetype pt, display d
	where p.entrypoint_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.entrypoint_id#" maxlength="6">
		and p.phonetype_id=pt.phonetype_id
		and pt.display_id=d.display_id
	order by p.sort
</cfquery>

<cfif ep.RecordCount>
	
	<!--- Wrap everything in a div with class 'entry_point --->
	<cfset outstr = outstr & "<div class=""entry_point"">">
	<cfif not attributes.reduced>
		<cfset outstr = outstr & "<br />">
	</cfif>
	<cfset outstr = outstr & "<span class=""epName""><strong>#ep.name#</strong></span><br />">
	<cfif not attributes.reduced>
		<cfif ep.subname neq ''>
			<cfset outstr = outstr & "#ep.subname#<br />">
		</cfif>
		<cfif ep.address1 neq ''>
			<cfset outstr = outstr & "#ep.address1#<br />">
		</cfif>
		<cfif ep.address2 neq ''>
			<cfset outstr = outstr & "#ep.address2#<br />">
		</cfif>
		<cfif ep.address3 neq ''>
			<cfset outstr = outstr & "#ep.address3#<br />">
		</cfif>
		<cfif ep.city neq '' and ep.state_id neq ''>
			<cfset outstr = outstr & "#ep.city#, #ep.state_id#">
			<cfif ep.zipcode neq ''>
				<cfset outstr = outstr & " #ep.zipcode#">
				<cfif trim(ep.zipcode_plus4) neq ''>
					<cfset outstr = outstr & "-#ep.zipcode_plus4#">
				</cfif>
			</cfif>
			<cfset outstr = outstr & "<br />">
		</cfif>
	</cfif>
	<cfif ph.RecordCount>
		<!--- if no address is showing --->
		<cfif not attributes.reduced and ep.address1 eq '' and ep.address2 eq '' and ep.address3 eq '' AND NOT isdefined("session.mZip")>
			<cf_displayText group="site" code="site_ep_no_address" var="eptext">
			<cfset outstr = outstr & "#eptext#<br />">
		</cfif>
		<cfloop query="ph">
			<cf_displayText group="phonetype" code="#display_code#" var="eptext">
			<cfset outstr = outstr & "#eptext#: #number#<br />">
		</cfloop>
	</cfif>
	<cfif not attributes.reduced and ep.email neq ''>
		<cf_displayText group="site" code="site_ep_email_address" var="eptext">
		<cfset outstr = outstr & "#eptext#: ">
		<cfif isPrintMode>
			<cfset outstr = outstr & ep.email>
		<cfelse>
			<cfset outstr = outstr & "<a href=""mailto:#ep.email#"">#ep.email#</a>">
		</cfif>
		<cfset outstr = outstr & "<br />">
	</cfif>
	<cfif ep.url neq ''>
    	<cfif NOT isdefined("session.mProgram") and NOT isdefined("session.maskURL")>
			<cf_displayText group="site" code="site_ep_web_address" var="eptext">
			<cfset outstr = outstr & "#eptext#: ">
        </cfif>
		<cfif isPrintMode>
			<cfset outstr = outstr & ep.url>
		<cfelse>
			<cfif len(ep.url) GT 30 AND attributes.wrapUrl IS TRUE>
				<cfset urlLine1 = left(ep.url, 30)>
				<cfset urlLine2 = right(ep.url, len(ep.url) - 30)>
				<cfset urlMod = urlLine1 & "<br />" & urlLine2>
			<cfelse>
				<cfset urlMod = ep.url>
			</cfif>
            <cfif (isdefined("session.mprogram") AND session.mprogram NEQ "")>
            	<cfset outstr = outstr & "<a href=""#ep.url#"" target=""_blank"">Website</a><br>">
            <cfelseif isdefined("session.maskURL")and session.maskURL EQ "true">
            	<cfset outstr = outstr & "<a href=""#ep.url#"" target=""_blank"">Website</a><br>">
            <cfelse>
            	<cfset outstr = outstr & "<a href=""#ep.url#"" target=""_blank"">#urlMod#</a>">
            </cfif>
		</cfif>
		<cfset outstr = outstr & "<br />">
	</cfif>
	<cfif not attributes.reduced>
		<cfif ep.hours_code neq ''>
			<cf_displayText group="ephours" code="#ep.hours_code#" stripTags="#isPrintMode#" var="ephours" alt="&nbsp;">
			<cfif ephours neq '' and ephours neq '&nbsp;'>
				<cf_displayText group="site" code="site_ep_hours" var="eptext">
				<cfset outstr = outstr & "#eptext#: #ephours#<br />">
			</cfif>
		</cfif>
		<cfif ep.contact_title neq '' or ep.contact_first neq '' or ep.contact_middle neq '' or ep.contact_last neq '' or ep.contact_suffix neq ''>
			<cf_displayText group="site" code="site_ep_contact" var="eptext">
			<cfset outstr = outstr & "#eptext#: #ep.contact_title# #ep.contact_first# #ep.contact_middle# #ep.contact_last# #ep.contact_suffix#<br />">
		</cfif>
		<cfif ep.info_code neq ''>
			<cf_displayText group="epinfo" code="#ep.info_code#" stripTags="#isPrintMode#" var="epinfo" alt="&nbsp;">
			<cfif epinfo neq '' and epinfo neq '&nbsp;'>
				<cf_displayText group="site" code="site_ep_more_info" var="eptext">
				<cfset outstr = outstr & "#eptext#: #epinfo#<br />">
			</cfif>
		</cfif>
	</cfif>
	
	<cfif attributes.google>
		
		<cfif listLen(ep.address1) GT 0>
			<cfif isnumeric(left(ep.address1, 1))>
				<cfset street = listgetat(ep.address1, 1)>
			<cfelse>
				<cfif listLen(ep.address2) GT 0>
					<cfset street = listgetat(ep.address2, 1)>
				<cfelse>
						<cfset street = "">
				</cfif>
			</cfif>
		<cfelse>
			<cfset street = "">
		</cfif>
		<cfsavecontent variable="externalLink">
			<cf_displayImage code="img_link_to_external_site_gif" height="10" width="10" hspace="0" vspace="0" border="0">
		</cfsavecontent>
		<cfset address = urlencodedformat("#street#, #ep.city#, #ep.state_id# #ep.zipcode#")>
		<cfif trim(street) IS NOT "">
			<cfset outstr = outstr & '<a href="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=#address#&ie=UTF8&z=16&iwloc=addr" target="map">View Map</a><br />'>
		</cfif>
	</cfif>
	<cfset outstr = outstr & "</div>">	
	

</cfif>

<cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelseif attributes.append><cfsilent>
	<cfset "caller.#attributes.var#" = Evaluate("caller.#attributes.var#") & outstr>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outstr>
</cfsilent></cfif>