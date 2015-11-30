<cfsilent>
<cfparam name="attributes.type" type="numeric" default="0">
<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.language_id" type="string">
<cfparam name="attributes.form" type="boolean" default="false">
<cfparam name="attributes.oldText" type="string" default="">
<cfparam name="attributes.codeHash" type="string" default="">
<cfparam name="attributes.letter" type="string" default="">
<cfparam name="attributes.debugvar" type="string" default="">

<cfif attributes.debugvar neq ''>
	<cfset debugOutput = ''>
</cfif>
<cfif attributes.codeHash neq ''>
	<cfif attributes.debugvar neq ''>
		<cfset debugOutput = debugOutput & "&nbsp; &nbsp; Checksum evaluation for #attributes.codeHash#<br>">
	</cfif>
	<cfset checksumHash = attributes.language_id & attributes.codeHash & attributes.letter>
	<cfif StructKeyExists(Evaluate("application.bcuRxPool.#attributes.language_id#.#attributes.letter#"), attributes.codeHash)>
		<cfif attributes.debugvar neq ''>
			<cfset debugOutput = debugOutput & "&nbsp; &nbsp; &nbsp; &nbsp; application.bcuRxPool.#attributes.language_id#.#attributes.letter#.#attributes.codeHash# exists<br>">
		</cfif>
		<cfif StructFind(Evaluate("application.bcuRxPool.#attributes.language_id#.#attributes.letter#"), attributes.codeHash) eq ''>
			<cfif attributes.debugvar neq ''>
				<cfset debugOutput = debugOutput & "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; application.bcuRxPool.#attributes.language_id#.#attributes.letter#.#attributes.codeHash# is empty<br>">
			</cfif>
			<cfif StructKeyExists(application.bcuRxPool.checksum, checksumHash)>
				<cfif attributes.debugvar neq ''>
					<cfset debugOutput = debugOutput & "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; application.bcuRxPool.#checksumHash# is #StructFind(application.bcuRxPool.checksum, checksumHash)#<br>">
				</cfif>
				<cfif StructFind(application.bcuRxPool.checksum, checksumHash) gt 0>
					<cfif attributes.debugvar neq ''>
						<cfset debugOutput = debugOutput & "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Deleting struct member to force correction<br>">
					</cfif>
					<cfset StructClear(Evaluate("application.bcuRxPool.#attributes.language_id#.#attributes.letter#"))>
				</cfif>
			</cfif>
		</cfif>
	<cfelseif attributes.debugvar neq ''>
		<cfset debugOutput = debugOutput & "&nbsp; &nbsp; &nbsp; &nbsp; No checksum exists<br>">
	</cfif>
<cfelse>
	<cfset letter = LCase(Left(attributes.text, 1))>
	<cfif letter lt 'a' or letter gt 'z'>
		<cfset letter = 'sym'>
	</cfif>
	<cfif attributes.oldText neq ''>
		<cfset oldLetter = LCase(Left(attributes.oldText, 1))>
		<cfif oldLetter lt 'a' or oldLetter gt 'z'>
			<cfset oldLetter = 'sym'>
		</cfif>
	<cfelse>
		<cfset oldLetter = ''>
	</cfif>
	<cfif oldLetter eq '' or oldLetter neq letter>
		<cfif attributes.form>
			<cfset f = 'f1'>
		<cfelse>
			<cfset f = 'f0'>
		</cfif>
		<cf_for from="0" to="1" index="x">
			<cfif x>
				<cfset g13 = 'g13'>
			<cfelse>
				<cfset g13 = ''>
			</cfif>
			<cf_for from="0" to="1" index="y">
				<cfif y>
					<cfset g14 = 'g14'>
				<cfelse>
					<cfset g14 = ''>
				</cfif>
				<cf_for from="0" to="1" index="z">
					<cfif x or y or z>
						<cfif z>
							<cfset g15 = 'g15'>
						<cfelse>
							<cfset g15 = ''>
						</cfif>
						<cfif x and y and z>
							<cfset g13 = ''>
							<cfset g14 = ''>
							<cfset g15 = ''>
						</cfif>
						<cfif (x and attributes.type eq 13) or (y and attributes.type eq 14) or (z and attributes.type eq 15)>
							<cfset hash = attributes.language_id & g13 & g14 & g15 & f & letter>
							<cfif not StructKeyExists(application.bcuRxPool.checksum, hash)>
								<cfset StructInsert(application.bcuRxPool.checksum, hash, 0)>
							</cfif>
							<cfset StructUpdate(application.bcuRxPool.checksum, hash, StructFind(application.bcuRxPool.checksum, hash) + 1)>
							<cfif oldLetter neq ''>
								<cfset oldHash = attributes.language_id & g13 & g14 & g15 & f & OldLetter>
								<cfif not StructKeyExists(application.bcuRxPool.checksum, oldHash)>
									<cfset StructInsert(application.bcuRxPool.checksum, oldHash, 0)>
								</cfif>
								<cfset StructUpdate(application.bcuRxPool.checksum, oldHash, StructFind(application.bcuRxPool.checksum, oldHash) - 1)>
							</cfif>
						</cfif>
					</cfif>
				</cf_for>
			</cf_for>
		</cf_for>
	</cfif>
</cfif>
<cfif attributes.debugvar neq ''>
	<cfset "caller.#attributes.debugvar#" = debugOutput>
</cfif>

</cfsilent>