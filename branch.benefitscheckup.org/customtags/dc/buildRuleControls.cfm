<cfparam name="attributes.name" type="string">
<cfparam name="attributes.breakBefore" type="boolean" default="true">
<cfparam name="attributes.breakAfter" type="boolean" default="false">

<cfquery name="afRule" datasource="#application.dbSrc#">
	select answerfield
	from answerfield
	order by answerfield
</cfquery>

<cfoutput>

<cfif attributes.breakBefore><br /></cfif>

	<select name="#attributes.name#_af">
		<option value="">-- answerfield --</option>
		<cfloop query="afRule">
			<option value="#answerfield#">#answerfield#</option>
		</cfloop>
	</select>

	<select name="#attributes.name#_op">
		<option value="">-- op --</option>
		<cfloop list="eq,neq,lt,lte,gt,gte" index="op">
			<option value="#op#">#op#</option>
		</cfloop>
	</select>
	
	<input type="text" name="#attributes.name#_val" value="" size="6" />

	<input type="button" name="#attributes.name#_add" value="add comparison to rule" onClick="
		if (this.form.#attributes.name#_af.value == '' || this.form.#attributes.name#_op.value == '' || this.form.#attributes.name#_val.value == '') {
			alert('Please fill in all three fields to add a comparion clause to the rule');
		} else {
			this.form.#attributes.name#.value += 'session.' + this.form.#attributes.name#_af.value + ' ' + this.form.#attributes.name#_op.value + ' ' + '\'' + this.form.#attributes.name#_val.value + '\'';
			this.form.#attributes.name#.focus();
		}
	" />

<cfif attributes.breakAfter><br /></cfif>

</cfoutput>