<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Subset Question Order" section="subset" js="order"><cfoutput>


<cf_buildOrder name="#name#" table="subset_question" code="subset_content" ordercolumn="sort" order="sort" condition="subset_id=#id#" crosstable="question" crosstag="question" crosskey="question_id" crosscolumn="question_code" crosscondition="x.question_id=question.question_id and x.subset_id=#id#" saving="#saving#" title="Subset Question Order" redirect="subsetquestions.cfm?id=#id#">

<!---

<cf_buildOrder name="#name#" table="subset_content" code="subset_content" ordercolumn="sort_order" order="sort_order" condition="subset_content.section_code='mqc3'" crosstable="subset_content" crosstag="subset_content" crosskey="post_code" crosscolumn="post_code" crosscondition="x.post_code=subset_content.post_code and subset_content.section_code='mqc3' and x.section_code='mqc3'" saving="#saving#" title="Subset Content (Recommendations) Order: MQC3 recs" redirect="subsetview.cfm?id=#id#">
 
--->



</cfoutput></cf_buildPage>
