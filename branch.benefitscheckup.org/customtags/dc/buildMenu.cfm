<cfparam name="attributes.section" type="string" default="">
<cfparam name="attributes.internal" type="boolean" default="false">

<cfset menuList = 'display,question,answerfield,help,rx,program,rule,lookup,tote,form,subset,entrypoint,zip,url,partner,image,user,misc,upload'>
<cfset menuAlign = 'left,left,left,left,left,left,left,left,left,right,right,right,right,right,right,right,right,right,right'>
<cfset menuSpan = '0,0,1,2,2,0,5,3,7,3,5,2,1,3,1,2,1,0,0'>
<cfset menuCount = 0>
<cfloop list="#menuList#" index="x">
	<cfset menuCount = menuCount + 1>
	<cfset "menuStruct.#x#" = StructNew()>
	<cfset "menuStruct.#x#.align" = ListGetAt(menuAlign, menuCount)>
	<cfset "menuStruct.#x#.span" = ListGetAt(menuSpan, menuCount)>
</cfloop>
<cfset itemCount = ListLen(menuList)>

<cfif attributes.section neq ''>

<cfif attributes.internal>
	<cfset cellspacing = 2>
	<cfset cellpadding = 3>
	<cfset style = ' class="tiny"'>
	<cfset dir = "#session.serverpath#/#attributes.section#/">
<cfelse>
	<cfset cellspacing = 3>
	<cfset cellpadding = 4>
	<cfset style = ' class="small"'>
	<cfset dir = ''>
</cfif>

<script language="javascript">
<!--
var menuRowObj;
function switchMenu (id) {
	var menuID = 'menu-' + id;
	if (menuRowObj == null) {
		menuRowObj = document.getElementById('menu-none')
	}
	menuRowObj.style.display = 'none';
	menuRowObj = document.getElementById(menuID);
	menuRowObj.style.display = '';
}
//-->
</script>

<cfoutput>
	<cfswitch expression="#attributes.section#">
	
		<cfcase value="answerfield">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.answerfield.dark#"><b>answerfields</b></td>
		<td bgcolor="#application.color.answerfield.med#"><cf_checkAccessLink level="3" href="#dir#answerfieldview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#answerfieldlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#answerfieldsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.answerfieldtype.dark#"><b>answerfield types</b></td>
		<td bgcolor="#application.color.answerfieldtype.med#"><cf_checkAccessLink level="1" href="#dir#answerfieldtypeview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#answerfieldtypelist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.option.dark#"><b>options</b></td>
		<td bgcolor="#application.color.option.med#"><cf_checkAccessLink level="3" href="#dir#optionview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#optionlist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.validation.dark#"><b>validation</b></td>
		<td bgcolor="#application.color.validation.med#"><cf_checkAccessLink level="1" href="#dir#validationview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#validationlist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="display">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.display.dark#"><b>site text</b></td>
		<td bgcolor="#application.color.display.med#"><cf_checkAccessLink level="3" href="#dir#sitetextview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#sitetextlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#xlatelist.cfm">translate</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.displaygroup.dark#"><b>site text group</b></td>
		<td bgcolor="#application.color.displaygroup.med#"><cf_checkAccessLink level="1" href="#dir#displaygroupview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#displaygrouplist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.language.dark#"><b>languages</b></td>
		<td bgcolor="#application.color.language.med#"><cf_checkAccessLink level="1" href="#dir#languageview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#languagelist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.quote.dark#"><b>quotes</b></td>
		<td bgcolor="#application.color.quote.med#"><cf_checkAccessLink level="2" href="#dir#quoteview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#quotelist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="entrypoint">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.entrypoint.dark#"><b>entry points</b></td>
		<td bgcolor="#application.color.entrypoint.med#"><cf_checkAccessLink level="4" href="#dir#entrypointview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#entrypointsearch.cfm">search</cf_checkAccessLink> | <cf_checkAccessLink level="4" href="#dir#entrypointcheck.cfm">check</cf_checkAccessLink> | <cf_checkAccessLink level="4" href="#dir#export.cfm">export</cf_checkAccessLink> | <cf_checkAccessLink level="4" href="#dir#import.cfm">import</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.entrypointgroup.dark#"><b>entry point groups</b></td>
		<td bgcolor="#application.color.entrypointgroup.med#"><cf_checkAccessLink level="4" href="#dir#entrypointgroupview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#entrypointgrouplist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#entrypointgroupsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.phone.dark#"><b>phone numbers</b></td>
		<td bgcolor="#application.color.phone.med#"><cf_checkAccessLink level="5" href="#dir#phonesearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.phonetype.dark#"><b>phone types</b></td>
		<td bgcolor="#application.color.phonetype.med#"><cf_checkAccessLink level="4" href="#dir#phonetypeview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#phonetypelist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="form">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.form.dark#"><b>forms</b></td>
		<td bgcolor="#application.color.form.med#"><cf_checkAccessLink level="3" href="#dir#formnew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#formlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#formsearch.cfm">search</cf_checkAccessLink> | <cf_checkAccessLink level="2" href="#dir#formdeactivateall.cfm">deactivate all eforms</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.forminstance.dark#"><b>form instances</b></td>
		<td bgcolor="#application.color.forminstance.med#"><cf_checkAccessLink level="5" href="#dir#forminstancelist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#forminstancesearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.formtag.dark#"><b>form tags</b></td>
		<td bgcolor="#application.color.formtag.med#"><cf_checkAccessLink level="3" href="#dir#formtagview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#formtaglist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#formtagsearch.cfm">search</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="help">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.help.dark#"><b>help text</b></td>
		<td bgcolor="#application.color.help.med#"><cf_checkAccessLink level="3" href="#dir#helpview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#helplist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#helpsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.helptype.dark#"><b>help type</b></td>
		<td bgcolor="#application.color.helptype.med#"><cf_checkAccessLink level="1" href="#dir#helptypeview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#helptypelist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.error.dark#"><b>error text</b></td>
		<td bgcolor="#application.color.error.med#"><cf_checkAccessLink level="3" href="#dir#errorview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#errorlist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="image">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.image.dark#"><b>image</b></td>
		<td bgcolor="#application.color.image.med#"><cf_checkAccessLink level="3" href="#session.serverpath#/image/imagecrawl.cfm">crawl</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#session.serverpath#/image/imagelist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#session.serverpath#/image/imagesearch.cfm">search</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="lookup">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.lookup.dark#"><b>income tables</b></td>
		<td bgcolor="#application.color.lookup.med#"><cf_checkAccessLink level="3" href="#session.serverpath#/incometables/add_inc_tbl.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#session.serverpath#/incometables/inc_tbl2.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.msp.dark#"><b>msp income</b></td>
		<td bgcolor="#application.color.msp.med#"><cf_checkAccessLink level="5" href="#dir#mxincomelist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#mxincomesearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.msp.dark#"><b>msp assets</b></td>
		<td bgcolor="#application.color.msp.med#"><cf_checkAccessLink level="5" href="#dir#mxassetlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#mxassetsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.export.dark#"><b>utilities</b></td>
		<td bgcolor="#application.color.export.med#"><cf_checkAccessLink level="5" href="#dir#export.cfm">export</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#import.cfm">import</cf_checkAccessLink></td>

	</tr>
</table>
		</cfcase>
		
		<cfcase value="misc">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.funder.dark#"><b>funder</b></td>
		<td bgcolor="#application.color.funder.med#"><cf_checkAccessLink level="3" href="#dir#funderview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#funderlist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.reference.dark#"><b>reference</b></td>
		<td bgcolor="#application.color.reference.med#"><cf_checkAccessLink level="3" href="#dir#referenceview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#referencelist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.source.dark#"><b>source</b></td>
		<td bgcolor="#application.color.source.med#"><cf_checkAccessLink level="3" href="#dir#sourceview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#sourcelist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.upload.dark#"><b>search</b></td>
		<td bgcolor="#application.color.upload.med#"><cf_checkAccessLink level="5" href="#session.serverpath#/search/homesearch.cfm">view</cf_checkAccessLink></td>

		
	</tr>
</table>
		</cfcase>
		
		<cfcase value="partner">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.partner.dark#"><b>partners</b></td>
		<td bgcolor="#application.color.partner.med#"><cf_checkAccessLink level="3" href="#dir#partnerview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#partnerlist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.partnertype.dark#"><b>partner types</b></td>
		<td bgcolor="#application.color.partnertype.med#"><cf_checkAccessLink level="3" href="#dir#partnertypeview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#partnertypelist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.wrapper.dark#"><b>wrappers</b></td>
		<td bgcolor="#application.color.wrapper.med#"><cf_checkAccessLink level="3" href="#dir#wrapperview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#wrapperlist.cfm">list</cf_checkAccessLink></td>
<td></td>
		<td></td>
		<td bgcolor="#application.color.wrapper.dark#"><b>private label admin</b></td>
		<td bgcolor="#application.color.wrapper.med#"><cf_checkAccessLink level="3" href="#dir#plnew.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#pls.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="program">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.program.dark#"><b>programs</b></td>
		<td bgcolor="#application.color.program.med#"><cf_checkAccessLink level="3" href="#dir#programview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programsearch.cfm">search</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#programsupersortreorder.cfm">supersort</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#export.cfm">export</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.programcategory.dark#"><b>categories</b></td>
		<td bgcolor="#application.color.programcategory.med#"><cf_checkAccessLink level="2" href="#dir#programcategoryview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programcategorylist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#programcategoryorder.cfm">reorder</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.programgroup.dark#"><b>groups</b></td>
		<td bgcolor="#application.color.programgroup.med#"><cf_checkAccessLink level="2" href="#dir#programgroupview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programgrouplist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#programgrouporder.cfm">reorder</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.requisite.dark#"><b>requisites</b></td>
		<td bgcolor="#application.color.requisite.med#"><cf_checkAccessLink level="3" href="#dir#requisiteview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#requisitelist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#requisitesearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.programtext.dark#"><b>recs</b></td>
		<td bgcolor="#application.color.programtext.med#"><cf_checkAccessLink level="3" href="#dir#programtextview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programtextlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programtextsearch.cfm">search</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programtextfaceplate.cfm">export</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="question">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.question.dark#"><b>questions</b></td>
		<td bgcolor="#application.color.question.med#"><cf_checkAccessLink level="3" href="#dir#questionview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#questionlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#questionsearch.cfm">search</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#questionorder.cfm">reorder</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.questiontype.dark#"><b>types</b></td>
		<td bgcolor="#application.color.questiontype.med#"><cf_checkAccessLink level="1" href="#dir#questiontypeview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#questiontypelist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.questioncategory.dark#"><b>categories</b></td>
		<td bgcolor="#application.color.questioncategory.med#"><cf_checkAccessLink level="2" href="#dir#questioncategoryview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#questioncategorylist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#questioncategoryorder.cfm">reorder</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.questionheader.dark#"><b>headers</b></td>
		<td bgcolor="#application.color.questionheader.med#"><cf_checkAccessLink level="3" href="#dir#questionheaderview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#questionheaderlist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.gridrow.dark#"><b>grid&nbsp;rows</b></td>
		<td bgcolor="#application.color.gridrow.med#"><cf_checkAccessLink level="1" href="#dir#gridrowview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#gridrowlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#gridroworder.cfm">reorder</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.format.dark#"><b>formats</b></td>
		<td bgcolor="#application.color.format.med#"><cf_checkAccessLink level="1" href="#dir#formatview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#formatlist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="rule">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.rule.dark#"><b>rules</b></td>
		<td bgcolor="#application.color.rule.med#"><cf_checkAccessLink level="3" href="#dir#ruleview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#rulelist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#rulesearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.hardrule.dark#"><b>hardcoded rules</b></td>
		<td bgcolor="#application.color.hardrule.med#"><cf_checkAccessLink level="1" href="#dir#hardruleview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#hardrulelist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="rx">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.drug.dark#"><b>drugs</b></td>
		<td bgcolor="#application.color.drug.med#"><cf_checkAccessLink level="3" href="#dir#drugnew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#druglist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#drugsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.generic.dark#"><b>generics</b></td>
		<td bgcolor="#application.color.generic.med#"><cf_checkAccessLink level="3" href="#dir#genericnew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#genericlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#genericsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.drugcompany.dark#"><b>companies</b></td>
		<td bgcolor="#application.color.drugcompany.med#"><cf_checkAccessLink level="3" href="#dir#companynew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#companylist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#companysearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.program.dark#"><b>programs</b></td>
		<td bgcolor="#application.color.program.med#"><cf_checkAccessLink level="5" href="#dir#programlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programsearch.cfm">search</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="subset">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.subset.dark#"><b>subsets</b></td>
		<td bgcolor="#application.color.subset.med#"><cf_checkAccessLink level="3" href="#dir#subsetview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#subsetlist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#subsetsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.page.dark#"><b>screening pages</b></td>
		<td bgcolor="#application.color.page.med#"><cf_checkAccessLink level="3" href="#dir#pageview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#pagelist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="tote">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.programvalue.dark#"><b>program&nbsp;values</b></td>
		<td bgcolor="#application.color.programvalue.med#"><cf_checkAccessLink level="3" href="#dir#programvalueview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#programvaluelist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
		
		<cfcase value="upload">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.upload.dark#"><b>database</b></td>
		<td bgcolor="#application.color.upload.med#"><cf_checkAccessLink level="2" href="#dir#clean.cfm">clean</cf_checkAccessLink> | <cf_checkAccessLink level="1" href="#dir#upload.cfm">upload</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>

		<cfcase value="url">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.url.dark#"><b>urls</b></td>
		<td bgcolor="#application.color.url.med#"><cf_checkAccessLink level="3" href="#dir#urlnew.cfm">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#urllist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.template.dark#"><b>templates</b></td>
		<td bgcolor="#application.color.template.med#"><cf_checkAccessLink level="2" href="#dir#templateview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#templatelist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>

		<cfcase value="user">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.user.dark#"><b>users</b></td>
		<td bgcolor="#application.color.user.med#"><cf_checkAccessLink level="2" href="#dir#userview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#userlist.cfm">list</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.usertype.dark#"><b>user types</b></td>
		<td bgcolor="#application.color.usertype.med#"><cf_checkAccessLink level="1" href="#dir#usertypeview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="#dir#usertypelist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>

		<cfcase value="zip">
<table border="0" cellspacing="#cellspacing#" cellpadding="#cellpadding#"#style#>
	<tr>
		<td bgcolor="#application.color.state.dark#"><b>states</b></td>
		<td bgcolor="#application.color.state.med#"><cf_checkAccessLink level="5" href="#dir#statelist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#statesearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.zip.dark#"><b>zips</b></td>
		<td bgcolor="#application.color.zip.med#"><cf_checkAccessLink level="5" href="#dir#ziplist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#zipsearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.county.dark#"><b>counties</b></td>
		<td bgcolor="#application.color.county.med#"><cf_checkAccessLink level="5" href="#dir#countylist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#countysearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.city.dark#"><b>cities</b></td>
		<td bgcolor="#application.color.city.med#"><cf_checkAccessLink level="5" href="#dir#citylist.cfm">list</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#citysearch.cfm">search</cf_checkAccessLink></td>
		<td></td>
		<td bgcolor="#application.color.proximity.dark#"><b>prox</b></td>
		<td bgcolor="#application.color.proximity.med#"><cf_checkAccessLink level="1" href="#dir#proximityview.cfm?action=new">new</cf_checkAccessLink> | <cf_checkAccessLink level="5" href="#dir#proximitylist.cfm">list</cf_checkAccessLink></td>
	</tr>
</table>
		</cfcase>
	
		<cfdefaultcase>
		</cfdefaultcase>
	</cfswitch>
	<cfif not attributes.internal>
	<br>
	</cfif>

</cfoutput>

<cfelseif session.level lte 5>

<cfoutput>
<table width="100%" border="0" cellspacing="2" cellpadding="4" align="center">

  <tr bgcolor="#application.color.home#">

    <td height="22" align="center" bgcolor="#application.color.display.med#" onMouseOver="switchMenu('display');"><span class="normal"><b>text</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.question.med#" onMouseOver="switchMenu('question');"><span class="normal"><b>question</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.answerfield.med#" onMouseOver="switchMenu('answerfield');"><span class="normal"><b>answerfield</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.help.med#" onMouseOver="switchMenu('help');"><span class="normal"><b>help</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.drug.med#" onMouseOver="switchMenu('rx');"><span class="normal"><b>rx</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.program.med#" onMouseOver="switchMenu('program');"><span class="normal"><b>program</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.rule.med#" onMouseOver="switchMenu('rule');"><span class="normal"><b>rule</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.lookup.med#" onMouseOver="switchMenu('lookup');"><span class="normal"><b>lookup</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.tote.med#" onMouseOver="switchMenu('tote');"><span class="normal"><b>tote</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.form.med#" onMouseOver="switchMenu('form');"><span class="normal"><b>forms</b></span></td>
	<td height="22" align="center" bgcolor="#application.color.subset.med#" onMouseOver="switchMenu('subset');"><span class="normal"><b>subset</b></span></td>
	<td height="22" align="center" bgcolor="#application.color.entrypoint.med#" onMouseOver="switchMenu('entrypoint');"><span class="normal"><b>entry&nbsp;point</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.zip.med#" onMouseOver="switchMenu('zip');"><span class="normal"><b>zip</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.url.med#" onMouseOver="switchMenu('url');"><span class="normal"><b>url</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.partner.med#" onMouseOver="switchMenu('partner');"><span class="normal"><b>partner</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.image.med#" onMouseOver="switchMenu('image');"><span class="normal"><b>image</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.user.med#" onMouseOver="switchMenu('user');"><span class="normal"><b>user</b></span></td>
    <td height="22" align="center" bgcolor="#application.color.upload.med#" onMouseOver="switchMenu('misc');"><span class="normal"><b>other</b></span></td>
	<td height="22" align="center" bgcolor="#application.color.upload.med#" onMouseOver="switchMenu('upload');"><span class="normal"><b>database</b></span></td>

  </tr>

<tr id="menu-none" style="display:table-row;"><td colspan="#itemCount#">
	<table border="0" cellspacing="0" cellpadding="3" style="font-family: Verdana,sans-serif; font-size: 7pt;">
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
</td></tr>
<cfset menuCount = 0>
<cfloop list="#menuList#" index="x">
	<cfset menuCount = menuCount + 1>
	<cfset total = itemCount>
	<cfif Evaluate("menuStruct.#x#.align") eq 'left'>
		<cfset left = Evaluate("menuStruct.#x#.span")>
		<cfset total = total - left>
		<tr id="menu-#x#" style="display:none;"><cfif left gt 0><td colspan="#left#"></td></cfif>
		<td colspan="#total#">
		<cf_buildMenu section="#x#" internal="true">
		</td></tr>
	<cfelseif Evaluate("menuStruct.#x#.align") eq 'right'>
		<cfset right = Evaluate("menuStruct.#x#.span")>
		<cfset total = total - right>
		<tr id="menu-#x#" style="display:none;"><td colspan="#total#" align="right">
		<cf_buildMenu section="#x#" internal="true">
		</td>
		<cfif right gt 0><td colspan="#left#"></td></cfif></tr>
	<cfelse>
		<tr id="menu-#x#" style="display:none;"><td colspan="#itemCount#">
		<cf_buildMenu section="#x#" internal="true">
		</td></tr>
	</cfif>
</cfloop>
</table>
</cfoutput>
	
</cfif>