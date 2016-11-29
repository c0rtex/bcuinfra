<h2>Test Program output</h2>




<cfinvoke  component="ProgramsDebug"
    method = "calcForScreening" 
    returnVariable = "stringOut">

<cfinvokeargument name="screeningId" value="#url.screeningId#"/> 
</cfinvoke>



<cfoutput>#stringOut#</cfoutput>

<cfabort>

<cfparam name="url.screeningId" default="5050859" type="numeric">
<cfinvoke  component="ProgramsDebug"
    method = "calcForPrescreen" 
    >

<cfinvokeargument name="screeningId" value="#url.screeningId#"/> 
</cfinvoke>

