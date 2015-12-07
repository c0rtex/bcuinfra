<!--- pop up wait screen --->
<!---- AZ added by BS 2004-07-26 --->
<cfif st is "AZ">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adAZRecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>

<cfelseif st is "CO">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adCORecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>

<!---- MD added by DD 020227 --->
<CFELSEIF st is "MD">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adMDRecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>
	
<CFELSEIF st is "WA">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adWARecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>
	
<!---- Cuyahoga County removed by BS 2004-07-26 --->
<CFELSEIF st is "OH">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adOHRecognize.cfm','Advertise',"resizable=no,width=475,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>
   
   <!---- PA added by DD 021127 --->	
<CFELSEIF st is "PA">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adPaRecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>

<!---- TX added by DD 021127 --->	   
<CFELSEIF st is "TX">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adTxRecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>

   
<CFELSEIF st is "IL">
	<cfif session.City EQ "Chicago">
		<SCRIPT LANGUAGE="JavaScript">
			{
			 var waitwindow =window.open('adILRecognize2.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
			}
		</SCRIPT>	
	<cfelseif session.City EQ "NotChi">
		<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adILRecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
		</SCRIPT>
      <!--- 02/12/2002 REM  NEED A BLANK CASE HERE --->
	</cfif>
   
<cfelseif st IS "RI">
	<SCRIPT LANGUAGE="JavaScript">
		{
		 var waitwindow =window.open('adRIRecognize.cfm','Advertise',"resizable=no,width=450,height=400,top=150,screenY=150,left=150,screenX=150");
		}
	</SCRIPT>
</cfif>