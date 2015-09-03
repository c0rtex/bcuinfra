<cfsilent>
<!--- MH: Bug 5265 Pull GU state info also --->
<!--- Original WHERE clause before removing VI and GU in #7115 --->
	<!--- WHERE statetype_id = 1 OR state_id = 'VI' OR state_id = 'PR' or state_id = 'GU' --->
<cfquery name="states" datasource="#application.dbSrc#">
	SELECT state_id, state_name, state_map_code2, state_map_code
	FROM state
	WHERE statetype_id = 1 OR state_id = 'VI' OR state_id = 'PR' or state_id = 'GU'
	ORDER BY state_map_code, state_map_code2
</cfquery>

</cfsilent>


<cfcontent type="text/xml"><usa_map_locator>

<config>
  <color_state_name>0xffffff</color_state_name>
  <color_state_name_over>0xffffff</color_state_name_over>
  <type_of_gradient>1</type_of_gradient>
  <background_color>0xffffff</background_color>
  <show_links>0</show_links>
  <light_effect>1</light_effect>
  <border_color>0xffffff</border_color>
  <sound>off</sound>
</config>

<map_data>
<cfoutput query="states">

<state>
  <id>#val(state_map_code)#</id>
  <name>#state_name#</name>
  <link>snap_state.cfm?state=#urlencodedformat(state_name)#&partner_id=#session.partner_id#&org_id=#session.org_id#</link>
  <comment></comment> 
  <cfif IsDefined("SESSION.partner_id") AND SESSION.partner_id EQ 77>
    <color_map>0x0098BA</color_map>
    <color_map_over>0x0075AE</color_map_over>
  <cfelse>
      <color_map>0xDAA869</color_map>
      <color_map_over>0x8a6b44</color_map_over>
  </cfif>	
  <frame>_top</frame>
  <image></image>
</state>

</cfoutput>

<!--- Remove for #7115 temporarily --->
<!---cfoutput>

<state>
  <id>53</id>
  <name>Guam</name>
  <!---MH: 5/7/10 Bug 5265 Added link to GU --->
  <link>snap_state.cfm?state=Guam&partner_id=#session.partner_id#&org_id=#session.org_id#</link>
  <comment></comment> 
  <cfif IsDefined("SESSION.partner_id") AND SESSION.partner_id EQ 77>
    <color_map>0xFDB813</color_map>
    <color_map_over>0xF1601B</color_map_over>
  <cfelse>
      <color_map>0xDAA869</color_map>
      <color_map_over>0x8a6b44</color_map_over>
  </cfif--->
  <!---frame>_top</frame>
  <image></image>
</state>
</cfoutput --->

</map_data>
</usa_map_locator>