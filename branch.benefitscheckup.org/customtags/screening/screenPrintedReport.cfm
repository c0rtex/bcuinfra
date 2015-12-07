<cfparam name="attributes.pdfname" type="string" default="">
<cfparam name="attributes.randseed" type="numeric" default="9999999">
<cfparam name="attributes.randappend" type="boolean" default="true">
<cfparam name="attributes.fileformat" type="string" default="pdf">
<cfparam name="attributes.coverpage" type="boolean" default="true">
<cfparam name="attributes.toc" type="boolean" default="true">
<cfparam name="attributes.intro" type="boolean" default="true">
<cfparam name="attributes.addedinfo" type="boolean" default="true">
<cfparam name="attributes.ltccinfo" type="boolean" default="true">
<cfparam name="attributes.localprgs" type="boolean" default="true">
<cfparam name="attributes.pgbreaks" type="boolean" default="true">
<cfparam name="attributes.prgdesc" type="boolean" default="true">
<cfparam name="attributes.prgeps" type="boolean" default="true">
<cfparam name="attributes.prgepnum" type="numeric" default="3">
<cfparam name="attributes.prgreqmat" type="boolean" default="true">
<cfparam name="attributes.prglist" type="string" default="all">
<cfparam name="attributes.orderbyprglist" type="boolean" default="false">
<cfparam name="attributes.brandname" type="string" default="BenefitsCheckUp">
<cfparam name="attributes.blankreport" type="boolean" default="false">
<cfparam name="attributes.brandcover" type="string" default="none">
<cfparam name="attributes.partner_id" type="numeric" default="0">
<!---<cftry>--->
<cfif not IsDefined('session.org_id') >
	<cfset session.org_id = 0>
</cfif>
<cfif IsDefined('request.partner_id') and request.partner_id gt 0 >
	<cfset session.partner_id = request.partner_id>
</cfif>
<cfif attributes.pdfname eq "">
	<cfset tempvar = Randomize(attributes.randseed)>
	<cfset attributes.pdfname = "" & RandRange(10, 99) & "-" & RandRange(100000, 999999) & "-" & RandRange(100, 999)>
<cfelseif attributes.randappend>
	<cfset tempvar = Randomize(RandRange(1, 9999999) + attributes.randseed)>
	<cfset tempvar = RandRange(0, 99999999)>
	<cfset session.randomname = "-" & tempvar>
	<cfset attributes.pdfname = attributes.pdfname & session.randomname>
</cfif>

<!--- PDF GENERATION --->

<cfset strOutData="">

<cfif attributes.blankreport>

	<!--- BLANK REPORT --->
	<cfset attributes.fileformat='html'>
	<cfset attributes.coverpage=false>

<cfelse>


<cfset strOutData = strOutData & "<HTML>">
<cfset strOutData = strOutData & "<HEAD>">
<cfif session.subset_id eq 70>
	<cfset strOutData = strOutData & "<TITLE>Your Benefits Report</TITLE>">
<cfelseif session.subset_id eq 49 or session.subset_id eq 62 or session.subset_id eq 68>
	<cfset strOutData = strOutData & "<TITLE>Your Benefits QuickLINK Report</TITLE>">
<cfelse>
	<cfset strOutData = strOutData & "<TITLE>Your #attributes.brandname# Report</TITLE>">
</cfif>
<cfset strOutData = strOutData & "</HEAD>">
<cfif session.subset_id eq 70>
	<cfset strOutData = strOutData & "<BODY><h1>Your Benefits Report">
<cfelseif session.subset_id eq 49 or session.subset_id eq 62 or session.subset_id eq 68>
	<cfset strOutData = strOutData & "<BODY><h1>Your Benefits QuickLINK Report">
<cfelse>
	<cfset strOutData = strOutData & "<BODY><h1>Your #attributes.brandname# Report">
</cfif>
<cfoutput>
	<cfif isDefined('session.unique_id') and session.subset_id eq 69>
    	<cfset strOutData = strOutData & "<BR /> (Unique ID: #session.unique_id#)">
   	</cfif>
</cfoutput>
<cfset strOutData = strOutData & "</h1>">

<cfif session.org_id gt 0>
	<cfquery name="localinfo" datasource="#application.dbSrcOE#">
		select o.site_name Pro_Name, '' Pro_LocalInfo, r.intro Pro_CSOInfo
		from ORGANIZATION o, REPORT r
		where o.id=#session.org_id#
			and o.id=r.org_id
	</cfquery>
	<cfset localProfileName = localinfo.Pro_Name>
</cfif>

<cfif attributes.intro>
<cfset strOutData = strOutData & "
<H2><font face=Arial>Introduction</font></h2>

">
<cfset strOutData = strOutData & "<hr size=6>

">
<cfset strOutData = strOutData & "<br><font face=Arial>">
<cfif IsDefined('session.partner_id') And session.partner_id eq 5>
	<cfset privatePhraseStr = ''>
<cfelse>
	<cfset privatePhraseStr = ' and private'>
</cfif>
<cfif isdefined('session.subset_id') and session.subset_id eq 57>
<cf_displayText group="site" code="site_print_report_intro_subset_#session.subset_id#"  var="vIntroText">
<cfset strOutData = strOutData & vIntroText & "</font>">
<cfelse>
<cf_displayText group="site" code="site_print_report_intro_default"  var="vIntroText">
<cfset strOutData = strOutData & vIntroText & "</font>">
</cfif>
<cfif session.org_id gt 0>
	<cfif localinfo.Pro_LocalInfo neq "" or localinfo.Pro_CSOInfo neq "">
		<cfoutput>
		<cfset strOutData = strOutData & "<font face=arial>">
		<cfset strOutData = strOutData & "&nbsp;<br><font size=+2>#localinfo.Pro_Name#</font><br><br>">
		<cfif localinfo.Pro_CSOInfo neq "">
			<cfset strOutData = strOutData & "#localinfo.Pro_CSOInfo#<br><br>">
		</cfif>
		<cfif localinfo.Pro_LocalInfo neq "">
			<cfset strOutData = strOutData & "#localinfo.Pro_LocalInfo#<br><br>">
		</cfif>
		<cfset strOutData = strOutData & "</font>">
		</cfoutput>
	</cfif>
</cfif>
<cfif attributes.pgbreaks>
	<cfset strOutData = strOutData & "<!-- NEW PAGE -->

">
<cfelse>
	<cfset strOutData = strOutData & "<br><br><br>

">
</cfif>
</cfif>

<cfif attributes.orderbyprglist>
	<cfset lstProgNormal = "'" & ListChangeDelims(attributes.prglist, "','") & "'">
	<cfquery name="shorterQueryName" datasource="#application.dbSrc#">
		select p.prg_id, c.major_cat, ifnull(pp.supersort, 999999999) bigsort
		from tbl_prg_all p, tbl_major_cat_list c, program pp, programcategory pc
		where
		<cfif lstProgNormal neq ''>
			p.prg_id in (#PreserveSingleQuotes(lstProgNormal)#)
		<cfelse>
			p.prg_id='this won''t match a damn thing'
		</cfif>
			and p.Cat_ID=c.id_number
		<cfif not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq ''>
			and c.id_number <> 333
		</cfif>
			and p.RecID=pp.program_id
			and pp.programcategory_id=pc.programcategory_id
		order by bigsort, pc.sort, pp.sort
	</cfquery>
	<cfset queryCat = StructNew()>
	<cfloop query="shorterQueryName">
		<cfset StructInsert(queryCat, prg_id, major_cat)>
	</cfloop>
	<cfset qryGetProgSortOrderAndCatName = QueryNew('prg_id,major_cat')>
	<cfloop list="#lstProgNormal#" index="thisHerePrg">
		<cfset tempPrg = Replace(thisHerePrg, "'", '', 'ALL')>
		<cfset QueryAddRow(qryGetProgSortOrderAndCatName)>
		<cfset QuerySetCell(qryGetProgSortOrderAndCatName, 'prg_id', tempPrg)>
		<cfset QuerySetCell(qryGetProgSortOrderAndCatName, 'major_cat', StructFind(queryCat, tempPrg))>
	</cfloop>
<cfelse>
	<cfset lstProgNormal=(#session.prg_list#)>
	<cfquery name="qryGetProgSortOrderAndCatName" datasource="#application.dbSrc#">
		select q.prg_id, q.major_cat, q.bigsort, q.pcsort, q.ppsort, ifnull(pg.sort, 0) groupsort
		from (
			select p.prg_id, c.major_cat, pp.programgroup_id, ifnull(pp.supersort, 999999999) bigsort, pc.sort pcsort, pp.sort ppsort
			from tbl_prg_all p, tbl_major_cat_list c, program pp, programcategory pc
			where
			<cfif lstProgNormal neq ''>
				p.prg_id in (#PreserveSingleQuotes(lstProgNormal)#)
			<cfelse>
				p.prg_id='this won''t match a damn thing'
			</cfif>
				and p.Cat_ID=c.id_number
			<cfif not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq ''>
				and c.id_number <> 333
			</cfif>
				and p.RecID=pp.program_id
				and pp.programcategory_id=pc.programcategory_id
			) q left outer join programgroup pg
				on q.programgroup_id=pg.programgroup_id
		order by groupsort, q.bigsort, q.pcsort, q.ppsort
	</cfquery>
</cfif>

<cfset prg_num=0>

<cfset strOutData = strOutData & "
<h2><font face=Arial>Programs</font></h2>">

<cfset queryloopcount = 0>
<cfloop query="qryGetProgSortOrderAndCatName">
	<cfif attributes.prglist eq 'all' or ListFindNoCase(attributes.prglist, prg_id) gt 0>
		<cfset prg_num = prg_num + 1>
		<cf_screenPrintedReportProgram prg_num="#prg_num#" prg_id="#prg_id#" outvar="rdOut" pgbreaks="#attributes.pgbreaks#" prgdesc="#attributes.prgdesc#" prgeps="#attributes.prgeps#" prgepnum="#attributes.prgepnum#" prgreqmat="#attributes.prgreqmat#">
		<cfset strOutData = strOutData & rdOut>
		<cfset queryloopcount = queryloopcount + 1>
	</cfif>
</cfloop>

<cfif IsDefined('session.buff_list') and session.buff_list neq ''>

	<cfset lstProgBuffer=(#session.buff_list#)>
	<cfquery name="qryGetBuffSortOrderAndCatName" datasource="#application.dbSrc#">
		select p.prg_id, c.major_cat, ifnull(pp.supersort, 999999999) bigsort
		from tbl_prg_all p, tbl_major_cat_list c, program pp, programcategory pc
		where p.prg_id in (#PreserveSingleQuotes(lstProgBuffer)#)
			and p.Cat_ID=c.id_number
		<cfif not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq ''>
			and c.id_number <> 333
		</cfif>
			and p.RecID=pp.program_id
			and pp.programcategory_id=pc.programcategory_id
		order by bigsort, pc.sort, pp.sort
	</cfquery>

	<cfset buffCount = 0>	
	<cfloop query="qryGetBuffSortOrderAndCatName">
		<cfif attributes.prglist eq 'all' or ListFindNoCase(attributes.prglist, prg_id) gt 0>
			<cfset buffCount = buffCount + 1>
		</cfif>
	</cfloop>

	<cfif buffCount gt 0>
		<cfset strOutData = strOutData & "
	<h2>Other Programs to Consider</h2>
	
	">
		<cfset strOutData = strOutData & "<p><font face=Arial>There is some chance that you may be eligible for these additional programs, although your income and assets appear to be too high. If these programs could be helpful to you, you may want to apply so that a formal determination can be made.</font></p>">
	
		<cfloop query="qryGetBuffSortOrderAndCatName">
			<cfif attributes.prglist eq 'all' or ListFindNoCase(attributes.prglist, prg_id) gt 0>
				<cfset prg_num = prg_num + 1>
				<cf_screenPrintedReportProgram prg_num="#prg_num#" prg_id="#prg_id#" major_cat="#major_cat#" outvar="rdOut" pgbreaks="#attributes.pgbreaks#" prgdesc="#attributes.prgdesc#" prgeps="#attributes.prgeps#" prgepnum="#attributes.prgepnum#" prgreqmat="#attributes.prgreqmat#">
				<cfset strOutData = strOutData & rdOut>
			</cfif>
		</cfloop>
	</cfif>

</cfif>



<cfif IsDefined('session.wantchips') and session.wantchips is "y">
	<cfset strOutData = strOutData & "
<h2>State Children's Health Insurance Program</h2>

">
	<cfset prg_num=prg_num+1>
	<cfset prg_id="103-309-2191-FD-FD">
	<cfset major_cat="">
	<cf_screenPrintedReportProgram prg_num="#prg_num#" prg_id="103-309-2191-FD-FD" major_cat="" outvar="rdOut" pgbreaks="#attributes.pgbreaks#" prgdesc="#attributes.prgdesc#" prgeps="#attributes.prgeps#" prgepnum="#attributes.prgepnum#" prgreqmat="#attributes.prgreqmat#">
	<cfset strOutData = strOutData & rdOut>
</cfif>


<cfif prg_num eq 0>
	<cfset strOutData = strOutData & "<HR SIZE=6 WIDTH=100%>">
	<cfset strOutData = strOutData & "<font face=Arial>None Selected</font>">
	<cfif attributes.pgbreaks>
		<cfset strOutData = strOutData & "<!-- NEW PAGE -->

">
	<cfelse>
		<cfset strOutData = strOutData & "<br><br><br>

">
</cfif>
</cfif>
<!--- MH: Bug 5476 Comment 6: Remove Additional Information and subsequent paragraph for subset_id 62 --->
<cfif session.subset_id neq 62>
<cfif attributes.addedinfo>
<cf_tagYeDisclaimer var="disclaimerStr" ltcc="#attributes.ltccinfo#">
<cfif #len(disclaimerStr)# gt 100>
<cfset strOutData = strOutData & "
<h2><font face=Arial>Additional Information</font></h2>

">

<cfset strOutData = strOutData & disclaimerStr>
<cfif attributes.pgbreaks>
	<cfset strOutData = strOutData & "<!-- NEW PAGE -->

">
<cfelse>
	<cfset strOutData = strOutData & "<br><br><br>

">
</cfif>
</cfif>
</cfif>
</cfif>


<cfif attributes.localprgs>
<cfif session.org_id gt 0>
	<cfquery name="proginfo" datasource="#application.dbSrcOE#">
		SELECT lp.name Prg_Name, lp.description Prg_Desc
		FROM LOCAL_PROGRAM lp, PRIORITY p
		WHERE lp.org_id = #session.org_id#
			AND lp.priority_id = p.id
		ORDER BY p.sort_order, lp.name
	</cfquery>
	<cfif proginfo.RecordCount gt 0>
		<cfset strOutData = strOutData & "<font face=Arial>">
		<cfset strOutData = strOutData & "
<h2>Other Programs Available from<br>#localProfileName#</h2>

">
		<cfset strOutData = strOutData & "<hr size=6><br>

">
		<cfoutput query="proginfo">
			<cfset prgDescFormatted = proginfo.Prg_Desc>
			<cfset prgDescFormatted = Replace(prgDescFormatted, '
', '<br>', 'ALL')>
			<cfset strOutData = strOutData & "<font size=+1><b>#proginfo.Prg_Name#</b></font><br>">
			<cfset strOutData = strOutData & "#prgDescFormatted#<br><br>">
		</cfoutput>
		<cfset strOutData = strOutData & "</font>">
<cfif attributes.pgbreaks>
	<cfset strOutData = strOutData & "<!-- NEW PAGE -->

">
<cfelse>
	<cfset strOutData = strOutData & "<br><br><br>

">
</cfif>
	</cfif>
</cfif>
</cfif>

<cfif attributes.addedinfo>
<!---cfif session.st eq 'OH' and session.county eq 'CUYAHOGA'>
		<cfset strOutData = strOutData & "
<h2><font face=Arial>Services Offered in Suburban Cuyahoga County</font></h2>

">
		<cfset strOutData = strOutData & "<CENTER>">
		<cfinclude template="screenCuyahogaMatrix.cfm">
		<cfset strOutData = strOutData & "</CENTER>">
<cfif attributes.pgbreaks>
	<cfset strOutData = strOutData & "<!-- NEW PAGE -->

">
<cfelse>
	<cfset strOutData = strOutData & "<br><br><br>

">
</cfif>
</cfif--->
</cfif>

<cfset strOutData=REReplace(strOutData, "<(a href|A HREF)=[^>]*>", "" , "ALL")>

<cfif session.st eq "IL" and session.county eq "COOK" and session.org_id gt 0>
	<cfsilent>
		<cf_tagPDFCover localversion="cookcountyil">
	</cfsilent>
<cfelseif attributes.brandcover neq "none">
	<cfsilent>
		<cf_tagPDFCover brandcover="#attributes.brandcover#">
	</cfsilent>
<cfelse>	
	<cfsilent>
		<cf_tagPDFCover >
	</cfsilent>
</cfif>


</cfif> <!--- END NOT BLANK REPORT --->

<!--- keep these soft coded to global path vars--->

<cfsilent>
	<cfif attributes.coverpage>
		<cffile action="WRITE" file="#session.strPDFPath##attributes.pdfname#.html" output="#pdfcoverstr#">
	</cfif>
	<cfset strOutData = #replacenocase(strOutData,'<img src="http://','<img src="http://','ALL')#>
	<cffile action="WRITE" file="#session.strPDFPath##attributes.pdfname#.cfm" output="#strOutData#">

	<cfif attributes.fileformat eq 'pdf'>
				<cfif attributes.coverpage>
			<cfif attributes.toc>
				<cfdocument format="PDF" filename="#session.strPDFPath##attributes.pdfname#">
					#strOutData#
				</cfdocument>
				<CFEXECUTE NAME="#session.strBatchPath#MakePDF.bat" timeout="1800" arguments="#attributes.pdfname#"></CFEXECUTE>
			<cfelse>
				<CFEXECUTE NAME="#session.strBatchPath#MakePDFNoTOC.bat" timeout="1800" arguments="#attributes.pdfname#"></CFEXECUTE>
			</cfif>
		<cfelse>
			<cfif attributes.toc>
				<CFEXECUTE NAME="#session.strBatchPath#MakePDFNoCover.bat" timeout="1800" arguments="#attributes.pdfname#"></CFEXECUTE>
			<cfelse>
				<CFEXECUTE NAME="#session.strBatchPath#MakePDFNoCoverTOC.bat" timeout="1800" arguments="#attributes.pdfname#"></CFEXECUTE>
			</cfif>
		</cfif>
	</cfif>
	<cfset strOutData = #replacenocase(strOutData,'<img src="http://','<img src="https://','ALL')#>
	<cffile action="WRITE" file="#session.strPDFPath##attributes.pdfname#.cfm" output="#strOutData#">
</cfsilent>

<cfset caller.pdfname = attributes.pdfname>

<!---<cfcatch type="Any">
	<h3>Sorry, this report is currently unavailable.</h3>
	<cfoutput>#Error.Diagnostics#</cfoutput>
	<cfabort>
</cfcatch>
</cftry>--->
