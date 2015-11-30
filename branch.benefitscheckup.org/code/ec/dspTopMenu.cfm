      <TABLE class=moduleTitle cellSpacing=0 cellPadding=0 width="100%" border=0>
 		<TBODY>
        <TR>

          <TD vAlign=top>&nbsp;</TD>

          <TD width="100%"> 

           <H2><cfif isdefined('url.cat')>
		  <cfswitch expression="#url.cat#">
		  <cfcase value="PAP">Patient Assistance Program Forms
		  </cfcase>
		   <cfcase value="MSP">Medicare Savings Program Forms
		  </cfcase>
		   <cfcase value="QMB">Qualified Medicare Beneficiary Forms
		  </cfcase>
		   <cfcase value="QI">Qualifying Individual Forms
		  </cfcase>
		   <cfcase value="SLMB">Specified Low-Income Medicare Beneficiary Forms
		  </cfcase>
		  <cfcase value="MED">Medicaid Forms
		  </cfcase>
		  <cfcase value="MEDAPROV">Medicare Approved Drug Discount Cards
		  </cfcase>
		  <cfcase value="OTH">Other Discount Program Forms
		  </cfcase>
		  <cfcase value="Drug">Search by Drug
		  </cfcase>
		  <cfcase value="Entered">Latest Form Changes in BenefitsCheckUp
		  </cfcase>
		  <cfcase value="STRX">State Rx Program Forms
		  </cfcase>
		  <cfcase value="PUB">Latest Forms Published by Agencies
		  </cfcase>
		  </cfswitch>
		  <cfif isdefined('url.st') and url.st neq ''>Forms for <cfoutput>#url.st#</cfoutput></cfif>
		  </cfif></TD>

     <TD style="PADDING-LEFT: 5px; PADDING-TOP: 3px" vAlign=top noWrap 

          align=right><cf_sessionPassVars href="ec/index.cfm" subset_id="0" class="utilsLink"><IMG 

            height=13 alt=Print src="GUIFiles/home.png" width=13 

            align=absMiddle border=0>&nbsp;Home</cf_sessionPassVars>&nbsp;<A class=utilsLink 

            href="javascript:self.print();"><IMG 

            height=13 alt=Print src="GUIFiles/print.png" width=13 

            align=absMiddle border=0></A>&nbsp;<A class=utilsLink 

            href="javascript:self.print();">Print</A> 

           <!--  &nbsp;<A class=utilsLink href="echelp.cfm" target=_blank 

            target=_blank><IMG height=13 alt=Help 

            src="GUIFiles/help.png" width=13 align=absMiddle 

            border=0></A>&nbsp;<A class=utilsLink 

            href="echelp.cfm" 

            target=_blank>Help</A> --></TD></TR></TBODY></TABLE>