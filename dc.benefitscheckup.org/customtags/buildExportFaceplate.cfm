<cfparam name="attributes.code" type="string">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.objectType" type="string" default="">

<cfif (ThisTag.ExecutionMode eq 'Start' And Not ThisTag.HasEndTag) Or ThisTag.ExecutionMode eq 'End'>

<cfset locallight = Evaluate("application.color.#attributes.code#.light")>
<cfset localmed = Evaluate("application.color.#attributes.code#.med")>
<cfset localdark = Evaluate("application.color.#attributes.code#.dark")>

<cfoutput>
<table border="0" cellpadding="3" cellspacing="3">
<cfif attributes.title neq ''>
	<tr bgcolor="#localdark#">
		<td><font size="+2"><b>#attributes.title#</b></font></td>
	</tr>
</cfif>
	<tr bgcolor="#localmed#">
		<td colspan="2"><font size="+1"><cfif IsDefined('ThisTag.AssocAttribs') and ArrayLen(ThisTag.AssocAttribs) eq 1>This link<cfelse>These links</cfif> will let you download the current #attributes.objectType# data in CSV format:</font></td>
	</tr>
	<tr bgcolor="#locallight#">
		<td><ul><br />
	<cfif IsDefined('ThisTag.AssocAttribs')>
		<cfloop index="x" from="1" to="#ArrayLen(ThisTag.AssocAttribs)#">
			<cfset href = ThisTag.AssocAttribs[x].href>
			<cfset text = ThisTag.AssocAttribs[x].text>
			<cfset section = ThisTag.AssocAttribs[x].section>
			<cfif section neq ''>
				<cfset href = "../#section#/#href#">
			</cfif>
			<cfif text eq ''>
				<cfset text = href>
			</cfif>
			<li>
				<strong><a href="#href#">#text#</a> &nbsp; <small><i>(<a href="#href#?format=html">HTML table format</a>)</i></small></strong>
			</li>
		</cfloop>
	</cfif>
		</ul></td>
	</tr>
	<tr bgcolor="#locallight#">
		<td>
			CSV is a comma-delimited text file that can be opened in Excel just as if it were a spreadsheet.  To save the exports:
			<ol>
			<li>Put your cursor on the desired link.</li>
			<li>Right-click.</li>
			<li>Choose "Save Target As..." (or "Save Link As..." in Firefox).</li>
			<li>Change the filename to whatever you like, but be sure to use <strong>.csv</strong> as the extension.</li>
			<li>Double-click the file where you saved it on your computer.</li>
			</ol>
			The file should open for you in Excel.<br />
			<br />
			(You do not need to follow these instructions for the secondary <i>HTML table format</i> link.  That you can just click on.)
		</td>
	</tr>
</table>
</cfoutput>

</cfif>