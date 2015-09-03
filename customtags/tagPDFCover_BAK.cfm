<cfparam name="attributes.resultvar" type="string" default="pdfcoverstr">
<cfparam name="attributes.localversion" type="string" default="">
<cfparam name="attributes.brandcover" type="string" default="">

<cfif session.org_id gt 0>
	<cfquery name="cobrandInfo" datasource="#application.dbSrcOE#">
		select o.site_name Pro_Name, o.slogan Pro_Slogon, o.site_bg_color Pro_BkColor, o.logo_path Pro_LogoPath, o.url Pro_URL, r.intro Pro_CSOInfo, '' Pro_LocalInfo, p.site_name parent_org
		from REPORT r INNER JOIN ORGANIZATION o
				ON o.id=r.org_id
			LEFT OUTER JOIN ORGANIZATION p
				ON o.parent_org_id = p.id
					AND p.org_name != 'NCOA'
		where o.id=<cfqueryparam cfsqltype="cf_sql_integer" maxlength="10" value="#session.org_id#">
	</cfquery>
	<cfquery name="cobrandPublicInfo" datasource="#application.dbSrcOE#">
		SELECT a.line_1 Pro_PbAddress1, a.line_2 Pro_PbAddress2, '' Pro_PbAddress3, a.city Pro_PbCity, a.state Pro_PbState, a.zip Pro_PbZipCode, op.number Pro_PbOffPhone1, '' Pro_PbOffPhone1_Ext, '' Pro_PbContact_FName, r.contact_name Pro_PbContact_LName, tp.number Pro_PbTDD, '' Pro_PbTDD_Ext, r.cover_comments Pro_PbPhone_Comment
		FROM ORGANIZATION o
			LEFT JOIN REPORT r
		    	ON r.org_id = o.id
			LEFT JOIN ADDRESS a
		    	ON a.org_id = o.id
			LEFT JOIN PHONE op
		    	ON op.org_id = o.id
					AND op.phonetype_id = 1
			LEFT JOIN PHONE tp
				ON tp.org_id = o.id
					AND tp.phonetype_id = 6
		WHERE  o.id =<cfqueryparam cfsqltype="cf_sql_integer" maxlength="10" value="#session.org_id#">
	</cfquery>
	<cfset cobrand_city="">
	<cfquery name="cobrandCityInfo" datasource="#application.dbSrcOE#">
		SELECT a.city Cty_Name
		FROM ADDRESS a
		WHERE a.org_id =<cfqueryparam cfsqltype="cf_sql_integer" maxlength="10" value="#session.org_id#">
	</cfquery>
	<cfset cobrand_name=cobrandInfo.Pro_Name>
	<cfset cobrand_slogan=cobrandInfo.Pro_Slogon>
	<cfset cobrand_bgcolor=cobrandInfo.Pro_BkColor>
	<cfset cobrand_logo=cobrandInfo.Pro_LogoPath>
	<cfset cobrand_url=cobrandInfo.Pro_URL>
	<cfset cobrand_csoinfo=cobrandInfo.Pro_CSOInfo>
	<cfset cobrand_localinfo=cobrandInfo.Pro_LocalInfo>
	<cfset cobrand_parent=cobrandInfo.parent_org>
	<cfset cobrand_add1=cobrandPublicInfo.Pro_PbAddress1>
	<cfset cobrand_add2=cobrandPublicInfo.Pro_PbAddress2>
	<cfset cobrand_add3=cobrandPublicInfo.Pro_PbAddress3>
	<cfif IsDefined("cobrandCityInfo.Cty_Name")>
		<cfset cobrand_city=cobrandCityInfo.Cty_Name>
	<cfelse>
		<cfset cobrand_city="">
	</cfif>
	<cfset cobrand_st=cobrandPublicInfo.Pro_PbState>
	<cfset cobrand_zip=cobrandPublicInfo.Pro_PbZipCode>
	<cfset cobrand_phone=cobrandPublicInfo.Pro_PbOffPhone1>
	<cfset cobrand_ext=cobrandPublicInfo.Pro_PbOffPhone1_Ext>
	<cfset cobrand_fname=cobrandPublicInfo.Pro_PbContact_FName>
	<cfset cobrand_lname=cobrandPublicInfo.Pro_PbContact_LName>
	<cfset cobrand_tdd=cobrandPublicInfo.Pro_PbTDD>
	<cfset cobrand_tdd_ext=cobrandPublicInfo.Pro_PbTDD_Ext>
	<cfset cobrand_comment=cobrandPublicInfo.Pro_PbPhone_Comment>
<cfelse>
	<cfset cobrand_name=''>
</cfif>

<cf_tagPassText outputvar="coverstr">
<cfif IsDefined('attributes.brandcover') and attributes.brandcover neq "">
	<cfif attributes.brandcover is "webmd">
		<cfinclude template="webmdcover.cfm">
	<cfelseif attributes.brandcover is "abc">
		<cfinclude template="abccover.cfm">	
	</cfif>

<cfelse>

<cfoutput>
<hr color="Black">
<BR>
<cfif attributes.localversion eq "cookcountyillinois">
<FONT FACE="Arial" SIZE=2>&nbsp; &nbsp; &nbsp; Client Name:&nbsp; ___________________________________________________________________________<br><br>
&nbsp; &nbsp; &nbsp; Client Phone##:&nbsp; ( ____ ) _____ - ______<BR><BR>
&nbsp; &nbsp; &nbsp; Client Address:&nbsp; _________________________________________________________________________<BR>
</font>
<hr color="Black">
</cfif>
<BR><BR>
<FONT size=7 face="Arial">
<cfif attributes.localversion eq "cookcountyillinois">
<CENTER>Your <b><cf_tagBCU></b> Report</CENTER>
</FONT>

<CENTER><FONT size=3 face="Arial"><B>
A personalized report of benefits that may be available to you 
</B></FONT></P></CENTER><br>
<cfelse>
<CENTER>Your <b><cf_tagBCU></b> Report</CENTER>
</FONT><BR>

<!---<CENTER><FONT size=3 face="Arial"><B>A personalized report of benefits that may be available to you</B></FONT></P></CENTER>---><br>
</cfif>

<cfif IsDefined('application.partnervars') AND session.partnerPDFLogoFlag and StructKeyExists(application.partnervars, "p#session.partner_id#") and FileExists(ExpandPath("/cf/img/partners/#StructFind(application.partnervars, "p#session.partner_id#")#/logo.gif"))>
<center><IMG src="http://#application.serverPath#/cf/img/partners/#StructFind(application.partnervars, "p#session.partner_id#")#/logo.gif" border="0" ALT="Logo"></center><br /><br /><br /><br /><br /><br />
<cfelseif session.partner_id eq 22 and session.partnerPDFLogoFlag>
<center><IMG src="http://#application.serverPath#/cf/images/logo_print_aarpfound2.jpg" width="239" height="80" border="0" ALT="AARP Foundation"></center><br /><br /><br /><br /><br />
<cfelseif session.partner_id eq 28 and session.partnerPDFLogoFlag>
<center><IMG src="http://#application.serverPath#/cf/images/logo_print_windsor.gif" width="205" height="60" border="0" ALT="Windsor Medicare Extra"></center><br /><br /><br /><br /><br /><br />
<cfelseif session.partner_id eq 30 and session.partnerPDFLogoFlag>
<center><IMG src="http://#application.serverPath#/cf/images/logo_print_coventry.gif" width="205" height="60" border="0" ALT="Coventry Healthcare Logo"></center><br /><br /><br /><br /><br /><br />
</cfif>

<cfif session.org_id eq 0>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<cfelse>
		<center><font face="arial">
			<cfif trim(cobrand_logo) neq "" and trim(cobrand_logo) neq "Null">
				<img src="#session.strLogoPathNonSSL##cobrand_logo#" border="0" vspace="5"><br>
			</cfif>
			<cfif trim(cobrand_parent) neq "">
				<b>#cobrand_parent#</b><hr size="1" width="200">
			</cfif>
			<font size="4"><b>#cobrand_name#</b></font><br>
			<cfif trim(cobrand_slogan) neq "">
				<b><i>#cobrand_slogan#</i></b><br>
			</cfif>
			<br>
			<cfif trim(cobrand_add1) neq "">
				<b>#cobrand_add1#</b><br>
			</cfif>
			<cfif trim(cobrand_add2) neq "">
				<b>#cobrand_add2#</b><br>
			</cfif>
			<cfif trim(cobrand_add3) neq "">
				<b>#cobrand_add3#</b><br>
			</cfif>
			<cfif cobrand_city neq "">
				<b>#cobrand_city#, #cobrand_st# #cobrand_zip#</b><br>
			</cfif>
			<cfif cobrand_phone neq "">
				<b>#cobrand_phone#<cfif cobrand_ext neq ""> ext. #cobrand_ext#</cfif></b><br>
			</cfif>
			<cfif cobrand_lname neq "">
				<b>Contact: #cobrand_fname# #cobrand_lname#</b><br>
			</cfif>
			<cfif trim(cobrand_url) neq "" and trim(cobrand_url) neq "null">
				<br>
				<b>http://#cobrand_url#</b><br>
			</cfif>
			<cfif trim(cobrand_comment) neq "" and trim(cobrand_url) neq "null">
				<cfset cobrand_comment = Replace(cobrand_comment, '
', '<br>', 'ALL')>
				<br>
				<b>#cobrand_comment#</b><br>
			</cfif>
		</font></center>
	<br>
</cfif>
<cfif attributes.localversion eq "cookcountyillinois"><br></cfif>


<CENTER><FONT size=3 face="Arial"><EM><B>Brought to you by</B></EM></FONT><br><br>
<IMG src="http://#application.serverPath#/cf/img/ncoa-logo.gif" border="0"></CENTER><BR><cfif attributes.localversion neq "cookcountyillinois"></cfif>


<!---
<cfif session.subset_id neq 21 and session.partner_id neq 16 and session.partner_id neq 17 and session.partner_id neq 22><CENTER><FONT size=3 face="Arial"><B><I>and <cfif attributes.localversion eq "cookcountyillinois">Nationally </cfif>Sponsored by</I></B></FONT></CENTER></cfif>
--->

<TABLE align="center"><!---<cfif session.subset_id neq 21 and session.partner_id neq 16 and session.partner_id neq 17 and session.partner_id neq 22><tr>
 <TD align=center bgColor=##ffffff><cf_tagLogos></TD>
</TR></cfif>
--->

<tr>
<TD align="center" VALIGN=middle nowrap><hr color="Black">
<FONT face="Arial" size=2> <I>Powered by BenefitsCheckUp</I></FONT>

</TD></tr></table>
</cfoutput>
</cfif>
</cf_tagPassText>
<cfset "caller.#attributes.resultvar#" = coverstr>