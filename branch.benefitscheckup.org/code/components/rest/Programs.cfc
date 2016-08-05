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

    <cffunction name="getExisting" access="remote" restpath="/forPrescreen/{screeningId}" returnType="String" httpMethod="GET">
        <cfargument name="screeningId" required="true" restargsource="Path" type="numeric"/>

        <cfset screening = entityLoadByPK("screening",screeningId)>

        <cfset screening_answers = ormexecutequery("select distinct a.code from screening_answerfield sa join sa.answer a where sa.screening=?",[screening])>

        <cfset programsByCategories = structNew()>

        <cfset filter = "''">
        <cfset groupBy = "">
        <cfset groupByCount = 0>

        <cfloop array="#screening_answers#" index="answerCode">
            <cfif structKeyExists(categories,answerCode)>
                <cfset programsByCategories[answerCode] = structNew()>
                <cfset programsByCategories[answerCode]["count"] = 0>
                <cfset programsByCategories[answerCode]["programs"] = arrayNew(1)>
                <cfloop array="#categories[answerCode]#" index="category">
                    <cfset filter="#filter#,'#category#'">
                    <cfset groupBy="#groupBy# case when pc.code = '#category#' then '#answerCode#' else">
                    <cfset groupByCount = groupByCount + 1>
                </cfloop>
            </cfif>
        </cfloop>

        <cfset filter = "(#filter#)">
        <cfset groupBy = "#groupBy# '' end">
        <cfloop index = "LoopCount" from="1" to="#groupByCount-1#" step="1">
            <cfset groupBy = "#groupBy# end">
        </cfloop>

        <cfset groupedByCategories = ormExecuteQuery("select p, #groupBy# as category from program p join p.program_category pc where pc.code in #filter# and p.state=? order by 2,p.sort",[screening.getPreset_state()])>

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
</cfcomponent>
