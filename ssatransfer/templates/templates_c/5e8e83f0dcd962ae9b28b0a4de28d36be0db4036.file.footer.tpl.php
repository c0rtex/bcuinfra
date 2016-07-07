<?php /* Smarty version Smarty-3.1.7, created on 2015-10-30 08:58:24
         compiled from "/opt/bcu/apps/bcu_code/branch.benefitscheckup.org/code/ssatransfer/templates/templates/footer.tpl" */ ?>
<?php /*%%SmartyHeaderCode:43543339956325672823b15-07153642%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '5e8e83f0dcd962ae9b28b0a4de28d36be0db4036' => 
    array (
      0 => '/opt/bcu/apps/bcu_code/branch.benefitscheckup.org/code/ssatransfer/templates/templates/footer.tpl',
      1 => 1446220525,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '43543339956325672823b15-07153642',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.7',
  'unifunc' => 'content_5632567283cbb',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5632567283cbb')) {function content_5632567283cbb($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/opt/bcu/progs/smarty/plugins/modifier.date_format.php';
?><!-- choose footer  -->
<TABLE cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">
	<tr>
		<td valign="top" bgcolor="white" colspan="2" align="center"><font face="Arial" color="#00656C" size="2"><i>Powered by National Council on Aging</i></font></td>
	</tr>
    <tr>
		<td bgcolor="white" colspan="2" align="center"><font face="Arial" color="#00656C" size="1">Copyright &copy; <?php echo smarty_modifier_date_format(time(),"%Y");?>
 National Council on Aging 
            | <a href="javascript:help2('privacy_cf.cfm')" style="color: #00656C;">Privacy Policy</a>
			| <a href="javascript:help2('terms_cf.cfm')" style="color: #00656C;">Terms of Use</a>
			| <a href="mailto:comments@benefitscheckup.org" style="color: #00656C;">Feedback</a>
			</font></td>
	</tr>
</table>
</td>
</tr>
</table>
</body>
</html>
<?php }} ?>