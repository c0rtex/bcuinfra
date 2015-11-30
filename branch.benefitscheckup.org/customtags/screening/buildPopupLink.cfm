
<!---
ERROR CODES
0 : no error
1 : no code or keyword given
2 : no definition found for given input
3 : no text given or determined for link
--->
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.keyword" type="string" default="">
<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.class" type="string" default="">
<cfparam name="attributes.style" type="string" default="">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.error_var" type="string" default="">
<cfparam name="attributes.image" default="">
<cfparam name="attributes.textonly" default="FALSE">
<cfparam name="attributes.debug"  default="false">
     
<cfif IsDefined('SESSION.partner_id') AND (SESSION.partner_id EQ 0 OR SESSION.partner_id EQ 77)>      
	<cfif Not IsDefined ("session.esiDefCt")>	
		<cfset session.esiDefCt = 0>      
     </cfif>
	<cfif not IsDefined('request.popupPool')>
		<cfset request.popupPool = StructNew()>
	</cfif>
	
	<cfset outstr = ''>
	<cfset errorCode = 0>
	
	<!--- if we don't have a code or keyword, throw error code 1 --->
	<cfif attributes.code eq '' and attributes.keyword eq ''>
		<cfset errorCode = 1>
	<cfelse>
		<!--- if we don't have a code, get it from the keyword --->
		<cfif attributes.code eq ''>
			<cf_cacheHelpPool action="getCodeByKeyword" keyword="#attributes.keyword#" var="attributes.code">
		</cfif>
		<!--- if we still don't have a code, throw error code 2 --->
		<cfif attributes.code eq ''>
			<cfset errorCode = 2>
		<cfelse>
			<cfif attributes.text eq ''>
				<cfset attributes.text = attributes.keyword>
			</cfif>
			<cf_cacheHelpPool action="get" code="#attributes.code#" var="hobj">
			<cfif attributes.debug><cfdump var="#hobj#"></cfif>
			<!--- if no help object found, also throw error code 2 --->
			<cfif not hobj.exists>
				<cfset errorCode = 2>
			<cfelse>
				<cfif StructKeyExists(request.popupPool, "help#hobj.id#") AND SESSION.partner_id NEQ 77>
					<cfset popupLinkCount = StructFind(request.popupPool, "help#hobj.id#")>
					<cfset popupLinkIDSuffix = "_#popupLinkCount#">
					<cfset includeFunction = false>
					<cfset StructUpdate(request.popupPool, "help#hobj.id#", popupLinkCount + 1)>
                <cfelse>
                	<cfset popupLinkIDSuffix = ''>
                    <cfset includeFunction = true>
                    <!--- Try this approach next to store unique help for each instance of basic needs and Household in ESI. Use cfoutput or evaluate? --->
                    <cfif session.partner_id eq 77 OR session.partner_id eq 0>
                    	<cfset session.esiDefCt = session.esiDefCt + 1> 
                    	<cfset StructInsert(request.popupPool, "help#hobj.id#_#session.esiDefCt#", 1)>
                    <cfelse>
						<cfset StructInsert(request.popupPool, "help#hobj.id#", 1)>
                    </cfif>
				</cfif>
				<cfif hobj.title eq ''>
					<cfset popTextQS = ''>
				<cfelse>
					<cfset popTextQS = "titlegroup=helptitle&titlecode=#hobj.title#&">
				</cfif>
				<cfif includeFunction>
					<cfif hobj.title eq ''>
						<cfset titleStr = "''">
					<cfelse>
						<cfif attributes.textonly>
							<cf_displayText group="helptitle" code="#attributes.text#" jsEscape="false" isTargetHTML="true" var="titleStr">
						<cfelse>
							<cfif attributes.text neq ''>
					<cfif attributes.debug > 1... helptext Ttiel <cfoutput>code="#attributes.keyword#" </cfoutput></cfif> 			<cf_displayText group="helptitle" code="#hobj.title#" jsEscape="true" isTargetHTML="true" var="titleStr">
                            <cfelse>
                            	<cf_displayText group="helptitle" code="#attributes.keyword#" jsEscape="true" isTargetHTML="true" var="titleStr">
                            </cfif>
						</cfif>
					</cfif>
					
					<cfif attributes.debug > 2... helptext <cfoutput>code="#hobj.text#" </cfoutput></cfif><cf_displayText group="help" code="#hobj.text#" jsEscape="false" isTargetHTML="false" var="textStr">
					
					<cfif attributes.text eq ''>
						<cfif titleStr neq "''">
							<cfset attributes.text = Mid(titleStr, 2, Len(attributes.text) - 2)>
						<cfelse>
							<cfset errorCode = 3>
						</cfif>
					</cfif>
				</cfif>
				<cfif attributes.style neq ''>
					<cfset attributes.style = " style=""#attributes.style#""">
				</cfif>
				<cfif attributes.class neq ''>
					<cfset attributes.class = " class=""#attributes.class#""">
				</cfif>
				<cfif not errorCode>
	            	<cfif attributes.image NEQ "">
	                	<cfsavecontent variable="helpImg">
	                		<cf_displayImage code="#attributes.image#" border="0" alt="#attributes.text#">
	                	</cfsavecontent>
						<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#attributes.style##attributes.class#>#helpImg#</a><script language=""JavaScript"">">
	                <cfelse>
	                	<cfif hobj.text EQ 'help_def_extrahelp'>
							<cfset outstr = '<script>$(function() { $("##show_extra_help_def").click(function() { $("##extra_help_def").toggle(); return false; }); $("##extra_help_def").click(function() { $("##extra_help_def").toggle();$(".questionHolder").removeClass("questionHighlight"); return false; }); });</script><a class="helpTrigger" id="show_extra_help_def" href="javascript:void(0);" style="font-size:14px; clear:right;">Extra Help</a><div style="display: none;" id="extra_help_def" class="helpTip" style="text-align:left;"><h2>Extra Help</h2>People with Medicare who have limited incomes and resources will be eligible to receive Extra Help through the Medicare Prescription Drug Coverage which will cover between 85 percent and 100 percent of prescription drug costs.</div>'>
                        <cfelse>
                        	<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#attributes.style##attributes.class#>#attributes.text#</a>">
                        </cfif>
						
							<!---<cfset outstr = '<a class="helpTrigger helpButton" href="javascript:void(0);">HELP<div style="display: none;" class="helpTip"><h2>Help</h2>' & hobj.text & '</div></a>'>--->
					</cfif>
					<cfif includeFunction>
						<!---<cfset outstr = outstr & "function showPopup#hobj.id#(e) {showPopup(e, #titleStr#, #textStr#);} ">--->
						<cfif Len(titleStr)>
							<cfset titleStr = Left(titleStr,Len(titleStr)-1)>
							<cfset titleStr = RemoveChars(titleStr, 1, 1)>
						</cfif>
						<cfset textStr = ReReplace(textStr, "'", "&rsquo;")>
						<!--- Start Test Capturing Custom Text to show in definitions --->
                        <cfif attributes.text NEQ ''>
							<cfset keywordStr = '#attributes.text#'>
                        </cfif>
							<!---cfset keywordStr = titleStr >
							<cfif keywordStr eq 'Conditions include but are not limited to:'>
                                <cfset keywordStr = 'condition'>
                            <cfelseif keywordStr eq 'Revocable Burial Account'>
                                <cfset keywordStr = 'Burial Accounts: Revocable Burial Account'>
                            <cfelseif keywordStr eq 'Irrevocable Burial Account'>
                                <cfset keywordStr = 'Burial Accounts: Irrevocable Burial Account'>
                            <cfelseif keywordStr eq 'Cash Value'>
                                <cfset keywordStr = 'Life Insurance: Cash Value'>
                            <cfelseif keywordStr eq 'Face Value'>
                                <cfset keywordStr = 'Life Insurance: Face Value'>
                            <cfelseif keywordStr eq 'Legally Blind'>
                                <cfset keywordStr = 'legally blind'>
                            <cfelseif keywordStr eq 'Honorable Discharge'>
                                <cfset keywordStr = 'honorably discharged'>
                            <cfelseif keywordStr eq 'Assistive Technology Devices'>
                                <cfset keywordStr = 'Assistive Technology'>
                            <cfelseif keywordStr eq 'Medical Expenses'>
                                <cfset keywordStr = 'medical expenses'>
                            <cfelseif keywordStr eq 'Dependent'>
                                <!---cfif attributes.code EQ 'esi_depandants_question'>
                                    <cfset keywordStr = 'dependents'>
                                <cfelse--->
                                    <cfset keywordStr = 'dependent'>
                                <!---/cfif--->
                            <cfelseif keywordStr eq 'Disability'>
                                <cfset keywordStr = 'disability'>
                            <cfelseif keywordStr eq 'Household'>
                                <cfif IsDefined('attributes.text') and attributes.text NEQ ''><cfset keywordStr = '#attributes.text#'></cfif>
                            <cfelseif keywordStr eq 'Medicare Advantage Plans'>
                                <cfset keywordStr = 'Medicare Advantage Plan'>
                            <cfelseif keywordStr eq 'Medicare Advantage Plan Types'>
                                <cfset keywordStr = 'HMO, PPO, PFFS'>
                            <cfelseif keywordStr eq 'Developmental Disability'>
                                <cfset keywordStr = 'developmental disability'>
                            <cfelseif keywordStr eq 'Basic Needs'>
                                <cfset keywordStr = 'basic needs'>
                            <cfelseif keywordStr eq 'Line of Credit'>
                                <cfset keywordStr = 'lines of credit'>
                            <cfelseif keywordStr eq 'Public Benefits Programs'>
                                <cfset keywordStr = 'public benefit programs'>
                            <cfelseif keywordStr eq 'Diagnosed Chronic Conditions'>
                                <cfset keywordStr = 'diagnosed chronic conditions'>
                            <cfelseif keywordStr eq 'Equity'>
                                <cfset keywordStr = 'equity'>
                            <cfelseif keywordStr eq 'Eviction'>
                                <cfset keywordStr = 'eviction'>
                            <cfelseif keywordStr eq 'Gross Income'>
                                <cfset keywordStr = 'gross'>
                            <cfelseif keywordStr eq 'Assets'>
                                <cfset keywordStr = 'assets'>
                            <cfelseif keywordStr eq 'Chronic Conditions'>
                                <cfset keywordStr = 'chronic conditions'>
                            <cfelseif keywordStr eq 'Long Term Care Ombudsman'>
                                <cfset keywordStr = 'Long-Term Care Ombudsman'>
                                <cfset titleStr = 'Long-Term Care Ombudsman'>
                            </cfif> 
                      	</cfif--->
						
						<!---cfif keywordStr NEQ 'Life Insurance: Cash Value' AND keywordStr NEQ 'Cash Value'--->
                        	<cfif SESSION.subset_id EQ 0 AND (CGI.SCRIPT_NAME IS '/cf/frmincomegrid.cfm' or CGI.SCRIPT_NAME IS '/cf/frmassetgrid.cfm')>
                            	<cfif attributes.code IS 'def_assets' OR attributes.code IS 'def_gross_income' OR attributes.code IS 'def_household'>
                                	<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;" class="helpTip"><h2>'& titleStr &'</h2>' & textStr & '</div></a>'>	
                                <cfelse>
						<cfset titleStr = Replace(titleStr, "\'", "'", 'ALL')>
						<cfset textStr = Replace(textStr, "\'", "'", 'ALL')>
						
                            		<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;margin-top:250px;" class="helpTip"><h2 style="margin:20px 0 0;">'& titleStr &'</h2>' & textStr & '</div></a>'>
                             	</cfif>
                           	<cfelseif SESSION.partner_id EQ 77 AND SESSION.subset_id EQ 63 AND CGI.SCRIPT_NAME IS '/cf/esi_questions.cfm' AND (attributes.code IS 'def_tanf' OR attributes.code IS 'def_cash_assist' OR attributes.code IS 'def_other_nw' OR attributes.code IS 'def_cash' OR attributes.code IS 'def_auto1' OR attributes.code IS 'def_auto2' OR attributes.code IS 'def_retirement_accounts' OR attributes.code IS 'def_stocks' OR attributes.code IS 'def_revocable' OR attributes.code IS 'def_irrevocable' OR attributes.code IS 'def_other_a')>
                            	<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;margin-top:200px;" class="helpTip"><h2 style="margin:20px 0 0;">'& titleStr &'</h2>' & textStr & '</div></a>'>
                            <cfelse>
								<cfset outstr = '<a class="helpTrigger" href="javascript:void(0);">'& keywordStr &'<div style="display: none;" class="helpTip"><h2>'& titleStr &'</h2>' & textStr & '</div></a>'>
                          	</cfif>
						<!---cfelse>
							<cfset outstr = '<script>$(function() { $("##show_cash_value").click(function() { $("##cash_value").show(); return false; }); $("##cash_value").click(function() { $("##cash_value").hide();$(".questionHolder").removeClass("questionHighlight"); return false; }); });</script><a class="helpTrigger" id="show_cash_value" href="##">Life Insurance: Cash Value</a><div style="display: none;" id="cash_value" class="helpTip"><h2>Cash Value</h2>The amount payable if a life insurance policy is canceled by the insured before it either matures or is payable on death. Cash value is the same amount that may be borrowed by the policy holder while the policy remains in force. The insurance company that issued the life insurance policy can provide the cash value amount of the policy.</div>'>
						</cfif--->
						
						<!---cfif keywordStr EQ 'Household' OR keywordStr EQ 'household'>
							<cfset outstr = '<script>$(function() { $("##show_household").click(function() { $("##household").toggle(); return false; }); $("##household").click(function() { $("##household").toggle();$(".questionHolder").removeClass("questionHighlight"); return false; }); });</script><a class="helpTrigger" id="show_household" href="javascript:void(0);" style="font-size:14px;">#keywordStr#</a><div style="display: none;text-align:left;" id="household" class="helpTip"><h2>Household</h2>The people who live together and usually buy and prepare food together make up one household. If the people who live together do not share food, each person makes up a separate household. Parents and minor children who live together are considered to make up one household, even if they do not share food, unless one of them is age 60 or older or disabled.</div>'>
						</cfif--->
						
						<!---cfif keywordStr EQ 'Extra Help'>
							<cfset outstr = '<script>$(function() { $("##show_extra_help").click(function() { $("##extra_help").toggle(); return false; }); $("##extra_help").click(function() { $("##extra_help").toggle();$(".questionHolder").removeClass("questionHighlight"); return false; }); });</script><a class="helpTrigger" id="show_extra_help" href="javascript:void(0);" style="font-size:14px;">Extra Help</a><div style="display: none;" id="extra_help" class="helpTip" style="text-align:left;"><h2>Extra Help</h2>People with Medicare who have limited incomes and resources will be eligible to receive Extra Help through the Medicare Prescription Drug Coverage which will cover between 85 percent and 100 percent of prescription drug costs.</div>'>
						</cfif--->
						
						
						
						
						
						
						
					</cfif>
					<!---<cfset outstr = outstr & "addEvent(document.getElementById('popupLink#hobj.id##popupLinkIDSuffix#'), 'click', showPopup#hobj.id#, false);</script>">--->
					<cfif attributes.textonly>
	
						<cfif IsDefined('textStr') AND Len(textStr)>
							<!---<cfset textStr = ReReplace(textStr, "'", "")>--->
							<cfset outstr = '<a class="helpTrigger helpButton" href="javascript:void(0);">HELP<div style="display: none;" class="helpTip"><h2>Help</h2>' & textStr & '</div></a>'>
							
						<cfelse>
							<cfset outstr = ''>
						</cfif>
						
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
	
	<cfif attributes.error_var neq ''>
		<cfset "caller.#attributes.error_var#" = errorCode>
	</cfif>
	<cfif outstr eq ''>
		<cfset outstr = attributes.text>
	</cfif>
	
<cfelse>
	<!--- Begin PL Customization --->
	<cfif not IsDefined('request.popupPool')>
		<cfset request.popupPool = StructNew()>
	</cfif>
	
	<cfset outstr = ''>
	<cfset errorCode = 0>
	
	<!--- if we don't have a code or keyword, throw error code 1 --->
	<cfif attributes.code eq '' and attributes.keyword eq ''>
		<cfset errorCode = 1>
	<cfelse>
		<!--- if we don't have a code, get it from the keyword --->
		<cfif attributes.code eq ''>
			<cf_cacheHelpPool action="getCodeByKeyword" keyword="#attributes.keyword#" var="attributes.code">
		</cfif>
		<!--- if we still don't have a code, throw error code 2 --->
		<cfif attributes.code eq ''>
			<cfset errorCode = 2>
		<cfelse>
			<cfif attributes.text eq ''>
				<cfset attributes.text = attributes.keyword>
			</cfif>
			<cf_cacheHelpPool action="get" code="#attributes.code#" var="hobj">
			<!--- if no help object found, also throw error code 2 --->
			<cfif not hobj.exists>
				<cfset errorCode = 2>
			<cfelse>
				<cfif StructKeyExists(request.popupPool, "help#hobj.id#")>
					<cfset popupLinkCount = StructFind(request.popupPool, "help#hobj.id#")>
					<cfset popupLinkIDSuffix = "_#popupLinkCount#">
					<cfset includeFunction = false>
					<cfset StructUpdate(request.popupPool, "help#hobj.id#", popupLinkCount + 1)>
				<cfelse>
					<cfset popupLinkIDSuffix = ''>
					<cfset includeFunction = true>
					<cfset StructInsert(request.popupPool, "help#hobj.id#", 1)>
				</cfif>
				<cfif hobj.title eq ''>
					<cfset popTextQS = ''>
				<cfelse>
					<cfset popTextQS = "titlegroup=helptitle&titlecode=#hobj.title#&">
				</cfif>
				<cfif includeFunction>
					<cfif hobj.title eq ''>
						<cfset titleStr = "''">
					<cfelse>
						<cf_displayText group="helptitle" code="#hobj.title#" jsEscape="true" isTargetHTML="true" var="titleStr">
					</cfif>
						<cf_displayText group="help" code="#hobj.text#" jsEscape="true" isTargetHTML="true" var="textStr">
					<cfif attributes.text eq ''>
						<cfif titleStr neq "''">
							<cfset attributes.text = Mid(titleStr, 2, Len(attributes.text) - 2)>
						<cfelse>
							<cfset errorCode = 3>
						</cfif>
					</cfif>
				</cfif>
				<cfif attributes.style neq ''>
					<cfset attributes.style = " style=""#attributes.style#""">
				</cfif>
				<cfif attributes.class neq ''>
					<cfset attributes.class = " class=""#attributes.class#""">
				</cfif>
				<cfif not errorCode>
	            	<cfif attributes.image NEQ "">
	                	<cfsavecontent variable="helpImg">
	                		<cf_displayImage code="#attributes.image#" border="0" alt="#attributes.text#">
	                	</cfsavecontent>
						<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#attributes.style##attributes.class#>#helpImg#</a><script language=""JavaScript"">">
	                <cfelse>
						<cfset outstr = "<a href=""javascript:help('popText.cfm?#popTextQS#group=help&code=#hobj.text#');"" id=""popupLink#hobj.id##popupLinkIDSuffix#""#attributes.style##attributes.class#>#attributes.text#</a><script language=""JavaScript"">">
					</cfif>
					<cfif includeFunction>
						<cfset outstr = outstr & "function showPopup#hobj.id#(e) {showPopup(e, #titleStr#, #textStr#);} ">
					</cfif>
					<cfset outstr = outstr & "addEvent(document.getElementById('popupLink#hobj.id##popupLinkIDSuffix#'), 'click', showPopup#hobj.id#, false);</script>">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
	
	<cfif attributes.error_var neq ''>
		<cfset "caller.#attributes.error_var#" = errorCode>
	</cfif>
	<cfif outstr eq ''>
		<cfset outstr = attributes.text>
	</cfif>
		
</cfif>		


<cfif attributes.var eq ''><cfsilent>
	</cfsilent><cfoutput>#outstr#</cfoutput><cfsilent>
</cfsilent><cfelse><cfsilent>
	</cfsilent><cfset "caller.#attributes.var#" = outstr><cfsilent>
</cfsilent></cfif>