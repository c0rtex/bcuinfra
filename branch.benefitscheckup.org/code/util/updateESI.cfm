<!--- Copy and paste this code to check screenings --->
<cfquery name="results9"  datasource="#APPLICATION.dbSrc#">
select * from screening_content where screening_id =  6671767
</cfquery>
<cfdump var="#results9#">
<!--- Copy and paste this code --->
<cfquery name="results"  datasource="#APPLICATION.dbSrc#">
select count(*) from screening where 
partner_id=77 and subset_id=63 
and start_datetime > '2013-11-30'  and end_datetime < '2014-05-01' 
and screening_id > 6671767
</cfquery>
<cfquery name="results9"  datasource="#APPLICATION.dbSrc#">
select screening_id, end_datetime from screening where 
partner_id=77 and subset_id=63 
and start_datetime > '2013-11-30'  and end_datetime < '2014-05-01' 
and screening_id > 6671767
</cfquery>
<cfloop query="results9">
<cfoutput><tr><td>#screening_id#</td><td>#screening_id#</td><td>&nbsp; #end_datetime#</td><td><a target="new" href="/esi-results/?screeningID=#screening_id#">#screening_id#</a></td></tr></cfoutput>
<cfhttp method="Get" 
    url="https://www.benefitscheckup.org/esi-results/?screeningID=#screening_id#"> 
</cfhttp> 
<cfoutput> 
Mime Type:#cfhttp.statusCode#<br> 
</cfoutput> 
<cfflush>
</cfloop>
<cfabort>




