<!--- ================================================
AUTHOR: JLuhmann
DESCRIPTION: gathers search information to search notes
CALLED BY: 
GOES TO: note_search2.cfm
=====================================================--->
	       <!---  Begin This page is a search screen it is submitted to 
	note_search2.cfm  after every Insert, Update and Delete the user is brought 
		   back to this page from update_notes1.cfm    --->

<cfmodule template="../header.cfm">

<body bgcolor="white" ALINK="BLUE" VLINK="BLUE" LINK="BLUE">
<font FACE="ARIAL">
<FORM ACTION="note_display.cfm" METHOD="post">
<b><P>Enter any words to search for:</P>
	<table border="0" width="100%" BGCOLOR="silver">
		<tr BGCOLOR="silver">
		<TD width="10%"><b>Key Word:</TD>
		<TD><INPUT TYPE="text" NAME="key_wrd"></TD>
	</TR>
	<TR>
		<TD<b>State:</TD>
		<TD><CF_tagState></TD>
	</TR></b>
</TABLE>
<BR>
<P>
<INPUT TYPE="submit" NAME="search" VALUE="Search">
</P>
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">