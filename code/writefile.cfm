<!--- 02/24/2002 REM  We use this var to hold the report text--it's finally flushed out to a 
cfm file and converted to a pdf at the end. --->
<cfset strOutData="">

<!--- 08/12/2002 Bill Shunn --->
<!--- Here, for reasons of Beta's self-preservation, we delete every entry older than one hour from tbl_user_zips --->
<!--- 01/29/2003 Bill Shunn | Removed tbl_user_zips delete code because tbl_user_zips is removed --->

<!--- 02/24/2002 REM  Here we insert the INTRO --->
<!--- 02/24/2002 REM  This custom tag just passes whatever text is output between the start and 
end into strOutData.  It could be made more flexible by passing the string name as an attribute
if needed. --->
<cf_tagPassText>
<HTML>
<HEAD>
<TITLE>Your BenefitsCheckUp Report</TITLE>
</HEAD>
<BODY>
<H1><font face="Arial">Introduction</font></h1>

<hr size=6>
<br><font face="Arial">
<cf_tagBCU> has prepared the following report identifying public and private benefits programs for you to consider.  Many of these programs provide financial, health, pharmaceutical, informational, and supportive services.  For your convenience, this report includes program details such as: program descriptions, local contact information where questions can be answered and/or applications can be completed, and a listing of necessary documentation to aid in the application process.</font>
<br><br><br>
<p><b><font face="Arial">It is important to note that final program eligibility determination can only be made by the agencies administering the program(s). We encourage you to contact the agencies with any questions you may have.</b></font></p>

<cfif IsDefined('session.org_id') and session.org_id gt 0>
	<cfquery name="localinfo" datasource="#application.dbSrcOE#">
		select o.site_name Pro_Name, '' Pro_LocalInfo, r.intro Pro_CSOInfo
		from ORGANIZATION o, REPORT r
		where o.id=#session.org_id#
			and o.id=r.org_id
	</cfquery>
	<cfset localProfileName = localinfo.Pro_Name>
	<cfif localinfo.Pro_LocalInfo neq "" or localinfo.Pro_CSOInfo neq "">
		<cfoutput>
		<font face="arial">
			&nbsp;<br><font size="+2">#localinfo.Pro_Name#</font><br><br>
			<cfif localinfo.Pro_CSOInfo neq "">
				#localinfo.Pro_CSOInfo#<br><br>
			</cfif>
			<cfif localinfo.Pro_LocalInfo neq "">
				#localinfo.Pro_LocalInfo#<br><br>
			</cfif>
		</font>
		</cfoutput>
	</cfif>
</cfif>

<!-- half page  -->
</cf_tagPassText>

<!--- 02/24/2002 REM  Here we insert the NORMAL PROGRAM DETAIL --->
<cfset lstProgNormal=(#session.prg_list#)>

<!--- 03/09/2002 REM  Two problems--lstProgNormal doesn't store the programs in the sort order
they have in the db, and it doesn't have the program-to-major-category associations (or cat
names).  To fix this, we have to run a query that JOINs tbl_prg_all and tbl_ --->
<cfquery name="qryGetProgSortOrderAndCatName" datasource="#application.dbSrc#">
SELECT     p.prg_id, c.major_cat
FROM       tbl_prg_all p 
   INNER JOIN
           tbl_major_cat_list c 
   ON p.Cat_ID = c.id_number
WHERE p.prg_id IN (#preserveSingleQuotes(lstProgNormal)#)
ORDER BY p.order_num
</cfquery>

<cfset intPrgNum=0>

<cf_tagPassText>
   <h1><font face="Arial">Programs</font></h1>
   <cfset queryloopcount = 0>
   <cfloop query="qryGetProgSortOrderAndCatName">
      <cfset intPrgNum = intPrgNum + 1>
      <cf_displayProgramDetails prg_id="#prg_id#" mode="print" number="#intPrgNum#">
	 <cfset queryloopcount = queryloopcount + 1>
	 <!--- <cfif queryloopcount eq 2>
		  <cfabort>
		</cfif> --->
   </cfloop>
</cf_tagPassText>

<!--- 02/24/2002 REM  Here we insert the BUFFER PROGRAM DETAIL --->
<!--- output buffer message --->
<cfif #session.buff_list# neq ''>

   <cfset lstProgBuffer=(#session.buff_list#)>
   <!--- 03/09/2002 REM  Have to repeat the process we use above on Normal Progs for the
   buffer progs: --->
   <cfquery name="qryGetBuffSortOrderAndCatName" datasource="#application.dbSrc#">
   SELECT     p.prg_id, c.major_cat
   FROM       tbl_prg_all p 
      INNER JOIN
              tbl_major_cat_list c 
      ON p.Cat_ID = c.id_number
   WHERE p.prg_id IN (#preserveSingleQuotes(lstProgBuffer)#)
   ORDER BY p.order_num
   </cfquery>

   <cf_tagPassText>
      <h1>Other Programs to Consider</h1>
      <p><font face="Arial">There is some chance that you may be eligible for these additional programs, although your income and assets appear to be too high. If these programs could be helpful to you, you may want to apply so that a formal determination can be made.</font></p>
   
      <cfloop query="qryGetBuffSortOrderAndCatName">
         <cfset intPrgNum = intPrgNum + 1>
	      <cf_displayProgramDetails prg_id="#prg_id#" mode="print" number="#intPrgNum#">
      </cfloop>
   </cf_tagPassText>

</cfif>

<!--- 02/24/2002 REM  Almost forgot the CHIPs stuff --->
<!--- Output chips stuff --->
<cfif session.wantchips is "y">
   <cf_tagPassText>
      <h1>State Children's Health Insurance Program</h1>
      <cfset intPrgNum = intPrgNum + 1>
      <cf_displayProgramDetails prg_id="103-309-2191-FD-FD" mode="print" number="#intPrgNum#">
   </cf_tagPassText>
</cfif>

<!--- 02/24/2002 REM  Next we insert the TAGDISCLAIMER data here --->
<!--- MH: Bug 5476 Comment 6: Remove Additional Information and subsequent paragraph for subset_id 62 --->
<cfif session.subset_id neq 62>
<cf_tagPassText>
   <h1><font face="Arial">Additional Information</font></h1>
   <cf_tagYEDisclaimer report="yes">
</cf_tagPassText>
</cfif>

<!--- 3/27/2002 Bill --->
<cfif IsDefined('session.org_id') and session.org_id gt 0>
	<cfquery name="proginfo" datasource="#application.dbSrcOE#">
		SELECT lp.name Prg_Name, lp.description Prg_Desc
		FROM LOCAL_PROGRAM lp, PRIORITY p
		WHERE lp.org_id = #session.org_id#
			AND lp.priority_id = p.id
		ORDER BY p.sort_order, lp.name
	</cfquery>
	<cfif proginfo.RecordCount gt 0>
		<cf_tagPassText>
		<font face="Arial">
		<cfoutput><h1>Other Programs Available from<br>#localProfileName#</h1></cfoutput>
		<hr size=6><br>
		<cfoutput query="proginfo">
			<cfset prgDescFormatted = proginfo.Prg_Desc>
			<cfset prgDescFormatted = Replace(prgDescFormatted, '
', '<br>', 'ALL')>
			<font size="+1"><b>#proginfo.Prg_Name#</b></font><br>
			#prgDescFormatted#<br><br>
		</cfoutput>
		</font>
		</cf_tagPassText>
	</cfif>
</cfif>

<cfif session.st eq 'OH' and session.county eq 'CUYAHOGA'>
	<cf_tagPassText>
		<h1><font face="Arial">Services Offered in Suburban Cuyahoga County</font></h1>
		<CENTER>
		<cfinclude template="CCSSPM-pdf.html">
				<!---  <cfinclude TEMPLATE="CSMDetails.html"> attempting to insert the Cuyahgoa Matrix in the PDF here - didn't work --->
				<!--- removed by DD in an attempt to add the Cuyahoga Matrix <center><IMG SRC="../images/CCSSP525.GIF" WIDTH="525" alt=""></center> --->
	</cf_tagPassText>
</cfif>

<!--- 02/24/2002 REM  Finally, we strip the unneeded HREF strings here--they're gone from the
cfm pages, but there are still a couple in the program descriptions.  --->
<cfset strOutData=REReplace(strOutData, "<(a href|A HREF)=[^>]*>", "" , "ALL")>

<cfif session.st eq "IL" and session.county eq "COOK" and session.org_id gt 0>
	<cfsilent>
		<cf_tagPDFCover localversion="cookcountyil">
	</cfsilent>
<cfelse>
	<cfsilent>
		<cf_tagPDFCover>
	</cfsilent>
</cfif>

<cffile action="WRITE" file="#session.strPDFPath##session.CFToken#-#session.cfid#.html" output="#pdfcoverstr#">
<cffile action="WRITE" file="#session.strPDFPath##session.CFToken#-#session.cfid#.cfm" output="#strOutData#">

<CFEXECUTE NAME="#session.strBatchPath#MakePDF.bat" timeout="30" arguments="#session.CFToken#-#session.cfid#">
</CFEXECUTE>

<cflocation url="frmframebottomfirst.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" >
