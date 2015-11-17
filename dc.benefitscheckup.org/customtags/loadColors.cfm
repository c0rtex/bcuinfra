<cfsilent>
<!---cfif Not IsDefined('application.color')--->
	<cfset application.color = StructNew()>
	<!---cfset application.color.page = "##ffffff"--->
	<cfset application.color.home = "##dddddd">
<!---/cfif--->
<cfif Not IsDefined('application.color.alturlpartner')>
	<cfset application.color.alturlpartner = StructNew()>
	<cfset application.color.alturlpartner.dark = "##505380">
	<cfset application.color.alturlpartner.med = "##737AC3">
	<cfset application.color.alturlpartner.light = "##8890DB">
</cfif>
<cfif Not IsDefined('application.color.answerfield')>
	<cfset application.color.answerfield = StructNew()>
	<cfset application.color.answerfield.dark = "##C7C654">
	<cfset application.color.answerfield.med = "##D3D284">
	<cfset application.color.answerfield.light = "##DEDEAF">
</cfif>
<cfif Not IsDefined('application.color.answerfieldtype')>
	<cfset application.color.answerfieldtype = StructNew()>
	<cfset application.color.answerfieldtype.dark = "##B5A654">
	<cfset application.color.answerfieldtype.med = "##D1C47D">
	<cfset application.color.answerfieldtype.light = "##DFD38F">
</cfif>
<cfif Not IsDefined('application.color.city')>
	<cfset application.color.city = StructNew()>
	<cfset application.color.city.dark = "##df3555">
	<cfset application.color.city.med = "##f96181">
	<cfset application.color.city.light = "##ff7292">
</cfif>
<cfif Not IsDefined('application.color.county')>
	<cfset application.color.county = StructNew()>
	<cfset application.color.county.dark = "##d64f6f">
	<cfset application.color.county.med = "##f07090">
	<cfset application.color.county.light = "##fd97b7">
</cfif>
<cfif Not IsDefined('application.color.display')>
	<cfset application.color.display = StructNew()>
	<cfset application.color.display.dark = "##C754A0">
	<cfset application.color.display.med = "##D291BC">
	<cfset application.color.display.light = "##DDC4D5">
</cfif>
<cfif Not IsDefined('application.color.displaygroup')>
	<cfset application.color.displaygroup = StructNew()>
	<cfset application.color.displaygroup.dark = "##B49E74">
	<cfset application.color.displaygroup.med = "##CAB896">
	<cfset application.color.displaygroup.light = "##D7C9AC">
</cfif>
<cfif Not IsDefined('application.color.drug')>
	<cfset application.color.drug = StructNew()>
	<cfset application.color.drug.dark = "##ffaaaa">
	<cfset application.color.drug.med = "##ffcccc">
	<cfset application.color.drug.light = "##ffe2e2">
</cfif>
<cfif Not IsDefined('application.color.drugcompany')>
	<cfset application.color.drugcompany = StructNew()>
	<cfset application.color.drugcompany.dark = "##ffff50">
	<cfset application.color.drugcompany.med = "##ffffa0">
	<cfset application.color.drugcompany.light = "##ffffc0">
</cfif>
<cfif Not IsDefined('application.color.entrypoint')>
	<cfset application.color.entrypoint = StructNew()>
	<cfset application.color.entrypoint.dark = "##DF0038">
	<cfset application.color.entrypoint.med = "##F08575">
	<cfset application.color.entrypoint.light = "##F4BAA6">
</cfif>
<cfif Not IsDefined('application.color.entrypointgroup')>
	<cfset application.color.entrypointgroup = StructNew()>
	<cfset application.color.entrypointgroup.dark = "##FF3300">
	<cfset application.color.entrypointgroup.med = "##FF8262">
	<cfset application.color.entrypointgroup.light = "##FFA48C">
</cfif>
<cfif Not IsDefined('application.color.error')>
	<cfset application.color.error = StructNew()>
	<cfset application.color.error.dark = "##fd5a21">
	<cfset application.color.error.med = "##FA9471">
	<cfset application.color.error.light = "##FAAF95">
</cfif>
<cfif Not IsDefined('application.color.export')>
	<cfset application.color.export = StructNew()>
	<cfset application.color.export.dark = "##E8C26C">
	<cfset application.color.export.med = "##F0D79F">
	<cfset application.color.export.light = "##F4E3BD">
</cfif>
<cfif Not IsDefined('application.color.form')>
	<cfset application.color.form = StructNew()>
	<cfset application.color.form.dark = "##B07CA9">
	<cfset application.color.form.med = "##CEA8C9">
	<cfset application.color.form.light = "##E6D2E4">
</cfif>
<cfif Not IsDefined('application.color.forminstance')>
	<cfset application.color.forminstance = StructNew()>
	<cfset application.color.forminstance.dark = "##825799">
	<cfset application.color.forminstance.med = "##B497C4">
	<cfset application.color.forminstance.light = "##CFBBD9">
</cfif>
<cfif Not IsDefined('application.color.formtag')>
	<cfset application.color.formtag = StructNew()>
	<cfset application.color.formtag.dark = "##915AA3">
	<cfset application.color.formtag.med = "##B996C5">
	<cfset application.color.formtag.light = "##DBC9E0">
</cfif>
<cfif Not IsDefined('application.color.format')>
	<cfset application.color.format = StructNew()>
	<cfset application.color.format.dark = "##47D39D">
	<cfset application.color.format.med = "##63E5B3">
	<cfset application.color.format.light = "##81FBCC">
</cfif>
<cfif Not IsDefined('application.color.formtype')>
	<cfset application.color.formtype = StructNew()>
	<cfset application.color.formtype.dark = "##80A3B8">
	<cfset application.color.formtype.med = "##A5BFD0">
	<cfset application.color.formtype.light = "##C9DBE5">
</cfif>
<cfif Not IsDefined('application.color.funder')>
	<cfset application.color.funder = StructNew()>
	<cfset application.color.funder.dark = "##CC9999">
	<cfset application.color.funder.med = "##FFcccc">
	<cfset application.color.funder.light = "##FFeeee">
</cfif>
<cfif Not IsDefined('application.color.generic')>
	<cfset application.color.generic = StructNew()>
	<cfset application.color.generic.dark = "##aaffaa">
	<cfset application.color.generic.med = "##ccffcc">
	<cfset application.color.generic.light = "##e2ffe2">
</cfif>
<cfif Not IsDefined('application.color.gridrow')>
	<cfset application.color.gridrow = StructNew()>
	<cfset application.color.gridrow.dark = "##9BCE80">
	<cfset application.color.gridrow.med = "##BDE2AC">
	<cfset application.color.gridrow.light = "##D3EDC8">
</cfif>
<cfif Not IsDefined('application.color.hardrule')>
	<cfset application.color.hardrule = StructNew()>
	<cfset application.color.hardrule.dark = "##91F753">
	<cfset application.color.hardrule.med = "##CAFBAC">
	<cfset application.color.hardrule.light = "##E0FDCE">
</cfif>
<cfif Not IsDefined('application.color.help')>
	<cfset application.color.help = StructNew()>
	<cfset application.color.help.dark = "##88AA20">
	<cfset application.color.help.med = "##B4D747">
	<cfset application.color.help.light = "##C7E95D">
</cfif>
<cfif Not IsDefined('application.color.helptype')>
	<cfset application.color.helptype = StructNew()>
	<cfset application.color.helptype.dark = "##58A624">
	<cfset application.color.helptype.med = "##A4E27A">
	<cfset application.color.helptype.light = "##BCEA9D">
</cfif>
<cfif Not IsDefined('application.color.image')>
	<cfset application.color.image = StructNew()>
	<cfset application.color.image.dark = "##F48CA7">
	<cfset application.color.image.med = "##F9B7C9">
	<cfset application.color.image.light = "##FBCED7">
</cfif>
<cfif Not IsDefined('application.color.language')>
	<cfset application.color.language = StructNew()>
	<cfset application.color.language.dark = "##DC403B">
	<cfset application.color.language.med = "##E57673">
	<cfset application.color.language.light = "##EDA8A6">
</cfif>
<cfif Not IsDefined('application.color.lookup')>
	<cfset application.color.lookup = StructNew()>
	<cfset application.color.lookup.dark = "##718967">
	<cfset application.color.lookup.med = "##B1C0AB">
	<cfset application.color.lookup.light = "##C6D0C1">
</cfif>
<cfif Not IsDefined('application.color.msp')>
	<cfset application.color.msp = StructNew()>
	<cfset application.color.msp.dark = "##ADAB67">
	<cfset application.color.msp.med = "##C2C18F">
	<cfset application.color.msp.light = "##DAD9BB">
</cfif>
<cfif Not IsDefined('application.color.option')>
	<cfset application.color.option = StructNew()>
	<cfset application.color.option.dark = "##BC7733">
	<cfset application.color.option.med = "##E9A96B">
	<cfset application.color.option.light = "##FFC891">
</cfif>
<cfif Not IsDefined('application.color.page')>
	<cfset application.color.page = StructNew()>
	<cfset application.color.page.dark = "##6C9BCA">
	<cfset application.color.page.med = "##A7C6E4">
	<cfset application.color.page.light = "##CADAE9">
</cfif>
<cfif Not IsDefined('application.color.partner')>
	<cfset application.color.partner = StructNew()>
	<cfset application.color.partner.dark = "##747d86">
	<cfset application.color.partner.med = "##A6B3C0">
	<cfset application.color.partner.light = "##C0CFDE">
</cfif>
<cfif Not IsDefined('application.color.partnertype')>
	<cfset application.color.partnertype = StructNew()>
	<cfset application.color.partnertype.dark = "##539197">
	<cfset application.color.partnertype.med = "##82B6BB">
	<cfset application.color.partnertype.light = "##ABCDD1">
</cfif>
<cfif Not IsDefined('application.color.phone')>
	<cfset application.color.phone = StructNew()>
	<cfset application.color.phone.dark = "##4B6C1E">
	<cfset application.color.phone.med = "##95CD49">
	<cfset application.color.phone.light = "##BCDF8C">
</cfif>
<cfif Not IsDefined('application.color.phonetype')>
	<cfset application.color.phonetype = StructNew()>
	<cfset application.color.phonetype.dark = "##5E731E">
	<cfset application.color.phonetype.med = "##ADCF47">
	<cfset application.color.phonetype.light = "##C6DD80">
</cfif>
<cfif Not IsDefined('application.color.program')>
	<cfset application.color.program = StructNew()>
	<cfset application.color.program.dark = "##aaaaff">
	<cfset application.color.program.med = "##ccccff">
	<cfset application.color.program.light = "##e2e2ff">
</cfif>
<cfif Not IsDefined('application.color.programcategory')>
	<cfset application.color.programcategory = StructNew()>
	<cfset application.color.programcategory.dark = "##80A3B8">
	<cfset application.color.programcategory.med = "##A5BFD0">
	<cfset application.color.programcategory.light = "##C9DBE5">
</cfif>
<cfif Not IsDefined('application.color.programgroup')>
	<cfset application.color.programgroup = StructNew()>
	<cfset application.color.programgroup.dark = "##8F74FC">
	<cfset application.color.programgroup.med = "##BFB0FD">
	<cfset application.color.programgroup.light = "##D6CBFE">
</cfif>
<cfif Not IsDefined('application.color.programtext')>
	<cfset application.color.programtext = StructNew()>
	<cfset application.color.programtext.dark = "##8888cc">
	<cfset application.color.programtext.med = "##aaaacc">
	<cfset application.color.programtext.light = "##d0d0cc">
</cfif>
<cfif Not IsDefined('application.color.programvalue')>
	<cfset application.color.programvalue = StructNew()>
	<cfset application.color.programvalue.dark = "##e0cc1a">
	<cfset application.color.programvalue.med = "##e8ee3a">
	<cfset application.color.programvalue.light = "##f0ff5a">
</cfif>
<cfif Not IsDefined('application.color.proximity')>
	<cfset application.color.proximity = StructNew()>
	<cfset application.color.proximity.dark = "##66BAB0">
	<cfset application.color.proximity.med = "##99D8CE">
	<cfset application.color.proximity.light = "##CCE3DA">
</cfif>
<cfif Not IsDefined('application.color.question')>
	<cfset application.color.question = StructNew()>
	<cfset application.color.question.dark = "##9BCE40">
	<cfset application.color.question.med = "##BDE27C">
	<cfset application.color.question.light = "##D3EDA6">
</cfif>
<cfif Not IsDefined('application.color.questioncategory')>
	<cfset application.color.questioncategory = StructNew()>
	<cfset application.color.questioncategory.dark = "##748F6E">
	<cfset application.color.questioncategory.med = "##9BBD93">
	<cfset application.color.questioncategory.light = "##B8E1AF">
</cfif>
<cfif Not IsDefined('application.color.questionheader')>
	<cfset application.color.questionheader = StructNew()>
	<cfset application.color.questionheader.dark = "##79932D">
	<cfset application.color.questionheader.med = "##9FC03A">
	<cfset application.color.questionheader.light = "##BDD674">
</cfif>
<cfif Not IsDefined('application.color.questiontype')>
	<cfset application.color.questiontype = StructNew()>
	<cfset application.color.questiontype.dark = "##8CA063">
	<cfset application.color.questiontype.med = "##B1CB7E">
	<cfset application.color.questiontype.light = "##C5E28C">
</cfif>
<cfif Not IsDefined('application.color.quote')>
	<cfset application.color.quote = StructNew()>
	<cfset application.color.quote.dark = "##c5af66">
	<cfset application.color.quote.med = "##e0cb82">
	<cfset application.color.quote.light = "##edd891">
</cfif>
<cfif Not IsDefined('application.color.reference')>
	<cfset application.color.reference = StructNew()>
	<cfset application.color.reference.dark = "##99cc99">
	<cfset application.color.reference.med = "##bbffbb">
	<cfset application.color.reference.light = "##ddffdd">
</cfif>
<cfif Not IsDefined('application.color.requisite')>
	<cfset application.color.requisite = StructNew()>
	<cfset application.color.requisite.dark = "##E0A01D">
	<cfset application.color.requisite.med = "##EECB62">
	<cfset application.color.requisite.light = "##F4DD97">
</cfif>

<cfif Not IsDefined('application.color.subset_content')>
	<cfset application.color.subset_content = StructNew()>
	<cfset application.color.subset_content.dark = "##E0A01D">
	<cfset application.color.subset_content.med = "##EECB62">
	<cfset application.color.subset_content.light = "##F4DD97">
</cfif>

<cfif Not IsDefined('application.color.rule')>
	<cfset application.color.rule = StructNew()>
	<cfset application.color.rule.dark = "##aaffaa">
	<cfset application.color.rule.med = "##ccffcc">
	<cfset application.color.rule.light = "##e2ffe2">
</cfif>
<cfif Not IsDefined('application.color.sitetext')>
	<cfset application.color.sitetext = StructNew()>
	<cfset application.color.sitetext.dark = "##C754A0">
	<cfset application.color.sitetext.med = "##D291BC">
	<cfset application.color.sitetext.light = "##DDC4D5">
</cfif>


<cfif Not IsDefined('application.color.snap')>
	<cfset application.color.snap = StructNew()>
	<cfset application.color.snap.dark = "##C754A0">
	<cfset application.color.snap.med = "##D291BC">
	<cfset application.color.snap.light = "##DDC4D5">
</cfif>

<cfif Not IsDefined('application.color.source')>
	<cfset application.color.source = StructNew()>
	<cfset application.color.source.dark = "##9999cc">
	<cfset application.color.source.med = "##bbbbff">
	<cfset application.color.source.light = "##ddddff">
</cfif>
<cfif Not IsDefined('application.color.state')>
	<cfset application.color.state = StructNew()>
	<cfset application.color.state.dark = "##b27e9e">
	<cfset application.color.state.med = "##dca1c1">
	<cfset application.color.state.light = "##f4b7d7">
</cfif>
<cfif Not IsDefined('application.color.state_snap')>
	<cfset application.color.state_snap = StructNew()>
	<cfset application.color.state_snap.dark = "##b27e9e">
	<cfset application.color.state_snap.med = "##dca1c1">
	<cfset application.color.state_snap.light = "##f4b7d7">
</cfif>

<cfif Not IsDefined('application.color.statetype')>
	<cfset application.color.statetype = StructNew()>
	<cfset application.color.statetype.dark = "##ae91b1">
	<cfset application.color.statetype.med = "##d3b4d4">
	<cfset application.color.statetype.light = "##e7c8e8">
</cfif>
<cfif Not IsDefined('application.color.subset')>
	<cfset application.color.subset = StructNew()>
	<cfset application.color.subset.dark = "##ff9900">
	<cfset application.color.subset.med = "##ffcc66">
	<cfset application.color.subset.light = "##ffe099">
</cfif>
<cfif Not IsDefined('application.color.template')>
	<cfset application.color.template = StructNew()>
	<cfset application.color.template.dark = "##62559D">
	<cfset application.color.template.med = "##978EC1">
	<cfset application.color.template.light = "##B5AED2">
</cfif>
<cfif Not IsDefined('application.color.tote')>
	<cfset application.color.tote = StructNew()>
	<cfset application.color.tote.dark = "##eeee00">
	<cfset application.color.tote.med = "##eeee55">
	<cfset application.color.tote.light = "##eeee88">
</cfif>
<cfif Not IsDefined('application.color.upload')>
	<cfset application.color.upload = StructNew()>
	<cfset application.color.upload.dark = "##999999">
	<cfset application.color.upload.med = "##cccccc">
	<cfset application.color.upload.light = "##eeeeee">
</cfif>
<cfif Not IsDefined('application.color.url')>
	<cfset application.color.url = StructNew()>
	<cfset application.color.url.dark = "##7075A0">
	<cfset application.color.url.med = "##959CE5">
	<cfset application.color.url.light = "##AAB1FD">
</cfif>
<cfif Not IsDefined('application.color.user')>
	<cfset application.color.user = StructNew()>
	<cfset application.color.user.dark = "##B08D7D">
	<cfset application.color.user.med = "##D7AC9A">
	<cfset application.color.user.light = "##FAC8B2">
</cfif>
<cfif Not IsDefined('application.color.usertype')>
	<cfset application.color.usertype = StructNew()>
	<cfset application.color.usertype.dark = "##B07E7E">
	<cfset application.color.usertype.med = "##DFA0A0">
	<cfset application.color.usertype.light = "##FAB2B2">
</cfif>
<cfif Not IsDefined('application.color.validation')>
	<cfset application.color.validation = StructNew()>
	<cfset application.color.validation.dark = "##D0B752">
	<cfset application.color.validation.med = "##E6CE6F">
	<cfset application.color.validation.light = "##F3DD85">
</cfif>
<cfif Not IsDefined('application.color.wrapper')>
	<cfset application.color.wrapper = StructNew()>
	<cfset application.color.wrapper.dark = "##22737B">
	<cfset application.color.wrapper.med = "##2E99AF">
	<cfset application.color.wrapper.light = "##21ADCB">
</cfif>
<cfif Not IsDefined('application.color.zip')>
	<cfset application.color.zip = StructNew()>
	<cfset application.color.zip.dark = "##cb6b8b">
	<cfset application.color.zip.med = "##ed8dad">
	<cfset application.color.zip.light = "##f995b5">
</cfif>
</cfsilent>
