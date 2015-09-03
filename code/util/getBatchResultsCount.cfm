
<cfquery name="results9"  datasource="BCU">
update tbl_major_cat_list
set major_cat = 'Pharmaceutical - Government Program'
where
RecID = 11
</cfquery>
<cfquery name="results9"  datasource="BCU">
select * from tbl_major_cat_list</cfquery>
<cfdump var="#results9#"><br />
<cfoutput>--------------------------------------------------------------------------------------------------<BR /><BR /></cfoutput>
select * from tbl_major_cat_list
<cfabort>

<cfquery name="whdlr" datasource="#application.dbSrcWarehouse#">
				select sum(dollarvalue) as s
                    from screening s join oe_org o on s.oe_org_id = o.id 
                    where (s.subset_id != 41 or              
                    ((s.source_id = 7 or s.partner_id in (47,51)) 
                    and s.submission_status in (1,222,999))) 
                    and s.subset_id != 53;
			</cfquery>
<cfdump var="#whdlr#">
<cfabort >
