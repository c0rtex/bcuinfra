<cfinclude template="rulequeryforlist.cfm">
<cfset rulelist = ListSort(ListAppend(rulelist, testanswerfield), 'Text')>
<cfinclude template="rulerewrite.cfm">
