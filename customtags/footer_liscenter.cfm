<cfset table_text_color = "##00656C">
<cfset table_link_color = "##00656C">
<cfoutput>

<!--- Normal Branding --->

<TABLE cellSpacing="2" cellPadding="2" width="100%" align="center" border="0">

           <cfif AddBanner is "Yes"><TR>

          <td align="center" bgcolor="##ffffff" colspan="2"><font face="Arial" size="2"><b><i>With support from</i></b></font><br>

		  <img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br>

		  <cf_tagLogos></td></TR></cfif>

	<tr>

		<td valign="top" bgcolor="white" colspan="2" align="center"><font face="Arial" color="#table_text_color#" size="2"><i>Powered by National Council on Aging</i></font></td>

	</tr>

    <tr>

		<td bgcolor="white" colspan="2" align="center"><font face="Arial" color="#table_text_color#" size="1">Copyright &copy; #Year(Now())# National Council on Aging 

            | <a href="javascript:help2('privacy_cf.cfm')" style="color: #table_link_color#;">Privacy Policy</a>

			| <a href="javascript:help2('termsofuse.cfm')" style="color: #table_link_color#;">Terms of Use</a>

			| <a href="mailto:#request.comments_address#" style="color: #table_link_color#;">Feedback</a>

			<!---| <a href="http://www.ncoa.org/content.cfm?sectionID=61" target="blank" style="color: #table_link_color#;">NCOA's Press Room</a>

			| <a href="javascript:help2('toLink.cfm')" style="color: #table_link_color#;">Link to Us</a>---></font></td>

	</tr>

</table>

<!--- end Normal Branding --->

</td>

</tr>

</table>

</cfoutput>