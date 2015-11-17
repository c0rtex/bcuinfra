<cfparam name="subset_id" type="numeric">
<cfparam name="post_code" type="string">
<cfparam name="section_code" type="string">
<cfparam name="saving" type="numeric" default="0"> 
<cfparam name="name" type="string" default="">
<cfparam name="action" type="string" default="new">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>



<cf_buildPage title="Subset Content">

<cf_buildView title="Subset Content" name="#name#" table="subset_content" code="question" key="#subset_id#,#post_code#,#section_code#" action="#action#" viewlevel="0" saving="#saving#" actionurl="subset_contentview.cfm?subset_id=#subset_id#&post_code=#post_code#&section_code=#section_code#" redirect="subsetview.cfm?id=#subset_id####name#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" link="subsetquestions.cfm?id=[[id]]#anchorname#">
	<cf_buildViewProperty column="post_code" skipon="edit">
	<cf_buildViewProperty column="programcategory_id" input="select" references="programcategory">
	<cf_buildViewProperty column="required_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="exclude_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="options_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="options_flag" visible="false" valueonadd="0">
</cf_buildView>



</cf_buildPage>
