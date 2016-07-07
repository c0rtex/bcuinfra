             <!----=======================================
DESCRIPTION: Adds the users answers, first accross, then down.
CALLED BY: procAsset
GOES TO: Caller
REQUIRED: N/A		
============================================---->
<!--- This is custom tag to set asset and asset variables --->
<!--- 07/09/2002 REM  REMOVED BANK vars--they're no longer used on the form, but they were still in here. --->
<cfif session.skipassets eq 'n'>
	
	<!--- 07/18/02 REM  We set each cell value to the Max Asset val, so any test using the cell
	value will fail --->
	<cfset valMaxAsset = 100501>
	
	<cfset session.S_SP_ASSET_CASH = valMaxAsset>
	<cfset session.HH_ASSET_CASH = valMaxAsset>
	
	<cfset session.S_SP_ASSET_STOCKS = valMaxAsset>
	<cfset session.HH_ASSET_STOCKS = valMaxAsset>
	
	<cfset session.S_SP_ASSET_LIFE_CASH = valMaxAsset>
	<cfset session.HH_ASSET_LIFE_CASH = valMaxAsset>
	
	<cfset session.S_SP_ASSET_LIFE_FACE = valMaxAsset>
	<cfset session.HH_ASSET_LIFE_FACE = valMaxAsset>
	
	<cfset session.S_SP_ASSET_AUTO1 = valMaxAsset>
	<cfset session.HH_ASSET_AUTO1 = valMaxAsset>
	
	<cfset session.S_SP_ASSET_AUTO2 = valMaxAsset>
	<cfset session.HH_ASSET_AUTO2 = valMaxAsset>
	
	<cfset session.S_SP_ASSET_RETIREMENT = valMaxAsset>
	<cfset session.HH_ASSET_RETIREMENT = valMaxAsset>
	
	<cfset session.S_SP_ASSET_HOME = valMaxAsset>
	<cfset session.HH_ASSET_HOME = valMaxAsset>
	
	<cfset session.S_SP_ASSET_REVOCABLE = valMaxAsset>
	<cfset session.HH_ASSET_REVOCABLE = valMaxAsset>
	
	<cfset session.S_SP_ASSET_IRREVOCABLE = valMaxAsset>
	<cfset session.HH_ASSET_IRREVOCABLE = valMaxAsset>
	
	<cfset session.S_SP_ASSET_OTHER_A = valMaxAsset>
	<cfset session.HH_ASSET_OTHER_A = valMaxAsset>

	<!--- 07/18/02 REM  Now we set the totals to the total of all of the above, plus one (so we'll always be
	over the buffer limit) --->
	<cfset session.S_ASSET_TOTAL_COMPLETE = (valMaxAsset * 11) + valMaxAsset>
	<cfset session.SP_ASSET_TOTAL_COMPLETE = (valMaxAsset * 11) + valMaxAsset>
	<cfset session.S_SP_ASSET_TOTAL_COMPLETE = (valMaxAsset * 11) + valMaxAsset>
	<cfset session.HH_ASSET_TOTAL_COMPLETE = (valMaxAsset * 11) + valMaxAsset>

<cfelse>

	<cfset session.S_SP_ASSET_CASH = session.S_SP_ASSET_CASH + session.S_ASSET_CASH + session.sp_ASSET_CASH>
	<cfset session.HH_ASSET_CASH = session.HH_ASSET_CASH + session.S_SP_ASSET_CASH>
	
	<cfset session.S_SP_ASSET_STOCKS = session.S_SP_ASSET_STOCKS + session.S_ASSET_STOCKS + session.sp_ASSET_STOCKS>
	<cfset session.HH_ASSET_STOCKS = session.HH_ASSET_STOCKS + session.S_SP_ASSET_STOCKS>
	
	<cfset session.S_SP_ASSET_LIFE_CASH = session.S_SP_ASSET_LIFE_CASH + session.S_ASSET_LIFE_CASH + session.sp_ASSET_LIFE_CASH>
	<cfset session.HH_ASSET_LIFE_CASH = session.HH_ASSET_LIFE_CASH + session.S_SP_ASSET_LIFE_CASH>
	
	<cfset session.S_SP_ASSET_LIFE_FACE = session.S_SP_ASSET_LIFE_FACE + session.S_ASSET_LIFE_FACE + session.sp_ASSET_LIFE_FACE>
	<cfset session.HH_ASSET_LIFE_FACE = session.HH_ASSET_LIFE_FACE + session.S_SP_ASSET_LIFE_FACE>
	
	<cfset session.S_SP_ASSET_AUTO1 = session.S_SP_ASSET_AUTO1 + session.S_ASSET_AUTO1 + session.sp_ASSET_AUTO1>
	<cfset session.HH_ASSET_AUTO1 = session.HH_ASSET_AUTO1 + session.S_SP_ASSET_AUTO1>
	
	<cfset session.S_SP_ASSET_AUTO2 = session.S_SP_ASSET_AUTO2 + session.S_ASSET_AUTO2 + session.sp_ASSET_AUTO2>
	<cfset session.HH_ASSET_AUTO2 = session.HH_ASSET_AUTO2 + session.S_SP_ASSET_AUTO2>
	
	<cfset session.S_SP_ASSET_RETIREMENT = session.S_SP_ASSET_RETIREMENT + session.S_ASSET_RETIREMENT + session.sp_ASSET_RETIREMENT>
	<cfset session.HH_ASSET_RETIREMENT = session.HH_ASSET_RETIREMENT + session.S_SP_ASSET_RETIREMENT>
	
	<cfset session.S_SP_ASSET_HOME = session.S_SP_ASSET_HOME + session.S_ASSET_HOME + session.sp_ASSET_HOME>
	<cfset session.HH_ASSET_HOME = session.HH_ASSET_HOME + session.S_SP_ASSET_HOME>
	
	<cfset session.S_SP_ASSET_REVOCABLE = session.S_SP_ASSET_REVOCABLE + session.S_ASSET_REVOCABLE + session.sp_ASSET_REVOCABLE>
	<cfset session.HH_ASSET_REVOCABLE = session.HH_ASSET_REVOCABLE + session.S_SP_ASSET_REVOCABLE>
	
	<cfset session.S_SP_ASSET_IRREVOCABLE = session.S_SP_ASSET_IRREVOCABLE + session.S_ASSET_IRREVOCABLE + session.sp_ASSET_IRREVOCABLE>
	<cfset session.HH_ASSET_IRREVOCABLE = session.HH_ASSET_IRREVOCABLE + session.S_SP_ASSET_IRREVOCABLE>
	
	<cfset session.S_SP_ASSET_OTHER_A = session.S_SP_ASSET_OTHER_A + session.S_ASSET_OTHER_A + session.sp_ASSET_OTHER_A>
	<cfset session.HH_ASSET_OTHER_A = session.HH_ASSET_OTHER_A + session.S_SP_ASSET_OTHER_A>
	
	<cfset session.S_ASSET_TOTAL_COMPLETE = session.S_ASSET_AUTO1 + session.S_ASSET_AUTO2 +  session.S_ASSET_CASH  +  session.S_ASSET_HOME +  session.S_ASSET_LIFE_CASH + session.S_ASSET_OTHER_A  + session.S_ASSET_RETIREMENT + session.S_ASSET_REVOCABLE + session.S_ASSET_STOCKS>
	
	<cfset session.SP_ASSET_TOTAL_COMPLETE = session.SP_ASSET_AUTO1 + session.SP_ASSET_AUTO2 + session.SP_ASSET_CASH + session.SP_ASSET_HOME + session.SP_ASSET_LIFE_CASH + session.SP_ASSET_OTHER_A + session.SP_ASSET_RETIREMENT + session.SP_ASSET_REVOCABLE + session.SP_ASSET_STOCKS>
	
	<cfset session.S_SP_ASSET_TOTAL_COMPLETE = session.S_SP_ASSET_AUTO1 + session.S_SP_ASSET_AUTO2 + session.S_SP_ASSET_CASH  + session.S_SP_ASSET_HOME  + session.S_SP_ASSET_LIFE_CASH + session.S_SP_ASSET_OTHER_A + session.S_SP_ASSET_RETIREMENT + session.S_SP_ASSET_REVOCABLE + session.S_SP_ASSET_STOCKS>
	
	<cfset session.HH_ASSET_TOTAL_COMPLETE = session.HH_ASSET_AUTO1 + session.HH_ASSET_AUTO2 + session.HH_ASSET_CASH + session.HH_ASSET_HOME  + session.HH_ASSET_LIFE_CASH + session.HH_ASSET_OTHER_A + session.HH_ASSET_RETIREMENT + session.HH_ASSET_REVOCABLE + session.HH_ASSET_STOCKS>

</cfif>