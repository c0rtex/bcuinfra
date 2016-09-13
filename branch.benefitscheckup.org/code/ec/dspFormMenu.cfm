<cfparam name="menu_tab" default="drug">

<cfoutput>
<cfif menu_tab IS "drug">
    <table class='leftcolumnmodulehead' cellspacing='0' cellpadding='0' width="100%" border='0' valign='top'>
        <tbody>
            <tr>
                <th width='5'><img height='21' alt=shortcuts src="GUIFiles/moduleTab_left.png" width='5' border='0'></th>
                <th style="background-image:url(themes/EC/images/moduleTab_middle.png)" width="146">Search by  Drug</th>
                <th width=9><img height=21 alt=shortcuts src="GUIFiles/moduleTab_right.png" width=9 border=0></th>
            </tr>
        </tbody>
    </table>
    <table class='submenu' cellspacing='0' cellpadding='0' width="100%" border='0'>
        <tbody>
            <tr>
                <td  width="116" class='submenutd' id='createleads_sh'  onclick="location.href='drugs.cfm?menu_tab=drug&drugs=all'"  onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
                    <a title="View Forms for All Drugs" class='submenulink'  href="drugs.cfm?menu_tab=#menu_tab#&drugs=all">How to Search by Drug</a>
                </td>
            </tr>
            <tr>
                <td  width="116" class='submenutd' id='createleads_sh'  onclick="location.href='frmDrugQuestions.cfm?menu_tab=#menu_tab#&drugs=all'"  onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
                    <a title="View Forms for All Drugs" class='submenulink' href="frmDrugQuestions.cfm?menu_tab=#menu_tab#&drugs=all">All Drugs </a>
                </td>
            </tr>
            <tr>
                <td class='submenutd' id='createleads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='frmDrugQuestions.cfm?menu_tab=#menu_tab#&drugs=brand'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
                    <a title="View Forms for All Brand Name Drugs" class='submenulink' href="frmDrugQuestions.cfm?menu_tab=#menu_tab#&drugs=brand">Brand Name</a>
                </td>
            </tr>
            <tr>
                <td class='submenutd' id='leads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='frmDrugQuestions.cfm?menu_tab=#menu_tab#&drugs=gen'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
                    <a title="View Forms for All Generic Drugs" class='submenulink'  href="frmDrugQuestions.cfm?menu_tab=#menu_tab#&drugs=gen">Generic Drugs</a>
                </td>
            </tr>
        </tbody>
    </table>
<cfelseif menu_tab IS "category">
	<table class='leftColumnModuleHead' cellSpacing='0' cellPadding='0' width="100%" border='0'>
		<tbody>
			<tr>
				<th width='5'><img height='21' alt='Shortcuts' src="GUIFiles/moduleTab_left.png" width='5' border='0' /></th>
				<th style="background-image:url(themes/EC/images/moduleTab_middle.png)" width="146">Search Category</th>
				<th width='9'><img height='21' alt='Shortcuts' src="GUIFiles/moduleTab_right.png" width='9' border='0' /></th>
			</tr>
		</tbody>
	</table>
	<table class='subMenu' cellSpacing='0' cellPadding='0' width="100%" border='0'>
		<tbody>
			<tr>
				<td width="116" class='subMenuTD' id='CreateLeads_sh' onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=PAP'" onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="How to Search by Category" class='subMenuLink' href="category.cfm?menu_tab=#menu_tab#&cat=PAP">How to Search by Category</a>
				</td>
			</tr>
			<tr>
				<td width="116" class='subMenuTD' id='CreateLeads_sh' onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=PAP'" onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View All Patient Assistance Programs Forms" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=PAP">Patient Assistance Programs</a>
				</td>
			</tr>
			<tr>
				<td class='subMenuTD' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=MSP'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View All Medicare Savings Program Forms" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=MSP">Medicare Savings Program</a>
				</td>
			</tr>
			<!---<tr>
				<td class='subMenuTDB' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=QMB'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View All Medicare Savings Program - Qualifying Individual (QI) Forms" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=QMB">Qualified Medicare Beneficiary (QMB)</a>
				</td>
			</tr>
			<tr>
				<td class='subMenuTDB' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=SLMB'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View All Medicare Savings Program - Specified Low-Income Medicare Beneficiary (SLMB) Forms" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=SLMB">Specified Low-Income Medicare Beneficiary (SLMB)</a>
				</td>
			</tr>
			<tr>
				<td class='subMenuTDB' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=QI'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View All Medicare Savings Program - Qualifying Individual (QI) Forms"  class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=QI">Qualifying Individual (QI)</a>
				</td>
			</tr>--->
			<tr>
				<td class='subMenuTD' id='Leads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=MED'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View All Medicaid Forms" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=MED">Medicaid</a>
				</td>
			</tr>
			<tr>
				<td class='subMenuTD' id='Leads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=MED'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View All State Rx Program Forms" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=STRX">State Rx</a>
				</td>
			</tr>
			<tr>
            	<td class='subMenuTD' id='Import_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=OTH'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View Other Discount Program Forms" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=OTH">Other Discount</A>
				</td>
			</tr>
		</tbody>
	</table>
<cfelseif menu_tab IS "state">
	<table class='leftColumnModuleHead' cellSpacing='0' cellPadding='0' width="100%" border='0'>
		<tbody>
			<tr>
				<th width='5'>
					<img height='21' alt='Shortcuts' src="GUIFiles/moduleTab_left.png" width='5' border='0' />
				</th>
				<th style="background-image:url(themes/EC/images/moduleTab_middle.png)" width="146">Search by State </th>
				<th width='9'>
					<img height='21' alt='Shortcuts' src="GUIFiles/moduleTab_right.png" width='9' border='0'>
                </th>
			</tr>
		</tbody>
	</table>
	<table class='subMenu' cellSpacing='0' cellPadding='0' width="100%" border='0'>
		<tbody>
		<form name="statesearch" action="dspForms.cfm?menu_tab=#menu_tab#&cat=ST" method="post">
			<tr>
				<td class='subMenuTD' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='state.cfm?menu_tab=#menu_tab#&cat=ST'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="How to Search by State" class='subMenuLink' href="state.cfm?menu_tab=#menu_tab#&cat=ENTERED">How to Search by State</a>
				</td>
			</tr>
			<tr>
				<td class='subMenuTD' id='CreateLeads_sh' title="View The Latest Forms Added to Our Website" onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<cfset stateList = "AK,AL,AR,AZ,CA,CO,CT,DC,DE,FL,GA,HI,IA,ID,IL,IN,KS,KY,LA,MA,MD,ME,MI,MN,MO,MS,MT,NC,ND,NE,NH,NJ,NM,NV,NY,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VA,VT,WA,WI,WV,WY">
					<select name="st" size="1">
						<cfloop list="#stateList#" index="state">
							<option value="#state#" <cfif st IS state>selected</cfif>>#state#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr>
				<td width="116" class='subMenuTD' id='CreateLeads_sh' title="View The Latest Forms Added to Our Website" onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<input type="submit" value="Get Forms">
				</td>
			</tr>
			<tr>
				<td class='subMenuTD' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
				</td>
			</tr>
        </form>
		</tbody>
	</table>      
<cfelseif menu_tab IS "date">
	<table class='leftColumnModuleHead' cellSpacing='0' cellPadding='0' width="100%" border='0'>
		<tbody>
			<tr>
				<th width='5'><img height='21' alt='Shortcuts' src="GUIFiles/moduleTab_left.png" width='5' border='0' /></th>
				<th style="background-image:url(themes/EC/images/moduleTab_middle.png)" width="146">Search by Date</th>
				<th width='9'><img height='21' alt='Shortcuts' src="GUIFiles/moduleTab_right.png" width='9' border='0' /></th>
			</tr>
		</tbody>
	</table>
	<table class='subMenu' cellSpacing='0' cellPadding='0' width="100%" border='0'>
		<tbody>
			<tr>
				<td class='subMenuTD' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='date.cfm?menu_tab=#menu_tab#&cat=ENTERED'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="How to Search by Date" class='subMenuLink' href="date.cfm?menu_tab=#menu_tab#&cat=ENTERED">How to Search by Date</a>
                </td>
			</tr>
			<tr>
				<td width="116" class='subMenuTD' id='CreateLeads_sh' onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=PUB'" onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View The Latest Forms Published by Program Sponsors" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=PUB">Latest Forms </a>
				</td>
			</tr>
			<tr>
				<td class='subMenuTD' id='CreateLeads_sh' onmouseover="this.style.background='##eeeeee';this.style.cursor='hand';" onclick="location.href='dspForms.cfm?menu_tab=#menu_tab#&cat=ENTERED'" onmouseout="this.style.background='##DFDFDF';this.style.cursor='auto';">
					<a title="View The Latest Forms Added to Our Website" class='subMenuLink' href="dspForms.cfm?menu_tab=#menu_tab#&cat=ENTERED">Latest Entered</a>
				</td>
			</tr>
		</tbody>
	</table>
</cfif>
</cfoutput>