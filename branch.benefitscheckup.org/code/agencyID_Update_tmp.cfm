<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Update FIT Agency ID </title>
<!-- Preface response for answerfield_id 6271 with 0 where there are only 3 chars-->
<!-- Set responsetype to 2 answerfield_id 6271 with 0 where there are only 3 chars-->
</head>
<table>
	<cfquery name="findScreenings" datasource="#application.dbSrc#">
	Select screening_id, responsetype, response
    from screening_answerfield
    where answerfield_id= 6271 and len(response) < 4 
	</cfquery>
	<tr>
		<td>
			<cfoutput>There are #findScreenings.RecordCount# screening_answerfield records that have less than 4 digits in fit_agency_id in #application.dbSrc#!</cfoutput>
       	</td>
  	</tr>
    <cfoutput>
    <cfloop query="findScreenings">
		<cfif len(response) eq 3>
        	<tr><td>Screening_id: #findScreenings.screening_id#<BR />Original fit_agency_id value: #findScreenings.response#<BR />Updated fit_agency_id value: 0#findScreenings.response#<BR />Original responsetype value: #findScreenings.responsetype#<BR />Updated responsetype value: 2<BR /><BR /></td></tr>
        	<cfquery name="update3" datasource="#application.dbSrc#">
				UPDATE screening_answerfield
   				SET responsetype = 2
                  , response = '0#Trim(findScreenings.response)#'
 				WHERE answerfield_id = 6271 and screening_id = #findScreenings.screening_id#
			</cfquery>
        <cfelseif len(response) eq 2>
        	<tr><td>Screening_id: #findScreenings.screening_id#<BR />Original fit_agency_id value: #findScreenings.response#<BR />Updated fit_agency_id value: 00#findScreenings.response#<BR />Original responsetype value: #findScreenings.responsetype#<BR />Updated responsetype value: 2<BR /><BR /></td></tr>
        	<cfquery name="update3" datasource="#application.dbSrc#">
				UPDATE screening_answerfield
   				SET responsetype = 2
                  , response = '00#Trim(findScreenings.response)#'
 				WHERE answerfield_id = 6271 and screening_id = #findScreenings.screening_id#
			</cfquery>
        <cfelseif length(response) eq 1>
        	<tr><td>Screening_id: #findScreenings.screening_id#<BR />Original fit_agency_id value: #findScreenings.response#<BR />Updated fit_agency_id value: 000#findScreenings.response#<BR />Original responsetype value: #findScreenings.responsetype#<BR />Updated responsetype value: 2<BR /><BR /></td></tr>
            <cfquery name="update3" datasource="#application.dbSrc#">
				UPDATE screening_answerfield
   				SET responsetype = 2
                  , response = '000#Trim(findScreenings.response)#'
 				WHERE answerfield_id = 6271 and screening_id = #findScreenings.screening_id#
			</cfquery>
        </cfif>
	</cfloop>
    </cfoutput>
</table>
<body>
</body>
</html>
