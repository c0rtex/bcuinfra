<!---====================================================================
   Description: This form Inserts, Updates and Deletes from tbl_contacts and takes you back to
   						 contact_srch.cfm page. 
   Called By: Contact_add.cfm and Contact_srch2.cfm
      Goes To: Contact_srch.cfm   
       =====================================================================  --->
<!--- Begin Delete  --->
<!--- End Delete  --->

<!--- Begin Update  --->
<CFIF #isdefined("Update")#>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="Update">
		UPDATE tbl_contacts
			SET firstname='#form.firstname#',
				lastname='#form.lastname#',
				phone='#form.phone#',
				fax='#form.fax#',
				phone2='#form.phone2#',
				email='#form.email#',
				notes='#form.notes#',
				org='#form.org#',
				title='#form.title#',
				address='#form.address#',
				address2='#form.address2#',
				city='#form.city#',
				state='#form.state#',
				zip='#form.zip#',
				web_site='#form.website#',
				category='#form.category#'
			WHERE contact_id=#contact_id#
	</CFQUERY>
	<CFLOCATION URL="contact_Srch2.cfm?contact_id=#contact_id#">
</CFIF>
<!--- End Update --->

<!--- Begin Insert  --->
<CFIF #isdefined("Add")#>
	<CFINSERT DATASOURCE="#application.dbSrc#"
		TABLENAME="tbl_contacts"
		FORMFIELDS="firstname,lastname">
	
	<CFQUERY DATASOURCE=#application.dbSrc# NAME="qryID">
			SELECT max(contact_id) as updateID
			FROM tbl_contacts
	</CFQUERY>
	<CFOUTPUT query="qryID">
	<CFLOCATION URL="contact_srch2.cfm?contact_id=#updateID#">
	</CFOUTPUT>
</CFIF>
<!--- End Insert  --->

<cfmodule template="../footer.cfm">

