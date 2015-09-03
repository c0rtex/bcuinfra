<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.media" type="string" default="">

<cfset debug = false>
<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif debug>
	<cfset borders = 'border:1px solid black;'>
<cfelse>
	<cfset borders = ''>
</cfif>

<cfif attributes.media eq ''>
	<cfif attributes.mode eq 'print'>
		<cfset attributes.media = 'print'>
	<cfelse>
		<cfset attributes.media = 'screen'>
	</cfif>
</cfif>

<!--- section for media-specific values, not currently used
<cfswitch expression="#effectiveMedia#">
	<cfcase value="screen">
		<cfset qTextNarrowWidth = 456>
		<cfset qFieldWideWidth = 200>
		<cfset selectTabWideInternalWidth = 253>
		<cfset selectTabWideNextInternalWidth = 290>
	</cfcase>
	<cfcase value="print">
		<cfset qTextNarrowWidth = 436>
		<cfset qFieldWideWidth = 220>
		<cfset selectTabWideInternalWidth = 253>
		<cfset selectTabWideNextInternalWidth = 290>
	</cfcase>
</cfswitch>
--->

<cfoutput>
<cfif attributes.media eq 'print'>
<style type="text/css" media="print">
.pagebreak {
	page-break-before: avoid;
}
.noprint {
	display: none;
}
</style>
</cfif>

<style type="text/css">

.question-category {
	/*page-break-inside: avoid;*/
	width:640px;
	border:1px solid black;
	background-color:##bdcfc8;
	margin-bottom:10px;
	padding:1px 3px 1px 3px;
	font-size:10pt;
	font-weight:bold;
	font-variant:small-caps;
	clear:both;
}

.question-error {
	page-break-inside: avoid;
	border:1px solid red;
	color: black;
	background-color:##ff9999;
	margin-bottom:10px;
	padding:1px 3px 1px 3px;
	font-size:9pt;
	font-weight:bold;
	clear:both;
}

.question-space {
	#borders#
	/*page-break-inside: avoid;*/
	height:10px;
	margin-bottom:10px;
	clear:both;
}

.question-print {
	#borders#
	page-break-inside: avoid;
	font-size:9pt;
}

.q-no {
	#borders#
	/*page-break-inside: avoid;*/
	text-align:right;
	vertical-align:top;
	font-weight:bold;
}
		
.q-text {
	#borders#
	font-size:9pt;
	/*page-break-inside: avoid;*/
	vertical-align:top;
}
		
.q-text-center {
	#borders#
	/*page-break-inside: avoid;*/
	text-align:center;
	vertical-align:top;
}
		
.q-field {
	#borders#
	font-size:9pt;
	/*page-break-inside: avoid;*/
	text-align:right;
	vertical-align:top;
	line-height:12pt;
}

</style>
</cfoutput>