<!--- BShunn 2004-09-09  Returns Yes if the program is NOT found in the list --->
<cfparam name="attributes.prg_id" type="string" default="">
<cfparam name="attributes.var" type="string" default="">
<!--- BShunn 2004-09-09  Set prgHideList to be a comma-delimited list of program IDs we want
      to prevent from appearing on the Application Guide --->
<cfset prgHideList = '103-311-2588-FD-FD,103-311-2592-FD-FD,103-311-2593-FD-FD,XXX-311-2387-FD-FD'>
<cfset outval = ListFindNoCase(prgHideList, attributes.prg_id) Eq 0>
<cfif attributes.var eq ''>
	<cfoutput>#outval#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outval>
</cfif>