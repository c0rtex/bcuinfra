<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cf_displaymenu title="View Display Text"><cfoutput>

<cf_buildView table="display" code="display" key="#id#" action="#action#" saving="#saving#" title="Display Text Data">
	<cf_buildViewProperty column="displaygroup_id" input="select" references="displaygroup">
	<cf_buildViewProperty column="active_flag" input="checkbox">
</cf_buildView>

</cfoutput><cfmodule template="../footer.cfm">