<cfoutput>
INSERT INTO `tbl_questions_new` VALUES ('792', 'chronic_condition', '6', '58', 'pri', 'Do you currently have any of the following [[def|chroniccondition2|chronic conditions]]: arthritis, asthma, emphysema, bronchitis, cancer, depression, anxiety, diabetes, heart disease, high blood pressure, stroke, osteoporosis, or HIV/AIDS?', 'opt', null, 'self', null, null, null, null, '(session.partner_id eq 0) and (session.org_id lt 1)');
here:

<cfset session.subset_id = 0 >


<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string" default="incomegrid">
<cfparam name="attributes.aflistvarname" type="string" default="">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode eq 'print' or attributes.mode eq 'XML'>
	<cfset stripTags = true>
<cfelse>
	<cfset stripTags = false>
</cfif>

<cfset qobj = application.QuestionPool.getQuestion(attributes.code)>
<cf_cacheSubsetQuestionGridrowPool action="get" subset_id="0" question="#attributes.code#" var="sqgobj">
<cf_cacheSubsetQuestionGridrowPool action="refresh" subset_id="0" question="#attributes.code#" var="sqgobj">

<cfoutput>
	<tr>
		<td colspan="9" class="question-space"></td>
	</tr>
	<tr class="question-print">
		<td colspan="3"></td>
		<td colspan="6"><table width="580" align="left" border="0" cellspacing="5" cellpadding="0">
			<tr class="question-print">
				<td width="250" class="q-text">&nbsp;</td>
				<cf_loopPoolStruct struct="qobj" sortBy="gsort" index="gccode">
					<cf_displayText group="gridcol" code="gridcol_#gccode#" var="gctext">
					<cf_cacheGridcolumnPool action="get" code="#gccode#" var="gcobj">
					<cfif attributes.mode eq 'print' or gcobj.help eq ''>
						<cfset colhead = gctext>
					<cfelse>
                    	<cf_buildPopupLink code="#gcobj.help#" text="#gctext#" var="colhead">
					</cfif>
					<td width="75" class="q-text-center"><strong>#colhead#</strong></td>
				</cf_loopPoolStruct>
			</tr>

		<cf_loopPoolStruct struct="sqgobj" index="grcode">
			<cf_displayText group="gridrow" code="gridrow_#grcode#" var="grtext">
			<cf_cacheGridrowPool action="get" code="#grcode#" var="grobj">
			<cfif attributes.mode eq 'print' or grobj.help eq ''>
				<cfset rowhead = grtext>
			<cfelse>
				<cf_buildPopupLink code="#grobj.help#" text="#grtext#" var="rowhead">
			</cfif>
			
			<tr class="question-print">
				<td width="250" class="q-text">#rowhead#</td>
				<cf_loopPoolStruct struct="qobj" sortBy="gsort" index="gccode">
					<cf_cacheGridrowGridcolumnPool action="get" code="#grcode#_#gccode#" var="ggobj">			
                    <cfset ansObj = application.answerfieldPool.getAnswerfield(ggobj.af)>
					<cfset type = ansObj.type> 
					<td width="75" class="q-text-center"><cfoutput> code="#ggobj.af#" type="#type#" showText="false" aflistvarname="caller.#attributes.aflistvarname#  <br> </cfoutput></td>
				</cf_loopPoolStruct>
			</tr>
		</cf_loopPoolStruct>
		</table></td>
</cfoutput>






<cfdump var="#application.bcuGridrowGridcolumnPool#">




<cfquery name="subset" datasource="#application.dbSrc#">update gridrow set gridrow_id = 25 where gridrow_id = 26</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">
select gr.code grcode, gc.code gccode, a.answerfield
		from gridrow_gridcolumn_answerfield gga, gridrow gr, gridcolumn gc, answerfield a
		where gga.gridrow_id=gr.gridrow_id
			and gga.gridcolumn_id=gc.gridcolumn_id
			and gga.answerfield_id=a.answerfield_id
		order by gr.sort, gc.sort
</cfquery><cfdump var="#subset#">

<cfquery name="subset" datasource="#application.dbSrc#">
select * from display d, display_language dl where d.display_id = dl.display_id and display_code like 'gridrow_%' 
</cfquery><cfdump var="#subset#">






<cfquery name="subset" datasource="#application.dbSrc#">
		select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='income_grid'
			and q.question_id=qg.question_id
			and qg.gridrow_id=g.gridrow_id
			and g.exclude_flag=0
			and g.gridrow_id not in (
				select gridrow_id
				from subset_gridrow
				where subset_id=0
					and exclude_flag=1
			)
		union
		select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='income_grid'
			and q.question_id=qg.question_id
			and qg.gridrow_id=g.gridrow_id
			and g.exclude_flag=1
			and g.gridrow_id in (
				select gridrow_id
				from subset_gridrow
				where subset_id=0
					and exclude_flag=0
			)
		order by gsort
</cfquery><cfdump var="#subset#">

<cfabort>
<cfquery name="subset" datasource="#application.dbSrc#">INSERT INTO `display` VALUES ('90307', '3', 'question_chronic_condition', 'Question Text: chronic_condition', null, '1');</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">INSERT INTO `display` VALUES ('90307', '3', 'question_chronic_condition', 'Question Text: chronic_condition', null, '1');</cfquery>



<cfquery name="subset" datasource="#application.dbSrc#">
SELECT *
				FROM tbl_opt
				WHERE field_nm = 'chronic_condition'
				ORDER BY sort_id
</cfquery><cfdump var="#subset#">

<cfquery name="subset" datasource="#application.dbSrc#">
select * from tbl_questions_new where question like '%chronic%'
</cfquery><cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from rule_answerfield where answerfield_id = 6862
</cfquery><cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from answerfield_option where answerfield_id = 6862
</cfquery><cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from question where question_id = 792
</cfquery><cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from question_answerfield where question_id = 792
</cfquery><cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from answerfield where answerfield_id = 6862
</cfquery>
<cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from rule_answerfield where answerfield_id =6862
</cfquery>
<cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from program_answerfield where answerfield_id =6862
</cfquery>
<cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from answerfield where answerfield like '%chronic%'
</cfquery>
<cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from rule where rule_id = 1827
</cfquery>
<cfdump var="#subset#">

<cfquery name="subset" datasource="#application.dbSrc#">
select * from display where display_id in (90028,90029,9030,9031,90315)
</cfquery>
<cfdump var="#subset#">


<cfquery name="subset" datasource="#application.dbSrc#">
select * from display_language where display_id in (90028,90029,9030,9031,90315)
</cfquery>
<cfdump var="#subset#">

<cfabort>


<cfquery name="subset" datasource="#application.dbSrc#">select * from answerfield where annswerfield like 'ch_rec_child_care'</cfquery>


<cfquery name="subset" datasource="#application.dbSrc#">select * from xsubset_xincometype</cfquery>
<cfdump var="#subset#">

<cfquery name="subset" datasource="#application.dbSrc#">
 select * from gridrow_gridcolumn_answerfield  where gridrow_id = 25
</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">
  select * from gridrow_gridcolumn_answerfield 
</cfquery>
<cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
select * from answerfield where answerfield like '%income_unemployment%'

</cfquery>
<cfdump var="#subset#">

</cfoutput>