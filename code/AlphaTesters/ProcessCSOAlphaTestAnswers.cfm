<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Alpha Tester's Survey Completed</title>
</head>
<!--- give us a timestamp --->
<CFSET form.WhenInserted = CreateODBCDATETIME(now())>

<!--- param all answers to an empty string (if text) or 0 (if int), so that they can be entered into db as such (and not have to be if tested in the insert statement) --->
<CFPARAM default="0" name="form.Lookfeel">
<CFPARAM default="0" name="form.Easeofuse">
<CFPARAM default="0" name="form.Navigationflow">
<CFPARAM default="0" name="form.OnlineAssistance">
<CFPARAM default="0" name="form.LoginProcess">
<CFPARAM default="0" name="form.OrgProfile">
<CFPARAM default="0" name="form.EstablishingUsers">
<CFPARAM default="0" name="form.AddingLocal">
<CFPARAM default="0" name="form.AccessingStats">
<CFPARAM default="0" name="form.ViewingPrintable">
<CFPARAM default="" name="form.Generalreactions ">
<CFPARAM default="0" name="form.NeededFunctionality">
<CFPARAM default="" name="form.Functionalityservices">
<CFPARAM default="" name="form.Supplementinfo">
<CFPARAM default="0" name="form.Numberscreened">
<CFPARAM default="0" name="form.Comppublic">
<CFPARAM default="0" name="form.Fastdata">
<CFPARAM default="0" name="form.Detailedonline">
<CFPARAM default="0" name="form.Readilyavailable">
<CFPARAM default="0" name="form.Availableprintable">
<CFPARAM default="0" name="form.Accessstats">
<CFPARAM default="0" name="form.Abilitytoshare">
<CFPARAM default="0" name="form.Abilitytocobrand">
<CFPARAM default="0" name="form.Availableresults">
<CFPARAM default="0" name="form.Manageaccess">
<CFPARAM default="0" name="form.Managenews">
<CFPARAM default="0" name="form.Rankofother">
<CFPARAM default="" name="form.OtherRanked">
<CFPARAM default="" name="form.Biggestbenefit">
<CFPARAM default="" name="form.Morehelpful">
<CFPARAM default="0" name="form.Recommendorg">
<CFPARAM default="0" name="form.Soinexpensive">
<CFPARAM default="0" name="form.Aboutrightprice">
<CFPARAM default="0" name="form.Tooexpensive">
<CFPARAM default="" name="form.compelling1">
<CFPARAM default="" name="form.compelling2">
<CFPARAM default="" name="form.compelling3">
<CFPARAM default="" name="form.OtherEffectiveChannel">
<CFPARAM default="0" name="form.willingtohelp">
<CFPARAM default="" name="form.AnyAdditional">

<!--- <CFIF NOT len(trim(form.Comppublic))>
	<CFSET form.Comppublic = 0>
</cfif>  
<CFIF NOT len(trim(form.COMPDATA))>
	<CFSET form.COMPDATA = 0>
</cfif>  
<CFIF NOT len(trim(form.Fastdata))>
	<CFSET form.Fastdata = 0>
</cfif>  
<CFIF NOT len(trim(form.Detailedonline))>
	<CFSET form.Detailedonline = 0>
</cfif>  
<CFIF NOT len(trim(form.Readilyavailable))>
	<CFSET form.Readilyavailable = 0>
</cfif>  
<CFIF NOT len(trim(form.Availableprintable))>
	<CFSET form.Availableprintable = 0>
</cfif>  
<CFIF NOT len(trim(form.Accessstats))>
	<CFSET form.Accessstats = 0>
</cfif>  
<CFIF NOT len(trim(form.Abilitytoshare))>
	<CFSET form.Abilitytoshare = 0>
</cfif>  
<CFIF NOT len(trim(form.Abilitytocobrand))>
	<CFSET form.Abilitytocobrand = 0>
</cfif>  
<CFIF NOT len(trim(form.Abilitytocobrand))>
	<CFSET form.Abilitytocobrand = 0>
</cfif>  
<CFIF NOT len(trim(form.AvailableResults))>
	<CFSET form.AvailableResults = 0>
</cfif>  
<CFIF NOT len(trim(form.Manageaccess))>
	<CFSET form.Manageaccess = 0>
</cfif>  
<CFIF NOT len(trim(form.Managenews))>
	<CFSET form.Managenews = 0>
</cfif>  
<CFIF NOT len(trim(form.Rankofother))>
	<CFSET form.Rankofother = 0>
</cfif>  
<CFIF NOT len(trim(form.Soinexpensive ))>
	<CFSET form.Soinexpensive  = 0>
</cfif>  
<CFIF NOT len(trim(form.Aboutrightprice))>
	<CFSET form.Aboutrightprice = 0>
</cfif>  
<CFIF NOT len(trim(form.Tooexpensive))>
	<CFSET form.Tooexpensive = 0>
</cfif>  
<CFIF NOT len(trim(form.Numberscreened))>
	<CFSET form.Numberscreened = 0>
</cfif>   --->


<!--- finally, put all 'effective' checked answers into form.EFFECTIVE --->
<CFSET form.EffectiveList = "">
<cfloop collection="#form#" item="this"><!--- loop over all form elements --->
	<CFIF left(this,9) is "effective" AND this neq 'EffectiveList'>
		<CFSET form.EffectiveList=ListAppend(form.EffectiveList,this)>
	</cfif>
	<CFIF NOT len(trim(evaluate(this)))>
		<CFSET form.ABILITYTOCOBRAND = 0>
		<CFSET "form.#this#" = 0><!--- <CFOUTPUT>#this#- #evaluate(this)#<br></cfoutput> --->
	</cfif> 
</cfloop> 

<body>

<CFQUERY name="processResults" datasource="#session.datasrc#">
	Insert into tbl_CSOAlphaTestFeedback (CFID, CFTOKEN, dtAdded, Username, Useremail, Lookfeel, Easeofuse, Navigationflow, OnlineAssistance, LoginProcess, OrgProfile, EstablishingUsers, AddingLocal, AccessingStats, ViewingPrintable, Generalreactions, NeededFunctionality, Functionalityservices, Supplementinfo, Numberscreened, Comppublic, Compdata, Fastdata, Detailedonline, Readilyavailable, Availableprintable, Accessstats, Abilitytoshare, Abilitytocobrand, Availableresults, Manageaccess, Managenews, Rankofother, OtherRanked, Biggestbenefit, Morehelpful, Recommendorg, Soinexpensive, Aboutrightprice, Tooexpensive, compelling1, compelling2, compelling3, EFFECTIVE, OtherEffectiveChannel, willingtohelp, AnyAdditional)
	VALUES
	(#session.CFID#, 
	#session.CFTOKEN#, 
	#form.WhenInserted#, 
	'#form.Username#', 
	'#form.Useremail#', 
	#form.Lookfeel#, 
	#form.Easeofuse#, 
	#form.Navigationflow#, 
	#form.OnlineAssistance#, 
	#form.LoginProcess#, 
	#form.OrgProfile#, 
	#form.EstablishingUsers#, 
	#form.AddingLocal#, 
	#form.AccessingStats#, 
	#form.ViewingPrintable#, 
	'#form.Generalreactions#', 
	#form.NeededFunctionality#, 
	'#form.Functionalityservices#', 
	'#form.Supplementinfo#', 
	#form.Numberscreened#, 
	#form.Comppublic#, 
	#form.Compdata#, 
	#form.Fastdata#, 
	#form.Detailedonline#, 
	#form.Readilyavailable#, 
	#form.Availableprintable#,  
	#form.Accessstats#, 
	#form.Abilitytoshare#, 
	#form.Abilitytocobrand#, 
	#form.Availableresults#, 
	#form.Manageaccess#, 
	#form.Managenews#, 
	#form.Rankofother#, 
	'#form.OtherRanked#', 
	'#form.Biggestbenefit#', 
	'#form.Morehelpful#', 
	#form.Recommendorg#, 
	#form.Soinexpensive#, 
	#form.Aboutrightprice#, 
	#form.Tooexpensive#, 
	'#form.compelling1#', 
	'#form.compelling2#', 
	'#form.compelling3#', 
	'#form.EffectiveList#', 
	'#form.OtherEffectiveChannel#', 
	#form.willingtohelp#, 
	'#form.AnyAdditional#')
</cfquery> 
<BR><BR><BR>
<CENTER>
<TABLE WIDTH=550>
<TR><TD>
<CENTER><FONT FACE=arial size=4><b>Thank you</b></center><BR> for taking the time to complete the Alpha Testers' Survey. Your answers are of great value and sincerely appreciated! If you have any questions or additional comments, please send us an email to <A HREF="mailto=cso@benefitscheckup.org">cso@benefitscheckup.org</a></foNT>
</td></tr></table></center>
</body>


</html>
