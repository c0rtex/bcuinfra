<cfparam name="attributes.print" type="boolean" default="true">
<cfparam name="attributes.printText" type="string" default="Print This Page Now For Your Records">
<cfparam name="attributes.go" type="boolean" default="true">
<cfparam name="attributes.goText" type="string" default="Go Back">
<cfparam name="attributes.goURL" type="string" default="">
<cfparam name="attributes.goMethod" type="string" default="post">
<cfparam name="attributes.goTarget" type="string" default="">
<cfparam name="attributes.fontFace" type="string" default="Arial, Helvetica, Verdana, sans-serif">
<cfparam name="attributes.fontSize" type="numeric" default="8">
<cfset fontStyle="font-family: #attributes.fontFace#; font-size: #attributes.fontSize#pt;">
<cfif attributes.print or attributes.go><cfoutput><form<cfif attributes.goURL neq ''> method="#attributes.goMethod#" action="#attributes.goURL#"<cfif attributes.goTarget neq ''> target="#attributes.goTarget#"</cfif></cfif>>
<cfif attributes.print><input class="view_buttons" type="button" name="print" value="#attributes.printText#" style="#fontStyle#" onclick="self.print();"></cfif>
<cfif (session.partner_id neq 0)><br><br></cfif>
<cfif attributes.go><input class="view_buttons" type="<cfif attributes.goURL eq ''>button<cfelse>submit</cfif>" name="prev" value="#attributes.goText#" style="#fontStyle#"<cfif attributes.goURL eq ''> onclick="history.go(-1);"</cfif>></cfif>
</form></cfoutput></cfif>