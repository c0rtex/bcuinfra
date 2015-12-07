<!---
	Template Name: SubsetQuestionAnswerfieldPoolCache
	Component Purpose: Component manages local cache of subsets questions and it's answer fields

	Data Tables: Subset_program_base, Program, Program_answerfield, Answerfield, Answerfield_subset_partner, Answerfield_relationship,
				 Subset_program_sum, Program_parent, Subset_program_base, Subset_question, Question

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuSubsetQuestionAnswerfieldPoolComponent">

<!---
	Methods initializes and recreates cache container
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.sqa = StructNew()>
</cffunction>

<!---
	Methods adds or refresh particular subsets questions and it's answer fields in cache
--->

<cffunction name="actionRefreshSubsetQuestionAnswerfield" output="no">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfset sqahash = this.getSqaHash(state_id,subset_id,partner_id,question)>

	<cfset partnerDiff = this.isPartnerdiff(subset_id,partner_id)>

	<cfset this.internalContent.sqa[sqahash] = StructNew()>
	<cfset this.internalContent.sqa[sqahash].lastRefresh = Now()>
	<cfset this.internalContent.sqa[sqahash].sort = StructNew()>

	<cfquery name="sqavars" datasource="#application.dbSrc#">
		SELECT a.answerfield
		FROM question q, question_answerfield qa, (
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff>
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)				                        </cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff>
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=ar.left_answerfield_id
				AND ar.relationship_id=2
				AND ar.right_answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff>
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)				                        </cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #subset_id#
						and ( p.state_id = '#state_id#' or p.state_id is NULL )

					)

			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff>
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=ar.left_answerfield_id
				AND ar.relationship_id=2
				AND ar.right_answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #subset_id#
						and ( p.state_id = '#state_id#' or p.state_id is NULL )

					)

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
		) AS a
		WHERE q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#question#" maxlength="100">
				AND q.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
		ORDER BY qa.sort
	</cfquery>
	<cfset aCount = 0>
	<cfloop query="sqavars">
		<cfset aCount = aCount + 1>
		<cfset StructInsert(this.internalContent.sqa[sqahash].sort, aCount, answerfield)>
	</cfloop>
</cffunction>

<!---
	Method returns true if any of subset id, state id or question code is empty when components methods are invoked
--->

<cffunction name="isDoAll" output="no">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfreturn state_id eq '' or subset_id eq '' or question eq ''>
</cffunction>

<!---
	Method defines and returns local cache value key based on subset id, partner id, state id and question code
--->

<cffunction name="getSqaHash" output="no">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfif this.isDoAll(state_id,subset_id,question)>
		<cfreturn ''>
	</cfif>

	<cfset phash = ''>
	<cfif partner_id neq ''>
		<cfif this.isPartnerDiff(subset_id,partner_id)>
			<cfset phash = "p#partner_id#">
		</cfif>
	</cfif>
	<cfreturn state_id & subset_id & phash & '_' & question>
</cffunction>

<!---
	Method returns true if passed subsets answer field list equals to answer field list binded to passed couple subset and partner
--->

<cffunction name="isPartnerDiff" output="no">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="any" default="">
		<cfset partnerDiff = false>
		<cfif partner_id neq ''>
			<cfset partnerDiff = CreateObject("component","cf.components.cacheAnswerfieldSubsetPartnerPoolComponent").getInstance().actionisDifferent(partner_id,subset_id)>
		</cfif>
		<cfreturn partnerDiff>
</cffunction>

<!---
	Method returns html table with dump of cache content
--->

<cffunction name="actionDump" output="yes">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfset sqahash=this.getSqaHash(state_id,subset_id,partner_id,question)>

	<cfif not StructKeyExists(this.internalContent.sqa, sqahash)>
		<cfinvoke component="#this#" method="actionRefreshSubsetQuestionAnswerfield">
			<cfinvokeargument name="state_id" value="#state_id#">
			<cfinvokeargument name="subset_id" value="#subset_id#">
			<cfinvokeargument name="partner_id" value="#partner_id#">
			<cfinvokeargument name="question" value="#question#">
		</cfinvoke>
	</cfif>

	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="7" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>

		<cfloop list="#ListSort(StructKeyList(this.internalContent.sqa), 'textnocase')#" index="x">
			<cfif this.isDoAll(state_id,subset_id,question) or x eq sqahash>
			<tr>
				<td colspan="7" align="center"><strong>#x#</strong> last refresh #this.internalContent.sqa[x].lastRefresh#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td><strong>answerfield</strong></td>
			</tr>
			<cfset answerfieldCount = 0>
			<cfloop list="#ListSort(StructKeyList(this.internalContent.sqa[x].sort), 'numeric')#" index="y">
				<cfset answerfieldCount = answerfieldCount + 1>
				<tr>
					<td align="right" valign="top">#answerfieldCount#</td>
					<td valign="top">#y#</td>
				</tr>
			</cfloop>
			</cfif>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns struct contained subsets questions and it's answer fields for passed subset id, partner id and state id. Method returns false if state id is empty
--->

<cffunction name="actionGet" output="no">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfif this.isDoAll(state_id,subset_id,question)>
		<cfreturn false>
	<cfelse>
		<cfif not StructKeyExists(this.internalContent.sqa, sqahash)>
			<cfinvoke component="#this#" method="actionRefreshSubsetQuestionAnswerfield">
				<cfinvokeargument name="state_id" value="#state_id#">
				<cfinvokeargument name="subset_id" value="#subset_id#">
				<cfinvokeargument name="partner_id" value="#partner_id#">
				<cfinvokeargument name="question" value="#question#">
			</cfinvoke>
		</cfif>
		<cfreturn StructCopy(this.internalContent.sqa[this.getSqaHash(state_id,subset_id,partner_id,question)])>
	</cfif>
</cffunction>

</cfcomponent>