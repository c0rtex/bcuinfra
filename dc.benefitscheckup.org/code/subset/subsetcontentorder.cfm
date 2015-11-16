<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="section_code" type="string" default="">
<cf_checkAccess level="3">

<cf_buildPage title="Subset Content Order" section="subset" js="order"><cfoutput>

<!--- <cf_buildOrder name="#name#" table="subset_content" ordercolumn="sort_order" code="subset_content" condition="sort_order=1" saving="#saving#" title="Subset Content (Recommendations) Order: ESI consumer recs" redirect="subsetview.cfm?id=#id#"> --->

<cf_buildOrder name="#name#" table="subset_content" code="subset_content" ordercolumn="sort_order" order="sort_order" condition="subset_content.section_code='#section_code#' and subset_content.subset_id = #id#" crosstable="subset_content" crosstag="subset_content" crosskey="post_code" crosscolumn="post_code" crosscondition="x.post_code=subset_content.post_code and subset_content.section_code='#section_code#' and subset_content.subset_id = #id# and x.section_code='#section_code#' and x.subset_id = #id#" saving="#saving#" title="Subset Content (Recommendations) Order: #section_code# recs" redirect="subsetview.cfm?id=#id#">


<!--- <cf_buildOrder name="#name#" table="subset_requisite" code="requisite" condition="subset_id=#id#" crosstable="requisite" crosstag="rq" crosskey="requisite_id" crosscolumn="code" crosscondition="x.requisite_id=rq.requisite_id" saving="#saving#" title="Requisite Item (Needed Info) Order" redirect="subsetview.cfm?id=#id#"> --->

</cfoutput></cf_buildPage>
