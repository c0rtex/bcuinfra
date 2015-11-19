<HTML><HEAD>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<cfif attributes.refreshurl neq ''>
<cfoutput><META http-equiv="refresh" content="#attributes.refreshsec#; url=#attributes.refreshurl#"></cfoutput>
</cfif>

<script language="JavaScript" src="ValidationFunctions.js"></script>
<cfset title="">
<cfset AddBanner="">
<cfset BasePath=GetBaseTemplatePath()>
<cfif Find("index.cfm", BasePath) gt 0>
	<cfset title="BenefitsCheckUpRx - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelseif Find("before_you_start.cfm", BasePath) gt 0>
	<cfset title="BenefitsCheckUpRx - NCOA's Online Screening Service">
	<cfset AddBanner = "Yes">
<cfelse>
	<cfset title="BenefitsCheckUpRx From NCOA">
	<cfset AddBanner="No">
</cfif>


<!--- ABCRx Settings --->
	<cfset page_background = 'bgcolor="##FFFFFF"'>
	<cfset text_color = "##00594B">
	<cfset link_color = "##666633">
	<cfset table_color = "##E2E2C6">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##666633">	

<cfoutput>
	<cfset bodyTagMore = ''>
<title>#title#</title>


</head>

<body link="#link_color#" vlink="#link_color#" alink="#link_color#"  bgcolor"##FFFFCC"#onLoadScript#>
<cfif session.access_id neq 1><a href="#accessURL#" title="For browsers utilizing a screen reader, please click here"></a></cfif><a href="##skipnav" title="Skip navigational links"></a>

<!-- set table values -->
	<cfset tablewidth="95%">
	<cfset cellpadding="5">
	<cfset session.cellpadding="12">
	<cfset session.cellspacing="2">
	<cfset session.innercellpadding="2">
	<cfset session.innercellspacing="2">


<!-- abc header -->
<TABLE cellSpacing=0 cellPadding=0 width=690  align=center  bgcolor"##FFFFFF" border=0><TBODY>
  <TR>
    <TD vAlign=top align=left colSpan=5 height=72>
      <TABLE  cellSpacing=0 cellPadding=0  border=0>
        <TBODY>
        <TR vAlign=top align=left>
     
          <TD vAlign=top align=left rowSpan=2><IMG 
            height=64 alt="Access to Benefits Coalition" 
            src="../rxabc/images/abclogo3.gif" 
            ></TD><TD vAlign=top align=left  ><IMG alt="Access to Benefits Coalition"
             src="../rxabc/images/abcslogan2.gif" ></TD>
		
		<cfif session.partner_id eq 6>
		<td width=50>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td align="right" ><img src="webmd/images/closewindow.gif" alt=""></td><td ><a href="javascript:window.close();"><img border=0   src="webmd/images/closebcu.gif" alt=""></a>
			</td>
	     <cfelse>
	     <td width=200></td>
	    </cfif>
          	
         </TR></table>
		 <cfif IsDefined('session.org_id') and session.org_id gt 0>

			<table cellpadding="0" cellspacing="0" align="center" border="0">
			<tr>
				<td align="center" valign="top" colspan="3"><img src="images/pixel.gif" width="1" height="5" border="0" alt=""></td>
			</tr>
			<tr>
				<td align="center" valign="top" colspan="3"><font face="Arial" size="4"><b>#parent_name#</b></font></td>
			</tr>
			<cfif trim(center_logo) eq ''>
			<tr>
				<td align="center" valign="top" colspan="3">#right_logo#</td>
			</tr>
			<cfelseif trim(left_logo) neq ''>
			<tr>
				<td rowspan="2" align="right">#left_logo#</td>
				<td rowspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td align="left" valign="top">#right_logo#</td>
			</tr>
			<cfelse>
			<tr>
				<td rowspan="2" align="right">#center_logo#</td>
				<td align="left" valign="top">#right_logo#</td>
			</tr>
			</cfif>
			</table>
		 
		 <cfelse>
		 <TABLE  cellSpacing=0 cellPadding=0  border=0>
		  <TR vAlign=top align=left>
     	  <td width=160>&nbsp;</td>
          <TD vAlign=top align=left colspan=2><IMG 
             alt="BenefitsCheckUpRx" 
            src="images/head-bcu.gif" 
            ></TD>
          
         </TR>
         </TBODY></TABLE>
		 </cfif>
		 <table align="center"  width="680"  border="0">
			<tr>
			<td align="center"><cfif maintMsg neq ''><img src="images/pixel.gif" width="1" height="5" border="0" alt=""><br><font color="##800000" face="Arial, Helvetica, Verdana" size="-1"><b>#maintMsg#</b></font></cfif><hr color="##999966"></td>
			</tr>
		 </table>
<a name="skipnav"></a>
		 <table><tr><td align="center" width="690">
</cfoutput>