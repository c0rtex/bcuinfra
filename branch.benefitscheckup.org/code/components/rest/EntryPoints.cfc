<cfcomponent rest="true" restpath="/entryPoints">

    <cffunction name="forProgram" access="remote" restpath="/forProgram/{programCode}/" returnType="String" httpMethod="GET">
        <cfargument name="programCode" required="true" restargsource="Path" type="string"/>
        <cfargument name="zipcode" required="false" restargsource="Query">

        <cfset params = structNew()>
        <cfset this.setDefaultParams()>

        <cfset retVal = arrayNew(1)>

        <cfset pobj = entityload("program",{code=programCode})>

        <cfif (arraylen(pobj) neq 0)>
            <cfset pobj = pobj[1]>
        <cfelse>
            <cfreturn serializeJSON(retVal)>
        </cfif>

        <cfset epgroup = ormExecuteQuery("select pepg.entry_point_group,
                                                 pepg.sort,
                                                 count(pepg.entry_point_group),
                                                 max(ep.id)
                                          from program_entry_point_group pepg join
                                               pepg.entry_point_group epg join
                                               epg.entry_points ep
                                          where epg.active_flag=1 and
                                                ep.active_flag=1 and pepg.program=?
                                          group by pepg.entry_point_group,
                                                   pepg.sort
                                          order by pepg.sort",[pobj])>

        <cfset prgprox = ormExecuteQuery("select p from program_proximity pp join pp.proximity p where pp.program=? order by pp.sort",[pobj])>

        <cfset methodSucceeded = false>
        <cfloop array="#epgroup#" index="erpgi">
            <cfif not methodSucceeded>

                <cfset egid = erpgi[1].getId()>

                <cfif erpgi[3] eq 1>
                    <cfset methodSucceeded = true>

                    <cfset arrayAppend(retVal,this.formatEntryPoint(entityLoadByPK("entry_point",erpgi[4])))>
                <cfelse>
                    <cfif params.proximityOverride is "county">
                        <cfset this.proximityCountyOverride(erpgi[1])>
                    <cfelse>
                        <cfloop array="#prgprox#" index="prgpi">
                            <cfif not methodSucceeded>
                                <cfswitch expression="#prgpi.getCode()#">
                                    <cfcase value="local">
                                        <cfset this.proximityLocal(erpgi[1])>
                                    </cfcase>
                                    <cfcase value="county">
                                        <cfset this.proximityCounty(erpgi[1])>
                                    </cfcase>
                                    <cfcase value="city">
                                        <cfset this.proximityCity(erpgi[1])>
                                    </cfcase>
                                    <cfcase value="zip">
                                        <cfset this.proximityZip(erpgi[1])>
                                    </cfcase>
                                    <cfcase value="radius">
                                        <cfset this.proximityRadius(erpgi[1])>
                                    </cfcase>
                                </cfswitch>
                            </cfif>
                        </cfloop>
                    </cfif>

                    <cfif not methodSucceeded >
                        <cfset this.proximityRadius(erpgi[1])>
                    </cfif>
                </cfif>
            </cfif>
        </cfloop>
        <cfreturn serializeJSON(retVal)>
    </cffunction>

    <cffunction name="setDefaultParams">
        <!---<cfparam name="attributes.program_id" type="numeric" default="0">
        <cfparam name="attributes.mode" type="string" default="screen">
        <cfparam name="attributes.source" type="string" default="">
        <cfparam name="attributes.city_id" type="string" default="">
        <cfparam name="attributes.zipcode" type="string" default="">
        <cfparam name="attributes.radius" type="numeric" default="100">
        <cfparam name="attributes.limit" type="numeric" default="3">
        <cfparam name="attributes.var" type="string" default="">
        <cfparam name="attributes.append" type="boolean" default="false">
        <cfparam name="attributes.debugvar" type="string" default="">
        <cfparam name="attributes.suppressText" type="string" default="false">
        <cfparam name="attributes.suppressOfficesLink" default="false">
        <cfparam name="attributes.proximityOverride" type="string" default="">
        <cfparam name="attributes.county_id" type="numeric" default="0">
        <cfparam name="attributes.google" type="boolean" default="false">
        <cfparam name="attributes.wrapUrl" type="boolean" default="false">--->

        <cfif not structKeyExists(params,"proximityOverride")>
            <cfset params.proximityOverride = "">
        </cfif>

        <cfif not structKeyExists(params,"zipcode")>
            <cfset params.zipcode = "">
        </cfif>

        <cfif not structKeyExists(params,"radius")>
            <cfset params.radius = 100>
        </cfif>
    </cffunction>

    <cffunction name="proximityCountyOverride">
        <cfargument name="entryPointGroup">

        <cfset ep=ormExecuteQuery("select ep, 999999 from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.counties c where epepg.entry_point_group=? and ep.active_flag=1 and c.id=? order by distance",[entryPointGroup, params.countyId])>

        <cfif arraylen(ep) eq 0>
            <cfset var success = false>
        <cfelse>
            <cfset var success = true>
            <cfloop array="#ep#" index="epi">
                <cfset arrayAppend(retVal,this.formatEntryPoint(epi[1]))>
            </cfloop>
        </cfif>
        <cfset methodSucceeded = success>
    </cffunction>

    <cffunction name="proximityLocal">
        <cfargument name="entryPointGroup">

        <cfset zip = entityLoadByPK("zip",params.zipCode)>
        <cfif isNull(zip)>
            <cfset methodSucceeded = false>
            <cfreturn>
        </cfif>
        <cfset st = zip.getState()>

        <cfset ep=ormExecuteQuery("select ep,zd.distance from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.view_zip_distance zd
         where ep.active_flag=1 and epepg.entry_point_group=? and zd.start_state_id=zd.end_state_id and zd.end_zipcode=?",[entryPointGroup, params.zipCode])>

        <cfset ep1 = ormExecuteQuery("select ep, 999999 as distance from entry_point_entry_point_group epepg join epepg.entry_point ep
         where ep.active_flag=1 and ep.zipcode is null and ep.state =? and epepg.entry_point_group=?",[st, entryPointGroup])>

        <cfset arrayAppend(ep,ep1,true)>

        <cfif arraylen(ep) eq 0>
            <cfset var success = false>
        <cfelse>
            <cfset var success = true>
            <cfloop array="#ep#" index="epi">
                <cfset arrayAppend(retVal,this.formatEntryPoint(epi[1]))>
            </cfloop>
        </cfif>
        <cfset methodSucceeded = success>
    </cffunction>

    <cffunction name="proximityCounty">
        <cfargument name="entryPointGroup">

        <cfif params.zipcode eq "">
            <cfreturn>
        </cfif>

        <cfset ep=ormExecuteQuery("select ep,zd.distance from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.counties c join ep.view_zip_distance zd
         where ep.active_flag=1 and epepg.entry_point_group=? and zd.end_zipcode=? and c in (select c from zip z join z.county c where z.zipcode=?)",
                [entryPointGroup, params.zipcode, params.zipcode])>

        <cfset ep1 = ormExecuteQuery("select ep, 999999 as distance from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.counties c
         where ep.active_flag=1 and ep.zipcode is null and epepg.entry_point_group=? and c in (select c from zip z join z.county c where z.zipcode=?)",
                [entryPointGroup, params.zipcode])>

        <cfset arrayAppend(ep,ep1,true)>


        <cfif arraylen(ep) eq 0>
            <cfset var success = false>
        <cfelse>
            <cfset var success = true>
            <cfloop array="#ep#" index="epi">
                <cfset arrayAppend(retVal,this.formatEntryPoint(epi[1]))>
            </cfloop>
        </cfif>
        <cfset methodSucceeded = success>
    </cffunction>

    <cffunction name="proximityCity">
        <cfargument name="entryPointGroup">

        <cfset zip = entityLoadByPK("zip",params.zipCode)>
        <cfif isNull(zip)>
            <cfset methodSucceeded = false>
            <cfreturn>
        </cfif>

        <cfif arraylen(zip.getPrefered_cities()) neq 0>
            <cfset ep=ormExecuteQuery("select ep,zd.distance from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.cities c join ep.view_zip_distance zd
                   where ep.active_flag=1 and epepg.entry_point_group=? and zd.end_zipcode=? and c=?",[entryPointGroup, params.zipcode, zip.getPrefered_cities()[1]])>

            <cfset ep1 = ormExecuteQuery("select ep, 999999 as distance from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.cities c
                   where ep.active_flag=1 and ep.zipcode is null and epepg.entry_point_group=? and c=?",[entryPointGroup, zip.getPrefered_cities()[1]])>

            <cfset arrayAppend(ep,ep1,true)>
        </cfif>

        <cfif arraylen(ep) eq 0>
            <cfset success = false>
        <cfelse>
            <cfset success = true>
            <cfloop array="#ep#" index="epi">
                <cfset arrayAppend(retVal,this.formatEntryPoint(epi[1]))>
            </cfloop>
        </cfif>

        <cfset methodSucceeded = success>
    </cffunction>

    <cffunction name="proximityZip">
        <cfargument name="entryPointGroup">

        <cfif params.zipcode eq "">
            <cfreturn>
        </cfif>

        <cfset ep=ormExecuteQuery("select ep,zd.distance from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.zips z join ep.view_zip_distance zd
               where ep.active_flag=1 and epepg.entry_point_group=? and z.zipcode=? and zd.end_zipcode=?",[entryPointGroup, params.zipcode, params.zipcode])>

        <cfset ep1 = ormExecuteQuery("select ep, 999999 as distance from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.zips z
               where ep.active_flag=1 and ep.zipcode is null and epepg.entry_point_group=? and z.zipcode=?",[entryPointGroup, params.zipcode])>

        <cfset arrayAppend(ep,ep1,true)>

        <cfif arraylen(ep) eq 0>
            <cfset var success = false>
        <cfelse>
            <cfset var success = true>
            <cfloop array="#ep#" index="epi">
                <cfset arrayAppend(retVal,this.formatEntryPoint(epi[1]))>
            </cfloop>
        </cfif>
        <cfset methodSucceeded = success>
    </cffunction>

    <cffunction name="proximityRadius">
        <cfargument name="entryPointGroup">

        <cfset zip = entityLoadByPK("zip",params.zipCode)>

        <cfif isNull(zip)>
            <cfset methodSucceeded = false>
            <cfreturn>
        </cfif>

        <cfset st = zip.getState()>

        <cfset ep=ormExecuteQuery("select ep from entry_point_entry_point_group epepg join epepg.entry_point ep join ep.view_zip_distance zd
         where ep.active_flag=1 and epepg.entry_point_group=? and zd.start_state_id = ? and zd.end_zipcode=? and zd.distance=?",[entryPointGroup, st, params.zipcode, params.radius])>

        <cfif arraylen(ep) eq 0>
            <cfset var success = false>
        <cfelse>
            <cfset var success = true>
            <cfloop array="#ep#" index="epi">
                <cfset arrayAppend(retVal,this.formatEntryPoint(epi))>
            </cfloop>
        </cfif>
        <cfset methodSucceeded = success>
    </cffunction>

    <cffunction name="formatEntryPoint">
        <cfargument name="entryPoint">
        <!---select e.code, e.name, e.subname, e.address1, e.address2, e.address3,
        e.city, e.state_id, e.zipcode, e.zipcode_plus4, e.email, e.url,
        e.contact_title, e.contact_first, e.contact_middle, e.contact_last,
        e.contact_suffix, dh.display_code hours_code, di.display_code info_code
        from entrypoint e left outer join display dh
        on e.hours_display_id=dh.display_id
        left outer join display di
        on e.info_display_id=di.display_id
        where e.entrypoint_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.entrypoint_id#" maxlength="6">
		and e.active_flag=1--->

        <cfset outstr = "<b>#entryPoint.getName()#</b><br />">

        <cfif not isNull(entryPoint.getSub_name())>
            <cfset outstr = outstr & "#entryPoint.getSub_name()#<br />">
        </cfif>

        <cfif not isNull(entryPoint.getAddress1())>
            <cfset outstr = outstr & "#entryPoint.getAddress1()#<br />">
        </cfif>

        <cfif not isNull(entryPoint.getAddress2())>
            <cfset outstr = outstr & "#entryPoint.getAddress2()#<br />">
        </cfif>

        <cfif not isNull(entryPoint.getAddress3())>
            <cfset outstr = outstr & "#entryPoint.getAddress3()#<br />">
        </cfif>

        <cfif not isNull(entryPoint.getCity()) and not isNull(entryPoint.getState())>
            <cfset outstr = outstr & "#entryPoint.getCity()#, #entryPoint.getState().getId()#">
            <cfif not isNull(entryPoint.getZipcode())>
                <cfset outstr = outstr & " #entryPoint.getZipcode()#">
                <cfif not isNull(entryPoint.getZipcode_plus4()) and trim(entryPoint.getZipcode_plus4()) neq ''>
                    <cfset outstr = outstr & "-#entryPoint.getZipcode_plus4()#">
                </cfif>
            </cfif>
            <cfset outstr = outstr & "<br />">
        </cfif>

        <cfloop array="#entryPoint.getPhones()#" index="ind">
            <cfset outstr = outstr & "#ind.getPhone_type().getDisplay().getDisplay_text()#: #ind.getNumber()#<br/>">
        </cfloop>

        <cfif not isNull(entryPoint.getEmail())>
            <cfset outstr = outstr & "Email: <a href=""mailto:#entryPoint.getEmail()#"">#entryPoint.getEmail()#</a><br />">
        </cfif>

        <cfif not isNull(entryPoint.getUrl())>
            <cfset outstr = outstr & "Website: <a href=""#entryPoint.getUrl()#"" target=""_blank"">#entryPoint.getUrl()#</a><br />">
        </cfif>

        <!--- <cfif not isNull(entryPoint.getHours_display())>
            <cf_displayText group="ephours" code="#ep.hours_code#" stripTags="#isPrintMode#" var="ephours" alt="&nbsp;">
            <cfif ephours neq '' and ephours neq '&nbsp;'>
                <cf_displayText group="site" code="site_ep_hours" var="eptext">
                <cfset outstr = outstr & "#eptext#: #ephours#<br />">
            </cfif>
        </cfif>

        <cfif ep.contact_title neq '' or ep.contact_first neq '' or ep.contact_middle neq '' or ep.contact_last neq '' or ep.contact_suffix neq ''>
            <cf_displayText group="site" code="site_ep_contact" var="eptext">
            <cfset outstr = outstr & "#eptext#: #ep.contact_title# #ep.contact_first# #ep.contact_middle# #ep.contact_last# #ep.contact_suffix#<br />">
        </cfif>

        <cfif ep.info_code neq ''>
            <cf_displayText group="epinfo" code="#ep.info_code#" stripTags="#isPrintMode#" var="epinfo" alt="&nbsp;">
            <cfif epinfo neq '' and epinfo neq '&nbsp;'>
                <cf_displayText group="site" code="site_ep_more_info" var="eptext">
                <cfset outstr = outstr & "#eptext#: #epinfo#<br />">
            </cfif>
        </cfif>--->


        <cfset var rtVl = structNew()>
        <cfset rtVl["code"] = entryPoint.getCode()>
        <cfset rtVl["print_name"] = outstr>
        <cfset rtVl["name"] = entryPoint.getName()>
        <cfset rtVl["subname"] = entryPoint.getSub_name()>
        <cfset rtVl["address1"] = entryPoint.getAddress1()>
        <cfset rtVl["address2"] = entryPoint.getAddress2()>
        <cfset rtVl["address3"] = entryPoint.getAddress3()>
        <cfset rtVl["city"] = entryPoint.getCity()>

        <cfif isnull(entryPoint.getState())>
            <cfset rtVl["state"] = "">
        <cfelse>
            <cfset rtVl["state"] = entryPoint.getState().getId()>
        </cfif>

        <cfset rtVl["zipcode"] = entryPoint.getZipcode()>
        <cfset rtVl["zipcode_plus4"] = entryPoint.getZipcode_plus4()>
        <cfset rtVl["email"] = entryPoint.getEmail()>
        <cfset rtVl["url"] = entryPoint.getUrl()>
        <cfset rtVl["contact_title"] = entryPoint.getContact_title()>
        <cfset rtVl["contact_first"] = entryPoint.getContact_first()>
        <cfset rtVl["contact_middle"] = entryPoint.getContact_middle()>
        <cfset rtVl["contact_last"] = entryPoint.getContact_last()>
        <cfset rtVl["contact_suffix"] = entryPoint.getContact_suffix()>

        <cfif isnull(entryPoint.getHours_display())>
            <cfset rtVl["hours"] = "">
        <cfelse>
            <cfset rtVl["hours"] = entryPoint.getHours_display().getDisplay_text()>
        </cfif>

        <cfif isnull(entryPoint.getInfo_display())>
            <cfset rtVl["info"] = "">
        <cfelse>
            <cfset rtVl["info"] = entryPoint.getInfo_display().getDisplay_text()>
        </cfif>
        <cfset rtVl["phones"] = arrayNew(1)>
        <cfloop array="#entryPoint.getPhones()#" index="ind">
            <cfset phone = structNew()>
            <cfset phone["number"] = ind.getNumber()>
            <cfset phone["type"] = ind.getPhone_type().getDisplay().getDisplay_text()>
            <cfset arrayAppend(rtVl["phones"],phone)>
        </cfloop>

        <cfreturn rtVl>
    </cffunction>

</cfcomponent>