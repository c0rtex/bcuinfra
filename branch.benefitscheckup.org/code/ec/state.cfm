<cf_sessionloadvars> 
<cfparam name="st" default="">
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
				<h2>How to Search by State</h2></cfif></td></tr></tbody></table></td></tr>

			<tr height=20>
			 <td  class=hometext valign=top bgcolor=white colspan=3><p class="text1">The Search by State option will return all available state program application forms for the selected state, including: state-sponsored prescription assistance programs, Medicaid, Medicaid Spend-Down, and Medicare Savings Programs.</p>

				</ul>
          
			</td>
			</tr>
			</tbody></table>
			</td></tr></tbody></table>

<cf_tagfooter>