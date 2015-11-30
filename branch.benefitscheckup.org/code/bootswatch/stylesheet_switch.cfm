
	<cfparam name="url.style" default="default"> 

	<cfswitch expression="#url.style#">
	<cfcase value="default">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="esi">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_esi.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="cosmo">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_cosmo.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="amelia">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_amelia.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="cerulean">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_cerulean.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="cyborg">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_cyborg.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="journal">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_journal.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="readable">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_readable.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="simplex">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_simplex.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="slate">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_slate.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="spacelab">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_spacelab.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="spruce">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_spruce.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="superhero">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_superhero.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
	<cfcase value="united">
		<cfoutput><link href="/cf/bootswatch/bootstrap/css/bootstrap_united.min.css" rel="stylesheet"></cfoutput>
	</cfcase>
    </cfswitch>
