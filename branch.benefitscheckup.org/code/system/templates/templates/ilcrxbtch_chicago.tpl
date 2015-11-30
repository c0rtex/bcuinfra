
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}AnchorPosition.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}date.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}PopupWindow.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var cal = new CalendarPopup();
var httpRequest;
</SCRIPT>
  <div class="topheader">
  	<table width="100%"><tr><td>
                    <div style="float:left;"><img title="BenefitsCheckUp" alt="BenefitsCheckUp" src="/wp-content/themes/bcuwptheme/images/logos/bcu.png"> 
       		</div><div style="float:right;"><a href="http://www.cityofchicago.org/fss/benefitscheckup" target="63"><img src="/cf/img/partners/chicago/logo.gif" border="0" alt="City of Chicago Senior Services" title="City of Chicago Senior Services"></a></div></td></tr></table>
   </div>
            
            
    
            <div class="clear"></div>
<form name="form1" method="post" action="{$smarty.server.PHP_SELF}">
<table align="center">
  <tr>
    <td>Unique ID</td>
    <!---td>Zip Code</td--->
    <td></td>
  </tr>
  <tr>
    <td><input type="text" name="client_id" value="{$smarty.session.client_id}"></td>
    <!---td><input type="text" name="response" value="{$smarty.session.response}"></td--->
    <td><input type="submit" name="Submit" value="Search"></td>
  </tr> 
</table>
</form>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="2">
	<tr>
		<td bgcolor="#ffffff" colspan="4" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 10pt; color: black;">
		<div align="center"><font size="5">IL Cares Rx Batch Records</font></div></td>
	</tr>	
	<tr>
		<td>Report Link</td>
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=s.end_datetime&dir={$dir}">Date</a></td>
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=sa.response&dir={$dir}">Zip Code</a></td>					
		<td><a href="{$smarty.server.PHP_SELF}?orderBy=s.client_id&dir={$dir}">Unique ID</a></td>
	</tr>	
	{foreach name=outer item=submission from=$submissions}  		
	<tr>
			<td><a target="_new" href="{$url_path}../util/procGetReport.cfm?clientnum={$submission.screening_id}&unique_id={$submission.client_id}&subset_id=69">View Report</a></td>
		<td>{$submission.end_datetime}</td>
		<td>{$submission.response}</td>
		<td>{$submission.client_id}</td>
	</tr>    			
	{/foreach}
</table>

