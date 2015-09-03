<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>suggest spelling</title>

<cfif Left(Server.ColdFusion.ProductVersion,1) gte 6>
	<cfset StructDelete(server, "activspell_class")>
	<cfif not StructKeyExists(server,"activspell_class")>
		<cfset Array=CreateObject("java", "java.lang.reflect.Array")>
		<cfset urlArray = Array.newInstance(CreateObject("java", "java.lang.Class").forName("java.net.URL"), JavaCast("int", 1))>
		<cfset dir=ExpandPath("./ActivSpell2.jar")>
		<cfset dir=replace(dir,"\","/","all")>
		<cfset Array.set(urlArray,0,createObject("java", "java.io.File").init(dir).toURL())>
		<cfset loader = CreateObject("java", "java.net.URLClassLoader").init(urlArray,getClass().getClassLoader())>
		<cfset clazz=loader.loadClass("com.cfdev.activspell2.SpellChecker")>
		<cflock scope="server" timeout="30">
			<cfset StructInsert(Server,"activspell_class",clazz)>
		</cflock>
	</cfif>
	<cfscript>
		strClass=getClass().forName('java.lang.String');
		a = arrayNew(1);
	    a[1] = strClass;
	    a[2] = strClass;
	    a[3] = strClass;
	    method=server.activspell_class.getMethod("init", a);
		a[1]=Request.userdict;
		a[2]=Request.tlx;
		a[3]=Request.clx;
		spellChecker = createObject("java", "coldfusion.runtime.java.JavaProxy").init(server.activspell_class);
		spellChecker.init();
		method.invoke(spellChecker,a);	
	</cfscript>
<cfelse>
	<cfscript>
		spellChecker = createObject("java", "com.cfdev.activspell2.SpellChecker");
		spellChecker.init(Request.userdict, Request.tlx, Request.clx);
	</cfscript>
</cfif>

<cfscript>
	spellChecker.setEnglishPhoneticComparator(Request.englishphonetic);
	spellChecker.setSearchDepth(Request.searchdepth);
	spellChecker.setNumSuggestions(Request.suggestions);
	jsoutput = spellChecker.checkSpelling("#word#", "javascript", Request.striphtml);
</cfscript>

<script>
function spell() {
<cfoutput>
#jsoutput#
</cfoutput>

	if (typeof(suggestions) == "undefined") { 
		var suggestions = new Array();
		suggestions[0] = new Array();
	}
	<cfoutput>
	parent.topframe.doSuggest("#word#", numMispelled, suggestions);
	</cfoutput>
}
</script>
</head>

<body onload="spell()">

<font face="verdana" size="-2">
	<span name="viewer" id="viewer">&nbsp;&nbsp;Suggestions for <cfoutput>#word#</cfoutput></span>
</font>


</body>
</html>
