<cfparam name="attributes.name" type="string">
<cfparam name="attributes.type" type="string" default="">
<cfparam name="attributes.maxlength" type="any" default="">
<cfparam name="attributes.format" type="string" default="">
<cfparam name="attributes.display" type="string" default="">
<cfparam name="attributes.matchval" type="any" default="">
<cfparam name="attributes.onChange" type="string" default="">
<cfparam name="attributes.onChangeYes" type="string" default="">
<cfparam name="attributes.onChangeNo" type="string" default="">
<cfparam name="attributes.onChange0" type="string" default="">
<cfparam name="attributes.onChange1" type="string" default="">
<cfparam name="attributes.onChange2" type="string" default="">
<cfparam name="attributes.onClick" type="string" default="">
<cfparam name="attributes.itemvar" type="string" default="safitem">
<!---2/5/10 MH: param to determine if to add JS checked value to checkbox  --->
<cfparam name="attributes.checkNone" type="string" default="">

<cfif attributes.format eq 'text_hide' or (attributes.type eq 'checkbox' and attributes.format eq 'text_rep_cur_ih_hide_others') or (attributes.type eq 'yn' and attributes.format eq 'text_yn_hide')>
	<cfset suppress=true>
<cfelse>
	<cfset suppress=false>
</cfif>
<cfset afobj = application.AnswerfieldPool.getAnswerfield(attributes.name)>
<cfif attributes.matchval eq ''>
	<cf_handleScreeningAnswerfield action="exists" code="#attributes.name#" var="afExists">
	<cfif afExists>
		<cf_handleScreeningAnswerfield action="get" code="#attributes.name#" element="val" var="attributes.matchval">
	<cfelseif session.screening.prepopulate>
		<cf_handleScreeningAnswerfield action="get" code="#attributes.name#" element="pre" var="attributes.matchval">
	<cfelse>
		<cf_getAnswerfieldDefault code="#attributes.name#" default="" var="attributes.matchval">
	</cfif>
</cfif>
<cfoutput>
	<cfset notApplicable = false>
	<cfswitch expression="#attributes.type#">
		<cfcase value="checkbox">
			<cfset itemtype = 'c'> 
			<!---2/12/10 MH: add onClick in cfelseif to all the answerfields for fit_none_of_the_above* ---> 
			<input type="checkbox" name="#attributes.name#" id="#attributes.name#" value="y"
			<cfif attributes.onClick neq ''> onClick="#attributes.onClick#"
			<cfelseif attributes.checkNone eq 'true'>
				<cfif attributes.name eq 'fit_reasons' or attributes.name eq 'fit_reason1' or attributes.name eq 'fit_reason2' or attributes.name eq 'fit_reason3' or attributes.name eq 'fit_reason4' or attributes.name eq 'fit_reason5' or attributes.name eq 'fit_reason6' or attributes.name eq 'fit_reason7' or attributes.name eq 'fit_reason8'> onClick="javascript:checkNoneJS_1()"
				<cfelseif attributes.name eq 'bath_dress' or attributes.name eq 'see_hear' or attributes.name eq 'chores'> onClick="javascript:checkNoneJS_9()"
				<cfelseif attributes.name eq 'fit_none_of_the_above'> onClick="javascript:checkNone_and_Invisible(9)"
				<cfelseif attributes.name eq 'fit_friend' or attributes.name eq 'fit_paid_helper_caregiver'> onClick="javascript:checkNoneJS_11()"
				<cfelseif attributes.name eq 'fit_none_of_the_above2'> onClick="javascript:checkNone_and_Invisible(11)"
				</cfif>
			</cfif><cfif attributes.matchval eq 1> checked="checked"</cfif> style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;"> <cf_displayText code="#attributes.display#" group="answerfield" suppress="#suppress#">
		</cfcase>
        <cfcase value="hiddenfield">
        	<cfset itemtype = 'y'> 
        	<input type="hidden" id="#attributes.name#" name="#attributes.name#" value="<cfif attributes.matchval is 0>n<cfelse>y</cfif>" />
        </cfcase>
	<cfcase value="hiddenfieldZero">
		<cfset itemtype = 'i'> 
        	<input type="hidden" id="#attributes.name#" name="#attributes.name#" value="0" />
        </cfcase>
		<cfcase value="currency">
			<cfset itemtype = 'n'>
			<cfif attributes.maxlength eq ''>
				<cfset afMaxLength = 64>
				<cfset afSize = 32>
			<cfelse>
				<cfset afMaxLength = attributes.maxlength>
				<cfif attributes.maxlength gt 31>
					<cfset afSize = 32>
				<cfelse>
					<cfset afSize = attributes.maxlength + 1>
				</cfif>
			</cfif>
			<cfif session.subset_id NEQ 63 and session.partner_id neq 77>
				<cfif attributes.format eq 'text_rep_cur_ih' or attributes.format eq 'text_rep_cur_ih_hide_others'>
                    I have: &nbsp;
                <cfelse>
                    <cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
                </cfif>
                $ <input type="text" id="#attributes.name#" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" maxlength="#afMaxLength#" size="#afSize#"> 
           	<cfelse>
            	<cfif attributes.name EQ 'receive_msp_amount' OR attributes.name EQ 'receive_lis_amount' OR attributes.name EQ 'receive_snap_amount' OR attributes.name EQ 'receive_liheap_amount' OR attributes.name EQ 'receive_medicaid_amount' OR attributes.name EQ 'receive_property_tax_amount' OR attributes.name EQ 'esi_outofpocket' OR attributes.name EQ 'esi_food' OR attributes.name EQ 'esi_healthmonthly' OR attributes.name EQ 'esi_transportation' OR attributes.name EQ 'esi_other_expenses' OR attributes.name EQ 'esi_debtestimate'>
                	<div><span style="float:left;">$&nbsp;</span><span><input type="text" id="#attributes.name#" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" maxlength="#afMaxLength#" size="#afSize#" onBlur="chkDollar(this,value);"></span><cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#"></div>
                <cfelse>
            		<div><span style="float:left;">$&nbsp;</span><span><input type="text" id="#attributes.name#" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" maxlength="#afMaxLength#" size="#afSize#"></span><cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#"></div>
                </cfif>
            </cfif>
		</cfcase>
		<cfcase value="day">
			<cfset itemtype = 'n'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<select name="#attributes.name#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
				<option value="">-- day --
			<cfloop from="1" to="31" index="x">
				<option value="#x#"<cfif attributes.matchval eq x> selected</cfif>>#x#
			</cfloop>
			</select>
            <cfif session.subset_id eq 63 and session.partner_id eq 77>
            	<BR />
            </cfif>
		</cfcase>
		<cfcase value="integer">
			<cfset itemtype = 'n'>
			<cfif attributes.maxlength eq ''>
				<cfset afMaxLength = 64>
				<cfset afSize = 32>
			<cfelse>
				<cfset afMaxLength = attributes.maxlength>
				<cfif attributes.maxlength gt 31>
					<cfset afSize = 32>
				<cfelse>
					<cfset afSize = attributes.maxlength + 1>
				</cfif>
			</cfif>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="text" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" maxlength="#afMaxLength#" size="#afSize#">
		</cfcase>
		<cfcase value="month">
			<cfset itemtype = 'n'>
			<!--- The "or true" below will temporarily set the month answerfieldtype to only display 3-letter months --->
			<cfif attributes.format eq 'mon_yearnow_pm' or true>
				<cfset dispcode = 'calendar_month_short_'>
			<cfelse>
				<cfset dispcode = 'calendar_month_'>
			</cfif>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<select id="month" name="#attributes.name#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
				<option value="">-- month --
			<cfloop from="1" to="12" index="x">
				<option value="#x#"<cfif attributes.matchval eq x> selected</cfif>><cf_displayText code="#dispcode##x#" group="calendar">
			</cfloop>
			</select>
		</cfcase>
		<cfcase value="no">
			<cfset itemtype = 'c'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="checkbox" name="#attributes.name#" value="y"<cfif attributes.matchval eq 1> checked</cfif> style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;"> No
		</cfcase>
		<cfcase value="state">
			<cfset itemtype = 's'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<cf_buildStateSelect name="#attributes.name#" default="#attributes.matchval#">
		</cfcase>
        <cfcase value="checkboxes_with_none">
        
        </cfcase>
		<cfcase value="select">
			<cfset itemtype = 'o'>
			<cfif attributes.format eq 'radio_stack'>
            	<cfif session.subset_id is 61>
                    <cf_loopPoolStruct struct="afobj" index="option">
                        <cfset optObj = application.OptionPool.getOption(option)>
                        <div style="<cfif findNoCase("Firefox",CGI.HTTP_USER_AGENT)>height:18px;</cfif>"><input type="radio" name="#attributes.name#" style="margin:0px;padding:0px;" value="#optobj.id#-#option#"<cfif attributes.matchval eq optobj.id> checked </cfif>>&nbsp;<cf_displayText group="option" code="option_#option#"></div>
                    </cf_loopPoolStruct>
                <cfelse>
                	<table border="0" cellspacing="0" cellpadding="0">
					<!---<tr style="height:5;">&nbsp;<td></td></tr>--->
                    <cf_loopPoolStruct struct="afobj" index="option">
                        <cfset optObj = application.OptionPool.getOption(option)>
                        <cfif session.subset_id EQ 63>
                        	<tr style="font-family: arial, helvetica, sans-serif; font-size: 14px; color: black;">
                        <cfelse>
	                        <tr style="height:18;font-family: verdana, arial, helvetica, sans-serif; font-size: <cfif session.subset_id IS 61>12px<cfelse>11pt</cfif>; color: black;">
                       	</cfif>
                        
                            <td valign="top"><input type="radio" name="#attributes.name#" style="margin:0px;padding:0px;" value="#optobj.id#-#option#"<cfif attributes.matchval eq optobj.id> checked</cfif>></td>
                            <td valign="top">&nbsp;</td>
                            <td valign="top"><cf_displayText group="option" code="option_#option#"></td>
                        </tr>
                    </cf_loopPoolStruct>
                    </table>
                </cfif>
				
			<cfelseif attributes.format eq 'radio_string'>
				<cfset track = 0>
				<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
				<cf_cacheRulePool action="get" code="#afobj.rule#" var="robj">
				<cf_testCondition condition="#robj.text#" var="isApplicable">
				<cfif isApplicable eq 2>
					<cf_loopPoolStruct struct="afobj" index="option">
						<cfset optObj = application.OptionPool.getOption(option)>
						<cfif track> &nbsp; </cfif><input id="radio_#track#_#attributes.name#" type="radio" name="#attributes.name#" value="#optobj.id#-#option#"<cfif track eq 0 and attributes.onChange0 neq ''> onChange="#attributes.onChange0#"<cfelseif track eq 1 and attributes.onChange1 neq ''> onChange="#attributes.onChange1#"<cfelseif track eq 2 and attributes.onChange2 neq ''> onChange="#attributes.onChange2#"</cfif><cfif attributes.matchval eq optobj.id> checked</cfif>> <cf_displayText group="option" code="option_#option#">
						<cfset track = track + 1>
					</cf_loopPoolStruct>
				<cfelse>
					<i>not applicable</i><input id="radio_0_#attributes.name#" type="hidden" name="#attributes.name#" value="0-n"><input id="radio_1_#attributes.name#" type="hidden" name="zzz_ignore_#attributes.name#" value=""><input id="radio_2_#attributes.name#" type="hidden" name="zzzz_ignore_#attributes.name#" value="">
					<cfset notApplicable = true>
				</cfif>
			<cfelse>
            	<cfif session.subset_id EQ 63>
                	<cfif attributes.name EQ 'esi_help_reason'>
						<cfset selectWidth = '550px'>     
                    <cfelseif attributes.name EQ 'esi_marital'>          
                    	<cfset selectWidth = '190px'>  
                   	<cfelseif attributes.name EQ 'esi_ethnicity'>          
                    	<cfset selectWidth = '280px'>   
                   	<cfelseif attributes.name EQ 'esi_housingtype'>          
                    	<cfset selectWidth = '210px'>    
                  	</cfif>
                </cfif>
				<select id="select_#attributes.name#" name="#attributes.name#" style="<cfif IsDefined('selectWidth')>width:#selectWidth#; </cfif>font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;"<cfif attributes.onChange neq ''> onChange="#attributes.onChange#"</cfif>>
					<option value="">- Select -</option>
				<cf_loopPoolStruct struct="afobj" index="option">
					<cfset optObj = application.OptionPool.getOption(option)>
					<option value="#optobj.id#-#option#"<cfif attributes.matchval eq optobj.id> selected</cfif>><cf_displayText group="option" code="option_#option#"></option>
                </cf_loopPoolStruct>
				</select>
			</cfif>
		</cfcase>
        <cfcase value="gender">
        	<cfset itemtype = 's'>
			<cf_displayText group="option" code="option_male" var="maleText">
			<cf_displayText group="option" code="option_female" var="femaleText">
            <span style="margin-right:10px;font-size:12px;"><input type="radio" name="#attributes.name#" value="M"<cfif attributes.matchVal Eq 2 OR attributes.matchVal Eq "M"> checked</cfif>>#maleText#</span>
            <span style="font-size:12px;"><input type="radio" name="#attributes.name#" value="F"<cfif attributes.matchVal Eq 3 OR attributes.matchVal Eq "F"> checked</cfif>>#femaleText#</span>
		</cfcase>
		<cfcase value="ssn">
			<cfset itemtype = 's'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="text" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" size="12" maxlength="11"><br>
			<span style="font-size: 9pt; font-style: italic">######-####-########</span>
		</cfcase>
		<cfcase value="text">
			<cfset itemtype = 's'>
			<cfif attributes.maxlength eq ''>
				<cfset afMaxLength = 64>
				<cfset afSize = 32>
			<cfelse>
				<cfset afMaxLength = attributes.maxlength>
				<cfif attributes.maxlength gt 31>
					<cfset afSize = 32>
				<cfelse>
					<cfset afSize = attributes.maxlength + 1>
				</cfif>
			</cfif>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
            <!--- MH: Bug 5412 6/07/10 display '8' for HCS Agency ID/fit_agency_id field in fit questionnaire --->
			<cfif attributes.name eq "fit_agency_id">8</cfif>
			<!--- MH: END --->
			<input type="text" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" maxlength="#afMaxLength#" size="#afSize#">
		</cfcase>
        <cfcase value="textarea">
			<cfset itemtype = 's'>
			<cfif attributes.maxlength eq ''>
				<cfset afMaxLength = 64>
				<cfset afSize = 32>
			<cfelse>
				<cfset afMaxLength = attributes.maxlength>
				<cfif attributes.maxlength gt 31>
					<cfset afSize = 32>
				<cfelse>
					<cfset afSize = attributes.maxlength + 1>
				</cfif>
			</cfif>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
            <textarea name="#attributes.name#" size="#afSize#">
            	#HTMLEditFormat(attributes.matchval)#
            </textarea>
			<!--- <input type="text" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" size="#afSize#"> --->
		</cfcase>
		<cfcase value="year">
			<cfset itemtype = 'n'>
			<!--- The "or true" below will temporarily set the year answerfieldtype to only display the current year +/- 1 --->
			<cfif attributes.format eq 'mon_yearnow_pm'>
				<cfset startYear = Year(Now()) - 1>
				<cfset endYear = Year(Now()) + 1>
			<cfelse>
				<cfset startYear = 1900>
				<cfset endYear = Year(Now())>
			</cfif>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<select id="year" name="#attributes.name#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
				<option value="">-- year --
			<cfloop from="#startYear#" to="#endYear#" index="x">
				<option value="#x#"<cfif attributes.matchval eq x> selected</cfif>>#x#
			</cfloop>
			</select>
		</cfcase>
		<cfcase value="yes">
			<cfset itemtype = 'c'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="checkbox" name="#attributes.name#" value="y"<cfif attributes.matchval eq 1> checked</cfif> style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;"> Yes
		</cfcase>
        <cfcase value="ny">
        	<cfset itemtype = 'y'>
            <cfset ynCount = 0>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
            	<cf_loopPoolStruct struct="afobj" index="option">
					<cfset optObj = application.OptionPool.getOption(option)>
                    <cfif ynCount IS 0 AND attributes.matchval is 0>
						<cfset checkedBool = true>
                    <cfelseif ynCount is 1 AND attributes.matchval is 1>
                        <cfset checkedBool = true>
                    <cfelse>
                        <cfset checkedBool = false>
                    </cfif>
                    <cfif attributes.format IS "fit_specify_on_no">
                 		<cfif ynCount>&nbsp;</cfif><input id="radio_<cfif ynCount IS 0>no<cfelseif ynCount IS 1>yes</cfif>_#attributes.name#" type="radio" name="#attributes.name#" value="<cfif ynCount IS 0>n<cfelseif ynCount IS 1>y</cfif>"<cfif checkedBool> checked</cfif><cfif attributes.onClick neq ''> onclick="#attributes.onClick#"</cfif><cfif ynCount IS 0><cfif attributes.onChangeYes neq ''> onchange="#attributes.onChangeNO#"</cfif><cfelseif ynCount is 1><cfif attributes.onChangeNo neq ''> onchange="#attributes.onChangeYes#"</cfif></cfif>>
                    <cfelse>
                    	<cfif ynCount>&nbsp;</cfif><input id="radio_<cfif ynCount IS 0>no<cfelseif ynCount IS 1>yes</cfif>_#attributes.name#" type="radio" name="#attributes.name#" value="<cfif ynCount IS 0>n<cfelseif ynCount IS 1>y</cfif>"<cfif checkedBool> checked</cfif><cfif attributes.onClick neq ''> onclick="#attributes.onClick#"</cfif><cfif ynCount IS 0><cfif attributes.onChangeYes neq ''> onchange="#attributes.onChangeNO#"</cfif><cfelseif ynCount is 1><cfif attributes.onChangeNo neq ''> onchange="#attributes.onChangeYes#"</cfif></cfif>>
                    </cfif>
                    <cf_displayText group="option" code="option_#option#">
                    <cfset ynCount++>
                </cf_loopPoolStruct>
        </cfcase>
        <cfcase value="nyd">
        	<cfset itemtype = 'y'>
            <cfset ynCount = 0>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<cf_cacheRulePool action="get" code="#afobj.rule#" var="robj">
			<cf_testCondition condition="#robj.text#" var="isApplicable">

            	<cf_loopPoolStruct struct="afobj" index="option">
					<cfset optObj = application.OptionPool.getOption(option)>
                    <cfif ynCount IS 0 AND attributes.matchval is 0>
						<cfset checkedBool = true>
                    <cfelseif ynCount is 1 AND attributes.matchval is 1>
                        <cfset checkedBool = true>
                    <cfelseif ynCount is 2 AND attributes.matchval is 2469>
                    <cfelse>
                        <cfset checkedBool = false>
                    </cfif>
		    		<div style="<cfif findNoCase("Firefox",CGI.HTTP_USER_AGENT)>height:18px;</cfif>">&nbsp;&nbsp;&nbsp;<input id="radio_<cfif ynCount IS 0>no<cfelseif ynCount IS 1>yes<cfelseif ynCount IS 2>dontknow</cfif>_#attributes.name#" type="radio" name="#attributes.name#" style="margin:0px;padding:0px;" value="<cfif ynCount IS 0>n<cfelseif ynCount IS 1>y<cfelseif ynCount IS 2>dontknow</cfif>"<cfif checkedBool or attributes.matchval is "1474"> checked</cfif><cfif attributes.onClick neq ''> onclick="#attributes.onClick#"</cfif><cfif ynCount IS 0><cfif attributes.onChangeYes neq ''> onchange="#attributes.onChangeNO#"</cfif><cfelseif ynCount is 1><cfif attributes.onChangeNo neq ''> onchange="#attributes.onChangeYes#"</cfif></cfif>>&nbsp;<cf_displayText group="option" code="option_#option#"></div>
                    
					<cfif ynCount is 1>
                        <cfset partInsYes = application.AnswerfieldPool.getAnswerfield('fit_married_partner_ins_yes')>
                        <div id="partner_ins" style="vertical-align:top;font-size:12px;<cfif findNoCase("Firefox",CGI.HTTP_USER_AGENT)>text-indent:33px;display:none;height:22px;<cfelse>margin-left:41px;display:none;height:18px;</cfif>">
                            <cf_displayText code="answerfield_fit_married_partner_ins_yes" group="answerfield" spaceafter="true"><cf_buildAnswerfield name="fit_married_partner_ins_yes" type="#partInsYes.type#" maxlength="#partInsYes.length#" display=""> 
                        </div>
                    </cfif>
                    <cfset ynCount++>
                </cf_loopPoolStruct>
        </cfcase>
		<cfcase value="yn">
			<cfset itemtype = 'y'>
            <cfset ynCount = 0>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<cf_cacheRulePool action="get" code="#afobj.rule#" var="robj">
			<cf_testCondition condition="#robj.text#" var="isApplicable">
			<cfif isApplicable eq 2>
            	<cfif session.subset_id IS 61 AND attributes.name NEQ "fit_counseling" AND attributes.name NEQ "fit_bcu_assessment">
                <cf_loopPoolStruct struct="afobj" index="option">
					<cfset optObj = application.OptionPool.getOption(option)>
                    <cfif ynCount IS 0 AND attributes.matchval is 0>
						<cfset checkedBool = true>
                    <cfelseif ynCount is 1 AND attributes.matchval is 1>
                        <cfset checkedBool = true>
                    <cfelse>
                        <cfset checkedBool = false>
                    </cfif>
                    <cfif attributes.format IS "fit_specify_on_no">
                 		<cfif ynCount>&nbsp;</cfif><input id="radio_<cfif ynCount IS 0>no<cfelseif ynCount IS 1>yes</cfif>_#attributes.name#" type="radio" name="#attributes.name#" value="<cfif ynCount IS 0>n<cfelseif ynCount IS 1>y</cfif>"<cfif checkedBool> checked</cfif><cfif attributes.onClick neq ''> onclick="#attributes.onClick#"</cfif><cfif ynCount IS 0><cfif attributes.onChangeYes neq ''> onchange="#attributes.onChangeNO#"</cfif><cfelseif ynCount is 1><cfif attributes.onChangeNo neq ''> onchange="#attributes.onChangeYes#"</cfif></cfif>>
                    <cfelse>
                    	<cfif ynCount>&nbsp;</cfif><input id="radio_<cfif ynCount IS 0>no<cfelseif ynCount IS 1>yes</cfif>_#attributes.name#" type="radio" name="#attributes.name#" value="<cfif ynCount IS 0>n<cfelseif ynCount IS 1>y</cfif>"<cfif checkedBool> checked</cfif><cfif attributes.onClick neq ''> onclick="#attributes.onClick#"</cfif><cfif ynCount IS 0><cfif attributes.onChangeYes neq ''> onchange="#attributes.onChangeNO#"</cfif><cfelseif ynCount is 1><cfif attributes.onChangeNo neq ''> onchange="#attributes.onChangeYes#"</cfif></cfif>>
                    </cfif>
                    <cf_displayText group="option" code="option_#option#">
                    <cfset ynCount++>
                </cf_loopPoolStruct>
                <cfelseif session.subset_id IS 61 AND attributes.name EQ "fit_counseling">
                	<cfset cCount = 0>
                	<cf_loopPoolStruct struct="afobj" index="option">
						<cfset optObj = application.OptionPool.getOption(option)>
                        <cfif cCount is 0>
                        	<cfset noOption = option>
                        <cfelseif cCount is 1>
                        	<cfset yesOption = option>
                        </cfif>
                        <cfset cCount++>
                    </cf_loopPoolStruct>
                     <table style="font-size:12px;margin-left:20px;" cellpadding="0">
                    	<tr valign="top" >
                        	<td width="50" valign="top">
								<table style="font-size:12px;">
                                	<tr valign="top">
                                    	<td>
											<input id="radio_yes_#attributes.name#" type="radio" name="#attributes.name#" value="y"<cfif attributes.matchval eq 1> checked</cfif><cfif attributes.onClick neq ''> onClick="#attributes.onClick#"</cfif><cfif attributes.onChangeYes neq ''> onChange="#attributes.onChangeYes#"</cfif>>                						</td>
                                        <td>
                                        	<cf_displayText group="option" code="option_#yesOption#">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100" valign="top">
                            	<table style="font-size:12px;" width="300">
                                	<tr valign="top">
                                    	<td>
                    						<input id="radio_no_#attributes.name#" type="radio" name="#attributes.name#" value="n"<cfif attributes.matchval eq 0> checked</cfif><cfif attributes.onClick neq ''> onClick="#attributes.onClick#"</cfif><cfif attributes.onChangeNo neq ''> onChange="#attributes.onChangeNo#"</cfif>>
                						</td>
                                        <td>
                                        	<cf_displayText group="option" code="option_#noOption#">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                <cfelse>
                	<cfif session.subset_id IS 61><div style="font-size:12px;" class="yes_or_no_radio"></cfif>
					<input id="radio_yes_#attributes.name#" type="radio" name="#attributes.name#" value="y"<cfif attributes.matchval eq 1> checked</cfif><cfif attributes.onClick neq ''> onClick="#attributes.onClick#"</cfif><cfif attributes.onChangeYes neq ''> onChange="#attributes.onChangeYes#"</cfif>> Yes
					&nbsp; <input id="radio_no_#attributes.name#" type="radio" name="#attributes.name#" value="n"<cfif attributes.matchval eq 0> checked</cfif><cfif attributes.onClick neq ''> onClick="#attributes.onClick#"</cfif><cfif attributes.onChangeNo neq ''> onChange="#attributes.onChangeNo#"</cfif>> No
					<cfif session.subset_id IS 61></div></cfif>
                </cfif>
            <cfelse>
				<i>not applicable</i><input id="radio_yes_#attributes.name#" type="hidden" name="#attributes.name#" value="n"><input id="radio_no_#attributes.name#" type="hidden" name="zzz_ignore_#attributes.name#" value="">
				<cfset notApplicable = true>
			</cfif>
		</cfcase>
		<cfcase value="ynd">
			<cfset itemtype = 'y'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="radio" name="#attributes.name#" value="y"<cfif attributes.matchval eq 1> checked</cfif>> Yes
			&nbsp; <input type="radio" name="#attributes.name#" value="n"<cfif attributes.matchval eq 0> checked</cfif>> No
			&nbsp; <input type="radio" name="#attributes.name#" value="dontknow"<cfif attributes.matchval eq 1474> checked</cfif>> Don't know
		</cfcase>
		<cfcase value="yns">
			<cfset itemtype = 'y'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="radio" name="#attributes.name#" value="y"<cfif attributes.matchval eq 1> checked</cfif>> Yes
			&nbsp; <input type="radio" name="#attributes.name#" value="n"<cfif attributes.matchval eq 0> checked</cfif>> No
			&nbsp; <input type="radio" name="#attributes.name#" value="notsure"<cfif attributes.matchval eq 1462> checked</cfif>> Don't know
		</cfcase>
        <cfcase value="ynns">
			<cfset itemtype = 'y'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="radio" name="#attributes.name#" value="y"<cfif attributes.matchval eq 1> checked</cfif>> Yes
			&nbsp; <input type="radio" name="#attributes.name#" value="n"<cfif attributes.matchval eq 0> checked</cfif>> No or Not Sure
		</cfcase>
		<cfcase value="zipcode">
			<cfset itemtype = 's'>
            
        	<cfif session.subset_id is 61>
            	
             
             <!---
					///
					///
					///
				--->
                
                <script language="javascript">
					<!--
					var zyxzip_#attributes.name#_save = '#attributes.matchval#';
					var stcode = '';
					// -->
		
				</script>
                <cfquery name="getStateName" datasource="#application.dbSrc#">
                	SELECT state_id
					FROM zip
					where zipcode="#attributes.matchval#"
				</cfquery>	
                <cfif getStateName.RecordCount EQ 1>
                	<cfset boxVal = '#getStateName.state_id#'>
              	<cfelse>
                	<cfset boxVal = 'n/a'>
               	</cfif>
                
				<cfset boxColor = "##666666">
				<cfset boxBack = "##dddddd">
                <input type="hidden" name="zyxzip_#attributes.name#_change" value="" />
                <input type="text" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" size="6" maxlength="5" onKeyUp="
					
						if (this.value.length == 5) {
                        	var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(this.value);
							if(!isValidZip){alert('You must enter a valid zipcode containing all numbers. Please try again');this.value='';return false};
                            var zipEl = this.form.zyxzip_#attributes.name#_abbrev;
                            myVal = this.value;
                            THAT = this
                            $.ajax({
                                url: '/cf/com/bcu/ZipFunctions.cfc?method=getStateFromZip',
                                datatype:'json',
                                data: 'zipcode='+myVal, 
                                cache:false,
                                success: function(StateId){
                                    var newcode = eval('('+StateId+')');
                                    stcode = '';
                                    stname = '';
                                    if(!newcode || StateId == 'false'){
                                    	alert(THAT.value + ' is an invalid zip code.  Please try again.');
                                        THAT.value = zyxzip_#attributes.name#_save;
                                    	zipEl.value = '??';
										zipEl.style.color = 'black';
										zipEl.style.background = '##ffcccc';
                                        return false;
                                    }else{
                                    	stcode = newcode.DATA[0][0];
                                        stname = newcode.DATA[0][1];
                                        zipEl.value = stcode;
                                        zipEl.style.color = 'black';
                                        if (stcode == '#session.state_id#'){
                                            zipEl.style.background = '##ccffcc';
                                        }else{
                                            zipEl.style.background = '##ccccff';
                                        }
                                    };
                                    
                                }
                            });
						} else {
							stcode = '';
							this.form.zyxzip_#attributes.name#_abbrev.value = 'n/a';
							this.form.zyxzip_#attributes.name#_abbrev.style.color = '##666666';
							this.form.zyxzip_#attributes.name#_abbrev.style.background = '##dddddd';
						}
						var changecode = this.form.zyxzip_#attributes.name#_change.value;
						if (stcode == '' && changecode != '')
							this.form.zyxzip_#attributes.name#_change.value = '';
						else if (stcode != '')
							this.form.zyxzip_#attributes.name#_change.value = stcode;
					
					" onBlur="
								
						<!---alert('Blur ' + zyxzip_#attributes.code#_save + ' : ' + this.value);--->
						if (zyxzip_#attributes.name#_save != this.value) {
							<!---alert('values have changed');--->
								<!---alert('zip looks valid');--->
                                 $.ajax({
                                    url: '/cf/com/bcu/ZipFunctions.cfc?method=isZipInState',
                                    datatype:'json',
                                    data: 'zipcode='+this.value+'&state_id=#session.state_id#', 
                                    cache:false,
                                    success: function(StateId){
                                        var newcode = eval('('+StateId+')');
                                        if(!newcode){
                                        
                                        }else{
                                        	zyxzip_#attributes.name#_save = this.value;
                                        }
                                    }
                                });
						} else {
							<!---alert('values still same');--->
						}
						
					">&nbsp;<input type="text" name="zyxzip_#attributes.name#_abbrev" size="2" value="#boxVal#" disabled style="font-size: 7pt; font-weight: bold; color: #boxColor#; background: #boxBack#; border-width: 1px; border-color: black; border-style: dotted;">
            <cfelse>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<input type="text" name="#attributes.name#" value="#HTMLEditFormat(attributes.matchval)#" size="6" maxlength="5">
            </cfif>
		</cfcase>
        <cfcase value="good_fair_poor">
			<cfset itemtype = 'o'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<select name="#attributes.name#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
            	<option value="">- Select -</option>
                <option<cfif attributes.matchval is 1> selected</cfif> value="1">Good</option>
                <option<cfif attributes.matchval is 2> selected</cfif> value="2">Fair</option>
                <option<cfif attributes.matchval is 3> selected</cfif> value="3">Poor</option>
            </select>
		</cfcase>
        <cfcase value="10_10-25_25plus">
			<cfset itemtype = 'o'>
			<cf_displayText code="#attributes.display#" group="answerfield" spaceafter="true" suppress="#suppress#">
			<select name="#attributes.name#" style="font-family: verdana, arial, helvetica, sans-serif; font-size: 9pt; color: black;">
            	<option value="">- Select -</option>
                <option<cfif attributes.matchval is 1> selected</cfif> value="1">Less than 10 years old</option>
                <option<cfif attributes.matchval is 2> selected</cfif> value="2">10-25 years old</option>
                <option<cfif attributes.matchval is 3> selected</cfif> value="3">More than 25 years old</option>
            </select>
		</cfcase>
		<cfdefaultcase>
			#attributes.type#: #attributes.name# (#afobj.id#)
			<cfset itemtype = 's'>
		</cfdefaultcase>
	</cfswitch>
</cfoutput>
<cfif notApplicable>
	<cfset "caller.#attributes.itemvar#" = ''>
<cfelse>
	<cfset "caller.#attributes.itemvar#" = "#itemtype#-#attributes.name#">
</cfif>