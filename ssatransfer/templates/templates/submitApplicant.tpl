{include file="header.tpl"}
<script language=javascript type='text/javascript'> 

self.setTimeout("showdiv('redirect')", 20000) 

{literal}
function showdiv(id) 
{
	if (document.getElementById) 
	{ // DOM3 = IE5, NS6
		document.getElementById(id).style.visibility = 'visible';
	}
	else 
	{
		if(document.layers) 
		{ // Netscape 4
			document.id.visibility = 'visible';
		}
		else 
		{ // IE 4
			document.all.id.style.visibility = 'visible';
		}
	}
}
{/literal}
</script> 
<table width="100%" border="0" align="center" cellpadding="12" cellspacing="2">
		<tr>
			<td bgcolor="#ffffff" colspan="2" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 10pt; color: black;">
			  <div align="center"><font size="5">Please wait a moment while we process your application. </font>		    </div></td>
		</tr>
		<tr>
			<td bgcolor="#ffffff" colspan="2">
              <div align="center">
                <p><img src="{$smarty.const.IMAGES_DIR}pleasewait.gif"> </p>
                <p><font size="5"><strong>DO NOT</strong> click on the back or refresh buttons on your browser while your application is being sent. </font></p>                
              </div>
              <div align="center" id="redirect" style="visibility: hidden;"> 
				 <font size="5"><strong><a href='../confirmation.cfm?cfid={$smarty.get.CFID}&ctoken={$smarty.get.CFTOKEN}'>Click here to view your submission results</a></strong></font>
			  </div>
			</td>
		</tr>
</table>
{include file="footer.tpl"}
