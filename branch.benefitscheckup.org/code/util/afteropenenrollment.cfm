<cfquery name="count"  datasource="#APPLICATION.dbSrc#">
select count(*)
from screening_contact 
where
AON_ID is not null and AON_RESPONSE_DATETIME >= '2013-12-08'
order by AON_RESPONSE_DATETIME
                                       
</cfquery><cfdump var="#count#">
<cfquery name="Details"  datasource="#APPLICATION.dbSrc#">
select *
from screening_contact 
where
AON_ID is not null and AON_RESPONSE_DATETIME >= '2013-12-08'
order by AON_RESPONSE_DATETIME
                                       
</cfquery><cfdump var="#Details#"><cfabort>
