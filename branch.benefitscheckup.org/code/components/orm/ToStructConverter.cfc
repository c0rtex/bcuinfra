<!---
	Template Name: StructConverter
	Component Purpose: Root component that converts orm components properties to structure.
	                   Each this attribute value defines structure element name, which stores property value. Attributes:
	                   tostruct - converter adds property value to structure
	                   tostructdisplay - converter adds display text with set localization to structure, i.e. set getDisplay_text method
	                                     return value of display component.
	                   tostructarray - converts array property to element of structure. Used in properties mapped by foreign key.
	                   tostructcomponents - adds properties defined in component property directly to current structure.


	Data Tables:
--->
<cfcomponent>

<!---
    Method converts properties to structure based on special properties attributes, defined in cfproperty tag
--->

    <cffunction name="toStructure">
        <cfset retVal = structNew()>
        <cfset metaData = getMetadata(this)>
        <cfif structKeyExists(metaData,"properties")>
            <cfloop array="#metaData.properties#" index="p">
                <cfif structKeyExists(p,"tostruct")>
                    <cfset retVal[p.tostruct]=evaluate("this.get#p.name#()")>
                <cfelseif structKeyExists(p,"tostructdisplay")>
                    <cfset retVal[p.tostructdisplay]=this.toStructDisplay(p.name)>
                <cfelseif structKeyExists(p,"tostructarray")>
                    <cfset retVal[p.tostructarray]=this.toStructArray(p.name)>
                <cfelseif structKeyExists(p,"tostructcomponent")>
                    <cfset s=evaluate("this.get#p.name#()")>
                    <cfif !isNull(s)>
                        <cfset s=s.toStructure()>
                        <cfif p.tostructcomponent neq "">
                            <cfset retVal["#p.tostructcomponent#"]=s>
                        <cfelse>
                            <cfloop collection=#s# item="i">
                                <cfset retVal["#i#"]=s[i]>
                            </cfloop>
                        </cfif>
                    </cfif>
                </cfif>
            </cfloop>
        </cfif>
        <cfreturn retVal>
    </cffunction>

<!---
    Method returns value for property where attribute tostructdisplay defined. Uses internally by toStructure method only.
--->

    <cffunction name="toStructDisplay">
        <cfargument name="attribute">
        <cfif not isNull(evaluate("this.get#attribute#()"))>
            <cfreturn evaluate("this.get#attribute#().getDisplay_text()")>
        <cfelse>
            <cfreturn "">
        </cfif>
    </cffunction>

<!---
    Method returns value for property where attribute tostructarray defined. Uses internally by toStructure method only.
--->

    <cffunction name="toStructArray">
        <cfargument name="attribute">
        <cfset rv=arrayNew(1)>

        <cfset arr=evaluate("this.get#attribute#()")>

        <cfloop array="#arr#" index="o">
            <cfset arrayAppend(rv,o.toStructure())>
        </cfloop>

        <cfreturn rv>
    </cffunction>

    <cffunction name="toDatabaseRepresentation">
        <cfset retVal = structNew()>
        <cfset metaData = getMetadata(this)>
        <cfif structKeyExists(metaData,"properties")>
            <cfloop array="#metaData.properties#" index="p">
                <cfif structKeyExists(p,"fieldtype")>
                    <cfif p.fieldtype eq "id">
                        <cfif structKeyExists(p,"column")>
                            <cfset retVal[p.column]=evaluate("this.get#p.name#()")>
                        <cfelse>
                            <cfset retVal[p.name]=evaluate("this.get#p.name#()")>
                        </cfif>
                    <cfelseif p.fieldtype eq "many-to-one">
                        <cfset retVal[p.fkcolumn] = this.getPKValue(evaluate("this.get#p.name#()"))>
                    </cfif>
                <cfelse>
                    <cfif structKeyExists(p,"column")>
                        <cfset retVal[p.column]=evaluate("this.get#p.name#()")>
                    <cfelse>
                        <cfset retVal[p.name]=evaluate("this.get#p.name#()")>
                    </cfif>
                </cfif>
            </cfloop>
        </cfif>
        <cfreturn retVal>
    </cffunction>

    <cffunction name="getPKValue">
        <cfargument name="aObject">
        <cfif isNull(aObject)>
            <cfreturn "">
        </cfif>
        <cfset mD = getMetadata(aObject)>
        <cfset aRV = "">
        <cfloop array="#mD.properties#" index="mDp">
            <cfif structKeyExists(mDp,"fieldtype")>
                <cfif mDp.fieldtype eq "id">
                    <cfset aRV=evaluate("aObject.get#mDp.name#()")>
                </cfif>
            </cfif>
        </cfloop>
        <cfreturn aRV>
    </cffunction>

    <cffunction name="returnMetadata">
        <cfset retVal = structNew()>
        <cfset metaData = getMetadata(this)>
        <cfif structKeyExists(metaData,"properties")>
            <cfloop array="#metaData.properties#" index="p">
                <cfif structKeyExists(p,"fieldtype")>
                    <cfif p.fieldtype eq "id">
                        <cfif structKeyExists(p,"column")>
                            <cfset retVal[p.column]["name"]=p.name>
                            <cfset retVal[p.column]["fieldtype"]="id">
                        <cfelse>
                            <cfset retVal[p.name]["name"]=p.name>
                            <cfset retVal[p.name]["fieldtype"]="id">
                        </cfif>
                    <cfelseif p.fieldtype eq "many-to-one">
                        <cfset retVal[p.fkcolumn]["fieldtype"]="many-to-one">
                        <cfset retVal[p.fkcolumn]["name"]=p.name>
                        <cfset retVal[p.fkcolumn]["master"]=p.cfc>
                    </cfif>
                <cfelse>
                    <cfif structKeyExists(p,"column")>
                        <cfset retVal[p.column]["fieldtype"]="">
                        <cfset retVal[p.column]["name"]=p.name>
                    <cfelse>
                        <cfset retVal[p.name]["fieldtype"]="">
                        <cfset retVal[p.name]["name"]=p.name>
                    </cfif>
                </cfif>
            </cfloop>
        </cfif>
        <cfreturn retVal>
    </cffunction>
</cfcomponent>
