<cfsetting enablecfoutputonly="yes" showdebugoutput="no"> 
<cfprocessingdirective suppresswhitespace="yes"  pageEncoding = "iso-8859-1" >
	<cfquery name="exp" datasource="#application.dbSrc#">
		SELECT *
		FROM programtext
	</cfquery>
<cf_excel_xml filename="programtext" sheets="1"  query1="#exp#"  >
</cfprocessingdirective> 