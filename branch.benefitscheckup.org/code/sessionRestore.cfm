<cfparam name="userkey" type="string" default="0-0-0">
<cfset temptoken=ListGetAt(userkey, 1, '-')>
<cfset tempid=ListGetAt(userkey, 2, '-')>
<cflocation url="frmAccess.cfm?cftoken=#temptoken#&cfid=#tempid#" addtoken="No">