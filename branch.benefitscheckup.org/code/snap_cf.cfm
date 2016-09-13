<script src="js/AC_RunActiveContent.js" type="text/javascript"></script>
<cfif IsDefined('URL.partner_id')>
	<cfset SESSION.partner_id = URL.partner_id>
</cfif>

<cfif session.partner_id IS 56>
	<cfset session.partner_id = 22>
</cfif>

<cfif IsDefined('URL.partner_id') AND URL.partner_id EQ 22>
	<cfset SESSION.partner_id = 22>
</cfif>

<cfif IsDefined('URL.partner_id') AND URL.partner_id EQ 0>
	<cfset SESSION.partner_id = 0>
</cfif>

<cfif NOT IsDefined('SESSION.partner_id')>
	<cfset SESSION.partner_id = 0>
</cfif>




<script type="text/javascript">
$(document).ready(function(){
var partnerID = "<cfoutput>#SESSION.partner_id#</cfoutput>";
if (partnerID == 22 || partnerID == 89 || partnerID == 90) {
//console.log ("AARP");
$ (".fm-map-container").appendTo ($(".contentcol2")); //so that the maps fall within the blue frame
}


    $('#go_button_submit').click(function() {
      if($('#state').val() == '') {
          alert('You must select a state before clicking the Go button.');
      return false;
     }
   });
 //console.log ("TEST + <cfoutput>#SESSION.partner_id#</cfoutput>");

for (var i=1;i<=54;i++){
this_state_id = "st"+i;
var stateLink = map.fetchStateAttr(this_state_id, 'link');
stateLink = stateLink.replace ("partner_id=0", "partner_id=<cfoutput>#SESSION.partner_id#</cfoutput>");
map.setLink(this_state_id, stateLink); //Lynna Cekova: so that partner branding is kept
//console.log("state link: "+stateLink);
}



 var optionSelected = $("#state").find("option:selected");
     var valueSelected  = optionSelected.val();
      if(valueSelected != '') {
state_case = valueSelected;
highlightState (state_case);
}

    $('#state').change(function() { //Lynna Cekova, TODO, replace for upon select change



 var optionSelected = $(this).find("option:selected");
     var valueSelected  = optionSelected.val();

      if(valueSelected == '') {

     }


  state_switch="none"; 

state_case = valueSelected;

highlightState (state_case);

   });


function highlightState (state_case){


//console.log ("map state id" + map_state_id);

switch (state_case)
{
case "Alabama":
  state_switch="AL"; 
  map_state_id = "st1"; break;
case "Alaska":
  state_switch="AK"; 
  map_state_id = "st2"; break;
case "Arizona":
  state_switch="AZ"; 
  map_state_id = "st3"; break;
case "Arkansas":
  state_switch="AR";
  map_state_id = "st4"; break;
case "California":
  state_switch="CA"; 
  map_state_id = "st5"; break;
case "Colorado":
  state_switch="CO"; 
  map_state_id = "st6"; break;
case "Connecticut":
  state_switch="CT";
  map_state_id = "st7"; break;
case "Delaware":
  state_switch="DE";
  map_state_id = "st8"; break;
case "Washington, DC":
  state_switch="DC"; 
  map_state_id = "st9"; break;
case "Florida":
  state_switch="FL";
  map_state_id = "st10"; break;
case "Geogia":
  state_switch="GA"; 
  map_state_id = "st11"; break;
case "Hawaii":
  state_switch="HI"; 
  map_state_id = "st12"; break;
case "Idaho":
  state_switch="ID"; 
  map_state_id = "st13"; break;
case "Illinois":
  state_switch="IL"; 
  map_state_id = "st14"; break;
case "Indiana":
  state_switch="IN"; 
  map_state_id = "st15"; break;
case "Iowa":
  state_switch="IA"; 
  map_state_id = "st16"; break;
case "Kansas":
  state_switch="KS"; 
  map_state_id = "st17"; break;
case "Kentucky":
  state_switch="KY"; 
  map_state_id = "st18"; break;
case "Louisiana": 
  state_switch="LA"; 
  map_state_id = "st19"; break;
case "Maine":
  state_switch="ME"; 
  map_state_id = "st20"; break;
case "Maryland":
  state_switch="MD"; 
  map_state_id = "st21"; break;
case "Massachusetts": 
  state_switch="MA"; 
  map_state_id = "st22"; break;
case "Michigan":
  state_switch="MI"; 
  map_state_id = "st23"; break;
case "Minnesota":
  state_switch="MN"; 
  map_state_id = "st24"; break;
case "Mississippi":
  state_switch="MS"; 
  map_state_id = "st25"; break;
case "Missouri":
  state_switch="MO";
  map_state_id = "st26"; break;
case "Montana":
  state_switch="MT"; 
  map_state_id = "st27"; break;
case "Nebraska": 
  state_switch="NE"; 
  map_state_id = "st28"; break;
case "Nevada":
  state_switch="NE"; 
  map_state_id = "st29"; break;
case "New Hampshire":
  state_switch="NH"; 
  map_state_id = "st30"; break;
case "New Jersey":
  state_switch="NJ"; 
  map_state_id = "st31"; break;
case "New Mexico":
  state_switch="NM"; 
  map_state_id = "st32"; break;
case "New York":
 state_switch="NY";
 map_state_id = "st33"; break;
case "North Carolina":
  state_switch="NC";
  map_state_id = "st34"; break;
case "North Dakota": 
  state_switch="ND"; 
  map_state_id = "st35"; break;
case "Ohio":
  state_switch="OH"; 
  map_state_id = "st36"; break;
case "Oklahoma":
  state_switch="OK";
  map_state_id = "st37"; break;
case "Oregon":
  state_switch="OR"; 
  map_state_id = "st38"; break;
case "Pennsylvania":
  state_switch="PA";
  map_state_id = "st39"; break;
case "Rhode Island":
  state_switch="RI"; 
  map_state_id = "st40"; break;
case "South Carolina": 
  state_switch="SC"; 
  map_state_id = "st41"; break;
case "South Dakota":
  state_switch="SD"; 
  map_state_id = "st42"; break;
case "Tennessee":
  state_switch="TN"; 
  map_state_id = "st43"; break;
case "Texas":
  state_switch="TX"; 
  map_state_id = "st44"; break;
case "Utah":
  state_switch="UT"; 
  map_state_id = "st45"; break;
case "Vermont":
  state_switch="VT"; 
  map_state_id = "st46"; break;
case "Virginia":
  state_switch="VA"; 
  map_state_id = "st47"; break;
case "Washington":
  state_switch="WA"; 
  map_state_id = "st48"; break;
case "West Virginia":
  state_switch="WV"; 
  map_state_id = "st49"; break;
case "Wisconsin":
  state_switch="WI"; 
  map_state_id = "st50"; break;
case "Wyoming":
  state_switch="WY"; 
  map_state_id = "st51"; break;    
case "Virgin Islands":
  state_switch="VI"; 
  map_state_id = "st53"; break;
case "Puerto Rico":
  state_switch="PR"; 
  map_state_id = "st52"; break;
case "Guam":
  state_switch="GU"; 
  map_state_id = "st54"; break;
default:
  state_switch='';               
}


for (var i=1;i<=54;i++){
the_state_id = "st"+i;
map.stateHighlightOff(the_state_id);
}
map.stateHighlightOn(map_state_id);



}


});
</script>

<!Lynna Cekova, Bug 8835; use this list in listing # of seniors per state below in the comment rather than just state name--->
		<cfquery name="getStateInfo" datasource="#application.dbSrc#">
select s.state_name, ssn.state_id, ssn.snap_seniors from state_snap ssn, state s
where ssn.year = '#year(now())#' and ssn.state_id = s.state_id

		</cfquery>

<!---<cfoutput query='getStateInfo'> <br/>#getStateInfo.state_id#< #getStateInfo.snap_seniors#</cfoutput>--->
 
<cfloop query="getStateInfo"> 
<!---
    <cfoutput> 
TESTTHIS
#getStateInfo.state_name#
#getStateInfo.state_id#< #getStateInfo.snap_seniors#<

    </cfoutput> 
--->

<script type="text/javascript">
$(document).ready(function(){
switch ("<cfoutput>#getStateInfo.state_id#</cfoutput>")
{
case "AL":
  map_state_id = "st1"; break;
case "AK":
  map_state_id = "st2"; break;
case "AZ":
  map_state_id = "st3"; break;
case "AR":
  map_state_id = "st4"; break;
case "CA":
  map_state_id = "st5"; break;
case "CO":
  map_state_id = "st6"; break;
case "CT":
  map_state_id = "st7"; break;
case "DE":
  map_state_id = "st8"; break;
case "DC":
  map_state_id = "st9"; break;
case "FL":
  map_state_id = "st10"; break;
case "GA":
  map_state_id = "st11"; break;
case "HI":
  map_state_id = "st12"; break;
case "ID":
  map_state_id = "st13"; break;
case "IL":
  map_state_id = "st14"; break;
case "IN":
  map_state_id = "st15"; break;
case "IA":
  map_state_id = "st16"; break;
case "KS":
  map_state_id = "st17"; break;
case "KY":
  map_state_id = "st18"; break;
case "LA": 
  map_state_id = "st19"; break;
case "ME":
  map_state_id = "st20"; break;
case "MD":
  map_state_id = "st21"; break;
case "MA": 
  map_state_id = "st22"; break;
case "MI":
  map_state_id = "st23"; break;
case "MN":
  map_state_id = "st24"; break;
case "MS":
  map_state_id = "st25"; break;
case "MO":
  map_state_id = "st26"; break;
case "MT":
  map_state_id = "st27"; break;
case "NE": 
  map_state_id = "st28"; break;
case "NV":
  map_state_id = "st29"; break;
case "NH":
  map_state_id = "st30"; break;
case "NJ":
  map_state_id = "st31"; break;
case "NM":
  map_state_id = "st32"; break;
case "NY":
 map_state_id = "st33"; break;
case "NC":
  map_state_id = "st34"; break;
case "ND": 
  map_state_id = "st35"; break;
case "OH":
  map_state_id = "st36"; break;
case "OK":
  map_state_id = "st37"; break;
case "OR":
  map_state_id = "st38"; break;
case "PA":
  map_state_id = "st39"; break;
case "RI":
  map_state_id = "st40"; break;
case "SC": 
  map_state_id = "st41"; break;
case "SD":
  map_state_id = "st42"; break;
case "TN":
  map_state_id = "st43"; break;
case "TX":
  map_state_id = "st44"; break;
case "UT":
  map_state_id = "st45"; break;
case "VT":
  map_state_id = "st46"; break;
case "VA":
  map_state_id = "st47"; break;
case "WA":
  map_state_id = "st48"; break;
case "WV":
  map_state_id = "st49"; break;
case "WI":
  map_state_id = "st50"; break;
case "WY":
  map_state_id = "st51"; break;    
case "VI":
  map_state_id = "st53"; break;
case "PR":
  map_state_id = "st52"; break;
case "GU":
  map_state_id = "st54"; break;
default:
  map_state_id = "none"; break;
}

//console.log ("<br>map state id" + map_state_id);

//console.log (" state id: <cfoutput>#getStateInfo.state_id#</cfoutput>")
map.setComment(map_state_id, "In <cfoutput>#getStateInfo.state_name#</cfoutput>, over <cfoutput>#NumberFormat(getStateInfo.snap_seniors, ",")#</cfoutput> seniors are using SNAP to stretch their grocery budget. Are you?"); 

var stateComment = map.fetchStateAttr(map_state_id, 'comment');

//console.log("map state comment: " + stateComment);



});
</script>
</cfloop>





<h1 class="indexh1"<cfif session.partner_id NEQ 89 and session.partner_id neq 90> align="center"<cfelse> style="text-align:center;"</cfif>>Welcome to the SNAP Map</h1>

 <p style="line-height:1.3em;">The Supplemental Nutrition Assistance Program (SNAP) (the new name for the
federal Food Stamp Program) helps low-income individuals and families buy the
food they need for good health. Although SNAP is the national name, your state may use a different name.
</p>
<p style="line-height:1.3em;">Use this map to learn more about SNAP and find application forms to apply for this benefit.</p>
<!---p style="line-height:1.3em;"><font color="red"><strong>Hurricane Sandy Relief:</strong></font> The federal government is working with your state to expand the SNAP program to offer food assistance after Hurricane Sandy.  You may get additional SNAP benefits to help replace food you lost and buy hot food with your EBT card, depending on where you live. In some areas, you may be able to apply and get SNAP benefits quickly, even if you were not able to get help from the program in the past.  To find out what SNAP benefits are available to you, get more information <a href="http://www.fns.usda.gov/disasters/response/pdf/Hurricane_Sandy.pdf" target="_blank">here</a>.</p--->
<!---<p class="text1"><cf_displayText group="site" code="site_snap_home_intro"></p>--->
<!---<cf_sessionPassVars action="snap_state.cfm" method="post" partner_id="#session.partner_id#">--->
<form action="snap_state.cfm?partner_id=<cfoutput>#session.partner_id#</cfoutput>" method="post">
<center>
<cfoutput><cfif IsDefined("url.partner_id")><cfset SESSION.partner_id = #url.partner_id#></cfif></cfoutput>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="700">
	<tr>
    <td><cfif session.partner_id EQ 0 OR session.partner_id EQ 77><p<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR session.partner_id EQ 77)> </cfif><strong>Start your search</strong>, <em>click</em> on your state <strong>OR</strong> select your state.
		<cfelse><p></cfif> </td>
<!--- Lynna Cekova: removed after replacing SNAP map with HTML5   <cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id NEQ 0 OR session.partner_id EQ 77)>align="center"</cfif> --->

<td style="width:450px;">    <select id="state" name="state">
<option value="">--- Select Your State ---</option>
<option value="Alaska">AK - Alaska</option>
<option value="Alabama">AL - Alabama</option>
<option value="Arkansas">AR - Arkansas</option>
<option value="Arizona">AZ - Arizona</option>
<option value="California">CA - California</option>
<option value="Colorado">CO - Colorado</option>
<option value="Connecticut">CT - Connecticut</option>
<option value="Washington, DC">DC - Washington, DC</option>
<option value="Delaware">DE - Delaware</option>
<option value="Florida">FL - Florida</option>
<option value="Georgia">GA - Georgia</option>
<option value="Guam">GU - Guam</option>
<option value="Hawaii">HI - Hawaii</option>
<option value="Iowa">IA - Iowa</option>
<option value="Idaho">ID - Idaho</option>
<option value="Illinois">IL - Illinois</option>
<option value="Indiana">IN - Indiana</option>
<option value="Kansas">KS - Kansas</option>
<option value="Kentucky">KY - Kentucky</option>
<option value="Louisiana">LA - Louisiana</option>
<option value="Massachusetts">MA - Massachusetts</option>
<option value="Maryland">MD - Maryland</option>
<option value="Maine">ME - Maine</option>
<option value="Michigan">MI - Michigan</option>
<option value="Minnesota">MN - Minnesota</option>
<option value="Missouri">MO - Missouri</option>
<option value="Mississippi">MS - Mississippi</option>
<option value="Montana">MT - Montana</option>
<option value="North Carolina">NC - North Carolina</option>
<option value="North Dakota">ND - North Dakota</option>
<option value="Nebraska">NE - Nebraska</option>
<option value="New Hampshire">NH - New Hampshire</option>
<option value="New Jersey">NJ - New Jersey</option>
<option value="New Mexico">NM - New Mexico</option>
<option value="Nevada">NV - Nevada</option>
<option value="New York">NY - New York</option>
<option value="Ohio">OH - Ohio</option>
<option value="Oklahoma">OK - Oklahoma</option>
<option value="Oregon">OR - Oregon</option>
<option value="Pennsylvania">PA - Pennsylvania</option>
<option value="Puerto Rico">PR - Puerto Rico</option>
<option value="Rhode Island">RI - Rhode Island</option>
<option value="South Carolina">SC - South Carolina</option>
<option value="South Dakota">SD - South Dakota</option>
<option value="Tennessee">TN - Tennessee</option>
<option value="Texas">TX - Texas</option>
<option value="Utah">UT - Utah</option>
<option value="Virginia">VA - Virginia</option>
<option value="Virgin Islands">VI - Virgin Islands</option>
<option value="Vermont">VT - Vermont</option>
<option value="Washington">WA - Washington</option>
<option value="Wisconsin">WI - Wisconsin</option>
<option value="West Virginia">WV - West Virginia</option>
<option value="Wyoming">WY - Wyoming</option>
</select>


	<input id="go_button_submit" type="submit" value="GO" />

</td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="700">
<tr><td>
<!-- start Fla-shop.com HTML5 Map -->
	<div id='container'></div>
	<link href="/cf/usa_locator/map.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="/cf/usa_locator/raphael-min.js"></script>
	<script type="text/javascript" src="/cf/usa_locator/settings.js"></script>
	<script type="text/javascript" src="/cf/usa_locator/map.js"></script>
	<script>
	var map = new FlaMap(map_cfg);
	map.draw('container');
	</script>
<!-- end HTML5 Map -->



</td></tr>

</table>
</form>
</center>
