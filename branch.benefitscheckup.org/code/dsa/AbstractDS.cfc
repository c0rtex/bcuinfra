<cfcomponent>
   <cffunction name="getData" access="remote" returntype="String">
       <cfargument name="reqParams" type="string" required="no" default="{}">
       <cfset ds = this.getQuery(deserializeJSON(reqParams))>
       <cfset columns=listToArray(ds.columnList,',')>
       <cfset rows = arrayNew(1)>
       <cfloop query="ds">
           <cfset row = structNew()>
           <cfloop array="#columns#" index="i">
               <cfset row[i]=ds[i][CurrentRow]>
           </cfloop>
           <cfset arrayAppend(rows,row)>
       </cfloop>

       <cfset retVal = structNew()>
       <cfset retVal["columns"]=columns>
       <cfset retVal["rows"]=rows>

       <cfif structKeyExists(arguments, "callback")>
           <cfset retVal = arguments.callback & "(" & serializeJSON(retVal) & ");">
       <cfelseif structKeyExists(arguments, "jsonp")>
           <cfset retVal= "jsonp(" & serializeJSON(retVal) & ");">
       <cfelse>
           <cfset retVal= serializeJSON(retVal)>
       </cfif>

       <cfreturn retVal>
   </cffunction>
</cfcomponent>
