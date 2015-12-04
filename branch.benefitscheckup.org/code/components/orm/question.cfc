<cfcomponent persistent="true" entityname="question" table="question">
    <cfproperty name="id" fieldtype="id" column="question_id">
    <cfproperty name="dep_question" fieldtype="many-to-one" fkcolumn="dep_question_id" cfc="Question">
    <cfproperty name="code" column="question_code">
    <cfproperty name="question_category" fieldtype="many-to-one"   fkcolumn="questioncategory_id" cfc="question_category">
    <cfproperty name="question_header" fieldtype="many-to-one" fkcolumn="questionheader_id" cfc="question_header">
    <cfproperty name="question_type" fieldtype="many-to-one" fkcolumn="questiontype_id" cfc="question_type">
	<cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
	<cfproperty name="short_display" fieldtype="many-to-one" fkcolumn="short_display_id" cfc="display">
	<cfproperty name="spq_display" fieldtype="many-to-one" fkcolumn="spq_display_id" cfc="display">
	<cfproperty name="print_display" fieldtype="many-to-one" fkcolumn="print_display_id" cfc="display">
	<cfproperty name="format" fieldtype="many-to-one" fkcolumn="format_id" cfc="format">
	<cfproperty name="rule" fieldtype="many-to-one" fkcolumn="rule_id" cfc="rule">
	<cfproperty name="include_flag">
	<cfproperty name="exclude_flag">
	<cfproperty name="suppress_qno_flag">
	<cfproperty name="spq_exclude_flag">
	<cfproperty name="sort">
	<cfproperty name="answer_fields" fieldtype="one-to-many" cfc="question_answer_field" fkcolumn="question_id" lazy="extra" cascade="all" orderby="sort">
	<cfproperty name="helps" fieldtype="one-to-many" cfc="question_help" fkcolumn="question_id" lazy="extra" cascade="all" orderby="sort">

	<cffunction name="returnStruct">
		<cfargument name="state_id" type="string" required="no" default="">
		<cfset retVal = StructNew()>
		<cfset retVal["id"] = this.getId()>
		<cfset retVal["code"]=this.getCode()>
		<cfset retVal["display"]=this.getDisplay().getDisplay_text()>
		<cfset retVal["category"]=this.getQuestion_category().getCode()>
		<cfset retVal["header"] = this.getQuestion_header()>
		<cfset retVal["type"] = this.getQuestion_type().getCode()>

		<cfif isNull(this.getShort_display())>
			<cfset retVal["short_display"] = "">
		<cfelse>
			<cfset retVal["short_display"] = this.getShort_display().getDisplay_text()>
		</cfif>

		<cfif isNull(this.getSpq_display())>
			<cfset retVal["spq_display"] = "">
		<cfelse>
			<cfset retVal["spq_display"] = this.getSpq_display().getDisplay_text()>
		</cfif>

		<cfif isNull(this.getPrint_display())>
			<cfset retVal["print_display"] = "">
		<cfelse>
			<cfset retVal["print_display"] = this.getPrint_display().getDisplay_text()>
		</cfif>


		<cfset retVal["rule"]= this.getRule()>

		<cfset retVal["helps"]=arrayNew(1)>
		<cfloop array="#this.getHelps()#" index="h">
			<cfset hi = structNew()>
			<cfset hi["code"]= h.getHelp().getCode()>

			<cfif isNull(h.getState())>
				<cfset hi["state"] = "">
			<cfelse>
				<cfset hi["state"] = h.getState().getName()>
			</cfif>
			<cfset hi["sort"] =h.getSort()>
			<cfset hi["title"] = h.getHelp().getTitle_display().getDisplay_text()>
			<cfset hi["text"] = h.getHelp().getDisplay().getDisplay_text()>
			<cfset arrayAppend(retVal["helps"],hi)>
		</cfloop>

		<cfset retVal["sort"] = this.getSort()>

		<cfset retVal["answer_fields"]= arrayNew(1)>

		<cfloop array="#this.getAnswer_fields()#" index="af">
			<cfif ((isNull(af.getAnswer().getState())<!---&&objectEquals(state_id,""))||objectEquals(af.getState().getId(),state_id)--->))>
				<cfset afItem = structNew()>
				<cfset afItem["id"] = af.getAnswer().getId()>
				<cfset afItem["code"] = af.getAnswer().getCode()>
				<cfset afItem["type"] = af.getAnswer().getAnswer_field_type().getCode()>

				<cfif not isNull(af.getAnswer().getDisplay())>
					<cfset afItem["display"] = af.getAnswer().getDisplay().getDisplay_text()>
				</cfif>
				<cfset afItem["sort"] = af.getSort()>

				<cfset afItem["options"]=arrayNew(1)>
				<cfloop array="#af.getAnswer().getOptions()#" index="o">
					<cfset oi = structNew()>
					<cfset oi["id"] = o.getOption().getId()>
					<cfset oi["code"] = o.getOption().getCode()>
					<cfset oi["display"] = o.getOption().getDisplay().getDisplay_text()>
					<cfset oi["sort"] = o.getSort()>
					<cfset arrayAppend(afItem["options"],oi)>
				</cfloop>

				<cfset afItem["event_handlers"]=structNew()>
				<cfloop array="#af.getAnswer().getEvent_handlers()#" index="eh">
					<cfset afItem["event_handlers"][eh.getEvent().getCode()] = eh.getHandler()>
				</cfloop>

				<cfset arrayAppend(retVal["answer_fields"],afItem)>
			</cfif>
		</cfloop>
		<cfreturn retVal>
	</cffunction>
</cfcomponent>