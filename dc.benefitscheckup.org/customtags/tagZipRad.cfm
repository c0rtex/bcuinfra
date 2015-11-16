 <!--- CF_ZipRad --->

<!--- 
CF_ZipRad ver .02 

This tag requires the zip code database from Jay Computer Services, Inc. http://www.jcsm.com.
Other databases may work with some modification.

Using the tag is very easy: 

<CF_ZipRad DATASOURCE="jcszip" ziptable="jcszip" zip1="#form.zipcode#" zipradius="#form.radius#" NAME="rad" sort="zip|miles" detail="0|1">  

Where datasource is the correctly configured ODBC source that contains the zip code table, 
ziptable is the name of the table containing the zip code data, 
zip1 is the zip code to use as the center of the radius search, 
name is the name you want to assign to the returned query, 
sort is the numeric field you wish to sort the returned query by (Currently only the numeric fields Miles and ZipCode are available for sorting),
and detail turns detail lookup on and off.

Sort defaults to miles.
Detail defaults to 0 (off) 

Outputting the returned data can be done in two ways: 

QUERY OUTPUT
This results in a standard CFOUTPUT using a named query.

Query Columns:

zip, city (primary city), state, county, areacode, city_dtl (list of other city names within that zip code), miles (distance from supplied zip).

The city_dtl comes from a seperate table in the jcszip database called `city detail`. You will need to import this table into your working database as well. The table name is hard-coded into the tag for now.


Example:

<CFOUTPUT QUERY="rad">
#zipcode# - #city#, #state# - #miles#
<CFOUTPUT>

Output:

52240 - Iowa City, IA - 2.5
52248 - Coralville, IA - 6.5


LISTS
zip_list
city_list
state_list
miles_list
county_list
areacode_list

These are standard comma delimited lists:

60657,60615,20435,99909...

IL,IA,MN,TX...

These can be used however you wish. One common practice is to use the Zip_List as the criteria for a new query, perhaps to select stores or other business locations by address from a database:

<cfquery NAME="locations">
SELECT * FROM businesses 
WHERE zipcode IN (#zip_list#)
ORDER BY StoreName ASC
</CFQUERY>

--->

<cfparam NAME="attributes.detail" default="0">
<cfparam NAME="attributes.sort" default="miles">

<CFIF ISDEFINED('attributes.sort')>
		<CFSET sort = attributes.sort>
</CFIF>

<CFIF NOT ISDEFINED('attributes.zip1')>
	ZIP1 not defined.
	<cfabort>
</CFIF>

<CFIF NOT ISDEFINED('attributes.zipradius')>
	ZIPRADIUS not defined.
	<cfabort>
</CFIF>

<CFIF NOT ISDEFINED('attributes.ziptable')>
	ZIPTABLE not defined.
	<cfabort>
</CFIF>

<CFIF NOT ISDEFINED('attributes.datasource')>
	DATASOURCE not defined.
	<cfabort>
</CFIF>


<CFIF NOT ISDEFINED('attributes.name')>
	NAME not defined.
	<cfabort>
</CFIF>



<CFSET zip_list = "">
<CFSET City_list = "">
<CFSET state_list = "">
<CFSET miles_list = "">
<CFSET county_list = "">
<CFSET areacode_list = ""> 
<CFSET city_dtl = "">

<CFSET zip1 = "#attributes.zip1#">
<CFSET zipradius = "#attributes.zipradius#">
<CFSET ziptable = "#attributes.ziptable#">
<CFSET datasource = "#attributes.datasource#">

<CFSET feedback = " ">



<!--- <CFSET feedback = "caller." & '#attributes.name#'> --->

<CFSET feedback = QueryNew('zip, miles, city, city_dtl, state, areacode, county')>


<!---
<CFSET "#feedback#" = QueryNew("zip,city,state,miles,county,areacode")>
--->

<CFIF zip1 LT 1>
	<CFSET zip1=100>
</CFIF> 

<CFSET zip1a=zip1>
<CFSET zip1b=zip1 + 700>

<CFLOOP condition="(#Len(zip1a)# LT 5)">
	<CFSET zip1a="0" & zip1a>
</CFLOOP>

<CFLOOP condition="(#Len(zip1b)# LT 5)">
	<CFSET zip1b="0" & zip1b>
</CFLOOP>

<CFSET radius=zipradius>
    
<cfquery NAME="ZP1" DATASOURCE="#attributes.datasource#">
	SELECT 
		cast( tbl_zip.Zip as int) as Zip, #ziptable#.Lat, #ziptable#.Lon,
		#ziptable#.LastLineCity, #ziptable#.CountofCity, #ziptable#.TimeZone,
		#ziptable#.AreaCode, #ziptable#.County, #ziptable#.State
	FROM #ziptable#
	WHERE tbl_zip.Zip=#zip1a#
	ORDER BY #ziptable#.Zip
</CFQUERY>

<CFIF ZP1.recordcount EQ 0>
	<cfquery NAME="ZP1" DATASOURCE="#attributes.datasource#">
		SELECT 
			cast( tbl_zip.Zip as  int) as Zip, #ziptable#.Lat, #ziptable#.Lon,
			#ziptable#.LastLineCity, #ziptable#.CountofCity, #zipTable#.TimeZone,
			#ziptable#.AreaCode, #ziptable#.County, #ziptable#.State
		FROM #ziptable#
		WHERE tbl_zip.Zip=#zip1a# AND tbl_zip.Zip <=#zip1b#  
		ORDER BY #ziptable#.Zip
	</CFQUERY>
</CFIF>

<CFIF ZP1.zip NEQ zip1a>
	<CFSET zip1a = ZP1.zip>
</CFIF>

<cfquery NAME="ZP2" DATASOURCE="#attributes.datasource#">
	SELECT 
		cast( #ziptable#.Zip as int) as Zip, #ziptable#.Lat, #ziptable#.Lon,
		#ziptable#.LastLineCity, #ziptable#.CountofCity, #ziptable#.TimeZone, 
		#ziptable#.AreaCode, #ziptable#.County, #ziptable#.State
	FROM #ziptable#
	WHERE (#ziptable#.Lat >= #ZP1.Lat# - (#radius# * 0.0005)) 
	And (#ziptable#.Lat <= #ZP1.Lat# + (#radius# * 0.0005))  
	AND (#ziptable#.Lon >= #ZP1.Lon# - (#radius# * 0.0005))
	AND (#ziptable#.Lon <= #ZP1.Lon# + (#radius# * 0.0005))
	ORDER BY #ziptable#.Zip
</CFQUERY>
 
<CFLOOP query="ZP2">
	<CFIF ZP1.zip EQ ZP2.zip>
		<CFSET miles=0>
	<CFELSE>
		<cfif (zp1.lat eq zp2.lat) or  (zp1.lon eq zp2.lon) >
			<cfset miles=0>
		<cfelse>
			<CFSET formula = Sin(ZP1.lat) * Sin(ZP2.lat) + COS(ZP1.lat) *  COS(ZP2.lat) * 
			 COS(ZP2.lon - ZP1.lon)>
			<CFIF formula EQ 1>
				<CFSET miles=0>
			<CFELSE>
		    	<CFSET miles = 3963 * (ATN(-formula / SQR(-formula * formula + 1)) + 2 *
				 ATN(1))> 
			</CFIF>
		</cfif>
	</CFIF>

	<CFIF miles LTE radius>  
		<CFIF attributes.detail>	
			<cfquery NAME="dtl" DATASOURCE="#attributes.datasource#">
			SELECT `city detail`.city 

			FROM  `city detail`

			WHERE  `city detail`.zip = '#ZP2.zip#' 

			ORDER BY `city detail`.city

			</CFQUERY>
	
			<CFSET city_dtlmod = "">	
			<CFSET city_dtlfinal = "">
	
			<CFOUTPUT QUERY="dtl">
				<CFSET city_dtlmod = city_dtlmod & city & ",">
			</CFOUTPUT>
			
			<CFSET city_dtlmod = LEFT(city_dtlmod, LEN(city_dtlmod) -1)>
			
			<CFLOOP index="ii" from="1" to="#LISTLEN(city_dtlmod)#"> 
				<CFIF zp2.lastlinecity NEQ ListGetAt(city_dtlmod, ii)>
					<CFSET city_dtlfinal = city_dtlfinal & ListGetAt(city_dtlmod, ii) & "<BR>">
				</CFIF>
			</CFLOOP>	
		</CFIF>
	
		<CFSET LastRow = QueryAddRow(feedback)>
		<CFSET Temp = QuerySetCell(feedback, "zip", ZP2.Zip)>
		<CFSET Temp = QuerySetCell(feedback, "city", ZP2.LastLineCity)>
	
		<CFIF attributes.detail>
			<CFSET temp = QuerySetCell(feedback, "city_dtl", city_dtlfinal)>
		<CFELSE>
			<CFSET temp = QuerySetCell(feedback, "city_dtl", '')>
		</CFIF>
	
			<CFIF miles EQ 0>
				 <CFSET Temp = QuerySetCell(feedback, "miles", 0.001)>
			<CFELSE>
				 <CFSET Temp = QuerySetCell(feedback, "miles", miles)>
			</CFIF>
			
			
			<CFSET Temp = QuerySetCell(feedback, "state", state)>
			<CFSET Temp = QuerySetCell(feedback, "areacode", areacode)>
			<CFSET Temp = QuerySetCell(feedback, "county", county)>
			<CFOUTPUT>
	
			<CFSET zip_list = zip_list  & ZP2.Zip & ','> 
			<CFSET city_list = City_List & ZP2.LastLineCity & ','>
			<CFSET state_list = State_List & ZP2.state & ','>
			<CFSET miles_list = Miles_List  & decimalformat(miles) & ','>
			<CFSET county_list = County_List & ZP2.county & ','>
			<CFSET areacode_list = AreaCode_List & ZP2.areacode & ','>
	
			</CFOUTPUT>
	</CFIF>

</CFLOOP>


<CFSET caller.zip_list = LEFT(zip_list, LEN(zip_list) -1)>
<CFSET caller.city_list = LEFT(city_list, LEN(City_List) -1)>
<CFSET caller.state_list = LEFT(State_List, LEN(State_List) -1)>
<CFSET caller.miles_list = LEFT(Miles_List, LEN(Miles_List) -1)>
<CFSET caller.county_list = LEFT(County_List, LEN(County_List) - 1)>
<CFSET caller.areacode_list = LEFT(AreaCode_List, LEN(AreaCode_List) -1)>

<!--- Changed to caller.city --->

<CFSET caller.city = zp1.lastlinecity>
<CFSET caller.state1 = zp1.state>
<CFSET caller.zip1 = zip1>

<CFIF ISDEFINED('attributes.sort')>
	<cftry>
		<CF_tagQuerySort
		  QUERY="feedback"
		  SORTCOLUMN="#sort#"
		  SORTORDER="ASC"              
		  SORTTYPE="Numeric"            
		  SORTEDQUERY="feedbackSorted">
	<cfcatch>
	<CF_tagQuerySort
		  QUERY="feedback"
		  SORTCOLUMN="#sort#"
		  SORTORDER="ASC"              
		  SORTTYPE="Textnocase"            
		  SORTEDQUERY="feedbackSorted">
	
	</cfcatch>
	</cftry>
	<CFSET "caller.#attributes.name#" = feedbackSorted>

<CFELSE>

	<CFSET "caller.#attributes.name#" = feedback>
</CFIF>
