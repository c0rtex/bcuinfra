<!--- pop up screen that tells user to wait. Shows up while eligibility3.cfm is processing, goes away when programs.cfm comes up ---->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Please Wait...Processing Results</TITLE>
</HEAD>
<SCRIPT LANGUAGE = "JavaScript">
<!--
var secs
var timerID = null
var timerRunning = false
var delay = 1000

function InitializeTimer()
{
    // Set the length of the timer, in seconds
    secs = 25                         
    StopTheClock()
    StartTheTimer()
}

function StopTheClock()
{
    if(timerRunning)
        clearTimeout(timerID)
    timerRunning = false
}

function StartTheTimer()
{
    if (secs==0)
    {
        StopTheClock()
        // Here's where you put something useful that's
        // supposed to happen after the allotted time.
        // For example, you could display a message:
        window.close();
    }
    else
    {
        self.status = secs
        secs = secs - 1
        timerRunning = true
        timerID = self.setTimeout("StartTheTimer()", delay)
    }
}
//-->
</SCRIPT>

<BODY onload="InitializeTimer()" onBlur="window.close();" onmousedown="window.close();" >
	&nbsp;<BR><CENTER><FONT FACE="Arial, Helvetica" SIZE="5"><B>Please Wait...<BR></B></FONT>
	<P><IMG HEIGHT=53 WIDTH=354 SRC="images/chk_sub_proc.gif" ALT="Please Be Patient!" BORDER=0></center>
	<P><FONT FACE="Arial, Helvetica" SIZE="2">

<cfoutput>
<br>
<B><CENTER><FONT FACE="Arial, Helvetica" SIZE="3">Your printable report is being created.
When this process is completed, you will receive instructions on how to view and print your report. 
</B></FONT></center>
</BODY>
</HTML>
</cfoutput>



