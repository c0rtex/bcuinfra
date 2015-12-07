<!--- variables used
feedbackform = name of form
process = action
compliment = subject matter is complimentary
criticism = "sm" is a criticism
ebug = sm is either an error or a bug notice
gb = sm is a general comment
request = sm is a request
suggest = sm is a suggestion
other = sm is other
name = the user's name
email = their email address
comments = what they have to say
--->
<head><title>BenefitsCheckUp FEEDBACK FORM</title></head>


<body bgcolor="#FFFFFF" link="#00594B" alink="#00594B" vlink="purple" onload="window.focus();"><font face="arial" size="4">
<H3><cf_tagBCU> FEEDBACK</H3>

We appreciate your feedback.  Please complete the brief form below to help us enhance the experience of our visitors.  While we cannot reply to every individual response, we will use your feedback to improve future versions of <cf_tagBCU>.
<HR>

<FORM ACTION="procfeedback.cfm" Method="POST">
<CFOUTPUT>
<INPUT TYPE="Hidden" NAME="TimeStamp" VALUE="#Now()#"></CFOUTPUT>

<FONT FACE="arial">
<TABLE WIDTH=400 BORDER=0><TR>
<TD COLSPAN=5 VALIGN="top">
<B><FONT FACE="arial">Subject Matter:</FONT></b>
</td></TR>
<TD WIDTH=45% VALIGN="top">
<INPUT TYPE="checkbox" NAME="sm" VALUE="compliment"> 
<FONT FACE="arial">Compliment</FONT>
</td>
<TD WIDTH=10%>&nbsp;</td>
<TD WIDTH=45% VALIGN="top">
<INPUT TYPE="checkbox" NAME="sm" VALUE="request">
<FONT FACE="arial">Request</FONT></td></tr>

<TR>
<TD WIDTH=45% VALIGN=top>
<INPUT TYPE="checkbox" NAME="sm" VALUE="criticism"> <FONT FACE="arial">Criticism</font></td>
<TD WIDTH=10%>&nbsp;</td>
<TD WIDTH=45% VALIGN=top>
<INPUT TYPE="checkbox" NAME="sm" VALUE="bug"> <FONT FACE="arial">Error/Bug</font></td></tr>
<TR>
<TD WIDTH="45%" VALIGN=top>
<INPUT TYPE="checkbox" NAME="sm" VALUE="suggest"> <FONT FACE="arial">Suggestion</font></td>
<TD WIDTH=10%>&nbsp;</td>
<TD WIDTH="45%">
<FONT FACE="arial">Other:</font></TD>
</tr>
<TR>
<TD WIDTH=45% VALIGN="top">
<INPUT TYPE="checkbox" name="sm" VALUE="gc"> <FONT FACE="arial">General Comment</font></td>
<TD WIDTH=10%>&nbsp;</td>
<TD WIDTH="45%"><INPUT TYPE="text" name="other"></td></tr>
</table>
<HR SIZE=1 ALIGN=left WIDTH=67%>
<TABLE WIDTH=300><TR>
<TD WIDTH=10% VALIGN=top>
<FONT FACE="arial"><b>Name:</b></FONT></td>
<TD WIDTH=90%><INPUT TYPE="text" name="name"></td></tr>
<TD WIDTH="10% VALIGN="top">
<FONT FACE="arial"><b>Email:</b></font></td>
<TD WIDTH=90 VALIGN=top>
<INPUT TYPE=text name="email"></td>
</TR></TABLE>
<HR SIZE=1 ALIGN=left WIDTH=67%>
<FONT FACE="arial"><B>Please enter your comments below.</b></font><BR>
<font face="arial"><textarea name="comments" rows="5" cols="33" WRAP="VIRTUAL"></textarea></font>
<BR><BR>
<font face="Arial" size="3"><b><INPUT TYPE="submit" value="Submit"></b></font> &nbsp;

</FORM>
<cf_tagClose>


</font>


