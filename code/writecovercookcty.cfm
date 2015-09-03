<cfif IsDefined('session.org_id') and session.org_id gt 0>
	<cfquery name="cobrandInfo" datasource="#application.dbSrcOE#">
		select o.site_name Pro_Name, o.slogan Pro_Slogon, o.site_bg_color Pro_BkColor, o.logo_path Pro_LogoPath, o.url Pro_URL, r.intro Pro_CSOInfo, '' Pro_LocalInfo
		from ORGANIZATION o, REPORT r
		where o.id=#session.org_id#
			and o.id=r.org_id
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
		WHERE o.id = #session.org_id#
	</cfquery>
	<cfset cobrand_city="">
	<cfquery name="cobrandCityInfo" datasource="#application.dbSrcOE#">
		SELECT a.city Cty_Name
		FROM ADDRESS a
		WHERE a.org_id = #session.org_id#
	</cfquery>
	<cfset cobrand_name=cobrandInfo.Pro_Name>
	<cfset cobrand_slogan=cobrandInfo.Pro_Slogon>
	<cfset cobrand_bgcolor=cobrandInfo.Pro_BkColor>
	<cfset cobrand_logo=cobrandInfo.Pro_LogoPath>
	<cfset cobrand_url=cobrandInfo.Pro_URL>
	<cfset cobrand_csoinfo=cobrandInfo.Pro_CSOInfo>
	<cfset cobrand_localinfo=cobrandInfo.Pro_LocalInfo>
	<cfset cobrand_add1=cobrandPublicInfo.Pro_PbAddress1>
	<cfset cobrand_add2=cobrandPublicInfo.Pro_PbAddress2>
	<cfset cobrand_add3=cobrandPublicInfo.Pro_PbAddress3>
	<cfset cobrand_city=cobrandCityInfo.Cty_Name>
	<cfset cobrand_st=cobrandPublicInfo.Pro_PbState>
	<cfset cobrand_zip=cobrandPublicInfo.Pro_PbZipCode>
	<cfset cobrand_phone=cobrandPublicInfo.Pro_PbOffPhone1>
	<cfset cobrand_ext=cobrandPublicInfo.Pro_PbOffPhone1_Ext>
	<cfset cobrand_fname=cobrandPublicInfo.Pro_PbContact_FName>
	<cfset cobrand_lname=cobrandPublicInfo.Pro_PbContact_LName>
	<cfset cobrand_tdd=cobrandPublicInfo.Pro_PbTDD>
	<cfset cobrand_tdd_ext=cobrandPublicInfo.Pro_PbTDD_Ext>
	<cfset cobrand_comment=cobrandPublicInfo.Pro_PbPhone_Comment>
	<cfset cso_id=session.org_id>
<cfelse>
	<cfset cso_id=0>
</cfif>


<hr color="Black">
<BR>
<FONT FACE="Arial" SIZE=2>&nbsp; &nbsp; &nbsp; Client Name:&nbsp; ___________________________________________________________________________<br><br>
&nbsp; &nbsp; &nbsp; Client Phone#:&nbsp; ( ____ ) _____ - ______<BR><BR>
&nbsp; &nbsp; &nbsp; Client Address:&nbsp; _________________________________________________________________________<BR>
</font>
<hr color="Black">
<BR><BR>
<FONT size=7 face="Arial">
<CENTER>Your <b>Benefits</b>Check<i>Up</i> Report</CENTER>
</FONT>

<CENTER><FONT size=3 face="Arial"><B>
A personalized report of benefits that may be appropriate for you
</B></FONT></P></CENTER><br>


<cfif not IsDefined('session.org_id') or session.org_id eq 0>
	<BR><BR><BR><BR><br><!--- delete some break tags here... --->
<cfelse>
	<cfoutput>
		<center><font face="arial">
			<cfif cobrand_logo neq "">
				<img src="#session.strLogoPath##session.cobrand_logo#" width="50" height="50" border="0" vspace="5" alt="#cobrand_name# logo"><br>
			</cfif>
			<font size="4"><b>#cobrand_name#</b></font><br>
			<cfif cobrand_slogan neq "">
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
		</font></center>
	<br><!--- ... and some more here --->
	</cfoutput>
</cfif>

<!--- <CENTER>
<TABLE WIDTH=50%><TR><TD>
<FONT FACE="arial" SIZE=3>
<PRE>
Client Name: __________________________________________<BR><BR>
Client Address: ________________________________________<BR><BR>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; ________________________________________<BR><BR>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; City: _________________ State: _____ Zip: _______<BR><BR>
Client Phone# : ________________________________________
</pre></font>
</td></tr></table></center> --->
<BR>


<cfoutput>
<CENTER><FONT size=3 face="Arial"><EM><B>Brought to you by</B></EM></FONT><br><br>
<IMG src="http://#application.serverPath#/images/ncoa-logotext-ffffff.gif" border="0" width="100" height="110" alt="NCOA"></CENTER><BR>
</cfoutput>


<CENTER><FONT size=3 face="Arial"><B><I>and Nationally Sponsored by</I></B></FONT></CENTER>


<CENTER><cf_tagLogos></CENTER>

		 </TD>
</TR>

<tr>
<TD VALIGN=middle nowrap><hr color="Black">
<CENTER>
<FONT face="Arial" size=2> <I>Powered by BenefitsCheckUp and Hosted by AOL's GovernmentGuide.com</I></FONT>
</td></tr></table>
</TD></tr></table>
