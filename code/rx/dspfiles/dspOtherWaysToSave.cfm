<!-- Other Ways to Save -->
<cfset otest = "test">

<cfif otest eq  "test" >

	<cfset RxPrgList = #ListAppend(RxPrgList, "XXX-311-2387-FD-FD", ",")# >
	<cfinclude template="../dspOtherOptions.cfm">
	
	<p>
		<li>
			There are other ways to save money on prescription drugs, including using 
			mail order and generics.   For a fact sheet, click <a href="genericdruginfo.cfm">here</a>.     
		</li>
	</p>

</cfif>