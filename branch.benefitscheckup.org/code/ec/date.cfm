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
				<h2>How to Search by Date</h2></cfif></td></tr></tbody></table></td></tr>

			<tr height=20>
			 <td  class=hometext valign=top bgcolor=white colspan=3><p class="text1">The Search by Date option allows you to search applications by two different dates, listed below:</p>
				
				<ul class="olex">
				<li class="liec"><strong>Latest Forms</strong> lists by the date the forms were last updated by the agency or company providing the benefit. </li>
				<li class="liec"><strong>Latest Entered</strong> lists by the date they were added to the Application Form Center.  </li>
				
				</ul>
          
			</td>
			</tr>
			</tbody></table>
			</td></tr></tbody></table>

<cf_tagfooter>