<cfcomponent rest="true" restpath="/findPrograms">
    <cfset categories = structNew()>
    <cfset categories['bcuqc_category_income'] = ["income"]>
    <cfset categories['bcuqc_category_medicaid'] = ["medicaid"]>
    <cfset categories['bcuqc_category_rx'] = ["medicare","medications"]>
    <cfset categories['bcuqc_category_property_taxrelief'] = ["taxrelief","taxrelief_other"]>
    <cfset categories['bcuqc_category_veteran'] = ["veteran"]>
    <cfset categories['bcuqc_category_nutrition'] = ["nutrition"]>
    <cfset categories['bcuqc_category_foodsupp'] = ["foodsupp"]>
    <cfset categories['bcuqc_category_utility'] = ["utility"]>

    <cffunction name="categoriesToGroups" returnType="String">
        <cfset groupBy = "">
        <cfset groupByCount = 0>

        <cfloop collection="#categories#" item="cat">
            <cfloop array="#categories[cat]#" index="category">
                <cfset groupBy="#groupBy# case when pc.code = '#category#' then '#cat#' else">
                <cfset groupByCount = groupByCount + 1>
            </cfloop>
        </cfloop>

        <cfset groupBy = "#groupBy# '' end">

        <cfloop index = "LoopCount" from="1" to="#groupByCount-1#" step="1">
            <cfset groupBy = "#groupBy# end">
        </cfloop>

        <cfreturn groupBy>
    </cffunction>

    <cffunction name="calcForPrescreen">
        <cfargument name="screeningId">
        <cfset screening = entityLoadByPK("screening",screeningId)>

        <cfset screening_answers = ormexecutequery("select distinct a.code from screening_answerfield sa join sa.answer a where sa.screening=?",[screening])>

        <cfset programsByCategories = structNew()>

        <cfset filter = "''">

        <cfloop array="#screening_answers#" index="answerCode">
            <cfif structKeyExists(categories,answerCode)>
                <cfloop array="#categories[answerCode]#" index="category">
                    <cfset filter="#filter#,'#category#'">
                </cfloop>
            </cfif>
        </cfloop>

        <cfset filter = "(#filter#)">

        <cfset programs = ormExecuteQuery("select p from program p join p.program_category pc where pc.code in #filter# and p.state=? and p.active_flag=1",[screening.getPreset_state()])>

        <cftransaction>
           <cfloop array="#programs#" index="program">
                <cfset sp = entityNew("screening_program")>
                <cfset sp.setScreening(screening)>
                <cfset sp.setProgram(program)>
                <cfset sp.setUnseen_flag(0)>
                <cfset sp.setBuffer_flag(0)>
                <cfset sp.setMaybe_flag(0)>
                <cfset entitySave(sp)>
            </cfloop>
        </cftransaction>
    </cffunction>

    <cffunction name="calculatedForScreening" access="remote" restpath="/calculatedForScreening/{screeningId}" returnType="String" httpMethod="GET">
        <cfargument name="screeningId" required="true" restargsource="Path" type="numeric"/>

        <cfset screening = entityLoadByPK("screening",screeningId)>

        <cfset programs = ormExecuteQuery("select p,#this.categoriesToGroups()# as category from screening_program sp join sp.program p join p.program_category pc where sp.screening=?",[screening])>


        <cfset programsByCategories = structNew()>

        <cfloop array="#programs#" index="i">
            <cfif structKeyExists(programsByCategories,i[2])>
                <cfset programsByCategories[i[2]].count = programsByCategories[i[2]].count + 1>
                <cfset arrayAppend(programsByCategories[i[2]].programs,i[1].toStructure())>
            <cfelse>
                <cfset programsByCategories[i[2]] = structNew()>
                <cfset programsByCategories[i[2]]["count"] = 1>
                <cfset programsByCategories[i[2]]["programs"] = arrayNew(1)>
                <cfset arrayAppend(programsByCategories[i[2]].programs,i[1].toStructure())>
            </cfif>
        </cfloop>

        <cfset retVal = arrayNew(1)>

        <cfloop collection="#programsByCategories#" item="category">
            <cfset categoryItem = structNew()>
            <cfset categoryItem['category'] = category>
            <cfset categoryItem['count'] = programsByCategories[category].count>
            <cfset categoryItem['programs'] = programsByCategories[category].programs>
            <cfset arrayAppend(retVal,categoryItem)>
        </cfloop>

        <cfreturn serializeJSON(retVal)>
    </cffunction>

    <cffunction name="programsForPrescreen" access="remote" restpath="/forPrescreen/{screeningId}" returnType="String" httpMethod="GET">
        <cfargument name="screeningId" required="true" restargsource="Path" type="numeric"/>

        <cfset screening = entityLoadByPK("screening",screeningId)>

        <cfset programsByCategories = structNew()>

        <cfset filter = "''">
        <cfset groupBy = "">
        <cfset groupByCount = 0>

        <cfloop collection="#categories#" item="answerCode">
            <cfif structKeyExists(categories,answerCode)>
                <cfset programsByCategories[answerCode] = structNew()>
                <cfset programsByCategories[answerCode]["count"] = 0>
                <cfset programsByCategories[answerCode]["programs"] = arrayNew(1)>
                <cfloop array="#categories[answerCode]#" index="category">
                    <cfset filter="#filter#,'#category#'">
                </cfloop>
            </cfif>
        </cfloop>

        <cfset filter = "(#filter#)">

        <cfset groupedByCategories = ormExecuteQuery("select p, #this.categoriesToGroups()# as category from program p join p.program_category pc where pc.code in #filter# and p.state=? and p.active_flag=1 order by 2,p.sort",[screening.getPreset_state()])>

        <cfloop array="#groupedByCategories#" index="i">
            <cfset programsByCategories[i[2]].count = programsByCategories[i[2]].count + 1>
            <cfset arrayAppend(programsByCategories[i[2]].programs,i[1].toStructure())>
        </cfloop>

        <cfset retVal = arrayNew(1)>

        <cfloop collection="#programsByCategories#" item="category">
            <cfset categoryItem = structNew()>
            <cfset categoryItem['category'] = category>
            <cfset categoryItem['count'] = programsByCategories[category].count>
            <cfset categoryItem['programs'] = programsByCategories[category].programs>
            <cfset arrayAppend(retVal,categoryItem)>
        </cfloop>

        <cfreturn serializeJSON(retval)>

    </cffunction>

    <cffunction name="calcForScreening" access="remote" restpath="/calcForScreening/{screeningId}" returnType="String" httpMethod="GET">
        <cfargument name="screeningId" required="true" restargsource="Path" type="numeric"/>
        <cfset pf = createObject("component","bcu.ProgramFinder")>
        <cfset retVal = pf.proceligibilityByScreening(screeningId,false,0,'Y')>
        <cfreturn retVal>
    </cffunction>



</cfcomponent>
