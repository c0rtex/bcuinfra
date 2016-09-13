<!--- replaces | with client, @ with his/her, * with he/she, and ^ with him as necessary
attributes= question, st (state, not currently used), user (Mother, Sister, etc) --->
<CFSET question = #attributes.question#>
<CFSET st = #attributes.st#>
<CFSET user = #attributes.user#></CFOUTPUT>
<CFIF #session.user# IS "Mother" or #session.user# IS "Sister" or #session.user# IS "Aunt">
	<CFSET hisher = "her">
	<CFSET heshe = "she">
<CFELSEIF #session.user# IS "Father" or #session.user# IS "Brother" or #session.user# IS "Uncle">
	<CFSET hisher = "his">
	<CFSET heshe = "he">
<CFELSE>
	<CFIF #gender# IS "m">
		<CFSET hisher = "his">
		<CFSET heshe = "he">
	<CFELSE>
		<CFSET hisher = "her">
		<CFSET heshe = "she">
	</CFIF>
</CFIF>

<CFSET newquestion = #replace(#question#,"|",#session.user#,"all")#>
<CFSET newquestion = #replace(#newquestion#,"@",#hisher#,"all")#>
<CFSET newquestion = #replace(#newquestion#,"$",#heshe#,"all")#>
<CFSET newquestion = #replace(#newquestion#,"^","#himher#","all")#>

<CFSET caller.newquestion =#newquestion#>

