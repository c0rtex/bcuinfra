<!----=======================================
DESCRIPTION: shows any help information...pulled into seperate window by javascript of the caller
CALLED BY: TagPIheader
GOES TO: N/A
REQUIRED: type, keyword
	var type = NavTip, ....description to define which query to use
	var Keyword = which record to pull in any of the queries
============================================---->
<!--- Output type as title --->
<cfparam name="type" default="NavTip">
<cfparam name="Keyword" default="Tips">
<HTML>
<HEAD>
<TITLE><CFOUTPUT>#type#</CFOUTPUT></TITLE>
</HEAD>
<!--- Javascript to close window --->
<BODY ONBLUR="window.close();" BGCOLOR="89E0E7">

<FORM>



<cfif keyword is "Tips">

	<TABLE>
			<TR>
				<TD>
			
					<FONT FACE="arial" COLOR="Black"><B>Navigation Tips</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">This section provides useful information to guide you through You're Entitled.
					<BR><BR></FONT>
			
				</TD>
			</TR>
      
	  		
			<TR>
				<TD>
			
					<FONT FACE="arial" COLOR="Black"><B>Back/Forward Buttons</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">The "Back/Forward" browser buttons may be used to review answers. However, if the "back" browser button is used and answers are changed, a pop up box will be provided alerting the user that previous answers may have to be re-entered. 
					<BR><BR></FONT>
			
				</TD>
			</TR>
			<TR>
				<TD>
			
					<FONT FACE="arial" COLOR="Black"><B>Answers Review</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">You will be able to review selected answers on the Recap window available at the end of the application.
					<BR><BR></FONT>
			
				</TD>
			</TR>
				<tr><TD>
			
					<FONT FACE="arial" COLOR="Black"><B>Session Time Limits</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">Please note that there is a built in time limit where the maximum time allowed per question is 20 minutes. If you exceed the time allowed, you may be asked to restart the questionnaire. <BR><BR></FONT>
			
				</TD>
			</TR>
	  		<TR>
				<TD>
			
					<FONT FACE="arial" COLOR="Black"><B>Browsers</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">For more accurate results, make sure that multiple browser windows are not opened at any one time.
													

					<BR><BR></FONT>
			
				</TD>
			</TR>
	







<cfelseif keyword is "Browsers">

		<TABLE>
		
      
	  		<TR>
				<TD>
			
					<FONT FACE="arial" COLOR="Black"><B>Browsers</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">For more accurate results, make sure that multiple browser windows are not open at any one time.
													

					<BR><BR></FONT>
			
				</TD>
			</TR>
			
			
<cfelseif keyword is "Buttons">

		<TABLE>
		
      
	  		<TR>
				<TD>			
					<FONT FACE="arial" COLOR="Black"><B>Back/Forward Buttons</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">The "back/forward" browser buttons may be used to review answers. However, if the "back" browser button is used and answers are changed, a pop up box will be provided alerting the user that previous answers may have to be re-entered. 
					<BR><BR></FONT>
			
				</TD>
			</TR>
			
			
	<cfelseif keyword is "Review">

		<TABLE>
		
      
	  		<TR>
				<TD>		
					<FONT FACE="arial" COLOR="Black"><B>Answers Review</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">You will be able to review selected answers on the Recap window available at the end of the application.
					<BR><BR></FONT>
			
				</TD>
			</TR>
<cfelseif keyword is "Privacy">

		<TABLE>
		
      
	  		<TR>
				<TD>		
					<FONT FACE="arial" COLOR="Black"><B>Privacy Policy</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD> Privacy Policy statement to follow.
					<!---FONT FACE="arial" COLOR="Black"><cfinclude template="PrivacyPolicy.cfm" --->
					<BR><BR></FONT>
			
				</TD>
			</TR>			
			
<cfelseif keyword is "Time">

		<TABLE>
		
      
	  		<TR>
				<TD>		
					<FONT FACE="arial" COLOR="Black"><B>Session Time Limits</B><BR></FONT>
				</TD>
			</TR>
			<TR>
				<TD>
					<FONT FACE="arial" COLOR="Black">Please note that there is a built in time limit where the maximum time allowed per question is 20 minutes. If you exceed the time allowed, you may be asked to restart the questionnaire. <BR><BR></FONT>
			
				</TD>
			</TR>
</cfif>  
			<TR>
		<TD ALIGN="center">
			<INPUT TYPE="button" VALUE="Close" ONCLICK="window.close();">
		</TD>
	</TR>
</TABLE>



</FORM>
</BODY>
</HTML>
