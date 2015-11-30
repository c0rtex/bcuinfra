<cfcomponent extends="cacheSingletonComponent" displayname="bcuSubsetAnswerfieldPoolComponent">

	<cffunction name="actionRefresh" output="no">
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.sa = StructNew()>
	</cffunction>

	<cffunction name="actionRefreshSubsetAnswerfield" output="no">
		<cfargument name="subset_id" type="any" default="">
		<cfargument name="partner_id" type="any" default="">
		<cfargument name="state_id" type="any" default="">

		<cfset sahash = this.getSahash(subset_id,partner_id)>

		<cfset this.internalContent.sa[sahash] = StructNew()>
		<cfset this.internalContent.sa[sahash].lastRefresh = Now()>
		<cfset this.internalContent.sa[sahash].sort = StructNew()>

		<cfquery name="savars" datasource="#application.dbSrc#">
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif this.isPartnerdiff(subset_id,partner_id)>(</cfif>partner_id is null
						<cfif this.isPartnerdiff(subset_id,partner_id)>
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=a.answerfield_id
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif this.isPartnerdiff(subset_id,partner_id)>(</cfif>partner_id is null
						<cfif this.isPartnerdiff(subset_id,partner_id)>
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=ar.left_answerfield_id
				AND ar.relationship_id=2
				AND ar.right_answerfield_id=a.answerfield_id
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM (
				select question_id
				from subset_question sq
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					and exclude_flag=0
				union
				select question_id
				from question q
				where include_flag=1
					and question_id not in (
						select question_id
						from subset_question sq
						where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
							and exclude_flag=1
					)
				) sq, question_answerfield qa, answerfield a
			WHERE sq.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
			ORDER BY answerfield
		</cfquery>
		<cfloop query="savars">
			<cfset StructInsert(this.internalContent.sa[sahash].sort, answerfield, answerfield_id)>
		</cfloop>

	</cffunction>

	<cffunction name="actionDump" output="yes">
		<cfargument name="subset_id" type="any" default="">
		<cfargument name="partner_id" type="any" default="">
		<cfargument name="state_id" type="any" default="">

		<cfset sahash=this.getSaHash(subset_id,partner_id)>

		<cfif not this.isDoAll(subset_id) and not StructKeyExists(this.internalContent.sa,sahash)>
			<cfset this.actionRefreshSubsetAnswerfield(subset_id,partner_id,state_id)>
		</cfif>

		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="7" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
			</tr>

			<cfloop list="#ListSort(StructKeyList(this.internalContent.sa), 'textnocase')#" index="x">
				<cfif this.isDoall(subset_id,partner_id) or x eq sahash>
				<tr>
					<td colspan="3" align="center"><strong>#x#</strong> last refresh #this.internalContent.sa[x].lastRefresh#</td>
				</tr>
				<tr>
					<td align="right"><strong>id</strong></td>
					<td><strong>answerfield</strong></td>
				</tr>
				<cfset afCount = 0>
				<cfloop list="#ListSort(StructKeyList(this.internalContent.sa[x].sort), 'textnocase')#" index="y">
					<cfset afCount = afCount + 1>
					<tr>
						<td align="right" valign="top">#this.internalContent.sa[x].sort[y]#</td>
						<td valign="top">#y#</td>
					</tr>
				</cfloop>
				</cfif>
			</cfloop>
			</table>
		</cfoutput>
	</cffunction>

	<cffunction name="isDoAll" output="no">
		<cfargument name="subset_id" type="any" default="">
		<cfreturn subset_id eq ''>
	</cffunction>

	<cffunction name="getSaHash" output="no">
		<cfargument name="subset_id" type="any" default="">
		<cfargument name="partner_id" type="any" default="">

		<cfif this.isDoAll(subset_id)>
			<cfreturn ''>
		</cfif>

		<cfset phash = ''>
		<cfif partner_id neq ''>
			<cfif this.isPartnerDiff(subset_id,partner_id)>
				<cfset phash = "p#partner_id#">
			</cfif>
		</cfif>
		<cfreturn "s#subset_id##phash#">
	</cffunction>

	<cffunction name="isPartnerDiff" output="no">
		<cfargument name="subset_id" type="any" default="">
		<cfargument name="partner_id" type="any" default="">
			<cfset partnerDiff = false>
			<cfif partner_id neq ''>
				<cfset partnerDiff = CreateObject("component","cf.components.cacheAnswerfieldSubsetPartnerPoolComponent").getInstance().actionisDifferent(partner_id,subset_id)>
			</cfif>
			<cfreturn partnerDiff>
	</cffunction>

	<cffunction name="actionGet" output="no">
		<cfargument name="subset_id" type="any" default="">
		<cfargument name="partner_id" type="any" default="">
		<cfargument name="state_id" type="any" default="">

		<cfif this.isDoall(subset_is)>
			<cfreturn false>
		<cfelse>
			<cfset sahash = this.getSahash(subset_id,partner_id)>
			<cfif not StructKeyExists(this.internalContent.sa, sahash)>
				<cfinvoke component="#this#" method="actionRefreshSubsetAnswerfield">
					<cfinvokeargument name="subset_id" value="#subset_id#">
					<cfinvokeargument name="partner_id" value="#partner_id#">
					<cfinvokeargument name="state_id" value="#state_id#">
				</cfinvoke>
			</cfif>
			<cfreturn StructCopy(this.internalContent.sa[sahash])>
		</cfif>

	</cffunction>

</cfcomponent>