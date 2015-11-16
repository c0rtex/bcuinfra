<cfinclude template="rulequeryforlist.cfm">
<cfset rulelist = ListDeleteAt(rulelist, ListFindNoCase(rulelist, testanswerfield))>
<cfinclude template="rulerewrite.cfm">