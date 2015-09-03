<cfparam name="attributes.debug" default="No">
<cfif attributes.debug eq "No">
	<cfsetting showdebugoutput="No">
<cfelse>
	<cfsetting showdebugoutput="Yes">
</cfif>
<!------------------------------------------------------------
	CF_Excel_XML 1.1
	
	An Excel export custom tag that uses Excel XP's XML format to let you pass in  
	multiple queries to create an Excel workbook containing multiple spreadsheets.
	It also allows you to specify data types to prevent situations where numbers or dates
	are displayed as strings.
	
	This tag works only with the XP and (hopefully) later versions of Excel. 
	It does not work with Excel 2000.

	(c) 2002	by 	Steven L. Smith
					s7@austin.rr.com
	
	  			 All Rights Reserved
	
	This is freeware; no warranties are expressed or implied.
	
	New in version 1.1

	Added yesnoflds attributes for each query
	Added a debug attribute
--------------------------------------------------------------->

<!---	
**************************************
Usage
**************************************

Example:	<cf_excel_xml 
				filename="testing"
				sheets="2" 

				query1="#test1#" 
				collist1="userid,login,browser,logincount" 
				colwidths1="50,100,150,50" 
				headerlist1="Userid,Last Login,Browser,Login Count" 

				query2="#test2#" 
				stringflds2="emplid"
				dateflds2="login">
	
	The only required field is query1 which is a query result. Note that it is passed as the name of the query inside the # signs.
	
	The following are the attributes that apply to the entire entire workbook.
	
	filename		The name of the Excel file you want to generate. It is used in the CFHEADER tag. Default is "export".
	author			The name of the person creating the file. Default is "CF_Excel_XML".
	sheets			The number of spreadsheets. Default is 1.
	headerbgcolor	The background color of the header row. Default is "#C0C0C0", a light grey.
	headerboldtext	Yes/No. Determines whether the header text is in bold text or not. Default is "Yes".
	row1bgcolor		The background color of the odd rows in the query results. Default is "#FFFFFF", white.
	row2bgcolor		The background color of the even rows in the query results. Default is "#FFFFCC", a light yellow.
	debug			Yes/No. Setting to Yes turns off the Excel conversion so you can view the output and any errors you are getting. Default is "No".

	The following are the attributes that apply to a particular spreadsheet. As in the example above, for each spreadsheet you
	increment the attributes's numeric suffix by one. 

	query1			The query to display. it should be passed as the name of the query inside the # signs.
	sheetname1		The name of the spreadsheet, which display in the tab at the bottom of the sheet. Default is "Sheet1", "Sheet2", etc.
	collist1		The list of columns from the query that you want to display, in the order you want to display them. Default is the columnlist variable from the query output.
	colwidths1		A list of widths for each column; each entry must match up with an entry in the collists1 attribute. Default is 100.
	headerrow1		Yes/No. Determines whether to display a header row. Default is "Yes".
	headerfreeze1	Yes/No. Determines whether to freeze the header row. Default is "No".
	headerlist1		A list of header names for each column; each entry must match up with an entry in the collists1 attribute. Default is the collist1 value.
	stringflds1		A list of the columns that contain string values.
	numflds1		A list of the columns that contain plain numeric values.
	currflds1		A list of the columns that contain currency values.
	pctflds1		A list of the columns that contain percent values.
	yesnoflds1		A list of the columns that contain 1's and 0's that will display as Yes/No.
	dateflds1		A list of the columns that contain date values.
	datetimeflds1	A list of the columns that contain datetime values.
	yesnoflds1	A list of the columns that contain 1's and 0's that you want displayed as Yes and No.
	
	If a column is not listed in any of the field type lists, the script will check to see if the value is a number 
	or a date and display it accordingly. Otherwise it is treated as a string.

--->
<cfparam name="attributes.filename" default="export">
<cfparam name="attributes.author" default="CF_Excel_XML">
<cfparam name="attributes.sheets" default="1">
<cfparam name="attributes.headerbgcolor" default="##C0C0C0">
<cfparam name="attributes.headerboldtext" default="Yes">
<cfparam name="attributes.row1bgcolor" default="##FFFFFF">
<cfparam name="attributes.row2bgcolor" default="##FFFFCC">

<cfoutput>
<cfif attributes.debug eq "No">
	<CFHEADER NAME="Content-Disposition" VALUE="inline;filename=#attributes.filename#.xls">
	<cfcontent type="application/msexcel">
	<?xml version="1.0"?>
</cfif>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <LastAuthor>#attributes.author#</LastAuthor>
  <Created>#DateFormat(Now(),"yyyy-mm-dd")#T#TimeFormat(Now(),"HH:mm:ss")#</Created>
  <Version/>
</DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <DownloadComponents/>
  <LocationOfComponents HRef="file:///\\"/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>8000</WindowHeight>
  <WindowWidth>10000</WindowWidth>
  <WindowTopX>480</WindowTopX>
  <WindowTopY>60</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="Head_Cell">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <cfif attributes.headerboldtext eq "Yes"><Font ss:Bold="1"/></cfif>
   <Interior ss:Color="#attributes.headerbgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Plain_Cell_1">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <Interior ss:Color="#attributes.row1bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Curr_Cell_1">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="Currency"/>
   <Interior ss:Color="#attributes.row1bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Pct_Cell_1">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="0%"/>
   <Interior ss:Color="#attributes.row1bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="YesNo_Cell_1">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="Yes/No"/>
   <Interior ss:Color="#attributes.row1bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Date_Cell_1">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="Short Date"/>
   <Interior ss:Color="#attributes.row1bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="DateTime_Cell_1">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="General Date"/>
   <Interior ss:Color="#attributes.row1bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Plain_Cell_2">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <Interior ss:Color="#attributes.row2bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Curr_Cell_2">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="Currency"/>
   <Interior ss:Color="#attributes.row2bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Pct_Cell_2">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="0%"/>
   <Interior ss:Color="#attributes.row2bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="YesNo_Cell_2">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="Yes/No"/>
   <Interior ss:Color="#attributes.row2bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="Date_Cell_2">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="Short Date"/>
   <Interior ss:Color="#attributes.row2bgcolor#" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="DateTime_Cell_2">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="##000000"/>
   </Borders>
   <NumberFormat ss:Format="General Date"/>
   <Interior ss:Color="#attributes.row2bgcolor#" ss:Pattern="Solid"/>
  </Style>
 </Styles>
</cfoutput>
<cfloop from="1" to="#attributes.sheets#" index="w">
<cfif IsDefined("attributes.query#variables.w#")>
	<cfset this_qry = Duplicate(Evaluate("attributes.query#variables.w#"))>
	<cfparam name="attributes.sheetname#variables.w#" default="Sheet#variables.w#">
	<cfparam name="attributes.collist#variables.w#" default="#this_qry.columnlist#">
	<cfparam name="attributes.colwidths#variables.w#" default="">
	<cfparam name="attributes.headerrow#variables.w#" default="Yes">
	<cfparam name="attributes.headerfreeze#variables.w#" default="No">
	<cfparam name="attributes.headerlist#variables.w#" default="#Evaluate("attributes.collist#variables.w#")#">
	<cfparam name="attributes.stringflds#variables.w#" default="">
	<cfparam name="attributes.numflds#variables.w#" default="">
	<cfparam name="attributes.currflds#variables.w#" default="">
	<cfparam name="attributes.pctflds#variables.w#" default="">
	<cfparam name="attributes.yesnoflds#variables.w#" default="">
	<cfparam name="attributes.dateflds#variables.w#" default="">
	<cfparam name="attributes.datetimeflds#variables.w#" default="">
	<cfset sheet_name = Evaluate("attributes.sheetname#variables.w#")>
	<cfset col_list = Evaluate("attributes.collist#variables.w#")>
	<cfset col_widths = Evaluate("attributes.colwidths#variables.w#")>
	<cfset header_row = Evaluate("attributes.headerrow#variables.w#")>
	<cfset header_freeze = Evaluate("attributes.headerfreeze#variables.w#")>
	<cfset header_list = Evaluate("attributes.headerlist#variables.w#")>
	<cfset string_flds = Evaluate("attributes.stringflds#variables.w#")>
	<cfset num_flds = Evaluate("attributes.numflds#variables.w#")>
	<cfset curr_flds = Evaluate("attributes.currflds#variables.w#")>
	<cfset pct_flds = Evaluate("attributes.pctflds#variables.w#")>
	<cfset yesno_flds = Evaluate("attributes.yesnoflds#variables.w#")>
	<cfset date_flds = Evaluate("attributes.dateflds#variables.w#")>
	<cfset datetime_flds = Evaluate("attributes.datetimeflds#variables.w#")>
	<cfif variables.header_row eq "Yes">
		<cfset rownum = this_qry.recordcount + 1>
	<cfelse>
		<cfset rownum = this_qry.recordcount>
	</cfif>
	<cfoutput>
	<Worksheet ss:Name="#variables.sheet_name#">
		<Table ss:ExpandedColumnCount="#ListLen(variables.col_list)#" ss:ExpandedRowCount="#variables.rownum#" x:FullColumns="1" x:FullRows="1">
	<cfloop from="1" to="#ListLen(variables.col_list)#" index="c">
		<cfif variables.col_widths neq ""><cfset this_width = ListGetAt(variables.col_widths,variables.c)><cfelse><cfset this_width = 100></cfif>
		<Column ss:Width="#variables.this_width#"/>
	</cfloop>
	<cfif variables.header_row eq "Yes">
		<Row>
		<cfloop list="#variables.header_list#" index="h">
			<Cell ss:StyleID="Head_Cell"><Data ss:Type="String">#XMLFormat(variables.h)#</Data></Cell>
		</cfloop>
		</Row>
	</cfif>
	</cfoutput>
	<cfoutput query="this_qry">
		<cfif this_qry.currentrow mod 2 eq 0>
			<cfset CellBack = "_2">
		<cfelse>
			<cfset CellBack = "_1">
		</cfif>
		<Row>
		<cfloop from="1" to="#ListLen(variables.col_list)#" index="c">
			<cfset this_col = ListGetAt(variables.col_list,variables.c)>
			<cfset this_val = Trim(Evaluate("this_qry.#variables.this_col#"))>
			<cfif ListFindNoCase(variables.string_flds,variables.this_col)>
				<cfset datatype = "String">
				<cfset format = "Plain">
				<cfset this_val = XMLFormat(variables.this_val)>
			<cfelseif ListFindNoCase(variables.num_flds,variables.this_col)>
				<cfset datatype = "Number">
				<cfset format = "Plain">
			<cfelseif ListFindNoCase(variables.curr_flds,variables.this_col)>
				<cfset datatype = "Number">
				<cfset format = "Curr">
			<cfelseif ListFindNoCase(variables.pct_flds,variables.this_col)>
				<cfset datatype = "Number">
				<cfset format = "Pct">
			<cfelseif ListFindNoCase(variables.yesno_flds,variables.this_col)>
				<cfset datatype = "Number">
				<cfset format = "YesNo">
			<cfelseif ListFindNoCase(variables.date_flds,variables.this_col)>
				<cfset datatype = "DateTime">
				<cfset format = "Date">
				<cfif variables.this_val neq ""><cfset this_val = "#DateFormat(variables.this_val,"yyyy-mm-dd")#"></cfif>
			<cfelseif ListFindNoCase(variables.datetime_flds,variables.this_col)>
				<cfset datatype = "DateTime">
				<cfset format = "DateTime">
				<cfif variables.this_val neq ""><cfset this_val = "#DateFormat(variables.this_val,"yyyy-mm-dd")#T#TimeFormat(variables.this_val,"HH:mm:ss")#"></cfif>
			<cfelseif IsNumeric(variables.this_val)>
				<cfset datatype = "Number">
				<cfset format = "Plain">
			<cfelseif IsDate(variables.this_val)>
				<cfset datatype = "DateTime">
				<cfset format = "DateTime">
				<cfif variables.this_val neq ""><cfset this_val = "#DateFormat(variables.this_val,"yyyy-mm-dd")#T#TimeFormat(variables.this_val,"HH:mm:ss")#"></cfif>
			<cfelse>
				<cfset datatype = "String">
				<cfset format = "Plain">
				<cfset this_val = XMLFormat(variables.this_val)>
 			</cfif>
			<cfif variables.this_val eq "">
				<Cell ss:StyleID="#variables.format#_Cell#variables.CellBack#"/>
			<cfelse>
				<Cell ss:StyleID="#variables.format#_Cell#variables.CellBack#"><Data ss:Type="#variables.datatype#">#variables.this_val#</Data></Cell>
 			</cfif>
		</cfloop>
	</Row>
	</cfoutput>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <DoNotDisplayGridlines/>
   <cfif variables.header_freeze eq "Yes">
   <FreezePanes/>
   <FrozenNoSplit/>
   <SplitHorizontal>1</SplitHorizontal>
   <TopRowBottomPane>1</TopRowBottomPane>
   <ActivePane>2</ActivePane>
   <Panes>
    <Pane>
     <Number>3</Number>
    </Pane>
    <Pane>
     <Number>2</Number>
    </Pane>
   </Panes>
   </cfif>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</cfif>
</cfloop>
</Workbook>
