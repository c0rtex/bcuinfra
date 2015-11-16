<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_assetgrid
	WHERE RecID = '#id#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 's_asset_#answer#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 'sp_asset_#answer#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 's_sp_asset_#answer#'
</CFQUERY>

<CFQUERY DATASOURCE="#application.dbSrc#">
	DELETE
	FROM tbl_answerfield_list
	WHERE answerfield = 'hh_asset_#answer#'
</CFQUERY>

<CFLOCATION URL="frmIncome_asset_show.cfm">