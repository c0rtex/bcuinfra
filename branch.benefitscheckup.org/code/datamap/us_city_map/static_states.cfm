<cfset qStates = createObject("component","com.bcu.mippaHandler").getStates()>

<cfsetting showdebugoutput="No">
<cfcontent type="text/xml">
<usa>
    <config>
      <background_color>ffffff</background_color>
      <button_back_text>BACK</button_back_text>
      <sound>off</sound>
      <button_back_javascript>javascript:hideOffices();</button_back_javascript>
    </config>
	<map>
		<cfoutput query="qStates">
        <state>
            <id>#state_map_code2#</id>
            <name>#state_name#</name>
            <map></map>
            <info></info>
            <color>7190C8</color>
            <color2>366CA3</color2>
            <xml></xml>
            <image> </image>
            <xml_points> </xml_points>
            <url></url>
        </state>
		</cfoutput>
        <state visible_state='0'>
             <id>52</id>
             <name>Puerto Rico</name>
             <map>maps/pr.swf</map>
             <info></info>
             <color>012056</color>
             <color2>366CA3</color2>
             <xml>maps/pr.xml</xml>
             <image></image>
             <xml_points>maps/pr_data.xml</xml_points>
             <url>http://www.google.com</url>
        </state>
        <state visible_state='0'>
         	<id>53</id>
         	<name>Virgin</name>
         	<map>maps/vi.swf</map>
         	<info></info>
         	<color>012056</color>
         	<color2>366CA3</color2>
         	<xml>maps/vi.xml</xml>
         	<image></image>
         	<xml_points>maps/vi_data.xml</xml_points>
         	<url></url>
        </state>
        <state visible_state='0'>
         	<id>53</id>
         	<name>Guam</name>
         	<map>maps/gu.swf</map>
         	<info></info>
         	<color>012056</color>
         	<color2>366CA3</color2>
         	<xml>maps/gu.xml</xml>
         	<image></image>
         	<xml_points>maps/gu_data.xml</xml_points>
         	<url></url>
        </state>
	</map>
</usa>