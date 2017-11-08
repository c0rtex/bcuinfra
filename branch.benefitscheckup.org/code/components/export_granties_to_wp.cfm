<cffunction name="getLogo" access="public" returntype="Struct" output="false">
    <cfargument name="logoFilename" default="">
    <cfquery name="getLogoInfo" datasource="dbSrc">
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

<cffunction name="getPartnerType" access="public" returntype="Struct" output="false">
    <cfargument name="partnerId" default="">
    <cfquery name="getPartner" datasource="dbSrc">
        select
            tp.partner_code,
            pt.`code`,
            pt.`name`
        from
            tbl_partner tp join partnertype pt on tp.partnertype_id=pt.partnertype_id
  where partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partnerId#">
    </cfquery>
    <cfset var retVal = structNew()>
    <cfif getPartner.recordcount>
        <cfset retVal.partner_code=getPartner.partner_code>
        <cfset retVal.partner_type_code=getPartner.code>
        <cfset retVal.partner_type_name=getPartner.name>
    <cfelse>
        <cfset retVal.partner_code=''>
        <cfset retVal.partner_type_code=''>
        <cfset retVal.partner_type_name=''>
    </cfif>
    <cfreturn retVal>
</cffunction>

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
<cfset granteeStruct.granteeStateName = "AL">
<cfset granteeStruct.partnerId = "68">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.bannerhealth.com/Locations/Arizona/Banner+Olive+Branch+Senior+Center/_Olive+Branch+Senior+Center.htm">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Banner Olive Branch Senior Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Arizona Banner Olive Branch Senior Center">
<cfset granteeStruct.granteeStateName = "AZ">
<cfset granteeStruct.partnerId = "111">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.coaoc.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Council on Aging (HICAP) of Orange County">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California Council on Aging (HICAP) of Orange County">
<cfset granteeStruct.granteeStateName = "CA">
<cfset granteeStruct.partnerId = "107">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ventura.org/vcaaa">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "HICAP for the County of Ventura Area Agency on Aging">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California HICAP for the County of Ventura Area Agency on Aging">
<cfset granteeStruct.granteeStateName = "CA">
<cfset granteeStruct.partnerId = "108">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.centura.org/centura-health-links">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Centura Health LINKS">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Colorado Centura Health LINKS">
<cfset granteeStruct.granteeStateName = "CO">
<cfset granteeStruct.partnerId = "0">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.seniorresourcesec.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Senior Resources">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Connecticut Senior Resources">
<cfset granteeStruct.granteeStateName = "CT">
<cfset granteeStruct.partnerId = "84">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.myeldersource.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "ElderSource of Jacksonville">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Florida ElderSource of Jacksonville">
<cfset granteeStruct.granteeStateName = "FL">
<cfset granteeStruct.partnerId = "95">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.glsp.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Georgia Legal Services Program">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Georgia Georgia Legal Services Program">
<cfset granteeStruct.granteeStateName = "GA">
<cfset granteeStruct.partnerId = "100">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ageoptions.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "AgeOptions">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Illinois AgeOptions">
<cfset granteeStruct.granteeStateName = "IL">
<cfset granteeStruct.partnerId = "61">
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
<cfset granteeStruct.granteeStateName = "IL">
<cfset granteeStruct.partnerId = "99">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.chcsek.org/bec">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Community Health Center of Southeast Kansas">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Kansas Community Health Center of Southeast Kansas">
<cfset granteeStruct.granteeStateName = "KS">
<cfset granteeStruct.partnerId = "124">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.gradd.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Green River Area Development District">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Kentucky Green River Area Development District">
<cfset granteeStruct.granteeStateName = "KY">
<cfset granteeStruct.partnerId = "67">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.lablaw.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Legal Aid of the Bluegrass">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Kentucky Legal Aid of the Bluegrass">
<cfset granteeStruct.granteeStateName = "KY">
<cfset granteeStruct.partnerId = "96">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.maine.gov/dhhs/oads/aging">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Legal Services for the Elderly">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Maine Legal Services for the Elderly">
<cfset granteeStruct.granteeStateName = "ME">
<cfset granteeStruct.partnerId = "64">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.wccoaging.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Washington County Commission on Aging">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Maryland Washington County Commission on Aging">
<cfset granteeStruct.granteeStateName = "MD">
<cfset granteeStruct.partnerId = "60">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>


<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.elderlawofmi.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Elder Law of Michigan">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Michigan Elder Law of Michigan">
<cfset granteeStruct.granteeStateName = "MI">
<cfset granteeStruct.partnerId = "65">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ma4web.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Missouri Alliance of Area Agencies on Aging">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Missouri Missouri Alliance of Area Agencies on Aging">
<cfset granteeStruct.granteeStateName = "MO">
<cfset granteeStruct.partnerId = "132">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://dphhs.mt.gov/sltc/index">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Montana Department of Public Health & Human Services">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Montana Montana Department of Public Health & Human Services">
<cfset granteeStruct.granteeStateName = "MT">
<cfset granteeStruct.partnerId = "62">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>


<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.hopes.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "HOPES Community Action Partnership, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Jersey HOPES Community Action Partnership, Inc.">
<cfset granteeStruct.granteeStateName = "NJ">
<cfset granteeStruct.partnerId = "127">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.jfsatlantic.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Jewish Family Service of Atlantic County">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Jersey Jewish Family Service of Atlantic County">
<cfset granteeStruct.granteeStateName = "NJ">
<cfset granteeStruct.partnerId = "128">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.goadelante.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Adelante Development Center, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Mexico Adelante Development Center, Inc.">
<cfset granteeStruct.granteeStateName = "NM">
<cfset granteeStruct.partnerId = "110">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.cidny.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Center for Independence of the Disabled in New York">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New York Center for Independence of the Disabled in New York">
<cfset granteeStruct.granteeStateName = "NY">
<cfset granteeStruct.partnerId = "59">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.isabella.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Isabella Geriatric Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New York Isabella Geriatric Center">
<cfset granteeStruct.granteeStateName = "NY">
<cfset granteeStruct.partnerId = "94">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.liveon-ny.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Live On New York">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New York Live On New York">
<cfset granteeStruct.granteeStateName = "NY">
<cfset granteeStruct.partnerId = "131">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://communityhealth.mc.duke.edu">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Duke University">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "North Carolina Duke University">
<cfset granteeStruct.granteeStateName = "NC">
<cfset granteeStruct.partnerId = "125">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>



<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.co.washington.or.us/hhs/davs">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Washington County Disability, Aging & Veteran Services ">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Oregon Washington County Disability, Aging & Veteran Services ">
<cfset granteeStruct.granteeStateName = "OR">
<cfset granteeStruct.partnerId = "98">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.bdtrust.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Benefits Data Trust">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Pennsylvania Benefits Data Trust">
<cfset granteeStruct.granteeStateName = "PA">
<cfset granteeStruct.partnerId = "23">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ccchouston.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Chinese Community Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Texas Chinese Community Center">
<cfset granteeStruct.granteeStateName = "TX">
<cfset granteeStruct.partnerId = "112">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.nctcog.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "North Central Texas AAA">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Texas North Central Texas AAA">
<cfset granteeStruct.granteeStateName = "TX">
<cfset granteeStruct.partnerId = "133">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.scos-rgv.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Senior Community Outreach Services, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Texas Senior Community Outreach Services, Inc.">
<cfset granteeStruct.granteeStateName = "TX">
<cfset granteeStruct.partnerId = "109">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.cisc-seattle.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Chinese Information and Service Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Washington Chinese Information and Service Center">
<cfset granteeStruct.granteeStateName = "WA">
<cfset granteeStruct.partnerId = "123">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.kcscgw.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Korean Community Service Center of Greater Washington">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Virginia Korean Community Service Center of Greater Washington">
<cfset granteeStruct.granteeStateName = "VA">
<cfset granteeStruct.partnerId = "129">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.wacog.com/BEC">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Western Arizona Council of Governments">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Arizona Western Arizona Council of Governments">
<cfset granteeStruct.granteeStateName = "AZ">
<cfset granteeStruct.partnerId = "145">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.csuchico.edu/chc">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "CSU Chico Research Foundation">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California CSU Chico Research Foundation">
<cfset granteeStruct.granteeStateName = "CA">
<cfset granteeStruct.partnerId = "148">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.fhcsd.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Family Health Centers of San Diego">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California Family Health Centers of San Diego">
<cfset granteeStruct.granteeStateName = "CA">
<cfset granteeStruct.partnerId = "151">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.maof.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Mexican American Opportunity Foundation">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "California Mexican American Opportunity Foundation">
<cfset granteeStruct.granteeStateName = "CA">
<cfset granteeStruct.partnerId = "154">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.acfb.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Atlanta Community Food Bank">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Georgia Atlanta Community Food Bank">
<cfset granteeStruct.granteeStateName = "GA">
<cfset granteeStruct.partnerId = "157">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.ccano.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Catholic Charities Archdiocese of New Orleans">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Louisiana Catholic Charities Archdiocese of New Orleans">
<cfset granteeStruct.granteeStateName = "LA">
<cfset granteeStruct.partnerId = "160">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.rio-arriba.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Rio Arriba County Health and Human Services Department">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "New Mexico Rio Arriba County Health and Human Services Department">
<cfset granteeStruct.granteeStateName = "NM">
<cfset granteeStruct.partnerId = "139">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.threesquare.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Three Square">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Nevada Three Square">
<cfset granteeStruct.granteeStateName = "NV">
<cfset granteeStruct.partnerId = "163">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.asiaohio.org/">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Asian Services in Action, Inc.">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Ohio Asian Services in Action, Inc.">
<cfset granteeStruct.granteeStateName = "OH">
<cfset granteeStruct.partnerId = "166">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>


<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.tnjustice.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Tennessee Justice Center">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Tennessee Tennessee Justice Center">
<cfset granteeStruct.granteeStateName = "TN">
<cfset granteeStruct.partnerId = "169">
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
<cfset granteeStruct.granteeStateName = "TX">
<cfset granteeStruct.partnerId = "172">
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
<cfset granteeStruct.granteeStateName = "AL">
<cfset granteeStruct.partnerId = "173">
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
<cfset granteeStruct.granteeStateName = "AZ">
<cfset granteeStruct.partnerId = "197">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- Asian Pacific Community in Action --->
<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.apcaaz.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "Asian Pacific Community in Action">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "Arizona Asian Pacific Community in Action">
<cfset granteeStruct.granteeStateName = "AZ">
<cfset granteeStruct.partnerId = "194">
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
<cfset granteeStruct.granteeStateName = "CA">
<cfset granteeStruct.partnerId = "200">
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
<cfset granteeStruct.granteeStateName = "CA">
<cfset granteeStruct.partnerId = "176">
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
<cfset granteeStruct.granteeStateName = "FL">
<cfset granteeStruct.partnerId = "179">
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
<cfset granteeStruct.granteeStateName = "LA">
<cfset granteeStruct.partnerId = "182">
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
<cfset granteeStruct.granteeStateName = "MD">
<cfset granteeStruct.partnerId = "185">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!--- First in Families of North Carolina --->
<cfset granteeStruct = structNew() />
<cfset granteeStruct.granteeLogo = "">
<cfset granteeStruct.granteeUrl = "http://www.fifnc.org">
<cfset granteeStruct.granteeImg = "">
<cfset granteeLogo = getLogo(granteeStruct.granteeImg)>
<cfset granteeStruct.granteeAltText = "First in Families of North Carolina">
<cfset granteeStruct.granteeID = "">
<cfset granteeStruct.granteeState = "North Carolina First in Families of North Carolina">
<cfset granteeStruct.granteeStateName = "NC">
<cfset granteeStruct.partnerId = "203">
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
<cfset granteeStruct.granteeStateName = "NV">
<cfset granteeStruct.partnerId = "206">
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
<cfset granteeStruct.granteeStateName = "PA">
<cfset granteeStruct.partnerId = "188">
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
<cfset granteeStruct.granteeStateName = "WV">
<cfset granteeStruct.partnerId = "191">
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
<cfset granteeStruct.granteeStateName = "IL">
<cfset granteeStruct.partnerId = "209">
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
<cfset granteeStruct.granteeStateName = "CT">
<cfset granteeStruct.partnerId = "212">
<cfset allGranteesStruct[granteeStruct.granteeState] = granteeStruct>

<!---<cfset sortedGrantees =  StructSort(allGranteesStruct, "textnocase", "asc", "granteeState")>--->

<cfoutput>
    <p>delete from wp_posts where post_type='grantees';</p>
    <p>delete from wp_postmeta where meta_key in ('site-url','state','logo-url','img-url');</p>
    </p>
    <cfloop collection="#allGranteesStruct#" item="i">
        <cfset partnerInfo = getPartnerType(allGranteesStruct[i]["partnerId"])>

        <cfoutput><p>set @post_id = null;</p></cfoutput>
        <cfoutput><p>insert into wp_posts(post_title,post_type,post_content,post_excerpt,to_ping,pinged,post_content_filtered,post_mime_type)
            values ('#allGranteesStruct[i]["granteeAltText"]#','grantees','','','','','','');</p></cfoutput>

        <cfoutput><p>select last_insert_id() into @post_id;</p></cfoutput>

        <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'site-url','#allGranteesStruct[i]["granteeUrl"]#');</p></cfoutput>
        <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'state','#allGranteesStruct[i]["granteeStateName"]#');</p></cfoutput>
        <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'logo-url','#allGranteesStruct[i]["granteeLogo"]#');</p></cfoutput>
        <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'img-url','#allGranteesStruct[i]["granteeImg"]#');</p></cfoutput>
        <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-id','#allGranteesStruct[i]["partnerId"]#');</p></cfoutput>
        <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-code','#partnerInfo["partner_code"]#');</p></cfoutput>
        <cfoutput><p>insert into wp_postmeta(post_id,meta_key,meta_value) values(@post_id,'partner-type','#partnerInfo["partner_type_code"]#');</p></cfoutput>
    </cfloop>
</cfoutput>

