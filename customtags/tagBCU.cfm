<cfprocessingdirective suppresswhitespace="Yes">
<cfparam name="attributes.size" default="">
<cfparam name="attributes.face" default="">
<cfparam name="attributes.case" default="lower">
<cfparam name="attributes.typeset" type="boolean" default="false">
<cfparam name="attributes.partner_id" type="numeric" default="0">
<cfparam name="attributes.subset_id" type="numeric" default="0">
<cfif (IsDefined('session.partner_id') And session.partner_id eq 5) Or attributes.partner_id eq 5>LTCC Public Programs<cfelseif (IsDefined('session.partner_id') And session.partner_id eq 22) Or attributes.partner_id eq 22>Benefits QuickLINK<cfelse><cfset bcubrandnamebenefits = "Benefits"><cfset bcubrandnamecheckup = "CheckUp"><cfif attributes.subset_id eq 1><cfset bcubrandnamesuffix = "Rx"><cfelseif attributes.subset_id eq 18><cfset bcubrandnamesuffix = "Rx Plus"><cfelse><cfset bcubrandnamesuffix = ""></cfif><cfif attributes.case eq "upper"><cfset bcubrandnamebenefits = UCase(bcubrandnamebenefits)><cfset bcubrandnamecheckup = UCase(bcubrandnamecheckup)><cfset bcubrandnamesuffix = UCase(bcubrandnamesuffix)></cfif><cfoutput><cfif attributes.typeset><cfif attributes.size neq ""><font size="#attributes.size#"></cfif><cfif attributes.face neq ""><span style="font-family: #attributes.face#;"></cfif><span style="font-style: normal; font-weight: bold;">#bcubrandnamebenefits#</span><span style="font-style: italic; font-weight: normal;">#bcubrandnamecheckup#</span><cfif attributes.subset_id eq 1><span style="font-style: normal; font-weight: bold;">#bcubrandnamesuffix#</span></cfif><cfif attributes.face neq ""></span></cfif><cfif attributes.size neq ""></font></cfif><cfelse><cfif attributes.size neq "" or attributes.face neq ""><font<cfif attributes.size neq ""> size="#attributes.size#"</cfif><cfif attributes.face neq ""> face="#attributes.face#"</cfif>></cfif>#bcubrandnamebenefits##bcubrandnamecheckup##bcubrandnamesuffix#<cfif attributes.size neq "" or attributes.face neq ""></font></cfif></cfif></cfoutput></cfif></cfprocessingdirective>