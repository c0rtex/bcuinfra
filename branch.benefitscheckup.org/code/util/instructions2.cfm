<cfoutput>


<cfquery name="subset" datasource="#application.dbSrc#">select * from xincometype</cfquery>
<cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">select * from xsubset_xincometype</cfquery>
<cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">update display set display_code = 'answerfield_ch_rec_childcare' where display_id = 90028;</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">update display set display_code = 'afshort_ch_rec_childcare' where display_id = 90029;</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">update display set display_code = 'afspq_ch_rec_childcare' where display_id = 90030;</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">update display set display_code = 'afprint_ch_rec_childcare' where display_id = 90031;</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">
 select * from display where display_code like '%ch_rec_child%' limit 10
</cfquery><cfdump var="#subset#">
<cfquery name="subset" datasource="#application.dbSrc#">
 update answerfield set answerfield = 'ch_rec_childcare' where answerfield = 'ch_rec_child_care'
</cfquery>
<cfquery name="subset" datasource="#application.dbSrc#">select * from answerfield where answerfield like 'ch_rec_childcare'</cfquery>
<cfdump var="#subset#">

</cfoutput>
