<!----=======================================

DESCRIPTION: Dumps the session variables into the tbl_answers

CALLED BY: prodEligibility.cfm or tagErrorPage.cfm

GOES TO: Caller

REQUIRED: N/A

============================================---->



<!--- take out the session variables that are arrays or structures --->

<cfloop collection = "#session#" item = "variable">

<CFIF variable NEQ "questionarray" AND variable NEQ "questionsecarray" AND variable NEQ "questionsecdeparray" AND variable NEQ "FIELDNAMES">

	<CFIF variable NEQ "income">

	<CFIF variable NEQ "incometable">

	<CFIF variable NEQ "prg_list">

	<CFIF variable NEQ "zip">

	<CFIF variable NEQ "email">

	<CFIF variable NEQ "category">	

	<CFIF variable NEQ "zipdat">

			<!--- dump the remaining variables, wheather numeric or not --->

			<CFIF #StructFind(session, "#variable#")# NEQ "Z" AND #StructFind(session, "#variable#")# NEQ "0">

		          <CFSET temp = #StructFind(session, "#variable#")#>

			  <CFIF IsNumeric(temp)>

			  	<CFQuERY datasource="#application.dbSrc#">

				INSERT INTO tbl_inc_cnty (mem1, mem2, mem3)

				Select #session.clientnum#, '#variable#', #temp#

				</cfquery>

			<CFELSE>			  

			  	<CFQuERY datasource="#application.dbSrc#">

				INSERT INTO tbl_inc_cnty (mem1, mem2, mem3)

				Select #session.clientnum#, '#variable#', '#temp#'

				</cfquery>

			  </cfif>

		<CFELSE>	  

			  

		</CFIF>

	</CFIF>

	</CFIF>

	</cfif>

	</CFIF>

	</cfif>

	</CFIF>

	</CFIF>

</CFIF>

</cfloop> 

















