<cfsilent>
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.alt" type="string" default="">
<cfparam name="attributes.width" type="string" default="">
<cfparam name="attributes.height" type="string" default="">
<cfparam name="attributes.border" type="string" default="">
<cfparam name="attributes.align" type="string" default="">
<cfparam name="attributes.hspace" type="string" default="">
<cfparam name="attributes.vspace" type="string" default="">
<cfparam name="attributes.ismap" type="string" default="">
<cfparam name="attributes.usemap" type="string" default="">
<cfparam name="attributes.longdesc" type="string" default="">
<cfparam name="attributes.id" type="string" default="">
<cfparam name="attributes.class" type="string" default="">
<cfparam name="attributes.title" type="string" default="">
<cfparam name="attributes.style" type="string" default="">
<cfparam name="attributes.lang" type="string" default="">
<cfparam name="attributes.onclick" type="string" default="">
<cfparam name="attributes.ondblclick" type="string" default="">
<cfparam name="attributes.onmousedown" type="string" default="">
<cfparam name="attributes.onmouseup" type="string" default="">
<cfparam name="attributes.onmouseover" type="string" default="">
<cfparam name="attributes.onmousemove" type="string" default="">
<cfparam name="attributes.onmouseout" type="string" default="">
<cfparam name="attributes.onkeypress" type="string" default="">
<cfparam name="attributes.onkeydown" type="string" default="">
<cfparam name="attributes.onkeyup" type="string" default="">
<cfset outstr = ''>
<cf_cacheImagePool action="get" code="#attributes.code#" var="iobj">
<cfif not IsStruct(iobj)>
	<cfset outstr = '<span style="font-weight: bold; color: ##800;">X</span>'>
<cfelse>
	<cfset outstr = '<img '>
	
		<cfif parameterExists(session.transferTypeCanonicalOverride)>
			<cfset urlType = session.transferTypeCanonicalOverride>
		<cfelse>
			<cfset urlType = application.transferType>		
		</cfif>		
	
	<cfif Left(iobj.file, 1) EQ "/">
     	<cfset iobj.file = ReReplaceNoCase(iobj.file,"/","","ONE")>
    </cfif>
    
	<cfset outstr = outstr & "src=""#iobj.file#"" ">
	<cfif attributes.alt eq ''>
		<cf_displayText group="imgalt" code="imgalt_#attributes.code#" alt="{{!!nada!!}}" title="{{!!nada!!}}" var="diAltText">
		<cfif diAltText neq '{{!!nada!!}}'>
			<cfset outstr = outstr & "alt=""#HTMLEditFormat(diAltText)#"" title=""#HTMLEditFormat(diAltText)#"" ">
		<cfelse>
			<cfset outstr = outstr & "alt="""" ">
		</cfif>
	<cfelse>
		<cfset outstr = outstr & "alt=""#HTMLEditFormat(attributes.alt)#"" title=""#HTMLEditFormat(attributes.alt)#"" ">
	</cfif>
	<cfif attributes.width eq ''>
		<cfif iobj.w neq ''>
			<cfset outstr = outstr & "width=""#iobj.w#"" ">
		</cfif>
	<cfelse>
		<cfset outstr = outstr & "width=""#attributes.width#"" ">
	</cfif>
	<cfif attributes.height eq ''>
		<cfif iobj.h neq ''>
			<cfset outstr = outstr & "height=""#iobj.h#"" ">
		</cfif>
	<cfelse>
		<cfset outstr = outstr & "height=""#attributes.height#"" ">
	</cfif>
	<cfif attributes.border neq ''>
		<cfset outstr = outstr & "border=""#attributes.border#"" ">
	</cfif>
	<cfif attributes.align neq ''>
		<cfset outstr = outstr & "align=""#attributes.align#"" ">
	</cfif>
	<cfif attributes.hspace neq ''>
		<cfset outstr = outstr & "hspace=""#attributes.hspace#"" ">
	</cfif>
	<cfif attributes.vspace neq ''>
		<cfset outstr = outstr & "vspace=""#attributes.vspace#"" ">
	</cfif>
	<cfif attributes.ismap neq ''>
		<cfset outstr = outstr & "ismap=""#attributes.ismap#"" ">
	</cfif>
	<cfif attributes.usemap neq ''>
		<cfset outstr = outstr & "usemap=""#attributes.usemap#"" ">
	</cfif>
	<cfif attributes.longdesc neq ''>
		<cfset outstr = outstr & "longdesc=""#attributes.longdesc#"" ">
	</cfif>
	<cfif attributes.id neq ''>
		<cfset outstr = outstr & "id=""#attributes.id#"" ">
	</cfif>
	<cfif attributes.class neq ''>
		<cfset outstr = outstr & "class=""#attributes.class#"" ">
	</cfif>
	<cfif attributes.title neq ''>
		<cfset outstr = outstr & "title=""#attributes.title#"" ">
	</cfif>
	<cfif attributes.style neq ''>
		<cfset outstr = outstr & "style=""#attributes.style#"" ">
	</cfif>
	<cfif attributes.lang neq ''>
		<cfset outstr = outstr & "lang=""#attributes.lang#"" ">
	</cfif>
	<cfif attributes.onclick neq ''>
		<cfset outstr = outstr & "onclick=""#attributes.onclick#"" ">
	</cfif>
	<cfif attributes.ondblclick neq ''>
		<cfset outstr = outstr & "ondblclick=""#attributes.ondblclick#"" ">
	</cfif>
	<cfif attributes.onmousedown neq ''>
		<cfset outstr = outstr & "onmousedown=""#attributes.onmousedown#"" ">
	</cfif>
	<cfif attributes.onmouseup neq ''>
		<cfset outstr = outstr & "onmouseup=""#attributes.onmouseup#"" ">
	</cfif>
	<cfif attributes.onmouseover neq ''>
		<cfset outstr = outstr & "onmouseover=""#attributes.onmouseover#"" ">
	</cfif>
	<cfif attributes.onmousemove neq ''>
		<cfset outstr = outstr & "onmousemove=""#attributes.onmousemove#"" ">
	</cfif>
	<cfif attributes.onmouseout neq ''>
		<cfset outstr = outstr & "onmouseout=""#attributes.onmouseout#"" ">
	</cfif>
	<cfif attributes.onkeypress neq ''>
		<cfset outstr = outstr & "onkeypress=""#attributes.onkeypress#"" ">
	</cfif>
	<cfif attributes.onkeydown neq ''>
		<cfset outstr = outstr & "onkeydown=""#attributes.onkeydown#"" ">
	</cfif>
	<cfif attributes.onkeyup neq ''>
		<cfset outstr = outstr & "onkeyup=""#attributes.onkeyup#"" ">
	</cfif>
	<cfset outstr = outstr & '/>'>
</cfif>
</cfsilent><cfoutput>#outstr#</cfoutput>