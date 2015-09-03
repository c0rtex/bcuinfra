<cfparam name="attributes.varname" type="string" default="jscode">
<cfparam name="attributes.frame" type="string" default="report">
<cfparam name="attributes.doctype" type="string" default="Report">
<cfparam name="attributes.message" type="string" default="If you have Adobe Acrobat 7.0 or higher installed, you may not be able to print your #LCase(attributes.doctype)# by clicking this button.  Instead click [Cancel], then click the printer icon in the toolbar below the [Print Your #attributes.doctype#] button.  If you have an earlier version of Acrobat installed, click [OK] to continue and print your #LCase(attributes.doctype)#.">

<cfset message = Replace(Trim(attributes.message), '''', '\''', 'ALL')>
<cfset outstr = "if (confirm('#message#')) parent.#attributes.frame#.print();">

<cfset "caller.#attributes.varname#" = outstr>