<!----=======================================
DESCRIPTION: shows any help information...pulled into seperate window by javascript of the caller
CALLED BY: TagPIheader
GOES TO: N/A
REQUIRED: type, keyword
	var type = NavTip, ....description to define which query to use
	var Keyword = which record to pull in any of the queries
============================================---->
<!--- Output type as title --->
<cfparam name="type" default="NavTip">
<cfparam name="Keyword" default="Liheap">

<link rel="alternate" type="application/rss+xml" title="BenefitsCheckUp &raquo; Feed" href="/feed/" />
<link rel="alternate" type="application/rss+xml" title="BenefitsCheckUp &raquo; Comments Feed" href="/comments/feed/" />
<link rel="alternate" type="application/rss+xml" title="BenefitsCheckUp &raquo; About BenefitsCheckUp Comments Feed" href="/about-2/feed/" />

<link rel="stylesheet" href="/wp-content/plugins/fancybox-for-wordpress/css/fancybox.css" type="text/css" media="screen" />

	<style type="text/css">
		div#fancy_inner {border-color:#BBBBBB}
		div#fancy_close {right:-15px;top:-12px}
		div#fancy_bg {background-color:#FFFFFF}
			</style>

	<link rel='stylesheet' id='pagelines-pro-css'  href='/wp-content/themes/platformpro/pro/pro.css?ver=1.2.3' type='text/css' media='all' />

<link rel='stylesheet' id='pagelines-stylesheet-css'  href='/wp-content/themes/platformbase/style.css?ver=1.2.3' type='text/css' media='all' />

<script type='text/javascript' src='/wp-includes/js/l10n.js?ver=20101110'></script>
<script type='text/javascript' src='/wp-includes/js/jquery/jquery.js?ver=1.6.1'></script>
<script type='text/javascript' src='/wp-includes/js/comment-reply.js?ver=20090102'></script>
<script type='text/javascript' src='/wp-content/plugins/fancybox-for-wordpress/js/jquery.fancybox-1.2.6.min.js?ver=1.3.2'></script>
<link rel="EditURI" type="application/rsd+xml" title="RSD" href="/xmlrpc.php?rsd" />
<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="/wp-includes/wlwmanifest.xml" /> 
<link rel='index' title='BenefitsCheckUp' href='/' />
<link rel='prev' title='Organization Users' href='/organization-users/' />
<link rel='next' title='Find Programs' href='/find-programs/' />
<meta name="generator" content="WordPress 3.2.1" />

<link rel="stylesheet" href="/wp-content/plugins/communications/comms.css" type="text/css" />
<!--- Javascript to close window --->
<BODY ONBLUR="window.close();" style="background-color:#FFFFFF;">

<FORM>

<cfif keyword is "LIHEAP">
<div style="background-color:#ffffff; color:#333333; width:100%; padding:25px;">
	<div style="background-color:#ffffff; color:#333333; width:400px;">
    	<p align="center" class="text1"><strong>Low Income Home Energy Assistance Program (LIHEAP)</strong></p>
        <p align="center" class="text1">LIHEAP is a federal program.  Your state may call LIHEAP by a different program name.  To find your state LIHEAP program name, see the list below.</p>
    </div>
	<TABLE align="center" style="background-color:#ffffff; color:#333333; font-size:14px;" width="400" border="1" cellpadding="1" class="text1">
    	<b>
        <tr><td><b>State</b></td> <td><b>LIHEAP Program Names</b> </td></tr>
        <tr><td>AK	</td><td>Heating Assistance Program (HAP) </td></tr>
        <tr><td>AL	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>AR	</td><td>Home Energy Assistance Program </td></tr>
        <tr><td>AZ	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>CA	</td><td>Home Energy Assistance Program (HEAP) </td></tr>
        <tr><td>CO	</td><td>Low Income Energy Assistance Program (LEAP) </td></tr>
        <tr><td>CT	</td><td>Connecticut Energy Assistance Program (CEAP) </td></tr>
        <tr><td>DC	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>DE	</td><td>Delaware Energy Assistance Program (DEAP) </td></tr>
        <tr><td>FL	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>GA	</td><td>Regular Energy Assistance Program </td></tr>
        <tr><td>HI	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>IA	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>ID	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>IL	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>IN	</td><td>Energy Assistance Program </td></tr>
        <tr><td>KS	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
        <tr><td>KY	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>LA	</td><td>Low Income Home Energy Assistance (LIHEAP) </td></tr>
        <tr><td>MA	</td><td>Low Income Home Energy Assistance (LIHEAP) </td></tr>
        <tr><td>MD	</td><td>Maryland Energy Assistance Program (MEAP) </td></tr>
        <tr><td>ME	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>MI	</td><td>Home Heating Credit/LIHEAP </td></tr>
        <tr><td>MN	</td><td>Energy Assistance Program (EAP) </td></tr>
        <tr><td>MO	</td><td>Low Income Home Energy Assistance Program </td></tr>
        <tr><td>MS	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>MT	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
        <tr><td>NC	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
        <tr><td>ND	</td><td>Heating Assistance or Low-Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>NE	</td><td>Low Income Energy Assistance Program </td></tr>
        <tr><td>NH	</td><td>Fuel Assistance Program </td></tr>
        <tr><td>NJ	</td><td>Home Energy Assistance </td></tr>
        <tr><td>NM	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>NV	</td><td>Energy Assistance Program (EAP) </td></tr>
        <tr><td>NY	</td><td>Home Energy Assistance Program (HEAP) </td></tr>
        <tr><td>OH	</td><td>Home Energy Assistance Program (HEAP) </td></tr>
        <tr><td>OK	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>OR	</td><td>Low Income Home Energy Assistance (LIHEAP) </td></tr>
        <tr><td>PA	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>RI	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>SC	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>SD	</td><td>The Low Income Energy Assistance Program (LIEAP) </td></tr>
        <tr><td>TN	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>TX	</td><td>Comprehensive Energy Assistance Program (CEAP) </td></tr>
        <tr><td>UT	</td><td>Home Energy Assistance Target (HEAT) </td></tr>
        <tr><td>VA	</td><td>Energy Assistance </td></tr>
        <tr><td>VT	</td><td>Fuel Assistance Program </td></tr>
        <tr><td>WA	</td><td>Low Income Home Energy Assistance Program (LIHEAP) </td></tr>
        <tr><td>WI	</td><td>Wisconsin Home Energy Assistance Program (WHEAP) </td></tr>
        <tr><td>WV	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
        <tr><td>WY	</td><td>Low Income Energy Assistance Program (LIEAP) </td></tr>
		</B>
    </TABLE>
    <table border="0" cellpadding="0" width="400" class="text1">
        <TR>
			<TD ALIGN="center" height="38" valign="middle">
				<INPUT style="font-weight:bold;" class="button" TYPE="button" VALUE="Close" ONCLICK="window.close();">
			</TD>
		</TR>
    </table>
</div>
</cfif> 


</FORM>

