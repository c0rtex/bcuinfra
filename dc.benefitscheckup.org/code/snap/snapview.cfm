<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">


<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="5">
</cfif>


<cf_buildPage title="Snap Table" section="snap">

<cf_buildView table="tbl_snap" code="snap" key="#id#" action="#action#" saving="#saving#" title="Snap Table">
	<cf_buildViewProperty column="snap_state" limit="2" restriction="alphanumeric" visible="disableonedit" >
	<cf_buildViewProperty column="snap_url" visible="false">
	<cf_buildViewProperty column="snap_online_app"  >
	<cf_buildViewProperty column="snap_program_names" visible="false">
</cf_buildView>

</cf_buildpage>