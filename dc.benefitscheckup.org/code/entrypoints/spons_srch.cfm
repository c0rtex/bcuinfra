<script language="JavaScript">
<!-- Force all the previous frames off
if (self.parent.frames.length != 0) self.parent.location=document.location.href;
// -->
</script>
<cfmodule template="../header.cfm">

<!--search FORM for sponsoring agencies-->

<HTML>
<HEAD>
	<TITLE>Org Search</TITLE>
</HEAD>

<BODY>
<FORM action="spons_srch2.cfm" method="post">
	Enter words to search for: 
	<INPUT TYPE="text" NAME="group_name" size="50">
	<br>
	St <CF_tagState all="no"><br>
	<INPUT TYPE="submit" NAME="search" VALUE="Search">
	<CFIF IsDefined("delete")>
	<INPUT TYPE="hidden" NAME="delete">
	</CFIF>
</FORM>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">