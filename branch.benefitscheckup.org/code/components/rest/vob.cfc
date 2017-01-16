<cfcomponent rest="true" restpath="/vob">

    <cffunction name="vobCountPeople" access="remote" restpath="/countpeople" returnType="String" httpMethod="GET">
			<cftry>
			<!--- Call data mine query to count screenings --->
			<cfquery name="whscr" datasource="bcu_warehouse">
					select count(s.id) as c from screening s join oe_org o on s.oe_org_id=o.id
					where s.subset_id not in (41,53)
	
			</cfquery>
		
				<cfset retVal = whscr.c * 5>
			

			<cfcatch>
        		<cfset retVal = 5538630>
			</cfcatch>
					
			</cftry>
			<cfreturn serializeJSON(retVal)>


    </cffunction>

 
    <cffunction name="countVob" access="remote" restpath="/countvob" returnType="String" httpMethod="GET">
			<cftry>
			<!--- Call data mine query to sum dollar value --->
			<cfquery name="whdlr" datasource="bcu_warehouse">
		      select sum(dollarvalue) as s
                    from screening s join oe_org o on s.oe_org_id = o.id 
                    where (s.subset_id != 41 or              
                    ((s.source_id = 7 or s.partner_id in (47,51)) 
                    and s.submission_status in (1,222,999))) 
                    and s.subset_id != 53;
			</cfquery>
			<cfset retVal = whdlr.s + 300000000>
			<cfcatch>
				<cfset retVal = 18039991961>
			</cfcatch>
			</cftry>
        	<cfreturn serializeJSON(retVal)>
    </cffunction>
</cfcomponent>

