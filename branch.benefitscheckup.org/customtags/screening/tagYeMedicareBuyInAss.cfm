<!----=======================================
<cfset session.s_asset_auto1 = ReReplace(session.s_asset_auto1,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_asset_auto1 = reReplaceNoCase(session.s_asset_auto1, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
<cfset session.s_asset_home = ReReplace(session.s_asset_home,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_asset_home = reReplaceNoCase(session.s_asset_home, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
<cfset session.s_asset_life_face = ReReplace(session.s_asset_life_face,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_asset_life_face = reReplaceNoCase(session.s_asset_life_face, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
<cfset session.s_asset_life_cash = ReReplace(session.s_asset_life_cash,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_asset_life_cash = reReplaceNoCase(session.s_asset_life_cash, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->


<cfset session.s_asset_irrevocable = ReReplace(session.s_asset_irrevocable,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_asset_irrevocable = reReplaceNoCase(session.s_asset_irrevocable, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->
<cfset session.s_asset_revocable = ReReplace(session.s_asset_revocable,'\.(.*)','','ALL')> <!--- remove anything after a .--->
<cfset session.s_asset_revocable = reReplaceNoCase(session.s_asset_revocable, '[^[:digit:]]', '', 'ALL') > <!---Lynna Cekova: replace all nonnumeric characters such as $ --->


<cfset ynDoBuffer = attributes.ynDoBuffer>