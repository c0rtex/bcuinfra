<cfcomponent rest="true" restpath="/findPrograms">
    <cfset categories = structNew()>
    <cfset categories['bcuqc_category_income'] = ["income"]>
    <cfset categories['bcuqc_category_medicaid'] = ["medicaid"]>
    <cfset categories['bcuqc_category_rx'] = ["medicare","medications","rxco"]>
    <cfset categories['bcuqc_category_property_taxrelief'] = ["taxrelief","taxrelief_other"]>
    <cfset categories['bcuqc_category_veteran'] = ["veteran"]>
    <cfset categories['bcuqc_category_nutrition'] = ["nutrition"]>
    <cfset categories['bcuqc_category_foodsupp'] = ["foodsupp"]>
    <cfset categories['bcuqc_category_utility'] = ["utility"]>

    <cfset sa = structNew()>

    <cfset ynDoBuffer = false>

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

        <cfset programs = ormExecuteQuery("select p,#this.categoriesToGroups()# as category from screening_program sp join sp.program p join p.program_category pc where sp.screening=? order by p.key_program, p.sort",[screening])>


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

        <cfset groupedByCategories = ormExecuteQuery("select p, #this.categoriesToGroups()# as category from program p join p.program_category pc where pc.code in #filter# and p.state=? and p.active_flag=1 order by 2,p.sort",[sa.st])>

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

    <cffunction name="getIncomeTables">

        <cfif Not structKeyExists(sa,'no_hh_members') or sa.no_hh_members eq 0>
            <cfset sa.no_hh_members = 1>
        <cfelseif sa.no_hh_members GT 8>
            <cfset sa.no_hh_members = 8>
        </cfif>
        <cfset householdcount =  sa.no_hh_members>

        <cfif structKeyExists(sa,'hh_depend')>
            <cfset sa.hh_depend = val(sa.hh_depend)>
            <cfif sa.hh_depend eq "" or sa.hh_depend lt 1>
                <cfset sa.hh_depend = 1>
            <cfelseif sa.hh_depend GT 8>
                <cfset sa.hh_depend = 8>
            </cfif>
            <cfset dependcount = sa.hh_depend>
        <cfelse>
            <cfset dependcount = 1>
        </cfif>

        <cfif structKeyExists(sa,'no_hh_children')>
            <cfif sa.no_hh_children lt 1>
                <cfset childcount = 1>
            <cfelseif sa.no_hh_children gt 8>
                <cfset childcount = 8>
            <cfelse>
                <cfset childcount = sa.no_hh_children>
            </cfif>
        <cfelse>
            <cfset childcount = 1>
        </cfif>

        <cfset sec8 = ormExecuteQuery("select mem#householdcount# from tbl_inc t where t.tbl_nm=? and t.state=?",['Section 8',sa.st])>
        <cfset sec8table = sec8[1]>

        <cfset ph = ormExecuteQuery("select mem#householdcount# from tbl_inc t where t.tbl_nm=? and t.state=?",['Public Housing',sa.st])>
        <cfset PHtable = ph[1]>

        <cfset weather = ormExecuteQuery("select mem#householdcount# from tbl_inc t where t.tbl_nm=? and t.state=?",['WEATHER',sa.st])>
        <cfset WEATHERTABLE = weather[1]>

        <cfset liheap = ormExecuteQuery("select mem#householdcount# from tbl_inc t where t.tbl_nm=? and t.state=?",['LIHEAP',sa.st])>
        <cfset LIHEAPTABLE = liheap[1]>

        <cfset lasset = ormExecuteQuery("select mem#householdcount# from tbl_inc t where t.tbl_nm=? and t.state=?",['LASSET',sa.st])>
        <cfset LASSETTABLE = lasset[1]>

        <cfif childcount gt 0>
            <cfset tanf = ormExecuteQuery("select mem#childcount# from tbl_inc t where t.tbl_nm=? and t.state=?",['TANF',sa.st])>
            <cfset TANFTABLE = tanf[1]>
        <cfelse>
            <cfset TANFTABLE = 0>
        </cfif>

        <cfset build_income_array = ormExecuteQuery("SELECT mem#householdcount#, mem#dependcount#, mem#childcount#, proc_id FROM tbl_inc t WHERE t.tbl_nm not in ('liheap','lasset','weather','public housing','section 8','TANF') ORDER BY t.proc_id")>

        <cfset struct_mem = structNew()>
        <cfset listable = structNew()>
        <cfset childtable = structNew()>

        <cfloop array = "#build_income_array#" index="i">
            <cfset Result = StructInsert(struct_mem, i[4], i[1], "true")>
            <cfset Result = StructInsert(listable, i[4], i[2], "true")>
            <cfset Result = StructInsert(childtable, i[4], i[3], "true")>
        </cfloop>
    </cffunction>

    <cffunction name="ynMedicareBuyInAss">
        <cfargument name="self">
        <cfargument name="self_spouse">

        <cfset sa.s_asset_auto1 = ReReplace(sa.s_asset_auto1,'\.(.*)','','ALL')>
        <cfset sa.s_asset_auto1 = reReplaceNoCase(sa.s_asset_auto1, '[^[:digit:]]', '', 'ALL') >
        <cfset sa.s_asset_home = ReReplace(sa.s_asset_home,'\.(.*)','','ALL')>
        <cfset sa.s_asset_home = reReplaceNoCase(sa.s_asset_home, '[^[:digit:]]', '', 'ALL') >
        <cfset sa.s_asset_life_face = ReReplace(sa.s_asset_life_face,'\.(.*)','','ALL')>
        <cfset sa.s_asset_life_face = reReplaceNoCase(sa.s_asset_life_face, '[^[:digit:]]', '', 'ALL') >
        <cfset sa.s_asset_life_cash = ReReplace(sa.s_asset_life_cash,'\.(.*)','','ALL')>
        <cfset sa.s_asset_life_cash = reReplaceNoCase(sa.s_asset_life_cash, '[^[:digit:]]', '', 'ALL') >

        <cfset sa.s_asset_irrevocable = ReReplace(sa.s_asset_irrevocable,'\.(.*)','','ALL')>
        <cfset sa.s_asset_irrevocable = reReplaceNoCase(sa.s_asset_irrevocable, '[^[:digit:]]', '', 'ALL') >
        <cfset sa.s_asset_revocable = ReReplace(sa.s_asset_revocable,'\.(.*)','','ALL')>
        <cfset sa.s_asset_revocable = reReplaceNoCase(sa.s_asset_revocable, '[^[:digit:]]', '', 'ALL') >

        <cfset var strRule = rule>

        <cfif sa.marital_stat NEQ "married">
            <cfif sa.s_asset_life_face LTE 1500>
                <cfset exclusion = sa.s_asset_life_cash>
            <cfelse>
                <cfset exclusion = 0>
           </cfif>

            <cfset X = sa.s_asset_life_face + sa.s_asset_irrevocable>
            <cfset burialexclusion = MAX((1500-X),0)>
            <cfset exclusion2 = MIN(burialexclusion,sa.s_asset_revocable)>
            <cfset exclusion3 = sa.s_asset_auto1 + sa.s_asset_home>
            <cfset finalfigure = sa.s_asset_total_complete - (exclusion + exclusion2 + exclusion3)>
            <cfset valToCompare = self>
        <cfelseif sa.marital_stat EQ "married">
            <cfif sa.s_sp_asset_life_face LTE 1500>
                <cfset exclusion = sa.s_sp_asset_life_cash>
            <cfelse>
                <cfset exclusion = 0>
            </cfif>

            <cfif sa.s_sp_asset_life_face EQ ''>
                <cfset sa.s_sp_asset_life_face = 0>
            </cfif>

            <cfif sa.s_sp_asset_irrevocable EQ ''>
                <cfset sa.s_sp_asset_irrevocable = 0>
            </cfif>

            <cfset X = sa.s_sp_asset_life_face + sa.s_sp_asset_irrevocable>
            <cfset burialexclusion = MAX((1500-X),0)>

            <cfif sa.s_sp_asset_revocable GT burialexclusion>
                <cfif ynDoBuffer>
                    <cfset exclusion2 = sa.s_sp_asset_revocable - burialexclusion>
                <cfelse>
                    <cfset exclusion2 = burialexclusion>
                </cfif>
            <cfelse>
               <cfset exclusion2 = sa.s_sp_asset_revocable>
            </cfif>

            <cfif sa.s_sp_asset_auto1 EQ ''>
                <cfset sa.s_sp_asset_auto1 = 0>
            </cfif>

            <cfif sa.s_sp_asset_home EQ ''>
                <cfset sa.s_sp_asset_home = 0>
            </cfif>

            <cfif sa.s_sp_asset_total_complete EQ ''>
                <cfset sa.s_sp_asset_total_complete = 0>
            </cfif>

            <cfif exclusion EQ ''>
                <cfset exclusion = 0>
            </cfif>

            <cfif exclusion2 EQ ''>
                <cfset exclusion2 = 0>
            </cfif>

            <cfset exclusion3 = sa.s_sp_asset_auto1 + sa.s_sp_asset_home>

            <cfif exclusion3 EQ ''>
                <cfset exclusion3 = 0>
            </cfif>

            <cfset finalfigure = sa.s_sp_asset_total_complete - (exclusion + exclusion2 + exclusion3)>
            <cfset valToCompare = self_spouse>
        </cfif>

        <cfif finalfigure lte valToCompare>
            <cfreturn "YES">
        <cfelse>
            <cfreturn "NO">
        </cfif>
    </cffunction>

    <cffunction name="ynMedicareBuyInInc">
        <cfargument name="self_high">
        <cfargument name="self_low">
        <cfargument name="s_sp_high">
        <cfargument name="s_sp_low">

        <cfif not IsNumeric(self_high)>
            <cfset self_high = 0>
        </cfif>

        <cfif not IsNumeric(s_sp_high)>
            <cfset s_sp_high = 0>
        </cfif>

        <cfif not IsNumeric(self_low)>
            <cfset self_low = 0>
        </cfif>

        <cfif not IsNumeric(s_sp_low)>
            <cfset s_sp_low = 0>
        </cfif>

        <cfset table = FINDNOCASE("table", strRule, 1)>

        <cfif table EQ 0>
            <cfif ynDoBuffer>
                <cfset self_high = self_high+100>
                <cfset s_sp_high = s_sp_high+100>
                <cfset minFigure=0>
            <cfelse>
                <cfset self_high = self_high>
                <cfset s_sp_high = s_sp_high>
                <cfset minFigure=1>
            </cfif>

            <cfset self_low = self_low>
            <cfset s_sp_low = s_sp_low>

            <cfif sa.marital_stat NEQ 'married'>
                <cfset spouseEarnedIncome = 0>
                <cfset selfEarnedIncome = sa.S_INCOME_EARNED>
                <cfset unearnedIncome = sa.S_INCOME_TOTAL_UNEARNED>
                <cfset highfigure = self_high>
                <cfset lowfigure = self_low>
            <cfelse>
                <cfif sa.SP_INCOME_EARNED EQ ''>
                    <cfset sa.SP_INCOME_EARNED = 0>
                </cfif>

                <cfif sa.S_SP_INCOME_TOTAL_UNEARNED EQ ''>
                    <cfset sa.S_SP_INCOME_TOTAL_UNEARNED = 0>
                </cfif>

                <cfset spouseEarnedIncome = sa.SP_INCOME_EARNED>
                <cfset selfEarnedIncome = sa.S_SP_INCOME_EARNED - spouseEarnedIncome>
                <cfset unearnedIncome = sa.S_SP_INCOME_TOTAL_UNEARNED>
                <cfset highfigure = s_sp_high>
                <cfset lowfigure = s_sp_low>
            </cfif>

            <cfset selfEarnedIncomeAdjusted = MAX(((selfEarnedIncome - 65) / 2), minFigure)>
            <cfset finalfigure = spouseEarnedIncome + selfEarnedIncomeAdjusted + unearnedIncome>
            <cfif finalfigure LTE highfigure AND finalfigure GT lowfigure>
                <cfreturn "YES">
            <cfelse>
                <cfreturn "NO">
            </cfif>
        <cfelse>
            <cfset figure = MAX(((sa.S_SP_INCOME_EARNED - sa.SP_INCOME_EARNED - 65) / 2),0) + sa.SP_INCOME_EARNED>
            <cfif ynDoBuffer>
                <cfset figure = MAX((figure - 100),0)>
            </cfif>
            <cfreturn EVALUATE(ReplaceNoCase(rule, "BuyInQI2inc", figure, "ALL"))>
        </cfif>
    </cffunction>

    <cffunction name="compareSSILookup">
        <cfargument name="table" type="string">
        <cfargument name="state_id" type="string" default="FD">
        <cfargument name="count" type="numeric" default="1">
        <cfargument name="childIncome" type="numeric" default="0">
        <cfargument name="parentsIncome" type="numeric" default="0">
        <cfargument name="checkHighIncome" type="boolean" default="false">

        <cfif checkHighIncome and table neq 'child' and sa.skipinc EQ 'n'>
            <cfreturn 'NO'>
        <cfelse>
            <cfset totalIncome = childIncome + parentsIncome>
            <cfswitch expression="#table#">
                <cfcase value="child">
                    <cfset query = "select mem#count# from tbl_inc where">
                    <cfif state_id eq 'MA'>
                        <cfif sa.ch_blind eq 'y'>
                            <cfset query = "#query# tbl_nm=:tbl_nm">
                            <cfset tbl_nm = 'Child SSI - Child Only (blind)'>
                        <cfelse>
                            <cfset query = "#query# tbl_nm=:tbl_nm">
                            <cfset tbl_nm = 'Child SSI - Child Only (disabled)'>
                        </cfif>
                    <cfelse>
                        <cfset query = "#query# tbl_nm like :tbl_nm">
                        <cfset tbl_nm='Child SSI - Child Only%'>
                    </cfif>
                    <cfset inctab = ormExecuteQuery("#query# and state=:state",{tbl_nm=tbl_nm,state=state_id})>
                </cfcase>
                <cfcase value="single">
                    <cfset query = "select mem#count# from tbl_inc where">
                    <cfif state_id eq 'MA'>
                        <cfif sa.ch_blind eq 'y'>
                            <cfset query = "#query# tbl_nm=:tbl_nm">
                            <cfset tbl_nm = 'Child SSI - 1 Parent (blind)'>
                        <cfelse>
                            <cfset query = "#query# tbl_nm=:tbl_nm">
                            <cfset tbl_nm = 'Child SSI - 1 Parent (disabled)'>
                        </cfif>
                    <cfelse>
                        <cfset query = "#query# tbl_nm like :tbl_nm">
                        <cfset tbl_nm='Child SSI - 1 Parent%'>
                    </cfif>
                    <cfset inctab = ormExecuteQuery("#query# and state=:state",{tbl_nm=tbl_nm,state=state_id})>
                </cfcase>
                <cfcase value="married">
                    <cfset query = "select mem#count# from tbl_inc where">
                    <cfif state_id eq 'MA'>
                        <cfif sa.ch_blind eq 'y'>
                            <cfset query = "#query# tbl_nm=:tbl_nm">
                            <cfset tbl_nm = 'Child SSI - 2 Parent (blind)'>
                        <cfelse>
                            <cfset query = "#query# tbl_nm=:tbl_nm">
                            <cfset tbl_nm = 'Child SSI - 2 Parent (disabled)'>
                        </cfif>
                    <cfelse>
                        <cfset query = "#query# tbl_nm like :tbl_nm">
                        <cfset tbl_nm='Child SSI - 2 Parent%'>
                    </cfif>
                    <cfset inctab = ormExecuteQuery("#query# and state=:state",{tbl_nm=tbl_nm,state=state_id})>
                </cfcase>
            </cfswitch>
            <cfif totalIncome lte inctab[1][1]>
                <cfreturn 'YES'>
            <cfelse>
                <cfreturn 'NO'>
            </cfif>
        </cfif>
    </cffunction>

    <cffunction name="ynChildSSIInc">
        <cfargument name="checkState" default="false">

        <cfif sa.ch_income_earned eq ''>
            <cfset sa.ch_income_earned = 0>
        </cfif>

        <cfif sa.ch_income_total_unearned eq ''>
            <cfset sa.ch_income_total_unearned = 0>
        </cfif>

        <cfif sa.ch_income_child_support eq ''>
            <cfset sa.ch_income_child_support = 0>
        </cfif>

        <cfset childIncomeAdjusted = MAX(((sa.ch_income_earned - 65) / 2), 0) + sa.ch_income_total_unearned + (sa.ch_income_child_support * 0.66666667)>

        <cfif sa.ch_parent eq 'y'>
            <cfif sa.MARITAL_STAT EQ 'married'>
                <cfset spouseEarnedIncome = sa.SP_INCOME_EARNED>
                <cfset selfEarnedIncome = sa.S_SP_INCOME_EARNED - spouseEarnedIncome>
                <cfset unearnedIncomeAdjusted = sa.S_SP_INCOME_TOTAL_UNEARNED - sa.S_SP_INCOME_TANF - sa.S_SP_INCOME_CASH_ASSIST - sa.S_SP_INCOME_VET_BEN>
                <cfset tableToCheck = 'married'>
            <cfelse>
                <cfset spouseEarnedIncome = 0>
                <cfset selfEarnedIncome = sa.S_INCOME_EARNED>
                <cfset unearnedIncomeAdjusted = sa.S_INCOME_TOTAL_UNEARNED - sa.S_INCOME_TANF - sa.S_INCOME_CASH_ASSIST - sa.S_INCOME_VET_BEN>
                <cfset tableToCheck = 'single'>
            </cfif>
            <cfset selfEarnedIncomeAdjusted = MAX(((selfEarnedIncome - 65) / 2), 0)>
            <cfset parentsIncomeAdjusted = spouseEarnedIncome + selfEarnedIncomeAdjusted + unearnedIncomeAdjusted>
        <cfelse>
            <cfset parentsIncomeAdjusted = 0>
        </cfif>

        <cfset childcount = sa.no_hh_children>
        <cfif childcount eq '' or childcount lt 1>
            <cfset childcount = 1>
        <cfelseif childcount gt 8>
            <cfset childcount = 8>
        </cfif>

        <cfif checkState>
            <cfset passStateID = s.st>
        <cfelse>
            <cfset passStateID = 'FD'>
        </cfif>

        <cfif sa.ch_parent neq 'y'>
            <cfset result = this.compareSSILookup(table="child",state_id=passStateID,count=childcount,childIncome=childIncomeAdjusted)>
        <cfelseif sa.ch_guardian eq 'y' or sa.ch_other eq 'y'>
            <cfset result = this.compareSSILookup(table=tableToCheck,state_id=passStateID,count=childcount,childIncome=childIncomeAdjusted,parentsIncome=parentsIncomeAdjusted,checkHighIncome=true)>

            <cfif not result>
                <cfset result = this.compareSSILookup(table="child",state_id=passStateID,count=childcount,childIncome=childIncomeAdjusted)>
            </cfif>
        <cfelse>
            <cfset result = this.compareSSILookup(table=tableToCheck,state_id=passStateID,count=childcount,childIncome=childIncomeAdjusted,parentsIncome=parentsIncomeAdjusted,checkHighIncome=true)>
        </cfif>

        <cfreturn result>
    </cffunction>

    <cffunction name="ynSSIInc">
        <cfargument name="self">
        <cfargument name="self_spouse">

        <cfif ynDoBuffer>
            <cfset self = self + 100>
            <cfset self_spouse = self_spouse + 100>
        </cfif>

        <cfif sa.MARITAL_STAT EQ "married">
            <cfset spouseEarnedIncome = sa.SP_INCOME_EARNED>

            <cfif spouseEarnedIncome EQ ''>
                <cfset spouseEarnedIncome = 0>
            </cfif>

            <cfset selfEarnedIncome = sa.S_SP_INCOME_EARNED - spouseEarnedIncome>

            <cfif sa.S_SP_INCOME_TOTAL_UNEARNED EQ ''>
                <cfset sa.S_SP_INCOME_TOTAL_UNEARNED = 0>
            </cfif>

            <cfif sa.S_SP_INCOME_TANF EQ ''>
                <cfset sa.S_SP_INCOME_TANF = 0>
            </cfif>

            <cfif sa.S_SP_INCOME_CASH_ASSIST EQ ''>
                <cfset sa.S_SP_INCOME_CASH_ASSIST = 0>
            </cfif>

            <cfset unearnedIncomeAdjusted = sa.S_SP_INCOME_TOTAL_UNEARNED - sa.S_SP_INCOME_TANF - sa.S_SP_INCOME_CASH_ASSIST>
            <cfset valToCheck = self_spouse>
        <cfelse>
            <cfset spouseEarnedIncome = 0>

            <cfif sa.S_INCOME_EARNED eq "">
                <cfset sa.S_INCOME_EARNED = 0>
            </cfif>

            <cfif sa.S_INCOME_TOTAL_UNEARNED eq "">
                <cfset sa.S_INCOME_TOTAL_UNEARNED = 0>
            </cfif>

            <cfset selfEarnedIncome = sa.S_INCOME_EARNED>
            <cfset unearnedIncomeAdjusted = sa.S_INCOME_TOTAL_UNEARNED - sa.S_INCOME_TANF - sa.S_INCOME_CASH_ASSIST>
            <cfset valToCheck = self>
        </cfif>

        <cfset selfEarnedIncomeAdjusted = MAX(((selfEarnedIncome - 65) / 2),0)>

        <cfset finalFigure = spouseEarnedIncome + selfEarnedIncomeAdjusted + unearnedIncomeAdjusted>

        <cfif finalFigure lte valToCheck>
            <cfreturn "YES">
        <cfelse>
            <cfreturn "NO">
        </cfif>
    </cffunction>

    <cffunction name="ynPrgFind">
        <cfargument name="rule">

        <cfset var StrFullRule = replaceNoCase(rule,"session","sa","ALL")>

        <cfloop index="count" from="1" to="10">
            <cfset CharNumP = FindNoCase("prg",StrFullRule,1)>
            <cfif CharNumP EQ 0>
                <cfset temp = Evaluate("#StrFullRule#")>
                <cfreturn temp>
            </cfif>

            <cfset CharNumY = FindNoCase("Y'",StrFullRule,CharNumP)>
            <cfset CharNumN = FindNoCase("N'",StrFullRule,CharNumP)>

            <cfif CharNumY EQ 0>
                <cfset Criteria = "N">
                <cfset CharNumCrit = CharNumN>
            <cfelseif CharNumN EQ 0>
                <cfset Criteria = "Y">
                <cfset CharNumCrit = CharNumY>
            <cfelse>
                <cfif CharNumY GT CharNumN>
                    <cfset Criteria = "N">
                    <cfset CharNumCrit = CharNumN>
                <cfelse>
                    <cfset Criteria = "Y">
                    <cfset CharNumCrit = CharNumY>
                </cfif>
            </cfif>

            <cfset prgRule = LEFT(StrFullRule, CharNumCrit + 1)>
            <cfif CharNumP NEQ 1>
                <cfset StrToRemove = Left(StrFullRule, CharNumP - 1)>
                <cfset prgRule = Replace(prgRule, StrToRemove, "")>
            </cfif>

            <cfset var prg_id = LEFT(StrFullRule, CharNumCrit - 6)>
            <cfset StrToRemove = Left(StrFullRule, CharNumP + 2)>
            <cfset prg_id = Replace(prg_id, StrToRemove, "")>

            <cfset prg_id = ListQualify(prg_id, "'")>

            <cfset var tmp_prg_list = tmp_prg_list>

            <cfif NOT ynDoBuffer>
                <cfif ListFindNoCase(tmp_prg_list, prg_id) IS 0 >
                    <cfset strFind = "N">
                <cfelse>
                    <cfset strFind = "Y">
                </cfif>
            <cfelse>
                <cfif ListFindNoCase(tmp_prg_list, prg_id) IS 0 AND
                    ListFindNoCase(sa.prg_list, prg_id) IS 0>
                    <cfset strFind = "N">
                <cfelse>
                    <cfset strFind = "Y">
                </cfif>
            </cfif>

            <cfif strFind EQ criteria>
                <cfset evaluate = "0 EQ 0">
            <cfelse>
                <cfset evaluate = "1 EQ 0">
            </cfif>

           <cfset StrFullRule = Replace(StrFullRule, prgRule, evaluate)>
        </cfloop>
        <cfreturn Evaluate(StrFullRule)>
    </cffunction>

    <cffunction name="ynSpendDown">
        <cfargument name="rule">
        <cfargument name="EvaluateRule">

        <cfif Not structKeyExists(sa,'med_costs') Or sa.med_costs eq ''>
            <cfset sa.med_costs = 0>
        </cfif>

        <cfset selfEarnedIncomeAdjusted = MAX(((sa.S_SP_INCOME_EARNED - sa.SP_INCOME_EARNED - 65) / 2),0)>

        <cfif Not EvaluateRule>
            <cfset self = gettoken(Rule,2,"-")>
            <cfset self_spouse = gettoken(Rule,3,"-")>
            <cfif ynDoBuffer>
                <cfset self = self + 100>
                <cfset self_spouse = self_spouse + 100>
            </cfif>
            <cfif sa.MARITAL_STAT EQ "married">
                <cfset valToCheck = self_spouse>
                <cfset spouseEarnedIncome = sa.SP_INCOME_EARNED>
                <cfset selfUnearnedIncome = sa.S_SP_INCOME_TOTAL_UNEARNED>
            <cfelse>
                <cfset valToCheck = self>
                <cfset spouseEarnedIncome = 0>
                <cfset selfUnearnedIncome = sa.S_INCOME_TOTAL_UNEARNED>
            </cfif>
            <cfset adjustedIncome = spouseEarnedIncome + selfUnearnedIncome + selfEarnedIncomeAdjusted>
            <cfset finalfigure = adjustedIncome - sa.med_costs>
            <cfif finalfigure lte valToCheck>
                <cfreturn "YES">
            <cfelse>
                <cfreturn "NO">
            </cfif>
        <cfelse>
            <cfset selfIncomeAdjusted = (sa.S_SP_INCOME_TOTAL_UNEARNED - sa.SP_INCOME_TOTAL_UNEARNED) + selfEarnedIncomeAdjusted>
            <cfset rest_hh_income = sa.HH_INCOME_TOTAL_COMPLETE - (sa.S_SP_INCOME_TOTAL_COMPLETE - sa.SP_INCOME_TOTAL_COMPLETE)>
            <cfset adjustedIncome = selfIncomeAdjusted + rest_hh_income>
            <cfset finalfigure = adjustedIncome - sa.med_costs>

            <cfif ynDoBuffer>
                <cfset valStructMem = getToken(rule, 3, " ")>
                <cfif (valStructMem LT FinalFigure) AND (FinalFigure LT (valStructMem + 100))>
                    <cfreturn "YES">
                <cfelse>
                    <cfreturn "NO">
                </cfif>
            <cfelse>
                <cfreturn EVALUATE(ReplaceNoCase(Rule, "spenddowninc", finalfigure, "ALL"))>
            </cfif>
        </cfif>

    </cffunction>



    <cffunction name="testRules">
        <cfset this.getIncomeTables()>
        <cfset testPrograms = "">
        <cfset tmp_prg_list = ''>
        <cfset oldid = ''>
        <cfset test = ''>
        <cfset loopindex = 0>

        <cfset querySubsetProgram = ormexecutequery("select p from subset_program_sum sp join sp.program p where sp.subset=? and p.active_flag=? and (p.state is null or p.state.id=?) order by p.sort",[screening.getSubset(),1,sa.st])>

        <cfloop array="#querySubsetProgram#" index="i">
            <cfset loopindex = loopindex + 1>
            <cfset prg_id = i.getLegacy()>

            <cfif loopindex gt 1>
                <cfset test1 = FINDNOCASE("no", test, 1)>
                <cfif test neq "" and test1 EQ 0>
                    <cfset tmp_prg_list = ListAppend(tmp_prg_list, "'#oldid#'")>
                </cfif>
            </cfif>

            <cfif not ynDoBuffer or ListFind(sa.prg_list, "'#prg_id#'") eq 0>
                <cfset testProgram = ormexecutequery("select r from program_rule pr join pr.rule r where pr.program=?",[i])>

                <cfloop array="#testProgram#" index="rule">

                    <cfset strRule = Replace(rule.getRule_text(), "gteq", "gte", "ALL")>
                    <cfset strRule = Replace(strRule, "lteq", "lte", "ALL")>
                    <cfset strRule = Replace(strRule, "XX[" , "[", "ALL")>

                    <cfif FINDNOCASE("BuyInQI2asset", strRule, 1) NEQ 0>
                        <cfif structKeyExists(sa,'skipassets') and sa.skipassets EQ "n">
                            <cfset answer = "NO">
                        <cfelse>
                            <cfset answer = this.ynMedicareBuyInAss(gettoken(strRule,2,"-"),gettoken(strRule,3,"-"))>
                        </cfif>
                    <cfelseif FINDNOCASE("BuyInQI2inc", strRule, 1) NEQ 0>
                        <cfif structKeyExists(sa,'skipinc') and sa.skipinc EQ "n">
                            <cfset answer = "NO">
                        <cfelse>
                            <cfset answer = this.ynMedicareBuyInInc(gettoken(strRule,2,"-"),gettoken(strRule,3,"-"),gettoken(strRule,4,"-"),gettoken(strRule,5,"-"))>
                        </cfif>
                    <cfelseif FINDNOCASE("MXASSET", strRule, 1) NEQ 0>
                        <cfset strTable = Replace(strRule,"(","","ALL")>
                        <cfset strTable = Trim(ReplaceNoCase(strTable,"MXASSET)","","ALL"))>
                        <cfset getMxAssetVals = ormexecutequery("SELECT single, couple FROM tbl_mx_asset where state=? and tbl_nm=?",[screening.getPreset_state(),strTable])>

                        <cfif structKeyExists(sa,'skipassets') and sa.skipassets EQ "n">
                            <cfif getMxAssetVals[1][1] GTE 1000000>
                                <cfset answer = "YES">
                            <cfelse>
                                <cfset answer = "NO">
                            </cfif>
                        <cfelse>
                            <cfset answer = this.ynMedicareBuyInAss(getMxAssetVals[1][1],getMxAssetVals[1][2])>
                        </cfif>
                    <cfelseif FINDNOCASE("MXINCOME", strRule, 1) NEQ 0>
                        <cfif structKeyExists(sa,'skipinc') and sa.skipinc EQ "n">
                            <cfset answer = "NO">
                        <cfelse>
                            <cfset strTable = Replace(strRule,"(","","ALL")>
                            <cfset strTable = Trim(ReplaceNoCase(strTable,"MXINCOME)","","ALL"))>
                            <cfset getMxIncVals = ormexecutequery("SELECT single_max, single_min, couple_max, couple_min FROM tbl_mx_income WHERE state.id=? and tbl_nm=?",[sa.st,strTable])>
                            <cfset answer = this.ynMedicareBuyInInc(getMxIncVals[1][1],getMxIncVals[1][2],getMxIncVals[1][3],getMxIncVals[1][4])>
                        </cfif>
                    <cfelseif FINDNOCASE("childstatessiinc", strRule, 1) NEQ 0>
                        <cfset answer = this.ynChildSSIInc(checkState=true)>
                    <cfelseif FINDNOCASE("childssiinc", strRule, 1) NEQ 0>
                        <cfset answer = this.ynChildSSIInc(checkState=false)>
                    <cfelseif FINDNOCASE("ssiinc", strRule, 1) NEQ 0>
                        <cfif structKeyExists(sa,'skipinc') and sa.skipinc EQ "n">
                            <cfset answer = "NO">
                        <cfelse>
                            <cfset answer = this.ynSSIInc(gettoken(strRule,2,"-"),gettoken(strRule,3,"-"))>
                        </cfif>
                    <cfelseif FINDNOCASE("prg", strRule, 1) NEQ 0>
                        <cfset answer = this.ynPrgFind(strRule)>
                    <cfelseif FINDNOCASE("spenddowninc", strRule, 1) NEQ 0>
                        <cfif structKeyExists(sa,'skipinc') and sa.skipinc EQ "n">
                            <cfset answer = "NO">
                        <cfelse>
                            <cfset ynConvertStructMem = FINDNOCASE("struct_mem", strRule, 1)>
                            <cfif ynConvertStructMem>
                                <cfset strStructMem = getToken(strRule,3," ")>
                                <cfset valStructMem = Evaluate("#strStructMem#")>
                                <cfset strConvertedRule = ReplaceNoCase(strRule, strStructMem, valStructMem)>
                                <cfset answer = this.ynSpendDown(strConvertedRule,true)>
                            <cfelse>
                                <cfset answer = this.ynSpendDown(strRule,false)>
                            </cfif>
                        </cfif>
                    <cfelse>
                        <cfset findPos = 1>
                        <cfloop condition="Find('##', strRule, findPos)">
                            <cfset firstPound = Find('##', strRule, findPos)>
                            <cfset secondPound = Find('##', strRule, firstPound + 1)>
                            <cfif secondPound gt firstPound>
                                <cfset variableName = Mid(strRule, firstPound + 1, secondPound - firstPound - 1)>
                                <cfif FindNoCase('struct_mem[', variableName) eq 1 Or FindNoCase('listable[', variableName) eq 1 Or FindNoCase('childtable[', variableName) eq 1 Or IsDefined(variableName)>
                                    <cfset eVal = Evaluate(variableName)>
                                    <cfelseif FindNoCase('session.', variableName) eq 1>
                                    <cfset newVariableName = RemoveChars(variableName, 1, 8)>
                                    <cfif structKeyExists(sa,newVariableName)>
                                        <cfset eVal = sa[newVariableName]>
                                    <cfelse>
                                        <cfset eval = 0>
                                    </cfif>
                                <cfelse>
                                    <cfset eVal = 0>
                                </cfif>
                                <cfif eVal eq ''>
                                    <cfset eVal = 0>
                                </cfif>
                                <cfif Not IsNumeric(eVal) Or (IsNumeric(eVal) And Len(eVal) gt 1 And Left(eVal, 1) eq '0')>
                                    <cfset eVal = "'#eVal#'">
                                </cfif>
                                <cfset strRule = Replace(strRule, "###variableName###", eVal, 'ONE')>
                            <cfelse>
                                <cfset findPos = firstPound + 1>
                            </cfif>
                        </cfloop>
                        <cfset posIn = FindNoCase(' in ', strRule, 1)>
                        <cfset posNotIn = FindNoCase(' not in ', strRule, 1)>
                        <cfif posNotIn>
                            <cfset posFind = posNotIn>
                            <cfset posLen = 8>
                            <cfelseif posIn>
                            <cfset posFind = posIn>
                            <cfset posLen = 4>
                        <cfelse>
                            <cfset posFind = 0>
                        </cfif>
                        <cfif posFind>
                            <cfset strItem = Trim(Left(strRule, posFind - 1))>
                            <cfif Find("('", strItem) eq 1>
                                <cfset strItem = Mid(strItem, 3, Len(strItem) - 3)>
                            <cfelse>
                                <cfset strItem = Mid(strItem, 2, Len(strItem) - 1)>
                            </cfif>
                            <cfset strList = Trim(Right(strRule, Len(strRule) - (posFind + posLen - 1)))>
                            <cfset strList = Mid(strList, 2, Len(strList) - 3)>
                            <cfloop index="element" from="1" to="#ListLen(strList)#">
                                <cfset strList = ListSetAt(strList, element, Trim(ListGetAt(strList, element)))>
                            </cfloop>
                            <cfset temp = ListFindNoCase(strList, strItem)>
                            <cfif temp eq 0>
                                <cfif posNotIn>
                                    <cfset answer="YES">
                                <cfelse>
                                    <cfset answer="NO">
                                </cfif>
                            <cfelse>
                                <cfif posNotIn>
                                    <cfset answer="NO">
                                <cfelse>
                                    <cfset answer="YES">
                                </cfif>
                            </cfif>
                        <cfelse>
                            <cftry>
                                <cfset answer=Evaluate("#strRule#")>
                                <cfcatch type="any">
                                    <cfset answer="YES">
                                </cfcatch>
                            </cftry>
                        </cfif>
                    </cfif>

                    <cfif oldid IS "" OR oldid IS prg_id>
                        <cfset test = test & answer>
                    <cfelse>
                        <cfset test = answer>
                    </cfif>

                     <cfset oldid = prg_id>
                </cfloop>
            </cfif>
        </cfloop>

        <cfset test1 = FINDNOCASE("no", test, 1)>
        <cfif test1 EQ 0 and oldid neq ''>
            <cfset tmp_prg_list = ListAppend(tmp_prg_list, "'#oldid#'")>
        </cfif>
        <cfif tmp_prg_list eq "''">
            <cfset tmp_prg_list = ''>
        </cfif>

        <cfif not ynDoBuffer>
            <cfset sa.prg_list = tmp_prg_list>
        <cfelse>
            <cfset sa.buff_list = tmp_prg_list>
        </cfif>
    </cffunction>


    <cffunction name="calcForScreening" access="remote" restpath="/calcForScreening/{screeningId}" returnType="String" httpMethod="GET">
        <cfargument name="screeningId" required="true" restargsource="Path" type="numeric"/>

        <cfset screening = entityLoadByPK("screening",screeningId)>

        <cfset this.initScreeningAnswers()>

        <cfset sa.selectedDrugs = ''>

        <cfif structKeyExists(sa,"no_hh_members")>
            <cfset sa.no_hh_members = val(sa.no_hh_members)>
            <cfif structKeyExists(sa,"marital_stat")>
                <cfif sa.marital_stat eq 'married'>
                    <cfif sa.no_hh_members lt 2>
                        <cfset sa.no_hh_members = 2 >
                    </cfif>
                    <cfelseif sa.marital_stat neq 'married'>
                    <cfif sa.no_hh_members lt 1>
                        <cfset sa.no_hh_members = 1 >
                    </cfif>
                </cfif>
            </cfif>
        </cfif>

        <cfif structKeyExists(sa,"hh_depend")>
            <cfset sa.hh_depend = val(sa.hh_depend)>
            <cfif structKeyExists(sa,"marital_stat") and sa.marital_stat eq 'married'>
                <cfif sa.hh_depend lt 2>
                    <cfset sa.hh_depend = 2 >
                </cfif>
                <cfelseif structKeyExists(sa,"marital_stat") and sa.marital_stat neq 'married'>
                <cfif sa.hh_depend lt 1>
                    <cfset sa.hh_depend = 1 >
                </cfif>
            </cfif>
        </cfif>

        <cfif structKeyExists(sa,"hh_disabled")>
            <cfset sa.hh_disabled = val(sa.hh_disabled)>
        </cfif>
        <cfif structKeyExists(sa,"over_60")>
            <cfset sa.over_60 = val(sa.over_60)>
        </cfif>
        <CFSET sa.END_TIME = CreateODBCDATETIME(now())>
        <cfset sa.prg_list = ''>
        <cfset sa.buff_list = ''>

        <cfset this.testRules()>

        <cfif Not isNull(screening.getSubset()) Or screening.getSubset().getId() neq 1>
            <CFSET sa.S_asset_TOTAL_COMPLETE = sa.s_asset_TOTAL_COMPLETE - 500>
            <CFSET sa.S_SP_asset_TOTAL_COMPLETE = sa.S_SP_asset_TOTAL_COMPLETE - 500>
            <CFSET sa.HH_asset_TOTAL_COMPLETE = sa.HH_asset_TOTAL_COMPLETE - 500>
            <CFSET sa.S_INCOME_TOTAL_COMPLETE = sa.s_INCOME_TOTAL_COMPLETE - 100>
            <CFSET sa.S_SP_INCOME_TOTAL_COMPLETE = sa.S_SP_INCOME_TOTAL_COMPLETE - 100>
            <CFSET sa.HH_INCOME_TOTAL_COMPLETE = sa.HH_INCOME_TOTAL_COMPLETE - 100>

            <cfset this.testRules()>

            <CFSET sa.S_asset_TOTAL_COMPLETE = sa.s_asset_TOTAL_COMPLETE + 500>
            <CFSET sa.S_SP_asset_TOTAL_COMPLETE = sa.S_SP_asset_TOTAL_COMPLETE + 500>
            <CFSET sa.HH_asset_TOTAL_COMPLETE = sa.HH_asset_TOTAL_COMPLETE + 500>
            <CFSET sa.S_INCOME_TOTAL_COMPLETE = sa.s_INCOME_TOTAL_COMPLETE + 100>
            <CFSET sa.S_SP_INCOME_TOTAL_COMPLETE = sa.S_SP_INCOME_TOTAL_COMPLETE + 100>
            <CFSET sa.HH_INCOME_TOTAL_COMPLETE = sa.HH_INCOME_TOTAL_COMPLETE + 100>
        </cfif>

        <cfset sa.zipradius = 100>

        <cfif Not isNull(screening.getSubset()) And screening.getSubset().getId() gt 0>
            <cfset helperPrg = ormExecuteQuery("select p.prg_id from subset_program_base spb right outer join spb.subset_program_sum sps inner join sps.tbl_prg_all p  where sps.subset.id=? and spb.subset is null order by p.prg_id",[screening.getSubset().getId()])>

             <cfloop array="#helperPrg#" index="i">
                <cfset helperIndex = ListFind(sa.prg_list, "'#i#'")>
                <cfif helperIndex gt 0>
                    <cfset sa.prg_list = ListDeleteAt(sa.prg_list, helperIndex)>
                </cfif>
                <cfset helperIndex = ListFind(sa.buff_list, "'#i#'")>
                <cfif helperIndex gt 0>
                    <cfset sa.buff_list = ListDeleteAt(sa.buff_list, helperIndex)>
                </cfif>
            </cfloop>
        </cfif>

        <cfset schipnum = ListFind(sa.prg_list, "'103-309-2191-FD-FD'")>
        <cfif schipnum gt 0>
            <cfset sa.prg_list=ListDeleteAt(sa.prg_list, schipnum)>
        </cfif>

        <cfset genericnum = ListFind(sa.prg_list, "'XXX-311-2387-FD-FD'")>
        <cfif genericnum gt 0>
            <cfset sa.prg_list=ListDeleteAt(sa.prg_list, genericnum)>
            <cfset sa.genericdrugs = 'y'>
        <cfelse>
            <cfset sa.genericdrugs = 'n'>
        </cfif>

        <!---<cfif sa.subsetRecFlag eq 1>
            <cfset unseenVal = 1>
        <cfelse>--->
            <cfset unseenVal = 0>
        <!---</cfif>--->


        <cftransaction>
            <cfloop list="#sa.prg_list#" index="prg_id">
                <cfset unseenAdjustedVal = unseenVal>
                <cfif unseenVal eq 0>
                    <cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
                        <cfset unseenAdjustedVal = 1>
                    </cfif>
                </cfif>

                <cfset tblPrg = entityload("tbl_prg_all",{prg_id=replaceNoCase(prg_id,"'","","all")})>
                <cfif arraylen(tblPrg) eq 0>
                    <cfset tblPrg = entityload("program",{legacy_prg_id=replaceNoCase(prg_id,"'","","all")})>
                    <cfif arraylen(tblPrg) neq 0>
                        <cfset program = tblPrg[1]>
                    </cfif>
                <cfelse>
                    <cfset program = tblPrg[1].getProgram()>
                </cfif>

                <cfif arraylen(tblPrg) neq 0>
                    <cfset insertprogram = entityNew("screening_program")>
                    <cfset insertprogram.setScreening(screening)>
                    <cfset insertprogram.setProgram(program)>
                    <cfset insertprogram.setUnseen_flag(unseenAdjustedVal)>
                    <cfset insertprogram.setBuffer_flag(0)>
                    <cfset insertprogram.setMaybe_flag(0)>
                <cfset entitySave(insertprogram)>
                </cfif>
            </cfloop>

            <cfif structKeyExists(sa,'wantchips') and sa.wantchips eq 'y'>
                <cfset tblPrg = entityload("tbl_prg_all",{prg_id='103-309-2191-FD-FD'})>
                <cfif arraylen(tblPrg) eq 0>
                    <cfset tblPrg = entityload("program",{legacy_prg_id='103-309-2191-FD-FD'})>
                    <cfif arraylen(tblPrg) neq 0>
                        <cfset program = tblPrg[1]>
                    </cfif>
                <cfelse>
                    <cfset program = tblPrg[1].getProgram()>
                </cfif>

                <cfif arraylen(tblPrg) neq 0>
                    <cfset insertchips = entityNew("screening_program")>
                    <cfset insertchips.setScreening(screening)>
                    <cfset insertchips.setProgram(program)>
                    <cfset insertchips.setUnseen_flag(unseenVal)>
                    <cfset insertchips.setBuffer_flag(0)>
                    <cfset insertchips.setMaybe_flag(0)>
                    <cfset entitySave(insertchips)>
                </cfif>
            </cfif>

            <cfif sa.genericdrugs eq 'y'>
                <cfset tblPrg = entityload("tbl_prg_all",{prg_id='XXX-311-2387-FD-FD'})>
                <cfif arraylen(tblPrg) eq 0>
                    <cfset tblPrg = entityload("program",{legacy_prg_id='XXX-311-2387-FD-FD'})>
                    <cfif arraylen(tblPrg) neq 0>
                        <cfset program = tblPrg[1]>
                    </cfif>
                <cfelse>
                    <cfset program = tblPrg[1].getProgram()>
                </cfif>

                <cfif arraylen(tblPrg) neq 0>
                    <cfset insertgeneric = entityNew("screening_program")>
                    <cfset insertgeneric.setScreening(screening)>
                    <cfset insertgeneric.setProgram(program)>
                    <cfset insertgeneric.setUnseen_flag(unseenVal)>
                    <cfset insertgeneric.setBuffer_flag(0)>
                    <cfset insertgeneric.setMaybe_flag(0)>
                    <cfset entitySave(insertgeneric)>
                </cfif>
            </cfif>

            <cfloop list="#sa.buff_list#" index="prg_id">

                <cfset tblPrg = entityload("tbl_prg_all",{prg_id=replaceNoCase(prg_id,"'","","all")})>
                <cfif arraylen(tblPrg) eq 0>
                    <cfset tblPrg = entityload("program",{legacy_prg_id=replaceNoCase(prg_id,"'","","all")})>
                    <cfif arraylen(tblPrg) neq 0>
                        <cfset program = tblPrg[1]>
                    </cfif>
                <cfelse>
                    <cfset program = tblPrg[1].getProgram()>
                </cfif>

                <cfif arraylen(tblPrg) neq 0>
                    <cfset insertbuffers = entityNew("screening_program")>
                    <cfset insertbuffers.setScreening(screening)>
                    <cfset insertbuffers.setProgram(program)>
                    <cfset insertbuffers.setUnseen_flag(unseenVal)>
                    <cfset insertbuffers.setBuffer_flag(1)>
                    <cfset insertbuffers.setMaybe_flag(0)>
                    <cfset entitySave(insertbuffers)>
                </cfif>
            </cfloop>
       </cftransaction>
        <cfreturn this.calculatedForScreening(screening.getId())>
    </cffunction>

    <cffunction name="initScreeningAnswers">
        <cfset saArr = entityload("screening_answerfield",{screening=screening})>
        <cfset sa = structNew()>
        <cfloop array="#saArr#" index="i">
            <cfif isNull(i.getOption())>
                <cfset sa[i.getAnswer().getCode()]=i.getResponse()>
            <cfelse>
                <cfset sa[i.getAnswer().getCode()]=i.getOption().getCode()>
            </cfif>
        </cfloop>

        <cfif not structKeyExists(sa,'st')>
            <cfset sa.st=screening.getPreset_state().getId()>
        </cfif>

<!---
 init undefined answers
--->
        <cfset uaForInit = ["SP_INCOME_EARNED","S_SP_INCOME_EARNED","S_SP_INCOME_TOTAL_UNEARNED","S_SP_INCOME_TANF","S_INCOME_TANF",
            "S_SP_INCOME_CASH_ASSIST","S_INCOME_EARNED","S_INCOME_TOTAL_UNEARNED","S_INCOME_CASH_ASSIST","s_asset_auto1",
            "s_asset_home","s_asset_life_face","s_asset_life_cash","s_asset_irrevocable","s_asset_revocable",
            "s_sp_asset_life_face","s_sp_asset_irrevocable","S_ASSET_TOTAL_COMPLETE","dob","st","pri_resident","grandparent",
            "ch_disabled","ch_income_earned","ch_income_total_unearned","ch_income_child_support","no_hh_members","hh_depend","no_hh_children",
            "ch_rec_tanf","sp_dob","ss_receive","ssd_receive_2","hh_asset_total_complete","s_sp_asset_auto1","s_sp_asset_home",
            "SP_INCOME_TOTAL_UNEARNED","HH_INCOME_TOTAL_COMPLETE","S_SP_INCOME_TOTAL_COMPLETE","SP_INCOME_TOTAL_COMPLETE",
            "ch_rec_medicaid","hh_income_earned","receive_partd","s_sp_asset_total_complete","s_sp_asset_life_cash",
            "receive_msp","receive_lis","s_income_total_complete","sp_asset_auto1","sp_asset_home","s_sp_income_dividends",
            "vet_disability","int_edu","int_blind","int_low_inc_house","receive_pub_housing","receive_section_8",
            "liheap_receive","snap_mn_receive","int_deaf","hh_income_ssi","hh_income_ss_disable","hh_income_unemploy",
            "hh_income_tanf","hh_income_cash_assist","scsep_receive","int_trans_personal","REC_DE_DPAP","REC_IN_HOOSIERRX",
            "REC_MA_PRESCRIPTIONADVANTAGE","REC_ME_DEL","REC_MO_RXPLAN","REC_NJ_PAAD","REC_NY_EPIC","REC_NV_SENIORRX",
            "REC_PA_PACE","REC_PA_PACENET","REC_SC_GAPS","REC_RI_RIPAE","REC_VT_VPHARM1","REC_VT_VPHARM2","REC_VT_VPHARM3",
            "REC_WI_SENIORCARE","REC_WY_PDAP","ch_blind","ch_asset_total_complete","ch_rec_ssi","sp_ss_years","ss_years","rent",
            "mortgage","electricity_costs","gas_costs","water_costs","telephone_costs","utility_costs_other","dep_care_costs",
            "scsep_inc","hh_disabled","over_60","leg_resident_5years","dep_care","ch_rec_schip","dep_child","property_tax",
            "vet_wartime","sp_veteran","vet_sp_died","int_emp","utility_2","S_SP_ASSET_REVOCABLE","S_SP_ASSET_TOTAL_COMPLETE",
            "s_sp_asset_auto1","s_sp_asset_home","city","med_costs","Citizen","hh_asset_auto1","hh_asset_home","hh_asset_life_cash",
            "hh_asset_retirement","med_receive","ssi_receive","disabled","medicare_receive","rec_tricare","receive_va","tricare",
            "chip","int_assistech","int_medicare","s_income_ss_disable","s_sp_income_ss_disable"]>

        <cfloop array="#uaForInit#" index="ind">
            <cfif not structKeyExists(sa,ind) or sa[ind] eq "">
                <cfset sa[ind] = 0>
            </cfif>
        </cfloop>
    </cffunction>


</cfcomponent>
