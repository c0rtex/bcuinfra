<cfparam name="test_id" type="numeric" default="1">
<cfoutput>
<frameset rows="10%,45%,45%">
    <frame name="header" src="header.cfm" marginwidth="5" marginheight="5" scrolling="no" frameborder="yes" noresize>
    <frameset cols="50%,50%">
        <frame name="window1" src="https://ssl1.benefitscheckup.org/flags/frame.cfm?test_id=#test_id#" marginwidth="5" marginheight="5" scrolling="no" frameborder="yes" noresize>
        <frame name="window2" src="https://ssl2.benefitscheckup.org/flags/frame.cfm?test_id=#test_id#" marginwidth="5" marginheight="5" scrolling="no" frameborder="yes" noresize>
    </frameset>
    <frameset cols="50%,50%">
        <frame name="window3" src="https://ssl3.benefitscheckup.org/flags/frame.cfm?test_id=#test_id#" marginwidth="5" marginheight="5" scrolling="no" frameborder="yes" noresize>
        <frame name="window4" src="https://ssl4.benefitscheckup.org/flags/frame.cfm?test_id=#test_id#" marginwidth="5" marginheight="5" scrolling="no" frameborder="yes" noresize>
    </frameset>
</frameset>
</cfoutput>