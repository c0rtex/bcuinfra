<cfsilent>
<cfparam name="attributes.text" type="string">
<cfparam name="attributes.quote" type="boolean" default="true">
<cfparam name="attributes.isTargetHTML" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="term">

<cfset outStr = attributes.text>
<cfif outStr neq ''>
	<cfset outStr = Replace(outStr, "'", "\'", 'ALL')>
	<cfset outStr = Replace(outStr, '"', "'+String.fromCharCode(34)+'", 'ALL')>
	<cfset outStr = Replace(outStr, chr(13) & chr(10), "\n", 'ALL')>
	<cfset outStr = Replace(outStr, chr(10), "\n", 'ALL')>
	<cfset outStr = Replace(outStr, chr(13), "\n", 'ALL')>
	<cfif attributes.isTargetHTML>
		<cfset outStr = Replace(outStr, '<br />\n', '<br />', 'ALL')>
		<cfset outStr = Replace(outStr, '<br>\n', '<br />', 'ALL')>
		<cfset outStr = Replace(outStr, '\n', '<br />', 'ALL')>
		<cfset outStr = Replace(outStr, '<', "'+String.fromCharCode(60)+'", 'ALL')>
		<cfset outStr = Replace(outStr, '>', "'+String.fromCharCode(62)+'", 'ALL')>
	<cfelse>
		<cfset saveStr = ''>
		<cfset placeMarker = '<thisiswheretheLFgoes>'>
		<cfloop condition="saveStr neq outStr">
			<cfset saveStr = outStr>
			<cfset chunkStruct = REFindNoCase("<br[^/>]*/?>((#placeMarker#)*)\\n", outStr, 1, true)>
			<cfif chunkStruct.pos[1]>
				<cfif chunkStruct.len[2]>
					<cfset chunk = Mid(outStr, chunkStruct.pos[2], chunkStruct.len[2])>
				<cfelse>
					<cfset chunk = ''>
				</cfif>
				<cfif chunkStruct.pos[1] eq 1>
					<cfset leftChunk = ''>
				<cfelse>
					<cfset leftChunk = Left(outStr, chunkStruct.pos[1] - 1)>
				</cfif>
				<cfif Len(outStr) eq chunkStruct.pos[1] + chunkStruct.len[1] - 1>
					<cfset rightChunk = ''>
				<cfelse>
					<cfset rightChunk = Right(outStr, Len(outStr) - chunkStruct.pos[1] - chunkStruct.len[1] + 1)>
				</cfif>
				<cfset outStr = leftChunk & chunk & placeMarker & rightChunk>
			</cfif>
		</cfloop>
		<cfset outStr = Replace(outStr, placeMarker, "\n", 'ALL')>
		<cfset outStr = REReplaceNoCase(outStr, "<br[^/>]*/?>", "\n", 'ALL')>
	</cfif>
	<cfset outStr = REReplace(outStr, "\+(''\+)+", '+', 'ALL')>
</cfif>
<cfif attributes.quote>
	<cfset outStr = "'" & outStr & "'">
	<cfset outStr = REReplace(outStr, "^''\+", '')>
	<cfset outStr = REReplace(outStr, "\+''$", '')>
</cfif>

</cfsilent><cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outStr#</cfoutput><cfsilent>
</cfsilent><cfelse><cfsilent>
	<cfset "caller.#attributes.var#" = outStr>
</cfsilent></cfif>