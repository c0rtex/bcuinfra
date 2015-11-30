<!--- pop up wait screen --->
<cfif session.st is 'CO'>
<CFOUTPUT>
<SCRIPT LANGUAGE="JavaScript">
	{
	 var waitwindow =window.open('COadvertise.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
	}
</SCRIPT>

</CFOUTPUT>
<cfelse>
<CFOUTPUT>
<SCRIPT LANGUAGE="JavaScript">
	{
	 var waitwindow =window.open('RIadvertise.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
	}
</SCRIPT>

</CFOUTPUT>

</cfif>