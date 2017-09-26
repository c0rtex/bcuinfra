<cfcomponent rest="true" restpath="/forms">

    <cffunction name="forProgram" access="remote" restpath="/appForms/forProgram/{programCode}" returnType="String" httpMethod="GET">
        <cfargument name="programCode" required="true" restargsource="Path" type="string"/>
        <cfargument name="stateId" required="false" restargsource="Query" default="" type="string"/>

        <!---SELECT ft.string, t.tag_name,f.form_id
        FROM program_form pf, form f, form_formtype ft, formtag t
        WHERE pf.program_id=2519
        AND pf.form_id=f.form_id
        AND f.form_id=ft.form_id
        AND ft.active=1
        AND f.formtag_id=t.formtag_id
        ORDER BY pf.sort--->

        <cfset retVal = arrayNew(1)>

        <cfset pobj = entityload("program",{code=programCode})>

        <cfif (arraylen(pobj) neq 0)>
            <cfset pobj = pobj[1]>
        <cfelse>
            <cfreturn serializeJSON(retVal)>
        </cfif>

        <cfset state = entityLoadByPK("state",stateId)>

        <cfif !isNull(state)>
            <cfset forms = ormExecuteQuery("select fft.string,
                                                   ft.name,
                                                   f.id,
                                                   ftp.code
                                            from program_form pf join
                                                 pf.form f join
                                                 f.form_form_types fft join
                                                 f.form_tag ft join
                                                 fft.form_type ftp
                                            where pf.program=?
                                                  and ftp.id in (1,3,4)
                                                  and fft.active=1 and (f.state=? or f.state is null)
					    ORDER BY pf.sort",[pobj,state])>
        <cfelse>
            <cfset forms = ormExecuteQuery("select fft.string,
                                                   ft.name,
                                                   f.id,
                                                   ftp.code
                                            from program_form pf join
                                                 pf.form f join
                                                 f.form_form_types fft join
                                                 f.form_tag ft join
                                                 fft.form_type ftp
                                            where pf.program=?
                                                  and ftp.id in (1,3,4)
                                                  and fft.active=1
					    ORDER BY pf.sort",[pobj])>
        </cfif>

        <cfloop array="#forms#" index="i">
            <cfset item = structNew()>
            <cfset item["url"] = i[1]>
            <cfset item["caption"] = i[2]>
            <cfset item["id"] = i[3]>
            <cfset item["type"] = i[4]>
            <cfset arrayAppend(retVal,item)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>

    <cffunction name="resources" access="remote" restpath="/resources/{category}/{stateId}" returntype="String" httpMethod="GET">
        <cfargument name="category" required="true" restargsource="Path" type="string"/>
        <cfargument name="stateId" required="true" restargsource="Path" type="string"/>
        <cfset var rs = ormexecutequery("select
                                           ftg.name,
                                           p.name_display,
                                           fft.string
                                         from
                                           form f join
                                           f.form_tag ftg join
                                           f.form_form_types fft join
                                           f.program_forms pf join
                                           pf.program p join
                                           p.program_category pc join
                                           pc.super_category psc
                                         where
                                           fft.form_type.id<>2 and
                                           (p.active_flag =0 or p.active_flag is null) and
                                           f.state.id=? and
                                           psc.answerfieldcode=?
                                         order by
                                           p.sort,pf.sort",[stateId,category])>

        <cfset var retVal = arrayNew(1)>

        <cfloop array="#rs#" index="i">
            <cfset item = structNew()>
            <cfset item["prg_nm"] = i[2].getDisplay_text()>
            <cfset item["tag_name"] = this.formatField(i,1)>
            <cfset item["string"] = this.formatField(i,3)>
            <cfset arrayAppend(retVal,item)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>

    </cffunction>

    <cffunction name="qryForms" access="remote" restpath="/qryForms/{category}" returntype="String" httpMethod="GET">
        <cfargument name="category" required="true" restargsource="Path" type="string"/>
        <cfargument name="stateId" required="false" restargsource="Query" default="" type="string"/>
        <cfargument name="ecPrgList" required="false" restargsource="Query" default="" type="string"/>
        <cfargument name="sortorder" required="false" restargsource="Query" default="" type="string"/>

        <cfset plQuery = "select distinct(f.id),tpa.rec_id,tpa.prg_id,tpa.prg_nm,f.state.id,f.name,ft.code,ftg.name,fft.string,fft.entry_date,fft.form_date,tpa.cat_id,ft.id,tpa.st,pf.sort from form f join f.form_form_types fft join fft.form_type ft join f.program_forms pf join pf.program p join p.tbl_prg_all tpa join f.form_tag ftg join tpa.subset_program_bases sp">
        <cfset plQuery = "#plQuery# where ft.id<>2 and (tpa.inactive_flag =0 or tpa.inactive_flag is null)">

        <cfif category EQ 'PAP'>
            <cfset plQuery = "#plQuery# and sp.subset.id=19">
            <cfset plQuery = "#plQuery# and tpa.cat_id = 331">
        <cfelseif category EQ 'MSP'>
            <cfset plQuery = "#plQuery# and sp.subset.id=1">
            <cfset plQuery = "#plQuery# and tpa.cat_id = 309">
        <cfelseif category EQ 'QMB'>
            <cfset plQuery = "#plQuery# and sp.subset.id=1">
            <cfset plQuery = "#plQuery# and (tpa.prg_id = '103-309-1031-FD-FD' or tpa.prg_id = '103-309-2681-AZ-ST')">
        <cfelseif category EQ 'QI'>
            <cfset plQuery = "#plQuery# and sp.subset.id=1">
            <cfset plQuery = "#plQuery# and (tpa.prg_id = '103-309-1071-FD-FD' or tpa.prg_id = '103-309-2683-AZ-ST')">
        <cfelseif category EQ 'SLMB'>
            <cfset plQuery = "#plQuery# and sp.subset.id=1">
            <cfset plQuery = "#plQuery# and (tpa.prg_id = '103-309-1032-FD-FD' or tpa.prg_id = '103-309-2682-AZ-ST')">
        <cfelseif category EQ 'MEDAPROV'>
            <cfset plQuery = "#plQuery# and sp.subset.id=12">
        <cfelseif category EQ 'MED'>
            <cfset plQuery = "#plQuery# and sp.subset.id=8">
        <cfelseif category EQ 'OTH'>
            <cfset plQuery = "#plQuery# and sp.subset.id=1">
            <cfset plQuery = "#plQuery# and tpa.cat_id = 332">
        <cfelseif category EQ 'STRX'>
            <cfset plQuery = "#plQuery# and sp.subset.id=9">
        <cfelseif category EQ 'Entered' or category EQ 'PUB'>
            <cfset plQuery = "#plQuery# and sp.subset.id=1">
        <cfelseif stateId neq ''>
            <cfset plQuery = "#plQuery# and sp.subset.id=1">
            <cfset plQuery = "#plQuery# and (f.state.id = '#stateId#')">
        </cfif>


        <cfif category EQ 'DRUG'>
            <cfif len(ecPrgList) gt 1 >
                <cfset plQuery = "#plQuery# and (sp.subset.id=1 or sp.subset.id=19)">
                <cfset plQuery = "#plQuery# and tpa.prg_id IN (#preserveSingleQuotes(ecPrgList)#)">
            <cfelse>
                <cfset plQuery = "#plQuery# and sp.subset.id=10000">
            </cfif>
        </cfif>

        <cfif sortorder neq '' and sortby neq ''>
            <cfset plQuery = "#plQuery# order by #sortby# #sortorder#, pf.sort">
        <cfelseif stateId neq '' >
            <cfset plQuery = "#plQuery# order by tpa.prg_nm,tpa.cat_id, pf.sort">
        <cfelseif category eq 'PUB' or category eq 'ENTERED'>
            <cfset plQuery = "#plQuery# order by  tpa.prg_nm, pf.sort">
        <cfelseif category eq 'DRUG'>
            <cfset plQuery = "#plQuery# order by tpa.cat_id asc, tpa.prg_nm, pf.sort">
        <cfelseif category EQ 'SLMB' or category EQ 'QMB' or category EQ 'QI' or category EQ 'MED' or category EQ 'MSP' or category EQ 'STRX'>
            <cfset plQuery = "#plforidQuery# order by tpa.st, tpa.prg_nm, pf.sort">
        <cfelse>
            <cfset plQuery = "#plQuery# order by tpa.prg_nm, pf.sort">
        </cfif>

        <cfset rs = ormExecuteQuery(plQuery)>
        <cfset retVal = arrayNew(1)>

        <cfloop array="#rs#" index="i">
            <cfset item = structNew()>
            <cfset item["form_id"] = this.formatField(i,1)>
            <cfset item["recid"] = this.formatField(i,2)>
            <cfset item["prg_id"] = this.formatField(i,3)>
            <cfset item["prg_nm"] = this.formatField(i,4)>
            <cfset item["form_st"] = this.formatField(i,5)>
            <cfset item["form_name"] = this.formatField(i,6)>
            <cfset item["type_code"] = this.formatField(i,7)>
            <cfset item["tag_name"] = this.formatField(i,8)>
            <cfset item["string"] = this.formatField(i,9)>
            <cfset item["entry_date"] = dateFormat(this.formatField(i,10),'yyyy-mm-dd')>
            <cfset item["form_date"] = dateFormat(this.formatField(i,11),'yyyy-mm-dd')>
            <cfset item["cat_id"] = this.formatField(i,12)>
            <cfset item["formtype_id"] = this.formatField(i,13)>
            <cfset item["program_st"] = this.formatField(i,14)>
            <cfset item["sort"] = this.formatField(i,15)>
            <cfset arrayAppend(retVal,item)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>

    <cffunction name="formatField">
        <cfargument name="rsi">
        <cfargument name="index">
        <cfif arrayIsDefined(rsi,index)>
            <cfreturn rsi[index]>
        <cfelse>
            <cfreturn "">
        </cfif>
    </cffunction>

</cfcomponent>