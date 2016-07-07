<cfsilent>
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.type" type="string" default="currency">
<cfparam name="attributes.aflistvarname" type="string" default="">
<cfparam name="attributes.tables" type="boolean" default="true">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>
<cfif attributes.mode neq 'print' and session.screening.prepopulate and StructKeyExists(session.screening.a, attributes.code)>
	<cfset matchVal = Evaluate("session.screening.a.#attributes.code#.pre")>
<cfelseif isdefined("session.screening.a.#attributes.code#.val") >
	<cfset default = Evaluate("session.screening.a.#attributes.code#.val")>
	<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="#default#" var="matchVal">
<cfelse>
	<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="0" var="matchVal">
</cfif>

<cfif attributes.type eq 'asset'>
	<cfset aftype = 'a'>
<cfelseif attributes.type eq 'income'>
	<cfset aftype = 'i'>
<cfelse>
	<cfset aftype = 'n'>
</cfif>
<cfset bcuAnswerfield = application.AnswerfieldPool.getAnswerfield('#attributes.code#')>
<cfif attributes.type eq 'asset' or attributes.type eq 'income'>
	<cfset maxlength = "8">
	<cfset size = "9">
	<cfset underscore = "10">
	<cfset showDollarSign = false>
	<cfset setOnBlurFunction = true >
<cfelseif bcuAnswerfield.length eq ''>
	<cfset maxlength = "8">
	<cfset size = "9">
	<cfset underscore = "12">
	<cfset showDollarSign = true>
	<cfset setOnBlurFunction = false >
<cfelse>
	<cfset maxlength = bcuAnswerfield.length>
	<cfset size = maxlength + 1>
	<cfif size gt 15>
		<cfset size = 15>
	</cfif>
	<cfset underscore = maxlength * 2>
	<cfif underscore gt 12>
		<cfset underscore = 12>
	</cfif>
	<cfset showDollarSign = true>
	<cfset setOnBlurFunction = false >
</cfif>

</cfsilent><cfif attributes.mode neq 'print'>
	<cfif attributes.tables>
	<table align="right" border="0" cellspacing="0" cellpadding="0">
    	<tr>
			<cfif showDollarSign>
            	<td class="q-field">$</td>
            </cfif>
            <td class="q-field">&nbsp;</td>
            <td class="q-field">
				<cfoutput>
                	<cfif session.subset_id EQ 63 AND (aftype EQ 'A' OR aftype EQ 'i')>
						<input class="grid_input" type="text" name="#attributes.code#" value="#HTMLEditFormat(matchVal)#" size="#size#" maxlength="#maxlength#" <cfif setOnBlurFunction>onBlur="chkDollar(this,value);"</cfif>>
                	<cfelse>
	                    <input type="text" name="#attributes.code#" value="#HTMLEditFormat(matchVal)#" size="#size#" maxlength="#maxlength#" <cfif setOnBlurFunction>onBlur="chkDollar(this,value);"</cfif>>
                  	</cfif>
				</cfoutput>
            </td>
        </tr>
    </table>
    <cfelse>
    	<cfoutput>
            <cfif showDollarSign>$&nbsp;</cfif><input type="text" name="#attributes.code#" value="#HTMLEditFormat(matchVal)#" size="#size#" maxlength="#maxlength#" <cfif setOnBlurFunction>onBlur="chkDollar(this,value);"</cfif>>
        </cfoutput>
    </cfif>
<cfelse>
	<cfoutput><cfif showDollarSign>$&nbsp;</cfif>#RepeatString('_', underscore)#</cfoutput>
</cfif><cfsilent>

<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cftry>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "#aftype#-#attributes.code#")>
	<cfcatch></cfcatch>
	</cftry>
</cfif>

</cfsilent>