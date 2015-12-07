<cfparam name="attributes.answerfield" type="string" default="">
<cfquery name="aspvar" datasource="#application.dbSrc#">	
select 
a.answerfield, at.code
from answerfield a inner join answerfieldtype at
on a.answerfieldtype_id=at.answerfieldtype_id			
left outer join rule r
on a.rule_id=r.rule_id
left outer join validation v				
on a.validation_id=v.validation_id			
left outer join answerfield_option ao				
on a.answerfield_id=ao.answerfield_id			
left outer join `option` o				
on ao.option_id=o.option_id	
where a.answerfield like '#attributes.answerfield#'	
order by a.answerfield, ao.sort	
</cfquery>

<cfset listvar = "">

<cfif aspvar.code eq "checkbox">
	<cfset listvar = "c-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "select">
	<cfset listvar = "o-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "text">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "currency">
	<cfif aspvar.answerfield contains 'asset'>
		<cfset aftype = 'a-'>
	<cfelseif  aspvar.answerfield contains 'income'>
		<cfset aftype = 'i-'>
	<cfelse >
		<cfset aftype = 'n-'>
	</cfif>
	<cfset listvar = "#aftype#" & aspvar.answerfield > 
<cfelseif aspvar.code eq "zipcode">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "yn">
	<cfset listvar = "y-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "integer">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "state">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "drug">
	<cfset listvar = "d-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "ssn">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "income">
	<cfset listvar = "i-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "asset">
	<cfset listvar = "a-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "city">
	<cfset listvar = "a-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "no">
	<cfset listvar = "s-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "year">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "month">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "day">
	<cfset listvar = "n-" & aspvar.answerfield > 
<cfelseif aspvar.code eq "gender">
	<cfset listvar = "g-" & aspvar.answerfield > 
<cfelse >
	<cfset listvar = "s-" & aspvar.answerfield > 
</cfif>

<cfset caller.aflistvar = listvar >