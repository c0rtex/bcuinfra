<!---<cfsetting showDebugOutput="No">
<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ReferenceTableLookupService.svc?wsdl" result="wsdl">
	<cfhttpparam type="header" name="Accept-Encoding" value="*" />
	<cfhttpparam type="Header" name="TE" value="deflate;q=0">
</cfhttp>
<cfdump var="#wsdl.filecontent#">
<cffile file="c:\inetpub\wwwroot\local.benefitscheckup.org\testWSDL.xml" action="write" output="#wsdl.filecontent#">
<cfabort>

<cfinvoke webservice = "https://www.humanservices-t.state.pa.us/Compass.RIAServices/ReferenceTableLookupService.svc?wsdl"
          method = "GetCpUserDetails"
          returnVariable = "GetCpUserDetails"
          refreshWSDL = "yes"
          >
          <cfinvokeargument name="CPUserId" value="b-sengels">
</cfinvoke>

<cfdump var="#GetBenefits#">
--->
<!---<cfsavecontent variable="variables.soap">
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
  	<CPUserId>b-sengels</CPUserId>
  </soap12:Body>
</soap12:Envelope>
</cfsavecontent>


<cfhttp
  url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ReferenceTableLookupService.svc?wsdl"
  method="GET"
>

  <cfhttpparam type="header" name="Content-Length" value="#Len( Trim( variables.soap ))#" />
  <cfhttpparam type="xml" value="#Trim( variables.soap )#" />
</cfhttp>

<cfdump var="#xmlParse( cfhttp.filecontent )#" />--->

<!---<cfinvoke 
	 webservice="https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc?wsdl" 
	 method="GetCpUserDetails" 
	 returnVariable="ws" 
	 username="b-ggreenberg"
	 password="Password">
	<cfinvokeargument name="CPUserId" value="CPD" />
</cfinvoke>


<cfdump var="#ws#">
--->

<!---<cfsavecontent variable="soap">
	<soapenv:Envelope
	 xmlns:q0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12"
	 xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	 <soapenv:Header>
	 </soapenv:Header>
	 <soapenv:Body>
	 <q0:CPUserRequest>
	  <q0:CPUserId>CPD</q0:CPUserId>
	</q0:CPUserRequest>
	</soapenv:Body>
	</soapenv:Envelope>
</cfsavecontent>

<cfhttp url="https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc/secured" method="get">
    <cfhttpparam type="header" name="content-type" value="text/xml">
    <cfhttpparam type="header" name="SOAPAction" value="">
    <cfhttpparam type="header" name="content-length" value="#len(soap)#">
    <cfhttpparam type="header" name="charset" value="utf-8">
    <cfhttpparam type="xml" name="message" value="#trim(soap)#">
</cfhttp>--->


<!---<cfscript>
 // Create the web service object.
 ws = CreateObject("webservice", "https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc?wsdl");
 
 // Set the username header as a string.
 addSOAPRequestHeader(ws, "https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc/secured", "username", "b-ggreenberg", false);
 
 // Set the password header as a CFML XML object.
 doc = XmlNew();
 doc.password = XmlElemNew(doc, "https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc/secured", "password");
 doc.password.XmlText = "Password##1";
 doc.password.XmlAttributes["xsi:type"] = "xsd:string";
 addSOAPRequestHeader(ws, "ignoredNameSpace", "ignoredName", doc);

 // Invoke the web service operation.
 ret = ws.echo_me("argument");
 

</cfscript>
--->


<!---<cfhttp firstRowAsHeaders="yes" result="postResults"
	method="POST"
	url="https://www.humanservices-t.state.pa.us/siteminderagent/forms/login.fcc"
	resolveURL="yes" 
	name="aspnetForm"
	
>

<cfhttpparam name="USER" type="formField" value="b-ggreenberg">
<cfhttpparam name="PASSWORD" type="formField" value="Password##1">
<cfhttpparam name="Target" type="formField" value="https://www.humanservices-t.state.pa.us/compass.web/MenuItems/CPSystemCompatibility.aspx">
<cfhttpparam type="cookie" name="ASP.NET_SessionId" value="h2zejcyxvnm42x55ntqlz145; path=/; HttpOnly">
</cfhttp>


<cfdump var="#postResults#">

<hr>

<cfhttp firstRowAsHeaders="yes" result="getResults"
	method="GET"
	url="https://www.humanservices-t.state.pa.us/compass.web/CMHOM.aspx"
	resolveURL="yes" 
	name="aspnetForm"
	redirect="no"

></cfhttp>


<cfdump var="#getResults#">--->

<!---
<cfhttp url="https://www.humanservices-t.state.pa.us/compass.web/CMHOM.aspx" port="443" method="GET" useragent="#CGI.HTTP_USER_AGENT#">
</cfhttp>

<cfhttp url="https://www.humanservices-t.state.pa.us/siteminderagent/forms/login.fcc" method="POST" useragent="#CGI.HTTP_USER_AGENT#" redirect="no">
	
	<cfhttpparam name="header" type="formField" value="#cfhttp.header#">
	<cfhttpparam name="USER" type="formField" value="b-ggreenberg">
	<cfhttpparam name="PASSWORD" type="formField" value="Password##1">
	<cfhttpparam name="Target" type="formField" value="https://www.humanservices-t.state.pa.us/compass.web/MenuItems/CPSystemCompatibility.aspx">
</cfhttp>

<cfhttp url="https://www.humanservices-t.state.pa.us/compass.web/MenuItems/CPSystemCompatibility.aspx" method="POST" useragent="#CGI.HTTP_USER_AGENT#" redirect="no">
	<cfhttpparam name="header" type="formField" value="#cfhttp.header#">
</cfhttp>


<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RiaClient/CPD/CompassCPD.html" method="POST" useragent="#CGI.HTTP_USER_AGENT#">
	<cfhttpparam name="header" type="formField" value="#cfhttp.header#">
</cfhttp>

<cfdump var="#cfhttp#">
--->


<!---
<cfset objHttpSession = CreateObject(
"component",
"CFHTTPSession"
).Init()
/>
 --->
 
<!---
Make the first call to login into Dig Deep Fitness,
the iPhone fitness application.

<cfset objResponse = objHttpSession
.NewRequest( "https://www.humanservices-t.state.pa.us/siteminderagent/forms/login.fcc" )
.AddFormField( "USER", "b-ggreenberg" )
.AddFormField( "PASSWORD", "Password##1" )
.Post()
/>
 --->
<!---
Make the second to get the list of exercises (which will
only be successful if the session is maintained across
CFHTTP calls.

<cfset objResponse = objHttpSession
.NewRequest( "http://www.digdeepfitness.com/index.cfm" )
.AddUrl( "go", "exercises" )
.Get()
/>
--->
 
<!--- Output the resposne content. 
<cfdump var="#objResponse#">--->
<cffunction
	name="ParseHTMLTag"
	access="public"
	returntype="struct"
	output="false"
	hint="Parses the given HTML tag into a ColdFusion struct.">
 
	<!--- Define arguments. --->
	<cfargument
		name="HTML"
		type="string"
		required="true"
		hint="The raw HTML for the tag."
		/>
 
	<!--- Define the local scope. --->
	<cfset var LOCAL = StructNew() />
 
	<!--- Create a structure for the taget tag data. --->
	<cfset LOCAL.Tag = StructNew() />
 
	<!--- Store the raw HTML into the tag. --->
	<cfset LOCAL.Tag.HTML = ARGUMENTS.HTML />
 
	<!--- Set a default name. --->
	<cfset LOCAL.Tag.Name = "" />
 
	<!---
		Create an structure for the attributes. Each
		attribute will be stored by it's name.
	--->
	<cfset LOCAL.Tag.Attributes = StructNew() />
 
 
	<!---
		Create a pattern to find the tag name. While it
		might seem overkill to create a pattern just to
		find the name, I find it easier than dealing with
		token / list delimiters.
	--->
	<cfset LOCAL.NamePattern = CreateObject(
		"java",
		"java.util.regex.Pattern"
		).Compile(
			"^<(\w+)"
			)
		/>
 
	<!--- Get the matcher for this pattern. --->
	<cfset LOCAL.NameMatcher = LOCAL.NamePattern.Matcher(
		ARGUMENTS.HTML
		) />
 
	<!---
		Check to see if we found the tag. We know there
		can only be ONE tag name, so using an IF statement
		rather than a conditional loop will help save us
		processing time.
	--->
	<cfif LOCAL.NameMatcher.Find()>
 
		<!--- Store the tag name in all upper case. --->
		<cfset LOCAL.Tag.Name = UCase(
			LOCAL.NameMatcher.Group( 1 )
			) />
 
	</cfif>
 
 
	<!---
		Now that we have a tag name, let's find the
		attributes of the tag. Remember, attributes may
		or may not have quotes around their values. Also,
		some attributes (while not XHTML compliant) might
		not even have a value associated with it (ex.
		disabled, readonly).
	--->
	<cfset LOCAL.AttributePattern = CreateObject(
		"java",
		"java.util.regex.Pattern"
		).Compile(
			"\s+(\w+)(?:\s*=\s*(""[^""]*""|[^\s>]*))?"
			)
		/>
 
	<!--- Get the matcher for the attribute pattern. --->
	<cfset LOCAL.AttributeMatcher = LOCAL.AttributePattern.Matcher(
		ARGUMENTS.HTML
		) />
 
 
	<!---
		Keep looping over the attributes while we
		have more to match.
	--->
	<cfloop condition="LOCAL.AttributeMatcher.Find()">
 
		<!--- Grab the attribute name. --->
		<cfset LOCAL.Name = LOCAL.AttributeMatcher.Group( 1 ) />
 
		<!---
			Create an entry for the attribute in our attributes
			structure. By default, just set it the empty string.
			For attributes that do not have a name, we are just
			going to have to store this empty string.
		--->
		<cfset LOCAL.Tag.Attributes[ LOCAL.Name ] = "" />
 
		<!---
			Get the attribute value. Save this into a scoped
			variable because this might return a NULL value
			(if the group in our name-value pattern failed
			to match).
		--->
		<cfset LOCAL.Value = LOCAL.AttributeMatcher.Group( 2 ) />
 
		<!---
			Check to see if we still have the value. If the
			group failed to match then the above would have
			returned NULL and destroyed our variable.
		--->
		<cfif StructKeyExists( LOCAL, "Value" )>
 
			<!---
				We found the attribute. Now, just remove any
				leading or trailing quotes. This way, our values
				will be consistent if the tag used quoted or
				non-quoted attributes.
			--->
			<cfset LOCAL.Value = LOCAL.Value.ReplaceAll(
				"^""|""$",
				""
				) />
 
			<!---
				Store the value into the attribute entry back
				into our attributes structure (overwriting the
				default empty string).
			--->
			<cfset LOCAL.Tag.Attributes[ LOCAL.Name ] = LOCAL.Value />
 
		</cfif>
 
	</cfloop>
 
 
	<!--- Return the tag. --->
	<cfreturn LOCAL.Tag />
</cffunction>

<cffunction
	name="GetResponseCookies"
	access="public"
	returntype="struct"
	output="false"
	hint="This parses the response of a CFHttp call and puts the cookies into a struct.">
 
	<!--- Define arguments. --->
	<cfargument
		name="Response"
		type="struct"
		required="true"
		hint="The response of a CFHttp call."
		/>
 
	<!--- Define the local scope. --->
	<cfset var LOCAL = StructNew() />
 
	<cfset LOCAL.Cookies = StructNew() />
 
	<cfif NOT StructKeyExists(
		ARGUMENTS.Response.ResponseHeader,
		"Set-Cookie"
		)>
 
		<cfreturn LOCAL.Cookies />
	</cfif>
 
	<cfset LOCAL.ReturnedCookies = ARGUMENTS.Response.ResponseHeader[ "Set-Cookie" ] />
 
	<!--- Loop over the returned cookies struct. --->
	<cfloop
		item="LOCAL.CookieIndex"
		collection="#LOCAL.ReturnedCookies#">

		<cfset LOCAL.CookieString = LOCAL.ReturnedCookies[ LOCAL.CookieIndex ] />
 
		<cfloop
			index="LOCAL.Index"
			from="1"
			to="#ListLen( LOCAL.CookieString, ';' )#"
			step="1">
 
			<!--- Get the name-value pair. --->
			<cfset LOCAL.Pair = ListGetAt(
				LOCAL.CookieString,
				LOCAL.Index,
				";"
				) />

			<cfset LOCAL.Name = ListFirst( LOCAL.Pair, "=" ) />
 
			<cfif (ListLen( LOCAL.Pair, "=" ) GT 1)>
				<!--- Grab the rest of the list. --->
				<cfset LOCAL.Value = ListRest( LOCAL.Pair, "=" ) />
			<cfelse>
 				<cfset LOCAL.Value = "" />
			</cfif>
 
			<cfif (LOCAL.Index EQ 1)>
				<cfset LOCAL.Cookies[ LOCAL.Name ] = StructNew() />
				<cfset LOCAL.Cookie = LOCAL.Cookies[ LOCAL.Name ] />
				<!--- Store the value of this cookie. --->
				<cfset LOCAL.Cookie.Value = LOCAL.Value />
				<cfset LOCAL.Cookie.Attributes = StructNew() />
			<cfelse>
				<cfset LOCAL.Cookie.Attributes[ LOCAL.Name ] = LOCAL.Value />
			</cfif>
 
		</cfloop>
	</cfloop>
 
	<!--- Return the cookies. --->
	<cfreturn LOCAL.Cookies />
</cffunction>

<!---<cfhttp url="https://www.humanservices-t.state.pa.us/compass.web/CMHOM.aspx" method="HEAD" userAgent="#CGI.HTTP_USER_AGENT#" redirect="no" result="getCookie">
<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
<cfhttpparam type="Header" name="TE" value="deflate;q=0">
</cfhttp>
<cfset objCookies = GetResponseCookies( getCookie ) />
<cfdump var="#getCookie#"><cfabort>--->
<!--- perform login --->
<cfhttp url="https://www.humanservices-t.state.pa.us/siteminderagent/forms/login.fcc" method="POST" useragent="#CGI.HTTP_USER_AGENT#" redirect="no" result="loginResult" username="b-ggreenberg" password="Password##1" port="443" compression="none">

	 <!--- Loop over the cookies we found. 
	<cfloop item="strCookie" collection="#objCookies#">
		<cfhttpparam
			type="COOKIE"
			name="#strCookie#"
			value="#objCookies[strCookie].Value#"
		/>
	</cfloop>--->
	
	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
	<cfhttpparam type="Header" name="TE" value="deflate;q=0">
	<cfhttpparam name="__VIEWSTATE" type="formField" value="">
	<cfhttpparam name="USER" type="formField" value="b-ggreenberg">
	<cfhttpparam name="PASSWORD" type="formField" value="Password##1">
	<cfhttpparam name="Target" type="formField" value="https://www.humanservices-t.state.pa.us/compass.web/MenuItems/CPSystemCompatibility.aspx">
</cfhttp>

<cfset headers = loginResult.header>
<cfset objCookies = GetResponseCookies( loginResult ) />
<!---<cfdump var="#loginResult#"><cfabort>--->

<cfhttp url="#loginResult.responseheader.location#" method="POST" useragent="#CGI.HTTP_USER_AGENT#" redirect="no" result="compatibilityResult" username="b-ggreenberg" password="Password##1" port="443">

	<cfloop item="strCookie" collection="#objCookies#">
		<cfhttpparam
			type="COOKIE"
			name="#strCookie#"
			value="#objCookies[strCookie].Value#"
		/>
	</cfloop>
	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
	<cfhttpparam type="Header" name="TE" value="deflate;q=0">
	<cfhttpparam name="__VIEWSTATE" type="formField" value="#objCookies.SMSESSION.value#">
</cfhttp>
<!---<cfdump var="#compatibilityResult#"><cfabort>--->

<!---  Extract form names and variables from HTML in cfhttp.filecontent--->
<cfset results = reMatchNoCase("<input\s+[^>]*>", compatibilityResult.fileContent)>

<!--- Extract the form action --->
<cfset formActionStruct = ParseHTMLTag(Trim(compatibilityResult.fileContent))>
<cfset formAction = formActionStruct.attributes.action>

<!---<cfdump var="#results#"><cfabort>--->
<cfhttp url="#formAction#" method="POST" useragent="#CGI.HTTP_USER_AGENT#" redirect="no" result="CMHOMResult" username="b-ggreenberg" password="Password##1" port="443">

	<cfloop item="strCookie" collection="#objCookies#">
		<cfhttpparam
			type="COOKIE"
			name="#strCookie#"
			value="#objCookies[strCookie].Value#"
		/>
	</cfloop>
	<!--- Parse html and add to cfhttpparam --->
	<cfloop from="1" to="#ArrayLen(results)#" index="i">
		<!---<cfdump var="#ParseHTMLTag(Trim(results[i]))#"/>--->
		<cfset formStruct = ParseHTMLTag(Trim(results[i]))>
		<cfif IsDefined('formStruct.attributes.name')>
			<cfset formName = formStruct.attributes.name>
		<cfelse>
			<cfset formName = formStruct.attributes.value>
		</cfif>
		<cfset formValue = formStruct.attributes.value>
		
		<cfhttpparam name="#formName#" type="formField" value="#formValue#">
	</cfloop>
	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
	<cfhttpparam type="Header" name="TE" value="deflate;q=0">
	<cfhttpparam name="__VIEWSTATE" type="formField" value="#objCookies.SMSESSION.value#">
</cfhttp>
<cfdump var="#CMHOMResult#"><cfabort>


<cfsavecontent variable="soapBody">
	<cfoutput>	
	<?xml version="1.0" encoding="utf-8"?>
	<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
	   <soapenv:Header/>
	   <soapenv:Body>
	      <ns:CPUserRequest>
	         <!--Optional:-->
	         <ns:CPUserId>AAA1</ns:CPUserId>
	      </ns:CPUserRequest>
	   </soapenv:Body>
	</soapenv:Envelope>
	</cfoutput>
</cfsavecontent>
 
<cfhttp 
	url="https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc/secured"
	method="POST"
	result="httpResponse"
	useragent="#CGI.http_user_agent#" username="b-ggreenberg" password="Password##1" port="443">
	
	<CFHTTPPARAM type="HEADER" name="Host" value="www.humanservices-t.state.pa.us">
	<cfhttpparam name="Content-Type" type="header" value="content-type: text/xml; charset='UTF-8';">
    <cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/CredentialsManagementService/CPUserRequest">
    <cfhttpparam type="header" name="content-length" value="#len(trim(soapBody))#"> 
    <cfhttpparam type="XML" value="#trim(soapBody)#" encoded="no">
	<cfhttpparam type="Header" name="TE" value="deflate;q=0"> 
	<CFHTTPPARAM type="CGI" name="HTTP_ACCEPT" value="*/*">
	<CFHTTPPARAM type="CGI" name="HTTP_ACCEPT_LANGUAGE" value="en">
	<CFHTTPPARAM TYPE="HEADER" NAME="referer" VALUE="https://www.humanservices-t.state.pa.us/compass.web/MenuItems/CPSystemCompatibility.aspx">
	<CFHTTPPARAM type="HEADER" name="Connection" value="Keep-Alive">
	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
	<cfhttpparam type="Header" name="TE" value="deflate;q=0">


 	<!--- Loop over the cookies we found. --->
	<cfloop item="strCookie" collection="#objCookies#">

		<cfhttpparam
			type="COOKIE"
			name="#strCookie#"
			value="#objCookies[strCookie].Value#"
		/>
	 
	</cfloop>
	  <!---<cfhttpparam
   type="cookie"
   name="SMSESSION"
   value="#Trim(objcookies.smsession.value)#"
  />--->
	<!---<cfhttpparam type="COOKIE" name="SMSESSION" value="SMSESSION=#objCookies.SMSESSION.value#" />
	
	<cfhttpparam
		type="header"
		name="SOAPAction"
		value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/CredentialsManagementService/CPUserRequest"
		/>
 
	<cfhttpparam
		type="xml"
		value="#trim(soapBody)#"
		/>--->
 
</cfhttp>

 
 <cfdump var="#httpResponse#">

<cfif find( "200", httpResponse.statusCode )>
 
	<!--- Parse the XML SOAP response. --->
	<cfset soapResponse = xmlParse( httpResponse.fileContent ) />
 
 <cfdump  var="#soapResponse#">
</cfif>


