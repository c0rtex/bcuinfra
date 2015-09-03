<cfif form.endrow - form.startrow gte 19>
<cfloop from="#form.startrow#" to="#form.endrow#" step="20" index="start"  >
<cfhttp method="post" url="http://bcuqa.benefitscheckup.org/procBatchScreening.cfm" >
	<cfset end = start + 19 >
	<cfoutput>start: #start# end: #end#</cfoutput>
	<cfhttpparam type="formfield" name="startrow" value="#start#" > 
	<cfhttpparam type="formfield" name="endrow" value="#end#" > 
</cfhttp>
<cfoutput>#cfhttp.FileContent#</cfoutput>
<cfflush>
</cfloop>
<cfelse>
	Please submit more than 100 rows, in increments of 20
</cfif>