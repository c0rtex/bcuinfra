<cfparam name="link" default="">
<cfparam name="rightcol" default="">
<cfset approot = "approot">
<cfset imgroot = "img">
<cfoutput></td>

<cfif wrapper.wrapper_right_col IS "n">
<cfelse>
	<td valign="top" class="rightcol"><cfinclude template="/#approot#/#attributes.rightcol#"></td>
</cfif>
</tr>
</table><cfoutput>
<div class="footer"><div class="container2"><div class="footer1">&copy; #year(now())# <a href="http://www.ncoa.org" class="footerlink" target="ncoa">National Council on Aging.</a> All rights reserved.</div>
<div class="footer2">

<cfif link IS NOT "" GT 1 OR session.org_id GT 1 OR  (session.partner_id IS 19 AND attributes.showmenu IS 0)>

<a href="javascript:help2('privacy_cf.cfm')" id="privacy" class="footerlink">Privacy Policy</a> / <a href="javascript:help2('termsofuse.cfm')" class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a>
<cfelse>

	<cfif attributes.showmenu IS 1>
 <a id="privacy" class="footerlink" href="privacy.cfm">Privacy Policy</a> / <a class="footerlink" id="terms" href="termsofuse.cfm">Terms of Use</a> / <a class="footerlink" href="mailto:#request.comments_address#">Feedback</a>
	<cfelse>
		<a id="privacy" href="javascript:help2('privacy_cf.cfm')"  class="footerlink">Privacy Policy</a> / <a href="javascript:help2('termsofuse.cfm')"  class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a>
	</cfif>
</cfif>


</div></div>
</div>
</cfoutput>
</div>
</body>
</html>
</cfoutput>

