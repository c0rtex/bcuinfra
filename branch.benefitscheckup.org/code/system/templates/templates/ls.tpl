{include file="header.tpl"}	
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}AnchorPosition.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}date.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}PopupWindow.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var cal = new CalendarPopup();
var httpRequest;
</SCRIPT>
<form name="form1" method="post" action="{$smarty.server.PHP_SELF}">
<table align="center">
  <tr>
    <td>Start Date</td>
    <td>End Date</td>
    <td>Status</td>
    <td>Org Id</td>
    <td>Screening Id</td>        
    <td>Partner Id</td>        
    <td></td>
  </tr>
  <tr>
    <td><input type="text" name="start_date" id="start_date" value="{if $smarty.session.start_date}{$smarty.session.start_date}{else}{$smarty.now|date_format:"%Y-%m-%d"}{/if}" onClick="cal.select(document.forms['form1'].start_date,'start_date','yyyy-MM-dd'); return false;"></td>
    <td><input type="text" name="end_date" id="end_date" value="{if $smarty.session.end_date}{$smarty.session.end_date}{else}{$smarty.now|date_format:"%Y-%m-%d"}{/if}" onClick="cal.select(document.forms['form1'].end_date,'end_date','yyyy-MM-dd'); return false;"></td>
    <td><select name="status">
		<option value="" selected>All</option>
		{html_options options=$status selected=$status_selected}
    	</select></td>
    <td><input type="text" name="org_id" value="{$smarty.session.org_id}"></td>
    <td><input type="text" name="screening_id" value="{$smarty.session.screening_id}"></td>    
    <td><input type="text" name="partner_id" value="{$smarty.session.partner_id}"></td>    
    <td><input type="submit" name="Submit" value="Search"></td>
  </tr> 
</table>
</form>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="2">
	<tr>
		<td bgcolor="#ffffff" colspan="5" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 10pt; color: black;">
		<div align="center"><font size="5">Submission Logs</font></div></td>
	</tr>	
	<tr>
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=ss.file_name&dir={$dir}">File</a></td>
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=ss.post_finish_time&dir={$dir}">Date</a></td>					
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=ss.submission_status&dir={$dir}">Status</a></td>
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=s.org_id&dir={$dir}">Org</a></td>
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=s.partner_id&dir={$dir}">Partner</a></td>
	</tr>	
	{foreach name=outer item=submission from=$submissions}  		
	<tr>
			<!--<td><a href="https://redesign.benefitscheckup.org/cf/system/vw2.php?submission_id={$submission.submission_id}">{$submission.file_name}</a></td>-->
			<td><a href="{$url_path}vw2.php?submission_id={$submission.submission_id}">{$submission.file_name}</a></td>
		<td>{$submission.post_finish_time}</td>
		<td>{$submission.submission_status}</td>
		<td>{$submission.org_id}</td>
		<td>{$submission.partner_id}</td>
		<td>{$submission.debug_kh}</td>
	</tr>    			
	{/foreach}
</table>
{include file="footer.tpl"}
