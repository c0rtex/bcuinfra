		<CFSET msgSingle = "This is the only office for this program.">
		<CFSET msgA = "The closest office could not be determined because a zip code was not entered.">
		<CFSET msgB = "This is the regional office that serves the zip code you entered.  All program inquiries should be made through this office.">
		<CFSET msgC = "There are no offices within 35 miles of the zip code you entered.">
		<CFSET msgD = "There is one office within 35 miles of the zip code you entered.">
		<CFSET msgE = "There are two offices within 35 miles of the zip code you entered.">
		<CFSET msgF = "There are three offices within 35 miles of the zip code you entered.">
		<CFSET msgG = "There are more than three offices within 35 miles.  These are the three closest to the zip code you entered.">

		<CFSET msgH = "The closest office could not be determined.">
		<CFSET msgChicago = "These are the regional offices that serve Cook county.">

		<cfset attributes.county = #session.county#>	

		<!--- Call to insert entry point info for report page --->

		<!---  Lets set the incoming variables to local naming --->

		<CFIF ISDEFINED("attributes.report")>

			<CFSET prg_id = #attributes.prg_id#>

			<CFSET county = #attributes.county#>

		</CFIF>

		<CFIF ISDEFINED("attributes.clientnum")>

			<CFSET clientnum =  attributes.clientnum >

		</CFIF>

		<CFSET usercounty = #attributes.county#>

		<!--- ================================================ --->

		<!--- This is against all the rules of programming, but this if statement is for the special

			occurance of the Chicago entry point that goes by the city limits and not the zip or

			county constraints that we use every where else in the USA --->

<!--- Pull in the entry points for the program --->

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry">

SELECT org_id,group_id

FROM tbl_prg_entry

WHERE prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

</CFQUERY>
<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">


<!--- Check to see if the program pulled in is Federal or state and then pull the proximity --->

<CFIF FindNoCase("FD", prg_id ) GT 0>

<CFSET PrgSt = "FD">

<CFELSE> 

<CFSET PrgSt = session.ST>

</CFIF>



<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prox">

SELECT proximity

FROM tbl_prg_all

WHERE prg_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

</CFQUERY>



<CFSET proximity = '#prox.proximity#'>



<!---  we need to check if we are dealing with a group of entry points  / added single quotes to group_id 12/12--->

<!---  we also need to make sure that we pull from MN if we are dealing with MN2 as state --->



<CFIF entry.group_id IS NOT 0>

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="cnt"> 

SELECT org_id

FROM tbl_entry

WHERE group_id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="'#entry.group_id#">

and st = '#left(session.st,2)#'

</CFQUERY>

<!--- set count to number of total entry points in state --->

<CFSET count = cnt.recordcount>

<!--- Also set entryst to the state --->

<CFSET entryst = left(session.st,2)>



<!--- Check to see if zip was entered by the user --->

<CFIF session.zip is 0>

<!--- Check if we are dealing Local --->

<CFIF proximity is "local" or proximity is "">

<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry2g" maxrows="3">

SELECT * 

FROM tbl_entry

WHERE  group_id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="'#entry.group_id#"> and st = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="#entryst#">

</CFQUERY>



<CFIF #count# is 1>

<cfquery name="insertit" datasource="#application.dbSrc#">

Update tbl_UserPrograms set entry_1 = '

This program is administered by a local office. #msgA# Below is the one office located in #left(session.st,2)#.'

where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

</cfquery>

<CFELSE>

<cfquery name="insertit" datasource="#application.dbSrc#">

Update tbl_UserPrograms set entry_1 = '

This program is administered by a local office. #msgA#  Below are offices located in #left(session.st,2)#.'

where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

</cfquery>

</CFIF>



<cfoutput query="entry2g">



<cfquery name="newquery" datasource="#application.dbSrc#">

Insert into tbl_User_ead

(program_id, session_id, org_name, org_name2, address,address1,address2,city,state, phone, email, web, hours, contact, Fax )

			  Values('#newprg_id#', '#session.cfid#-#session.cftoken#-#session.clientnum2#', '#org_name#', '#org_name2#', '#address#','#address1#', '#address2#', '#city#', '#st#', '#phone_no#', '<A HREF="mailto:#email#">#email#</A>', '<A HREF="http://#web_site#">#web_site#</A>', '#hours#','#contact_title#', '#Fax#')																				



</cfquery>



</cfoutput>


<CFELSE><!--- proximity is county or regional --->

						<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry2g" maxrows="3">

							SELECT * 

							FROM tbl_entry

							WHERE  group_id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="'#entry.group_id#"> and st = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="#entryst#">

					   </CFQUERY>

	

						

						<CFIF #count# is 1>

						<cfquery name="insertit" datasource="#application.dbSrc#">

							Update tbl_UserPrograms set entry_1 = 'This program is administered by a regional office. #msgA# Below is the one office located in #left(session.st,2)#.'

							where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

						</cfquery>

						<CFELSE>

								

								<cfquery name="insertit" datasource="#application.dbSrc#">

									Update tbl_UserPrograms set entry_1 = 'This program is administered by a regional office. Below are the offices located in #left(session.st,2)#.'

									where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

								</cfquery>

							

						</cfif>

						<cfoutput query="entry2g">

						<cfquery name="newquery" datasource="#application.dbSrc#">

							Insert into tbl_User_ead

							(program_id, session_id, org_name, org_name2, address,address1,address2,city,state, phone, email, web, hours, contact, Fax )

							Values('#newprg_id#', '#session.cfid#-#session.cftoken#-#session.clientnum2#', '#org_name#', '#org_name2#', '#address#','#address1#', '#address2#', '#city#', '#st#', '#phone_no#', '<A HREF="mailto:#email#">#email#</A>', '<A HREF="http://#web_site#">#web_site#</A>', '#hours#','#contact_title#', '#Fax#')																				

							

						</cfquery>

						</cfoutput>

 </CFIF><!--- finished checking for proximity within no zip code if --->

		

<CFELSE><!--- Meaning that zip was entered --->

	

			<!--- Check if we are dealing Local --->

			<CFIF proximity is "local" or proximity is "">

	

						<!--- Check to see if any are within 35 miles --->

						<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry2" maxrows="3">

							SELECT *

							FROM tbl_entry, tbl_user_zip

							WHERE	tbl_entry.zip = tbl_user_zip.zip and tbl_user_zip.clientnum = #session.clientnum# and tbl_entry.group_id = #entry.group_id#

								AND tbl_entry.st = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="#entryst#">

							ORDER BY tbl_user_zip.miles

						</CFQUERY>  

						

						<!---  Output accrding to the record count--->

						<CFIF #entry2.recordcount# is 0>

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = '#msgC#'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

							</cfquery>

						</CFIF><!--- recordcount being 0 --->

	

						<CFIF #entry2.recordcount# is 1>

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = '#msgD#'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>

						<CFELSEIF #entry2.recordcount# is 2>

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = '#msgE#'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>

						<CFELSEIF #entry2.recordcount# is 3>

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = '#msgF#'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>

						<CFELSEIF #entry2.recordcount# gt 3>

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = '#msgE# are all #count# offices located in #entryst#.'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>

						</CFIF><!--- recordcount greater than 3 --->

	

							<CFIF #entry2.recordcount# LT #count# or #entry2.recordcount# GT 3>

								<CFIF #count# is 1>

									<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = 'Below is the one office located in #left(session.st,2)#.'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>							

							<CFELSE>

									<cfquery name="msg" datasource="#application.dbSrc#">

									 Update tbl_userPrograms set entry_2 = 'Below are the offices located in #left(session.st,2)#.'

									 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

									</cfquery>

								

								</CFIF>

							<CFELSE>

								<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = 'There are no other offices in #session.st#.'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>

							</CFIF><!--- recordcount equals count --->

							

							<cfoutput query="entry2">

							<cfquery name="newquery" datasource="#application.dbSrc#">

							Insert into tbl_User_ead

							(program_id, session_id, org_name, org_name2, address,address1,address2,city,state, phone, email, web, hours, contact, Fax )

												  Values('#newprg_id#', '#session.cfid#-#session.cftoken#-#session.clientnum2#', '#org_name#', '#org_name2#', '#address#','#address1#', '#address2#', '#city#', '#st#', '#phone_no#', '<A HREF="mailto:#email#">#email#</A>', '<A HREF="http://#web_site#">#web_site#</A>', '#hours#','#contact_title#', '#Fax#')																				

							

							</cfquery>

							</cfoutput>

			<CFELSE><!--- proximity is not local --->

					<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry2a">

						SELECT counties_served,org_id

						FROM tbl_entry

						WHERE group_id = #entry.group_id# and st = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="2" value="#entryst#">

					</CFQUERY>

	

					<CFLOOP query="entry2a"><!--- loop through and see if user's county is in [counties_served] --->

								<CFSET commafind = FINDNOCASE(",", #entry2a.counties_served#, 1)>

								<CFIF commafind NEQ 0>				

									<CFIF listcontainsnocase("#counties_served#","#usercounty#") gt 0 or counties_served EQ "all"> 

										<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry2">

											SELECT *

											FROM tbl_entry

											WHERE org_id = '#entry2a.org_id#' AND group_id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="'#entry.group_id#">

										</CFQUERY>

									<CFBREAK>

									</CFIF>

								<CFELSE>

									<CFSET usercountyspace = "#usercounty#" & " ">

									<CFIF #entry2a.counties_served# EQ #usercounty# OR #entry2a.counties_served# IS "All" OR #entry2a.counties_served# EQ #usercountyspace#>

										<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry2">

											SELECT *

											FROM tbl_entry

											WHERE org_id = '#entry2a.org_id#' AND group_id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="5" value="'#entry.group_id#">

										</CFQUERY>

									<CFBREAK>

									</CFIF>

								</CFIF>

					</CFLOOP>

					<CFIF ISDEFINED("entry2.recordcount")>

						<CFIF #entry2.recordcount# is 1>

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = '#msgB#'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#">

							</cfquery>

						<CFELSE>

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = 'Below are the offices located in #left(session.st,2)#.'

	'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>					

						</CFIF>

					<CFELSE>				

							<cfquery name="msg" datasource="#application.dbSrc#">

							 Update tbl_userPrograms set entry_2 = '#msgH# Below are the offices located in #left(session.st,2)#.'

	'

							 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

							</cfquery>					

							

					</CFIF>

					<cfoutput query="entry2">

							<cfquery name="newquery" datasource="#application.dbSrc#">

							Insert into tbl_User_ead

							(program_id, session_id, org_name, org_name2, address,address1,address2,city,state, phone, email, web, hours, contact, Fax )

												  Values('#newprg_id#', '#session.cfid#-#session.cftoken#-#session.clientnum2#', '#org_name#', '#org_name2#', '#address#','#address1#', '#address2#', '#city#', '#st#', '#phone_no#', '<A HREF="mailto:#email#">#email#</A>', '<A HREF="http://#web_site#">#web_site#</A>', '#hours#','#contact_title#', '#Fax#')																				

							

					</cfquery>

					</cfoutput>

					<!--- recordcount is 1 --->

			</CFIF> <!--- end of proximity if --->

</CFIF> <!--- end of zip if --->

		

</CFIF>         <!--- if group id was a 0   meaning single office --->

<CFIF entry.group_id is 0>



<CFQUERY DATASOURCE="#application.dbSrc#" NAME="entry2">

SELECT * 

FROM tbl_entry

WHERE org_id = #entry.org_id#

</CFQUERY>

<CFSET count = 1>

<cfquery name="msg" datasource="#application.dbSrc#">

	 Update tbl_userPrograms set entry_2 = '#msgSingle#'

	 where program_id =<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="25" value="#prg_id#"> 

</cfquery>





<CFIF ISDEFINED("entry2.recordcount")>

<cfset newprg_id = #prg_id#>

<cfloop query="entry2" startrow="1" endrow="3" >



<CFOUTPUT QUERY="entry2" >

<CFSET strZip = #zip#>

<cfset CharDot = FindNoCase(".",strzip,1)>

					<CFIF CharDot NEQ 0>

						<CFSET strzip = #LEFT(strzip, CharDot-1)#>

					</cfif>

					<CFSET strZip = "000#StrZip#">

					<CFSET strZip = right(strZip, 5)>#strZip#

<cfquery name="newquery" datasource="#application.dbSrc#">

Insert into tbl_User_ead

(program_id, session_id, org_name, org_name2, address,address1,address2,city,state,zip, phone, email, web, hours, contact )

Values('#newprg_id#', '#session.cfid#-#session.cftoken#-#session.clientnum2#', '#org_name#', '#org_name2#', '#address#','#address1#', '#address2#', '#city#', '#st#', '#strzip#', '#phone_no#', '<A HREF="mailto:#email#">#email#</A>', '<A HREF="http://#web_site#">#web_site#</A>', '#hours#','#contact_title#')

</cfquery>

</cfoutput>		

</cfloop>

</CFIF> <!--- if recordcount is defined --->

</CFIF><!---  End of full if statement, starting with group id --->







