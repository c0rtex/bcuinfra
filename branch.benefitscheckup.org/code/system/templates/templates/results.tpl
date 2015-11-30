<b>Possible Status Messages BCU can provide:</b><br>
{foreach name=outer item=possible_status from=$possible_status}
- {$possible_status.status_message}<br>
{/foreach}

<hr>
<b>Total number of Records in Current batch (batch_id=<i>{$batch_id}</i>): </b>{$count[0].amount}<br>

{foreach name=outer item=r from=$rundown}
{$r.status_message} - {$r.b} (rate: <b>{$count[0].amount|get_percents:$r.b}% </b>)
<br>
{/foreach}



<hr>
<b>Actual Result Records:</b><br>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="2">
	<tr>
		<td align="center"><b>Client ID</b></td>
		<td align="center"><b>Status Message</b></td>
		<td align="center"><b>Date Time</b></td>
	</tr>	
	{foreach name=outer item=submission from=$submissions}  		
	<tr>
		<td>{$submission.client_id}</td>
		<td>{$submission.status_message}</td>
		<td>{$submission.date_time}</td>
	</tr>    			
	{/foreach}
</table>

