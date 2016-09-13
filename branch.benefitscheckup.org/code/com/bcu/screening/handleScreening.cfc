<cfcomponent displayname="handleScreening" hint="This will handle screenings for processing">
<!---<cfset nullStr = '[zzz[null]zzz]'>
<cfparam name="attributes.action" type="string" default="start">
<cfparam name="attributes.mode" type="string" default="#nullStr#">
<cfparam name="attributes.id" type="string" default="#nullStr#">
<cfparam name="attributes.qno" type="string" default="#nullStr#">
<cfparam name="attributes.cat" type="string" default="#nullStr#">
<cfparam name="attributes.pgno" type="string" default="#nullStr#">
<cfparam name="attributes.pglist" type="string" default="#nullStr#">
<cfparam name="attributes.dview" type="string" default="#nullStr#">
<cfparam name="attributes.cont" type="string" default="#nullStr#">
<cfparam name="attributes.recap" type="string" default="#nullStr#">
<cfparam name="attributes.closed" type="string" default="#nullStr#">
<cfparam name="attributes.element" type="string" default="">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.basics" type="boolean" default="false">
<cfparam name="attributes.screening_id" type="numeric" default="0">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.initvarname" type="string" default="">
<cfparam name="attributes.aflistvarname" type="string" default="">
<cfparam name="attributes.loadsession" type="boolean" default="false">--->



	<cffunction name="init" access="public" returntype="handleScreening">
		<cfargument name="screening_id" type="numeric" required="no" default="0" hint="setting the screening id on instatiation default is 0">
        <cfargument name="state_id" type="string" required="no" default="" hint="setting the state id on instatiation default is '' ">
        <cfargument name="mode" type="string" required="no" default="" hint="setting initial mode">
        <cfargument name="qno" type="numeric" required="no" default="0">
        <cfargument name="cat" type="string" required="no" default="">
        <cfargument name="pgno" type="numeric" required="no" default="1">
        <cfargument name="pglist" type="array" required="no" default="#arrayNew(1)#">
        <cfargument name="dview" type="numeric" required="no" default="0">
        <cfargument name="cont" type="numeric" required="no" default="0">
        <cfargument name="recap" type="numeric" required="no" default="0">
        <cfargument name="closed" type="numeric" required="no" default="0">
		<cfargument name="basics" type="boolean" default="false" required="no">
        <cfscript>
        	setScreening_id(arguments.screening_id);
			setState_id(arguments.state_id);
			setMode(arguments.mode);
			setQno(arguments.qno);
			setCat(arguments.cat);
			setPgno(arguments.pgno);
			setPglist(arguments.pglist);
			setDview(arguments.dview);
			setCont(arguments.cont);
			setRecap(arguments.recap);
			setClosed(arguments.closed);
			setBasics(arguments.basics);
        </cfscript>
		<cfreturn this />
	</cffunction>
    
    <cffunction name="killScreening" access="public" returntype="void" hint="Removes the screening structure from the session.">
    	<cfscript>
        	structDelete(session,screening);
        </cfscript>
    </cffunction>
    <cffunction name="endScreening" access="public" returntype="void" hint="END action:  log the end of a screening and close the screening">
        <!--- Use variables.instance.screening_id if passed in, else use session.screening.id from session --->
        <cfscript>
			if(getScreening_id() > 0){
				logScreeningEnd(getScreening_id());
			}else if( isDefined(session.sceening.id) && session.screening.is > 0){
				setScreening_id(session.screening.id);
				logScreeningEnd(getScreening_id());
			};
        </cfscript>
    </cffunction>
    <cffunction name="logScreeningEnd" access="private" returntype="void" hint="UPDATE screening.end_datetime in database">
    	<cfargument name="screening_id" required="yes" type="numeric">
        <cfif arguments.screening_id GT 0>
            <cfquery name="logScreeningEnd" datasource="#application.dbSrc#">
                UPDATE screening
                SET end_datetime=#CreateODBCDateTime(Now())#
                WHERE screening_id=#screening_id#
            </cfquery>
            <cfscript>
            	session.screening.closed = 1;
            </cfscript>
        </cfif>
    </cffunction>
    <cffunction name="reloadScreening" access="public" hint="Reloads variables needed and runs the start function">
    	<cfscript>
        	if(getState_id() != ''){
				session.state_id = getState_id();
				session.prev_id = getScreening_id();
				startScreening();
			};
        </cfscript>
    </cffunction>
    <cffunction name="resetScreening" access="public" hint="deletes screening structure and sets new.">
    	<cfscript>
        	structDelete(session,"screening");
			setScreening();
        </cfscript>
    </cffunction>
    <cffunction name="setScreening" access="public" hint="Sets the screenings variables or resets them">
    	<cfscript>
        	var init = false;
			if(!isDefined('session.screening') ||  !isStruct('session.screening')){
				session.screening = structNew();
				session.screening.q = structNew();
				session.screening.qsort = structNew();
				session.screening.head = structnew();
				init = true;
			};
			
			if(getMode() EQ '' && init){
				setMode('dynamic');
			};
			session.screening.mode = getMode();
			if(getScreening_id() EQ '' && init){
				setScreening_id(0);
			};
			session.screening_id = getScreening_id();
			if(getQno() EQ '' && init){
				setQno(0);
			};
			session.screening.qno = getQno();
			if(getCat() EQ '' && init){
				setCat('');
			};
			session.screening.cat = getCat();
			if(getMode() NEQ 'print'){
				if(init){
					session.screening.a = structNew();
					session.screening.pg = structNew();
				};
				if(getPgno() EQ '' && init){
					setPgno(1);
				};
				session.screening.pgno = getPgno();
				if(arrayLen(getPglist()) lt 1 && init){
					setPglist();
				};
				session.screening.pglist = getPglist();
				if(getDview() EQ '' && init){
					setDview(0);
				};
				session.screening.dview = getDview();
				if(getCont() EQ '' && init){
					setCont(0);
				};
				session.screening.cont = getCont();
				if(getRecap() EQ '' && init){
					setRecap(0);
				};
				session.screening.reacp = getRecap();
				if(getClosed() EQ '' && init){
					setClosed(0);
				};
				session.screening.closed = getClosed();
			}; 	
        </cfscript>
    </cffunction>
    <cffunction name="getScreening" access="public" returntype="any">
    	<cfscript>
			var outStr = '';
        	if(isDefined('session.screening') && isStruct('session.screening')){
				if(!isDefined(session.screening.mode)){
					setMode('');
					session.screening.mode = getMode();
				};
				outStr = evaluate('session.screening.#arguments.element#');
			};
			return outStr;
        </cfscript>
    </cffunction>
    <cffunction name="startScreening" access="public" returntype="any" hint="START action:  log the start of a screening and initialize structure">
		<cfscript>
			var subsetobj = structNew();
			var isApplication = false;
			var sqState = session.state_id;
			var explicitAFs = "";
			var rx = "";
			var qcount = 0;
			var Setvar = '';
        	if(getMode() EQ ''){
				setMode('dynamic');
			};
        </cfscript>
        <cf_cacheSubsetPool action="get" subset_id="#session.subset_id#" var="subsetobj">
        <cfscript>
			//isApplication = false;
			//sqState = session.state_id;
        	if(subsetobj.type EQ 'application'){
				isApplication = true;
				sqState = '';
			};
			structClear(subsetobj);
			if(getMode() NEQ 'print'){
				// Delete user responses from any previous screening
				// START OBSOLESCENT:  This section will be obsolete when we stop putting responses directly in session
				for(af in application.bcuAnswerfieldPool){
					structDelete(session,af);
					/*if(!isApplication){
						rx = evaluate('application.bcuAnswerfieldPool.a.#af#.rx');
						if(!rx){
							session[af] = 0;
						};
					};*/
				};
				session.strclient = 'self';
				explicitAFs = getExplicitAnswerfields();
			};
        </cfscript>
		<cfif getMode() NEQ 'print'>
			<cfloop query="explicitAFs">
				<cf_translateAnswerfieldIntoSession code="#answerfield#" value="#default_value#">
			</cfloop>
		</cfif>
		<cfscript>
			//Initialize session.screening structure
			resetScreening();
			//The two variables below should be phased out along with all basic session-scope answerfields
			if(getMode() NEQ 'print'){
				session.screening.selectedDrugs = '';
				session.selectedDrugs = '';
			};

		</cfscript>
		<cfif getBasics()>
			<cf_cacheSubsetQuestionPool action="get" basics="true" subset_id="#session.subset_id#" partner_id="#session.partner_id#" var="qaire">
		<cfelse>
			<!---cfoutput action="get" app="#isApplication#" state_id="#sqState#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" var="qaire" --->
			<cf_cacheSubsetQuestionPool action="get" app="#isApplication#" state_id="#sqState#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" var="qaire">
		</cfif>
		
		<cf_loopPoolStruct struct="qaire" index="qu">
	        <cf_cacheQuestionPool action="get" code="#qu#" var="qobj">
			<cfif qobj.spx eq 0>
				<cfset qCount = qCount + 1>
				<cfif getMode() eq 'print'>
					<cf_handleScreeningQuestion mode="#getMode()#" code="#qu#">
				<cfelse>
					<cf_handleScreeningQuestion mode="#getMode()#" code="#qu#" spg="#Evaluate("qaire.q.#qu#.pg")#">
				</cfif>
				<cfset StructInsert(session.screening.qsort, qCount, qu)>
	            <cfset qobj = Evaluate("application.bcuQuestionPool.q.#qu#")>
				<cf_loopPoolStruct struct="qobj" index="af">
	                 <cfset req = Evaluate("application.bcuAnswerfieldPool.a.#af#.req")>
					<cfif req>
						<cf_handleScreeningAnswerfield code="#af#" req="1">
					</cfif>
				</cf_loopPoolStruct>
			</cfif>
		</cf_loopPoolStruct>
		
		
		<cfset structClear(qaire)>
		<cfif getMode() neq 'print'>
			<cfset getRequiredAFs = getRequiredAFs()>
			<cfloop query="getRequiredAFs">
				<cf_handleScreeningAnswerfield code="#answerfield#" req="#required#" recap="#recap_code#">
			</cfloop>
			<cfif session.prev_id eq '' or not IsNumeric(session.prev_id) or session.prev_id eq 0>
				<cfset session.screening.prepopulate = 0>
			<cfelse>
				<cfset getPrevScreening = getPrevScreening()>
				<cfif getPrevScreening.RecordCount Eq 0>
					<cfset session.screening.prepopulate = 0>
				<cfelse>
					<cfset session.screening.prepopulate = 1>
					<cfloop query="getPrevScreening">
						<cfif encryption_flag eq 1>
							<cf_decodeString text="#encrypted_response#" var="decrypted">
						</cfif>
						<cfif encryption_flag eq 1>
							<cf_handleScreeningAnswerfield code="#answerfield#" pre="#decrypted#">
						<cfelseif responsetype lt 3>
							<cf_handleScreeningAnswerfield code="#answerfield#" pre="#response#">
						<cfelse>
							<cf_handleScreeningAnswerfield code="#answerfield#" pre="#option_id#">
						</cfif>
						<cfif attributes.loadsession>
							<cfif encryption_flag eq 1>
								<cfset "session.#answerfield#" = decrypted>
								<cf_handleScreeningAnswerfield code="#answerfield#" val="#decrypted#">
								<cfif responsetype eq 1>
									<cfset part='n'>
								<cfelse>
									<cfset part='s'>
								</cfif>
							<cfelseif responsetype lt 3>
								<cfset "session.#answerfield#" = response>
								<cf_handleScreeningAnswerfield code="#answerfield#" val="#response#">
								<cfif responsetype eq 1>
									<cfset part='n'>
								<cfelse>
									<cfset part='s'>
								</cfif>
							<cfelse>
								<cfset "session.#answerfield#" = option_code>
								<cf_handleScreeningAnswerfield code="#answerfield#" val="#option_id#">
								<cfset part='o'>
							</cfif>
							<!---<cfset caller.theList = ListAppend(caller.theList, "#part#-#answerfield#")>--->
						</cfif>
					</cfloop>
				</cfif>
			</cfif>
			<cf_screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#session.state_id#" test_flag="#session.test_id#" var="outvar">
			<cfset session.screening.id = outvar>
			<cfif Setvar eq ''>
				<cfset session.screening_id = outvar>
			<cfelse>
				<cfreturn outvar />
			</cfif>
		</cfif>	
    </cffunction>
    
    <cffunction name="getRequiredAFs" access="private" returntype="query">
    	<cfset qRequiredAFs = ''>
		<cfquery name="qRequiredAFs" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
            select qa.answerfield_id, a.answerfield, sa.required, qa.sort, r.recap_code
            from subset_question sq
                inner join question_answerfield qa
                    on sq.subset_id=#session.subset_id# and sq.question_id=qa.question_id
                inner join answerfield a
                    on qa.answerfield_id=a.answerfield_id
                left outer join subset_answerfield sa
                     on sa.subset_id=#session.subset_id# and qa.answerfield_id=sa.answerfield_id
                left outer join recap r
                     on sa.recap_id=r.recap_id
            group by a.answerfield, qa.answerfield_id, sa.required, qa.sort, r.recap_code
            order by a.answerfield
        </cfquery>
        <cfreturn qRequiredAFs />
    </cffunction>
    <cffunction name="getPrevScreening" access="private" returntype="query">
    	<cfset qPrevScreening = ''>
    	<cfquery name="qPrevScreening" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
            SELECT a.answerfield, sa.responsetype, sa.response, o.option_id, o.option_code,
                sa.encryption_flag, sa.encrypted_response
            FROM answerfield a INNER JOIN screening_answerfield sa 
                    ON sa.answerfield_id = a.answerfield_id
                LEFT OUTER JOIN `option` o
                    ON sa.option_id = o.option_id
            WHERE sa.screening_id=#session.prev_id#
            ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime
        </cfquery>
        <cfreturn qPrevScreening />
    </cffunction>
	<cffunction name="getExplicitAnswerfields" access="private" returntype="query">
		<cfset qExplicitAnswerfields = "">
		<cfquery name="qExplicitAnswerfields" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
			SELECT a.answerfield, asp.default_value
			FROM answerfield_subset_partner asp, (
					SELECT answerfield_id, subset_id, max(partner_id) partner_id
					FROM answerfield_subset_partner
					WHERE subset_id=#session.subset_id#
						AND (partner_id is null or partner_id=#session.partner_id#)
						AND background_flag=1
					GROUP BY answerfield_id, subset_id
				) q, answerfield a
			WHERE asp.answerfield_id=q.answerfield_id
				AND asp.subset_id=q.subset_id
				AND (asp.partner_id=q.partner_id or (asp.partner_id is null and q.partner_id is null))
				AND asp.background_flag=1
				AND q.answerfield_id=a.answerfield_id
			ORDER BY a.answerfield
		</cfquery>
		<cfreturn qExplicitAnswerfields />
	</cffunction>
    <!--- MUTATORS --->
    <cffunction name="getScreening_id" access="public" returntype="numeric">
    	<cfreturn variables.instance.screening_id />
    </cffunction>
    <cffunction name="setScreening_id" access="public" returntype="void">
    	<cfargument name="screening_id" required="yes" type="numeric" default="0">
        <cfset variables.instance.screening_id = arguments.screening_id>
    </cffunction>
    <cffunction name="getState_id" access="public" returntype="string">
    	<cfreturn variables.instance.state_id />
    </cffunction>
    <cffunction name="setState_id" access="public" returntype="void">
    	<cfargument name="state_id" type="string" required="no" default="">
        <cfset variables.instance.state_id = arguments.state_id>
    </cffunction>
    <cffunction name="getMode" access="public" returntype="string">
    	<cfreturn variables.instance.mode />
    </cffunction>
    <cffunction name="setMode" access="public" returntype="void">
    	<cfargument name="mode" type="string" required="no" default="">
        <cfset variables.instance.mode = arguments.mode>
    </cffunction>
    <cffunction name="getQno" access="public" returntype="numeric">
    	<cfreturn variables.instance.qno />
    </cffunction>
    <cffunction name="setQno" access="public" returntype="void">
    	<cfargument name="qno" type="numeric" required="no" default="0">
        <cfset variables.instance.qno = arguments.qno>
    </cffunction> 
    <cffunction name="getCat" access="public" returntype="string">
    	<cfreturn variables.instance.cat />
    </cffunction>
    <cffunction name="setCat" access="public" returntype="void">
    	<cfargument name="cat" type="string" required="no" default="">
        <cfset variables.instance.cat = arguments.cat>
    </cffunction>
    <cffunction name="getPgno" access="public" returntype="numeric">
    	<cfreturn variables.instance.pgno />
    </cffunction>
    <cffunction name="setPgno" access="public" returntype="void">
    	<cfargument name="pgno" type="numeric" required="no" default="1">
        <cfset variables.instance.pgno = arguments.pgno>
    </cffunction>
    <cffunction name="getPglist" access="public" returntype="array">
    	<cfreturn variables.instance.pglist />
    </cffunction>
    <cffunction name="setPglist" access="public" returntype="void">
    	<cfargument name="pglist" type="array" required="no" default="#arrayNew(1)#">
        <cfset variables.instance.pglist = arguments.pglist>
    </cffunction>
    <cffunction name="getDview" access="public" returntype="numeric">
    	<cfreturn variables.instance.dview />
    </cffunction>
    <cffunction name="setDview" access="public" returntype="void">
    	<cfargument name="dview" type="numeric" required="no" default="0">
        <cfset variables.instance.dview = arguments.dview>
    </cffunction>
    <cffunction name="getCont" access="public" returntype="numeric">
    	<cfreturn variables.instance.cont />
    </cffunction>
    <cffunction name="setCont" access="public" returntype="void">
    	<cfargument name="cont" type="numeric" required="no" default="0">
        <cfset variables.instance.cont = arguments.cont>
    </cffunction>
    <cffunction name="getRecap" access="public" returntype="numeric">
    	<cfreturn variables.instance.recap />
    </cffunction>
    <cffunction name="setRecap" access="public" returntype="void">
    	<cfargument name="recap" type="numeric" required="no" default="0">
        <cfset variables.instance.recap = arguments.recap>
    </cffunction>
    <cffunction name="getClosed" access="public" returntype="numeric">
    	<cfreturn variables.instance.closed />
    </cffunction>
    <cffunction name="setClosed" access="public" returntype="void">
    	<cfargument name="closed" type="numeric" required="no" default="0">
        <cfset variables.instance.closed = arguments.closed>
    </cffunction>
	<cffunction name="getBasics" access="public" returntype="boolean">
		<cfreturn variables.instance.basics />
	</cffunction>
	<cffunction name="setBasics" access="public" returntype="void">
		<cfargument name="basics" type="boolean" required="no" default="false">
		<cfset variables.instance.basics = arguments.basics>
	</cffunction>
</cfcomponent>