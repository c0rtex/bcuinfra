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
                                                  and ftp.id in (1,4)
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
                                                  and ftp.id in (1,4)
                                                  and fft.active=1
					    ORDER BY pf.sort",[pobj])>
        </cfif>

        <cfloop array="#forms#" index="i">
            <cfset item = structNew()>
            <cfset item["url"] = i[1]>
            <cfset item["caption"] = i[2]>
            <cfset item["type"] = i[4]>
            <cfset arrayAppend(retVal,item)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>

</cfcomponent>