<CFQUERY name="entry" datasource="#application.dbSrc#">
Select * 
From tbl_entry
where RecId = 5
</cfquery>

<cfform action="proc_phone_no.cfm" method="POST" name="phone_no_update">

<CFOUTPUT query="entry">
#org_name#<BR>
#org_name2#<BR>
#address#<BR>
#address1#<BR>
#address2#<BR>
#city#<BR>
#st#<BR>
#zip#<BR>
#phone_no#<BR>
#fax#<BR>

<input type="hidden" name="org_id" value="#org_id#">
<input type="hidden" name="group_id" value="#group_id#">
<input type="hidden" name="RecId" value="#RecId#">
</cfoutput>




<table cellspacing="0" cellpadding="0" border="1"></td><td>
<tr><td>phone</td><td><cfinput type="Text" name="phone_no" validate="integer" required="Yes" size="10" maxlength="10"></td></tr>
<tr><td>text</td><td><cfinput type="Text" name="phone_no_txt" required="No" size="50" maxlength="50"></td></tr>
<tr><td>phone</td><td><cfinput type="Text" name="phone_no1" validate="integer" required="No" size="10" maxlength="10"></td></tr>
<tr><td>text</td><td><cfinput type="Text" name="phone_no1_txt" required="No" size="50" maxlength="50"></td></tr>
<tr><td>phone</td><td><cfinput type="Text" name="phone_no2" validate="integer" required="No" size="10" maxlength="10"></td></tr>
<tr><td>text</td><td><cfinput type="Text" name="phone_no2_txt" required="No" size="50" maxlength="50"></td></tr>
<tr><td>phone</td><td><cfinput type="Text" name="phone_no3" validate="integer" required="No" size="10" maxlength="10"></td></tr>
<tr><td>text</td><td><cfinput type="Text" name="phone_no3_txt" required="No" size="50" maxlength="50"></td></tr>
<tr><td>fax</td><td><cfinput type="Text" name="fax" validate="integer" required="No" size="10" maxlength="10"></td></tr>
<tr><td>fax</td><td><cfinput type="Text" name="fax2" validate="integer" required="No" size="10" maxlength="10"></td></tr>
</table>

<input type="submit" value="Submit">
</cfform>