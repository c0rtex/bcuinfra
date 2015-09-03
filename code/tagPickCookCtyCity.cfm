<!--- 02/16/2002 REM  Note that the 'question' formname is hard-coded below--if the form name
on frmQuestions.cfm changes, this will have to be adjusted. --->
<script language="JavaScript">
function setCity(form) {
   if (form.City.options[form.City.selectedIndex].value=='Chicago') {
      document.questions.City.value='Chicago';
      document.questions.OtherCity.value='';
   } else {
      document.questions.City.value='NotChi';
      document.questions.OtherCity.value=form.OtherCity.value;
   }
}
</script>
<div style="background-color: Silver; font-size: small; border: thin solid Black; padding: 0em 0em 0em .2em; width: 32em;">
<table cellpadding="2"><tr><td>
<font face="Arial" size="2">
<p>Because your zip code is on the border between Chicago and suburban Cook County, we need you to identify which city you live in.</p>  
<p>Please select your city from the list. If it does not appear on the list, please choose Other and enter it in the text box below. </p>
<form name="frmSetCity" action="">
   <select name="City">
      <option value="NotChi">&nbsp;</option>
      <cfoutput query="qryGetCookCtyZips">
      <option 
      value="#IIF(PostalCity EQ 'Chicago',DE('Chicago'),DE('NotChi'))#">#PostalCity#</option>
      </cfoutput>
      <option value="NotChi">OTHER</option>
   </select>
   <p>If Other, enter it here:<br>   
   <input type="Text" name="OtherCity" maxlength="50"></p>
   <input type="Button" name="btnSetCity" value="Set Your City" onClick="setCity(this.form)">
</form>
</font>
</td></tr></table>
</div>
