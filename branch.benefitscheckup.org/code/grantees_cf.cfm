<!--- Get alt text info from database --->
<cffunction name="getLogo" access="public" returntype="Struct" output="false">
	<cfargument name="logoFilename" default="">
	<cfquery name="getLogoInfo" datasource="#application.dbSrc#">
        SELECT i.width, i.height, dl.display_text
        FROM image i 
        LEFT OUTER JOIN display_language dl ON dl.display_id = i.alt_display_id
        WHERE i.filename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#logoFilename#">	</cfquery>
	
	<cfset logoInfoStruct = StructNew()>
	<cfif getLogoInfo.recordcount>
		<cfset logoInfoStruct.display_text = getLogoInfo.display_text>
		<cfset logoInfoStruct.width = getLogoInfo.width>
		<cfset logoInfoStruct.height = getLogoInfo.height>
	<cfelse>
		<cfset logoInfoStruct.display_text = ''>
		<cfset logoInfoStruct.width = ''>
		<cfset logoInfoStruct.height = ''>
	</cfif>
	
	<cfreturn logoInfoStruct>
</cffunction>

<!--- 
Struct of structs of grantee logos 
--->
	<cfset allGranteesStruct = StructNew()>
	<!--- granteeStruct.granteeState MUST be unique for each entry in order to sort properly --->
	
	<cfset granteeStruct = structNew() />
	
	<cfset granteeStruct.granteeLogo = "">

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.alabamaageline.gov">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Alabama Aging and Disability Resource Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Alabama Alabama Aging and Disability Resource Center">
<cfset granteeStruct.granteeStateName = "Alabama">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.bannerhealth.com/Locations/Arizona/Banner+Olive+Branch+Senior+Center/_Olive+Branch+Senior+Center.htm">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Banner Olive Branch Senior Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Arizona Banner Olive Branch Senior Center">
<cfset granteeStruct.granteeStateName = "Arizona">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.coaoc.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Council on Aging (HICAP) of Orange County">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California Council on Aging (HICAP) of Orange County">
<cfset granteeStruct.granteeStateName = "California">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ventura.org/vcaaa">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "HICAP for the County of Ventura Area Agency on Aging">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California HICAP for the County of Ventura Area Agency on Aging">
<cfset granteeStruct.granteeStateName = "California">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.wiseandhealthyaging.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "WISE & Healthy Aging">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California WISE & Healthy Aging">
<cfset granteeStruct.granteeStateName = "California">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.centura.org/centura-health-links">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Centura Health LINKS">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Colorado Centura Health LINKS">
<cfset granteeStruct.granteeStateName = "Colorado">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.seniorresourcesec.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Senior Resources">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Connecticut Senior Resources">
<cfset granteeStruct.granteeStateName = "Connecticut">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.myeldersource.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "ElderSource of Jacksonville">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Florida ElderSource of Jacksonville">
<cfset granteeStruct.granteeStateName = "Florida">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.glsp.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Georgia Legal Services Program">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Georgia Georgia Legal Services Program">
<cfset granteeStruct.granteeStateName = "Georgia">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ageoptions.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "AgeOptions">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Illinois AgeOptions">
<cfset granteeStruct.granteeStateName = "Illinois">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.kacschicago.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Korean American Community Services">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Illinois Korean American Community Services">
<cfset granteeStruct.granteeStateName = "Illinois">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.chcsek.org/bec">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Community Health Center of Southeast Kansas">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Kansas Community Health Center of Southeast Kansas">
<cfset granteeStruct.granteeStateName = "Kansas">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.gradd.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Green River Area Development District">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Kentucky Green River Area Development District">
<cfset granteeStruct.granteeStateName = "Kentucky">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.lablaw.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Legal Aid of the Bluegrass">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Kentucky Legal Aid of the Bluegrass">
<cfset granteeStruct.granteeStateName = "Kentucky">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.maine.gov/dhhs/oads/aging">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Legal Services for the Elderly">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Maine Legal Services for the Elderly">
<cfset granteeStruct.granteeStateName = "Maine">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.wccoaging.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Washington County Commission on Aging">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Maryland Washington County Commission on Aging">
<cfset granteeStruct.granteeStateName = "Maryland">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.awbs.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Adult Well-Being Services">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Michigan Adult Well-Being Services">
<cfset granteeStruct.granteeStateName = "Michigan">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.elderlawofmi.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Elder Law of Michigan">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Michigan Elder Law of Michigan">
<cfset granteeStruct.granteeStateName = "Michigan">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ma4web.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Missouri Alliance of Area Agencies on Aging">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Missouri Missouri Alliance of Area Agencies on Aging">
<cfset granteeStruct.granteeStateName = "Missouri">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://dphhs.mt.gov/sltc/index">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Montana Department of Public Health & Human Services">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Montana Montana Department of Public Health & Human Services">
<cfset granteeStruct.granteeStateName = "Montana">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>


<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.hopes.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "HOPES Community Action Partnership, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Jersey HOPES Community Action Partnership, Inc.">
<cfset granteeStruct.granteeStateName = "New Jersey">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.jfsatlantic.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Jewish Family Service of Atlantic County">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Jersey Jewish Family Service of Atlantic County">
<cfset granteeStruct.granteeStateName = "New Jersey">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.goadelante.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Adelante Development Center, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Mexico Adelante Development Center, Inc.">
<cfset granteeStruct.granteeStateName = "New Mexico">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.cidny.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Center for Independence of the Disabled in New York">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New York Center for Independence of the Disabled in New York">
<cfset granteeStruct.granteeStateName = "New York">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.isabella.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Isabella Geriatric Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New York Isabella Geriatric Center">
<cfset granteeStruct.granteeStateName = "New York">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.liveon-ny.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Live On New York">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New York Live On New York">
<cfset granteeStruct.granteeStateName = "New York">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://communityhealth.mc.duke.edu">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Duke University">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "North Carolina Duke University">
<cfset granteeStruct.granteeStateName = "North Carolina">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.legalaidnc.org ">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Legal Aid of North Carolina">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "North Carolina Legal Aid of North Carolina">
<cfset granteeStruct.granteeStateName = "North Carolina">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.co.washington.or.us/hhs/davs">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Washington County Disability, Aging & Veteran Services ">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Oregon Washington County Disability, Aging & Veteran Services ">
<cfset granteeStruct.granteeStateName = "Oregon">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.bdtrust.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Benefits Data Trust">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Pennsylvania Benefits Data Trust">
<cfset granteeStruct.granteeStateName = "Pennsylvania">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ccchouston.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Chinese Community Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Texas Chinese Community Center">
<cfset granteeStruct.granteeStateName = "Texas">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.nctcog.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "North Central Texas AAA">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Texas North Central Texas AAA">
<cfset granteeStruct.granteeStateName = "Texas">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.scos-rgv.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Senior Community Outreach Services, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Texas Senior Community Outreach Services, Inc.">
<cfset granteeStruct.granteeStateName = "Texas">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.cisc-seattle.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Chinese Information and Service Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Washington Chinese Information and Service Center">
<cfset granteeStruct.granteeStateName = "Washington">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.kcscgw.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Korean Community Service Center of Greater Washington">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "District of Columbia Korean Community Service Center of Greater Washington">
<cfset granteeStruct.granteeStateName = "District of Columbia">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset sortedGrantees =  StructSort(allGranteesStruct, "textnocase", "asc", "granteeState")>

<cfoutput>

<h1 class="indexh1 grantees_h1"><cf_displayText code="site_nc_grantees_title" group="site"></h1>
<p class="text1 grantees_callout"><cf_displayText code="site_nc_grantees_text" group="site"></p>

<p>
<div class="clear" style="margin-bottom:16px;margin-top:32px;"></div>
</p>

	<cftry>
        <cfset currentStateName = "nostate">
        <cfset prevStateName = "nostate">
<ul>
	<cfloop from="1" to="#ArrayLen(sortedGrantees)#" index="i">
		<cfset currentStruct = allGranteesStruct[sortedGrantees[i]]>
        <cfset currentStateName = currentSTruct.granteeStateName>
<cfif Trim(currentStateName) EQ Trim(prevStateName)>
<!---<cfif "CA" IS "CA">--->
<cfelse>
</ul>

<p class="grantees_callout">#currentSTruct.granteeStateName#</p>
<p><ul style="granteeState">
<cfset prevStateName = currentSTruct.granteeStateName>
<!---
<p>After change</p>
<p>Current state name is-#currentStateName#-</p>
<p>Grantee state name is-#currentSTruct.granteeStateName#-</p>
--->

</cfif>
		<li>
			<div>
				<a href="#currentStruct.granteeUrl#" target="_new">
					<cfif Left(currentStruct.granteeImg, 1) EQ '/'>
						<cfset currentStruct.granteeImg = RemoveChars(currentStruct.granteeImg,1,1)>
					</cfif>
					<!---<cf_displayImage code="#currentStruct.granteeLogo#" alt="#currentStruct.granteeAltText#">--->
					<!---<img src="#currentStruct.granteeImg#" alt="#currentStruct.granteeAltText#" title="#currentStruct.granteeAltText#" />--->
<!---Lynna Cekova: display state and name instead of logo --->
#currentSTruct.granteeAltText#

				</a>
			</div>
		</li>
	</cfloop>
	<cfcatch type="any">
	</cfcatch>
	</cftry>


</li>


</ul>


</cfoutput>


