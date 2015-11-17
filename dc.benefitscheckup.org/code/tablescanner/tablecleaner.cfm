<cfset datasource = application.dbSrc>

<!--- -------------------------

USAGE:  

FIXDB processes all tables in tablecleaner table with status of 0

fixdb.cfm?init=1&db=[database_name] to create the tablecleaner table, suvey all tables in db, and set flag to 0 (process)
fixdb.cfm?init=1&status=1&db=[database_name] to create the tablecleaner table, suvey all tables in db, and set flag to 1 (process)
fixdb.cfm?init=1&status=0/1 to set the status column to 0 or 1

Run fixdb.cfm with no params at any time to continue processing all tables with status = 0

------------------------- --->

<cfparam name="init" default="0">
<cfparam name="loop" default="0">
<cfparam name="status" default="0">
<cfparam name="db" default="0">

<cfif init IS 1>
	<cftry>
        <cfquery datasource="#datasource#" name="maketable">
            CREATE TABLE tablecleaner(
                tablecleaner_id int AUTOINCREMENT NOT NULL PRIMARY KEY,
                tablecleaner_table_name text NULL,
                tablecleaner_status int NULL,
                tablecleaner_viruses text NULL,
            ) 
        </cfquery>
        <cfcatch>
        </cfcatch>
    </cftry>

	<cfquery datasource="#datasource#" name="tables">
    TRUNCATE TABLE tablecleaner
    </cfquery>

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
                        UPDATE tablecleaner SET  tablecleaner_status = #val(status)# WHERE tablecleaner_id = #findtable.tablecleaner_id#
                    </cfquery>
                </cfif>
            </cfif>
        </cfif>
    </cfloop>
    tablecleaner created and reset!
    <cfabort>
</cfif>

<cfquery datasource="#datasource#" name="tablecleaners">
    SELECT * FROM tablecleaner WHERE tablecleaner_status = 0 ORDER BY tablecleaner_id limit 0, 1
</cfquery>

<cfif tablecleaners.recordcount IS 0>
All tables cleaned!
<cfabort>
</cfif>

<cfset table_name = tablecleaners.tablecleaner_table_name>

<cfquery datasource="#datasource#" name="cols">
    sp_columns '#tablecleaners.tablecleaner_table_name#'
</cfquery>

<cfset col_list = "">
<cfset sql_list = "">

<cfloop query="cols">
    <cfif (SQL_DATA_TYPE IS 12)>
        <cfset col_list = listAppend(col_list, column_name)>
    </cfif>

	<cfif type_name IS 'int identity'>
		<cfset key = column_name>
    </cfif>
</cfloop>
<cftry>
<cfoutput><strong>Fixing table: #table_name# (Key: #key#)</strong><br /></cfoutput>
    <cfcatch>
        <cfquery datasource="#datasource#" name="findTableU">
    	    UPDATE tablecleaner SET  tablecleaner_status = -1 WHERE tablecleaner_id = #tablecleaners.tablecleaner_id#
	    </cfquery>
        <meta http-equiv="refresh" content="0;url=tablecleaner.cfm">
	    <cfabort>
    </cfcatch>
</cftry>

<cfif loop IS 0>
    <cftry>
        <cfquery datasource="#datasource#" name="add_virus_column">
            ALTER TABLE dbo.#table_name# ADD
            #table_name#_virus int NULL
        </cfquery>
        <cfcatch>
        </cfcatch>
    </cftry>
    
    <cfquery datasource="#datasource#" name="working_table">
        UPDATE #table_name# SET #table_name#_virus = 0
    </cfquery>
</cfif>

<cfquery datasource="#datasource#" name="working_table">
    SELECT * FROM #table_name# 
    WHERE #table_name#_virus = 0
    ORDER BY #key# DESC LIMIT 0, 10
</cfquery>

<cfloop query="working_table">
    <cfoutput><strong>Fixing ID #evaluate(key)#</strong></cfoutput><br>
    <cfflush>
    <cfloop list="#col_list#" index="c">
        <cfset cleaned = evaluate(c)>
        
        <cfset viruslist = reMatch('("></title><script src=").+("></script><!--)', cleaned)>
        
        <cfloop array="#viruslist#" index="virus">
	        <cfset cleaned = replacenocase(cleaned, virus, '', 'all')>
        </cfloop>
        
        <cfset sqlUpdate = "#c# = ">
        <cfset sql_list = listAppend(sql_list, sqlUpdate)>

        <cfquery datasource="#datasource#" name="working_tableu">
            UPDATE #table_name# SET 
            #c# = '#cleaned#'
            WHERE #key# = #evaluate(key)#
        </cfquery>			
    </cfloop>
    
    <cfquery datasource="#datasource#" name="working_tableu2">
        UPDATE #table_name# SET 
        #table_name#_virus = 1
        WHERE #key# = #evaluate(key)#
    </cfquery>			
<hr>
</cfloop>

<cfset loop = loop + 1>

<cfif working_table.recordcount IS 0>
    <cfquery datasource="#datasource#" name="findTableU">
        UPDATE tablecleaner SET  tablecleaner_status = 1 WHERE tablecleaner_id = #tablecleaners.tablecleaner_id#
    </cfquery>
    
    <cfset loop = 0>
</cfif>

<cfif tablecleaners.recordcount IS NOT 0>
	<cfoutput>
    <meta http-equiv="refresh" content="0;url=tablecleaner.cfm?loop=#loop#">
    </cfoutput>
</cfif>