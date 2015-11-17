<cfmodule template="../header.cfm">
<!-- Entry point info. shows up in lower left corner of program info screen-->

<!-- Check if editing. if so make update-->
<CFIF isdefined("edit")>
	<CFQUERY DATASOURCE="#application.dbSrc#">
		UPDATE tbl_entry
		SET 
            org_name='#org_name#', org_name2='#org_name2#', address='#address#',
            address1='#address1#', address2='#address2#', city='#city#', zip='#zip#', 
            st='#st#', phone_no='#phone_no#', fax='#fax#', email='#email#', web_site='#web_site#',
            counties_served='#counties_served#', cities_served='#cities_served#',
            zips_served='#zips_served#', hours='#hours#'
		WHERE org_id=<CFIF isdefined("org_id")>'#org_id#'<cfelse>'#cfgridkey#'</CFIF>
            AND group_id=#group_id#
	</CFQUERY>

	<!---CFQUERY DATASOURCE="datasrc">
		UPDATE tbl_phone_lookup
		SET phone_no='#phone_no#',a_area='#a_area#',a_number='#a_number#',a_note='#a_note#',
			b_area='#b_area#',b_number='#b_number#',b_note='#b_note#',
			c_area='#c_area#',c_number='#c_number#',c_note='#c_note#',
			f_area='#f_area#',f_number='#f_number#',additional='#additional#'
		WHERE org_id = #org_id#
	</CFQUERY--->

	<CFIF IsDefined("group_id")>
		<CFLOCATION URL="entry_group.cfm?datasrc=#application.dbSrc#&user=#session.user#&st=#srch_st#&group_id=#group_id#">
	<CFELSE>
		<SCRIPT LANGUAGE="javascript">{history.go(-2);}</SCRIPT>
	</CFIF>
<CFELSE>

	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="grp">
		SELECT group_name,group_id
		FROM tbl_entry_grp
		WHERE group_id in (SELECT group_id
							FROM tbl_prg_entry
							WHERE prg_id ='#prg_id#')
	</CFQUERY>
	
	
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="org">
		SELECT org_name,address,address1,city,zip,st,phone_no,fax,web_site,org_id,mod_dt
		FROM tbl_entry
		WHERE org_id IN (SELECT org_id
						FROM tbl_prg_entry
						WHERE prg_id ='#prg_id#')
	</CFQUERY>
	
	<HTML>
	<HEAD>
		<TITLE>Org</TITLE>
	</HEAD>
	<FORM METHOD="post">
	<BODY BGCOLOR="#FFF7EE">
	<CFSET st = gettoken("#prg_id#",4,"-")>
	<CFIF IsDefined("dontshow") IS "no"><!-- if running from report, don't show links -->
		<CFOUTPUT>
			<A HREF="entry_prg.cfm?prg_id=#prg_id#&user=#session.user#&datasrc=#application.dbSrc#&level=#session.user_level#">Add</A> |
			<A HREF="del_entry.cfm?prg_id=#prg_id#&user=#session.user#&datasrc=#application.dbSrc#&level=#session.user_level#">Delete</A>
		</CFOUTPUT>
	</CFIF>
	<BR>This program is associated with this group(s) of entry points. Click the group name to see the individual entry points.
	<BR><BR>
	<CFOUTPUT QUERY="grp">
		<A HREF="entry_group.cfm?user=#session.user#&prg_id=#prg_id#&group_id=#group_id#&datasrc=#application.dbSrc#&st=#st#&level=#session.user_level#">#Group_name#</A>
	<BR>
	</CFOUTPUT>
	<BR>This program may also have individual entry points associated with it. If so, they are listed below.
	<BR><BR>
	<CFOUTPUT query="org">
	<table border="1" WIDTH="100%">
		<TR>
				<TD COLSPAN="5" WIDTH="1%"><B><A HREF="edit_spons.cfm?org_id=#org_id#&user=#session.user#&prg_id=#prg_id#&datasrc=#application.dbSrc#&level=#session.user_level#&st=#st#">#org_name#</A></B></TD>
				<TD><font size="-1">#DateFormat(mod_dt,"MM/DD/YY")#</font></TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Address</B></TD>
				<TD COLSPAN="5">#address#</TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Address2</B></TD>
				<TD COLSPAN="5">#address1#</TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>City</B></TD>
				<TD>#city#</TD>
				<TD><B>State</B></TD>
				<TD>#st#</TD>
				<TD><B>Zip</B></TD>
				<TD>#zip#</TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Phone</B></TD>
				<TD COLSPAN="5" WIDTH="1%">#phone_no#</TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Fax</B></TD>
				<TD COLSPAN="5" WIDTH="1%">#fax#</TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Web  Site</B></TD>
				<TD COLSPAN="5"><A HREF="http:\\#web_site#">#web_site#</A></TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Counties Served</B></TD>
				<TD COLSPAN="5">#counties_served#</TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Cities Served</B></TD>
				<TD COLSPAN="5">#cities_served#</TD>
			</TR>
			<TR BGCOLOR="WHITE">
				<TD><B>Zips Served</B></TD>
				<TD COLSPAN="5">#zips_served#</TD>
			</TR>
	</TABLE>
	<!---font size="-1"><A HREF="entry_details.cfm?org_id=#org_id#&prg_id=#prg_id#&user=#session.user#&datasrc=#application.dbSrc#&level=#session.user_level#" target="btm_rt">Details</A></font--->
	<BR><BR>
	</CFOUTPUT>
	</FORM>
</CFIF>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">