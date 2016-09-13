<cfcomponent output="false" displayname="program" hint="I am a program object.">

	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="program_id" required="no" type="numeric" default="0">
        <cfargument name="programcategory_id" required="no" type="numeric" default="0">
        <cfargument name="state_id" required="no" type="string" default="">
		<cfargument name="program_code" required="no" type="string" default="">
        <cfargument name="name_display_id" required="no" type="numeric" default="0">
        <cfargument name="desc_display_id" required="no" type="numeric" default="0">
        <cfargument name="url" required="no" type="string" default="">
        <cfargument name="exclude_flag" required="no" type="boolean" default="false">
        <cfargument name="significant_flag" required="no" type="boolean" default="false">
        <cfargument name="active_flag" required="no" type="boolean" default="false">
        <cfargument name="funder_id" required="no" type="numeric" default="0">
        <cfargument name="reference_id" required="no" type="numeric" default="0">
        <cfargument name="last_update" required="no" type="date" default="#now()#">
        <cfargument name="notes" required="no" type="string" default="">
        <cfargument name="supersort" required="no" type="numeric" default="0">
        <cfargument name="sort" required="no" type="numeric" default="0">
        <cfargument name="legacy_prg_id" required="no" type="string" default="">
        <cfargument name="legacy_pri_sec" required="no" type="numeric" default="0">
        <cfargument  name="create_user_id" required="no" type="numeric" default="0">
        <cfargument name="create_date" required="no" type="date" default="#now()#">
        <cfargument name="modify_user_id" required="no" type="numeric" default="0">
        <cfargument name="modify_date" required="no" type="date" default="#now()#">
        <cfargument name="programCategory" required="no" 
        	type="fw.model.program.programCategory.programCategory" 
            default="#createObject("component", "fw.model.program.programCategory.programCategory").init()#">
        <cfargument name="displayName" required="no" type="fw.model.display.display" default="#createObject("component", "fw.model.display.display").init()#">
        <cfargument name="displayDesc" required="no" type="fw.model.display.display" default="#createObject("component", "fw.model.display.display").init()#">
		<!--- <cfargument name="address" required="no" type="fw.model.address.address" default="#createObject("component", "fw.model.address.address").init()#"> --->
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getProgram_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.program_id>
	</cffunction>
	<cffunction name="setProgram_id" access="public" output="no" returntype="void">
		<cfargument name="program_id" required="yes" type="numeric">
		<cfset variables.instance.program_id = arguments.program_id>
	</cffunction>
	<cffunction name="getProgramcategory_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.programcategory_id>
	</cffunction>
	<cffunction name="setProgramcategory_id" access="public" output="no" returntype="void">
		<cfargument name="programcategory_id" required="yes" type="numeric">
		<cfset variables.instance.programcategory_id = arguments.programcategory_id>
	</cffunction>
	<cffunction name="getState_id" access="public" output="no" returntype="string">
		<cfreturn variables.instance.state_id>
	</cffunction>
	<cffunction name="setState_id" access="public" output="no" returntype="void">
		<cfargument name="state_id" required="yes" type="string">
		<cfset variables.instance.state_id = arguments.state_id>
	</cffunction>
	<cffunction name="getProgram_code" access="public" output="no" returntype="string">
		<cfreturn variables.instance.program_code>
	</cffunction>
	<cffunction name="setProgram_code" access="public" output="no" returntype="void">
		<cfargument name="program_code" required="yes" type="string">
		<cfset variables.instance.program_code = arguments.program_code>
	</cffunction>
	<cffunction name="getName_display_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.name_display_id>
	</cffunction>
	<cffunction name="setName_display_id" access="public" output="no" returntype="void">
		<cfargument name="name_display_id" required="yes" type="numeric">
		<cfset variables.instance.name_display_id = arguments.name_display_id>
	</cffunction>
	<cffunction name="getDesc_display_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.desc_display_id>
	</cffunction>
	<cffunction name="setDesc_display_id" access="public" output="no" returntype="void">
		<cfargument name="desc_display_id" required="yes" type="numeric">
		<cfset variables.instance.desc_display_id = arguments.desc_display_id>
	</cffunction>
    <cffunction name="getUrl" access="public" output="no" returntype="string">
		<cfreturn variables.instance.url>
	</cffunction>
	<cffunction name="setUrl" access="public" output="no" returntype="void">
		<cfargument name="url" required="yes" type="string">
		<cfset variables.instance.url = arguments.url>
	</cffunction>
    <cffunction name="getExclude_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.exclude_flag>
	</cffunction>
	<cffunction name="setExclude_flag" access="public" output="no" returntype="void">
		<cfargument name="exclude_flag" required="yes" type="boolean">
		<cfset variables.instance.exclude_flag = arguments.exclude_flag>
	</cffunction>
    <cffunction name="getSignificant_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.significant_flag>
	</cffunction>
	<cffunction name="setSignificant_flag" access="public" output="no" returntype="void">
		<cfargument name="significant_flag" required="yes" type="boolean">
		<cfset variables.instance.significant_flag = arguments.significant_flag>
	</cffunction>
    <cffunction name="getActive_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.active_flag>
	</cffunction>
	<cffunction name="setActive_flag" access="public" output="no" returntype="void">
		<cfargument name="active_flag" required="yes" type="boolean">
		<cfset variables.instance.active_flag = arguments.active_flag>
	</cffunction>
    <cffunction name="getFunder_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.funder_id>
	</cffunction>
	<cffunction name="setFunder_id" access="public" output="no" returntype="void">
		<cfargument name="funder_id" required="yes" type="numeric">
		<cfset variables.instance.funder_id = arguments.funder_id>
	</cffunction>
    <cffunction name="getReference_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.reference_id>
	</cffunction>
	<cffunction name="setReference_id" access="public" output="no" returntype="void">
		<cfargument name="reference_id" required="yes" type="numeric">
		<cfset variables.instance.reference_id = arguments.reference_id>
	</cffunction>
    <cffunction name="getLast_update" access="public" output="no" returntype="date">
		<cfreturn variables.instance.last_update>
	</cffunction>
	<cffunction name="setLast_update" access="public" output="no" returntype="void">
		<cfargument name="last_update" required="yes" type="date">
		<cfset variables.instance.last_update = arguments.last_update>
	</cffunction>
    <cffunction name="getNotes" access="public" output="no" returntype="string">
		<cfreturn variables.instance.notes>
	</cffunction>
	<cffunction name="setNotes" access="public" output="no" returntype="void">
		<cfargument name="notes" required="yes" type="string">
		<cfset variables.instance.notes = arguments.notes>
	</cffunction>
    <cffunction name="getSupersort" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.supersort>
	</cffunction>
	<cffunction name="setSupersort" access="public" output="no" returntype="void">
		<cfargument name="supersort" required="yes" type="numeric">
		<cfset variables.instance.supersort = arguments.supersort>
	</cffunction>
     <cffunction name="getSort" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.sort>
	</cffunction>
	<cffunction name="setSort" access="public" output="no" returntype="void">
		<cfargument name="sort" required="yes" type="numeric">
		<cfset variables.instance.sort = arguments.sort>
	</cffunction>
    <cffunction name="getLegacy_prg_id" access="public" output="no" returntype="string">
		<cfreturn variables.instance.legacy_prg_id>
	</cffunction>
	<cffunction name="setLegacy_prg_id" access="public" output="no" returntype="void">
		<cfargument name="legacy_prg_id" required="yes" type="string">
		<cfset variables.instance.legacy_prg_id = arguments.legacy_prg_id>
	</cffunction>
    <cffunction name="getLegacy_pri_sec" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.legacy_pri_sec>
	</cffunction>
	<cffunction name="setLegacy_pri_sec" access="public" output="no" returntype="void">
		<cfargument name="legacy_pri_sec" required="yes" type="numeric">
		<cfset variables.instance.legacy_pri_sec = arguments.legacy_pri_sec>
	</cffunction>
    <cffunction name="getCreate_user_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.create_user_id>
	</cffunction>
	<cffunction name="setCreate_user_id" access="public" output="no" returntype="void">
		<cfargument name="create_user_id" required="yes" type="numeric">
		<cfset variables.instance.create_user_id = arguments.create_user_id>
	</cffunction>
    <cffunction name="getCreate_date" access="public" output="no" returntype="date">
		<cfreturn variables.instance.create_date>
	</cffunction>
	<cffunction name="setCreate_date" access="public" output="no" returntype="void">
		<cfargument name="create_date" required="yes" type="date">
		<cfset variables.instance.create_date = arguments.create_date>
	</cffunction>
    <cffunction name="getModify_user_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.modify_user_id>
	</cffunction>
	<cffunction name="setModify_user_id" access="public" output="no" returntype="void">
		<cfargument name="modify_user_id" required="yes" type="numeric">
		<cfset variables.instance.modify_user_id = arguments.modify_user_id>
	</cffunction>
    <cffunction name="getModify_date" access="public" output="no" returntype="date">
		<cfreturn variables.instance.modify_date>
	</cffunction>
	<cffunction name="setModify_date" access="public" output="no" returntype="void">
		<cfargument name="modify_date" required="yes" type="date">
		<cfset variables.instance.modify_date = arguments.modify_date>
	</cffunction>
    
    <cffunction name="getProgramCategory" access="public" output="no" returntype="fw.model.program.programCategory.programCategory">
		<cfreturn variables.instance.programCategory>
	</cffunction>
	<cffunction name="setProgramCategory" access="public" output="no" returntype="void">
		<cfargument name="programCategory" required="yes" type="fw.model.program.programCategory.programCategory">
		<cfset variables.instance.programCategory = arguments.programCategory>
	</cffunction>
    
    <cffunction name="getDisplayName" access="public" output="no" returntype="fw.model.display.display">
		<cfreturn variables.instance.displayName>
	</cffunction>
	<cffunction name="setDisplayName" access="public" output="no" returntype="void">
		<cfargument name="displayName" required="yes" type="fw.model.display.display">
		<cfset variables.instance.displayName = arguments.displayName>
	</cffunction>
    
    <cffunction name="getDisplayDesc" access="public" output="no" returntype="fw.model.display.display">
		<cfreturn variables.instance.displayDesc>
	</cffunction>
	<cffunction name="setDisplayDesc" access="public" output="no" returntype="void">
		<cfargument name="displayDesc" required="yes" type="fw.model.display.display">
		<cfset variables.instance.displayDesc = arguments.displayDesc>
	</cffunction>
    
    <!---
	<cffunction name="addRole" access="public" output="no" returntype="void">
		<cfargument name="role" type="fw.model.user.role.role" required="true">
		<cfset arrayAppend(variables.instance.roles, arguments.role)>
	</cffunction>
	<cffunction name="hasRole" access="public" output="no" returntype="boolean">
		<cfargument name="roleName" required="yes" type="string">
		<cfset var i = 0>
		<cfloop from="1" to="#arrayLen(variables.instance.roles)#" index="i">
			<cfif variables.instance.roles[i].getName() eq arguments.roleName>
				<cfreturn true>
			</cfif>
		</cfloop>
		<cfreturn false>
	</cffunction> 
    <cffunction name="clearRole" access="public" output="no" returntype="void">
        	<cfset arrayClear(getRoles())>
    </cffunction>
    --->
    
    
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data.program_id = getProgram_id()>
		<cfset data.programcategory_id = getProgramcategory_id()>
		<cfset data.state_id = getState_id()>
		<cfset data.program_code = getProgram_code()>
		<cfset data.name_display_id = getName_display_id()>
        <cfset data.desc_display_id = getDesc_display_id()>
        <cfset data.url = getUrl()>
        <cfset data.exclude_flag = getExclude_flag()>
        <cfset data.significant_flag = getSignificant_flag()>
        <cfset data.active_flag = getActive_flag()>
        <cfset data.funder_id = getFunder_id()>
        <cfset data.reference_id = getReference_id()>
        <cfset data.last_update = getLast_update()>
        <cfset data.notes = getNotes()>
        <cfset data.supersort = getSupersort()>
        <cfset data.sort = getSort()>
        <cfset data.legacy_prg_id = getLegacy_prg_id()>
        <cfset data.legacy_pri_sec = getLegacy_pri_sec()>
        <cfset data.create_user_id = getCreate_user_id()>
        <cfset data.create_date_id = getCreate_date()>
        <cfset data.modify_user_id = getModify_user_id()>
        <cfset data.modify_date = getModify_date()>
        <cfset data.programCategory = getProgramCategory()>
        <cfset data.displayName = getDisplayName()>
        <cfset data.displayDesc = getDisplayDesc()>
		<cfreturn data>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setProgram_id(arguments.data.program_id)>
		<cfset setProgramcategory_id(arguments.data.programcategory_id)>
		<cfset setState_id(arguments.data.state_id)>
		<cfset setProgram_code(arguments.data.program_code)>
		<cfset setName_display_id(arguments.data.name_display_id)>
		<cfset setDesc_display_id(arguments.data.desc_display_id)>
        <cfset setUrl(arguments.data.url)>
        <cfset setExclude_flag(arguments.data.exclude_flag)>
        <cfset setSignificant_flag(arguments.data.significant_flag)>
        <cfset setActive_flag(arguments.data.active_flag)>
        <cfset setFunder_id(arguments.data.funder_id)>
        <cfset setReference_id(arguments.data.reference_id)>
        <cfset setLast_update(arguments.data.last_update)>
        <cfset setNotes(arguments.data.notes)>
        <cfset setSupersort(arguments.data.supersort)>
        <cfset setSort(arguments.data.sort)>
        <cfset setLegacy_prg_id(arguments.data.legacy_prg_id)>
        <cfset setLegacy_pri_sec(arguments.data.legacy_pri_sec)>
        <cfset setCreate_user_id(arguments.data.create_user_id)>
        <cfset setCreate_date(arguments.data.create_date)>
        <cfset setModify_user_id(arguments.data.modify_user_id)>
        <cfset setModify_date(arguments.data.modify_date)>
        <cfset setProgramCategory(arguments.data.programCategory)>
        <cfset setDisplayName(arguments.data.displayName)>
        <cfset setDisplayDesc(arguments.data.displayDesc)>
	</cffunction>

</cfcomponent>