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

<!--- Hana Center, formerly Korean American Community Services --->
<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.kacschicago.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Hana Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Illinois Hana Center">
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
<cfset granteeStruct.granteeState = "Virginia Korean Community Service Center of Greater Washington">
<cfset granteeStruct.granteeStateName = "Virginia">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.wacog.com/BEC">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Western Arizona Council of Governments">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Arizona Western Arizona Council of Governments">
<cfset granteeStruct.granteeStateName = "Arizona">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.csuchico.edu/chc">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "CSU Chico Research Foundation">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California CSU Chico Research Foundation">
<cfset granteeStruct.granteeStateName = "California">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.fhcsd.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Family Health Centers of San Diego">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California Family Health Centers of San Diego">
<cfset granteeStruct.granteeStateName = "California">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.maof.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Mexican American Opportunity Foundation">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California Mexican American Opportunity Foundation">
<cfset granteeStruct.granteeStateName = "California">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.acfb.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Atlanta Community Food Bank">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Georgia Atlanta Community Food Bank">
<cfset granteeStruct.granteeStateName = "Georgia">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ccano.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Catholic Charities Archdiocese of New Orleans">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Louisiana Catholic Charities Archdiocese of New Orleans">
<cfset granteeStruct.granteeStateName = "Louisiana">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.rio-arriba.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Rio Arriba County Health and Human Services Department">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Mexico Rio Arriba County Health and Human Services Department">
<cfset granteeStruct.granteeStateName = "New Mexico">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.threesquare.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Three Square">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Nevada Three Square">
<cfset granteeStruct.granteeStateName = "Nevada">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- Sixty & Better, formerly Senior Citizen Services of Tarrant County --->
<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.sixtyandbetter.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Sixty & Better">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Texas Sixty & Better">
<cfset granteeStruct.granteeStateName = "Texas">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- Feeding the Gulf Coast --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.feedingthegulfcoast.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Feeding the Gulf Coast">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Alabama Feeding the Gulf Coast">
 <cfset granteeStruct.granteeStateName = "Alabama">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- Pima Council on Aging --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.pcoa.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Pima Council on Aging">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Arizona Pima Council on Aging">
 <cfset granteeStruct.granteeStateName = "Arizona">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- United Cambodian Community --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.ucclb.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "United Cambodian Community">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "California United Cambodian Community">
 <cfset granteeStruct.granteeStateName = "California">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

 <!--- Felton Institute --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.felton.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Felton Institute">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "California Felton Institute">
 <cfset granteeStruct.granteeStateName = "California">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- Area Agency of Palm Beach and the Treasure Coast Inc. --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.youragingresourcecenter.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Area Agency of Palm Beach and the Treasure Coast Inc.">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Florida Area Agency of Palm Beach and the Treasure Coast Inc.">
 <cfset granteeStruct.granteeStateName = "Florida">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

 <!--- Volunteers of America of North Louisiana --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.voanorthla.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Volunteers of America of North Louisiana">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Louisiana Volunteers of America of North Louisiana">
 <cfset granteeStruct.granteeStateName = "Louisiana">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- The Arc of Prince Georges County --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.thearcofpgc.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "The Arc of Prince Georges County">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Maryland The Arc of Prince Georges County">
 <cfset granteeStruct.granteeStateName = "Maryland">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>
 
<!--- Catholic Charities of Northern Nevada --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.ccsnn.org/">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Catholic Charities of Northern Nevada">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Nevada Catholic Charities of Northern Nevada">
 <cfset granteeStruct.granteeStateName = "Nevada">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.asiaohio.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Asian Services in Action, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Ohio Asian Services in Action, Inc.">
<cfset granteeStruct.granteeStateName = "Ohio">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

 <!--- Cambodian Association of Greater Philadelphia --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.cagp.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Cambodian Association of Greater Philadelphia">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Pennsylvania Cambodian Association of Greater Philadelphia">
 <cfset granteeStruct.granteeStateName = "Pennsylvania">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- West Virginia Bureau of Senior Services --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.wvseniorservices.gov">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "West Virginia Bureau of Senior Services">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "West Virginia West Virginia Bureau of Senior Services">
 <cfset granteeStruct.granteeStateName = "West Virginia">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

 <!--- Alivio Medical Center --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.aliviomedicalcenter.org">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Alivio Medical Center">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Illinois Alabama Alivio Medical Center">
 <cfset granteeStruct.granteeStateName = "Illinois">
 <cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- Connecticut State Department on Aging --->
 <cfset granteeStruct = structNew() />
 <cfset granteeStruct.granteeLogo = "">
 <cfset granteeStruct.granteeUrl = "http://www.ct.gov/agingservices">
 <cfset granteeStruct.granteeImg = "">
 <cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
 <cfset granteeStruct.granteeAltText = "Connecticut State Department on Aging">
 <cfset granteeStruct.granteeID = "">
 <cfset granteeStruct.granteeState = "Connecticut State Department on Aging">
 <cfset granteeStruct.granteeStateName = "Connecticut">
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


