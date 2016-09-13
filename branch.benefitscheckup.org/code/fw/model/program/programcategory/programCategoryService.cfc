<cfcomponent output="false" displayname="programCategoryService" hint="I am a program Category service.">


	<!--- Setters for dependency injections via ColdSpring CAN USE DPENDS TOO --->
	<cffunction name="setProgramCategoryDAO" access="public" returntype="void" output="false">
		<cfargument name="programCategoryDAO" type="any" required="yes">
		<!--- dc-fw2.model.user.userDAOTransfer --->
		<cfset variables.programCategoryDAO = arguments.programCategoryDAO>
	</cffunction>
	<cffunction name="setProgramCategoryGateway" access="public" returntype="void" output="false">
		<cfargument name="programCategoryGateway" type="fw.model.program.programCategory.programCategoryGateway" required="yes">
		<cfset variables.programCategoryGateway = arguments.programCategoryGateway>
	</cffunction>	
	<!--- <cffunction name="setAddressService" access="public" returntype="void" output="false">
		<cfargument name="addressService" type="fw.model.address.addressService" required="yes">
		<cfset variables.addressService = arguments.addressService>
	</cffunction>
	<cffunction name="setRoleService" access="public" returntype="void" output="false">
		<cfargument name="roleService" type="fw.model.user.role.roleService" required="yes">
		<cfset variables.roleService = arguments.roleService>
	</cffunction> --->

	<cffunction name="getProgramCategory" access="public" returntype="fw.model.program.programCategory.programCategory" output="false">
		<cfargument name="programCategory_id" type="numeric" required="no" default="0">
		<cfset var programCategory = "">
		<!--- <cfset user = variables.userDAO.read(arguments.user_id)> --->
		<cfif arguments.programCategory_id neq 0>
			<cfset programCategory = variables.programCategoryDAO.read(arguments.programCategory_id)>
		<cfelse>
			<cfset programCategory = createObject("component", "dc-fw2.model.program.programCategory.programCategory").init()>
		</cfif>
		<cfreturn programCategory>
	</cffunction>
	<cffunction name="getUserTO" access="public" returntype="struct" output="false">
		<cfargument name="user_id" type="numeric" required="no" default="0">
		<cfset var user = getUser(arguments.user_id)>
		<cfset var userTO = user.getInstanceMemento()>
		<cfreturn userTO>
	</cffunction>
	<cffunction name="saveProgramCategory" access="public" returntype="void" output="false">
		<cfargument name="programCategory" type="fw.model.program.programCategory.programCategory" required="yes">
		<cfset variables.programCategoryDAO.save(arguments.programCategory)>
	</cffunction>
	<cffunction name="getProgramCategories" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="any" default="">
		<cfset var programCategories = "">
		<cfif isStruct(args)>
			<cfset programCategories = variables.programCategoryGateway.getProgramCategories(argumentcollection=arguments.args)>
		<cfelse>
			<cfset programCategories = variables.programCategoryGateway.getProgramCategories()>
		</cfif>
		<cfreturn programCategories />
	</cffunction>
	
	<cffunction name="getLastNameList" access="public" returntype="string" output="false">
		<cfargument name="lastName" required="true" type="string">
		<cfset var lastNameList = "">
		<cfset var users = variables.userGateway.getUsers(lastname=arguments.lastname)>
		<cfset lastNameList = valueList(users.lastname)>
		<cfreturn lastNameList>
	</cffunction>

</cfcomponent>