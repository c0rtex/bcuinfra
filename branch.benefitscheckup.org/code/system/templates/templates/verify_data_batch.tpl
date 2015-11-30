<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}AnchorPosition.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}date.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="{$smarty.const.JAVASCRIPT_DIR}PopupWindow.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
		<div align="center"><font size="5">Available Records</font></div></td>
<table align="center" border=1>
  <tr>
    <td>Client ID</td>
    <td>BDTSource</td>
  </tr>

	{foreach from=$verifications item=i}  		
	<tr>	
		<td>{$i.CLIENT_ID}</td>
		<td>{$i.BDTSOURCE}</td>
	</tr>    			
	{/foreach}
</table>

<form action="do_batch.php" method="post">
<input type="submit" value="Wheeeha....">
</form>
