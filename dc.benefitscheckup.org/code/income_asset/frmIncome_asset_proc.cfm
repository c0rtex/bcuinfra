<CFIF isdefined("FORM.addincome")>
	
	<cfset question = #form.question#>
	
	<CFIF isdefined("FORM.self")>
		<cfset self = "Y">
	<CFELSE>
		<cfset self = "N">
	</CFIF>

	<CFIF isdefined("FORM.spouse")>
		<cfset spouse = "Y">
	<CFELSE>
		<cfset spouse = "N">
	</CFIF>
	
	<CFIF isdefined("FORM.self_spouse")>
		<cfset self_spouse = "Y">
	<CFELSE>
		<cfset self_spouse = "N">
	</CFIF>
	
	<CFIF isdefined("FORM.household")>
		<cfset household = "Y">
	<CFELSE>
		<cfset household = "N">
	</CFIF>
	
	<cfset answerfield = #form.answerfield#>
	
	<cfset number = #form.number#>
	
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_incomegrid (question,self,spouse,self_spouse,household,answerfield,number)
		VALUES ('#question#','#self#','#spouse#','#self_spouse#','#household#','#answerfield#','#number#')
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('s_income_#answerfield#')
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('sp_income_#answerfield#')
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('s_sp_income_#answerfield#')
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('hh_income_#answerfield#')
	</CFQUERY>

</CFIF>

<CFIF isdefined("FORM.addasset")>

	<cfset question = #form.question#>
	
	<CFIF isdefined("FORM.self")>
		<cfset self = "Y">
	<CFELSE>
		<cfset self = "N">
	</CFIF>
	
	<CFIF isdefined("FORM.spouse")>
		<cfset spouse = "Y">
	<CFELSE>
		<cfset spouse = "N">
	</CFIF>
	
	<CFIF isdefined("FORM.self_spouse")>
		<cfset self_spouse = "Y">
	<CFELSE>
		<cfset self_spouse = "N">
	</CFIF>
	
	<CFIF isdefined("FORM.household")>
		<cfset household = "Y">
	<CFELSE>
		<cfset household = "N">
	</CFIF>
	
	<cfset answerfield = #form.answerfield#>
	
	<cfset number = #form.number#>
	
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_assetgrid (question,self,spouse,self_spouse,household,answerfield,number)
		VALUES ('#question#','#self#','#spouse#','#self_spouse#','#household#','#answerfield#','#number#')
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('s_asset_#answerfield#')
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('sp_asset_#answerfield#')
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('s_sp_asset_#answerfield#')
	</CFQUERY>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		INSERT INTO tbl_answerfield_list (answerfield)
		VALUES ('hh_asset_#answerfield#')
	</CFQUERY>
</CFIF>

<CFLOCATION URL="frmIncome_asset_show.cfm">