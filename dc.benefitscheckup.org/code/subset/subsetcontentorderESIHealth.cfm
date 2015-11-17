<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">
<cfparam name="saving" type="numeric" default="0">

<cf_checkAccess level="3">

<cf_buildPage title="Subset Content Order" section="subset" js="order"><cfoutput>


<cf_buildOrder name="#name#" table="subset_content" code="subset_content" ordercolumn="sort_order" order="sort_order" condition="subset_content.section_code='health_recs' " crosstable="subset_content" crosstag="subset_content" crosskey="post_code" crosscolumn="post_code" crosscondition="x.post_code=subset_content.post_code" saving="#saving#" title="Subset Content (Recommendations) Order: ESI health recs" redirect="subsetview.cfm?id=#id#">



</cfoutput></cf_buildPage>
