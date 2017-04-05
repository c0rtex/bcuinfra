<!---
Template Name: custom tag buildHTML.cfm
Component Purpose: Generates HTML content for LIS app
Data Tables: NA	
--->
<cfsilent>
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.onLoad" type="string" default="">
<cfparam name="attributes.onUnload" type="string" default="">
<cfparam name="attributes.width" type="string" default="100%">
<cfparam name="attributes.align" type="string" default="center">
<cfparam name="attributes.border" type="numeric" default="0">
<cfparam name="attributes.cellpadding" type="numeric" default="0"><!--- was 12 --->
<cfparam name="attributes.cellspacing" type="numeric" default="0"><!--- was 2 --->
<cfparam name="attributes.bgcolor" type="string" default="##ffffff">
<cfparam name="attributes.style" type="string" default="font-family: verdana, arial, helvetica, sans-serif; font-size: 11pt; color: black;">
<cfparam name="attributes.expires" type="boolean" default="false">
<cfparam name="attributes.allowBack" type="string" default="true">
<cfparam name="attributes.refreshurl" type="string" default="">
<cfparam name="attributes.refreshsec" type="numeric" default="5">
<cfparam name="attributes.sidebar" type="boolean" default="false">
<cfparam name="attributes.jsInclude" type="boolean" default="false">
<!--- START annoying attributes to pass through to tagHeader.cfm --->
<cfparam name="attributes.guts" type="string" default="">
<cfparam name="attributes.show_title" type="string" default="">
<cfparam name="attributes.show_left_col" type="string" default="">
<cfparam name="attributes.content_title_override" type="string" default="">
<cfparam name="attributes.meta_title" type="string" default="">
<cfparam name="attributes.meta_description" type="string" default="">
<cfparam name="url.partner_id" type="numeric" default="0">
<!--- END annoying attributes --->
<cfif IsDefined('SESSION.partner_id') AND SESSION.partner_id NEQ ''>
	<cfset attributes.partner_id = SESSION.partner_id>
</cfif>

<cfif attributes.partner_id eq ''>
	<cfif IsDefined('session.subset_id') and session.subset_id neq '' and IsNumeric(session.subset_id)>
		<cf_cacheSubsetPool action="get" subset_id="#session.subset_id#" var="sobj">
        <!--- Start debug ---><cfoutput>ln 31 - branding_partner_id is |#sobj.brand#|<BR /></cfoutput><!--- End debug --->
        <cfif sobj.brand eq ''>
        	<cfset attributes.partner_id = 0>
        <cfelse>
	        <cfset attributes.partner_id = sobj.brand>
        </cfif>
	</cfif>
</cfif>
<cfif attributes.partner_id eq ''>
	<cfif IsDefined('session.partner_id') and session.partner_id neq '' and IsNumeric(session.partner_id)>
		<cfset attributes.partner_id = session.partner_id>
         <cfoutput>ln 38 - attrib_pid = |#attributes.partner_id#|<BR /></cfoutput>
	<cfelse>
		<cfset attributes.partner_id = 0>
		<cfset session.partner_id = 0>
        <!--- Start debug --->
		<cfoutput>ln 42 - attrib_pid = |0| AND session_pid = |0|<BR /></cfoutput><br />
		<cfabort> <!--- End debug --->
	</cfif>
</cfif>
</cfsilent><cfif ThisTag.ExecutionMode eq 'Start'>
	<cfif attributes.expires>
		<cfheader name="expires" value="#Now()#">
		<cfhtmlhead text="<meta http-equiv=""pragma"" content=""no-cache"">">
		<cfhtmlhead text="<meta http-equiv=""expires"" content=""Tue, 01 Jan 1980 1:00:00 GMT"">">
		<cfhtmlhead text="<meta http-equiv=""cache-control"" content=""no-cache"">">
	</cfif>
	<cfoutput>#attributes.meta_title#"</cfoutput>
	<cfif IsDefined('SESSION.partner_id') >
	<cf_tagHeader partner_id="#attributes.partner_id#" onLoad="#attributes.onLoad#" onUnload="#attributes.onUnload#" refreshurl="#attributes.refreshurl#" refreshsec="#attributes.refreshsec#" sidebar="#attributes.sidebar#" allowBack="#attributes.allowBack#" guts="#attributes.guts#" show_title="#attributes.show_title#" show_left_col="#attributes.show_left_col#" content_title_override="#attributes.content_title_override#" meta_title="#attributes.meta_title#" meta_description="#attributes.meta_description#">
	</cfif>
	<cfif attributes.jsInclude>
		<script language="JavaScript" type="text/javascript" src="/cf/include/select.js"></script>
		<script language="javascript" type="text/javascript" src="/cf/include/ziplist.js"></script>
		<script language="javascript" type="text/javascript" src="/cf/include/zipcheck.js"></script>
	</cfif>
	<script language="JavaScript" type="text/javascript" src="/cf/include/popup.js"></script>
	<cf_buildPopupStyle>
	<div id="popupLayer" class="defPopup">
		<p id="popupClose" class="defPopupClose"></p>
		<p id="popupTitle" class="defPopupTitle"></p>
		<p id="popupBody"></p>
	</div>
	<div id="shadowLayer" class="defPopupShadow"></div>
	<script language="JavaScript">
		addEvent(document.getElementById('shadowLayer'), 'click', hidePopup, false);
	</script>
	<!---<cfoutput>
	<table width="#attributes.width#" border="#attributes.border#" align="#attributes.align#" cellpadding="#attributes.cellpadding#" cellspacing="#attributes.cellspacing#">
		<tr>
			<td bgcolor="#attributes.bgcolor#" style="#attributes.style#">
			
	</cfoutput>--->
<cfelse>
			<!---</td>
		</tr>
	</table>--->
	<cfif IsDefined('SESSION.partner_id')>
	<cf_tagFooter partner_id="#attributes.partner_id#">
	</cfif>
</cfif>