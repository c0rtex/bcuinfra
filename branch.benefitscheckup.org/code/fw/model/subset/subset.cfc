<cfcomponent output="false" displayname="subset" hint="I am a subset object.">

	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="subset_id" required="no" type="numeric" default="0">
		<cfargument name="subsettype_id" required="no" type="numeric" default="0">
		<cfargument name="code" required="no" type="string" default="">
		<cfargument name="description" required="no" type="string" default="">
        <cfargument name="display_id" required="no" type="numeric" default="0">
		<cfargument name="alt_display_id" required="no" type="numeric" default="0">
        <cfargument name="spq_display_id" required="no" type="numeric" default="0">
        <cfargument name="oe_name" required="no" type="string" default="">
        <cfargument name="intro_display_id" required="no" type="numeric" default="0">
        <cfargument name="resultpage_id" required="no" type="numeric" default="0">
        <cfargument name="shadow_subset_id" required="no" type="numeric" default="0">
        <cfargument name="branding_partner_id" required="no" type="numeric" default="0">
        <cfargument name="active_flag" required="no" type="boolean" default="false">
        <cfargument name="test_flag" required="no" type="boolean" default="false">
        <cfargument name="eform_flag" required="no" type="boolean" default="false">
        <cfargument name="report_flag" required="no" type="boolean" default="false">
        <cfargument name="create_user_id" required="no" type="numeric" default="0">
        <cfargument name="create_date" required="no" type="date" default="#now()#">
        <cfargument name="modify_user_id" required="no" type="numeric" default="0">
        <cfargument name="modify_date" required="no" type="date" default="#now()#">
        <cfargument name="display" required="no" type="fw.model.display.display" default="#createObject("component", "fw.model.display.display").init()#">
        <cfargument name="displayAlt" required="no" type="fw.model.display.display" default="#createObject("component", "fw.model.display.display").init()#">
        <cfargument name="displaySpq" required="no" type="fw.model.display.display" default="#createObject("component", "fw.model.display.display").init()#">
        <cfargument name="displayIntro" required="no" type="fw.model.display.display" default="#createObject("component", "fw.model.display.display").init()#">
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getSubset_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.subset_id>
	</cffunction>
	<cffunction name="setSubset_id" access="public" output="no" returntype="void">
		<cfargument name="subset_id" required="yes" type="numeric">
		<cfset variables.instance.subset_id = arguments.subset_id>
	</cffunction>
	<cffunction name="getSubsettype_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.subsettype_id>
	</cffunction>
	<cffunction name="setSubsettype_id" access="public" output="no" returntype="void">
		<cfargument name="subsettype_id" required="yes" type="numeric">
		<cfset variables.instance.subsettype_id = arguments.subsettype_id>
	</cffunction>
	<cffunction name="getCode" access="public" output="no" returntype="string">
		<cfreturn variables.instance.code>
	</cffunction>
	<cffunction name="setCode" access="public" output="no" returntype="void">
		<cfargument name="code" required="yes" type="string">
		<cfset variables.instance.code = arguments.code>
	</cffunction>
	<cffunction name="getDescription" access="public" output="no" returntype="string">
		<cfreturn variables.instance.description>
	</cffunction>
	<cffunction name="setDescription" access="public" output="no" returntype="void">
		<cfargument name="description" required="yes" type="string">
		<cfset variables.instance.description = arguments.description>
	</cffunction>
    <cffunction name="getDisplay_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.display_id>
	</cffunction>
	<cffunction name="setDisplay_id" access="public" output="no" returntype="void">
		<cfargument name="display_id" required="yes" type="numeric">
		<cfset variables.instance.display_id = arguments.display_id>
	</cffunction>
	<cffunction name="getAlt_display_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.alt_display_id>
	</cffunction>
	<cffunction name="setAlt_display_id" access="public" output="no" returntype="void">
		<cfargument name="alt_display_id" required="yes" type="numeric">
		<cfset variables.instance.alt_display_id = arguments.alt_display_id>
	</cffunction>
    <cffunction name="getSpq_display_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.spq_display_id>
	</cffunction>
	<cffunction name="setSpq_display_id" access="public" output="no" returntype="void">
		<cfargument name="spq_display_id" required="yes" type="numeric">
		<cfset variables.instance.spq_display_id = arguments.spq_display_id>
	</cffunction>
    <cffunction name="getOe_name" access="public" output="no" returntype="string">
		<cfreturn variables.instance.oe_name>
	</cffunction>
	<cffunction name="setOe_name" access="public" output="no" returntype="void">
		<cfargument name="oe_name" required="yes" type="string">
		<cfset variables.instance.oe_name = arguments.oe_name>
	</cffunction>
    <cffunction name="getIntro_display_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.intro_display_id>
	</cffunction>
	<cffunction name="setIntro_display_id" access="public" output="no" returntype="void">
		<cfargument name="intro_display_id" required="yes" type="numeric">
		<cfset variables.instance.intro_display_id = arguments.intro_display_id>
	</cffunction>
    <cffunction name="getResultpage_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.resultpage_id>
	</cffunction>
	<cffunction name="setResultpage_id" access="public" output="no" returntype="void">
		<cfargument name="resultpage_id" required="yes" type="numeric">
		<cfset variables.instance.resultpage_id = arguments.resultpage_id>
	</cffunction>
    <cffunction name="getShadow_subset_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.shadow_subset_id>
	</cffunction>
	<cffunction name="setShadow_subset_id" access="public" output="no" returntype="void">
		<cfargument name="shadow_subset_id" required="yes" type="numeric">
		<cfset variables.instance.shadow_subset_id = arguments.shadow_subset_id>
	</cffunction>
    <cffunction name="getBranding_partner_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.branding_partner_id>
	</cffunction>
	<cffunction name="setBranding_partner_id" access="public" output="no" returntype="void">
		<cfargument name="branding_partner_id" required="yes" type="numeric">
		<cfset variables.instance.branding_partner_id = arguments.branding_partner_id>
	</cffunction>
	<cffunction name="getActive_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.active_flag>
	</cffunction>
	<cffunction name="setActive_flag" access="public" output="no" returntype="void">
		<cfargument name="active_flag" required="yes" type="boolean">
		<cfset variables.instance.active_flag = arguments.active_flag>
	</cffunction>
	<cffunction name="getTest_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.test_flag>
	</cffunction>
	<cffunction name="setTest_flag" access="public" output="no" returntype="void">
		<cfargument name="test_flag" required="yes" type="boolean">
		<cfset variables.instance.test_flag = arguments.test_flag>
	</cffunction>
    <cffunction name="getEform_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.eform_flag>
	</cffunction>
	<cffunction name="setEform_flag" access="public" output="no" returntype="void">
		<cfargument name="eform_flag" required="yes" type="boolean">
		<cfset variables.instance.eform_flag = arguments.eform_flag>
	</cffunction>
    <cffunction name="getReport_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.report_flag>
	</cffunction>
	<cffunction name="setReport_flag" access="public" output="no" returntype="void">
		<cfargument name="report_flag" required="yes" type="boolean">
		<cfset variables.instance.report_flag = arguments.report_flag>
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
    
    <cffunction name="getDisplay" access="public" output="no" returntype="fw.model.display.display">
		<cfreturn variables.instance.display>
	</cffunction>
	<cffunction name="setDisplay" access="public" output="no" returntype="void">
		<cfargument name="display" required="yes" type="fw.model.display.display">
		<cfset variables.instance.display = arguments.display>
	</cffunction>
    
    <cffunction name="getDisplayAlt" access="public" output="no" returntype="fw.model.display.display">
		<cfreturn variables.instance.displayAlt>
	</cffunction>
	<cffunction name="setDisplayAlt" access="public" output="no" returntype="void">
		<cfargument name="displayAlt" required="yes" type="fw.model.display.display">
		<cfset variables.instance.displayAlt = arguments.displayAlt>
	</cffunction>
    
    <cffunction name="getDisplaySpq" access="public" output="no" returntype="fw.model.display.display">
		<cfreturn variables.instance.displaySpq>
	</cffunction>
	<cffunction name="setDisplaySpq" access="public" output="no" returntype="void">
		<cfargument name="displaySpq" required="yes" type="fw.model.display.display">
		<cfset variables.instance.displaySpq = arguments.displaySpq>
	</cffunction>
    
    <cffunction name="getDisplayIntro" access="public" output="no" returntype="fw.model.display.display">
		<cfreturn variables.instance.displayIntro>
	</cffunction>
	<cffunction name="setDisplayIntro" access="public" output="no" returntype="void">
		<cfargument name="displayIntro" required="yes" type="fw.model.display.display">
		<cfset variables.instance.displayIntro = arguments.displayIntro>
	</cffunction>
    
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data.subset_id = getSubset_id()>
		<cfset data.subsettype_id = getSubsettype_id()>
		<cfset data.code = getCode()>
		<cfset data.description = getDescription()>
        <cfset data.display_id = getDisplay_id()>
		<cfset data.alt_display_id = getAlt_display_id()>
        <cfset data.Spq_display_id = getSpq_display_id()>
        <cfset data.oe_name = getOe_name()>
        <cfset data.intro_display_id = getIntro_display_id()>
        <cfset data.resultpage_id = getResultpage_id()>
        <cfset data.shadow_subset_id = getShadow_subset_id()>
        <cfset data.branding_partner_id = getBranding_partner_id()>
		<cfset data.active_flag = getActive_flag()>
        <cfset data.test_flag = getTest_flag()>
        <cfset data.eform_flag = getEform_flag()>
        <cfset data.report_flag = getReport_flag()>
        <cfset data.create_user_id = getCreate_user_id()>
        <cfset data.create_date = getCreate_date()>
        <cfset data.modify_user_id = getModify_user_id()>
        <cfset data.modify_date = getModify_date()>
        <cfset data.display = getDisplay()>
        <cfset data.displayAlt = getDisplayAlt()>
        <cfset data.displaySpq = getDisplaySpq()>
        <cfset data.displayIntro = getDisplayIntro()>
		<cfreturn data>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setSubset_id(arguments.data.subset_id)>
		<cfset setSubsettype_id(arguments.data.subsettype_id)>
		<cfset setCode(arguments.data.code)>
		<cfset setDescription(arguments.data.description)>
        <cfset setDisplay_id(arguments.data.display_id)>
		<cfset setAlt_display_id(arguments.data.alt_display_id)>
        <cfset setSpq_display_id(arguments.data.spq_display_id)>
        <cfset setOe_name(arguments.data.oe_name)>
        <cfset setIntro_display_id(arguments.data.intro_display_id)>
        <cfset setResultpage_id(arguments.data.resultpage_id)>
        <cfset setShadow_subset_id(arguments.data.shadow_subset_id)>
        <cfset setBranding_partner_id(arguments.data.branding_partner_id)>
        <cfset setActive_flag(arguments.data.active_flag)>
        <cfset setTest_flag(arguments.data.test_flag)>
        <cfset setEform_flag(arguments.data.eform_flag)>
        <cfset setReport_flag(arguments.data.report_flag)>
        <cfset setCreate_user_id(arguments.data.create_user_id)>
        <cfset setCreate_date(arguments.data.create_date)>
        <cfset setModify_user_id(arguments.data.modify_user_id)>
        <cfset setModify_date(arguments.data.modify_date)>
        <cfset setDisplay(arguments.data.display)>
        <cfset setDisplayAlt(arguments.data.displayAlt)>
        <cfset setDisplaySpq(arguments.data.displaySpq)>
        <cfset setDisplayIntro(arguments.data.displayIntro)>
	</cffunction>
</cfcomponent>