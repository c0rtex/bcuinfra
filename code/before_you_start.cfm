<cfparam name="preserve" type="boolean" default="false">
<cfset hasRadio = false>
<!--- Initialize and load any session variable value passed into this page --->
<!--- Call header tag --->
<cf_sessionLoadVars>
<!--- trying new CFC to load session vars... 
<cfset loadSessionVars = CreateObject("component","com.bcu.sessionLoadVars").init()>--->
<cf_tagHeader show_title="yes">
<cfif session.subset_id eq 1>
	<cfset neededURL = "neededinfo-rx.cfm">
<cfelseif session.subset_id eq 3>
	<cfset neededURL = "neededinfo-3.cfm">	
<cfelseif session.subset_id eq 12>
	<cfset neededURL = "neededinfo-card.cfm">
<cfelseif session.subset_id eq 14>
	<cfset neededURL = "neededinfo-lis.cfm">
<cfelseif session.subset_id eq 18 or session.subset_id eq 22 Or (Not Preserve And session.subset_id eq 19)>
	<cfset neededURL = "neededinfo-aoa.cfm">
<cfelseif session.subset_id eq 21>
	<cfset neededURL = "neededinfo-il.cfm">
<cfelseif session.subset_id eq 27>
	<cfset neededURL = "neededinfo-27.cfm">
<cfelseif session.subset_id eq 34>
	<cfset neededURL = "neededinfo-wom.cfm">
<cfelseif session.subset_id eq 35>
	<cfset neededURL = "neededinfo-35.cfm">
<cfelseif session.subset_id eq 36>
	<cfset neededURL = "neededinfo-36.cfm">
<cfelseif session.subset_id eq 37>
	<cfset neededURL = "neededinfo-37.cfm">
<cfelseif session.subset_id eq 38>
	<cfset neededURL = "neededinfo-38.cfm">
<cfelseif session.subset_id eq 39>
	<cfset neededURL = "neededinfo-39.cfm">
<cfelseif session.subset_id eq 44>
	<cfset neededURL = "neededinfo-44.cfm">
<cfelseif session.subset_id eq 49>
	<cfset neededURL = "neededinfo-49.cfm">
<cfelseif session.subset_id eq 49>
	<cfset neededURL = "neededinfo-49.cfm">
<cfelseif session.subset_id eq 51>
	<cfset neededURL = "neededinfo-51.cfm">
<cfelseif session.subset_id eq 57>
	<cfset neededURL = "neededinfo-57.cfm">		
<cfelseif session.subset_id eq 59>
	<cfset neededURL = "neededinfo-59.cfm">	
<!--- MH: 6/28/10 Bug 5476 --->
<cfelseif session.subset_id eq 62>
	<cfset neededURL = "neededinfo-62.cfm">	
<cfelse>
	<cfset neededURL = "neededinfo.cfm">
</cfif>
<cfif session.partner_id eq 14 or session.partner_id eq 15>
	<cfset imgExt = '-mmm'>
<cfelse>
	<cfset imgExt = ''>
</cfif>
<cfif session.partner_id eq 25>
	<cfinclude template="index_pfizer.cfm">
<cfelseif session.partner_id eq 27>
	<cfinclude template="index_rmc.cfm">
<cfelseif session.partner_id eq 28>
	<cfinclude template="index_windsor.cfm">
<cfelseif session.partner_id eq 30>
	<cfinclude template="index_coventry.cfm">
<cfelse>
	<!--- Open Main Table --->
    <!---
    <cfif session.subsetText neq ''>
        <cfif Not Preserve And session.subset_id eq 19>
            BenefitsCheckUpRx helps people with Medicare and other older adults to learn about and enroll in government benefits, including the new Medicare Prescription Drug Coverage and other valuable federal, state and private programs that can save you money on health care and prescription drugs.
        <cfelse>
            <cf_CountProgramsRounded var="varCountProgramsRounded">
            <cf_CountProgramsRounded var="varCountProgramsRoundedPAP" subset="pap">
            <cf_CountDrugsRounded var="varCountDrugsRounded">
            <cfset session.subsetText = Replace(session.subsetText, '##varCountProgramsRounded##', varCountProgramsRounded, 'ALL')>
            <cfset session.subsetText = Replace(session.subsetText, '##varCountProgramsRoundedPAP##', varCountProgramsRoundedPAP, 'ALL')>
            <cfset session.subsetText = Replace(session.subsetText, '##varCountDrugsRounded##', varCountDrugsRounded, 'ALL')>
            <cf_expandTextCodes text="#session.subsetText#">
        </cfif>
    <cfelse>
        <cf_displayText code="site_subset_intro_0" group="site">
    </cfif>
    --->
    <cf_cacheSubsetPool action="get" subset_id="#session.subset_id#" var="sobj">
    <table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
        <tr>
            <td bgColor="#ffffff" colSpan="2" align="center">
                <table width="700" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td rowspan="2"><img src="images/pixel.gif" width="8" height="1" border="0" alt="pixel" /></td>
                        <td valign="top"></td>
                        <td valign="top">
                            <cf_headerILTabs partner_id="#session.partner_id#">
                            <img src="images/pixel.gif" width="1" height="8" border="0" alt="pixel" /><br />
                            <font face="arial"><b><cf_displayText group="subintro" code="#sobj.intro#"></b></font>
                        </td>
                        <td rowspan="2"><img src="images/pixel.gif" width="8" height="1" border="0" alt="pixel" /></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <cfset blocklist=''>
                            <cfif (session.partner_id EQ 7 OR session.partner_id eq 8 Or session.partner_id eq 12 Or (session.partner_id eq 13 and session.subset_id gt 0) Or session.partner_id eq 14 Or session.partner_id eq 15) And Not preserve>
                                <cfset blocklist='subset_id'>
                            </cfif>
                            <cf_sessionPassVars action="frmwelcome2.cfm?partner_id=#SESSION.partner_id#" method="post" name="formwelcome" blocklist="#blocklist#">
                            <font face="arial" size="3">
                                <cfif Not (IsDefined('session.subset_id') And (session.subset_id eq 1 or session.subset_id eq 12))>
                                    <img src="images/pixel.gif" width="1" height="15" border="0" alt="" /><br />
                                    <cfif session.subset_id eq 49>
                                        Choose one of the following and click the Start button.
                                    <cfelse>
                                        Here's how it works:
                                    </cfif>
                                </cfif>
                                <cfif session.subset_id neq 49>
                                    <ol>
                                </cfif>
                                <cfif IsDefined('session.subset_id') And (session.subset_id eq 1 or session.subset_id eq 12)>
                                    <li>
                                        <a href="javascript:help2('whomithelps.cfm')">Click here</a> to learn who is likely to receive the most help from this service.<br />
                                        <img src="images/pixel.gif" width="1" height="10" border="0" alt="" /><br />
                                    </li>
                                </cfif>
                                <cfif blocklist eq 'subset_id'>
                                    <cfif session.subset_id eq 49>
                                        <img src="images/pixel.gif" width="1" height="10" border="0" alt="" />
                                    <cfelse>
                                        <li>
                                            Choose one of the following:
                                        </li>
                                    </cfif>
                                    <br />
                                    <img src="images/pixel.gif" width="1" height="5" border="0" alt="" /><br />
                                    <cfif session.partner_id eq 7 and session.subset_id neq 19 and false>
                                        <cfset hasRadio = true>
                                        <input type="radio" name="subset_id" value="18"<cfif session.subset_id Neq 12> checked</cfif> /> <b>All Rx Assistance Programs</b>&nbsp;
                                        <input type="radio" name="subset_id" value="12"<cfif session.subset_id Eq 12> checked</cfif> /> <b>Medicare Card Finder</b><br>
                                    <cfelse>
                                        <cfset hasRadio = true>
                                        <table>
                                            <tr>
                                                <td><img src="images/pixel.gif" width="1" height="3" border="0" alt="" /></td>
                                            </tr>
                                            <cfif session.subset_id eq 21>
                                                <tr>
                                                    <td valign="top"><input type="radio" name="subset_id" value="21" checked /></td>
                                                    <td>&nbsp;</td>
                                                    <td valign="top">Find out which Federal, State, Local and Private Programs you may be eligible for</td>
                                                </tr>
                                                <cfif session.partner_id eq 13>
                                                    <tr>
                                                        <td><img src="images/pixel.gif" width="1" height="3" border="0" alt="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top"><input type="radio" name="subset_id" value="39" /></td>
                                                        <td>&nbsp;</td>
                                                        <td valign="top">Find out which Prescription Drug and Health Care Programs (including Medicare Rx) you may be eligible for</td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="images/pixel.gif" width="1" height="3" border="0" alt="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top"><input type="radio" name="subset_id" value="27" /></td>
                                                        <td>&nbsp;</td>
                                                        <td valign="top">Find out if you are eligible for Medicare Rx Extra Help</td>
                                                    </tr>
                                                </cfif>
                                            <cfelseif session.subset_id eq 27>
                                                <tr>
                                                    <td valign="top"><input type="radio" name="subset_id" value="27" checked /></td>
                                                    <td>&nbsp;</td>
                                                    <td valign="top">Find out if you are eligible for Medicare Rx Extra Help</td>
                                                </tr>
                                            <cfelseif session.subset_id eq 49>
                                                <tr>
                                                    <td valign="top"><input type="radio" name="subset_id" value="49" checked /></td>
                                                    <td>&nbsp;</td>
                                                    <td valign="top">Find Public Benefits for Older Americans and Their Families</td>
                                                </tr>
                                                <tr>
                                                    <td><img src="images/pixel.gif" width="1" height="3" border="0" alt="" /></td>
                                                </tr>
                                                <tr>
                                                    <td valign="top"><input type="radio" name="subset_id" value="19" /></td>
                                                    <td>&nbsp;</td>
                                                    <td valign="top">Find Private Prescription Drug Programs Offered by Pharmaceutical Companies</td>
                                                </tr>
                                            <cfelse>
                                                <tr>
                                                    <td valign="top"><input type="radio" name="subset_id" value="39"<cfif session.subset_id neq 41> checked</cfif> /></td>
                                                    <td>&nbsp;</td>
                                                    <td valign="top">
                                                        Find out which Prescription Drug and Health Care Programs (including Medicare Rx) you may be eligible for
                                                    </td>
                                                </tr>
                                                <cfif session.subset_id eq 39 and (session.partner_id eq 7 or (session.partner_id eq 12 and session.source_id eq 5))>
                                                    <tr>
                                                        <td><img src="images/pixel.gif" width="1" height="3" border="0" alt="" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top"><input type="radio" name="subset_id" value="27" /></td>
                                                        <td>&nbsp;</td>
                                                        <td valign="top">Find out if you are eligible for Medicare Rx Extra Help</td>
                                                    </tr>
                                                </cfif>
                                            </cfif>
                                            <tr>
                                                <td><img src="images/pixel.gif" width="1" height="5" border="0" alt="" /></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"><input type="radio" name="subset_id" value="41"<cfif session.subset_id eq 41> checked</cfif> /></td>
                                                <td>&nbsp;</td>
                                                <td valign="top">
                                                    <cfif session.subset_id neq 49>
                                                        <font size="-1" color="red"><sup><b>NEW!</b></sup></font> 
                                                    </cfif>
                                                    <b>Apply<cfif session.subset_id neq 49> Now</cfif></b> for Medicare Rx Extra Help
                                                </td>
                                            </tr>
                                        </table>
                                    </cfif>
                                    <img src="images/pixel.gif" width="1" height="10" border="0" alt="" /><br />
                                </cfif>
                                <cfif session.subset_id eq 49>
                                    <img src="images/pixel.gif" width="1" height="10" border="0" alt="" /><br />
                                <cfelse>
                                    <li>
                                </cfif>
                                
                                <div id="welcome_button">
                                	<strong><input type="submit" value="Click Here" name="welcome"></strong> to start.
                                </div>
                               <cfif session.partner_id eq 7 and session.subset_id neq 14>
                                        , get your results, and get help enrolling
                                    <cfelseif session.subset_id eq 14>
                                        , learn about your current coverage, and get our recommendations for what you should do next
                                    </cfif>
                                <br />
                                <img src="images/pixel.gif" width="1" height="10" border="0" alt="" /><br />
                                <cfif (session.partner_id EQ 22 AND session.subset_id IS NOT 3) or session.subset_id eq 18 Or (Not Preserve And session.subset_id eq 19)>
                                    <li>
                                        Print out your personalized report that lists programs you may qualify for, telephone numbers, and directions 
                                        on how to sign up for these programs.<br />
                                    </li>
                                <cfelseif session.subset_id eq 19>
                                    <li>
                                        Print out your personalized report that includes a list of the Patient Assistance Programs you may qualify for 
                                        as well as application forms and instructions about how to sign up for them.<br />
                                   </li>
                                <cfelseif session.partner_id neq 7 or session.subset_id neq 39>
                                    <cfif session.partner_id neq 7 and session.partner_id neq 22 OR (session.partner_id EQ 22 AND session.subset_id IS 3)>
                                        <img src="images/pixel.gif" width="1" height="10" border="0" alt="" /><br />
                                        <li>
                                            Print out your personalized report that lists programs you may qualify for, telephone numbers, and 
                                            directions on how to sign up for these programs.
                                        </li>
                                    </cfif>
                                </cfif>
                                </b>
                                <cfif session.subset_id neq 49>
                                    </ol>
                                </cfif>
                                <br>
                                <cfif session.subset_id neq 19 Or (Not Preserve And session.subset_id eq 19)>
                                    <p>
                                        <cfif session.subset_id eq 14 or session.subset_id eq 18 or session.subset_id eq 19 or session.subset_id eq 22  or session.subset_id eq 34 or session.subset_id eq 35 >
                                            <a href="javascript:help2('<cfoutput>#application.transferType#://#application.serverPath#/whatithelps.cfm?id=#session.subset_id#</cfoutput>')">Click here</a> 
                                            to learn which benefits are included in this screening and enrollment service.<br />
                                        <cfelseif session.subset_id eq 49>
                                            What public benefits are included?&nbsp; <a href="javascript:help2('<cfoutput>#application.transferType#://#application.serverPath#/whatithelps.cfm?id=#session.subset_id#</cfoutput>')">Click here</a><br />
                                        </cfif>
                                        <cfif session.subset_id eq 36>
                                            See if you need to gather information <a href="javascript:help2('<cfoutput>#neededURL#</cfoutput>')">before you begin</a>.
                                        <cfelseif session.subset_id eq 49>
                                            What information do I need to begin?&nbsp; <a href="javascript:help2('<cfoutput>#neededURL#</cfoutput>')">Click here</a>
                                        <cfelse>
                                            <a href="javascript:help2('<cfoutput>#neededURL#</cfoutput>')">Click here</a> to see if you need to gather any information before you begin.
                                        </cfif>
                                     </p>
                                </cfif>
                                <cfif false>
                                    <cfif session.subset_id eq 14 Or (Not Preserve And session.subset_id eq 19)>
                                        <cfif hasRadio>
                                            <p>
                                                <b>Note:</b>&nbsp; 
                                                <input type="button" name="qjump" value="Click Here" onClick="this.form.subset_id[0].value = '34'; this.form.subset_id[0].checked = true; this.form.submit();" /> &nbsp;
                                                if you're looking for prescription drug assistance for a person who does NOT have Medicare.
                                            </p>
                                        <cfelse>
                                            <p>
                                                <b>Note:</b>&nbsp; 
                                                <input type="button" name="qjump" value="Click Here" onClick="this.form.subset_id.value = '34'; this.form.submit();" /> &nbsp;
                                                if you're looking for prescription drug assistance for a person who does NOT have Medicare.
                                            </p>
                                        </cfif>
                                    </cfif>
                                </cfif>
                                <cfif session.partner_id neq 7>
                                    <!---
                                    <cfif session.subset_id eq 18 or session.subset_id eq 22 Or session.subset_id eq 39 Or (Not Preserve And session.subset_id eq 19)>
                                        <font face="arial" size="3"><cf_tagBCU>Rx</font>
                                    <cfelseif session.subset_id eq 19>
                                        This service
                                    <cfelseif session.subset_id eq 14>
                                        <font face="arial" size="3"><cf_tagBCU> for People with Medicare</font>
                                    <cfelse>
                                        <font face="arial" size="3"><cf_tagBCU></font>
                                    </cfif> 
                                    <font face="arial">
                                        <b>is completely confidential. It does not require your name, address, phone number, 
                                        or Social Security number. For more information
                                        <cfif session.subset_id eq 27 or session.subset_id eq 36>
                                            , see our <a href="javascript:help2('privacy.cfm?keyword=residence&type=Definition')">privacy policy</A>
                                        <cfelse> 
                                            on our privacy policy, <a href="javascript:help2('privacy.cfm?keyword=residence&type=Definition')">click here</A>
                                        </cfif>
                                        .</b>
                                    </font>
                                    --->
                                    <cfif session.subset_id neq 14 and session.subset_id neq 18 and session.subset_id neq 19 and session.subset_id neq 21 and session.subset_id neq 22 and session.subset_id neq 27 and session.subset_id neq 34 and session.subset_id neq 35 and session.subset_id neq 39 and session.subset_id neq 49 and session.partner_id neq 17>
                                        <!--- NOT SURE WHY THERE IS NOTHING HERE --->
                                    </cfif>
                                </cfif>
                                <cfif session.subset_id neq 14 and session.subset_id neq 27 and session.subset_id neq 34 and session.subset_id neq 35 and session.subset_id neq 36 and session.subset_id neq 37 and session.subset_id neq 38 and session.subset_id neq 49 and session.partner_id neq 17 and (session.subset_id neq 39 or session.partner_id neq 12)>
                                    <cfif IsDefined('session.partner_id') And session.partner_id eq 7>
                                        Note: If you represent an organization that is using this service to help your clients, 
                                        <a href="javascript:var oe=open('http://www.accesstobenefits.org/Helpful%20Resources/OrganizationalEdition/default.aspx', 'OE', 'width=575,height=450,status=no,toolbar=no,scrollbars=yes,resizable=yes,menubar=no')">click here</a> 
                                        to learn about the special ABC Organizational Edition.
                                    </cfif><br />
                                <cfelseif session.partner_id eq 7 and session.subset_id eq 39>
                                    <p>
                                        Note: If you represent an organization that is using this service to help your clients, 
                                        <a href="javascript:var oe=open('http://www.accesstobenefits.org/Helpful%20Resources/OrganizationalEdition/default.aspx', 'OE', 'width=575,height=450,status=no,toolbar=no,scrollbars=yes,resizable=yes,menubar=no')">click here</a> 
                                        to learn about the special ABC Organizational Edition.
                                    </p>
                                </cfif>
                                <cfif session.partner_id eq 17>
                                    <cfoutput>
                                        <p align="center">
                                            Organizational Edition users, <a href="#application.transferType#://#application.serverPath#/kaiseroe/">click here</a>.
                                        </p>
                                    </cfoutput>
                                </cfif>
                            </font>
                            </cf_sessionPassVars>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</cfif>
<!--- close Main Table --->
<cf_tagFooter>

<cfif (IsDefined('URL.partner_id') AND URL.partner_id EQ 0 )OR (IsDefined('SESSION.partner_id') AND SESSION.partner_id EQ 0)>
	<cfif IsDefined('form.preview_subset39_zip')>
		<cflocation url="frmwelcome2.cfm?#CGI.query_string#&preview_zip_39=#form.preview_subset39_zip#" addToken="yes">
	<cfelseif IsDefined('form.preview_subset62_zip')>
		<cflocation url="frmwelcome2.cfm?#CGI.query_string#&preview_zip_62=#form.preview_subset62_zip#" addToken="yes">
	<cfelseif SESSION.subset_id EQ 0>
		<cflocation url="frmwelcome2.cfm?#CGI.query_string#" addToken="yes">
	<cfelseif SESSION.subset_id EQ 27>
		<cflocation url="frmwelcome2.cfm?#CGI.query_string#" addToken="yes">
	<cfelseif SESSION.subset_id EQ 39>
		<cflocation url="frmwelcome2.cfm?#CGI.query_string#" addToken="yes">
	<cfelseif SESSION.subset_id EQ 62>	
	<cflocation url="frmwelcome2.cfm?#CGI.query_string#" addToken="yes">
    <cfelse>    
        
     </cfif>
</cfif>