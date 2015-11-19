<form>
<font face="Arial" size="3">
<b><input type="button" name="print" value="Print This Page" style="font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 8pt;" onclick="self.print();">
&nbsp; &nbsp;
<input type="button" name="prev" value="Back to <cfif IsDefined('session.RxPrgList') And session.RxPrgList neq ''>Application Guide<cfelse>Results</cfif>" style="font-family: Arial, Helvetica, Verdana, sans-serif; font-size: 8pt;" onclick="history.go(-1);"></b>
</font>
</form>