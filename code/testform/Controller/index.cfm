
<cfparam name="page" default="2" >
<--- cfdump var="#cfhttp.responseHeader#"  expand="yes" --->

<cfswitch expression="#page#">

<cfcase value="1">

<cfhttp method="post"   url="https://s044a90.ssa.gov/apps6z/i1020/Controller"   >

<cfloop list="#FORM.FIELDNAMES#" index="fieldname">

		<cfset FieldValue = #evaluate(fieldname)# >

		<cfoutput><cfhttpparam  name="#fieldname#" type="formfield"  value="#FieldValue#"></cfoutput>

</cfloop>

</cfhttp>

	<cfset session.cookiestruct = structnew()>

	<cfset session.cookiestruct = #cfhttp.responseHeader['Set-Cookie']#>

	<cfset session.header1 = cfhttp.header >

	<cfset session.errorDetail1 = cfhttp.errorDetail >

	<cfset session.statusCode1 = cfhttp.statusCode >

	<cfset session.filecontent1 = cfhttp.fileContent >

	<cfoutput>#cfhttp.header#</cfoutput>
	<cfoutput>#cfhttp.filecontent#</cfoutput>
</cfcase>



<cfcase value="2">

<cfhttp method="post"   url="https://s044a90.ssa.gov/apps6z/i1020/Controller"    >

<cfloop list="#FORM.FIELDNAMES#" index="fieldname">

		<cfset FieldValue = #evaluate(fieldname)# >

		<cfoutput><cfhttpparam  name="#fieldname#" type="formfield"  value="#FieldValue#"></cfoutput>

</cfloop>

<cfhttpparam   type="cookie" name="JSESSIONID"  value="0000e3HREL56wMHf3aWHnRND_Ou:BC008F5138D37502000003C0000014D90A000802" >

<cfhttpparam   type="cookie" name="PD_STATEFUL_bed2f066-84b6-11da-bf1c-c7ade78daa77"  value="%2Fapps6z">

</cfhttp>

	<cfset session.header2 = cfhttp.header >

	<cfset session.errorDetail2 = cfhttp.errorDetail >

	<cfset session.statusCode2 = cfhttp.statusCode >

	<cfset session.filecontent2 = cfhttp.fileContent >

	<cflocation url="resultpage.cfm">

</cfcase>

</cfswitch>

