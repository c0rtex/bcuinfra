<cfsilent>
<!----=======================================
6/30/2008 BShunn
THIS TEMPLATE IS NOW DEPRECATED.  IT IS SUPERSEDED BY popText.cfm.  ALL REFERENCES TO THIS
TEMPLATE SHOULD BE KILLED, AND THIS TEMPLATE SHOULD BE DELETED ASAP.  FOR NOW, IT WILL DO
A LOOKUP THAT REDIRECTS TO popText.cfm.  ALSO, IT ONLY SUPPORTS "DEFINITIONS" AS STORED IN
THE NEW help TABLE.  IT NO LONGER SUPPORTS REQUIRED MATERIALS FROM tbl_req_mat NOR HINTS
FROM tbl_hints.

DESCRIPTION: shows any help information...pulled into seperate window by javascript of the caller
CALLED BY: either help graphic, or hyperlink definition,required material
GOES TO: N/A
REQUIRED: type, keyword
	var type = Hint, Definition, NavTip, or RequiredMaterial....description to define which query to use
	var Keyword = which record to pull in any of the queries
============================================---->

<cfparam name="keyword" type="string" >

<cfquery name="def" datasource="#application.dbSrc#">
	select dt.display_code title_help, d.display_code help
	from help h inner join display d
			on h.display_id=d.display_id
		left outer join display dt
			on h.title_display_id=dt.display_id
	where keyword=<cfqueryparam cfsqltype="cf_sql_varchar" value="#keyword#" maxlength="64">
	order by h.help_code
</cfquery>
<cfif def.title_help eq ''>
	<cfset popTextQS = ''>
<cfelse>
	<cfset popTextQS = "titlegroup=helptitle&titlecode=#def.title_help#&">
</cfif>

</cfsilent>
<cflocation url="popText.cfm?#popTextQS#group=help&code=#def.help#" addtoken="no">