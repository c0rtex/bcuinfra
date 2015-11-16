<CFSET op_name = attributes.op_name>
<CFSET criteria_name = attributes.criteria_name>
<CFSET field = attributes.field>
<CFSET inc_tbl_name = attributes.inc_tbl_name>

<CFIF IsDefined("attributes.edit")>
	<CFSET op = #attributes.op#>
	<CFSET criteria=#attributes.criteria#>
	
	<CFOUTPUT>#field#</CFOUTPUT>
	<CFIF op IS "lteq">
		must be less than equal to
	<CFELSEIF op IS "gteq">
		must be greater than equal to
	<CFELSEIF op IS "lt">
		must be less than
	<CFELSEIF op IS "gt">
		must be greater than
	<CFELSEIF op is "eq">
		must be
	<CFELSEIF op is "neq">
		must not be
	</CFIF>
	
	<CFOUTPUT>
		<INPUT TYPE="text" NAME="#criteria_name#" VALUE="#criteria#">
	</CFOUTPUT>

<CFELSE>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fields1">
		SELECT * 
		FROM tbl_fields_list
		WHERE field_nm = '#field#'
	</CFQUERY>
	
	<CFSET tblst = #mid("#prg_id#",14,3)#>
	<CFIF tblst IS NOT "MN2">
		<CFSET tblst = left(tblst,2)>
	</CFIF>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prgs">
		SELECT prg_id,prg_nm
		FROM tbl_prg_FD
		UNION
		SELECT prg_id,prg_nm
		FROM tbl_prg_#tblst#
		ORDER BY prg_nm
	</CFQUERY>
	
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="fields">
		SELECT *
		FROM tbl_fields_list
		ORDER BY field_desc
	</CFQUERY>
	
	<CFIF field IS "program">
		<CFOUTPUT>#inc_tbl_name#</CFOUTPUT>
		<CFOUTPUT>
			<SELECT NAME="#inc_tbl_name#">
		</CFOUTPUT>
			<CFOUTPUT QUERY="prgs">
				<OPTION VALUE="#prg_id#">#prg_nm#
			</CFOUTPUT>
		</SELECT> 
		<INPUT TYPE="hidden" NAME="sec" VALUE="yes">
		<CFOUTPUT><INPUT TYPE="hidden" NAME="inc" VALUE="#inc_tbl_name#"></CFOUTPUT>
	<CFELSE>
		<CFOUTPUT>#fields1.field_desc#</CFOUTPUT>
	</CFIF>
	<CFIF fields1.type IS "txt">
		must be
		<CFOUTPUT><SELECT NAME="#op_name#" SIZE="1"></CFOUTPUT>
			<OPTION>
			<OPTION VALUE="eq">equal to
			<OPTION VALUE="gt">greater than
			<OPTION VALUE="lt">less than
			<OPTION VALUE="gteq">greater than or equal to 
			<OPTION VALUE="lteq">less than or equal to
			<OPTION VALUE="inlist">in following list:
		</SELECT>
		<BR>
		<CFOUTPUT><INPUT TYPE="text" NAME="#criteria_name#" size="50"><br></CFOUTPUT>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="inc">
			SELECT tbl_nm,tbl_id
			FROM tbl_inc
			ORDER BY tbl_nm
		</CFQUERY>
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="inc2">
			SELECT DISTINCT tbl_nm
			FROM tbl_inc_cnty
			ORDER BY tbl_nm
		</CFQUERY>
		If income table is required type "table" and choose table below:
		<BR>
		<CFOUTPUT>
			<SELECT NAME="#inc_tbl_name#">
		</CFOUTPUT>
				<OPTION>
				<CFOUTPUT QUERY="inc">
					<OPTION VALUE="#tbl_id#">#tbl_nm#
				</CFOUTPUT>
			</SELECT>
		<BR>
		If COUNTY income table is required type "table_county" and choose table below:
		<BR>
		<CFOUTPUT>
			<SELECT NAME="#inc_tbl_name#">
		</CFOUTPUT>
				<OPTION>
				<CFOUTPUT QUERY="inc2">
					<OPTION VALUE="#tbl_nm#">#tbl_nm#
				</CFOUTPUT>
			</SELECT>		
	<CFELSEIF #fields1.type# IS "yn">
		must be
		<CFOUTPUT>
			<INPUT TYPE="hidden" NAME="#op_name#" VALUE="eq">
			<SELECT NAME="#criteria_name#">
		</CFOUTPUT>
				<OPTION>
				<OPTION VALUE="Y">Yes
				<OPTION VALUE="N">No
			</SELECT>
	<CFELSEIF #fields1.type# IS "opt">
		<CFQUERY DATASOURCE="#application.dbSrc#" NAME="opts">
			SELECT OPTION_nm
			FROM tbl_opt
			WHERE field_nm = '#fields1.field_nm#'
		</CFQUERY>
		<CFOUTPUT>
			<SELECT NAME="#op_name#">
		</CFOUTPUT>
			<OPTION>
			<OPTION VALUE="eq">Must be
			<OPTION VALUE="neq">Must not be
		</SELECT>
		<CFOUTPUT>
			<SELECT NAME="#criteria_name#">
		</CFOUTPUT>
				<OPTION>
				<CFOUTPUT QUERY="opts">
					<OPTION VALUE="#OPTION_nm#">#option_nm#
				</CFOUTPUT>
			</SELECT>
		<BR>
	</CFIF>
	<CFIF field IS "calc">
		Calculation Fields:
		<SELECT NAME="calc_field">
			<OPTION>
			<CFOUTPUT query="fields">
				<OPTION VALUE="#field_nm#">#field_desc#
			</CFOUTPUT>
		</SELECT>
		<SELECT NAME="calc_op">
			<OPTION VALUE="sub">-
			<OPTION VALUE="add">+
			<OPTION VALUE="mul">*
			<OPTION VALUE="div">/
		</SELECT>
		<SELECT NAME="calc_field2">
			<OPTION>
			<CFOUTPUT query="fields">
				<OPTION VALUE="#field_nm#">#field_desc#
			</CFOUTPUT>
		</SELECT>
	</CFIF>
</CFIF>