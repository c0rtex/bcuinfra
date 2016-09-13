<cfparam name="bname" type="string" default="">
<cfparam name="gname" type="string" default="">

<cfoutput>
<ol>
<cfif bname neq ''>

	<cfset truncated = UCase(Left(REReplace(bname, '[^A-Za-z]', '', 'ALL'), 4))>
	<cfset iter = 0>
	<cfset taken = true>
	<cfloop condition="taken">
		<cfset iter = iter + 1>
		<cfset answerfield = "dn_" & truncated & iter>
		<cfquery name="ansmatch" datasource="#session.datasrc#">
			select answerfield
			from tbl_answerfield_list
			where lower(answerfield) = lower('#answerfield#')
		</cfquery>
		<cfif ansmatch.RecordCount eq 0>
			<cfset taken="false">
		</cfif>
	</cfloop>
	<cfset newanswerfield = LCase(answerfield)>
	<li>Create answerfield code: #answerfield#

	<cfif gname neq ''>
		<cfset bname = "#bname# (#gname#)">
	</cfif>
	<cf_displaySave action="insert" value="#bname#" group="answerfield" name="#newanswerfield#" code="#newanswerfield#" var="brand_display_id">
	<li>Save display text: "#bname#" = #brand_display_id#
	
	<cfquery name="ins" datasource="#session.datasrc#">
		insert into answerfield
			(answerfieldtype_id, answerfield, display_id, create_user_id, create_date, modify_user_id, modify_date)
		values
			(13, '#newanswerfield#', #brand_display_id#, 1, now(), 1, now())
	</cfquery>
	<cfquery name="brand" datasource="#session.datasrc#">
		select answerfield_id
		from answerfield
		where answerfield='#newanswerfield#'
	</cfquery>
	<cfset answerfield_id = brand.answerfield_id>
	<li>Save answerfield in <em>answerfield</em> table:  answerfield_id = #answerfield_id#
	
	<cfquery name="ins" datasource="#session.datasrc#">

		insert into tbl_answerfield_list
			(RecID, answerfield, answerfieldtype_id)
		values
			(#answerfield_id#, '#answerfield#', 13)

	</cfquery>
	<li>Save answerfield in <em>tbl_answerfield_list</em> table:  RecID = #answerfield_id#
	
	<cfquery name="mopt" datasource="#session.datasrc#">
		select max(sort_id) as smax
		from tbl_opt
	</cfquery>
	<cfset smax = mopt.smax + 1>
	<cfquery name="ins" datasource="#session.datasrc#">
		insert into tbl_opt
			(option_nm, field_nm, fieldtext, opt_type, sort_id)
		values
			('#bname#', 'drugnm', '#answerfield#', 'chk', #smax#)
	</cfquery>
	<cfquery name="opt" datasource="#session.datasrc#">
		select opt_id
		from tbl_opt
		where fieldtext='#answerfield#'
	</cfquery>
	<cfset opt_id = opt.opt_id>
	<li>Save answerfield as option in <em>tbl_opt</em> table:  opt_id = #opt_id#
	
	
	<cfif gname neq ''>
	
		<cfquery name="gfind" datasource="#session.datasrc#">
			select generic_id
			from tbl_generic
			where generic_name='#gname#'
		</cfquery>
		<cfif gfind.RecordCount gt 0>
		
			<cfset gmax = gfind.generic_id>
			<li>Found generic '#gname#': generic_id = #gmax#
		
			<cfquery name="gaf" datasource="#session.datasrc#">
				select answerfield_id
				from answerfield
				where answerfield='g#gmax#'
			</cfquery>
			<cfset generic_answerfield_id = gaf.answerfield_id>
			<li>Found generic answerfield: #generic_answerfield_id#
		
		<cfelse>
		
			<cfquery name="mgen" datasource="#session.datasrc#">
				select max(generic_id) as gmax
				from tbl_generic
			</cfquery>
			<cfset gmax = mgen.gmax + 1>
			<cfset gfield = "g#gmax#">
			<li>Create generic answerfield code: #gfield#
		
			<cfquery name="ins" datasource="#session.datasrc#">

				insert into tbl_generic
					(generic_id, generic_name)
				values
					(#gmax#, '#gname#')

			</cfquery>
			<li>Save generic drug in <em>tbl_generic</em> table:  generic_id = #gmax#
	
			<cf_displaySave action="insert" value="#gname#" group="answerfield" name="#gfield#" code="#gfield#" var="generic_display_id">
			<li>Save display text: "#gname#" = #generic_display_id#
			
			<cfquery name="ins" datasource="#session.datasrc#">
				insert into answerfield
					(answerfieldtype_id, answerfield, display_id, create_user_id, create_date, modify_user_id, modify_date)
				values
					(14, '#gfield#', #generic_display_id#, 1, now(), 1, now())
			</cfquery>
			<cfquery name="generic" datasource="#session.datasrc#">
				select answerfield_id
				from answerfield
				where answerfield='#gfield#'
			</cfquery>
			<cfset generic_answerfield_id = generic.answerfield_id>
			<li>Save generic answerfield in <em>answerfield</em> table:  answerfield_id = #generic_answerfield_id#
	
			<cfquery name="ins" datasource="#session.datasrc#">

				insert into tbl_answerfield_list
					(RecID, answerfield, answerfieldtype_id)
				values
					(#generic_answerfield_id#, '#gfield#', 14)

			</cfquery>
			<li>Save generic answerfield in <em>tbl_answerfield_list</em> table:  RecID = #generic_answerfield_id#
			
			<cfquery name="ins" datasource="#session.datasrc#">
				insert into tbl_opt
					(option_nm, field_nm, fieldtext, opt_type, sort_id)
				values
					('#gname#', 'drugnm', '#gfield#', 'chk', 1)
			</cfquery>
			<cfquery name="opt" datasource="#session.datasrc#">
				select opt_id
				from tbl_opt
				where fieldtext='#gfield#'
			</cfquery>
			<cfset generic_opt_id = opt.opt_id>
			<li>Save generic answerfield as option in <em>tbl_opt</em> table:  opt_id = #generic_opt_id#
			
		</cfif>

		<cfquery name="ins" datasource="#session.datasrc#">
			insert into answerfield_relationship
				(left_answerfield_id, right_answerfield_id, relationship_id)
			values
				(#answerfield_id#, #generic_answerfield_id#, 1)
		</cfquery>
		<li>Save generic association in <em>answerfield_relationship</em> table:  left_answerfield_id = #answerfield_id#; right_answerfield_id = #generic_answerfield_id#
	
		<cfquery name="ins" datasource="#session.datasrc#">
			insert into tbl_opt_generic
				(opt_id, generic_id)
			values
				(#opt_id#, #gmax#)
		</cfquery>
		<li>Save generic association in <em>tbl_opt_generic</em> table:  opt_id = #opt_id#; generic_id = #gmax#
	
	</cfif>
</cfif>

</ol>
</cfoutput>



<table cellpadding="3" cellspacing="3" border="0">
<form method="post" action="rx.cfm">
<tr>
	<td align="right"><b>Brand-name:</b></td>
	<td align="left"><input type="text" name="bname" size="30" value="" /></td>
</tr>
<tr>
	<td align="right"><b>Generic:</b></td>
	<td align="left"><input type="text" name="gname" size="30" value="" /></td>
</tr>
<tr>
	<td align="right">&nbsp;</td>
	<td align="left"><input type="submit" value="Submit" /></td>
</tr>
</form>
</table>
