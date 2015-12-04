<cfif isdefined('url.debug')>
	<cfoutput>#prg_list#</cfoutput>
</cfif> 
<cfquery name="qryMedicaid" datasource="#application.dbSrc#">
SELECT   p.program_code, tpa.prg_id
from subset_program sp, tbl_prg_all tpa, program p
WHERE     
sp.program_id = tpa.recID
and
p.program_id = sp.program_id
and tpa.prg_id in (#preservesinglequotes(prg_list)#)
and 
(sp.subset_id = 8)  
and tpa.st = (<cfqueryparam 
                        value="#session.ST#" 
                        cfsqltype="CF_SQL_VARCHAR" 
                        maxlength="2">)
</cfquery>	



