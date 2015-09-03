<table width="100%" border="1" align="center" cellpadding="2" cellspacing="2">
	<tr>
		<td bgcolor="#ffffff" colspan="4" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 10pt; color: black;">
		<div align="center"><font size="5">URLs</font></div></td>
	</tr>	
	<tr>
		<td>Program ID</td>
		<td>Program Name</td>
		<td>Associated URL</td>					
	</tr>	
	{foreach name=outer item=submission from=$submissions}  		
	<tr>	
		<td>{$submission.prg_id}</td>
		<td>{$submission.prg_nm}</td>
		<td><a href="{$submission.comment}" target="_blank">{$submission.comment} </a></td>
	</tr>    			
	{/foreach}
</table>
{include file="footer.tpl"}
