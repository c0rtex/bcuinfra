<!---== ================================================================
 Begin : Mir This form Inserts, Updates and Deletes date from tbl_notes and 
          takes the user to search screen -- Note_search.cfm 
		  CALLED By:Update_notes1.cfm
		  GOES TO:Note_search.cfm		  
      ==================================================================--->

<CFIF IsDefined("FORM.add")>
	<CFINSERT DATASOURCE="#application.dbSrc#" TABLENAME="tbl_notes" FORMFIELDS="added_dt,added_by,note,st">
	<CFLOCATION URL="note_display.cfm"> 
</CFIF>

<CFIF #isdefined("Update")#>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="Update">		
    Update tbl_Notes
	set   note='#form.note#'
	       		     where recID='#recID#'
</CFQUERY> 
 <CFLOCATION URL="note_display.cfm?id=#recID#">
</CFIF>
<!--- End Update --->

<cfmodule template="../footer.cfm">