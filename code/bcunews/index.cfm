<cfif isdefined('session.partner_id') and session.partner_id neq 0><cflocation url="../"></cfif>
<cfparam name="gohome" default="true">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>

<cfquery datasource="#application.dbSrc#" name="getNews">
	SELECT	*
	FROM bcu_news
	WHERE	(active = 1 AND archived = <cfif isDefined("url.archived") and url.archived EQ 1>1<cfelse>0</cfif>)	
    <cfif structKeyExists(url,'article_id')>AND news_id = <cfoutput>#url.article_id#</cfoutput></cfif>
	ORDER BY 	date_added DESC
</cfquery>

<cfif structKeyExists(url,'article_id')>
    <cfquery datasource="#application.dbSrc#" name="readNews">
        SELECT	*
        FROM bcu_news
        WHERE news_id = <cfoutput>#url.article_id#</cfoutput>
        ORDER BY 	date_added DESC
    </cfquery>
</cfif>
<!--- HEADER --->
<cfset guts = "index.cfm">
<cf_tagHeader log="false" guts="#guts#" show_left_col="y" randomimage="y">
<!--- /HEADER --->



<cfif structKeyExists(url,'article_id')>
	<cfif readNews.recordCount gt 0>
        <cfoutput query="readNews">
        	<div style="font-size:12px; padding:4px;"><a href="index.cfm<cfif structKeyExists(url,'archived')>?archived=1</cfif>">Back to article list</a></div>
            <h1 class="h1">#title#</h1>
            <div style="font-size:0.9em;">#news#</div>
            <div style="font-size:12px; padding:4px;"><a href="index.cfm<cfif structKeyExists(url,'archived')>?archived=1</cfif>">Back to article list</a></div>
        </cfoutput>
    </cfif>
<cfelse>
    <h1 class="h1">What's in the News at BenefitsCheckUp?</h1>
    <div class="partners2">
        <p class="text1">BenefitsCheckUp Press Contact</p>
        <p class=p2>Ken Schwartz</p>
        <p class="p2">Director of Communications </p>
        <p class="p2"><a class="newslink2" href="mailto:ken.schwartz@ncoa.org ">ken.schwartz@ncoa.org </a></p>
        <p class="p2">202.600.3131</p>
    </div>
    <div class="casestudies">
        <a class="newslink" href="casestudies/Case_Study_Maria_Ibarra.pdf" target="Google_Case_Study"><img src="images/casestudiesthumb.gif" align="right" vspace="12"></a>
        <a class="h1link" href="casestudies.cfm">Current Case Studies</A> 
        <p class="text1">
            <a class="newslink2" href="casestudies/Case_Study_Maria_Ibarra.pdf" target="Google_Case_Study">
                Success Stories: How BenefitsCheckUp Helped Maria Ibarra find Benefits for Her Elderly Family Members (PDF file)
            </a><br />
        </p>
        <p>
            <a class="newslink" href="casestudies.cfm"><strong>More Case Studies</strong></a>
        </p>
    </div>
    <div style="clear:both;"></div>
    <h1 class="h1"><cfif isDefined("url.archived") and url.archived eq 1>Archived<cfelse>Current</cfif> Press Releases </h1>
    <table cellSpacing="8" cellPadding="0" width="100%" border="0">
        <tbody>
        <cfoutput query="getNews">
            <tr valign="top" align="left"> 
                <td width="17%">
                    <a class="newslink" href="index.cfm?article_id=#news_id#<cfif structKeyExists(url,'archived')>&archived=1</cfif>"><strong>#DateFormat(date_added,'mm/dd/yyyy')#</strong></a>
                </td>
                <td width="79%">
                    <a class=newslink href="index.cfm?article_id=#news_id#<cfif structKeyExists(url,'archived')>&archived=1</cfif>">#title#</a>
                </td>
            </tr>
        </cfoutput>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <cfif isDefined("url.archived") and url.archived eq 1>
                        <a href="index.cfm">See Current Press Releases</a>
                    <cfelse>
                        <a href="index.cfm?archived=1">See Archived Press Releases</a>
                    </cfif>
                </td>
            </tr>
        </tbody>
    </table>
</cfif>
<!--- FOOTER --->
<cf_tagFooter >
<!--- /FOOTER --->
