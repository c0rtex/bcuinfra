<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_incomegrid
	WHERE RecID = '#id#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 's_income_#answer#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 'sp_income_#answer#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 's_sp_income_#answer#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 'hh_income_#answer#'
</CFQUERY>

<CFLOCATION URL="frmIncome_asset_show.cfm">