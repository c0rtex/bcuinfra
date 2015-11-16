<cfsilent>
<cfparam name="attributes.rule_id" type="numeric">
<cfparam name="attributes.debug" type="boolean" default="false">
<cfquery name="radelete" datasource="#application.dbSrc#">
	delete
	from rule_answerfield
	where rule_id=#attributes.rule_id#
</cfquery>
<cfquery name="rainsert" datasource="#application.dbSrc#">
	insert into rule_answerfield
	select r.rule_id, a.answerfield_id
	from `rule` r, answerfield a
	where r.rule_id=#attributes.rule_id#
		and (r.rule_text rlike concat('.*[^a-z0-9_]session\.' , a.answerfield , '[^a-z0-9_].*')
			or r.rule_text rlike concat('session.' , a.answerfield , '[^a-z0-9_].*')
			or r.rule_text rlike concat('.*[^a-z0-9_]session\.' , a.answerfield,'##')
			or r.rule_text rlike concat('session\.' , a.answerfield,'##'))
	union
	select r.rule_id, ha.answerfield_id
	from `rule` r, hardrule hr, hardrule_answerfield ha
	where r.rule_id=#attributes.rule_id#
		and (r.rule_text rlike concat('.*[^a-z0-9_]' , hr.code , '[^a-z0-9_].*')
			or r.rule_text rlike concat(hr.code , '[^a-z0-9_].*')
			or r.rule_text rlike concat('.*[^a-z0-9_]' , hr.code)
			or r.rule_text like hr.code)
		and hr.hardrule_id=ha.hardrule_id
</cfquery>
</cfsilent>
<cfif attributes.debug >
<h3>Debug Output: Rule Assocation</h3>
	insert into rule_answerfield
	select r.rule_id, a.answerfield_id
	from `rule` r, answerfield a
	where r.rule_id=#attributes.rule_id#
		and (r.rule_text rlike concat('.*[^a-z0-9_]session\.' , a.answerfield , '[^a-z0-9_].*')
			or r.rule_text rlike concat('session.' , a.answerfield , '[^a-z0-9_].*')
			or r.rule_text rlike concat('.*[^a-z0-9_]session\.' , a.answerfield,'##')
			or r.rule_text rlike concat('session\.' , a.answerfield,'##'))
	union
	select r.rule_id, ha.answerfield_id
	from `rule` r, hardrule hr, hardrule_answerfield ha
	where r.rule_id=#attributes.rule_id#
		and (r.rule_text rlike concat('.*[^a-z0-9_]' , hr.code , '[^a-z0-9_].*')
			or r.rule_text rlike concat(hr.code , '[^a-z0-9_].*')
			or r.rule_text rlike concat('.*[^a-z0-9_]' , hr.code)
			or r.rule_text like hr.code)
		and hr.hardrule_id=ha.hardrule_id


<br>
</cfif>
