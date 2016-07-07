<cfoutput>
	<cfif Not IsDefined("session.partner_id")>
		<cfif IsDefined("URL.partner_id")>
    		<cfset session.partner_id = #URL.partner_id#>
       	</cfif>
   	</cfif>
</cfoutput>
<cfif session.partner_id NEQ 77>
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
    
    <a id="link_to_us" href="javascript:linkToUs('link_to_us.cfm')" class="footerlink">Link to Us</a> / <a href="javascript:help2('privacy_cf.cfm')" id="privacy" class="footerlink">Privacy Policy</a> / <a href="javascript:help2('termsofuse.cfm')" class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a>
    <cfelse>
    
        <cfif attributes.showmenu IS 1>
     <a id="link_to_us" href="javascript:linkToUs('/cf/link_to_us.cfm')" class="footerlink">Link to Us</a> / <a id="privacy" class="footerlink" href="/cf/privacy.cfm">Privacy Policy</a> / <a class="footerlink" id="terms" href="/cf/termsofuse.cfm">Terms of Use</a> / <a class="footerlink" href="mailto:#request.comments_address#">Feedback</a> / <a href="http://#application.serverPathOE#?partner_id=#session.partner_id#"  class="footerlink"><cfif wrapper.partnertype_id IS 9>Login<cfelseif wrapper.partnertype_id IS 12>Login<cfelse>Partner Login</cfif><cf_displayImage code="img_partners_arrow_gif" style="margin:-4px 2px;"></a>
        <cfelse>
            <cfif SESSION.partner_id NEQ 79><a id="link_to_us" href="javascript:linkToUs('link_to_us.cfm')" class="footerlink">Link to Us</a> / </cfif><a id="privacy" href="javascript:help2('privacy_cf.cfm')"  class="footerlink">Privacy Policy</a> / <a href="javascript:help2('termsofuse.cfm')"  class="footerlink">Terms of Use</a> / <a href="mailto:#request.comments_address#"  class="footerlink">Feedback</a> <cfif SESSION.partner_id NEQ 79>/ <a href="http://#application.serverPathOE#?partner_id=#session.partner_id#"  class="footerlink"><cfif wrapper.partnertype_id IS 9>Login<cfelseif wrapper.partnertype_id IS 12>Login<cfelse>Partner Login</cfif><cf_displayImage code="img_partners_arrow_gif" style="margin:-4px 2px;"></a></cfif>
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
<cfelse>
	<cfinclude template="footer_esi.cfm">
</cfif>
