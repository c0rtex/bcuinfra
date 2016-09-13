<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content="text/html; charset=utf-8" http-equiv=Content-Type></HEAD>
<BODY>
<table>
<cfloop list="mspenrollees,totalpd,totallis,totalliselg,totalcovered,totalautoenroll,ssitotal,snapeleg60,snapelegall,partsnapadjall,partsnapall,tothhfedmax,tothh100fpl,tothh150fpl,liheappartheathh,liheappartcoolhh,cpstotpop65,cpsfpl100,cpsfpl125,cpsfpl135,cpsfpl150,cpsfpl185,cpsfpl200,asc100fpl,asc125fpl,asc150fpl,asc200fpl,asc300fpl,pdconcen,lisconcen,mspconcen,partratepd,coveragerate,partratelis,listargetrate,autoenrollrate,listopd,chnglistargtrate,lostdeemed,lostdeemrate" index="ListItem" delimiters=",">
<cfoutput>
I am doing #ListItem#<BR><BR>
<cfquery name="nineList" datasource="#application.dbSrc#">
	SELECT dataelement_id, `#ListItem#`
	FROM mp_dataelement
	where #ListItem# = 999999
</cfquery>
<cfloop query="nineList">
	<cfif Evaluate(ListItem) eq 999999>					
		<cfquery name="update" datasource="#application.dbSrc#">
			UPDATE mp_dataelement
   			SET `#ListItem#` = null
			where dataelement_id = #dataelement_id#
      		</cfquery>
	</cfif>
</cfloop>
</cfoutput>
</cfloop>
</table>
</BODY></HTML>