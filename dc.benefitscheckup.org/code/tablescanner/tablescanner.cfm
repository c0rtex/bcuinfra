<cfset datasource = application.dbSrc>

<cftry>

<style type="text/css">
body, td {
	font-family:Calibri, Arial, Helvetica, sans-serif;
	font-size:12px;
}

.error {
	color:#FF0000;
	font-weight: bold;
}

</style>

<!--- -------------------------

USAGE:  

TABLESCANNER processes all tables in tablecleaner table with status of 0

------------------------- --->

<cfparam name="init" default="0">
<cfparam name="loop" default="0">
<cfparam name="status" default="0">
<cfparam name="db" default="0">

<cfif init IS 1>

    <cftry>
            <cfquery datasource="#datasource#" name="maketable">

                CREATE TABLE tablecleaner (
                  tablecleaner_id INTEGER(11) NOT NULL AUTO_INCREMENT,
                  tablecleaner_table_name LONGTEXT,
                  tablecleaner_status INTEGER(11) DEFAULT NULL,
                  tablecleaner_virus INTEGER(11) DEFAULT NULL,
                  tablecleaner_virus_cols LONGTEXT,
                  tablecleaner_viruses LONGTEXT,
                PRIMARY KEY (tablecleaner_id)
                ) ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
               

            </cfquery>
            <cfcatch>
			<!--- 	<cfdump var="#cfcatch#">
				<cfabort> --->
            </cfcatch>
        </cftry>

    <cfquery datasource="#datasource#" name="tables">
    sp_tables
    </cfquery>
    
    <cfloop query="tables">
    	<cfif table_owner IS 'dbo'>
            <cfquery datasource="#datasource#" name="findTable">
                SELECT * FROM tablecleaner WHERE tablecleaner_table_name LIKE '#table_name#'
            </cfquery>
            
            <cfif findTable.recordcount IS 0>
                <cfquery datasource="#datasource#" name="findTableA">
                    INSERT INTO tablecleaner (tablecleaner_table_name, tablecleaner_status) VALUES ('#table_name#', #val(status)#)
                </cfquery>
            <cfelse>
             	<cfif findTable.tablecleaner_status IS NOT -1>
                    <cfquery datasource="#datasource#" name="findTableU">
                        UPDATE tablecleaner SET tablecleaner_status = #val(status)# WHERE tablecleaner_id = #findtable.tablecleaner_id#
                    </cfquery>
                </cfif>
            </cfif>
        </cfif>
    </cfloop>
	
<h1>Tablescanner table initialized</h1>

<p><a href="tablescanner.cfm">Scan Tables</a></p>

<cfabort>

	
</cfif>

<cfquery datasource="#datasource#" name="tablecleaners">
    SELECT * FROM tablecleaner WHERE tablecleaner_status = 0 AND tablecleaner_table_name NOT LIKE 'TableCleaner' ORDER BY tablecleaner_id LIMIT 0, 1
</cfquery>

<cfif tablecleaners.recordcount IS 0>
<h1>All tables cleaned!</h1>

<p><a href="tablescanner.cfm?init=1">Rescan Tables</a></p>

<p><a href="tablescannerReport.cfm">View Report</a></p>

<cfabort>
</cfif>

<cfset table_name = tablecleaners.tablecleaner_table_name>

<cfquery datasource="#datasource#" name="cols">
    sp_columns '#tablecleaners.tablecleaner_table_name#'
</cfquery>

<cfset col_list = "">
<cfset sql_list = "">

<cfset skiplist = "binary,timestamp,definition,version,name,image">

<cfloop query="cols">
<!--- 	<cfoutput>#type_name#<br /></cfoutput> --->
	<cfif listfindnocase(skiplist, type_name) IS 0>
		<cfset col_list = listAppend(col_list, column_name)>
		
		<cfif type_name IS 'int identity'>
			<cfset key = column_name>
		</cfif>
	</cfif>
</cfloop>

<cfoutput><h1>Scanning table: #table_name#</h1></cfoutput>

<cfquery datasource="#datasource#" name="working_table">
    SELECT * FROM `#table_name#` limit 0, 1
</cfquery>

<cfloop query="working_table">
    <cfflush>
	<cfset cList = "">
	<cfset vList = "">
    <cfloop list="#col_list#" index="c">
        <cfset cleaned = evaluate(c)>
        
        <cfset viruslist = reMatch('("></title><script src=")[^"\r\n]*("></script><!--)', cleaned)>
		<cfset viruslist = listtoArray(viruslist)>
        
        
        <cfif arraylen(viruslist) GT 0>
			<cfoutput>
            <div class="error">Viruses found in #c#</div>
            </cfoutput>
            <cfloop list="#viruslist#" index="virus">
                
                <cfset cleaned = replacenocase(cleaned, virus, '', 'all')>
                <cfset v2 = replacenocase(virus, '"', '', 'all')>
				<cfif listfindnocase(cList, c) IS 0>
	                <cfset cList = listappend(cList, c)>
				</cfif>
				<cfset vList = listappend(vList, virus, "|")>
            </cfloop>
            
            <cfquery datasource="#datasource#" name="findTableU">
                UPDATE tablecleaner SET tablecleaner_virus = #listLen(vList, "|")#, tablecleaner_virus_cols = '#cList#' , tablecleaner_viruses = '#vList#' WHERE tablecleaner_id = #tablecleaners.tablecleaner_id#
            </cfquery>
            <cfelse>
				<cfoutput>No viruses found in #c#<br /></cfoutput>
           </cfif>
	</cfloop>
<hr>
</cfloop>

<cfquery datasource="#datasource#" name="findTableU">
    UPDATE tablecleaner SET tablecleaner_status = 1 WHERE tablecleaner_id = #tablecleaners.tablecleaner_id#
</cfquery>

<cfset loop = loop + 1>

<cfif tablecleaners.recordcount IS NOT 0>
	<cfoutput>
    <meta http-equiv="refresh" content="0;url=tablescanner.cfm">
    </cfoutput>
<cfelse>
<cfquery datasource="#datasource#" name="viruses">
    SELECT * FROM tablecleanser WHERE tablecleaner_virus IS NOT NULL OR tablecleaner_virus <> ''
</cfquery>

<cfdump var="#viruses#">

</cfif>

<cfcatch>

	<cfdump var="#cfcatch#">
</cfcatch>
</cftry>