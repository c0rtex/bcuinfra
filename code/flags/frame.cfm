<cfparam name="test_id" type="numeric" default="1">
<cf_sessionPassVars href="index.cfm" canonical="false" test_id="#test_id#" var="redirectURL">
<cfoutput>
<frameset rows="20%,80%">
        <frame name="control" src="control.cfm?test_id=#test_id#" marginwidth="5" marginheight="5" scrolling="no" frameborder="yes" noresize>
        <frame name="window" src="#redirectURL#" marginwidth="5" marginheight="5" scrolling="no" frameborder="yes" noresize>
</frameset><noframes></noframes>
</cfoutput>