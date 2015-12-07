<cf_sessionloadvars> 
<cfset session.partner_id = 11 >
<cf_tagheader guts="ec" show_title="yes" content_title_override="Application Forms Center" show_left_col="n">
<style type=text/css>
@import url( ../ec/themes/EC/style.css );
</style>
<script src="GUIFiles/sugar.js"></script>
<table cellspacing=0 cellpadding=0 width="100%" border=0>
<tbody>	
<tr>
<td style="PADDING-RIGHT: 8px; PADDING-LEFT: 0px" valign=top  width="20%"><cfinclude template="dspFormMenu.cfm"></td>
<td style="PADDING-RIGHT: 2px; VERTICAL-ALIGN: top" width="80%">
<slot>
 <table class=listview cellspacing=0 cellpadding=0 width="100%" border=0>
        <tbody>
        <tr>
          <td align="right" valign="top"><table cellspacing=0 cellpadding=0 width="100%" border=0>
              <tbody>
              <tr>
                <td class=listviewpaginationtds1 align=center><cfif not isdefined('url.hometext')>
				<h2>How to Search by Drug</h2></cfif></td></tr></tbody></table></td></tr>

			<tr height=20>
			 <td  class=hometext valign=top bgcolor=white colspan=3><p class="text1">The Search by Drug option allows you to search Patient Assistance Program application forms and fact sheets by drug in three different ways, listed below:</p>
				
				<ul class="olex">
				<li class="liec"><strong>All Drugs</strong> includes program information and application forms for both brand name and generic drugs. </li>
				<li class="liec"><strong>Brand Name</strong> includes program information and application forms for brand name drugs. </li>
				<li class="liec"><strong>Generic Drugs</strong> includes program information and application forms for generic drugs. Please note: Most generic drugs are not included in company-sponsored patient assistance programs (PAPs). However if you enter the name of a generic drug, the search will find one or more assistance programs for the brand name version of the generic drug.</li>
				
				</ul>
				<p class="text1">If you don't find your drug listed it is because there is no assistance program or no form associated with the drug at this time.
				</p>
          
			</td>
			</tr>
			</tbody></table>
			</td></tr></tbody></table>

<cf_tagfooter>