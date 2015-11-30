<?php /* Smarty version Smarty-3.1.7, created on 2015-10-30 08:58:24
         compiled from "/opt/bcu/apps/bcu_code/branch.benefitscheckup.org/code/ssatransfer/templates/templates/submitApplicant.tpl" */ ?>
<?php /*%%SmartyHeaderCode:8114207556325672798f03-93690614%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a559047cadbba19d6564dcb4d155d6c16c87e524' => 
    array (
      0 => '/opt/bcu/apps/bcu_code/branch.benefitscheckup.org/code/ssatransfer/templates/templates/submitApplicant.tpl',
      1 => 1446220525,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '8114207556325672798f03-93690614',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.7',
  'unifunc' => 'content_563256727fb33',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_563256727fb33')) {function content_563256727fb33($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ("header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<script language=javascript type='text/javascript'> 

self.setTimeout("showdiv('redirect')", 20000) 


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

</script> 
<table width="100%" border="0" align="center" cellpadding="12" cellspacing="2">
		<tr>
			<td bgcolor="#ffffff" colspan="2" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 10pt; color: black;">
			  <div align="center"><font size="5">Please wait a moment while we process your application. </font>		    </div></td>
		</tr>
		<tr>
			<td bgcolor="#ffffff" colspan="2">
              <div align="center">
                <p><img src="<?php echo @IMAGES_DIR;?>
pleasewait.gif"> </p>
                <p><font size="5"><strong>DO NOT</strong> click on the back or refresh buttons on your browser while your application is being sent. </font></p>                
              </div>
              <div align="center" id="redirect" style="visibility: hidden;"> 
				 <font size="5"><strong><a href='../confirmation.cfm?cfid=<?php echo $_GET['CFID'];?>
&ctoken=<?php echo $_GET['CFTOKEN'];?>
'>Click here to view your submission results</a></strong></font>
			  </div>
			</td>
		</tr>
</table>
<?php echo $_smarty_tpl->getSubTemplate ("footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<?php }} ?>