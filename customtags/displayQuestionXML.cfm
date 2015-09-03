<cfparam name="attributes.code" type="string">
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.form" type="string" default="bcuQuestionnaire">
<cfparam name="attributes.default" type="any" default="">
<cfparam name="attributes.validation" type="string" default="">
<cfparam name="attributes.options_flag" type="numeric" default="-1">
<cfparam name="attributes.suppress" type="string" default="">
<cfparam name="attributes.override" type="string" default="">
<cfparam name="attributes.display_heading_once" type="string" default="">
<cfparam name="attributes.type" type="string" default="">
<cfparam name="attributes.debug" type="string" default="false">
<cfparam name="attributes.useHardcodedOrder" type="boolean" default="false">
<cfset STRIPTAGS = "true">
<cfset debug = false>
<cfset outputXML = "">
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfset getQuestion = application.QuestionPool.getQuestion(attributes.code)>


<!--- If multiselect question, check to see if there are any
      answerfields for the current subset and answerfield --->
<cfset hasAnswerfields = true>
<cfif getQuestion.type eq 'multiselect'>
	<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="thisStateID">
	<cfif Not IsDefined('thisStateID') or thisStateID eq ''>
		<cfset thisStateID = session.state_id>
	</cfif>
	<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="#thisStateID#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" question="#attributes.code#" var="questionAnswerfields">
	<cfif StructCount(questionAnswerfields.sort) eq 0>
		<cfset hasAnswerfields = false>
	</cfif>
</cfif>
<cfif hasAnswerfields>
	<cfif attributes.display_heading_once eq '' and getQuestion.head neq ''>
		<cfset attributes.display_heading_once = getQuestion.head>
	</cfif>
	<cfif IsStruct(getQuestion)>
		<cf_handleScreeningQuestion action="get" code="#attributes.code#" element="qno" var="qno">
		<cfif qno eq 0>
			<cfif attributes.suppress neq 'number' and getQuestion.sup eq 0>
				<cfset session.screening.qno = session.screening.qno + 1>
				<cfset qno = session.screening.qno>
			<cfelse>
				<cfset qno = ''>
			</cfif>
			<cf_handleScreeningQuestion code="#attributes.code#" qno="#qno#">
		</cfif>

			<!--- SIMPLE VERSION OF CATEGORY DISPLAY
			<cfif session.screening.cat neq getQuestion.cat>
				<div class="question-category"><cf_displayText code="quescat_#getQuestion.cat#" group="quescat"></div>
			</cfif>
			--->
			<cfset session.screening.cat = getQuestion.cat>

		
		
		<!-- DISPLAY QUESTIONS -->
			<cfif attributes.type eq ''>
				<cfset testType = getQuestion.type>
			<cfelse>
				<cfset testType = attributes.type>
			</cfif>
			<cfif StructKeyExists(getQuestion.sort, 1)>
				<cfset firstAF = StructFind(getQuestion.sort, 1)>
                <cfset ans = application.AnswerfieldPool.getAnswerfield('#firstAF#')>
				<cfset firstType = ans.type>
				<cfif attributes.mode eq 'print' and testType eq 'general' and firstType eq 'select'>
					<cfset testType = 'radio'>
				</cfif>
				<cfset firstReq = ans.req>
			<cfelse>
				<cfset firstReq = 0>
			</cfif>
				
				<cfif testType eq 'either_or_marital'>
					<cf_handleScreeningAnswerfield action="get" code="marital_stat" var="maritalOptionID">
					<cfif attributes.mode eq 'full' or attributes.mode eq 'print'>
						<cfset eitherOrElementText = 1>
						<cfset eitherOrElementAnswerfield = 2>
					<cfelseif maritalOptionID neq '' and maritalOptionID neq 4>
						<cfset eitherOrElementText = 2>
						<cfset eitherOrElementAnswerfield = 2>
					<cfelse>
						<cfset eitherOrElementText = 1>
						<cfset eitherOrElementAnswerfield = 1>
					</cfif>
					<cf_displayTextQuestion code="#attributes.code#" element="#eitherOrElementText#" stripTags="true" var="questionText">
				<cfelse>
					<cf_displayTextQuestion code="#attributes.code#" stripTags="true" var="questionText">
				</cfif>
				<cfset questionText = #replacenocase(questionText,'"','&quot;',"ALL")#>
		<!--- MULTISELECTS --->
		<cfif testType eq "multiselect">	
			<cfset outputXML = outputXML & '
<Question code="#attributes.code#"  DisplaySort="#qno#" helpcode="#getQuestion.help#" controltype="multiselect" helptext="" required="#firstReq#" fieldtype="#testType#" questiontext="#ltrim(rtrim(questionText))#" category="#getQuestion.cat#">
				'>

<cf_displayQuestionMultiselect code="#attributes.code#" aflistvarname="caller.aflist" mode="XML" >
	
<cfset outputXML = outputXML & '
</Question>
				'>
		<!--- GRIDS --->
		<cfelseif testType eq "grid">	
			<cfset outputXML = outputXML & '
<Question code="#attributes.code#"  DisplaySort="#qno#" helpcode="#getQuestion.help#" controltype="grid" helptext="" required="#firstReq#" fieldtype="#testType#" questiontext="#ltrim(rtrim(questionText))#" category="#getQuestion.cat#">
				'>
<cf_displayQuestionGrid code="#attributes.code#" aflistvarname="caller.aflist" mode="XML">
	
<cfset outputXML = outputXML & '
</Question>
				'>
		<!--- either or marital --->
		<cfelseif testType eq "either_or_marital" or testtype  eq "no_grid_income_total">	
			<cfset outputXML = outputXML & '
<Question code="#attributes.code#"  DisplaySort="#qno#" helpcode="#getQuestion.help#" controltype="currency" helptext="" required="#firstReq#" fieldtype="#testType#" questiontext="#ltrim(rtrim(questionText))#" category="#getQuestion.cat#">
				'>
<cfset outputXML = outputXML & '
<Answerfield type="currency" id="111" name="s_income_other_nw" label=""></Answerfield>'>	
<cfset outputXML = outputXML & '
</Question>
				'>

		<!--- ALL OTHER QUESTION TYPES --->	
		<cfelseif attributes.code neq "drugs" and attributes.code neq "receive_ma_plan" >
				<cfset outputXML = outputXML & '
<Question code="#attributes.code#"  DisplaySort="#qno#" helpcode="#getQuestion.help#" '>
<cfset controltype = testType>
<!-- Hard Code Some Control Type Info ( Control Type is used to determine question display attributes on client side) -->
<cfif attributes.code eq 'gender'>
	<cfset controltype = 'gender'>
<cfelseif testtype eq 'hh_expenses_layout'>
	<cfset controltype = 'currency'>
<cfelseif attributes.code eq 'zip'>
	<cfset controltype = 'zipcode'>
<cfelseif testType eq 'either_or_marital'>
	<cfset controltype = 'currency'>
<cfelseif attributes.code eq 'marital_stat' or attributes.code eq 'citizen' or attributes.code eq 'housing' or attributes.code eq 'work_status' or attributes.code eq 'city' >
	<cfset controltype = 'select'>
<cfelseif attributes.code eq 'hh_depend' or attributes.code eq 'citizen' or attributes.code eq 'no_hh_members' or attributes.code eq 'dep_child' >
	<cfset controltype = 'integer'>
<cfelseif attributes.code eq 'hh'>
	<cfset controltype = 'doubleinteger'>
<cfelseif attributes.code eq 'dep_care_costs' or attributes.code eq 'shelter_costs' or attributes.code eq 'med_costs' or attributes.code eq 'scsep_inc' or attributes.code eq 'rent' >
	<cfset controltype = 'currency'>
<cfelseif testtype eq 'date'>
	<cfset controltype = 'doubleselect'>
<cfelseif testtype eq "general">
	<cfset controltype = 'yn'>
</cfif>
<cfset outputXML = outputXML & 'required="#firstReq#" fieldtype="#testType#" controltype="#controltype#" helptext="" questiontext="#ltrim(rtrim(questionText))#" category="#getQuestion.cat#">
				'>
<cfif testtype eq 'hh_expenses_layout'>
<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="#session.state_id#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" question="hh_expenses" var="hh_expensefieldlist">
                                <cf_loopPoolStruct struct="hh_expensefieldlist" index="field">
                                	<cfset ansObj = application.answerfieldPool.getAnswerfield('#field#')>
									<cfset type = ansObj.type> 
<cfset outputXML = outputXML & '
<Answerfield type="#ansObj.type#" id="#ansObj.id#"'>
	<cf_displayTextAnswerfield code="#field#" stripTags="true" var="answerfieldText">
					<cfset outputXML = outputXML & ' name="#field#" label="#answerfieldText#"'>
<cfset outputXML = outputXML & '></Answerfield>
						'>	
</cf_loopPoolStruct>
<cfelse>

											
					<cf_loopPoolStruct struct="getQuestion" index="answerfield">
						<cfset loopcount = 0>
                        <cfset ans = application.AnswerfieldPool.getAnswerfield('#answerfield#')>
						<cf_displayTextAnswerfield code="#answerfield#" stripTags="true" var="answerfieldText">
					<cfif attributes.debug eq "true"><cfoutput>Type:#ans.type# Qtype:#testtype# #attributes.code#<br></cfoutput></cfif>
					
					<cfif ans.type eq "select">
                    <cfset options = application.AnswerfieldPool.getAnswerfield('#attributes.code#')>

					<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#" name="#attributes.code#" label="" >'>
<cfif attributes.code neq 'chronic_condition'>
<cfset outputXML = outputXML & '
<Option type="#ans.type#" id="#ans.id#"  name="" label="" helpcode=""/>
'>
</cfif>					
					<cf_loopPoolStruct struct="options" index="optionName">
						<!--- <cf_cacheOptionPool action="get" code="#optionName#" var="optionStruct"> --->
                        <cfset optionStruct = application.OptionPool.getOption(optionName)>
						<cf_ifOptionIncluded struct="optionStruct">
						<cf_displayText group="option" code="option_#optionName#" var="option_label" stripTags="true">
						<cfset outputXML = outputXML & '
<Option type="#ans.type#" id="#ans.id#"  name="#optionStruct.id#-#optionName#" label="#option_label#" helpcode=""/>
'>					
						</cf_ifOptionIncluded>
					</cf_loopPoolStruct>
<cfset outputXML = outputXML & '
</Answerfield>
'>					
					<cfelseif ans.type eq "checkbox">
					
					<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>
					<cfset outputXML = outputXML & ' name="#attributes.code#" label="#AnswerfieldText#">'>
					<cfset outputXML = outputXML & '</Answerfield>
						'>



					<cfelseif ans.type eq "gender">
<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>
					<cfset outputXML = outputXML & ' name="#attributes.code#" label="#AnswerfieldText#"  >
'>
					
<cfset outputXML = outputXML & '
<Option type="#ans.type#" id="#ans.id#" name="m" label="male" helpcode=""/>
'>
<cfset outputXML = outputXML & '
<Option type="#ans.type#" id="#ans.id#" name="f" label="female"/>
'>
<cfset outputXML = outputXML & '</Answerfield>
						'>	
					<cfelseif ans.type eq "integer" or ans.type eq 'either_or_marital'>
	<cfif AnswerfieldText contains "60 years">
    	<cfset attributes.code = "over_60">
    <cfelseif AnswerfieldText eq "Disabled">
		<cfset attributes.code = "hh_disabled">
	</cfif>
<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>
					<cfset outputXML = outputXML & ' name="#attributes.code#" label="#AnswerfieldText#"'>
<cfset outputXML = outputXML & '></Answerfield>
						'>

					<cfelseif ans.type eq "yn">
<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>
					<cfset outputXML = outputXML & ' name="#attributes.code#" label="#AnswerfieldText#"  >
'>
<cfset outputXML = outputXML & '
<Option type="#ans.type#" id="#ans.id#" name="y" label="yes" helpcode=""/>
'>
<cfset outputXML = outputXML & '
<Option type="#ans.type#" id="#ans.id#" name="n" label="no"/>
'>
<cfset outputXML = outputXML & '</Answerfield>
						'>
					<cfelseif ans.type eq "currency">
<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>

					<cfset outputXML = outputXML & ' name="#attributes.code#" label=""'>
<cfset outputXML = outputXML & '></Answerfield>
						'>	


				 	<cfelseif ans.type eq "month">
					  <cfif ans.id eq "4271">
<cfset outputXML = outputXML & '
<Answerfield type="select" id="4271" name="dob_month" label="">'> 
<cfloop from="1" to="12" index="m">
<cf_displayText group="calendar" code="calendar_month_#m#" var="monthval">
<cfset outputXML = outputXML & '<Option type="#ans.type#" id="#ans.id#"  name="#m#" label="#monthval#" helpcode=""/>
'>
</cfloop>               
<cfset outputXML = outputXML & '</Answerfield>
						'>
					  <cfelseif ans.id eq "4273">
<cfset outputXML = outputXML & '
<Answerfield type="select" id="4273" name="sp_dob_month" label="">'>
<cfloop from="1" to="12" index="m">
<cf_displayText group="calendar" code="calendar_month_#m#" var="monthval">
<cfset outputXML = outputXML & '<Option type="#ans.type#" id="#ans.id#"  name="#m#" label="#monthval#" helpcode=""/>
'>
</cfloop>
<cfset outputXML = outputXML & '</Answerfield>
						'>
					</cfif>

				 	<cfelseif ans.type eq "year">
					  <cfif ans.id eq "4272">
<cfset outputXML = outputXML & '
<Answerfield type="select" id="4272" name="dob_year" label="">
					'>
<cfset outputXML = outputXML & '<Option type="#ans.type#" id="#ans.id#"  name="1899" label="before 1900" helpcode=""/>
'>
                    <cfloop from="1900" to="#DateFormat(Now(), "yyyy")#" index="y">
<cfset outputXML = outputXML & '<Option type="#ans.type#" id="#ans.id#"  name="#y#" label="#y#" helpcode=""/>
'>
                    </cfloop>
<cfset outputXML = outputXML & '</Answerfield>
						'>
					  <cfelseif ans.id eq "4274">
<cfset outputXML = outputXML & '
<Answerfield type="select" id="4274" name="sp_dob_year" label="">
					'>
<cfset outputXML = outputXML & '<Option type="#ans.type#" id="#ans.id#"  name="1899" label="before 1900" helpcode=""/>
'>
                    <cfloop from="1900" to="#DateFormat(Now(), "yyyy")#" index="y">
<cfset outputXML = outputXML & '<Option type="#ans.type#" id="#ans.id#"  name="#y#" label="#y#" helpcode=""/>
'>
                    </cfloop>
<cfset outputXML = outputXML & '</Answerfield>
						'>
					</cfif>

					<cfelseif ans.type eq "text">
<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>
						<cfif attributes.code eq "race">
						<cfset outputXML = outputXML & ' name="other_#attributes.code#" label=""'>
						<cfset outputXML = outputXML & '></Answerfield>
							'>
						<cfelseif  attributes.code eq "learn">
						<cfset outputXML = outputXML & ' name="other_#attributes.code#" label=""'>
						<cfset outputXML = outputXML & '></Answerfield>
							'>
						<cfelseif  attributes.code eq "client">
						<cfset outputXML = outputXML & ' name="#attributes.code#_other" label=""'>
						<cfset outputXML = outputXML & '></Answerfield>
							'>
						<cfelse>
						<cfset outputXML = outputXML & ' name="#attributes.code#" label=""'>
						<cfset outputXML = outputXML & '></Answerfield>
							'>			
						</cfif>
					  
					<cfelseif ans.type eq "zipcode">
<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>
					<cfset outputXML = outputXML & ' name="#attributes.code#" label=""'>
<cfset outputXML = outputXML & '></Answerfield>
						'>
					<cfelseif ans.type eq "drug" or ans.type eq "druglist">
				<cfset outputXML = outputXML & '
<Answerfield type="#ans.type#" id="#ans.id#"'>
					<cfset outputXML = outputXML & ' name="#attributes.code#" label="" >'>
<cf_loopRxStruct grouplist="rx,generic" chop="100" object="rxobj">
					<cfset outputXML = outputXML & '
<Option type="#ans.type#" id="#ans.id#"  name="#rxobj.code#" label="#rxobj.text#" helpcode=""/>'>
				</cf_loopRxStruct>

<cfset outputXML = outputXML & '></Answerfield>
						'>

					</cfif>			
					<cfset loopcount = loopcount + 1>
					</cf_loopPoolStruct>			
</cfif>				
				<cfset outputXML = outputXML & '
</Question>
				'>	
</cfif>							
				<!-- DISPLAY FIELD --
		
	</cfif>
</cfif>
<cfset outputXML = #replacenocase(outputXML,"<div style=&quot;display: none;&quot; class=&quot;helpTip&quot;>","","ALL")#>
<cfset outputXML = #replacenocase(outputXML,'<div style="display: none;" class="helpTip"',"","ALL")#>
<cfset outputXML = #replacenocase(outputXML,"</div>","","ALL")#>
<cfset outputXML = #replacenocase(outputXML,"<h2>","","ALL")#>
<cfset outputXML = #replacenocase(outputXML,"</h2>","","ALL")#>
<cfset outputXML = #replacenocase(outputXML,"< h2>","","ALL")#>
<cfset outputXML = #replacenocase(outputXML,"< div>","","ALL")#>
<cfset caller.outputXML = outputXML>
