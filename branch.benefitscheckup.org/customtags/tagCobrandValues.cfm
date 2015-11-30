<!--- Set cobranding colors and graphics --->
<!--- Constants --->
<cfset hasparent = False>
<cfset ncoalogo = '<a target="_blank" href="http://www.ncoa.org"><img src="images/ncoaLogoNew.gif" width="137" height="60" border="0" alt="NCOA - National Council on Aging"></a>'>

<cfif ListFind('1,2,4', partner_id)>
	<cfset page_background = 'background="images/BCUback.jpg"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##00594b">
	<cfset table_color = "##bdcfc8">
	<cfset table_text_color = "##00594b">
	<cfset table_link_color = "##00594b">
	<cfset left_logo = ''>
	<cfset center_logo = '<img src="images/ncoaLogoNew.gif" width="137" height="60" border="0" alt="NCOA - National Council on Aging">'>
	<cfset right_logo = '<img src="images/head-bcu_green.gif" border="0" alt="BenefitsCheckUp">'>
	<cfset page_slogan = ''>
<cfelseif partner_id eq 5>
<!--- CMS LTCC cobranding--->
	<cfset page_background = 'bgcolor="##ffffff"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##00594b">
	<cfset table_color = "##ffffff">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##000000">
	<cfset page_slogan = ''>
<cfelseif partner_id eq 3>
<!--- AVAYA cobranding --->
	<cfset page_background = 'bgcolor="##ffffff"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##00594b">
	<cfset table_color = "##4799b6">
	<cfset table_text_color = "##000000">
	<cfset table_link_color = "##000000">
	<cfset left_logo = '<a target="_blank" href="http://www.avaya.com"><img src="images/logo_avaya.gif" width="121" height="45" alt="Avaya" border="0"></a>'>
	<cfset center_logo = ''>
	<cfset right_logo = '<IMG src="images/head-bcu.gif" border="0" ALT="BenefitsCheckUp">'>
	<cfset page_slogan = ''>
<cfelseif (not IsDefined('session.cobrand_name') or session.cobrand_name eq '') and (not IsDefined('session.cobrand_logo') or session.cobrand_logo eq '')>
<!--- NORMAL branding --->
	<cfset page_background = 'background="images/BCUback.jpg"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##00594b">
	<cfset table_color = "##bdcfc8">
	<cfset table_text_color = "##00594b">
	<cfset table_link_color = "##00594b">
	<cfset left_logo = ''>
	<cfset center_logo = '<img src="images/ncoaLogoNew.gif" width="137" height="60" border="0" alt="NCOA - National Council on Aging">'>
	<cfset right_logo = '<img src="images/head-bcu_green.gif" border="0" alt="BenefitsCheckUp">'>
	<cfset page_slogan = ''>
<cfelseif partner_id eq 16>
<!--- CSO cobranding ---> 
	<cfset page_background = 'bgcolor="#session.cobrand_bgcolor#"'>
	<cfset text_color = "##000000">
	<cfset link_color = "##003300">
	<cfset table_color = "##bdcfc8">
	<cfset table_text_color = "##0067A4">
	<cfset table_link_color = "##0067A4">
	<cfset left_logo = ''>
	<cfif session.cobrand_logo eq '' or session.cobrand_logo eq 'Null'>
		<cfset center_logo = "">
	<cfelse>
		<cfset center_logo = '<img src="#session.strLogoPath##session.cobrand_logo#" border="0" hspace="10" alt="#session.cobrand_name#">'>
	</cfif>
	
	<cfif IsDefined('session.cobrand_parent_name') and (trim(session.cobrand_parent_name) neq '')>
		<cfset parent_name = '<span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12pt">' & session.cobrand_parent_name & '</span><br><hr size="1">'>
		<cfset hasparent = True>
	</cfif>
	<cfset right_logo = '<span style="font-family: Georgia, Times New Roman, serif; font-weight: bold; font-size: 18pt">#session.cobrand_name#</span>'>
	<cfset page_slogan = ''>
<cfelse>
<!--- CSO cobranding --->
	<cfif session.cobrand_bgcolor eq '' or session.cobrand_bgcolor eq 0 or session.cobrand_bgcolor eq 'Null'>
		<cfset page_background = 'background="images/BCUback.jpg"'>
	<cfelse>
		<cfset page_background = 'bgcolor="#session.cobrand_bgcolor#"'>
	</cfif>
	<cfset text_color = "##000000">
	<cfset link_color = "##00594b">
	<cfset table_color = "##bdcfc8">
	<cfset table_text_color = "##00594b">
	<cfset table_link_color = "##00594b">
	<cfset left_logo = ''>
	<cfif session.cobrand_logo eq '' or session.cobrand_logo eq 'Null'>
		<cfset center_logo = "">
	<cfelse>
		<cfset center_logo = '<img src="#session.strLogoPath##session.cobrand_logo#" border="0" hspace="10" alt="#session.cobrand_name#">'>
	</cfif>
	<cfif session.site_name_style eq ''>
		<cfset right_logo = '<font face="Arial" size="6"><b>#session.cobrand_name#</b></font>'>
	<cfelse>
		<cfset right_logo = '<span style="#session.site_name_style#">#session.cobrand_name#</span>'>
	</cfif>
	<cfif session.site_slogan_style eq ''>
		<cfset page_slogan = '<font face="Arial" size="2"><i><b>#session.cobrand_slogan#</b></i></font>'>
	<cfelse>
		<cfset page_slogan = '<span style="#session.site_slogan_style#">#session.cobrand_slogan#</span>'>
	</cfif>
</cfif>
<cfif IsDefined('session.cobrand_parent_name') and (trim(session.cobrand_parent_name) neq '') and hasparent eq false>
	<cfset parent_name = session.cobrand_parent_name & '<br><hr size="1">'>
<cfelseif hasparent eq false>
	<cfset parent_name = "">
</cfif>