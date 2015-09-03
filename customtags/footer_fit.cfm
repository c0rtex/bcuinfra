<cfparam name="link" default="">
<cfparam name="rightcol" default="">
<cfparam name="attributes.tag" default="">
<cfset approot = "approot">
<cfset imgroot = "img">
<cfoutput></td>
</table><cfoutput>

<cfif wrapper.wrapper_show_footer IS 1>

<cfif wrapper.wrapper_footer_custom IS NOT "">
<cfset footer = replacenocase(wrapper.wrapper_footer_custom, "[Year]", Year(Now()), 'all')>
<cfset footer = replacenocase(footer, "##application.serverPathOE##", application.serverPathOE)>
<cfset footer = replacenocase(footer, "##session.partner_id##", session.partner_id)>
<cfset footer = replacenocase(footer, "[Feedback]", request.comments_address)>
<cfset footer = replacenocase(footer, "[none]", "&nbsp;")>
<cfif session.subset_id IS 59>
	<cfset footer = replacenocase(footer, ' | <a href="https://#application.serverPathOE#?partner_id=22">Organization Login</a>', '')>
</cfif>
#footer#

<cfelse>
	<div class="footer"><div class="container2"><div class="footer1">&copy; #year(now())# <a href="http://www.ncoa.org" class="footerlink" target="ncoa">National Council on Aging.</a> All rights reserved.</div>
	<div class="footer2">
	
	<cfif link IS NOT "" GT 1 OR session.org_id GT 1 OR  (session.partner_id IS 19 AND attributes.showmenu IS 0)>
	
	<a href="javascript:help2('privacy_cf.cfm')" id="privacy" class="footerlink">Privacy Policy</a> / <a href="javascript:help2('termsofuse.cfm')" class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a> / <a href="http://#application.serverPathOE#/welcome.do?partner_id=76"  class="footerlink">Reports Login</a>
	<cfelse>
	
		<cfif attributes.showmenu IS 1>
	  <a id="privacy" class="footerlink" href="privacy.cfm">Privacy Policy</a> / <a class="footerlink" id="terms" href="termsofuse.cfm">Terms of Use</a> / <a class="footerlink" href="mailto:#request.comments_address#">Feedback</a> / <a href="http://#application.serverPathOE#/welcome.do?partner_id=76"  class="footerlink">Reports Login</a>
		<cfelse>
			<a id="privacy" href="javascript:help2('privacy_cf.cfm')"  class="footerlink">Privacy Policy</a> / <a href="javascript:help2('termsofuse.cfm')"  class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a> / <a href="http://#application.serverPathOE#/welcome.do?partner_id=76"  class="footerlink">Reports Login</a>
		</cfif>
	</cfif>
	</div></div>
	</div>
</cfif>
</cfif>
</cfoutput>
</div>

<cfif trim(attributes.tag) IS NOT "">
<cfoutput>
#attributes.tag#
</cfoutput>
</cfif>
</cfoutput>