<!----=======================================
DESCRIPTION: gets called when there is a need for white space, usually formatting questions
CALLED BY: N/A
GOES TO: N/A
REQUIRED: N/A
OPTIONAL ATTRIBUTES: Spaces=integer,number of spaces desired
============================================---->
<CFIF IsDefined('Attributes.Spaces')>
	<CFSET Count=Attributes.Spaces>
<CFELSE>
	<CFSET Count=9>
</CFIF>
	<CFSET LoopCount=0>
<CFLOOP CONDITION="LoopCount LESS THAN OR EQUAL TO Count">
	<CFSET LoopCount=LoopCount +1>
			&nbsp;
</CFLOOP>