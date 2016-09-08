<cfcomponent rest="true" restpath="/forms">

    <cffunction name="forProgram" access="remote" restpath="/appForms/forProgram/{programCode}/" returnType="String" httpMethod="GET">
        <cfargument name="programCode" required="true" restargsource="Path" type="string"/>

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

        <cfset forms = ormExecuteQuery("select fft.string,
                                               ft.name,
                                               f.id
                                        from program_form pf join
                                             pf.form f join
                                             f.form_form_types fft join
                                             f.form_tag ft
                                        where pf.program=? and
                                              fft.active=1",[pobj])>

        <cfloop array="#forms#" index="i">
            <cfset item = structNew()>
            <cfset item["url"] = i[1]>
            <cfset item["caption"] = i[2]>
            <cfset arrayAppend(retVal,item)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>

</cfcomponent>