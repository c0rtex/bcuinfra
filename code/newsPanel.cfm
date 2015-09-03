<!--- REvERTED CODE TO #53 testing ... --->
<cfquery name="news" datasource="#application.dbSrc#">
    SELECT      *
    FROM         bcu_news AS bn
    WHERE     (date_added =
                  (SELECT     MAX(date_added) AS Expr1
                   FROM          bcu_news
                   WHERE      (news_id = bn.news_id)))
    ORDER BY date_added DESC limit 0, 3
</cfquery>

		<cfoutput query="news">
		<li><a href="bcunews/index.cfm?article_id=#news_id#">#title#</a></li>
		</cfoutput>
		
		
