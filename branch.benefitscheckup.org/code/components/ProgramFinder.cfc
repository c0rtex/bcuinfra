<cfcomponent>

  <cfproperty name="incomeTables">
  <cfproperty name="mxAssetVals">
  <cfproperty name="mxIncVals">
  <cfproperty name="sa">
  <cfproperty name="screening">
  <cfproperty name="prg_list">
  <cfproperty name="buff_list">
  <cfproperty name="selectedDrugs">
  <cfproperty name="ynDoBuffer">
  <cfproperty name="subsetRecFlag">

  <cffunction name="dspForms" access="remote" returnFormat="plain">
      <cfargument name="cat" required="no" default="">
      <cfargument name="st" required="no" default="">
      <cfargument name="ecPrgList" required="no" default="">
      <cfargument name="sortorder" required="no" default="">
      <cfargument name="sortby" required="no" default="">

      <cfset qryFormsQuery = "select distinct(f.id),p.id,p.prg_id,p.prg_nm,f.state.id,f.name,ft.code,ftg.name,fft.string,fft.entry_date,fft.form_date,p.cat_id,fft.form_type.id,p.st,pf.sort from form f join f.form_form_types fft join fft.form_type ft join f.form_tag ftg join f.program_forms pf join pf.program pr join pr.tbl_prg_all p join p.subset_program_bases sp">
      <cfset qryFormsQuery = "#qryFormsQuery# where ft.id <> 2 and (p.inactive_flag = 0 or p.inactive_flag is null)">

      <cfif cat EQ 'PAP'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=19 and p.cat_id = 331">
      <cfelseif cat EQ 'MSP'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=1 and p.cat_id = 309">
      <cfelseif cat EQ 'QMB'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=1 and (  p.prg_id = '103-309-1031-FD-FD' or  p.prg_id = '103-309-2681-AZ-ST')">
      <cfelseif cat EQ 'QI'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=1 and (  p.prg_id = '103-309-1071-FD-FD' or p.prg_id = '103-309-2683-AZ-ST' )">
      <cfelseif cat EQ 'SLMB'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=1 and ( p.prg_id = '103-309-1032-FD-FD' or p.prg_id = '103-309-2682-AZ-ST')">
      <cfelseif cat EQ 'MEDAPROV'>
          <cfset qryFormsQuery = "#qryFormsQuery#   and sp.subset.id=12">
      <cfelseif cat EQ 'MED'>
          <cfset qryFormsQuery = "#qryFormsQuery#   and sp.subset.id=8">
      <cfelseif cat EQ 'OTH'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=1 and p.cat_id = 332">
      <cfelseif cat EQ 'STRX'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=9">
      <cfelseif cat EQ 'Entered' or cat EQ 'PUB'>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=1">
      <cfelseif st neq ''>
          <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=1 and f.state.id = '#st#'">
      </cfif>

      <cfif cat EQ 'DRUG'>
          <cfif isdefined('ecPrgList') and len(ecPrgList) gt 1 >
              <cfset prgIdList = listToArray(ecPrgList,",")>
              <cfset prgList = "'1'">
              <cfloop array="#prgIdList#" index="item">
                  <cfset prgList = "#prgList#,'#trim(item)#'">
              </cfloop>
              <cfset qryFormsQuery = "#qryFormsQuery# and (sp.subset.id=1 or sp.subset.id=19) and p.prg_id IN (#prgList#)">
          <cfelse>
              <cfset qryFormsQuery = "#qryFormsQuery# and sp.subset.id=10000">
          </cfif>
      </cfif>

      <cfif sortorder neq '' and sortby neq ''>
          <cfset qryFormsQuery = "#qryFormsQuery# order by #sortby# #sortorder#, pf.sort">
      <cfelseif st neq '' >
          <cfset qryFormsQuery = "#qryFormsQuery# order by p.prg_nm,p.cat_id, pf.sort">
      <cfelseif cat eq 'PUB'>
          <cfset qryFormsQuery = "#qryFormsQuery# order by  p.prg_nm, pf.sort">
      <cfelseif cat eq 'ENTERED'>
          <cfset qryFormsQuery = "#qryFormsQuery# order by p.prg_nm, pf.sort">
      <cfelseif cat eq 'DRUG'>
          <cfset qryFormsQuery = "#qryFormsQuery# order by p.cat_id asc, p.prg_nm, pf.sort">
      <cfelseif cat EQ 'SLMB' or cat EQ 'QMB' or cat EQ 'QI' or cat EQ 'MED' or cat EQ 'MSP' or cat EQ 'STRX'>
          <cfset qryFormsQuery = "#qryFormsQuery# order by p.st, p.prg_nm, pf.sort">
      <cfelse>
          <cfset qryFormsQuery = "#qryFormsQuery# order by p.prg_nm, pf.sort">
      </cfif>

      <cfset query = ormExecuteQuery(qryFormsQuery)>

      <cfset data = arrayNew(1)>

      <cfloop array="#query#" index="item">
          <cfset str = structNew()>
          <cfset str.form_id = item[1]>
          <cfset str.program_id=item[2]>
          <cfset str.prg_id=item[3]>
          <cfset str.prg_nm=item[4]>
          <cfif arrayIsDefined(item,5)>
              <cfset str.form_state = item[5]>
          <cfelse>
              <cfset str.form_state = "ALL">
          </cfif>
          <cfset str.form_name=item[6]>
          <cfset str.form_type_code=item[7]>
          <cfset str.form_tag_name=item[8]>
          <cfset str.form_file=item[9]>

          <cfif arrayIsDefined(item,10)>
              <cfset str.entry_date=dateFormat(item[10],"yyyy-mm-dd")>
          <cfelse>
              <cfset str.entry_date="">
          </cfif>

          <cfif arrayIsDefined(item,11)>
              <cfset str.form_date=dateFormat(item[11],"yyyy-mm-dd")>
          <cfelse>
              <cfset str.form_date="">
          </cfif>

          <cfset str.cat_id=item[12]>
          <cfset str.form_type_id=item[13]>
          <cfset str.program_state=item[14]>
          <cfset str.sort=item[15]>
          <cfset arrayAppend(data,str)>
      </cfloop>

      <cfif structKeyExists(arguments, "callback")>
          <cfset retVal = arguments.callback & "(" & serializeJSON(data) & ");">
      <cfelseif structKeyExists(arguments, "jsonp")>
          <cfset retVal= "jsonp(" & data & ");">
      <cfelse>
          <cfset retVal = serializeJSON(data)>
      </cfif>

      <cfreturn retVal>
  </cffunction>

  <cffunction name="proceligibilityByScreening" access="remote" returnFormat="plain">
      <cfargument name="screening_id"required="no" default="">
      <cfargument name="ynDoBuffer" required="no" default="false">
      <cfargument name="subsetRecFlag" required="no" default="0">
      <cfargument name="genericdrugs" required="no" default="Y">

      <cfset this.ynDoBuffer = ynDoBuffer>
      <cfset this.subsetRecFlag = subsetRecFlag>
      <cfset this.genericdrugs = genericdrugs>

      <cfif screening_id neq "">
          <cfset scArr = ormExecuteQuery("from screening where id=:id",{id=screening_id})>
      <cfelse>
          <cfset scArr = ormExecuteQuery("from screening where cfid=:cfid and cftoken=:cftoken",{cfid=session.cfid, cftoken=session.cftoken})>
      </cfif>

      <cfset retVal = arrayNew(1)>

      <cfif arraylen(scArr) neq 0>
          <cfset this.screening = scArr[1]>
          <cfset this.proceligibility()>
          <cfset prgs = ormexecutequery("from screening_program sp where sp.screening=:screening order by sp.program.sort",{screening=this.screening})>
          <cfloop array="#prgs#" index="i">
              <cfset arrayAppend(retVal,i.getProgram().toStructure())>
          </cfloop>
      </cfif>

      <cfset data = structNew()>
      <cfset data.programs=retVal>

      <cfif structKeyExists(arguments, "callback")>
          <cfset retVal = arguments.callback & "(" & serializeJSON(data) & ");">
      <cfelseif structKeyExists(arguments, "jsonp")>
          <cfset retVal= "jsonp(" & data & ");">
      <cfelse>
          <cfset retVal = serializeJSON(data)>
      </cfif>

      <cfreturn retVal>
  </cffunction>

  <cffunction name="proceligibility">
      <cfset this.initScreeningAnswers()>
      
      <cfset this.screening.setEnd_datetime(Now())>
      <cfset entitySave(this.screening)>

      <cfset this.selectedDrugs = ''>

      <cfif not structKeyExists(this.sa,'city')>
          <cfset this.sa.city = 0>
      </cfif>

      <cfif structKeyExists(this.sa,"no_hh_members")>
          <cfset sa.no_hh_members = val(this.sa.no_hh_members)>
          <cfif structKeyExists(this.sa,"marital_stat")>
              <cfif this.sa.marital_stat eq 'married'>
                  <cfif this.sa.no_hh_members lt 2>
                      <cfset this.sa.no_hh_members = 2 >
                  </cfif>
              <cfelse>
                  <cfif this.sa.no_hh_members lt 1>
                      <cfset this.sa.no_hh_members = 1 >
                  </cfif>
              </cfif>
          </cfif>
      </cfif>

      <cfif structKeyExists(this.sa,"hh_depend")>
          <cfset this.sa.hh_depend = val(this.sa.hh_depend)>
          <cfif structKeyExists(this.sa,"marital_stat")>
              <cfif this.sa.marital_stat eq 'married'>
                  <cfif this.sa.hh_depend lt 2>
                      <cfset this.sa.hh_depend = 2 >
                  </cfif>
              <cfelse>
                  <cfif this.sa.hh_depend lt 1>
                      <cfset this.sa.hh_depend = 1 >
                  </cfif>
              </cfif>
          </cfif>
      </cfif>

      <cfif structKeyExists(this.sa,"hh_disabled")>
          <cfset this.sa.hh_disabled = val(this.sa.hh_disabled)>
      </cfif>

      <cfif structKeyExists(this.sa,"over_60")>
          <cfset this.sa.over_60 = val(this.sa.over_60)>
      </cfif>

      <cfset this.prg_list = ''>
      <cfset this.buff_list = ''>

      <cfset this.testRules()>

      <cfif IsNull(this.screening.getSubset()) Or this.screening.getSubset().getId() neq 1>
          <CFSET this.sa.S_asset_TOTAL_COMPLETE = this.sa.s_asset_TOTAL_COMPLETE - 500>
          <CFSET this.sa.S_SP_asset_TOTAL_COMPLETE = this.sa.S_SP_asset_TOTAL_COMPLETE - 500>
          <CFSET this.sa.HH_asset_TOTAL_COMPLETE = this.sa.HH_asset_TOTAL_COMPLETE - 500>
          <CFSET this.sa.S_INCOME_TOTAL_COMPLETE = this.sa.s_INCOME_TOTAL_COMPLETE - 100>
          <CFSET this.sa.S_SP_INCOME_TOTAL_COMPLETE = this.sa.S_SP_INCOME_TOTAL_COMPLETE - 100>
          <CFSET this.sa.HH_INCOME_TOTAL_COMPLETE = this.sa.HH_INCOME_TOTAL_COMPLETE - 100>
          <cfset this.testRules()>
          <CFSET this.sa.S_asset_TOTAL_COMPLETE = this.sa.s_asset_TOTAL_COMPLETE + 500>
          <CFSET this.sa.S_SP_asset_TOTAL_COMPLETE = this.sa.S_SP_asset_TOTAL_COMPLETE + 500>
          <CFSET this.sa.HH_asset_TOTAL_COMPLETE = this.sa.HH_asset_TOTAL_COMPLETE + 500>
          <CFSET this.sa.S_INCOME_TOTAL_COMPLETE = this.sa.s_INCOME_TOTAL_COMPLETE + 100>
          <CFSET this.sa.S_SP_INCOME_TOTAL_COMPLETE = this.sa.S_SP_INCOME_TOTAL_COMPLETE + 100>
          <CFSET this.sa.HH_INCOME_TOTAL_COMPLETE = this.sa.HH_INCOME_TOTAL_COMPLETE + 100>
      </cfif>

      <cfset this.sa.zipradius = 100>

      <cfif not isNull(this.screening.getSubset()) And this.screening.getSubset().getId() gt 0>
          <cfquery name="helperPrg" datasource="#application.dbSrc#">
		    SELECT p.prg_id AS helper_prg_id
		    FROM subset_program_base spb RIGHT OUTER JOIN subset_program_sum sps
				ON spb.subset_id=sps.subset_id AND spb.program_id=sps.program_id
			    INNER JOIN tbl_prg_all p
				ON sps.program_id=p.RecID
		        WHERE sps.subset_id=#this.screening.getSubset().getId()#
			    AND spb.subset_id IS NULL
		        ORDER BY p.prg_id
	      </cfquery>
          <cfloop query="helperPrg">
              <cfset helperIndex = ListFind(this.prg_list, "'#helper_prg_id#'")>
              <cfif helperIndex gt 0>
                  <cfset session.prg_list = ListDeleteAt(this.prg_list, helperIndex)>
              </cfif>
              <cfset helperIndex = ListFind(this.buff_list, "'#helper_prg_id#'")>
              <cfif helperIndex gt 0>
                  <cfset session.buff_list = ListDeleteAt(this.buff_list, helperIndex)>
              </cfif>
          </cfloop>
      </cfif>

      <cfset schipnum = ListFind(this.prg_list, "'103-309-2191-FD-FD'")>
      <cfif schipnum gt 0>
          <cfset this.prg_list=ListDeleteAt(this.prg_list, schipnum)>
      </cfif>

      <cfset genericnum = ListFind(this.prg_list, "'XXX-311-2387-FD-FD'")>
      <cfif genericnum gt 0>
          <cfset this.prg_list=ListDeleteAt(this.prg_list, genericnum)>
          <cfset this.sa.genericdrugs = 'y'>
      <cfelse>
          <cfset this.sa.genericdrugs = 'n'>
      </cfif>

      <cfif this.subsetRecFlag eq 1>
          <cfset unseenVal = 1>
      <cfelse>
          <cfset unseenVal = 0>
      </cfif>

      <cf_loadApplicationVars hashname="prgvars">

      <cfset spA = arrayNew(1)>

      <cftransaction>

      <cfloop list="#this.prg_list#" index="prg_id">
          <cfset unseenAdjustedVal = unseenVal>
          <cfif unseenVal eq 0>
              <cfif Mid(prg_id, Find('-', prg_id) + 1, Find('-', prg_id, Find('-', prg_id) + 1) - Find('-', prg_id) - 1) eq '333'>
                  <cfset unseenAdjustedVal = 1>
              </cfif>
          </cfif>
          <cftry>
              <cfset sp = entityNew("screening_program")>
              <cfset sp.setScreening(this.screening)>
              <cfset sp.setProgram(entityLoadByPK("program",StructFind(application.prgvars,replaceNoCase(prg_id,"'","","all"))))>
              <cfset sp.setUnseen_flag(unseenAdjustedVal)>
              <cfset sp.setBuffer_flag(0)>
              <cfset sp.setMaybe_flag(0)>
              <cfset entitySave(sp)>
              <cfset arrayAppend(spa,sp)>
          <cfcatch></cfcatch>
          </cftry>
      </cfloop>

      <cfif structKeyExists(this.sa,'wantchips') and this.sa.wantchips eq 'Y'>
          <cftry>
              <cfset sp = entityNew("screening_program")>
              <cfset sp.setScreening(this.screening)>
              <cfset sp.setProgram(entityLoadByPK("program",StructFind(application.prgvars, '103-309-2191-FD-FD')))>
              <cfset sp.setUnseen_flag(unseenVal)>
              <cfset sp.setBuffer_flag(0)>
              <cfset sp.setMaybe_flag(0)>
              <cfset entitySave(sp)>
              <cfset arrayAppend(spa,sp)>
          <cfcatch></cfcatch>
          </cftry>
      </cfif>

      <cfif this.genericdrugs eq 'Y'>
          <cftry>
              <cfset sp = entityNew("screening_program")>
              <cfset sp.setScreening(this.screening)>
              <cfset sp.setProgram(entityLoadByPK("program",StructFind(application.prgvars, 'XXX-311-2387-FD-FD')))>
              <cfset sp.setUnseen_flag(unseenVal)>
              <cfset sp.setBuffer_flag(0)>
              <cfset sp.setMaybe_flag(0)>
              <cfset entitySave(sp)>
              <cfset arrayAppend(spa,sp)>
          <cfcatch></cfcatch>
          </cftry>
      </cfif>

      <cfloop list="#this.buff_list#" index="prg_id">
          <cftry>
              <cfset sp = entityNew("screening_program")>
              <cfset sp.setScreening(this.screening)>
              <cfset sp.setProgram(entityLoadByPK("program",StructFind(application.prgvars,replaceNoCase(prg_id,"'","","all"))))>
              <cfset sp.setUnseen_flag(unseenVal)>
              <cfset sp.setBuffer_flag(0)>
              <cfset sp.setMaybe_flag(0)>
              <cfset entitySave(sp)>
              <cfset arrayAppend(spa,sp)>
          <cfcatch></cfcatch>
          </cftry>
      </cfloop>
      </cftransaction>
      <cfif not IsNull(this.screening.getPartner()) And this.screening.getPartner().getId() eq 5>
          <cfif ListLen(this.prg_list)>
              <cfif this.sa.citizen eq 'Citizen'>
                  <cfset showAddedInfo="false">
              <cfelse>
                  <cfset showAddedInfo="true">
              </cfif>
              <cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" fileformat="html" coverpage="false" toc="false" addedinfo="#showAddedInfo#" ltccinfo="false" pgbreaks="false" brandname="LTCC Public Programs">
          <cfelse>
              <cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" blankreport="true">
          </cfif>
      </cfif>
      <cfreturn spA>
  </cffunction>

  <cffunction name="initScreeningAnswers">
      <cfset saArr = entityload("screening_answerfield",{screening=this.screening})>
      <cfset this.sa = structNew()>
      <cfloop array="#saArr#" index="i">
          <cfif isNull(i.getOption())>
              <cfset this.sa[i.getAnswer().getCode()]=i.getResponse()>
          <cfelse>
              <cfset this.sa[i.getAnswer().getCode()]=i.getOption().getCode()>
          </cfif>
      </cfloop>
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
                          "s_sp_asset_auto1","s_sp_asset_home"]>

        <cfloop array="#uaForInit#" index="ind">
          <cfif not structKeyExists(this.sa,ind) or this.sa[ind] eq "">
              <cfset this.sa[ind] = 0>
          </cfif>
      </cfloop>
  </cffunction>

  <cffunction name="initMxAssetVals">
      <cfargument name="strTable" default="" type="string">
      <cfset this.mxAssetVals = ormExecuteQuery("from tbl_mx_asset tma where tma.state=:state and tma.tbl_nm=:tbl_nm",{state=this.screening.getPreset_state(),tbl_nm=strTable})>
      <cfset this.mxAssetVals = this.mxAssetVals[1]>
  </cffunction>

  <cffunction name="initMxIncVals">
      <cfargument name="strTable" default="" type="string">
      <cfset this.mxIncVals = ormExecuteQuery("from tbl_mx_income tmi where tmi.state=:state and tmi.tbl_nm=:tbl_nm",{state=this.screening.getPreset_state(),tbl_nm=strTable})>
      <cfset this.mxIncVals = this.mxIncVals[1]>
  </cffunction>

  <cffunction name="testRules">

      <cfset this.initIncomeTables()>
      <cfset testPrograms = "">
      <cfset tmp_prg_list = ''>
      <cfset oldid = ''>
      <cfset test = ''>
      <cfset loopindex = 0>

      <cfset querySubsetProgram = ormexecutequery("from subset_program_sum sps join sps.program p where sps.subset=:subset and p.active_flag=1 and (p.state=:state or p.state is null) order by p.sort",{subset=this.screening.getSubset(),state=this.screening.getPreset_state()})>


      <cfloop array="#querySubsetProgram#" index="i">
          <cfset loopindex = loopindex + 1>
          <cfset testProgram = i[2]>
          <cfset prg_id = testProgram.getLegacy()>

          <cfif loopindex gt 1>
              <cfset test1 = FINDNOCASE("no", test, 1)>
              <cfif test neq "" and test1 EQ 0>
                  <cfset tmp_prg_list = ListAppend(tmp_prg_list, "'#oldid#'")>
              </cfif>
          </cfif>
          <cfif not this.ynDoBuffer or ListFind(this.prg_list, "'#prg_id#'") eq 0>
              <cfset queryProgramRules = ormExecuteQuery("from program_rule where program=:program order by sort",{program=testProgram})>
              <cfloop array="#queryProgramRules#" index="program_rule">
                  <cfset testRule = program_rule.getRule()>
                  <cfset strRule = Replace(testRule.getRule_text(), "gteq", "gte", "ALL")>
                  <cfset strRule = Replace(strRule, "lteq", "lte", "ALL")>
                  <cfset strRule = Replace(strRule, "XX[" , "[", "ALL")>

                  <cfif FINDNOCASE("BuyInQI2asset", strRule, 1) NEQ 0>
                      <cfif structKeyExists(this.sa,"skipassets") and this.sa.skipassets EQ "N">
                          <cfset answer = "NO">
                      <cfelse>
                          <cfset answer = this.yeMedicareBuyInAss(strRule,gettoken(strRule,2,"-"),gettoken(strRule,3,"-"))>
                      </cfif>
                  <cfelseif FINDNOCASE("BuyInQI2inc", strRule, 1) NEQ 0>
                      <cfif structKeyExists(this.sa,"skipinc") and this.sa.skipinc EQ "N">
                          <cfset answer = "NO">
                      <cfelse>
                          <cfset answer = this.yeMedicareBuyInInc(strRule,gettoken(strRule,2,"-"),gettoken(strRule,3,"-"),gettoken(strRule,4,"-"),gettoken(strRule,5,"-"))>
                      </cfif>
                  <cfelseif FINDNOCASE("MXASSET", strRule, 1) NEQ 0>
                      <cfset strTable = Replace(strRule,"(","","ALL")>
                      <cfset strTable = Trim(ReplaceNoCase(strTable,"MXASSET)","","ALL"))>
                      <cfset this.initMxAssetVals(strTable)>

                      <cfif structKeyExists(this.sa,"skipassets") and this.sa.skipassets EQ "N">
                          <cfif mxAssetVals.getSingle() GTE 1000000>
                              <cfset answer = "YES">
                          <cfelse>
                              <cfset answer = "NO">
                          </cfif>
                      <cfelse>
                          <cfset answer = this.yeMedicareBuyInAss(strRule,this.mxAssetVals.getSingle(),this.mxAssetVals.getCouple())>
                      </cfif>
                  <cfelseif FINDNOCASE("MXINCOME", strRule, 1) NEQ 0>
                      <cfif structKeyExists(this.sa,"skipinc") and this.sa.skipinc EQ "N">
                          <cfset answer = "NO">
                      <cfelse>
                          <cfset strTable = Replace(strRule,"(","","ALL")>
                          <cfset strTable = Trim(ReplaceNoCase(strTable,"MXINCOME)","","ALL"))>
                          <cfset this.initMxIncVals(strTable)>
                          <cfset answer = this.yeMedicareBuyInInc(strRule,this.mxIncVals.getSingle_max(),this.mxIncVals.getSingle_min(),this.mxIncVals.getCouple_max(),this.mxIncVals.getCouple_min())>
                      </cfif>
                  <cfelseif FINDNOCASE("childstatessiinc", strRule, 1) NEQ 0>
                      <cfset answer = this.yeChildSSIInc("true")>
                  <cfelseif FINDNOCASE("childssiinc", strRule, 1) NEQ 0>
                      <cfset answer = this.yeChildSSIInc()>
                  <cfelseif FINDNOCASE("ssiinc", strRule, 1) NEQ 0>
                      <cfif structKeyExists(this.sa,'skipinc') and this.sa.skipinc EQ "N">
                          <cfset answer = "NO">
                      <cfelse>
                          <cfset answer = this.yeSSIInc(self=gettoken(strRule,2,"-"),self_spouse=gettoken(strRule,3,"-"))>
                      </cfif>
                  <cfelseif FINDNOCASE("prg", strRule, 1) NEQ 0>
                      <cfset answer = this.yePrgFind(rule=strRule,tmp_prg_list=tmp_prg_list)>
                  <cfelseif FINDNOCASE("spenddowninc", strRule, 1) NEQ 0>
                      <cfif structKeyExists(this.sa,'skipinc') and this.sa.skipinc EQ "N">
                          <cfset answer = "NO">
                      <cfelse>
                          <cfset ynConvertStructMem = FINDNOCASE("struct_mem", strRule, 1)>
                          <cfif ynConvertStructMem>
                              <cfset strStructMem = getToken(strRule,3," ")>
                              <cfset valStructMem = Evaluate("#strStructMem#")>
                              <cfset strConvertedRule = ReplaceNoCase(strRule, strStructMem, valStructMem)>
                              <cfset answer = this.yeSpendDown(rule=strConvertedRule,EvaluateRule="TRUE")>
                          <cfelse>
                              <cfset answer = this.yeSpendDown(rule=strRule,EvaluateRule="FALSE")>
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
                                  <cfset eVal = this.sa["#newVariableName#"]>
                              <cfelse>
                                  <cfset eVal = 0>
                              </cfif>
                              <cfif isArray(eVal)>
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
          <cfset tmp_prg_list = ListAppend(tmp_prg_list, "#oldid#")>
      </cfif>

      <cfif tmp_prg_list eq "''">
          <cfset tmp_prg_list = ''>
      </cfif>

      <cfif not this.ynDoBuffer>
          <cfset this.prg_list = tmp_prg_list>
      <cfelse>
          <cfset this.buff_list = tmp_prg_list>
      </cfif>
  </cffunction>

  <cffunction name="initIncomeTables">

      <cfset this.incomeTables = structNew()>

      <cfif this.sa.no_hh_members lt 1>
          <cfset householdcount = 1>
      <cfelseif this.sa.no_hh_members GT 8>
          <cfset householdcount = 8>
      <cfelse>
          <cfset householdcount =  this.sa.no_hh_members>
      </cfif>

      <cfif this.sa.hh_depend lt 1>
          <cfset dependcount = 1>
      <cfelseif this.sa.hh_depend GT 8>
          <cfset dependcount = 8>
      <cfelse>
          <cfset dependcount = this.sa.hh_depend>
      </cfif>

      <cfif this.sa.no_hh_children lt 1>
          <cfset childcount = 1>
      <cfelseif this.sa.no_hh_children gt 8>
          <cfset childcount = 8>
      <cfelse>
          <cfset childcount = this.sa.no_hh_children>
      </cfif>

      <cfset sec8table = entityload("tbl_inc",{tbl_nm="Section 8",state=this.screening.getPreset_state().getId()})>
      <cfif arraylen(sec8table) neq 0>
          <cfset sec8table = evaluate("sec8table[1].getmem#householdcount#()")>
      <cfelse>
          <cfset sec8table = 0>
      </cfif>

      <cfset PHtable = entityload("tbl_inc",{tbl_nm="Public Housing",state=this.screening.getPreset_state().getId()})>
      <cfif arraylen(PHtable) neq 0>
          <cfset PHtable = evaluate("PHtable[1].getmem#householdcount#()")>
      <cfelse>
          <cfset PHtable = 0>
      </cfif>

      <cfset WEATHERTABLE = entityload("tbl_inc",{tbl_nm="WEATHER",state=this.screening.getPreset_state().getId()})>
      <cfif arraylen(WEATHERTABLE) neq 0>
          <cfset WEATHERTABLE = evaluate("WEATHERTABLE[1].getmem#householdcount#()")>
      <cfelse>
          <cfset WEATHERTABLE = 0>
      </cfif>

      <cfset LIHEAPTABLE = entityload("tbl_inc",{tbl_nm="LIHEAP",state=this.screening.getPreset_state().getId()})>
      <cfif arraylen(LIHEAPTABLE) neq 0>
          <cfset LIHEAPTABLE = evaluate("LIHEAPTABLE[1].getmem#householdcount#()")>
      <cfelse>
          <cfset LIHEAPTABLE = 0>
      </cfif>

      <cfset LASSETTABLE = entityload("tbl_inc",{tbl_nm="LASSET",state=this.screening.getPreset_state().getId()})>
      <cfif arraylen(LASSETTABLE) neq 0>
          <cfset LASSETTABLE = evaluate("LASSETTABLE[1].getmem#householdcount#()")>
      <cfelse>
          <cfset LASSETTABLE = 0>
      </cfif>

      <cfif childcount gt 0>
          <cfset TANFTABLE = entityload("tbl_inc",{tbl_nm="TANF",state=this.screening.getPreset_state().getId()})>
          <cfif arraylen(TANFTABLE) neq 0>
              <cfset TANFTABLE = evaluate("TANFTABLE[1].getmem#childcount#()")>
          <cfelse>
              <cfset TANFTABLE = 0>
          </cfif>
      <cfelse>
          <cfset TANFTABLE = 0>
      </cfif>

      <cfset build_income_array = ormExecuteQuery("from tbl_inc where tbl_nm not in ('liheap','lasset','weather','public housing','section 8')")>

      <cfset struct_mem = structNew()>
      <cfset listable = structNew()>
      <cfset childtable = structNew()>

      <cfloop array="#build_income_array#" index="i">
          <cfset StructInsert(struct_mem, i.getProc_id(), evaluate("i.getMem#householdcount#()"), "true")>
          <cfset StructInsert(listable, i.getProc_id(), evaluate("i.getMem#dependcount#()"), "true")>
          <cfset StructInsert(childtable, i.getProc_id(), evaluate("i.getMem#childcount#()"), "true")>
      </cfloop>
  </cffunction>

  <cffunction name="yeMedicareBuyInAss">
      <cfargument name="rule">
      <cfargument name="self">
      <cfargument name="self_spouse">

      <cfset ReReplace(this.sa.s_asset_auto1,'\.(.*)','','ALL')>
      <cfset reReplaceNoCase(this.sa.s_asset_auto1, '[^[:digit:]]', '', 'ALL') >
      <cfset ReReplace(this.sa.s_asset_home,'\.(.*)','','ALL')>
      <cfset reReplaceNoCase(this.sa.s_asset_home, '[^[:digit:]]', '', 'ALL') >
      <cfset ReReplace(this.sa.s_asset_life_face,'\.(.*)','','ALL')>
      <cfset reReplaceNoCase(this.sa.s_asset_life_face, '[^[:digit:]]', '', 'ALL') >
      <cfset ReReplace(this.sa.s_asset_life_cash,'\.(.*)','','ALL')>
      <cfset reReplaceNoCase(this.sa.s_asset_life_cash, '[^[:digit:]]', '', 'ALL') >

      <cfset ReReplace(this.sa.s_asset_irrevocable,'\.(.*)','','ALL')>
      <cfset reReplaceNoCase(this.sa.s_asset_irrevocable, '[^[:digit:]]', '', 'ALL') >
      <cfset ReReplace(this.sa.s_asset_revocable,'\.(.*)','','ALL')>
      <cfset reReplaceNoCase(this.sa.s_asset_revocable, '[^[:digit:]]', '', 'ALL') >

      <cfif this.sa.marital_stat neq 'married'>
          <cfif this.sa.s_asset_life_face LTE 1500>
              <cfset exclusion = this.sa.s_asset_life_cash>
          <cfelse>
              <cfset exclusion = 0>
          </cfif>

          <cfset X = this.sa.s_asset_life_face + this.sa.s_asset_irrevocable>

          <cfset burialexclusion = MAX((1500-X),0)>

          <cfset exclusion2 = MIN(burialexclusion,this.sa.s_asset_revocable)>

          <cfset exclusion3 = this.sa.s_asset_auto1 + this.sa.s_asset_home>

          <cfset finalfigure = this.sa.s_asset_total_complete - (exclusion + exclusion2 + exclusion3)>

          <cfset valToCompare = self>
      <cfelseif this.sa.marital_stat eq 'married'>
          <cfif this.sa.s_sp_asset_life_face LTE 1500>
              <cfset exclusion = this.sa.s_sp_asset_life_cash>
          <cfelse>
              <cfset exclusion = 0>
          </cfif>

          <cfset X = this.sa.s_sp_asset_life_face + this.sa.s_sp_asset_irrevocable>

          <cfset burialexclusion = MAX((1500-X),0)>

          <cfif this.sa.s_sp_asset_revocable GT burialexclusion>
              <cfif this.ynDoBuffer>
                  <cfset exclusion2 = this.sa.s_sp_asset_revocable - burialexclusion>
              <cfelse>
                  <cfset exclusion2 = burialexclusion>
              </cfif>
          <cfelse>
              <cfset exclusion2 = this.sa.s_sp_asset_revocable>
          </cfif>

          <cfif exclusion EQ ''>
              <cfset exclusion = 0>
          </cfif>

          <cfif exclusion2 EQ ''>
              <cfset exclusion2 = 0>
          </cfif>

          <cfset exclusion3 = this.sa.s_sp_asset_auto1 + this.sa.s_sp_asset_home>

          <cfif exclusion3 EQ ''>
              <cfset exclusion3 = 0>
          </cfif>

          <cfset finalfigure = this.sa.s_sp_asset_total_complete - (exclusion + exclusion2 + exclusion3)>

          <cfset valToCompare = self_spouse>
      </cfif>

      <cfif finalfigure lte valToCompare>
          <cfreturn "YES">
      <cfelse>
          <cfreturn "NO">
      </cfif>
    </cffunction>

  <cffunction name="yeMedicareBuyInInc">
      <cfargument name="rule">
      <cfargument name="self_high">
      <cfargument name="self_low">
      <cfargument name="s_sp_high">
      <cfargument name="s_sp_low">

      <cfif not IsNumeric("#self_high#")>
          <cfset self_high = 0>
      </cfif>

      <cfif not IsNumeric("#s_sp_high#")>
          <cfset s_sp_high = 0>
      </cfif>

      <cfif not IsNumeric("#self_low#")>
          <cfset self_low = 0>
      </cfif>

      <cfif not IsNumeric("#s_sp_low#")>
          <cfset s_sp_low = 0>
      </cfif>

      <cfset table = FINDNOCASE("table", rule, 1)>

      <cfif table EQ 0>
          <cfif this.ynDoBuffer>
              <cfset self_high = self_high+100>
              <cfset s_sp_high = s_sp_high+100>
              <cfset minFigure=0>
          <cfelse>
              <cfset self_high = self_high>
              <cfset s_sp_high = s_sp_high>
              <cfset minFigure=1>
          </cfif>

          <cfif this.sa.MARITAL_STAT NEQ 'married'>
              <cfset spouseEarnedIncome = 0>
              <cfset selfEarnedIncome = this.sa.S_INCOME_EARNED>
              <cfset unearnedIncome = this.sa.S_INCOME_TOTAL_UNEARNED>
              <cfset highfigure = self_high>
              <cfset lowfigure = self_low>
          <cfelse>
              <cfset spouseEarnedIncome = this.sa.SP_INCOME_EARNED>
              <cfset selfEarnedIncome = this.sa.S_SP_INCOME_EARNED - spouseEarnedIncome>
              <cfset unearnedIncome = this.sa.S_SP_INCOME_TOTAL_UNEARNED>
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
          <cfset figure = MAX(((this.sa.S_SP_INCOME_EARNED - this.sa.SP_INCOME_EARNED - 65) / 2),0) + this.sa.SP_INCOME_EARNED>
          <cfif this.ynDoBuffer>
              <cfset figure = MAX((figure - 100),0)>
          </cfif>
          <cfset rule = ReplaceNoCase(rule, "BuyInQI2inc", figure, "ALL")>
          <cfreturn EVALUATE(rule)>
      </cfif>
  </cffunction>

  <cffunction name="yeChildSSIInc">
      <cfargument name="checkState" type="boolean" default="false">

      <cfset childIncomeAdjusted = MAX(((this.sa.ch_income_earned - 65) / 2), 0) + this.sa.ch_income_total_unearned + (this.sa.ch_income_child_support * 0.66666667)>

      <cfif structKeyExists(this.sa,"ch_parent")>
          <cfif this.sa.ch_parent eq 'Y'>
              <cfif this.sa.MARITAL_STAT EQ 'married'>
                  <cfset spouseEarnedIncome = this.sa.SP_INCOME_EARNED>
                  <cfset selfEarnedIncome = this.sa.S_SP_INCOME_EARNED - spouseEarnedIncome>
                  <cfset unearnedIncomeAdjusted = this.sa.S_SP_INCOME_TOTAL_UNEARNED - this.sa.S_SP_INCOME_TANF - this.sa.S_SP_INCOME_CASH_ASSIST - this.sa.S_SP_INCOME_VET_BEN>
                  <cfset tableToCheck = 'married'>
              <cfelse>
                  <cfset spouseEarnedIncome = 0>
                  <cfset selfEarnedIncome = this.sa.S_INCOME_EARNED>
                  <cfset unearnedIncomeAdjusted = this.sa.S_INCOME_TOTAL_UNEARNED - this.sa.S_INCOME_TANF - this.sa.S_INCOME_CASH_ASSIST - this.sa.S_INCOME_VET_BEN>
                  <cfset tableToCheck = 'single'>
              </cfif>
              <cfset selfEarnedIncomeAdjusted = MAX(((selfEarnedIncome - 65) / 2), 0)>
              <cfset parentsIncomeAdjusted = spouseEarnedIncome + selfEarnedIncomeAdjusted + unearnedIncomeAdjusted>
          <cfelse>
              <cfset parentsIncomeAdjusted = 0>
          </cfif>
      <cfelse>
          <cfset parentsIncomeAdjusted = 0>
      </cfif>

      <cfset childcount = this.sa.no_hh_children>
      <cfif childcount eq '' or childcount lt 1>
          <cfset childcount = 1>
      <cfelseif childcount gt 8>
          <cfset childcount = 8>
      </cfif>

      <cfif checkState>
          <cfset passState = this.screening.getPreset_state().getId()>
      <cfelse>
          <cfset passState = 'FD'>
      </cfif>

      <cfif not structKeyExists(this.sa,"CH_PARENT") or this.sa.ch_parent neq 'Y'>
          <cfset answer = this.compareSSILookup(table="child",state=passState,count=childcount,childIncome=childIncomeAdjusted)>
      <cfelseif this.sa.ch_guardian eq 'Y' or this.sa.ch_other eq 'Y'>
          <cfset answer = this.compareSSILookup(table=tableToCheck,state=passState,count=childcount,childIncome=childIncomeAdjusted,parentsIncome=parentsIncomeAdjusted,checkHighIncome="true")>
          <cfif not result>
              <cfset answer = this.compareSSILookup(table="child",state=passState,count=childcount,childIncome=childIncomeAdjusted)>
          </cfif>
      <cfelse>
          <cfset answer = this.compareSSILookup(table=tableToCheck,state=passState,count=childcount,childIncome=childIncomeAdjusted,parentsIncome=parentsIncomeAdjusted,checkHighIncome="true")>
      </cfif>

      <cfreturn answer>
  </cffunction>

  <cffunction name="compareSSILookup">
      <cfargument name="table" type="string">
      <cfargument name="state" type="string" default="FD">
      <cfargument name="count" type="numeric" default="1">
      <cfargument name="childIncome" type="numeric" default="0">
      <cfargument name="parentsIncome" type="numeric" default="0">
      <cfargument name="checkHighIncome" type="boolean" default="false">

      <cfif checkHighIncome and table neq 'child' and this.sa.skipinc EQ 'N'>
          <cfreturn 'NO'>
      <cfelse>
          <cfset totalIncome = childIncome + parentsIncome>
          <cfswitch expression="#table#">
              <cfcase value="child">
                  <cfset query = "from tbl_inc where">
                  <cfif state eq 'MA'>
                      <cfif ch_blind eq 'Y'>
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
                  <cfset inctab = ormExecuteQuery("#query# and state=:state",{tbl_nm=tbl_nm,state=state})>
              </cfcase>
              <cfcase value="single">
                  <cfset query = "from tbl_inc where">
                  <cfif state eq 'MA'>
                      <cfif ch_blind eq 'Y'>
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
                  <cfset inctab = ormExecuteQuery("#query# and state=:state",{tbl_nm=tbl_nm,state=state})>
              </cfcase>
              <cfcase value="married">
                  <cfset query = "from tbl_inc where">
                  <cfif state eq 'MA'>
                      <cfif ch_blind eq 'Y'>
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
                  <cfset inctab = ormExecuteQuery("#query# and state=:state",{tbl_nm=tbl_nm,state=state})>
              </cfcase>
          </cfswitch>
          <cfif totalIncome lte evaluate("inctab[1].getmem#count#()")>
              <cfreturn 'YES'>
          <cfelse>
              <cfreturn 'NO'>
          </cfif>
      </cfif>
  </cffunction>

  <cffunction name="yeSSIInc">
      <cfargument name="self">
      <cfargument name="self_spouse">

      <cfif this.ynDoBuffer>
          <cfset self = self + 100>
          <cfset self_spouse = self_spouse + 100>
      </cfif>

      <cfif this.sa.MARITAL_STAT EQ "Married">
          <cfset spouseEarnedIncome = this.sa.SP_INCOME_EARNED>

          <cfset selfEarnedIncome = this.sa.S_SP_INCOME_EARNED - spouseEarnedIncome>

          <cfset unearnedIncomeAdjusted = this.sa.S_SP_INCOME_TOTAL_UNEARNED - this.sa.S_SP_INCOME_TANF - this.sa.S_SP_INCOME_CASH_ASSIST>

          <cfset valToCheck = self_spouse>
      <cfelse>
          <cfset spouseEarnedIncome = 0>

          <cfset selfEarnedIncome = this.sa.S_INCOME_EARNED>
          <cfset unearnedIncomeAdjusted = this.sa.S_INCOME_TOTAL_UNEARNED - this.sa.S_INCOME_TANF - this.sa.S_INCOME_CASH_ASSIST>
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

  <cffunction name="yePrgFind">
      <cfargument name="rule">
      <cfargument name="tmp_prg_list">

      <cfset StrFullRule = replaceNoCase(rule,"session","this.sa","all")>

      <cfloop index="count" from="1" to="10">
          <cfset CharNumP = FindNoCase("prg",StrFullRule,1)>
          <cfif CharNumP EQ 0>
              <cfreturn Evaluate("#StrFullRule#")>
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
          <cfset prg_id = LEFT(StrFullRule, CharNumCrit - 6)>
          <cfset StrToRemove = Left(StrFullRule, CharNumP + 2)>
          <cfset prg_id = Replace(prg_id, StrToRemove, "")>
          <cfset prg_id = ListQualify(prg_id, "'")>
          <cfif this.ynDoBuffer>
              <cfif ListFindNoCase(tmp_prg_list, prg_id) IS 0 >
                  <cfset strFind = "N">
              <cfelse>
                  <cfset strFind = "Y">
              </cfif>
          <cfelse>
              <cfif ListFindNoCase(tmp_prg_list, prg_id) IS 0 AND
                  ListFindNoCase(this.prg_list, prg_id) IS 0>
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

  <cffunction name="yeSpendDown">
      <cfargument name="rule">
      <cfargument name="EvaluateRule">

      <cfif Not structKeyExists(this.sa,'med_costs') Or this.sa.med_costs eq ''>
          <cfset this.sa.med_costs = 0>
      </cfif>
      <cfset selfEarnedIncomeAdjusted = MAX(((this.sa.S_SP_INCOME_EARNED - this.sa.SP_INCOME_EARNED - 65) / 2),0)>

      <cfif EvaluateRule IS "FALSE">
          <cfset self = gettoken(Rule,2,"-")>
          <cfset self_spouse = gettoken(Rule,3,"-")>
          <cfif this.ynDoBuffer>
              <cfset self = self + 100>
              <cfset self_spouse = self_spouse + 100>
          </cfif>
          <cfif this.sa.MARITAL_STAT EQ "Married">
              <cfset valToCheck = self_spouse>
              <cfset spouseEarnedIncome = this.sa.SP_INCOME_EARNED>
              <cfset selfUnearnedIncome = this.sa.S_SP_INCOME_TOTAL_UNEARNED>
          <cfelse>
              <cfset valToCheck = self>
              <cfset spouseEarnedIncome = 0>
              <cfset selfUnearnedIncome = this.sa.S_INCOME_TOTAL_UNEARNED>
          </cfif>
          <cfset adjustedIncome = spouseEarnedIncome + selfUnearnedIncome + selfEarnedIncomeAdjusted>
          <cfset finalfigure = adjustedIncome - this.sa.med_costs>
          <cfif finalfigure lte valToCheck>
              <cfreturn "YES">
          <cfelse>
              <cfreturn "NO">
          </cfif>
      <cfelse>
          <cfset selfIncomeAdjusted = (this.sa.S_SP_INCOME_TOTAL_UNEARNED - this.sa.SP_INCOME_TOTAL_UNEARNED) + selfEarnedIncomeAdjusted>
          <cfset rest_hh_income = this.sa.HH_INCOME_TOTAL_COMPLETE - (this.sa.S_SP_INCOME_TOTAL_COMPLETE - this.sa.SP_INCOME_TOTAL_COMPLETE)>
          <cfset adjustedIncome = selfIncomeAdjusted + rest_hh_income>
          <cfset finalfigure = adjustedIncome - this.sa.med_costs>
          <cfif this.ynDoBuffer>
              <cfset valStructMem = getToken(rule, 3, " ")>
              <cfif (valStructMem LT FinalFigure) AND (FinalFigure LT (valStructMem + 100))>
                  <cfreturn "YES">
              <cfelse>
                  <cfreturn "NO">
              </cfif>
          <cfelse>
              <cfset Rule = ReplaceNoCase(Rule, "spenddowninc", finalfigure, "ALL")>
              <cfreturn EVALUATE(Rule)>
          </cfif>
      </cfif>
  </cffunction>

</cfcomponent>

