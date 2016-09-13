<cfset session.partner_id = 11>
<cfparam name="application.formpath" default="forms">
<cf_tagheader show_title="yes" content_title_override="Application Forms Center" show_left_col="n">
<!--- CHECKING FOR LANG ID --->
<cfif not isDefined('session.language_id')>
	<cfset session.language_id='EN'>
</cfif>

<cfset session.ZIPRADIUS = ''>
<cfset session.strClient = 'Self'>
<cfset session.st = 'FD'>
<cfset session.county = 'Unknown'>
<cfset session.city = "Unknown">
<cfset session.zip = "00000">

<!--- FORM QUERY --->
<cfinclude template="qryForms.cfm">

<style type='text/css'>@import url( ../ec/themes/EC/style.css );</style>
<script type="text/javascript" src="GUIFiles/sugar.js"></script>

<table cellSpacing='0' cellPadding='0' width="100%" border='0'>
	<tbody>	
		<tr>
			<td style="padding:0 8px 0 4px;" valign='top' width="20%">
				<cfinclude template="dspFormMenu.cfm">
			</td>
			<td style="padding-right:2px;vertical-align:top;" width="80%"><!-- crmprint -->
				<slot>
				<table class='listView' cellSpacing='0' cellPadding='0' width="100%" border='0'>
					<tbody>
						<tr>
							<td align=right colSpan='18'>
								<table cellspacing='0' cellPadding='0' width="100%" border='0'>
									<tbody>
										<tr>
											<td colspan='2' class='listViewPaginationTdS1' align='left'></td>
											<!--- td class='listViewPaginationTdS1' align='right'>
                                            <img height='9' alt='Start' src="GUIFiles/start_off.png" width='11' align='absMiddle' border='0' />&nbsp;Start&nbsp;&nbsp;<IMG height='9' alt='Previous' src="GUIFiles/previous_off.png" width='6' align='absmiddle' border='0' />&nbsp;Previous&nbsp;&nbsp;<span class='pageNumbers'>(1 - <cfoutput>#qryForms.RecordCount# of #qryForms.RecordCount#</cfoutput>)</span&nbsp;&nbsp;
                                            <a class='listViewPaginationLinkS1' href="">
                                            Next&nbsp;<img height='9' alt='Next' src="GUIFiles/next.png" width='6' align='absmiddle' border='0'>
                                            </a>
                                            &nbsp;&nbsp;
                                            <a class='listViewPaginationLinkS1' href="">
                                            End&nbsp;<img height='9' alt='End' src="GUIFiles/end.png" width='11' align='absmiddle' border='0' />
                                            </a>
                                            </td ---->
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr height='30'>
						<cfoutput>
                        	<cfif menu_tab NEQ 'state'>
                                <td class='listViewThS1' scope='col' width="26%" title="Click here to view details about this program.">
                                    <slot>
                                        <a class='listViewThLinkS1' href="dspForms.cfm?menu_tab=#menu_tab#&cat=#url.cat#&st=#url.st#&Sortby=prg_nm&Sortorder=#sortorder#">
                                            Program&nbsp;Name&nbsp;<img height='10' alt='Sort' src="GUIFiles/arrow.png" width='8' align='absmiddle' border='0'>
                                        </a>
                                    </slot>
                                </td>
                            </cfif>
							<td class='listViewThS1' scope='col' width="31%" title="Click here to open this form.">
								<slot>
									<a class='listViewThLinkS1' href="dspForms.cfm?menu_tab=#menu_tab#&cat=#url.cat#&st=#url.st#&Sortby=form_name&Sortorder=#sortorder#">
										Application Name&nbsp;<img height='10' alt='Sort' src="GUIFiles/arrow.png" width='8' align='absmiddle' border='0'>
									</a>
								</slot>
							</td>
							<cfif url.cat neq 'Drug' and cat neq 'PAP' >	
							<td class='listViewThS1' scope='col' width="12%" title="State or region this program applies to.">
								<slot>
									<a class='listViewThLinkS1' href="dspForms.cfm?menu_tab=#menu_tab#&cat=#url.cat#&st=#url.st#&Sortby=f.state_id&Sortorder=#sortorder#" title="State or region this program applies to.">
										State&nbsp;<img height='10' alt='Sort' src="GUIFiles/arrow.png" width='8' align='absmiddle' border='0'>
									</a>
								</slot>
							</td>
							</cfif>
							<td class='listViewThS1' scope='col' width="16%" title="Date this form was released by the program sponsor.">
                            	<slot>
                                    <a class='listViewThLinkS1' href="dspForms.cfm?menu_tab=#menu_tab#&cat=#url.cat#&st=#url.st#&Sortby=form_date&Sortorder=#sortorder#" title="Date this form was released by the program sponsor.">
                                        Revision&nbsp;Date&nbsp;<img height='10' alt='Sort' src="GUIFiles/arrow.png" width='8' align='absmiddle' border='0'>
                                    </a>
								</slot>
							</td>
						</cfoutput>
						</tr>
						<cfset loopcount = 'even' >
						<cfif qryForms.recordcount eq 0>
						<tr onmousedown="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'click', '#f1f1f1', '#EAEAD2', '');" onmouseover="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'over', '#f1f1f1', '#EAEAD2', '');" onmouseout="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'out', '#f1f1f1', '#EAEAD2', '');" height='20'>
							<td  class='homeText' valign='top' bgcolor='white' <cfif url.cat neq 'Drug' and cat neq 'PAP'>colspan='4'<cfelse>colspan='3'</cfif>>
								<p>Sorry, there are no forms available matching your search criteria.</p>
                                <p>
                                    BenefitsCheckUp strives to maintain the most current database of programs and application 
                                    forms possible. Please feel free to contact BenefitsCheckUp Customer Support at <a href="mailto:support@benefitscheckup.org">
                                    support@benefitscheckup.org</a> with questions or program additions.  
                                </p>
							</td>
						</tr>
						</cfif>
                        <cfif menu_tab is "state">
                        	<cfoutput query="qryForms" group="prg_nm">
                            <tr>
                            	<td colspan="3" class='listViewThS1' style="border-bottom:none;">
									<div style="padding:6px;">
                                    	<a class='listViewTdLinkS1' href="../frmDetails.cfm?menu_tab=#menu_tab#&prg_id=#prg_id#&src=ec&st=#ST#&content_title_override=#urlencodedformat('Application Forms Center')#&partner_id=11" title="Click here to view program details">
                                        	#prg_nm#
                                        </a>
                                    </div>
                                </td>
                            </tr>
								<cfoutput>
									<cfif loopcount eq 'even'>
                                        <cfset style = 'evenListRowS1'>
                                        <cfset color = '##f1f1f1'>
                                        <tr onmousedown="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'click', '##f1f1f1', '##EAEAD2', '');" onmouseover="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'over', '##f1f1f1', '##EAEAD2', '');" onmouseout="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'out', '##f1f1f1', '##EAEAD2', '');" height='20'>
                                        <cfset loopcount = 'odd'>
                                    <cfelse>
                                        <cfset style = 'oddListRowS1'>
                                        <cfset color = '##fdfdfd'>
                                        <tr onmousedown="setPointer(this, '347484f7-7037-14d3-fc10-42279fb06b49', 'click', '##fdfdfd', '##EAEAD2', '');" onmouseover="setPointer(this, '347484f7-7037-14d3-fc10-42279fb06b49', 'over', '##fdfdfd', '##EAEAD2', '');" onmouseout="setPointer(this, '347484f7-7037-14d3-fc10-42279fb06b49', 'out', '##fdfdfd', '##EAEAD2', '');" height='20'>
                                        <cfset loopcount = 'even'>
                                    </cfif>
                                    <td class='evenListRowS1' valign='top' scope='row' style="padding-left:20px;" bgcolor="#color#">
                                        <a class='listViewTdLinkS1' href="<cfif formtype_id eq 3>#string#<cfelse>../#application.formpath#/#string#</cfif>" title="Click here to view this form" target="#prg_id#">
                                            <cfif formtype_id eq 4>
                                                <strong><i>Fillable!</i></strong>
                                            </cfif> 
                                            #tag_name#
                                        </a>
                                    </td>
                                    <td class='evenListRowS1' valign='top' scope='row' bgcolor="#color#">
                                        <slot>
                                        #st#
                                        </slot>
                                    </td>
                                    <td class='evenListRowS1' valign='top' scope='row' bgcolor="#color#">
                                        <slot>
                                        <span class="evenListRowS1">#dateformat(form_date,"mm/dd/yy")#</span>
                                        </slot>
                                    </td>
                                </tr>
                                </cfoutput>
							</cfoutput>
                        <cfelse>
                            <cfloop query="qryForms">
                                <cfif loopcount eq 'even'>
                                    <cfset style = 'evenListRowS1'>
                                    <cfset color = '##f1f1f1'>
                                    <tr onmousedown="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'click', '#f1f1f1', '#EAEAD2', '');" onmouseover="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'over', '#f1f1f1', '#EAEAD2', '');" onmouseout="setPointer(this, '70fcbeae-cf4c-0d62-39cb-42279f3e065f', 'out', '#f1f1f1', '#EAEAD2', '');" height='20'>
                                    <cfset loopcount = 'odd'>
                                <cfelse>
                                    <cfset style = 'oddListRowS1'>
                                    <cfset color = '##fdfdfd'>
                                    <tr onmousedown="setPointer(this, '347484f7-7037-14d3-fc10-42279fb06b49', 'click', '#fdfdfd', '#EAEAD2', '');" onmouseover="setPointer(this, '347484f7-7037-14d3-fc10-42279fb06b49', 'over', '#fdfdfd', '#EAEAD2', '');" onmouseout="setPointer(this, '347484f7-7037-14d3-fc10-42279fb06b49', 'out', '#fdfdfd', '#EAEAD2', '');" height='20'>
                                    <cfset loopcount = 'even'>
                                </cfif>
                                <td class='oddListRowS1' valign='top' scope='row' bgcolor='<cfoutput>#color#</cfoutput>'>
                                    <table>
                                        <tr>
                                            <td>
                                                <slot>
                                                <cfoutput>
                                                    <a class='listViewTdLinkS1' href="../frmDetails.cfm?menu_tab=#menu_tab#&prg_id=#prg_id#&src=ec&st=#ST#&content_title_override=#urlencodedformat('Application Forms Center')#&partner_id=11" title="Click here to view program details">
                                                        #prg_nm#
                                                    </a>
                                                </cfoutput>
                                                </slot>
                                            </td>
                                        </tr>
                                        <cfif url.cat eq 'DRUG' and len(session.ecPrgList) gt 1>
                                            <tr>
                                                <td>
                                                <cfif IsDefined('session.selectedAFCDrugs')>
                                                    <cfquery name="matchingdrugs" datasource="#application.dbSrc#">
                                                        SELECT a.answerfield, substring(dl.display_text, 1, 255) option_nm
                                                        FROM tbl_prg_all p, program_answerfield pa, answerfield a, display_language dl
                                                        WHERE p.prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#prg_id#" maxlength="25">
                                                            AND p.recid=pa.program_id
                                                            AND pa.answerfield_id=a.answerfield_id
                                                            AND a.answerfieldtype_id in (13, 14)
                                                            AND a.display_id=dl.display_id
                                                            AND dl.language_id='#session.language_id#'
                                                        ORDER BY option_nm
                                                    </cfquery>
                                                    <cfset hasOutputted = 0>
                                                    <cfoutput query="matchingdrugs">
                                                        <cfif ListFindNoCase(session.selectedAFCDrugs, answerfield) gt 0>
                                                            <cfif hasOutputted eq 0>
                                                                Applies to:
                                                                <ul>
                                                                <cfset hasOutputted = 1>
                                                            </cfif>
                                                            <li>#option_nm#</li>
                                                        </cfif>
                                                    </cfoutput>
                                                    <cfif hasOutputted eq 1>
                                                        </ul>
                                                    </cfif>
                                                    <cfset genericList = "">
                                                    <cfloop list="#session.selectedAFCDrugs#" index="thisdrug">
                                                         <cf_cacheAnswerfieldPool action="get" code="#thisdrug#" var="afobj"> 
                                                        <!---<cfset afobj = application.answerfieldPool.getAnswerfield(thisdrug)>--->
                                                        <cfif afobj.type eq 'generic'>
                                                            <cfset genericList = ListAppend(genericList, afobj.id)>
                                                        </cfif>
                                                    </cfloop>
                                                    <cfif genericList eq ''>
                                                        <cfquery name="genericMatch" datasource="#application.dbSrc#">
                                                            SELECT answerfield, answerfield option_nm
                                                            FROM answerfield
                                                            WHERE answerfield_id IS null
                                                        </cfquery>
                                                    <cfelse>
                                                        <cfquery name="genericMatch" datasource="#application.dbSrc#">
                                                            SELECT a.answerfield, substring(dl.display_text, 1, 255) AS option_nm
                                                            FROM answerfield_relationship ar, answerfield a, display_language dl
                                                            WHERE ar.right_answerfield_id IN (#genericList#)
                                                            AND ar.relationship_id=1
                                                            AND ar.left_answerfield_id=a.answerfield_id
                                                            AND a.answerfieldtype_id=13
                                                            AND a.display_id=dl.display_id
                                                            AND dl.language_id='#session.language_id#'
                                                            ORDER BY option_nm
                                                        </cfquery>
                                                    </cfif>
                                                    <cfset hasOutputted = 0>
                                                    <cfoutput query="matchingdrugs">
                                                        <cfif ListFindNoCase(ValueList(genericMatch.answerfield), answerfield) gt 0>
                                                            <cfif hasOutputted eq 0>
                                                                brand-name version of generic medication selected:
                                                                <ul>
                                                                <cfset hasOutputted = 1>
                                                            </cfif>
                                                            <li>#option_nm#</li>
                                                        </cfif>
                                                    </cfoutput>
                                                    <cfif hasOutputted eq 1>
                                                        </ul>
                                                    </cfif>
                                                </cfif>
                                                </td>
                                            </tr>
                                        </cfif>
                                    </table>
                                </td>
                                <td class='<cfoutput>#style#</cfoutput>' valign='top' bgcolor='<cfoutput>#color#</cfoutput>'>
                                    <table>
                                        <tr>
                                            <td>
                                            <cfoutput>
                                                <slot>
                                                    <a class='listViewTdLinkS1' href="<cfif formtype_id eq 3>#string#<cfelse>../#application.formpath#/#string#</cfif>" title="Click here to view this form" target="#prg_id#">
                                                        <cfif formtype_id eq 4>
                                                            <strong><i>Fillable!</i></strong>
                                                        </cfif> 
                                                        #tag_name#
                                                    </a> 
                                                </slot> 
                                            </cfoutput>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <cfif url.cat neq 'Drug' and cat neq 'PAP'>		  
                                    <td title="State or region this program applies to." class='<cfoutput>#style#</cfoutput>' valign='top' bgcolor='<cfoutput>#color#</cfoutput>'>
                                        <cfoutput>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <slot>
                                                        <cfif len(st) lt 2 >
                                                            <cfif #FindNoCase('333',prg_id)# gt 0 >
                                                                <cfswitch expression=#prg_id#>
                                                                    <cfcase value="129-333-2673-FD-FD">
                                                                        AL, DE, FL, GA, IA, IL, KS, KY, LA, MD, MO, NC, NE, NJ, OH, PA, SC, TN, UT, VA, WV, DC
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2675-FD-FD">
                                                                        DE, NJ, PA
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2600-FD-FD">
                                                                        AL
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2601-FD-FD">
                                                                        FL
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2605-FD-FD">
                                                                        OH
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2606-FD-FD">
                                                                        AL
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2607-FD-FD">
                                                                        IL
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2608-FD-FD">
                                                                        TN
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2677-FD-FD">
                                                                        NJ, MN, MT, NE, NM, ND, OK, TX, WY
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2617-FD-FD">
                                                                        AZ, CO, ID, IA, IL, IN, KS, KY, MI, MT, MN, MO, NE, NM, ND, OH, OK, SD, UT, WI, WY
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2619-FD-FD">
                                                                        PA
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2663-FD-FD">
                                                                        SC
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2665-FD-FD">
                                                                        TN
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2662-FD-FD">
                                                                        NY
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2659-FD-FD">
                                                                        IL
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2661-FD-FD">
                                                                        MO
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2666-FD-FD">
                                                                        TX 
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2660-FD-FD">
                                                                        MN
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2664-FD-FD">
                                                                        IA, SD
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2624-FD-FD">
                                                                        CA, CO, LA, NV, TX
                                                                    </cfcase>
                                                                    <cfcase value="129-333-2625-FD-FD">
                                                                        TX
                                                                    </cfcase>
                                                                    <cfdefaultcase>
                                                                        ALL
                                                                    </cfdefaultcase>
                                                                </cfswitch>
                                                            <cfelse>
                                                                ALL
                                                            </cfif>
    
                                                        <cfelse>
                                                            #ST#
                                                        </cfif>
                                                        </slot>
                                                    </td>
                                                </tr>
                                            </table>
                                        </cfoutput>
                                    </td>
                                </cfif>
                                <td title="Date this form was released by the program sponsor." class='<cfoutput>#style#</cfoutput>' valign='top' bgcolor='<cfoutput>#color#</cfoutput>'>
                                    <slot>
                                        <span class="evenListRowS1"><cfoutput>#dateformat(form_date,"mm/dd/yy")#</cfoutput></span>
                                    </slot>
                                </td>
                            </tr>
                            </cfloop>
                        </cfif>
						<tr>
							<td class='listViewHRS1' colSpan='18'></td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
    </tbody>
</table>
<cf_tagFooter>