<cfcomponent extends="cacheSingletonComponent" displayname="bcuSubsetQuestionPoolComponent">

<cffunction name="isDoAll" output="no">
	<cfargument name="basics" type="boolean" default="false">
	<cfargument name="app" type="boolean" default="false">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">

	<cfreturn (state_id eq '' and not basics and not app) or subset_id eq ''>
</cffunction>

<cffunction name="getSqHash" output="no">
	<cfargument name="basics" type="boolean" default="false">
	<cfargument name="app" type="boolean" default="false">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="numeric" default="0">

	<cfif this.isDoAll(basics,app,state_id,subset_id)>
		<cfreturn "">
	<cfelse>
		<cfif basics or app>
			<cfset state_id = 'US'>
		</cfif>
		<cfset sqhash = state_id & subset_id>
		<cfif partner_id eq 8>
			<cfset sqhash = "#sqhash#p#partner_id#">
		</cfif>
		<cfreturn sqhash>
	</cfif>
</cffunction>

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.sq = StructNew()>
</cffunction>

<cffunction name="actionRefreshSubsetQuestionPoolComponent" output="no">
	<cfargument name="basics" type="boolean" default="false">
	<cfargument name="v_app" type="boolean" default="false">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="numeric" default="0">

	<cfset includePartner = partner_id eq 8>
	<cfset app=v_app>

	<cfset sqhash = this.getSqHash(basics,app,state_id,subset_id,partner_id)>

	<cfset this.internalContent.sq[sqhash] = StructNew()>
	<cfset this.internalContent.sq[sqhash].lastRefresh = Now()>
	<cfset this.internalContent.sq[sqhash].sort = StructNew()>
	<cfset this.internalContent.sq[sqhash].q = StructNew()>

	<cfquery name="sqvars" datasource="#application.dbSrc#">
		SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
		FROM (
			SELECT q.question_id, NULL AS page_id
			FROM (
				SELECT pa.answerfield_id
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not basics>(</cfif>p.state_id IS NULL
					<cfif not basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner>
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=a.answerfield_id
					AND <cfif not basics>(</cfif> a.state_id IS NULL
					<cfif not basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
					</cfif>
				UNION
				SELECT ar.right_answerfield_id as answerfield_id
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not basics>(</cfif>p.state_id IS NULL
					<cfif not basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner>
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=ar.left_answerfield_id
					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not basics>(</cfif>a.state_id IS NULL
					<cfif not basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
					</cfif>
				UNION
				SELECT  pa.answerfield_id
				FROM subset_program_sum sps, program_answerfield pa, answerfield a
				WHERE
					sps.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					and pa.program_id = sps.program_id
					and a.answerfield_id = pa.answerfield_id
					and sps.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #subset_id#
						and (p.state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2"> or p.state_id IS NULL)
					)
				UNION
				SELECT ar.right_answerfield_id as answerfield_id
				FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not basics>(</cfif>p.state_id IS NULL
					<cfif not basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner>
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					and sp.program_id in
					(	select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #subset_id#
						and ( p.state_id = '#state_id#' or p.state_id is NULL )
					)

					AND pa.answerfield_id=ar.left_answerfield_id

					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not basics>(</cfif>a.state_id IS NULL
					<cfif not basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
					</cfif>


			) AS a, question_answerfield qa, question q
			WHERE a.answerfield_id=qa.answerfield_id
				AND qa.question_id NOT IN (
					SELECT question_id
					FROM subset_question
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND exclude_flag=1
				)
				AND qa.question_id=q.question_id
				AND q.exclude_flag=0
			UNION
			SELECT q.question_id, sq.page_id
			FROM subset_question sq, question q
			WHERE sq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sq.exclude_flag=0
				AND sq.question_id=q.question_id
			UNION
			SELECT q.question_id, NULL AS page_id
			FROM question q
			WHERE q.include_flag=1
				AND q.question_id NOT IN (
					SELECT question_id
					FROM subset_question
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND exclude_flag=1
				)
		) AS a, question q, questioncategory qc<cfif app>, page pg</cfif>
		WHERE a.question_id=q.question_id
			AND q.questioncategory_id=qc.questioncategory_id
			<cfif basics>AND qc.questioncategory_code='basics'</cfif>
			<cfif app>AND a.page_id=pg.page_id</cfif>
		ORDER BY <cfif app>pg.sort, </cfif>qc.sort, q.sort
	</cfquery>
	<cfset qCount = 0>
	<cfloop query="sqvars">
		<cfset qCount = qCount + 1>
		<cfset this.internalContent.sq[sqhash].q[question_code] = StructNew()>
		<cfset this.internalContent.sq[sqhash].q[question_code].pg = page_id>
		<cfset StructInsert(this.internalContent.sq[sqhash].sort, qCount, question_code)>
	</cfloop>
</cffunction>

<cffunction name="actionDump" output="yes">
	<cfargument name="basics" type="boolean" default="false">
	<cfargument name="app" type="boolean" default="false">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="numeric" default="0">

	<cfset sqhash = this.getSqhash(basics,app,state_id,subset_id,partner_id)>

	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="7" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>

		<cfloop list="#ListSort(StructKeyList(this.internalContent.sq), 'textnocase')#" index="x">
			<cfif this.isDoAll(basics,app,state_id,subset_id) or x eq sqhash>
			<tr>
				<td colspan="7" align="center"><strong>#x#</strong> last refresh #this.internalContent.sq[x].lastRefresh#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td><strong>question</strong></td>
			</tr>
			<cfset questionCount = 0>
			<cfloop list="#ListSort(StructKeyList(this.internalContent.sq[x].sort), 'numeric')#" index="y">
				<cfset questionCount = questionCount + 1>
				<tr>
					<td align="right" valign="top">#questionCount#</td>
					<td valign="top">#y#</td>
				</tr>
			</cfloop>
			</cfif>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<cffunction name="actionGet" output="no">
	<cfargument name="basics" type="boolean" default="false">
	<cfargument name="app" type="boolean" default="false">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="numeric" default="0">

	<cfif this.isDoall(basics,app,state_id,subset_id)>
		<cfreturn false>
	<cfelse>
		<cfset sqhash = this.getSqhash(basics,app,state_id,subset_id,partner_id)>
		<cfif not StructKeyExists(this.internalContent.sq,sqhash)>
			<cfinvoke component="#this#" method="actionRefreshSubsetQuestionPoolComponent">
				<cfinvokeargument name="basics" value="#basics#">
				<cfinvokeargument name="app" value="#app#">
				<cfinvokeargument name="state_id" value="#state_id#">
				<cfinvokeargument name="subset_id" value="#subset_id#">
				<cfinvokeargument name="partner_id" value="#partner_id#">
			</cfinvoke>
		</cfif>

		<cfreturn StructCopy(this.internalContent.sq[sqhash])>
	</cfif>
</cffunction>

</cfcomponent>