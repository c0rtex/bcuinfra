

<cfquery name="results10"  datasource="#application.dbsrc#">				 
select screening_id, subset_id from screening where screening_id in (
7511980,7512089,7512244,7512247,7512322,7512463,7512729,7515079,7515398,7518325,7518433,7525789
)
</cfquery>
<cfdump var="#results10#"><cfabort>
<cfquery name="results10"  datasource="#application.dbsrc#">				 
select * from click
order by screening_id
desc
limit 10

</cfquery>
<cfdump var="#results10#"><cfabort>
<cfquery name="results10"  datasource="wp_benefitscheckup">	
			 
select * from wp_2_posts where id  in (
2632,
2691,
2694,
2697,
2702,
3684,
2708,
2711,
2714,
3685,
3686,
3687,
3688,
3689,
2757,
2760,
3690,
3691,
2769,
2772,
3696,
2778,
2782,
2786,
2790,
2793,
2799,
3175,
3195,
3467,
3469,
3471,
3473,
10706,
10708,
10712,
10714,
10722,
11109,
11113,
11115,
11942,
11944,
12076,
12471,
12471,
12473,
12473,
12475,
12475,
12477,
12477,
12479,
12481,
12481,
12483,
12483,
12485,
12485,
12487,
12487,
12489,
12489,
12491,
12491,
12493,
12493,
12495,
12495,
12497,
12497,
12499,
12499,
12501,
12501,
12503,
12503,
12505,
12505,
12507,
12507,
12509,
12509,
12511,
12511,
12513,
12515,
12515,
12517,
12517,
12519,
12519,
12521,
12521,
12523,
12523,
12525,
12525,
12527,
12527,
12529,
12529,
12531,
12531,
12533,
12533,
12535,
12535,
12537,
12539,
12539,
12541,
12541,
12543,
12543,
12545,
12545,
12547,
12547,
12549,
12549,
12551,
12551,
12553,
12553,
12555,
12555,
12557,
12557,
12559,
12561,
12561,
12565,
12569,
12573,
12573,
12755,
12794,
12794,
13545,
13547,
13549,
13551,
13661,
13663,
13665,
13667,
13669,
13671,
13673,
13675,
13677,
13766,
13792,
13807,
13843,
13864,
13976,
13982,
13987,
14045,
14047,
14051,
14054,
14207,
14223,
14368,
14372,
14374,
14377,
14379,
3484,
3403,
13698,
12360,14120,135333,13570,13572,13574,13587,13589,13353,13413,13867
) 

</cfquery>
11583
<cfdump var="#results10#">

<cfquery name="results10"  datasource="#APPLICATION.dbSrc#">				 
select * from subset_content;
</cfquery>
<cfdump var="#results10#"><cfabort>
<cfquery name="results10"  datasource="#application.dbsrc#">				 
update answerfield set answerfieldtype_id = 6 where answerfield_id = 7324
</cfquery>
<cfquery name="results10"  datasource="#application.dbsrc#">				 
select * from answerfield where answerfield like '%hsa%'
</cfquery>
<cfdump var="#results10#"><cfabort>

<cfquery name="results9"  datasource="#APPLICATION.dbSrc#">

	select  sa.response as agency_id, s.client_id as vendor_id from screening s, screening_answerfield sa where 
	sa.screening_id = s.screening_id 
	and
	end_datetime > '2010-01-01' and s.partner_id = 76   and sa.answerfield_id = 6271 
	group by agency_id
	


		
                                            
</cfquery><cfdump var="#results9#"><cfabort>
<table border=1><tr><td>clientid</td><td>screeningid</td><td>date</td></tr>
<cfloop query="results9">
<cfoutput><tr><td>#client_id#</td><td>#screening_id#</td><td>#end_datetime#</td><td>http://www.benefitscheckup.org/util/procGetReport.cfm?clientnum=#screening_id#</td></tr></cfoutput>
</cfloop>
</table>
<cfabort>