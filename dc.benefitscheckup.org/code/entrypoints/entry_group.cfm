<cfmodule template="../header.cfm">
<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: shows grid for entry points. if user clicks on entry point, goes to edit screen
CALLED BY: 
GOES TO: add_entry.cfm,edit_spons.cfm
=====================================================--->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry">  <!--- Changed By chaim 1/3/00 --->
	SELECT org_id, org_name, org_name2, address, address1, address2, city, st, zip, 
		counties_served, cities_served, zips_served, phone_no, fax, email, web_site, hours
	FROM tbl_entry
	WHERE group_id = #group_id# AND (st = '#st#' OR st = '#left(st,2)#')
	ORDER BY org_name, city
</CFQUERY>

<CFFORM NAME="entrypoints" ACTION="add_entry.cfm">
	 <!--- Changed By chaim 1/3/00 --->
	<CFGRID QUERY="entry" HEIGHT="80%" WIDTH="100%" NAME="ep" BGCOLOR="white" SELECTMODE="row" DELETE="yes" INSERT="yes">

		<CFGRIDCOLUMN NAME="org_id" DISPLAY="no">
		<CFIF IsDefined("delete") IS "no">
			<CFGRIDCOLUMN NAME="org_name" HEADER="Name" WIDTH="100" HREFKEY="org_id" HREF="edit_spons.cfm?datasrc=#application.dbSrc#&user=#session.user#&re=yes&st=#st#&group_id=#group_id#" TARGET="main">
		<CFELSE>
			<CFGRIDCOLUMN NAME="org_name" HEADER="Name" WIDTH="100" hrefkey="org_id" target="main">
		</CFIF>
		<CFGRIDCOLUMN NAME="org_name2" HEADER="Name 2" WIDTH="50">
		<CFGRIDCOLUMN NAME="address" HEADER="Address" WIDTH="150">
		<CFGRIDCOLUMN NAME="address1" HEADER="Address 1" WIDTH="75"> <!--- Changed By chaim 1/3/00 --->
		<CFGRIDCOLUMN NAME="address2" HEADER="Address 2" WIDTH="75"> <!--- Changed By chaim 1/3/00 --->
		<CFGRIDCOLUMN NAME="city" HEADER="City" WIDTH="75">
		<CFGRIDCOLUMN NAME="st" HEADER="State">
		<CFGRIDCOLUMN NAME="zip" HEADER="Zip" WIDTH="50">
		<CFGRIDCOLUMN NAME="counties_served" HEADER="Counties Served" WIDTH="75">
		<CFGRIDCOLUMN NAME="cities_served" HEADER="Cities Served" WIDTH="75">
		<CFGRIDCOLUMN NAME="zips_served" HEADER="Zips Served" WIDTH="75">
		<CFGRIDCOLUMN NAME="phone_no" HEADER="Phone No" WIDTH="80">
		<CFGRIDCOLUMN NAME="fax" HEADER="fax" WIDTH="80">
		<CFGRIDCOLUMN NAME="hours" HEADER="Hours" WIDTH="50"> <!--- Changed By chaim 1/3/00 --->
		<CFGRIDCOLUMN NAME="email" HEADER="E-Mail" WIDTH="100">
		<CFGRIDCOLUMN NAME="web_site" HEADER="Web Site">
	</CFGRID>

</CFFORM>
<cfmodule template="../footer.cfm">