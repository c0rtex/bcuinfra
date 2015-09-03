<cfset qStates = createObject("component","com.bcu.mippaHandler").getStates()>
<cfset tdstamp="#DateFormat(Now(),'mmddyyyy')##TimeFormat(Now(),'hhmmss')#">
<!--- Create a random number. --->
<cfset randomnum1=RAND()*100000000>
<!--- Create another random number. --->
<cfset randomnum2=RAND()*100000000>
<!--- Concatenate the first random number, the time and date stamp, and the second random number. --->
<cfset uniquenumber="#randomnum1##tdstamp##randomnum2#">

<cfsetting showdebugoutput="No">
<cfcontent type="text/xml">

<usa>
    <config>
      <background_color>ffffff</background_color>
      <button_back_text>BACK</button_back_text>
      <sound>off</sound>
      <button_back_javascript>javascript:mippa.backToStates();</button_back_javascript>
      <fontsize_popup>16</fontsize_popup>
    </config>
	<map>
		<cfoutput query="qStates">
        	<cfif session.mData NEQ "">
                <cfquery name="statedata" datasource="#application.dbSrc#">
                    SELECT de.#session.mData#, de.year, mp_codebook2.type_of_variable AS type
                    FROM mp_dataelement2 AS de INNER JOIN mp_codebook2 ON mp_codebook2.variable_label = '#session.mData#'
                    WHERE  (de.year =
                      (SELECT MAX(year) AS Expr1
                       FROM  mp_dataelement2 AS mp_dataelement_1
                       WHERE mp_dataelement_1.#session.mData# <> 0))
                    AND de.state = '#state_name#' AND (de.county = 'Statewide' OR de.county = 'District of Columbia')
                </cfquery>
                <cfif statedata.recordCount gt 0>
					<cfset testNum = evaluate('statedata.#session.mData#')>
                    <cfset amtText = "Number">
                    <cfif testNum IS "" OR testNum is "NULL">
            			<cfset testNum = 0>
                    <cfelseif  statedata.type IS 'percent' AND testNum LT 1>
                        <cfset testNum = NumberFormat(testNum * 100,"99.99") &"%">
                        <cfset amtText = "Percent">
                    <cfelseif statedata.type IS 'percent' AND testNum EQ 1>
						<cfset testNum = "100%">
                        <cfset amtCText = "Percent">
                    <cfelse>
                        <cfset testNum = NumberFormat(testNum)>
                    </cfif>
                <cfelse>
                	<cfset testNum = 0>
                    <cfset amtText = "Number">
                </cfif>
            </cfif>
            <cfset newStateID = state_id & "-" & uniquenumber>
        <state>
            <id>#state_map_code2#</id>
            <name>#state_name#</name>
            <map>us_city_map/maps/#LCase(state_id)#.swf</map>
            <info>&lt;b&gt;#state_name#&lt;&frasl;b&gt;<cfif session.mData NEQ "">&lt;br&gt;Year:&nbsp;#statedata.year#&lt;br&gt;#amtText#:&nbsp;#testNum#</cfif>
            </info>
            <color>7190C8</color>
            <color2>366CA3</color2>
            <xml>us_city_map/counties.cfm?state=#newStateId#</xml>
            <image></image>
            <xml_points>us_city_map/maps/#LCase(state_id)#_data.xml</xml_points>
            <url>javascript:mippa.processState('#state_id#');</url> 
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