<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the SpendDown asset disregard rule
CALLED BY: procBuffer
GOES TO: Caller
REQUIRED: rule = the eligibility rule as a string
RETURNS: answer = YES or NO dependant on if user is eligible
NOTE: The manipulation of the numbers is determined by the content staff
		the rule by structure gives us the single person limit, and the married limit  the rule will be 
		structured assuch  spenddown-singlelimit-marriedlimit so  we do a get token function 
		to set the limits within the tag,  then we offset that limit cus this is the buffer.
============================================---->
<CFSET strRule = attributes.rule>
					<CFSET self = gettoken(strRule,2,"-")>
					<CFSET self_spouse = gettoken(strRule,3,"-")>
		<!--- First check to see if not married --->
		<CFIF #SESSION.MARITAL_STAT# NEQ 'Married'>
			<!--- Do the calculations of the self income --->
				<CFIF #session.s_asset_life_face# LT 1500 or #session.s_asset_life_face# EQ 1500>
					<CFSET exclusion = #session.s_asset_life_cash#>
				<CFELSE>
					<CFSET exclusion = 0>
				</CFIF>
				
				<CFSET X = #session.s_asset_life_face# + #session.s_asset_irrevocable#>
					<CFIF X GT 1500>
						<CFSET burialexclusion = 0>
					<CFELSE>
						<CFSET burialexclusion = 1500 - #X#>
					</CFIF>
					
					<CFIF #session.s_asset_revocable# GT #burialexclusion#>
						<CFSET exclusion2 = #burialexclusion#>
					<CFELSE>
						<CFSET exclusion2 = #session.s_asset_revocable#>
					</CFIF>
					
					<CFSET exclusion3 = #session.s_asset_auto1# + #session.s_asset_home#>
				<CFSET Z = #session.s_asset_total_complete# - (#exclusion# + #exclusion2# + #exclusion3#)>
					<!--- Compare our figure to the self figure passed in --->
				<CFIF Z lte (#self#)>
					<CFSET answer = 'YES'>
				<CFELSE>
					<CFSET answer = 'NO'>
				</CFIF>
		<!--- Check if Married --->		
		<CFELSEIF #SESSION.MARITAL_STAT# EQ 'Married'>
			<!--- Do the calculations of the self and spouse income --->
				<CFIF #session.s_sp_asset_life_face# LT 1500 or #session.s_sp_asset_life_face# EQ 1500>
					<CFSET exclusion = #session.s_sp_asset_life_cash#>
				<CFELSE>
					<CFSET exclusion = 0>
				</CFIF>
				
				<CFSET X = #session.s_sp_asset_life_face# + #session.s_sp_asset_irrevocable#>
					<CFIF X GT 1500>
						<CFSET burialexclusion = 0>
					<CFELSE>
						<CFSET burialexclusion = 1500 - #X#>
					</CFIF>
					
					<CFIF #session.s_sp_asset_revocable# GT #burialexclusion#>
						<CFSET exclusion2 = #session.s_sp_asset_revocable# - #burialexclusion#>
					<CFELSE>
						<CFSET exclusion2 = #session.s_sp_asset_revocable#>
					</CFIF>
					
					<CFSET exclusion3 = #session.s_sp_asset_auto1# + #session.s_sp_asset_home#>
					
				<CFSET Z = #session.s_sp_asset_total_complete# - (#exclusion# + #exclusion2# + #exclusion3#)>
						<!--- Compare our figure to the self and spouse figure passed in --->
						<CFIF Z lte (#self_spouse#)>
							<CFSET answer = 'YES'>
						<CFELSE>
							<CFSET answer = 'NO'>
						</CFIF>
			</CFIF>

<!--- Pass back the answer....   should be Yes or No --->
<CFOUTPUT><CFSET caller.answer = #answer#></CFOUTPUT>