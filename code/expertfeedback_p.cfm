<cfparam name="form.like" default="" type="string">
<cfparam name="form.suggestions" default="" type="string">
<cfparam name="form.comments" default="" type="string">
<cfif #form.suggestions# is not "" OR #form.like# is not "" OR #form.comments# is not "">
<CFQUERY datasource="rxwizardexpfdbk" NAME="add">

INSERT INTO pagefeedback (
   `like`, suggestions, comments
	)
VALUES (
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.like#" maxlength="200" >,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suggestions#" maxlength="200" >,    
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comments#" maxlength="200" >
	)
</CFQUERY>
</cfif>

<HTML>
<HEAD><TITLE>Confirmation of Medication Selection Page Feedback</title></head>
<BODY>
<FONT FACE="arial">
<b>Thank you for your feedback.</b> 
<BR><BR>
Please click the button below to return back to the Medication Selection Page to complete your <cf_tagBCU> questionnaire. You must click on the "Submit Questionnaire" in order to process your results on the Medication Selection.</font>

<font face="arial" size="3"> 
<form action="JavaScript:self.close();">
<b><input type="Submit" value="Return to the Medication Selection Page" onClick="javascript:if (opener) if (!opener.closed) opener.focus(); self.close()"></b>
</form>
</font>

</body>
</html>
