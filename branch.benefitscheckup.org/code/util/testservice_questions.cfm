<cfinvoke method="getQuestions" 
returnvariable="responseFromService" 
webservice="http://bcuqa.benefitscheckup.org/util/remotescreening_staging.cfc?wsdl" >

<cfinvokeargument name="partner_id" value="#url.partner_id#">
<cfinvokeargument name="subset_id" value="#url.subset_id#">
<cfinvokeargument name="state_id" value="#url.state_id#">

</cfinvoke>

<!--- cfset questiondata = #xmlparse(responsefromservice)# --->

<cfsetting enablecfoutputonly="yes"> <!--- Required for CSV export to function properly --->
<cfset delim = 44> <!--- Use a comma for a field delimitter, Excel will open CSV files --->
<cfcontent type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=QuestionExport_Subset_#url.subset_id#_Partner_#url.partner_id#_State_#url.state_id#.csv" >


<!--- Output Column Headers --->
<cfoutput>Sort#chr(delim)#"Field Name"#chr(delim)#"Question Type"#chr(delim)#"Field Type"#chr(delim)#Values#chr(delim)#Labels#chr(delim)#Validation#chr(delim)#Question#chr(delim)#Required#chr(delim)#QuestionCat</cfoutput>
<cfoutput>#chr(13)##chr(10)#</cfoutput> <!--- line break after column header --->
<!--- Spill out data from a query --->
<cfset xmlfile = responsefromservice>

<!---cfoutput>#xmlfile#</cfoutput--->
<cfset questiondata = #xmlparse(xmlfile)#>
<!--- cfdump var="#questiondata#" --->
<cfset questioncount = #structcount(questiondata.questionnaire.questions)#>
<cfloop from="1" to="#questioncount#" index="i">
<cfset qsort = #questiondata.Questionnaire.questions.question[i].XMLAttributes.DisplaySort#>
<cfset Field = #questiondata.Questionnaire.questions.question[i].XMLAttributes.code#>
<cfset QuestionType = #questiondata.Questionnaire.questions.question[i].XMLAttributes.fieldtype#>
<cfset FieldType = "">
<cfset Values = "">
<cfset Labels = "">
<cftry>
	<cfset Labels = #questiondata.Questionnaire.questions.question[i].Answerfield[1].XMLAttributes.label#>
<cfcatch><cfset Labels = ""></cfcatch>
</cftry>

<cftry>
<cfset optionscount = #structcount(questiondata.questionnaire.questions.question[i].Answerfield[1])#>
<cfloop from="1" to="#optionscount#" index="x">
	<cfif x eq 1>
		<cfset Labels = #questiondata.Questionnaire.questions.question[i].answerfield[1].option[x].XMLAttributes.label#>
	<cfelse>
		<cfset Labels = Labels & ":" & #questiondata.Questionnaire.questions.question[i].answerfield[1].option[x].XMLAttributes.label#>
	</cfif>
	
</cfloop>
<cfcatch></cfcatch>
</cftry>
<cftry>
<cfset optionscount = #structcount(questiondata.questionnaire.questions.question[i].Answerfield[1])#>
<cfloop from="1" to="#optionscount#" index="x">
	<cfif x eq 1>
		<cfset Values =  #questiondata.Questionnaire.questions.question[i].answerfield[1].option[x].XMLAttributes.name#>
	<cfelse>
		<cfset Values = Values & ":" & #questiondata.Questionnaire.questions.question[i].answerfield[1].option[x].XMLAttributes.name#>
	</cfif>
</cfloop>
<cfcatch></cfcatch>
</cftry>
<cfset qtext = replacenocase(questiondata.Questionnaire.questions.question[i].XMLAttributes.questiontext,",",",","ALL")>
<cfset required = #questiondata.Questionnaire.questions.question[i].XMLAttributes.required#>
<cfset validation = "">
<cfset QCat = #questiondata.Questionnaire.questions.question[i].XMLAttributes.Category#>
<cfoutput>"#qsort#"#chr(delim)#"#Field#"#chr(delim)#"#Questiontype#"#chr(delim)#"#FieldType#"#chr(delim)#"#Values#"#chr(delim)#"#Labels#"#chr(delim)#"#Validation#"#chr(delim)#"#Qtext#"#chr(delim)#"#Required#"#chr(delim)#"#QCat#"</cfoutput>
<cfoutput>#chr(13)##chr(10)#</cfoutput>
</cfloop>