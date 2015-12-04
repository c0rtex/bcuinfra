<!--- Set initial variables for struct that will be passed in to the function --->
	<cfset soapData = StructNew()>
	<!--- Authentication variables--->
	<cfset soapData.USER = 'b-sengels'>
	<cfset soapData.PASSWORD = 'Password##1'>
	<cfset soapData.CPUserId = 'AAA2'>
	
	<!--- Application variables--->
	<cfset soapData.FirstName = 'Michael'>
	<cfset soapData.MiddleInitial = 'B'>
	<cfset soapData.LastName = 'Tester'>
	<cfset soapData.SpouseFirstName = 'Katy'>
	<cfset soapData.SpouseMiddleInitial = 'B'>
	<cfset soapData.SpouseLastName = 'Tester'>
	<cfset soapData.City = 'Camp Hill'>
	<cfset soapData.State = 'PA'>
	<cfset soapData.AddressLine1 = '123 Main St'>
	<cfset soapData.AddressLine2 = ''>
	<cfset soapData.ZIP = '17011'>
	<cfset soapData.DateOfBirth = '1930-01-05'>
	<cfset soapData.Sex = 'M'>
	<cfset soapData.SpouseDateOfBirth = '1930-01-05'>
	<cfset soapData.SpouseSex = 'F'>
	<cfset soapData.BenefitName = 'FS'>
	
	<cfset soapData.CommunityPartnerInitials = "CP">
	<cfset soapData.PrintLanguage = 1>
	<cfset soapData.PrintStatus = "AE">
	<cfset soapData.HouseholdLanguagePreference = "01">
	<cfset soapData.RequiredInterpreter = "N">
	<cfset soapData.IsApplicationESigned = "Y">
	<cfset soapData.AgreedToRightsAndResponsibilities = "Y">
	<cfset soapData.County = "01">
	<cfset soapData.SchoolDistrict = "01110">
	<cfset soapData.ApplicationType = "W">
	<cfset soapData.Applicationlanguage = 1>
	
	<cfset SNAPWebServiceCall(soapData)>

<cffunction name="SNAPWebServiceCall" access="public" returntype="struct" output="true" 
	hint="Create SNAP Web Service Call and return struct of result">
	
	<cfargument name="soapData" default="" required="true" type="struct">
	
	<!--- Initially set userProcessed to FALSE; set to TRUE if each step proceeds without error and each data element validates --->
	<cfset arguments.soapData.userProcessed = FALSE>
	
		<!--- perform login --->
		<cfhttp url="https://www.humanservices-t.state.pa.us/siteminderagent/forms/login.fcc" method="POST" useragent="#CGI.HTTP_USER_AGENT#" redirect="no" result="loginResult" port="443">
			<cfhttpparam name="USER" type="formField" value="#arguments.soapData.USER#">
			<cfhttpparam name="PASSWORD" type="formField" value="#arguments.soapData.PASSWORD#">
			<cfhttpparam name="Target" type="formField" value="https://www.humanservices-t.state.pa.us/compass.web/MenuItems/CPSystemCompatibility.aspx">
		</cfhttp>
		<cfset headers = loginResult.header>
		<cfset objCookies = GetResponseCookies( loginResult ) />
		
		<!--- Traverse the cookies and build SMString consisting SMSESSION=thekey --->
		<cfloop item="strCookie" collection="#objCookies#">
		    <cfif trim(strCookie) eq "SMSESSION">
		      <cfset SMString = "SMSESSION=#objCookies[strCookie].Value#">
		    </cfif>
		</cfloop>
		
		<!--- BEGIN WEB SERVICE CALL - STEP ONE --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			   <soapenv:Header/>
			   <soapenv:Body>
			      <ns:CPUserRequest>
			         <!--Optional:-->
			         <ns:CPUserId>#arguments.soapData.CPUserId#</ns:CPUserId>
			      </ns:CPUserRequest>
			   </soapenv:Body>
			</soapenv:Envelope>
			</cfoutput>
		</cfsavecontent>
		 
		<cfhttp url="https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc/Secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/CredentialsManagementService/CPUserRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!--- Put returned data in to a session scoped struct --->
			<cfset arguments.soapData.CpUserId = 			soapResponseStruct.CPUserResponse.CPUserData.CpUserId>
			<cfset arguments.soapData.CpUserFirstName = 	soapResponseStruct.CPUserResponse.CPUserData.CpUserFirstName>
			<cfset arguments.soapData.CpUserLastName = 		soapResponseStruct.CPUserResponse.CPUserData.CpUserLastName>
			<cfset arguments.soapData.CurrentDate = 		soapResponseStruct.CPUserResponse.CPUserData.CurrentDate>
			<cfset arguments.soapData.OrganizationId = 		soapResponseStruct.CPUserResponse.CPUserData.OrganizationId>
			<cfset arguments.soapData.Role = 				soapResponseStruct.CPUserResponse.CPUserData.Role.string>
			<cfset arguments.soapData.SponsorId = 			soapResponseStruct.CPUserResponse.CPUserData.SponsorId>
			<cfset arguments.soapData.UserOrgLocation = 	soapResponseStruct.CPUserResponse.CPUserData.UserOrgLocation.string>
			
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step One.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML"><cfabort>--->
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step One.</P> 
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP ONE --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP TWO :: Check for Food Stamps availability --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:BenefitsRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:BenefitRequestData>
			        <ns0:ApplicationLanguage>1</ns0:ApplicationLanguage>
			        <ns0:ModuleName>AFS_Citizen</ns0:ModuleName>
			        <ns0:RenewalType xsi:nil="true"/>
			      </ns0:BenefitRequestData>
			    </ns0:BenefitsRequest>
			  </SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ReferenceTableLookupService.svc" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/ReferenceTableLookupService/BenefitsRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!--- Check for LIHEAP availability :: find the "FS" key in the returned array --->
			<cfset arguments.soapData.foodstampProgramAvailability = FALSE>
			<cfset liheapArr = soapResponseStruct.BenefitsResponse.AvailableBenefitCollection.AvailableBenefitDC>
			<cfloop from="1" to="#ArrayLen(soapResponseStruct.BenefitsResponse.AvailableBenefitCollection.AvailableBenefitDC)#" index="i">
				<cfif soapResponseStruct.BenefitsResponse.AvailableBenefitCollection.AvailableBenefitDC[i].key EQ 'FS'>
					<cfset arguments.soapData.foodstampProgramAvailability = 
						soapResponseStruct.BenefitsResponse.AvailableBenefitCollection.AvailableBenefitDC[i].ProgramAvailability>
				</cfif>
			</cfloop>
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Two.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
			<!---<cfdump var="#soapData#" label="SESSION SOAP data">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML"><cfabort>--->
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Two.</P> 
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP TWO :: Check for Food Stamps availability --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP THREE :: Initialize the application --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:InitializeRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:InitializationData>
			        <ns0:CreatorType>BP</ns0:CreatorType>
			        <ns0:ApplicationType>W</ns0:ApplicationType>
			        <ns0:ApplicationLanguage>1</ns0:ApplicationLanguage>
			        <ns0:BusinessFunctionOrigin>C</ns0:BusinessFunctionOrigin>
			        <ns0:ProviderNumber xsi:nil="true"/>
			        <ns0:CPOrganizationId>#arguments.soapData.OrganizationId#</ns0:CPOrganizationId>
			        <ns0:CpUserId>#arguments.soapData.CpUserId#</ns0:CpUserId>
			        <ns0:ScreeningNumber>0</ns0:ScreeningNumber>
			      </ns0:InitializationData>
			    </ns0:InitializeRequest>
			  </SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ApplicationProcess.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/ApplicationProcessService/InitializeRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<cfset arguments.soapData.ApplicationDataXML = 	soapResponseStruct.InitializeResponse.InitializeApplicationResponseData.ApplicationDataXML>
			<cfset arguments.soapData.ApplicationNumber = 	soapResponseStruct.InitializeResponse.InitializeApplicationResponseData.ApplicationNumber>
			<cfset arguments.soapData.IndivXmlTemplate = 		soapResponseStruct.InitializeResponse.InitializeApplicationResponseData.IndivXmlTemplate>
			<cfset arguments.soapData.SecurityToken = 		soapResponseStruct.InitializeResponse.InitializeApplicationResponseData.SecurityToken>
			<cfset arguments.soapData.SecurityToken_attributes = 	TRUE>
			<cfset arguments.soapData.SystemDate = 			soapResponseStruct.InitializeResponse.InitializeApplicationResponseData.SystemDate>
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Three.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data - Step 3">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT - Step 3">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML - Step 3"><cfabort>--->
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Three.</P>
			<cfset arguments.soapData.userProcessed = FALSE> 
		</cfif>
		
		<!--- END WEB SERVICE CALL - STEP THREE :: Initialize the application --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP FOUR :: Save application credentials --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:SaveApplicationCredentialsRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
			      <ns0:SaveCredentialsInformation>
			        <ns0:CreatorType>BP</ns0:CreatorType>
			        <ns0:ForgotPassword>false</ns0:ForgotPassword>
			        <ns0:HintCollection>
			          <ns0:HintDC>
			            <ns0:HintAnswer>Answer One</ns0:HintAnswer>
			            <ns0:HintQuestionCode>17</ns0:HintQuestionCode>
			          </ns0:HintDC>
			          <ns0:HintDC>
			            <ns0:HintAnswer>Answer Two</ns0:HintAnswer>
			            <ns0:HintQuestionCode>16</ns0:HintQuestionCode>
			          </ns0:HintDC>
			          <ns0:HintDC>
			            <ns0:HintAnswer>Answer Three</ns0:HintAnswer>
			            <ns0:HintQuestionCode>05</ns0:HintQuestionCode>
			          </ns0:HintDC>
			        </ns0:HintCollection>
			        <ns0:Password>#arguments.soapData.PASSWORD#</ns0:Password>
			      </ns0:SaveCredentialsInformation>
			      <ns0:SecurityToken xsi:nil="true"/>
			    </ns0:SaveApplicationCredentialsRequest>
			  </SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/CredentialsManagementService.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/CredentialsManagementService/SaveApplicationCredentialsRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<cfset arguments.soapData.SaveApplicationCredentialsResponse = soapResponseStruct.SaveApplicationCredentialsResponse.Completed>
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Four.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
			<!---<cfdump var="#soapData#" label="SESSION SOAP data - Step 4">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT - Step 4">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML - Step 4"><cfabort>--->
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Four.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP FOUR :: Save application credentials --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP FIVE :: Get the server generated Individual numbers for the individuals in the application household. --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
				<SOAP-ENV:Body>
				<ns0:SaveIndividualInformationRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
				  <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
				  <ns0:SecurityToken xsi:nil="true"/>
				  <ns0:IndividualCollection>
				    <ns0:IndividualIdentifierDC>
				      <ns0:IndividualNumber xsi:nil="true"/>
				      <ns0:SequenceNumber>0</ns0:SequenceNumber>
				    </ns0:IndividualIdentifierDC>
				    <ns0:IndividualIdentifierDC>
				      <ns0:IndividualNumber xsi:nil="true"/>
				      <ns0:SequenceNumber>1</ns0:SequenceNumber>
				    </ns0:IndividualIdentifierDC>
				  </ns0:IndividualCollection>
				</ns0:SaveIndividualInformationRequest>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/IndividualManagementService.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/IndividualManagementService/SaveIndividualInformationRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!--- arguments.soapData.IndividualIdentifierDC is an array containing the IndividualNumber and SequenceNumber --->
			<cfset arguments.soapData.IndividualIdentifierDC = soapResponseStruct.SaveIndividualInformationResponse.IndividualIdentifierCollection.IndividualIdentifierDC>
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Five.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data - Step 5">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT - Step 5">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML - Step 5"><cfabort>--->
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Five.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP FIVE :: Get the server generated Individual numbers for the individuals in the application household. --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP SIX :: Save the application XML --->
		<cfprocessingdirective suppresswhitespace="yes">
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
<cfoutput><?xml version="1.0" encoding="utf-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <SOAP-ENV:Body>
            <ns0:SaveRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
                  <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
                  <ns0:SecurityToken xsi:nil="true"/>
                  <ns0:ApplicationDetailsData>
                        <ns0:County>#arguments.soapData.County#</ns0:County>
                        <ns0:SchoolDistrict>#arguments.soapData.SchoolDistrict#</ns0:SchoolDistrict>
                        <ns0:ApplicationType>#arguments.soapData.ApplicationType#</ns0:ApplicationType>
                        <ns0:Applicationlanguage>#arguments.soapData.Applicationlanguage#</ns0:Applicationlanguage>
                        <ns0:PrintLanguage>#arguments.soapData.PrintLanguage#</ns0:PrintLanguage>
                        <ns0:PrintStatus>#arguments.soapData.PrintStatus#</ns0:PrintStatus>
                        <ns0:CPOrganizationId>#arguments.soapData.OrganizationId#</ns0:CPOrganizationId>
                        <ns0:CpUserId>#arguments.soapData.CpUserId#</ns0:CpUserId>
                        <ns0:NavigationMetaData>tab=0&amp;crd=0&amp;sec=7&amp;GS=Green&amp;HH=Green&amp;BN=Green&amp;ID=Green&amp;IN=Green&amp;EX=Green&amp;INS=Green&amp;WQ=Green&amp;RS=White&amp;SMR=White&amp;NS=White&amp;VER=White&amp;SUB=White</ns0:NavigationMetaData>
                        <ns0:ApplicationDataXml>
                        
                        
                        
                        
                        
                        
                        
                              &lt;CompassApplication xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&gt;
                                    &lt;ApplicationNumber&gt;#arguments.soapData.ApplicationNumber#&lt;/ApplicationNumber&gt;
                                    &lt;Household&gt;
                                          &lt;OtherHouseholdSchoolDistrict xsi:nil="true"/&gt;
                                          &lt;Qualification&gt;
                                                &lt;ReceivedTANFinPasts6Months&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/ReceivedTANFinPasts6Months&gt;
                                                &lt;HasAnyoneReceivedSSIInThePast&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/HasAnyoneReceivedSSIInThePast&gt;
                                                &lt;ReceivingTANF&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/ReceivingTANF&gt;
                                                &lt;AnyOneHasPaidMedicalBills&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/AnyOneHasPaidMedicalBills&gt;
                                                &lt;ReceivingFS&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/ReceivingFS&gt;
                                                &lt;DoesAnyOneHavePermanentDisabilityOrSpecialHealthCare&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/DoesAnyOneHavePermanentDisabilityOrSpecialHealthCare&gt;
                                                &lt;HasAnyOneReceivedSSDInThePast&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasAnyOneReceivedSSDInThePast&gt;
                                                &lt;AnyOneHasUnpaidMedicalBills&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/AnyOneHasUnpaidMedicalBills&gt;
                                                &lt;AnyOneReceivingProtectiveServicesAsVictimOfDomesticViolence xsi:nil="true"/&gt;
                                                &lt;AnyOneReceivingTreatmentForAlcoholOrDrugProblem xsi:nil="true"/&gt;
                                                &lt;AnyOneDisabledBlindSeriouslyIllOrHasAlcoholOrDrugProblem xsi:nil="true"/&gt;
                                          &lt;/Qualification&gt;
                                          &lt;CCISOffice&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/CCISOffice&gt;
                                          &lt;WhoHasBeenConvictedAFelony&gt;
                                                &lt;IndividualNumbers/&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/WhoHasBeenConvictedAFelony&gt;
                                          &lt;DistrictOffice&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/DistrictOffice&gt;
                                          &lt;NumberOfMonthsInPA xsi:nil="true"/&gt;
                                          &lt;Resources&gt;
                                                &lt;HasMemberReceivedLongTermCare&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMemberReceivedLongTermCare&gt;
                                                &lt;AnyoneClosedOrDepletedAccounts&gt;
                                                      &lt;ClosedAccounts/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyoneClosedOrDepletedAccounts&gt;
                                                &lt;AnyOneEstablishTrust&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyOneEstablishTrust&gt;
                                                &lt;AnyoneExpectingAnyResources&gt;
                                                      &lt;ExpectingMoneyCollection/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyoneExpectingAnyResources&gt;
                                                &lt;AnyoneHaveCash&gt;
                                                      &lt;CashCollection/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyoneHaveCash&gt;
                                                &lt;AnyoneBuyingNonResidentProperty&gt;
                                                      &lt;NonResidentialProperties/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyoneBuyingNonResidentProperty&gt;
                                                &lt;HasMemberSoldTransferedProperty&gt;
                                                      &lt;SoldTransferredProperties/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMemberSoldTransferedProperty&gt;
                                                &lt;AnyOwnORBuyingVehicle&gt;
                                                      &lt;Vehicles/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyOwnORBuyingVehicle&gt;
                                                &lt;AnyoneHaveLifeInsurancePolicy&gt;
                                                      &lt;LifeInsuranceCollection/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyoneHaveLifeInsurancePolicy&gt;
                                                &lt;AnyoneOwnBurialSpaceORPlot&gt;
                                                      &lt;BurialSpaces/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyoneOwnBurialSpaceORPlot&gt;
                                                &lt;AnyoneHaveBurialORTrustAgreementWithBankORFuneralHome&gt;
                                                      &lt;BurialTrustAgreements/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/AnyoneHaveBurialORTrustAgreementWithBankORFuneralHome&gt;
                                          &lt;/Resources&gt;
                                          &lt;MobilePhoneNumber xsi:nil="true"/&gt;
                                          &lt;HaveYouReceivedBenefitsInPA xsi:nil="true"/&gt;
                                          &lt;FromHowManyYearsAtThisAddress xsi:nil="true"/&gt;
                                          &lt;WhoHasBeenIssuedASummons&gt;
                                                &lt;IndividualNumbers/&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/WhoHasBeenIssuedASummons&gt;
                                          &lt;WhoWasConvictedForWelfareFraud&gt;
                                                &lt;IndividualNumbers/&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/WhoWasConvictedForWelfareFraud&gt;
                                          &lt;ApplicantAddress&gt;
                                                &lt;City&gt;#arguments.soapData.City#&lt;/City&gt;
                                                &lt;State&gt;
                                                      &lt;Code&gt;#arguments.soapData.State#&lt;/Code&gt;
                                                &lt;/State&gt;
                                                &lt;AddressLine1&gt;#arguments.soapData.AddressLine1#&lt;/AddressLine1&gt;
                                                &lt;AddressLine2&gt;#arguments.soapData.AddressLine2#&lt;/AddressLine2&gt;
                                                &lt;ZIPExtension xsi:nil="true"/&gt;
                                                &lt;ZIP&gt;#arguments.soapData.ZIP#&lt;/ZIP&gt;
                                          &lt;/ApplicantAddress&gt;
                                          &lt;OtherCurrentHousingSituation xsi:nil="true"/&gt;
                                          &lt;IsWeatherizationSelected&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/IsWeatherizationSelected&gt;
                                          &lt;VerficationDocumentInformation&gt;
                                                &lt;Departments/&gt;
                                          &lt;/VerficationDocumentInformation&gt;
                                          &lt;FoodStampRepresentativeInformation&gt;
                                                &lt;FoodStampsRepresentativeAvailable xsi:nil="true"/&gt;
                                                &lt;FoodStampRepresentativeName xsi:nil="true"/&gt;
                                                &lt;FoodStampRepresentativeAddress&gt;
                                                      &lt;AddressLine2 xsi:nil="true"/&gt;
                                                      &lt;ZIPExtension xsi:nil="true"/&gt;
                                                      &lt;City xsi:nil="true"/&gt;
                                                      &lt;State&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/State&gt;
                                                      &lt;AddressLine1 xsi:nil="true"/&gt;
                                                      &lt;ZIP xsi:nil="true"/&gt;
                                                &lt;/FoodStampRepresentativeAddress&gt;
                                                &lt;SocialSecurityNumber xsi:nil="true"/&gt;
                                                &lt;PhoneNumber xsi:nil="true"/&gt;
                                          &lt;/FoodStampRepresentativeInformation&gt;
                                          &lt;InsuranceInformation&gt;
                                                &lt;HealthInsuranceForChildrenFromWork&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HealthInsuranceForChildrenFromWork&gt;
                                                &lt;DoesAnyoneHaveHealthInsurance&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/DoesAnyoneHaveHealthInsurance&gt;
                                                &lt;DidAnyoneApplyingForHaveHealthInsuranceInLast90Days&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/DidAnyoneApplyingForHaveHealthInsuranceInLast90Days&gt;
                                                &lt;DidAnyOfTheChildrenLoseInsuranceInPast6Months&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/DidAnyOfTheChildrenLoseInsuranceInPast6Months&gt;
                                                &lt;Insurances/&gt;
                                                &lt;DidTheyApplyForUnemploymentCompensation&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/DidTheyApplyForUnemploymentCompensation&gt;
                                                &lt;IndividualHaveToPayForChildren&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                &lt;/IndividualHaveToPayForChildren&gt;
                                                &lt;HasMemberCanGetInsuranceThroughJob&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMemberCanGetInsuranceThroughJob&gt;
                                                &lt;IndividualHaveToPayForIt&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                &lt;/IndividualHaveToPayForIt&gt;
                                          &lt;/InsuranceInformation&gt;
                                          &lt;WhoIsCurrentlyFleeingFromLawEnforcementOfficials&gt;
                                                &lt;IndividualNumbers/&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/WhoIsCurrentlyFleeingFromLawEnforcementOfficials&gt;
                                          &lt;PreviousAddress&gt;
                                                &lt;AddressLine2 xsi:nil="true"/&gt;
                                                &lt;ZIPExtension xsi:nil="true"/&gt;
                                                &lt;City xsi:nil="true"/&gt;
                                                &lt;State&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/State&gt;
                                                &lt;AddressLine1 xsi:nil="true"/&gt;
                                                &lt;ZIP xsi:nil="true"/&gt;
                                          &lt;/PreviousAddress&gt;
                                          &lt;AdmissionDate xsi:nil="true"/&gt;
                                          &lt;FromHowManyMonthsAtThisAddress xsi:nil="true"/&gt;
                                          &lt;County&gt;
                                                &lt;Code&gt;01&lt;/Code&gt;
                                          &lt;/County&gt;
                                          &lt;Expenses&gt;
                                                &lt;DidTheHouseholdGetEnergyAssistanceSinceOctoberFirst xsi:nil="true"/&gt;
                                                &lt;HasMemberPaysCareToAttendTraining&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMemberPaysCareToAttendTraining&gt;
                                                &lt;SharesWithNonMember/&gt;
                                                &lt;HasMembersPaysLegalFees&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMembersPaysLegalFees&gt;
                                                &lt;HasMemberDrivesOrPaysWorkTransportation&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMemberDrivesOrPaysWorkTransportation&gt;
                                                &lt;MealsIncludedInRent xsi:nil="true"/&gt;
                                                &lt;HasMembersPaysAlimonyToNonMember&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMembersPaysAlimonyToNonMember&gt;
                                                &lt;HasMembersPaysChildSupportToNonMember&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMembersPaysChildSupportToNonMember&gt;
                                                &lt;HasMemeberPayForChildcareOrDisabledAdultCareToGoToWork&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMemeberPayForChildcareOrDisabledAdultCareToGoToWork&gt;
                                                &lt;HasMemberPaysShelterOrUtilityExpenses&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMemberPaysShelterOrUtilityExpenses&gt;
                                                &lt;HouseHoldShareExpense xsi:nil="true"/&gt;
                                                &lt;UtilityExpense&gt;
                                                      &lt;FuelCostForHouse xsi:nil="true"/&gt;
                                                      &lt;UtilityOrFuelCompany&gt;
                                                            &lt;UtilityCompanyName xsi:nil="true"/&gt;
                                                            &lt;UtilityCompanyAccountNumber xsi:nil="true"/&gt;
                                                            &lt;Address&gt;
                                                                  &lt;AddressLine2 xsi:nil="true"/&gt;
                                                                  &lt;ZIPExtension xsi:nil="true"/&gt;
                                                                  &lt;City xsi:nil="true"/&gt;
                                                                  &lt;State&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/State&gt;
                                                                  &lt;AddressLine1 xsi:nil="true"/&gt;
                                                                  &lt;ZIP xsi:nil="true"/&gt;
                                                            &lt;/Address&gt;
                                                      &lt;/UtilityOrFuelCompany&gt;
                                                      &lt;UtilityCostOtherThanHeatingOrCooling xsi:nil="true"/&gt;
                                                      &lt;PrimaryHeatingSource&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/PrimaryHeatingSource&gt;
                                                      &lt;FuelDeliveryDate xsi:nil="true"/&gt;
                                                      &lt;Utilities&gt;
                                                            &lt;DoesAnyonePayForGas&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForGas&gt;
                                                            &lt;DoesAnyonePayForRentOrMortgage&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForRentOrMortgage&gt;
                                                            &lt;DoesAnyonePayForHomeInsurance&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForHomeInsurance&gt;
                                                            &lt;DoesAnyonePayForGarbage&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForGarbage&gt;
                                                            &lt;DoesAnyonePayForPropertyTaxes&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForPropertyTaxes&gt;
                                                            &lt;DoesAnyonePayForOilCoalWood&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForOilCoalWood&gt;
                                                            &lt;DoesAnyonePayForUtilityInstallationThisMonth&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForUtilityInstallationThisMonth&gt;
                                                            &lt;DoesAnyonePayForOtherUtilities&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForOtherUtilities&gt;
                                                            &lt;DoesAnyonePayForTelephone&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForTelephone&gt;
                                                            &lt;DoesAnyonePayForSewerage&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForSewerage&gt;
                                                            &lt;DoesAnyonePayForWater&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForWater&gt;
                                                            &lt;DoesAnyonePayForElectric&gt;
                                                                  &lt;Frequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/Frequency&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;Amount xsi:nil="true"/&gt;
                                                                  &lt;NetExpenseAmount xsi:nil="true"/&gt;
                                                            &lt;/DoesAnyonePayForElectric&gt;
                                                      &lt;/Utilities&gt;
                                                      &lt;SecondaryHeatingSource&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/SecondaryHeatingSource&gt;
                                                      &lt;BilledSeparatelyForHeatingOrCooling xsi:nil="true"/&gt;
                                                      &lt;PayForHeatingOrCooling xsi:nil="true"/&gt;
                                                &lt;/UtilityExpense&gt;
                                                &lt;HasMembersPaidMedicalLastNintyDays&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/HasMembersPaidMedicalLastNintyDays&gt;
                                          &lt;/Expenses&gt;
                                          &lt;CurrentHousingSituation&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/CurrentHousingSituation&gt;
                                          &lt;Income&gt;
                                                &lt;PastEmployment&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/PastEmployment&gt;
                                                &lt;NoIncomeExplanation xsi:nil="true"/&gt;
                                                &lt;DoesAnyoneReceiveFinancialAssistanceForDisability xsi:nil="true"/&gt;
                                                &lt;CurrentEmployment&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/CurrentEmployment&gt;
                                                &lt;OtherIncome&gt;
                                                      &lt;IndividualNumbers/&gt;
                                                      &lt;Code&gt;N&lt;/Code&gt;
                                                &lt;/OtherIncome&gt;
                                          &lt;/Income&gt;
                                          &lt;HousingAssistance&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/HousingAssistance&gt;
                                          &lt;FoodStamps&gt;
                                                &lt;TotalAssets xsi:nil="true"/&gt;
                                                &lt;SubmitShortApplication xsi:nil="true"/&gt;
                                                &lt;AnyoneMigrantWorker xsi:nil="true"/&gt;
                                                &lt;HasReceivedFoodStamps xsi:nil="true"/&gt;
                                                &lt;IncomeLowEnough xsi:nil="true"/&gt;
                                                &lt;SubmitImmediately xsi:nil="true"/&gt;
                                                &lt;ShelterLiving xsi:nil="true"/&gt;
                                                &lt;RentExceedsIncome xsi:nil="true"/&gt;
                                          &lt;/FoodStamps&gt;
                                          &lt;PreviousBenefitInformation&gt;
                                                &lt;AppliedORReceivedBenefitsInOtherState xsi:nil="true"/&gt;
                                                &lt;PreviousStateBenefitDescription xsi:nil="true"/&gt;
                                                &lt;PreviousCountyBenefitDescription xsi:nil="true"/&gt;
                                          &lt;/PreviousBenefitInformation&gt;
                                          &lt;HowtoContact&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/HowtoContact&gt;
                                          &lt;AdditionalInformation&gt;
                                                &lt;OptionalInformation xsi:nil="true"/&gt;
                                                &lt;RequiredInterpreter&gt;#arguments.soapData.RequiredInterpreter#&lt;/RequiredInterpreter&gt;
                                                &lt;LearnSource&gt;
                                                      &lt;Sources/&gt;
                                                      &lt;OtherLearnSource xsi:nil="true"/&gt;
                                                &lt;/LearnSource&gt;
                                                &lt;DoesAnyChildUnder21HaveParentNotLivingInHouseholdOrDeceased&gt;N&lt;/DoesAnyChildUnder21HaveParentNotLivingInHouseholdOrDeceased&gt;
                                                &lt;DoesAnyoneNeedHelpForChildSupportOrInsuranceFromAbsentRelative&gt;N&lt;/DoesAnyoneNeedHelpForChildSupportOrInsuranceFromAbsentRelative&gt;
                                                &lt;AnyOneHasASpouseNotLivingInHouseholdOrDeceased xsi:nil="true"/&gt;
                                          &lt;/AdditionalInformation&gt;
                                          &lt;CityTownship&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/CityTownship&gt;
                                          &lt;WhoIsTheSelfRelationshipIndividual&gt;
                                                &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
                                          &lt;/WhoIsTheSelfRelationshipIndividual&gt;
                                          &lt;DateMovedToPA xsi:nil="true"/&gt;
                                          &lt;WhoIsOnProbationORParole&gt;
                                                &lt;IndividualNumbers/&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/WhoIsOnProbationORParole&gt;
                                          &lt;OtherHouseholdLanguagePreference xsi:nil="true"/&gt;
                                          &lt;NursingHomeInformation&gt;
                                                &lt;Address&gt;
                                                      &lt;AddressLine2 xsi:nil="true"/&gt;
                                                      &lt;ZIPExtension xsi:nil="true"/&gt;
                                                      &lt;City xsi:nil="true"/&gt;
                                                      &lt;State&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/State&gt;
                                                      &lt;AddressLine1 xsi:nil="true"/&gt;
                                                      &lt;ZIP xsi:nil="true"/&gt;
                                                &lt;/Address&gt;
                                                &lt;PreviouslyLivedInNursingFacility xsi:nil="true"/&gt;
                                                &lt;NursingFacilityName xsi:nil="true"/&gt;
                                                &lt;NursingFacilityEndDate xsi:nil="true"/&gt;
                                                &lt;NursingFacilityStartDate xsi:nil="true"/&gt;
                                          &lt;/NursingHomeInformation&gt;
                                          &lt;FamilyHealthCareInformation&gt;
                                                &lt;DoctorOrClinicAddress&gt;
                                                      &lt;AddressLine2 xsi:nil="true"/&gt;
                                                      &lt;ZIPExtension xsi:nil="true"/&gt;
                                                      &lt;City xsi:nil="true"/&gt;
                                                      &lt;State&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/State&gt;
                                                      &lt;AddressLine1 xsi:nil="true"/&gt;
                                                      &lt;ZIP xsi:nil="true"/&gt;
                                                &lt;/DoctorOrClinicAddress&gt;
                                                &lt;NameOfDoctorOrClinic xsi:nil="true"/&gt;
                                          &lt;/FamilyHealthCareInformation&gt;
                                          &lt;PreviousPhoneNumber xsi:nil="true"/&gt;
                                          &lt;HouseholdLanguagePreference&gt;#arguments.soapData.HouseholdLanguagePreference#&lt;/HouseholdLanguagePreference&gt;
                                          &lt;HouseholdSchoolDistrict&gt;
                                                &lt;Code&gt;01110&lt;/Code&gt;
                                          &lt;/HouseholdSchoolDistrict&gt;
                                          &lt;WhoIsTheHeadOfHousehold&gt;
                                                &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
                                          &lt;/WhoIsTheHeadOfHousehold&gt;
                                          &lt;CurrentLivingSituation&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/CurrentLivingSituation&gt;
                                          &lt;DisqualifiedForAssistance xsi:nil="true"/&gt;
                                          &lt;AppliedBenefitsWithDifferentNameORSSN xsi:nil="true"/&gt;
                                          &lt;IsEveryoneApplyingForLI&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/IsEveryoneApplyingForLI&gt;
                                          &lt;BestTimeToCall xsi:nil="true"/&gt;
                                          &lt;DoYouChooseAnAuthorizedRepresentativeForFoodStampBenefits xsi:nil="true"/&gt;
                                          &lt;WorkPhone&gt;
                                                &lt;PhoneNumber xsi:nil="true"/&gt;
                                                &lt;PhoneExtension xsi:nil="true"/&gt;
                                          &lt;/WorkPhone&gt;
                                          &lt;OtherCityTownship xsi:nil="true"/&gt;
                                          &lt;AlternateMailingAddress&gt;
                                                &lt;AlternateAddressEffectiveDate xsi:nil="true"/&gt;
                                                &lt;Address&gt;
                                                      &lt;AddressLine2 xsi:nil="true"/&gt;
                                                      &lt;ZIPExtension xsi:nil="true"/&gt;
                                                      &lt;City xsi:nil="true"/&gt;
                                                      &lt;State&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/State&gt;
                                                      &lt;AddressLine1 xsi:nil="true"/&gt;
                                                      &lt;ZIP xsi:nil="true"/&gt;
                                                &lt;/Address&gt;
                                                &lt;IsThereAnAlternateMailingAddress xsi:nil="true"/&gt;
                                                &lt;IsTheAddressEffectiveImmediately xsi:nil="true"/&gt;
                                          &lt;/AlternateMailingAddress&gt;
                                          &lt;PreviousCountyrecordNumber xsi:nil="true"/&gt;
                                          &lt;EmailAddress xsi:nil="true"/&gt;
                                          &lt;NumberOfYearsInPA xsi:nil="true"/&gt;
                                          &lt;HomePhoneNumber xsi:nil="true"/&gt;
                                    &lt;/Household&gt;
                                    &lt;ApplicationInformation&gt;
                                          &lt;RenewalInformation xsi:nil="true"/&gt;
                                          &lt;LastSequenceNumberCreated&gt;3&lt;/LastSequenceNumberCreated&gt;
                                          &lt;Comments xsi:nil="true"/&gt;
                                          &lt;CommunityPartnerInformation&gt;
                                                &lt;CommunityPartnerRightsRevoked xsi:nil="true"/&gt;
                                                &lt;CommunityPartnerOrganizationID&gt;IDMUpgrade4530-1&lt;/CommunityPartnerOrganizationID&gt;
                                                &lt;CommunityPartnerLastUserID xsi:nil="true"/&gt;
                                                &lt;CommunityPartnerUserID&gt;b-kchetty&lt;/CommunityPartnerUserID&gt;
                                          &lt;/CommunityPartnerInformation&gt;
                                          &lt;ReferralIncomeScheduleIndicator&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/ReferralIncomeScheduleIndicator&gt;
                                          &lt;SubmitServiceTargets/&gt;
                                          &lt;PrintStatus&gt;#arguments.soapData.PrintStatus#&lt;/PrintStatus&gt;
                                          &lt;ContractorInformation&gt;
                                                &lt;ContractorName&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/ContractorName&gt;
                                                &lt;ContractorTypeSelection&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/ContractorTypeSelection&gt;
                                          &lt;/ContractorInformation&gt;
                                          &lt;RequiredTranslator xsi:nil="true"/&gt;
                                          &lt;OtherPrograms/&gt;
                                          &lt;ProviderInformation&gt;
                                                &lt;ProviderName&gt;IDM Upgrade&lt;/ProviderName&gt;
                                                &lt;FWProjectName xsi:nil="true"/&gt;
                                                &lt;CBOType&gt;TEST&lt;/CBOType&gt;
                                                &lt;FWProjectID xsi:nil="true"/&gt;
                                                &lt;ProviderType&gt;
                                                      &lt;Code&gt;C&lt;/Code&gt;
                                                &lt;/ProviderType&gt;
                                                &lt;FWContractorName xsi:nil="true"/&gt;
                                                &lt;ProviderNumber xsi:nil="true"/&gt;
                                                &lt;MedicalServiceType&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/MedicalServiceType&gt;
                                                &lt;StartDateForHealthCareCoverage xsi:nil="true"/&gt;
                                          &lt;/ProviderInformation&gt;
                                          &lt;CompassSubmitDate xsi:nil="true"/&gt;
                                          &lt;AgreedToRightsAndResponsibilities&gt;#arguments.soapData.AgreedToRightsAndResponsibilities#&lt;/AgreedToRightsAndResponsibilities&gt;
                                          &lt;IsApplicationESigned&gt;#arguments.soapData.IsApplicationESigned#&lt;/IsApplicationESigned&gt;
                                          &lt;Esignature&gt;
                                                &lt;Last4DigitsOfSSN xsi:nil="true"/&gt;
                                                &lt;CommunityPartnerInitials&gt;#arguments.soapData.CommunityPartnerInitials#&lt;/CommunityPartnerInitials&gt;
                                                &lt;ESignedIndividualNumber xsi:nil="true"/&gt;
                                                &lt;ESignatureAgreement&gt;
                                                      &lt;Code&gt;Y&lt;/Code&gt;
                                                &lt;/ESignatureAgreement&gt;
                                                &lt;EsignedNoSSNIndicator&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/EsignedNoSSNIndicator&gt;
                                                &lt;IsESignedIndividualEmancipatedMinor&gt;
                                                      &lt;Code xsi:nil="true"/&gt;
                                                &lt;/IsESignedIndividualEmancipatedMinor&gt;
                                          &lt;/Esignature&gt;
                                          &lt;CCSTAFFAPPIndicator xsi:nil="true"/&gt;
                                          &lt;EsignatureSelectionType&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/EsignatureSelectionType&gt;
                                          &lt;ApplicationOrigin&gt;
                                                &lt;Code&gt;C&lt;/Code&gt;
                                          &lt;/ApplicationOrigin&gt;
                                          &lt;LiheapProgramType&gt;
                                                &lt;Code xsi:nil="true"/&gt;
                                          &lt;/LiheapProgramType&gt;
                                          &lt;ReleaseNumber xsi:nil="true"/&gt;
                                          &lt;ApplicationLanguage&gt;
                                                &lt;Code&gt;1&lt;/Code&gt;
                                          &lt;/ApplicationLanguage&gt;
                                          &lt;ApplicationType&gt;
                                                &lt;Code&gt;W&lt;/Code&gt;
                                          &lt;/ApplicationType&gt;
                                          &lt;ApplicationStatus xsi:nil="true"/&gt;
                                          &lt;ReferralId xsi:nil="true"/&gt;
                                          &lt;MAWDInformation&gt;
                                                &lt;ModeOfPaymentForMAWD xsi:nil="true"/&gt;
                                                &lt;CoverageBeginForMAWD xsi:nil="true"/&gt;
                                          &lt;/MAWDInformation&gt;
                                          &lt;AppliedPrograms&gt;
                                                &lt;Program&gt;
                                                      &lt;IsThisARenewal&gt;N&lt;/IsThisARenewal&gt;
                                                      &lt;Code&gt;FS&lt;/Code&gt;
                                                      &lt;TargetSystems/&gt;
                                                      &lt;RoutingLocation&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/RoutingLocation&gt;
                                                &lt;/Program&gt;
                                                &lt;Program&gt;
                                                      &lt;IsThisARenewal&gt;N&lt;/IsThisARenewal&gt;
                                                      &lt;Code&gt;HC&lt;/Code&gt;
                                                      &lt;TargetSystems/&gt;
                                                      &lt;RoutingLocation&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/RoutingLocation&gt;
                                                &lt;/Program&gt;
                                          &lt;/AppliedPrograms&gt;
                                          &lt;PrintLanguage&gt;#arguments.soapData.PrintLanguage#&lt;/PrintLanguage&gt;
                                    &lt;/ApplicationInformation&gt;
                                    &lt;People&gt;
                                          &lt;AbsentRelatives/&gt;
                                          &lt;Individuals&gt;
                                                &lt;Individual&gt;
                                                      &lt;Qualification&gt;
                                                            &lt;TANForCashAssistance&gt;
                                                                  &lt;State&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/State&gt;
                                                            &lt;/TANForCashAssistance&gt;
                                                            &lt;WasSSIStoppedBecauseSocialSecurityIncreased xsi:nil="true"/&gt;
                                                            &lt;WasSSIStoppedBecauseSocialSecurityStarted xsi:nil="true"/&gt;
                                                      &lt;/Qualification&gt;
                                                      &lt;MaritalStatus&gt;
                                                            &lt;Code&gt;1&lt;/Code&gt;
                                                      &lt;/MaritalStatus&gt;
                                                      &lt;Citizenship&gt;
                                                            &lt;BirthCounty xsi:nil="true"/&gt;
                                                            &lt;OtherCountry xsi:nil="true"/&gt;
                                                            &lt;MothersMaidenFirstName xsi:nil="true"/&gt;
                                                            &lt;DateEnteredUS xsi:nil="true"/&gt;
                                                            &lt;BirthState&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/BirthState&gt;
                                                            &lt;BirthLastName xsi:nil="true"/&gt;
                                                            &lt;Country&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/Country&gt;
                                                            &lt;MothersMaidenLastName xsi:nil="true"/&gt;
                                                            &lt;BirthFirstName xsi:nil="true"/&gt;
                                                            &lt;Identification&gt;
                                                                  &lt;LicensedState&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/LicensedState&gt;
                                                                  &lt;DriversLicenceNumberOrStateId xsi:nil="true"/&gt;
                                                                  &lt;Name xsi:nil="true"/&gt;
                                                            &lt;/Identification&gt;
                                                            &lt;Sponsor&gt;
                                                                  &lt;Address&gt;
                                                                        &lt;AddressLine2 xsi:nil="true"/&gt;
                                                                        &lt;ZIPExtension xsi:nil="true"/&gt;
                                                                        &lt;City xsi:nil="true"/&gt;
                                                                        &lt;State&gt;
                                                                              &lt;Code xsi:nil="true"/&gt;
                                                                        &lt;/State&gt;
                                                                        &lt;AddressLine1 xsi:nil="true"/&gt;
                                                                        &lt;ZIP xsi:nil="true"/&gt;
                                                                  &lt;/Address&gt;
                                                                  &lt;MiddleInitial xsi:nil="true"/&gt;
                                                                  &lt;LastName xsi:nil="true"/&gt;
                                                                  &lt;HaveASponsor xsi:nil="true"/&gt;
                                                                  &lt;Type xsi:nil="true"/&gt;
                                                                  &lt;SponsorOrganizationName xsi:nil="true"/&gt;
                                                                  &lt;FirstName xsi:nil="true"/&gt;
                                                            &lt;/Sponsor&gt;
                                                            &lt;INSSection xsi:nil="true"/&gt;
                                                            &lt;CitizenshipCode&gt;1&lt;/CitizenshipCode&gt;
                                                            &lt;BirthCity xsi:nil="true"/&gt;
                                                            &lt;AlienRegistrationNumber xsi:nil="true"/&gt;
                                                      &lt;/Citizenship&gt;
                                                      &lt;IsThisPersonAStudent&gt;N&lt;/IsThisPersonAStudent&gt;
                                                      &lt;Income&gt;
                                                            &lt;OtherIncomeSources/&gt;
                                                            &lt;PastEmployment&gt;
                                                                  &lt;MonthlyIncome xsi:nil="true"/&gt;
                                                                  &lt;PayRate xsi:nil="true"/&gt;
                                                                  &lt;PhoneNumber xsi:nil="true"/&gt;
                                                                  &lt;NumberOfHoursWorkedPerWeek xsi:nil="true"/&gt;
                                                                  &lt;EmploymentStartDate xsi:nil="true"/&gt;
                                                                  &lt;IncomeFrequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/IncomeFrequency&gt;
                                                                  &lt;GrossIncome xsi:nil="true"/&gt;
                                                                  &lt;OnStrike xsi:nil="true"/&gt;
                                                                  &lt;EmployerName xsi:nil="true"/&gt;
                                                                  &lt;StrikeStartDate xsi:nil="true"/&gt;
                                                                  &lt;EmploymentEndDate xsi:nil="true"/&gt;
                                                                  &lt;MostRecentPayDate xsi:nil="true"/&gt;
                                                                  &lt;ReferralIncomeVerification&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/ReferralIncomeVerification&gt;
                                                                  &lt;TargetSystemIncomeId xsi:nil="true"/&gt;
                                                                  &lt;EmployerAddress&gt;
                                                                        &lt;AddressLine2 xsi:nil="true"/&gt;
                                                                        &lt;ZIPExtension xsi:nil="true"/&gt;
                                                                        &lt;City xsi:nil="true"/&gt;
                                                                        &lt;State&gt;
                                                                              &lt;Code xsi:nil="true"/&gt;
                                                                        &lt;/State&gt;
                                                                        &lt;AddressLine1 xsi:nil="true"/&gt;
                                                                        &lt;ZIP xsi:nil="true"/&gt;
                                                                  &lt;/EmployerAddress&gt;
                                                            &lt;/PastEmployment&gt;
                                                            &lt;Employment/&gt;
                                                      &lt;/Income&gt;
                                                      &lt;ImmunizationInfo&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/ImmunizationInfo&gt;
                                                      &lt;DeletedBenefits/&gt;
                                                      &lt;MonthlyIncome xsi:nil="true"/&gt;
                                                      &lt;ActiveMedicaidStatus xsi:nil="true"/&gt;
                                                      &lt;Veteran&gt;
                                                            &lt;VerteranClaimNumber xsi:nil="true"/&gt;
                                                            &lt;DateVeteranEntered xsi:nil="true"/&gt;
                                                            &lt;BranchOfService&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/BranchOfService&gt;
                                                            &lt;DateVeteranLeft xsi:nil="true"/&gt;
                                                            &lt;Status&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/Status&gt;
                                                      &lt;/Veteran&gt;
                                                      &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
                                                      &lt;BenefitsNotReceivedInformation&gt;
                                                            &lt;HasAppliedForBenefitButNotReceived&gt;N&lt;/HasAppliedForBenefitButNotReceived&gt;
                                                            &lt;Benefits/&gt;
                                                      &lt;/BenefitsNotReceivedInformation&gt;
                                                      &lt;RepresentativeContactInformation&gt;
                                                            &lt;RepresentativeContactPersons/&gt;
                                                            &lt;HasRepresentativeAttorneyOrContact xsi:nil="true"/&gt;
                                                      &lt;/RepresentativeContactInformation&gt;
                                                      &lt;IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
                                                      &lt;Pregnant xsi:nil="true"/&gt;
                                                      &lt;HasThePrePopulatedDataChanged xsi:nil="true"/&gt;
                                                      &lt;ResidentInResidentialInstitution xsi:nil="true"/&gt;
                                                      &lt;MedicalConditions&gt;
                                                            &lt;ReceivingDisabilityIncome&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ReceivingDisabilityIncome&gt;
                                                            &lt;DisabilityType&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/DisabilityType&gt;
                                                            &lt;ChildDisabilityType&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ChildDisabilityType&gt;
                                                            &lt;DisabilityOnsetDate xsi:nil="true"/&gt;
                                                            &lt;DisabilityDescription xsi:nil="true"/&gt;
                                                            &lt;AffectsAbilitytoCare xsi:nil="true"/&gt;
                                                            &lt;DevelopmentalAge xsi:nil="true"/&gt;
                                                            &lt;AffectsAbilitytoWork xsi:nil="true"/&gt;
                                                      &lt;/MedicalConditions&gt;
                                                      &lt;FamilyCareInformation&gt;
                                                            &lt;CareControlIndividuals/&gt;
                                                            &lt;IsFamilyCare xsi:nil="true"/&gt;
                                                      &lt;/FamilyCareInformation&gt;
                                                      &lt;FSTANFStatus xsi:nil="true"/&gt;
                                                      &lt;HaveYouBeenResidentOfPAFor90Days&gt;N&lt;/HaveYouBeenResidentOfPAFor90Days&gt;
                                                      &lt;Expense&gt;
                                                            &lt;LegalFeesPerMonthAmount xsi:nil="true"/&gt;
                                                            &lt;ChildOrDisabledAdultCareExpenses/&gt;
                                                            &lt;ChildSupportExpenses/&gt;
                                                            &lt;MedicalExpenses/&gt;
                                                            &lt;AlimonyExpenses/&gt;
                                                      &lt;/Expense&gt;
                                                      &lt;HighestGradeLevelCompleted&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/HighestGradeLevelCompleted&gt;
                                                      &lt;AliasMaidenNameORFormerMarriedName xsi:nil="true"/&gt;
                                                      &lt;ReferralInformation&gt;
                                                            &lt;ReferralMATerminationDate xsi:nil="true"/&gt;
                                                            &lt;ReferralReasonCode&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ReferralReasonCode&gt;
                                                            &lt;IsThisIndividualEmacipated xsi:nil="true"/&gt;
                                                      &lt;/ReferralInformation&gt;
                                                      &lt;HasAliasOrMaidenName xsi:nil="true"/&gt;
                                                      &lt;HispanicOrigin xsi:nil="true"/&gt;
                                                      &lt;SSNVerificationCode&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/SSNVerificationCode&gt;
                                                      &lt;PreventPregnancySurgery xsi:nil="true"/&gt;
                                                      &lt;ParentsOfThisChild&gt;
                                                            &lt;Parent2&gt;
                                                                  &lt;IndividualNumber xsi:nil="true"/&gt;
                                                            &lt;/Parent2&gt;
                                                            &lt;Parent1&gt;
                                                                  &lt;IndividualNumber xsi:nil="true"/&gt;
                                                            &lt;/Parent1&gt;
                                                      &lt;/ParentsOfThisChild&gt;
                                                      &lt;PregnancyDueDate xsi:nil="true"/&gt;
                                                      &lt;RenewalInformation&gt;
                                                            &lt;TargetSystemIndividualID xsi:nil="true"/&gt;
                                                            &lt;IsSSNProvidedByTargetSystem xsi:nil="true"/&gt;
                                                            &lt;IsThisIndividualNoLongerPresentInTheHousehold xsi:nil="true"/&gt;
                                                      &lt;/RenewalInformation&gt;
                                                      &lt;Relationships&gt;
                                                            &lt;Relationship&gt;
                                                                  &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[2].individualNumber#&lt;/IndividualNumber&gt;
                                                                  &lt;Code&gt;B&lt;/Code&gt;
                                                            &lt;/Relationship&gt;
                                                      &lt;/Relationships&gt;
                                                      &lt;SpouseDeathDate xsi:nil="true"/&gt;
                                                      &lt;SeparationDate xsi:nil="true"/&gt;
                                                      &lt;SocialSecurityNumber xsi:nil="true"/&gt;
                                                      &lt;FsOrTANFCaseNumber xsi:nil="true"/&gt;
                                                      &lt;LastName&gt;Individual&lt;/LastName&gt;
                                                      &lt;FSTANFIndividualEBTNumber xsi:nil="true"/&gt;
                                                      &lt;TrainingInformation&gt;
                                                            &lt;IsAttendingTraining xsi:nil="true"/&gt;
                                                            &lt;Trainings/&gt;
                                                      &lt;/TrainingInformation&gt;
                                                      &lt;FirstName&gt;First&lt;/FirstName&gt;
                                                      &lt;RaceInformation/&gt;
                                                      &lt;Sex&gt;
                                                            &lt;Code&gt;M&lt;/Code&gt;
                                                      &lt;/Sex&gt;
                                                      &lt;VeteranRelationInformation&gt;
                                                            &lt;DateVeteranEntered xsi:nil="true"/&gt;
                                                            &lt;DateVeteranLeft xsi:nil="true"/&gt;
                                                            &lt;VeteranName xsi:nil="true"/&gt;
                                                            &lt;BranchOfService&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/BranchOfService&gt;
                                                            &lt;VerteranClaimNumber xsi:nil="true"/&gt;
                                                      &lt;/VeteranRelationInformation&gt;
                                                      &lt;MiddleInitial&gt;M&lt;/MiddleInitial&gt;
                                                      &lt;AppliedBenefits&gt;
                                                            &lt;Benefit&gt;
                                                                  &lt;BenefitName&gt;
                                                                        &lt;Code&gt;FS&lt;/Code&gt;
                                                                  &lt;/BenefitName&gt;
                                                                  &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
                                                                  &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
                                                            &lt;/Benefit&gt;
                                                            &lt;Benefit&gt;
                                                                  &lt;BenefitName&gt;
                                                                        &lt;Code&gt;HC&lt;/Code&gt;
                                                                  &lt;/BenefitName&gt;
                                                                  &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
                                                                  &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
                                                            &lt;/Benefit&gt;
                                                      &lt;/AppliedBenefits&gt;
                                                      &lt;IsFosterChild xsi:nil="true"/&gt;
                                                      &lt;IsHomeless xsi:nil="true"/&gt;
                                                      &lt;MigrantOrSeasonalWorker xsi:nil="true"/&gt;
                                                      &lt;TypeOfFacilityForWhichApplying&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/TypeOfFacilityForWhichApplying&gt;
                                                      &lt;IsRunaway xsi:nil="true"/&gt;
                                                      &lt;Suffix&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/Suffix&gt;
                                                      &lt;DateOfBirth&gt;#arguments.soapData.DateOfBirth#&lt;/DateOfBirth&gt;
                                                      &lt;Education&gt;
                                                            &lt;SchoolCounty&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/SchoolCounty&gt;
                                                            &lt;TypeOfSchool&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/TypeOfSchool&gt;
                                                            &lt;RequiresChildCare xsi:nil="true"/&gt;
                                                            &lt;CurrentGrade xsi:nil="true"/&gt;
                                                            &lt;CharterOrPrivateSchoolType xsi:nil="true"/&gt;
                                                            &lt;SchoolBuilding xsi:nil="true"/&gt;
                                                            &lt;PartTimeORFullTime&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/PartTimeORFullTime&gt;
                                                            &lt;SchoolName xsi:nil="true"/&gt;
                                                            &lt;ExpectedGraduationDate xsi:nil="true"/&gt;
                                                            &lt;SchoolDistrict&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/SchoolDistrict&gt;
                                                      &lt;/Education&gt;
                                                      &lt;ReceivedLongTermCare&gt;
                                                            &lt;HowWereYourExpenseBeingPaid&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/HowWereYourExpenseBeingPaid&gt;
                                                      &lt;/ReceivedLongTermCare&gt;
                                                      &lt;ChildCare&gt;
                                                            &lt;CCScheduleNoOfHrs xsi:nil="true"/&gt;
                                                            &lt;ChildCareSchedule&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ChildCareSchedule&gt;
                                                      &lt;/ChildCare&gt;
                                                      &lt;InterestedToVote&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/InterestedToVote&gt;
                                                &lt;/Individual&gt;
                                                &lt;Individual&gt;
                                                      &lt;Qualification&gt;
                                                            &lt;TANForCashAssistance&gt;
                                                                  &lt;State&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/State&gt;
                                                            &lt;/TANForCashAssistance&gt;
                                                            &lt;WasSSIStoppedBecauseSocialSecurityIncreased xsi:nil="true"/&gt;
                                                            &lt;WasSSIStoppedBecauseSocialSecurityStarted xsi:nil="true"/&gt;
                                                      &lt;/Qualification&gt;
                                                      &lt;MaritalStatus&gt;
                                                            &lt;Code&gt;1&lt;/Code&gt;
                                                      &lt;/MaritalStatus&gt;
                                                      &lt;Citizenship&gt;
                                                            &lt;BirthCounty xsi:nil="true"/&gt;
                                                            &lt;OtherCountry xsi:nil="true"/&gt;
                                                            &lt;MothersMaidenFirstName xsi:nil="true"/&gt;
                                                            &lt;DateEnteredUS xsi:nil="true"/&gt;
                                                            &lt;BirthState&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/BirthState&gt;
                                                            &lt;BirthLastName xsi:nil="true"/&gt;
                                                            &lt;Country&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/Country&gt;
                                                            &lt;MothersMaidenLastName xsi:nil="true"/&gt;
                                                            &lt;BirthFirstName xsi:nil="true"/&gt;
                                                            &lt;Identification&gt;
                                                                  &lt;LicensedState&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/LicensedState&gt;
                                                                  &lt;DriversLicenceNumberOrStateId xsi:nil="true"/&gt;
                                                                  &lt;Name xsi:nil="true"/&gt;
                                                            &lt;/Identification&gt;
                                                            &lt;Sponsor&gt;
                                                                  &lt;Address&gt;
                                                                        &lt;AddressLine2 xsi:nil="true"/&gt;
                                                                        &lt;ZIPExtension xsi:nil="true"/&gt;
                                                                        &lt;City xsi:nil="true"/&gt;
                                                                        &lt;State&gt;
                                                                              &lt;Code xsi:nil="true"/&gt;
                                                                        &lt;/State&gt;
                                                                        &lt;AddressLine1 xsi:nil="true"/&gt;
                                                                        &lt;ZIP xsi:nil="true"/&gt;
                                                                  &lt;/Address&gt;
                                                                  &lt;MiddleInitial xsi:nil="true"/&gt;
                                                                  &lt;LastName xsi:nil="true"/&gt;
                                                                  &lt;HaveASponsor xsi:nil="true"/&gt;
                                                                  &lt;Type xsi:nil="true"/&gt;
                                                                  &lt;SponsorOrganizationName xsi:nil="true"/&gt;
                                                                  &lt;FirstName xsi:nil="true"/&gt;
                                                            &lt;/Sponsor&gt;
                                                            &lt;INSSection xsi:nil="true"/&gt;
                                                            &lt;CitizenshipCode&gt;1&lt;/CitizenshipCode&gt;
                                                            &lt;BirthCity xsi:nil="true"/&gt;
                                                            &lt;AlienRegistrationNumber xsi:nil="true"/&gt;
                                                      &lt;/Citizenship&gt;
                                                      &lt;IsThisPersonAStudent&gt;N&lt;/IsThisPersonAStudent&gt;
                                                      &lt;Income&gt;
                                                            &lt;OtherIncomeSources/&gt;
                                                            &lt;PastEmployment&gt;
                                                                  &lt;MonthlyIncome xsi:nil="true"/&gt;
                                                                  &lt;PayRate xsi:nil="true"/&gt;
                                                                  &lt;PhoneNumber xsi:nil="true"/&gt;
                                                                  &lt;NumberOfHoursWorkedPerWeek xsi:nil="true"/&gt;
                                                                  &lt;EmploymentStartDate xsi:nil="true"/&gt;
                                                                  &lt;IncomeFrequency&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/IncomeFrequency&gt;
                                                                  &lt;GrossIncome xsi:nil="true"/&gt;
                                                                  &lt;OnStrike xsi:nil="true"/&gt;
                                                                  &lt;EmployerName xsi:nil="true"/&gt;
                                                                  &lt;StrikeStartDate xsi:nil="true"/&gt;
                                                                  &lt;EmploymentEndDate xsi:nil="true"/&gt;
                                                                  &lt;MostRecentPayDate xsi:nil="true"/&gt;
                                                                  &lt;ReferralIncomeVerification&gt;
                                                                        &lt;Code xsi:nil="true"/&gt;
                                                                  &lt;/ReferralIncomeVerification&gt;
                                                                  &lt;TargetSystemIncomeId xsi:nil="true"/&gt;
                                                                  &lt;EmployerAddress&gt;
                                                                        &lt;AddressLine2 xsi:nil="true"/&gt;
                                                                        &lt;ZIPExtension xsi:nil="true"/&gt;
                                                                        &lt;City xsi:nil="true"/&gt;
                                                                        &lt;State&gt;
                                                                              &lt;Code xsi:nil="true"/&gt;
                                                                        &lt;/State&gt;
                                                                        &lt;AddressLine1 xsi:nil="true"/&gt;
                                                                        &lt;ZIP xsi:nil="true"/&gt;
                                                                  &lt;/EmployerAddress&gt;
                                                            &lt;/PastEmployment&gt;
                                                            &lt;Employment/&gt;
                                                      &lt;/Income&gt;
                                                      &lt;ImmunizationInfo&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/ImmunizationInfo&gt;
                                                      &lt;DeletedBenefits/&gt;
                                                      &lt;MonthlyIncome xsi:nil="true"/&gt;
                                                      &lt;ActiveMedicaidStatus xsi:nil="true"/&gt;
                                                      &lt;Veteran&gt;
                                                            &lt;VerteranClaimNumber xsi:nil="true"/&gt;
                                                            &lt;DateVeteranEntered xsi:nil="true"/&gt;
                                                            &lt;BranchOfService&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/BranchOfService&gt;
                                                            &lt;DateVeteranLeft xsi:nil="true"/&gt;
                                                            &lt;Status&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/Status&gt;
                                                      &lt;/Veteran&gt;
                                                      &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[2].individualNumber#&lt;/IndividualNumber&gt;
                                                      &lt;BenefitsNotReceivedInformation&gt;
                                                            &lt;HasAppliedForBenefitButNotReceived xsi:nil="true"/&gt;
                                                            &lt;Benefits/&gt;
                                                      &lt;/BenefitsNotReceivedInformation&gt;
                                                      &lt;RepresentativeContactInformation&gt;
                                                            &lt;RepresentativeContactPersons/&gt;
                                                            &lt;HasRepresentativeAttorneyOrContact xsi:nil="true"/&gt;
                                                      &lt;/RepresentativeContactInformation&gt;
                                                      &lt;IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
                                                      &lt;Pregnant xsi:nil="true"/&gt;
                                                      &lt;HasThePrePopulatedDataChanged xsi:nil="true"/&gt;
                                                      &lt;ResidentInResidentialInstitution xsi:nil="true"/&gt;
                                                      &lt;MedicalConditions&gt;
                                                            &lt;ReceivingDisabilityIncome&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ReceivingDisabilityIncome&gt;
                                                            &lt;DisabilityType&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/DisabilityType&gt;
                                                            &lt;ChildDisabilityType&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ChildDisabilityType&gt;
                                                            &lt;DisabilityOnsetDate xsi:nil="true"/&gt;
                                                            &lt;DisabilityDescription xsi:nil="true"/&gt;
                                                            &lt;AffectsAbilitytoCare xsi:nil="true"/&gt;
                                                            &lt;DevelopmentalAge xsi:nil="true"/&gt;
                                                            &lt;AffectsAbilitytoWork xsi:nil="true"/&gt;
                                                      &lt;/MedicalConditions&gt;
                                                      &lt;FamilyCareInformation&gt;
                                                            &lt;CareControlIndividuals/&gt;
                                                            &lt;IsFamilyCare xsi:nil="true"/&gt;
                                                      &lt;/FamilyCareInformation&gt;
                                                      &lt;FSTANFStatus xsi:nil="true"/&gt;
                                                      &lt;HaveYouBeenResidentOfPAFor90Days&gt;N&lt;/HaveYouBeenResidentOfPAFor90Days&gt;
                                                      &lt;Expense&gt;
                                                            &lt;LegalFeesPerMonthAmount xsi:nil="true"/&gt;
                                                            &lt;ChildOrDisabledAdultCareExpenses/&gt;
                                                            &lt;ChildSupportExpenses/&gt;
                                                            &lt;MedicalExpenses/&gt;
                                                            &lt;AlimonyExpenses/&gt;
                                                      &lt;/Expense&gt;
                                                      &lt;HighestGradeLevelCompleted&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/HighestGradeLevelCompleted&gt;
                                                      &lt;AliasMaidenNameORFormerMarriedName xsi:nil="true"/&gt;
                                                      &lt;ReferralInformation&gt;
                                                            &lt;ReferralMATerminationDate xsi:nil="true"/&gt;
                                                            &lt;ReferralReasonCode&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ReferralReasonCode&gt;
                                                            &lt;IsThisIndividualEmacipated xsi:nil="true"/&gt;
                                                      &lt;/ReferralInformation&gt;
                                                      &lt;HasAliasOrMaidenName xsi:nil="true"/&gt;
                                                      &lt;HispanicOrigin xsi:nil="true"/&gt;
                                                      &lt;SSNVerificationCode&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/SSNVerificationCode&gt;
                                                      &lt;PreventPregnancySurgery xsi:nil="true"/&gt;
                                                      &lt;ParentsOfThisChild&gt;
                                                            &lt;Parent2&gt;
                                                                  &lt;IndividualNumber xsi:nil="true"/&gt;
                                                            &lt;/Parent2&gt;
                                                            &lt;Parent1&gt;
                                                                  &lt;IndividualNumber xsi:nil="true"/&gt;
                                                            &lt;/Parent1&gt;
                                                      &lt;/ParentsOfThisChild&gt;
                                                      &lt;PregnancyDueDate xsi:nil="true"/&gt;
                                                      &lt;RenewalInformation&gt;
                                                            &lt;TargetSystemIndividualID xsi:nil="true"/&gt;
                                                            &lt;IsSSNProvidedByTargetSystem xsi:nil="true"/&gt;
                                                            &lt;IsThisIndividualNoLongerPresentInTheHousehold xsi:nil="true"/&gt;
                                                      &lt;/RenewalInformation&gt;
                                                      &lt;Relationships&gt;
                                                            &lt;Relationship&gt;
                                                                  &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
                                                                  &lt;Code&gt;B&lt;/Code&gt;
                                                            &lt;/Relationship&gt;
                                                      &lt;/Relationships&gt;
                                                      &lt;SpouseDeathDate xsi:nil="true"/&gt;
                                                      &lt;SeparationDate xsi:nil="true"/&gt;
                                                      &lt;SocialSecurityNumber xsi:nil="true"/&gt;
                                                      &lt;FsOrTANFCaseNumber xsi:nil="true"/&gt;
                                                      &lt;LastName&gt;#arguments.soapData.LastName#&lt;/LastName&gt;
                                                      &lt;FSTANFIndividualEBTNumber xsi:nil="true"/&gt;
                                                      &lt;TrainingInformation&gt;
                                                            &lt;IsAttendingTraining xsi:nil="true"/&gt;
                                                            &lt;Trainings/&gt;
                                                      &lt;/TrainingInformation&gt;
                                                      &lt;FirstName&gt;#arguments.soapData.FirstName#&lt;/FirstName&gt;
                                                      &lt;RaceInformation/&gt;
                                                      &lt;Sex&gt;
                                                            &lt;Code&gt;#arguments.soapData.Sex#&lt;/Code&gt;
                                                      &lt;/Sex&gt;
                                                      &lt;VeteranRelationInformation&gt;
                                                            &lt;DateVeteranEntered xsi:nil="true"/&gt;
                                                            &lt;DateVeteranLeft xsi:nil="true"/&gt;
                                                            &lt;VeteranName xsi:nil="true"/&gt;
                                                            &lt;BranchOfService&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/BranchOfService&gt;
                                                            &lt;VerteranClaimNumber xsi:nil="true"/&gt;
                                                      &lt;/VeteranRelationInformation&gt;
                                                      &lt;MiddleInitial&gt;#arguments.soapData.MiddleInitial#&lt;/MiddleInitial&gt;
                                                      &lt;AppliedBenefits&gt;
                                                            &lt;Benefit&gt;
                                                                  &lt;BenefitName&gt;
                                                                        &lt;Code&gt;#arguments.soapData.BenefitName#&lt;/Code&gt;
                                                                  &lt;/BenefitName&gt;
                                                                  &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
                                                                  &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
                                                            &lt;/Benefit&gt;
                                                      &lt;/AppliedBenefits&gt;
                                                      &lt;IsFosterChild xsi:nil="true"/&gt;
                                                      &lt;IsHomeless xsi:nil="true"/&gt;
                                                      &lt;MigrantOrSeasonalWorker xsi:nil="true"/&gt;
                                                      &lt;TypeOfFacilityForWhichApplying&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/TypeOfFacilityForWhichApplying&gt;
                                                      &lt;IsRunaway xsi:nil="true"/&gt;
                                                      &lt;Suffix&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/Suffix&gt;
                                                      &lt;DateOfBirth&gt;#arguments.soapData.DateOfBirth#&lt;/DateOfBirth&gt;
                                                      &lt;Education&gt;
                                                            &lt;SchoolCounty&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/SchoolCounty&gt;
                                                            &lt;TypeOfSchool&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/TypeOfSchool&gt;
                                                            &lt;RequiresChildCare xsi:nil="true"/&gt;
                                                            &lt;CurrentGrade xsi:nil="true"/&gt;
                                                            &lt;CharterOrPrivateSchoolType xsi:nil="true"/&gt;
                                                            &lt;SchoolBuilding xsi:nil="true"/&gt;
                                                            &lt;PartTimeORFullTime&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/PartTimeORFullTime&gt;
                                                            &lt;SchoolName xsi:nil="true"/&gt;
                                                            &lt;ExpectedGraduationDate xsi:nil="true"/&gt;
                                                            &lt;SchoolDistrict&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/SchoolDistrict&gt;
                                                      &lt;/Education&gt;
                                                      &lt;ReceivedLongTermCare&gt;
                                                            &lt;HowWereYourExpenseBeingPaid&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/HowWereYourExpenseBeingPaid&gt;
                                                      &lt;/ReceivedLongTermCare&gt;
                                                      &lt;ChildCare&gt;
                                                            &lt;CCScheduleNoOfHrs xsi:nil="true"/&gt;
                                                            &lt;ChildCareSchedule&gt;
                                                                  &lt;Code xsi:nil="true"/&gt;
                                                            &lt;/ChildCareSchedule&gt;
                                                      &lt;/ChildCare&gt;
                                                      &lt;InterestedToVote&gt;
                                                            &lt;Code xsi:nil="true"/&gt;
                                                      &lt;/InterestedToVote&gt;
                                                &lt;/Individual&gt;
                                          &lt;/Individuals&gt;
                                          &lt;DeletedIndividuals/&gt;
                                    &lt;/People&gt;
                              &lt;/CompassApplication&gt;
                        </ns0:ApplicationDataXml>
                        <ns0:XmlMetadaCollection xsi:nil="true"/>
                        <ns0:ProgramCollection>
                              <ns0:ProgramDC>
                                    <ns0:AppliedBenefit>#arguments.soapData.BenefitName#</ns0:AppliedBenefit>
                                    <ns0:IsRenewal>N</ns0:IsRenewal>
                                    <ns0:PostScreeningType xsi:nil="true"/>
                                    <ns0:ApplicationProcessingCode xsi:nil="true"/>
                                    <ns0:PostScreeningResult>false</ns0:PostScreeningResult>
                              </ns0:ProgramDC>
                              <ns0:ProgramDC>
                                    <ns0:AppliedBenefit>#arguments.soapData.BenefitName#</ns0:AppliedBenefit>
                                    <ns0:IsRenewal>N</ns0:IsRenewal>
                                    <ns0:PostScreeningType xsi:nil="true"/>
                                    <ns0:ApplicationProcessingCode xsi:nil="true"/>
                                    <ns0:PostScreeningResult>false</ns0:PostScreeningResult>
                              </ns0:ProgramDC>
                        </ns0:ProgramCollection>
                        <ns0:IndividualCollection>
                              <ns0:IndividualDC>
                                    <ns0:IndividualNumber>#arguments.soapData.IndividualIdentifierDC[2].IndividualNumber#</ns0:IndividualNumber>
                                    <ns0:SequenceNumber xsi:nil="true"/>
                                    <ns0:FirstName>#arguments.soapData.SpouseFirstName#</ns0:FirstName>
                                    <ns0:LastName>#arguments.soapData.SpouseLastName#</ns0:LastName>
                                    <ns0:DateOfBirth>#arguments.soapData.SpouseDateOfBirth#</ns0:DateOfBirth>
                                    <ns0:SocialSecurityNumber>0</ns0:SocialSecurityNumber>
                                    <ns0:IsHeadOfHousehold>Y</ns0:IsHeadOfHousehold>
                                    <ns0:ProgramsCollection>
                                          <ns0:IndividualProgramsDC>
                                                <ns0:AppliedBenefit>#arguments.soapData.BenefitName#</ns0:AppliedBenefit>
                                                <ns0:IsSentByTargetSystem>N</ns0:IsSentByTargetSystem>
                                                <ns0:isThisIndividualRenewing>N</ns0:isThisIndividualRenewing>
                                          </ns0:IndividualProgramsDC>
                                    </ns0:ProgramsCollection>
                                    <ns0:FosterIndicator xsi:nil="true"/>
                                    <ns0:MigrantIndicator xsi:nil="true"/>
                                    <ns0:RunawayIndicator xsi:nil="true"/>
                                    <ns0:HomelessIndicator xsi:nil="true"/>
                                    <ns0:FsTanfCode xsi:nil="true"/>
                                    <ns0:MiddleInitial>#arguments.soapData.SpouseMiddleInitial#</ns0:MiddleInitial>
                                    <ns0:Suffix xsi:nil="true"/>
                              </ns0:IndividualDC>
                              <ns0:IndividualDC>
                                    <ns0:IndividualNumber>#arguments.soapData.IndividualIdentifierDC[1].IndividualNumber#</ns0:IndividualNumber>
                                    <ns0:SequenceNumber xsi:nil="true"/>
                                    <ns0:FirstName>#arguments.soapData.FirstName#</ns0:FirstName>
                                    <ns0:LastName>#arguments.soapData.LastName#</ns0:LastName>
                                    <ns0:DateOfBirth>#arguments.soapData.DateOfBirth#</ns0:DateOfBirth>
                                    <ns0:SocialSecurityNumber>0</ns0:SocialSecurityNumber>
                                    <ns0:IsHeadOfHousehold>N</ns0:IsHeadOfHousehold>
                                    <ns0:ProgramsCollection>
                                          <ns0:IndividualProgramsDC>
                                                <ns0:AppliedBenefit>#arguments.soapData.BenefitName#</ns0:AppliedBenefit>
                                                <ns0:IsSentByTargetSystem>N</ns0:IsSentByTargetSystem>
                                                <ns0:isThisIndividualRenewing>N</ns0:isThisIndividualRenewing>
                                          </ns0:IndividualProgramsDC>
                                    </ns0:ProgramsCollection>
                                    <ns0:FosterIndicator xsi:nil="true"/>
                                    <ns0:MigrantIndicator xsi:nil="true"/>
                                    <ns0:RunawayIndicator xsi:nil="true"/>
                                    <ns0:HomelessIndicator xsi:nil="true"/>
                                    <ns0:FsTanfCode xsi:nil="true"/>
                                    <ns0:MiddleInitial>#arguments.soapData.MiddleInitial#</ns0:MiddleInitial>
                                    <ns0:Suffix xsi:nil="true"/>
                              </ns0:IndividualDC>
                        </ns0:IndividualCollection>
                        <ns0:ChipOrABcontractorName xsi:nil="true"/>
                        <ns0:ChipOrABSelection xsi:nil="true"/>
                        <ns0:VerificationeSign xsi:nil="true"/>
                  </ns0:ApplicationDetailsData>
                  <ns0:SaveSequenceNumber>4</ns0:SaveSequenceNumber>
                  <ns0:ExpireToken>false</ns0:ExpireToken>
            </ns0:SaveRequest>
      </SOAP-ENV:Body>
</SOAP-ENV:Envelope></cfoutput>
			</cfoutput>
		</cfsavecontent>
	</cfprocessingdirective>
	
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ApplicationProcess.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/ApplicationProcessService/SaveRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!---<cfset arguments.soapData.SaveResponse.Completed = soapResponseStruct.SaveResponse.Completed>--->
			
			<cfdump var="#soapData#" label="SESSION SOAP data - Step 6">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT - Step 6">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML - Step 6"><cfabort>--->
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Six.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Six.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP SIX :: Save the application XML --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP SEVEN :: Perform Routing --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:RoutingResultsRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
			      <ns0:RoutingApplicationRequestData>
			        <ns0:IsResources>false</ns0:IsResources>
			      </ns0:RoutingApplicationRequestData>
			      <ns0:SecurityToken>#arguments.soapData.SecurityToken#</ns0:SecurityToken>
			    </ns0:RoutingResultsRequest>
			  </SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/RulesManagementService.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/RulesManagementService/RoutingResultsRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data - Step 7">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT - Step 7">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML - Step 7">--->
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Seven.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Seven.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP SEVEN :: Perform Routing --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP EIGHT :: Save the application XML --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:SaveRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
			      <ns0:SecurityToken xsi:nil="true"/>
			      <ns0:ApplicationDetailsData>
			        <ns0:County>01</ns0:County>
			        <ns0:SchoolDistrict>01110</ns0:SchoolDistrict>
			        <ns0:ApplicationType>W</ns0:ApplicationType>
			        <ns0:Applicationlanguage>1</ns0:Applicationlanguage>
			        <ns0:PrintLanguage>#arguments.soapData.PrintLanguage#</ns0:PrintLanguage>
			        <ns0:PrintStatus>#arguments.soapData.PrintStatus#</ns0:PrintStatus>
			        <ns0:CPOrganizationId>#arguments.soapData.OrganizationID#</ns0:CPOrganizationId>
			        <ns0:CpUserId>#arguments.soapData.USER#</ns0:CpUserId>     <ns0:NavigationMetaData>tab=0&amp;crd=0&amp;sec=7&amp;GS=Green&amp;HH=Green&amp;BN=Green&amp;ID=Green&amp;IN=Green&amp;EX=Green&amp;INS=Green&amp;WQ=Green&amp;RS=White&amp;SMR=White&amp;NS=White&amp;VER=White&amp;SUB=White</ns0:NavigationMetaData> 
			        <ns0:ApplicationDataXml>&lt;CompassApplication xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&gt;
		  &lt;ApplicationNumber&gt;W9200208&lt;/ApplicationNumber&gt;
		  &lt;Household&gt;
		    &lt;OtherHouseholdSchoolDistrict xsi:nil="true"/&gt;
		    &lt;Qualification&gt;
		      &lt;ReceivedTANFinPasts6Months&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/ReceivedTANFinPasts6Months&gt;
		      &lt;HasAnyoneReceivedSSIInThePast&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/HasAnyoneReceivedSSIInThePast&gt;
		      &lt;ReceivingTANF&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/ReceivingTANF&gt;
		      &lt;AnyOneHasPaidMedicalBills&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/AnyOneHasPaidMedicalBills&gt;
		      &lt;ReceivingFS&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/ReceivingFS&gt;
		      &lt;DoesAnyOneHavePermanentDisabilityOrSpecialHealthCare&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/DoesAnyOneHavePermanentDisabilityOrSpecialHealthCare&gt;
		      &lt;HasAnyOneReceivedSSDInThePast&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasAnyOneReceivedSSDInThePast&gt;
		      &lt;AnyOneHasUnpaidMedicalBills&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/AnyOneHasUnpaidMedicalBills&gt;
		      &lt;AnyOneReceivingProtectiveServicesAsVictimOfDomesticViolence xsi:nil="true"/&gt;
		      &lt;AnyOneReceivingTreatmentForAlcoholOrDrugProblem xsi:nil="true"/&gt;
		      &lt;AnyOneDisabledBlindSeriouslyIllOrHasAlcoholOrDrugProblem xsi:nil="true"/&gt;
		    &lt;/Qualification&gt;
		    &lt;CCISOffice&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/CCISOffice&gt;
		    &lt;WhoHasBeenConvictedAFelony&gt;
		      &lt;IndividualNumbers/&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/WhoHasBeenConvictedAFelony&gt;
		    &lt;DistrictOffice&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/DistrictOffice&gt;
		    &lt;NumberOfMonthsInPA xsi:nil="true"/&gt;
		    &lt;Resources&gt;
		      &lt;HasMemberReceivedLongTermCare&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMemberReceivedLongTermCare&gt;
		      &lt;AnyoneClosedOrDepletedAccounts&gt;
		        &lt;ClosedAccounts/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyoneClosedOrDepletedAccounts&gt;
		      &lt;AnyOneEstablishTrust&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyOneEstablishTrust&gt;
		      &lt;AnyoneExpectingAnyResources&gt;
		        &lt;ExpectingMoneyCollection/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyoneExpectingAnyResources&gt;
		      &lt;AnyoneHaveCash&gt;
		        &lt;CashCollection/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyoneHaveCash&gt;
		      &lt;AnyoneBuyingNonResidentProperty&gt;
		        &lt;NonResidentialProperties/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyoneBuyingNonResidentProperty&gt;
		      &lt;HasMemberSoldTransferedProperty&gt;
		        &lt;SoldTransferredProperties/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMemberSoldTransferedProperty&gt;
		      &lt;AnyOwnORBuyingVehicle&gt;
		        &lt;Vehicles/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyOwnORBuyingVehicle&gt;
		      &lt;AnyoneHaveLifeInsurancePolicy&gt;
		        &lt;LifeInsuranceCollection/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyoneHaveLifeInsurancePolicy&gt;
		      &lt;AnyoneOwnBurialSpaceORPlot&gt;
		        &lt;BurialSpaces/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyoneOwnBurialSpaceORPlot&gt;
		      &lt;AnyoneHaveBurialORTrustAgreementWithBankORFuneralHome&gt;
		        &lt;BurialTrustAgreements/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/AnyoneHaveBurialORTrustAgreementWithBankORFuneralHome&gt;
		    &lt;/Resources&gt;
		    &lt;MobilePhoneNumber xsi:nil="true"/&gt;
		    &lt;HaveYouReceivedBenefitsInPA xsi:nil="true"/&gt;
		    &lt;FromHowManyYearsAtThisAddress xsi:nil="true"/&gt;
		    &lt;WhoHasBeenIssuedASummons&gt;
		      &lt;IndividualNumbers/&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/WhoHasBeenIssuedASummons&gt;
		    &lt;WhoWasConvictedForWelfareFraud&gt;
		      &lt;IndividualNumbers/&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/WhoWasConvictedForWelfareFraud&gt;
		    &lt;ApplicantAddress&gt;
		      &lt;City&gt;Camp Hill&lt;/City&gt;
		      &lt;State&gt;
		        &lt;Code&gt;PA&lt;/Code&gt;
		      &lt;/State&gt;
		      &lt;AddressLine1&gt;Corporate center&lt;/AddressLine1&gt;
		      &lt;AddressLine2 xsi:nil="true"/&gt;
		      &lt;ZIPExtension xsi:nil="true"/&gt;
		      &lt;ZIP&gt;17011&lt;/ZIP&gt;
		    &lt;/ApplicantAddress&gt;
		    &lt;OtherCurrentHousingSituation xsi:nil="true"/&gt;
		    &lt;IsWeatherizationSelected&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/IsWeatherizationSelected&gt;
		    &lt;VerficationDocumentInformation&gt;
		      &lt;Departments/&gt;
		    &lt;/VerficationDocumentInformation&gt;
		    &lt;FoodStampRepresentativeInformation&gt;
		      &lt;FoodStampsRepresentativeAvailable xsi:nil="true"/&gt;
		      &lt;FoodStampRepresentativeName xsi:nil="true"/&gt;
		      &lt;FoodStampRepresentativeAddress&gt;
		        &lt;AddressLine2 xsi:nil="true"/&gt;
		        &lt;ZIPExtension xsi:nil="true"/&gt;
		        &lt;City xsi:nil="true"/&gt;
		        &lt;State&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/State&gt;
		        &lt;AddressLine1 xsi:nil="true"/&gt;
		        &lt;ZIP xsi:nil="true"/&gt;
		      &lt;/FoodStampRepresentativeAddress&gt;
		      &lt;SocialSecurityNumber xsi:nil="true"/&gt;
		      &lt;PhoneNumber xsi:nil="true"/&gt;
		    &lt;/FoodStampRepresentativeInformation&gt;
		    &lt;InsuranceInformation&gt;
		      &lt;HealthInsuranceForChildrenFromWork&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HealthInsuranceForChildrenFromWork&gt;
		      &lt;DoesAnyoneHaveHealthInsurance&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/DoesAnyoneHaveHealthInsurance&gt;
		      &lt;DidAnyoneApplyingForHaveHealthInsuranceInLast90Days&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/DidAnyoneApplyingForHaveHealthInsuranceInLast90Days&gt;
		      &lt;DidAnyOfTheChildrenLoseInsuranceInPast6Months&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/DidAnyOfTheChildrenLoseInsuranceInPast6Months&gt;
		      &lt;Insurances/&gt;
		      &lt;DidTheyApplyForUnemploymentCompensation&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/DidTheyApplyForUnemploymentCompensation&gt;
		      &lt;IndividualHaveToPayForChildren&gt;
		        &lt;IndividualNumbers/&gt;
		      &lt;/IndividualHaveToPayForChildren&gt;
		      &lt;HasMemberCanGetInsuranceThroughJob&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMemberCanGetInsuranceThroughJob&gt;
		      &lt;IndividualHaveToPayForIt&gt;
		        &lt;IndividualNumbers/&gt;
		      &lt;/IndividualHaveToPayForIt&gt;
		    &lt;/InsuranceInformation&gt;
		    &lt;WhoIsCurrentlyFleeingFromLawEnforcementOfficials&gt;
		      &lt;IndividualNumbers/&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/WhoIsCurrentlyFleeingFromLawEnforcementOfficials&gt;
		    &lt;PreviousAddress&gt;
		      &lt;AddressLine2 xsi:nil="true"/&gt;
		      &lt;ZIPExtension xsi:nil="true"/&gt;
		      &lt;City xsi:nil="true"/&gt;
		      &lt;State&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/State&gt;
		      &lt;AddressLine1 xsi:nil="true"/&gt;
		      &lt;ZIP xsi:nil="true"/&gt;
		    &lt;/PreviousAddress&gt;
		    &lt;AdmissionDate xsi:nil="true"/&gt;
		    &lt;FromHowManyMonthsAtThisAddress xsi:nil="true"/&gt;
		    &lt;County&gt;
		      &lt;Code&gt;01&lt;/Code&gt;
		    &lt;/County&gt;
		    &lt;Expenses&gt;
		      &lt;DidTheHouseholdGetEnergyAssistanceSinceOctoberFirst xsi:nil="true"/&gt;
		      &lt;HasMemberPaysCareToAttendTraining&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMemberPaysCareToAttendTraining&gt;
		      &lt;SharesWithNonMember/&gt;
		      &lt;HasMembersPaysLegalFees&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMembersPaysLegalFees&gt;
		      &lt;HasMemberDrivesOrPaysWorkTransportation&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMemberDrivesOrPaysWorkTransportation&gt;
		      &lt;MealsIncludedInRent xsi:nil="true"/&gt;
		      &lt;HasMembersPaysAlimonyToNonMember&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMembersPaysAlimonyToNonMember&gt;
		      &lt;HasMembersPaysChildSupportToNonMember&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMembersPaysChildSupportToNonMember&gt;
		      &lt;HasMemeberPayForChildcareOrDisabledAdultCareToGoToWork&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMemeberPayForChildcareOrDisabledAdultCareToGoToWork&gt;
		      &lt;HasMemberPaysShelterOrUtilityExpenses&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMemberPaysShelterOrUtilityExpenses&gt;
		      &lt;HouseHoldShareExpense xsi:nil="true"/&gt;
		      &lt;UtilityExpense&gt;
		        &lt;FuelCostForHouse xsi:nil="true"/&gt;
		        &lt;UtilityOrFuelCompany&gt;
		          &lt;UtilityCompanyName xsi:nil="true"/&gt;
		          &lt;UtilityCompanyAccountNumber xsi:nil="true"/&gt;
		          &lt;Address&gt;
		            &lt;AddressLine2 xsi:nil="true"/&gt;
		            &lt;ZIPExtension xsi:nil="true"/&gt;
		            &lt;City xsi:nil="true"/&gt;
		            &lt;State&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/State&gt;
		            &lt;AddressLine1 xsi:nil="true"/&gt;
		            &lt;ZIP xsi:nil="true"/&gt;
		          &lt;/Address&gt;
		        &lt;/UtilityOrFuelCompany&gt;
		        &lt;UtilityCostOtherThanHeatingOrCooling xsi:nil="true"/&gt;
		        &lt;PrimaryHeatingSource&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/PrimaryHeatingSource&gt;
		        &lt;FuelDeliveryDate xsi:nil="true"/&gt;
		        &lt;Utilities&gt;
		          &lt;DoesAnyonePayForGas&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForGas&gt;
		          &lt;DoesAnyonePayForRentOrMortgage&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForRentOrMortgage&gt;
		          &lt;DoesAnyonePayForHomeInsurance&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForHomeInsurance&gt;
		          &lt;DoesAnyonePayForGarbage&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForGarbage&gt;
		          &lt;DoesAnyonePayForPropertyTaxes&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForPropertyTaxes&gt;
		          &lt;DoesAnyonePayForOilCoalWood&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForOilCoalWood&gt;
		          &lt;DoesAnyonePayForUtilityInstallationThisMonth&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForUtilityInstallationThisMonth&gt;
		          &lt;DoesAnyonePayForOtherUtilities&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForOtherUtilities&gt;
		          &lt;DoesAnyonePayForTelephone&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForTelephone&gt;
		          &lt;DoesAnyonePayForSewerage&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForSewerage&gt;
		          &lt;DoesAnyonePayForWater&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForWater&gt;
		          &lt;DoesAnyonePayForElectric&gt;
		            &lt;Frequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/Frequency&gt;
		            &lt;Code xsi:nil="true"/&gt;
		            &lt;Amount xsi:nil="true"/&gt;
		            &lt;NetExpenseAmount xsi:nil="true"/&gt;
		          &lt;/DoesAnyonePayForElectric&gt;
		        &lt;/Utilities&gt;
		        &lt;SecondaryHeatingSource&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/SecondaryHeatingSource&gt;
		        &lt;BilledSeparatelyForHeatingOrCooling xsi:nil="true"/&gt;
		        &lt;PayForHeatingOrCooling xsi:nil="true"/&gt;
		      &lt;/UtilityExpense&gt;
		      &lt;HasMembersPaidMedicalLastNintyDays&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/HasMembersPaidMedicalLastNintyDays&gt;
		    &lt;/Expenses&gt;
		    &lt;CurrentHousingSituation&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/CurrentHousingSituation&gt;
		    &lt;Income&gt;
		      &lt;PastEmployment&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/PastEmployment&gt;
		      &lt;NoIncomeExplanation xsi:nil="true"/&gt;
		      &lt;DoesAnyoneReceiveFinancialAssistanceForDisability xsi:nil="true"/&gt;
		      &lt;CurrentEmployment&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/CurrentEmployment&gt;
		      &lt;OtherIncome&gt;
		        &lt;IndividualNumbers/&gt;
		        &lt;Code&gt;N&lt;/Code&gt;
		      &lt;/OtherIncome&gt;
		    &lt;/Income&gt;
		    &lt;HousingAssistance&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/HousingAssistance&gt;
		    &lt;FoodStamps&gt;
		      &lt;TotalAssets xsi:nil="true"/&gt;
		      &lt;SubmitShortApplication xsi:nil="true"/&gt;
		      &lt;AnyoneMigrantWorker xsi:nil="true"/&gt;
		      &lt;HasReceivedFoodStamps xsi:nil="true"/&gt;
		      &lt;IncomeLowEnough xsi:nil="true"/&gt;
		      &lt;SubmitImmediately xsi:nil="true"/&gt;
		      &lt;ShelterLiving xsi:nil="true"/&gt;
		      &lt;RentExceedsIncome xsi:nil="true"/&gt;
		    &lt;/FoodStamps&gt;
		    &lt;PreviousBenefitInformation&gt;
		      &lt;AppliedORReceivedBenefitsInOtherState xsi:nil="true"/&gt;
		      &lt;PreviousStateBenefitDescription xsi:nil="true"/&gt;
		      &lt;PreviousCountyBenefitDescription xsi:nil="true"/&gt;
		    &lt;/PreviousBenefitInformation&gt;
		    &lt;HowtoContact&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/HowtoContact&gt;
		    &lt;AdditionalInformation&gt;
		      &lt;OptionalInformation xsi:nil="true"/&gt;
		      &lt;RequiredInterpreter&gt;#arguments.soapData.RequiredInterpreter#&lt;/RequiredInterpreter&gt;
		      &lt;LearnSource&gt;
		        &lt;Sources/&gt;
		        &lt;OtherLearnSource xsi:nil="true"/&gt;
		      &lt;/LearnSource&gt;
		      &lt;DoesAnyChildUnder21HaveParentNotLivingInHouseholdOrDeceased&gt;N&lt;/DoesAnyChildUnder21HaveParentNotLivingInHouseholdOrDeceased&gt;
		      &lt;DoesAnyoneNeedHelpForChildSupportOrInsuranceFromAbsentRelative&gt;N&lt;/DoesAnyoneNeedHelpForChildSupportOrInsuranceFromAbsentRelative&gt;
		      &lt;AnyOneHasASpouseNotLivingInHouseholdOrDeceased xsi:nil="true"/&gt;
		    &lt;/AdditionalInformation&gt;
		    &lt;CityTownship&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/CityTownship&gt;
		    &lt;WhoIsTheSelfRelationshipIndividual&gt;
		      &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
		    &lt;/WhoIsTheSelfRelationshipIndividual&gt;
		    &lt;DateMovedToPA xsi:nil="true"/&gt;
		    &lt;WhoIsOnProbationORParole&gt;
		      &lt;IndividualNumbers/&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/WhoIsOnProbationORParole&gt;
		    &lt;OtherHouseholdLanguagePreference xsi:nil="true"/&gt;
		    &lt;NursingHomeInformation&gt;
		      &lt;Address&gt;
		        &lt;AddressLine2 xsi:nil="true"/&gt;
		        &lt;ZIPExtension xsi:nil="true"/&gt;
		        &lt;City xsi:nil="true"/&gt;
		        &lt;State&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/State&gt;
		        &lt;AddressLine1 xsi:nil="true"/&gt;
		        &lt;ZIP xsi:nil="true"/&gt;
		      &lt;/Address&gt;
		      &lt;PreviouslyLivedInNursingFacility xsi:nil="true"/&gt;
		      &lt;NursingFacilityName xsi:nil="true"/&gt;
		      &lt;NursingFacilityEndDate xsi:nil="true"/&gt;
		      &lt;NursingFacilityStartDate xsi:nil="true"/&gt;
		    &lt;/NursingHomeInformation&gt;
		    &lt;FamilyHealthCareInformation&gt;
		      &lt;DoctorOrClinicAddress&gt;
		        &lt;AddressLine2 xsi:nil="true"/&gt;
		        &lt;ZIPExtension xsi:nil="true"/&gt;
		        &lt;City xsi:nil="true"/&gt;
		        &lt;State&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/State&gt;
		        &lt;AddressLine1 xsi:nil="true"/&gt;
		        &lt;ZIP xsi:nil="true"/&gt;
		      &lt;/DoctorOrClinicAddress&gt;
		      &lt;NameOfDoctorOrClinic xsi:nil="true"/&gt;
		    &lt;/FamilyHealthCareInformation&gt;
		    &lt;PreviousPhoneNumber xsi:nil="true"/&gt;
		    &lt;HouseholdLanguagePreference&gt;#arguments.soapData.HouseholdLanguagePreference#&lt;/HouseholdLanguagePreference&gt;
		    &lt;HouseholdSchoolDistrict&gt;
		      &lt;Code&gt;01110&lt;/Code&gt;
		    &lt;/HouseholdSchoolDistrict&gt;
		    &lt;WhoIsTheHeadOfHousehold&gt;
		      &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
		    &lt;/WhoIsTheHeadOfHousehold&gt;
		    &lt;CurrentLivingSituation&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/CurrentLivingSituation&gt;
		    &lt;DisqualifiedForAssistance xsi:nil="true"/&gt;
		    &lt;AppliedBenefitsWithDifferentNameORSSN xsi:nil="true"/&gt;
		    &lt;IsEveryoneApplyingForLI&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/IsEveryoneApplyingForLI&gt;
		    &lt;BestTimeToCall xsi:nil="true"/&gt;
		    &lt;DoYouChooseAnAuthorizedRepresentativeForFoodStampBenefits xsi:nil="true"/&gt;
		    &lt;WorkPhone&gt;
		      &lt;PhoneNumber xsi:nil="true"/&gt;
		      &lt;PhoneExtension xsi:nil="true"/&gt;
		    &lt;/WorkPhone&gt;
		    &lt;OtherCityTownship xsi:nil="true"/&gt;
		    &lt;AlternateMailingAddress&gt;
		      &lt;AlternateAddressEffectiveDate xsi:nil="true"/&gt;
		      &lt;Address&gt;
		        &lt;AddressLine2 xsi:nil="true"/&gt;
		        &lt;ZIPExtension xsi:nil="true"/&gt;
		        &lt;City xsi:nil="true"/&gt;
		        &lt;State&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/State&gt;
		        &lt;AddressLine1 xsi:nil="true"/&gt;
		        &lt;ZIP xsi:nil="true"/&gt;
		      &lt;/Address&gt;
		      &lt;IsThereAnAlternateMailingAddress xsi:nil="true"/&gt;
		      &lt;IsTheAddressEffectiveImmediately xsi:nil="true"/&gt;
		    &lt;/AlternateMailingAddress&gt;
		    &lt;PreviousCountyrecordNumber xsi:nil="true"/&gt;
		    &lt;EmailAddress xsi:nil="true"/&gt;
		    &lt;NumberOfYearsInPA xsi:nil="true"/&gt;
		    &lt;HomePhoneNumber xsi:nil="true"/&gt;
		  &lt;/Household&gt;
		  &lt;ApplicationInformation&gt;
		    &lt;RenewalInformation xsi:nil="true"/&gt;
		    &lt;LastSequenceNumberCreated&gt;3&lt;/LastSequenceNumberCreated&gt;
		    &lt;Comments xsi:nil="true"/&gt;
		    &lt;CommunityPartnerInformation&gt;
		      &lt;CommunityPartnerRightsRevoked xsi:nil="true"/&gt;
		      &lt;CommunityPartnerOrganizationID&gt;IDMUpgrade4530-1&lt;/CommunityPartnerOrganizationID&gt;
		      &lt;CommunityPartnerLastUserID xsi:nil="true"/&gt;
		      &lt;CommunityPartnerUserID&gt;b-kchetty&lt;/CommunityPartnerUserID&gt;
		    &lt;/CommunityPartnerInformation&gt;
		    &lt;ReferralIncomeScheduleIndicator&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/ReferralIncomeScheduleIndicator&gt;
		    &lt;SubmitServiceTargets/&gt;
		    &lt;PrintStatus&gt;#arguments.soapData.PrintStatus#&lt;/PrintStatus&gt;
		    &lt;ContractorInformation&gt;
		      &lt;ContractorName&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/ContractorName&gt;
		      &lt;ContractorTypeSelection&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/ContractorTypeSelection&gt;
		    &lt;/ContractorInformation&gt;
		    &lt;RequiredTranslator xsi:nil="true"/&gt;
		    &lt;OtherPrograms/&gt;
		    &lt;ProviderInformation&gt;
		      &lt;ProviderName&gt;IDM Upgrade&lt;/ProviderName&gt;
		      &lt;FWProjectName xsi:nil="true"/&gt;
		      &lt;CBOType&gt;TEST&lt;/CBOType&gt;
		      &lt;FWProjectID xsi:nil="true"/&gt;
		      &lt;ProviderType&gt;
		        &lt;Code&gt;C&lt;/Code&gt;
		      &lt;/ProviderType&gt;
		      &lt;FWContractorName xsi:nil="true"/&gt;
		      &lt;ProviderNumber xsi:nil="true"/&gt;
		      &lt;MedicalServiceType&gt;
		        &lt;Code xsi:nil="true"/&gt;
		      &lt;/MedicalServiceType&gt;
		      &lt;StartDateForHealthCareCoverage xsi:nil="true"/&gt;
		    &lt;/ProviderInformation&gt;
		    &lt;CompassSubmitDate xsi:nil="true"/&gt;
		    &lt;AgreedToRightsAndResponsibilities&gt;#arguments.soapData.AgreedToRightsAndResponsibilities#&lt;/AgreedToRightsAndResponsibilities&gt;
		    &lt;IsApplicationESigned&gt;#arguments.soapData.IsApplicationESigned#&lt;/IsApplicationESigned&gt;
		    &lt;Esignature&gt;
				&lt;Last4DigitsOfSSN xsi:nil="true"/&gt;
				&lt;CommunityPartnerInitials&gt;#arguments.soapData.CommunityPartnerInitials#&lt;/CommunityPartnerInitials&gt;
				&lt;ESignedIndividualNumber xsi:nil="true"/&gt;
				&lt;ESignatureAgreement&gt;
				&lt;Code&gt;Y&lt;/Code&gt;
				&lt;/ESignatureAgreement&gt;
				&lt;EsignedNoSSNIndicator&gt;
				&lt;Code xsi:nil="true"/&gt;
				&lt;/EsignedNoSSNIndicator&gt;
				&lt;IsESignedIndividualEmancipatedMinor&gt;
				&lt;Code xsi:nil="true"/&gt;
				&lt;/IsESignedIndividualEmancipatedMinor&gt;
			&lt;/Esignature&gt;
		    &lt;CCSTAFFAPPIndicator xsi:nil="true"/&gt;
		    &lt;EsignatureSelectionType&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/EsignatureSelectionType&gt;
		    &lt;ApplicationOrigin&gt;
		      &lt;Code&gt;C&lt;/Code&gt;
		    &lt;/ApplicationOrigin&gt;
		    &lt;LiheapProgramType&gt;
		      &lt;Code xsi:nil="true"/&gt;
		    &lt;/LiheapProgramType&gt;
		    &lt;ReleaseNumber xsi:nil="true"/&gt;
		    &lt;ApplicationLanguage&gt;
		      &lt;Code&gt;1&lt;/Code&gt;
		    &lt;/ApplicationLanguage&gt;
		    &lt;ApplicationType&gt;
		      &lt;Code&gt;W&lt;/Code&gt;
		    &lt;/ApplicationType&gt;
		    &lt;ApplicationStatus xsi:nil="true"/&gt;
		    &lt;ReferralId xsi:nil="true"/&gt;
		    &lt;MAWDInformation&gt;
		      &lt;ModeOfPaymentForMAWD xsi:nil="true"/&gt;
		      &lt;CoverageBeginForMAWD xsi:nil="true"/&gt;
		    &lt;/MAWDInformation&gt;
		    &lt;AppliedPrograms&gt;
		      &lt;Program&gt;
		        &lt;IsThisARenewal&gt;N&lt;/IsThisARenewal&gt;
		        &lt;Code&gt;FS&lt;/Code&gt;
		        &lt;TargetSystems/&gt;
		        &lt;RoutingLocation&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/RoutingLocation&gt;
		      &lt;/Program&gt;
		      &lt;Program&gt;
		        &lt;IsThisARenewal&gt;N&lt;/IsThisARenewal&gt;
		        &lt;Code&gt;HC&lt;/Code&gt;
		        &lt;TargetSystems/&gt;
		        &lt;RoutingLocation&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/RoutingLocation&gt;
		      &lt;/Program&gt;
		    &lt;/AppliedPrograms&gt;
		    &lt;PrintLanguage&gt;#arguments.soapData.PrintLanguage#&lt;/PrintLanguage&gt;
		  &lt;/ApplicationInformation&gt;
		  &lt;People&gt;
		    &lt;AbsentRelatives/&gt;
		    &lt;Individuals&gt;
		      &lt;Individual&gt;
		        &lt;Qualification&gt;
		          &lt;TANForCashAssistance&gt;
		            &lt;State&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/State&gt;
		          &lt;/TANForCashAssistance&gt;
		          &lt;WasSSIStoppedBecauseSocialSecurityIncreased xsi:nil="true"/&gt;
		          &lt;WasSSIStoppedBecauseSocialSecurityStarted xsi:nil="true"/&gt;
		        &lt;/Qualification&gt;
		        &lt;MaritalStatus&gt;
		          &lt;Code&gt;1&lt;/Code&gt;
		        &lt;/MaritalStatus&gt;
		        &lt;Citizenship&gt;
		          &lt;BirthCounty xsi:nil="true"/&gt;
		          &lt;OtherCountry xsi:nil="true"/&gt;
		          &lt;MothersMaidenFirstName xsi:nil="true"/&gt;
		          &lt;DateEnteredUS xsi:nil="true"/&gt;
		          &lt;BirthState&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/BirthState&gt;
		          &lt;BirthLastName xsi:nil="true"/&gt;
		          &lt;Country&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/Country&gt;
		          &lt;MothersMaidenLastName xsi:nil="true"/&gt;
		          &lt;BirthFirstName xsi:nil="true"/&gt;
		          &lt;Identification&gt;
		            &lt;LicensedState&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/LicensedState&gt;
		            &lt;DriversLicenceNumberOrStateId xsi:nil="true"/&gt;
		            &lt;Name xsi:nil="true"/&gt;
		          &lt;/Identification&gt;
		          &lt;Sponsor&gt;
		            &lt;Address&gt;
		              &lt;AddressLine2 xsi:nil="true"/&gt;
		              &lt;ZIPExtension xsi:nil="true"/&gt;
		              &lt;City xsi:nil="true"/&gt;
		              &lt;State&gt;
		                &lt;Code xsi:nil="true"/&gt;
		              &lt;/State&gt;
		              &lt;AddressLine1 xsi:nil="true"/&gt;
		              &lt;ZIP xsi:nil="true"/&gt;
		            &lt;/Address&gt;
		            &lt;MiddleInitial xsi:nil="true"/&gt;
		            &lt;LastName xsi:nil="true"/&gt;
		            &lt;HaveASponsor xsi:nil="true"/&gt;
		            &lt;Type xsi:nil="true"/&gt;
		            &lt;SponsorOrganizationName xsi:nil="true"/&gt;
		            &lt;FirstName xsi:nil="true"/&gt;
		          &lt;/Sponsor&gt;
		          &lt;INSSection xsi:nil="true"/&gt;
		          &lt;CitizenshipCode&gt;1&lt;/CitizenshipCode&gt;
		          &lt;BirthCity xsi:nil="true"/&gt;
		          &lt;AlienRegistrationNumber xsi:nil="true"/&gt;
		        &lt;/Citizenship&gt;
		        &lt;IsThisPersonAStudent&gt;N&lt;/IsThisPersonAStudent&gt;
		        &lt;Income&gt;
		          &lt;OtherIncomeSources/&gt;
		          &lt;PastEmployment&gt;
		            &lt;MonthlyIncome xsi:nil="true"/&gt;
		            &lt;PayRate xsi:nil="true"/&gt;
		            &lt;PhoneNumber xsi:nil="true"/&gt;
		            &lt;NumberOfHoursWorkedPerWeek xsi:nil="true"/&gt;
		            &lt;EmploymentStartDate xsi:nil="true"/&gt;
		            &lt;IncomeFrequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/IncomeFrequency&gt;
		            &lt;GrossIncome xsi:nil="true"/&gt;
		            &lt;OnStrike xsi:nil="true"/&gt;
		            &lt;EmployerName xsi:nil="true"/&gt;
		            &lt;StrikeStartDate xsi:nil="true"/&gt;
		            &lt;EmploymentEndDate xsi:nil="true"/&gt;
		            &lt;MostRecentPayDate xsi:nil="true"/&gt;
		            &lt;ReferralIncomeVerification&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/ReferralIncomeVerification&gt;
		            &lt;TargetSystemIncomeId xsi:nil="true"/&gt;
		            &lt;EmployerAddress&gt;
		              &lt;AddressLine2 xsi:nil="true"/&gt;
		              &lt;ZIPExtension xsi:nil="true"/&gt;
		              &lt;City xsi:nil="true"/&gt;
		              &lt;State&gt;
		                &lt;Code xsi:nil="true"/&gt;
		              &lt;/State&gt;
		              &lt;AddressLine1 xsi:nil="true"/&gt;
		              &lt;ZIP xsi:nil="true"/&gt;
		            &lt;/EmployerAddress&gt;
		          &lt;/PastEmployment&gt;
		          &lt;Employment/&gt;
		        &lt;/Income&gt;
		        &lt;ImmunizationInfo&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/ImmunizationInfo&gt;
		        &lt;DeletedBenefits/&gt;
		        &lt;MonthlyIncome xsi:nil="true"/&gt;
		        &lt;ActiveMedicaidStatus xsi:nil="true"/&gt;
		        &lt;Veteran&gt;
		          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
		          &lt;DateVeteranEntered xsi:nil="true"/&gt;
		          &lt;BranchOfService&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/BranchOfService&gt;
		          &lt;DateVeteranLeft xsi:nil="true"/&gt;
		          &lt;Status&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/Status&gt;
		        &lt;/Veteran&gt;
		        &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
		        &lt;BenefitsNotReceivedInformation&gt;
		          &lt;HasAppliedForBenefitButNotReceived&gt;N&lt;/HasAppliedForBenefitButNotReceived&gt;
		          &lt;Benefits/&gt;
		        &lt;/BenefitsNotReceivedInformation&gt;
		        &lt;RepresentativeContactInformation&gt;
		          &lt;RepresentativeContactPersons/&gt;
		          &lt;HasRepresentativeAttorneyOrContact xsi:nil="true"/&gt;
		        &lt;/RepresentativeContactInformation&gt;
		        &lt;IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
		        &lt;Pregnant xsi:nil="true"/&gt;
		        &lt;HasThePrePopulatedDataChanged xsi:nil="true"/&gt;
		        &lt;ResidentInResidentialInstitution xsi:nil="true"/&gt;
		        &lt;MedicalConditions&gt;
		          &lt;ReceivingDisabilityIncome&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ReceivingDisabilityIncome&gt;
		          &lt;DisabilityType&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/DisabilityType&gt;
		          &lt;ChildDisabilityType&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ChildDisabilityType&gt;
		          &lt;DisabilityOnsetDate xsi:nil="true"/&gt;
		          &lt;DisabilityDescription xsi:nil="true"/&gt;
		          &lt;AffectsAbilitytoCare xsi:nil="true"/&gt;
		          &lt;DevelopmentalAge xsi:nil="true"/&gt;
		          &lt;AffectsAbilitytoWork xsi:nil="true"/&gt;
		        &lt;/MedicalConditions&gt;
		        &lt;FamilyCareInformation&gt;
		          &lt;CareControlIndividuals/&gt;
		          &lt;IsFamilyCare xsi:nil="true"/&gt;
		        &lt;/FamilyCareInformation&gt;
		        &lt;FSTANFStatus xsi:nil="true"/&gt;
		        &lt;HaveYouBeenResidentOfPAFor90Days&gt;N&lt;/HaveYouBeenResidentOfPAFor90Days&gt;
		        &lt;Expense&gt;
		          &lt;LegalFeesPerMonthAmount xsi:nil="true"/&gt;
		          &lt;ChildOrDisabledAdultCareExpenses/&gt;
		          &lt;ChildSupportExpenses/&gt;
		          &lt;MedicalExpenses/&gt;
		          &lt;AlimonyExpenses/&gt;
		        &lt;/Expense&gt;
		        &lt;HighestGradeLevelCompleted&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/HighestGradeLevelCompleted&gt;
		        &lt;AliasMaidenNameORFormerMarriedName xsi:nil="true"/&gt;
		        &lt;ReferralInformation&gt;
		          &lt;ReferralMATerminationDate xsi:nil="true"/&gt;
		          &lt;ReferralReasonCode&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ReferralReasonCode&gt;
		          &lt;IsThisIndividualEmacipated xsi:nil="true"/&gt;
		        &lt;/ReferralInformation&gt;
		        &lt;HasAliasOrMaidenName xsi:nil="true"/&gt;
		        &lt;HispanicOrigin xsi:nil="true"/&gt;
		        &lt;SSNVerificationCode&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/SSNVerificationCode&gt;
		        &lt;PreventPregnancySurgery xsi:nil="true"/&gt;
		        &lt;ParentsOfThisChild&gt;
		          &lt;Parent2&gt;
		            &lt;IndividualNumber xsi:nil="true"/&gt;
		          &lt;/Parent2&gt;
		          &lt;Parent1&gt;
		            &lt;IndividualNumber xsi:nil="true"/&gt;
		          &lt;/Parent1&gt;
		        &lt;/ParentsOfThisChild&gt;
		        &lt;PregnancyDueDate xsi:nil="true"/&gt;
		        &lt;RenewalInformation&gt;
		          &lt;TargetSystemIndividualID xsi:nil="true"/&gt;
		          &lt;IsSSNProvidedByTargetSystem xsi:nil="true"/&gt;
		          &lt;IsThisIndividualNoLongerPresentInTheHousehold xsi:nil="true"/&gt;
		        &lt;/RenewalInformation&gt;
		        &lt;Relationships&gt;
		          &lt;Relationship&gt;
		            &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[2].individualNumber#&lt;/IndividualNumber&gt;
		            &lt;Code&gt;B&lt;/Code&gt;
		          &lt;/Relationship&gt;
		        &lt;/Relationships&gt;
		        &lt;SpouseDeathDate xsi:nil="true"/&gt;
		        &lt;SeparationDate xsi:nil="true"/&gt;
		        &lt;SocialSecurityNumber xsi:nil="true"/&gt;
		        &lt;FsOrTANFCaseNumber xsi:nil="true"/&gt;
		        &lt;LastName&gt;Individual&lt;/LastName&gt;
		        &lt;FSTANFIndividualEBTNumber xsi:nil="true"/&gt;
		        &lt;TrainingInformation&gt;
		          &lt;IsAttendingTraining xsi:nil="true"/&gt;
		          &lt;Trainings/&gt;
		        &lt;/TrainingInformation&gt;
		        &lt;FirstName&gt;First&lt;/FirstName&gt;
		        &lt;RaceInformation/&gt;
		        &lt;Sex&gt;
		          &lt;Code&gt;M&lt;/Code&gt;
		        &lt;/Sex&gt;
		        &lt;VeteranRelationInformation&gt;
		          &lt;DateVeteranEntered xsi:nil="true"/&gt;
		          &lt;DateVeteranLeft xsi:nil="true"/&gt;
		          &lt;VeteranName xsi:nil="true"/&gt;
		          &lt;BranchOfService&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/BranchOfService&gt;
		          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
		        &lt;/VeteranRelationInformation&gt;
		        &lt;MiddleInitial&gt;M&lt;/MiddleInitial&gt;
		        &lt;AppliedBenefits&gt;
		          &lt;Benefit&gt;
		            &lt;BenefitName&gt;
		              &lt;Code&gt;FS&lt;/Code&gt;
		            &lt;/BenefitName&gt;
		            &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
		            &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
		          &lt;/Benefit&gt;
		          &lt;Benefit&gt;
		            &lt;BenefitName&gt;
		              &lt;Code&gt;HC&lt;/Code&gt;
		            &lt;/BenefitName&gt;
		            &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
		            &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
		          &lt;/Benefit&gt;
		        &lt;/AppliedBenefits&gt;
		        &lt;IsFosterChild xsi:nil="true"/&gt;
		        &lt;IsHomeless xsi:nil="true"/&gt;
		        &lt;MigrantOrSeasonalWorker xsi:nil="true"/&gt;
		        &lt;TypeOfFacilityForWhichApplying&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/TypeOfFacilityForWhichApplying&gt;
		        &lt;IsRunaway xsi:nil="true"/&gt;
		        &lt;Suffix&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/Suffix&gt;
		        &lt;DateOfBirth&gt;2000-01-05&lt;/DateOfBirth&gt;
		        &lt;Education&gt;
		          &lt;SchoolCounty&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/SchoolCounty&gt;
		          &lt;TypeOfSchool&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/TypeOfSchool&gt;
		          &lt;RequiresChildCare xsi:nil="true"/&gt;
		          &lt;CurrentGrade xsi:nil="true"/&gt;
		          &lt;CharterOrPrivateSchoolType xsi:nil="true"/&gt;
		          &lt;SchoolBuilding xsi:nil="true"/&gt;
		          &lt;PartTimeORFullTime&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/PartTimeORFullTime&gt;
		          &lt;SchoolName xsi:nil="true"/&gt;
		          &lt;ExpectedGraduationDate xsi:nil="true"/&gt;
		          &lt;SchoolDistrict&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/SchoolDistrict&gt;
		        &lt;/Education&gt;
		        &lt;ReceivedLongTermCare&gt;
		          &lt;HowWereYourExpenseBeingPaid&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/HowWereYourExpenseBeingPaid&gt;
		        &lt;/ReceivedLongTermCare&gt;
		        &lt;ChildCare&gt;
		          &lt;CCScheduleNoOfHrs xsi:nil="true"/&gt;
		          &lt;ChildCareSchedule&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ChildCareSchedule&gt;
		        &lt;/ChildCare&gt;
		        &lt;InterestedToVote&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/InterestedToVote&gt;
		      &lt;/Individual&gt;
		      &lt;Individual&gt;
		        &lt;Qualification&gt;
		          &lt;TANForCashAssistance&gt;
		            &lt;State&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/State&gt;
		          &lt;/TANForCashAssistance&gt;
		          &lt;WasSSIStoppedBecauseSocialSecurityIncreased xsi:nil="true"/&gt;
		          &lt;WasSSIStoppedBecauseSocialSecurityStarted xsi:nil="true"/&gt;
		        &lt;/Qualification&gt;
		        &lt;MaritalStatus&gt;
		          &lt;Code&gt;1&lt;/Code&gt;
		        &lt;/MaritalStatus&gt;
		        &lt;Citizenship&gt;
		          &lt;BirthCounty xsi:nil="true"/&gt;
		          &lt;OtherCountry xsi:nil="true"/&gt;
		          &lt;MothersMaidenFirstName xsi:nil="true"/&gt;
		          &lt;DateEnteredUS xsi:nil="true"/&gt;
		          &lt;BirthState&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/BirthState&gt;
		          &lt;BirthLastName xsi:nil="true"/&gt;
		          &lt;Country&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/Country&gt;
		          &lt;MothersMaidenLastName xsi:nil="true"/&gt;
		          &lt;BirthFirstName xsi:nil="true"/&gt;
		          &lt;Identification&gt;
		            &lt;LicensedState&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/LicensedState&gt;
		            &lt;DriversLicenceNumberOrStateId xsi:nil="true"/&gt;
		            &lt;Name xsi:nil="true"/&gt;
		          &lt;/Identification&gt;
		          &lt;Sponsor&gt;
		            &lt;Address&gt;
		              &lt;AddressLine2 xsi:nil="true"/&gt;
		              &lt;ZIPExtension xsi:nil="true"/&gt;
		              &lt;City xsi:nil="true"/&gt;
		              &lt;State&gt;
		                &lt;Code xsi:nil="true"/&gt;
		              &lt;/State&gt;
		              &lt;AddressLine1 xsi:nil="true"/&gt;
		              &lt;ZIP xsi:nil="true"/&gt;
		            &lt;/Address&gt;
		            &lt;MiddleInitial xsi:nil="true"/&gt;
		            &lt;LastName xsi:nil="true"/&gt;
		            &lt;HaveASponsor xsi:nil="true"/&gt;
		            &lt;Type xsi:nil="true"/&gt;
		            &lt;SponsorOrganizationName xsi:nil="true"/&gt;
		            &lt;FirstName xsi:nil="true"/&gt;
		          &lt;/Sponsor&gt;
		          &lt;INSSection xsi:nil="true"/&gt;
		          &lt;CitizenshipCode&gt;1&lt;/CitizenshipCode&gt;
		          &lt;BirthCity xsi:nil="true"/&gt;
		          &lt;AlienRegistrationNumber xsi:nil="true"/&gt;
		        &lt;/Citizenship&gt;
		        &lt;IsThisPersonAStudent&gt;N&lt;/IsThisPersonAStudent&gt;
		        &lt;Income&gt;
		          &lt;OtherIncomeSources/&gt;
		          &lt;PastEmployment&gt;
		            &lt;MonthlyIncome xsi:nil="true"/&gt;
		            &lt;PayRate xsi:nil="true"/&gt;
		            &lt;PhoneNumber xsi:nil="true"/&gt;
		            &lt;NumberOfHoursWorkedPerWeek xsi:nil="true"/&gt;
		            &lt;EmploymentStartDate xsi:nil="true"/&gt;
		            &lt;IncomeFrequency&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/IncomeFrequency&gt;
		            &lt;GrossIncome xsi:nil="true"/&gt;
		            &lt;OnStrike xsi:nil="true"/&gt;
		            &lt;EmployerName xsi:nil="true"/&gt;
		            &lt;StrikeStartDate xsi:nil="true"/&gt;
		            &lt;EmploymentEndDate xsi:nil="true"/&gt;
		            &lt;MostRecentPayDate xsi:nil="true"/&gt;
		            &lt;ReferralIncomeVerification&gt;
		              &lt;Code xsi:nil="true"/&gt;
		            &lt;/ReferralIncomeVerification&gt;
		            &lt;TargetSystemIncomeId xsi:nil="true"/&gt;
		            &lt;EmployerAddress&gt;
		              &lt;AddressLine2 xsi:nil="true"/&gt;
		              &lt;ZIPExtension xsi:nil="true"/&gt;
		              &lt;City xsi:nil="true"/&gt;
		              &lt;State&gt;
		                &lt;Code xsi:nil="true"/&gt;
		              &lt;/State&gt;
		              &lt;AddressLine1 xsi:nil="true"/&gt;
		              &lt;ZIP xsi:nil="true"/&gt;
		            &lt;/EmployerAddress&gt;
		          &lt;/PastEmployment&gt;
		          &lt;Employment/&gt;
		        &lt;/Income&gt;
		        &lt;ImmunizationInfo&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/ImmunizationInfo&gt;
		        &lt;DeletedBenefits/&gt;
		        &lt;MonthlyIncome xsi:nil="true"/&gt;
		        &lt;ActiveMedicaidStatus xsi:nil="true"/&gt;
		        &lt;Veteran&gt;
		          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
		          &lt;DateVeteranEntered xsi:nil="true"/&gt;
		          &lt;BranchOfService&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/BranchOfService&gt;
		          &lt;DateVeteranLeft xsi:nil="true"/&gt;
		          &lt;Status&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/Status&gt;
		        &lt;/Veteran&gt;
		        &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[2].individualNumber#&lt;/IndividualNumber&gt;
		        &lt;BenefitsNotReceivedInformation&gt;
		          &lt;HasAppliedForBenefitButNotReceived xsi:nil="true"/&gt;
		          &lt;Benefits/&gt;
		        &lt;/BenefitsNotReceivedInformation&gt;
		        &lt;RepresentativeContactInformation&gt;
		          &lt;RepresentativeContactPersons/&gt;
		          &lt;HasRepresentativeAttorneyOrContact xsi:nil="true"/&gt;
		        &lt;/RepresentativeContactInformation&gt;
		        &lt;IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
		        &lt;Pregnant xsi:nil="true"/&gt;
		        &lt;HasThePrePopulatedDataChanged xsi:nil="true"/&gt;
		        &lt;ResidentInResidentialInstitution xsi:nil="true"/&gt;
		        &lt;MedicalConditions&gt;
		          &lt;ReceivingDisabilityIncome&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ReceivingDisabilityIncome&gt;
		          &lt;DisabilityType&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/DisabilityType&gt;
		          &lt;ChildDisabilityType&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ChildDisabilityType&gt;
		          &lt;DisabilityOnsetDate xsi:nil="true"/&gt;
		          &lt;DisabilityDescription xsi:nil="true"/&gt;
		          &lt;AffectsAbilitytoCare xsi:nil="true"/&gt;
		          &lt;DevelopmentalAge xsi:nil="true"/&gt;
		          &lt;AffectsAbilitytoWork xsi:nil="true"/&gt;
		        &lt;/MedicalConditions&gt;
		        &lt;FamilyCareInformation&gt;
		          &lt;CareControlIndividuals/&gt;
		          &lt;IsFamilyCare xsi:nil="true"/&gt;
		        &lt;/FamilyCareInformation&gt;
		        &lt;FSTANFStatus xsi:nil="true"/&gt;
		        &lt;HaveYouBeenResidentOfPAFor90Days&gt;N&lt;/HaveYouBeenResidentOfPAFor90Days&gt;
		        &lt;Expense&gt;
		          &lt;LegalFeesPerMonthAmount xsi:nil="true"/&gt;
		          &lt;ChildOrDisabledAdultCareExpenses/&gt;
		          &lt;ChildSupportExpenses/&gt;
		          &lt;MedicalExpenses/&gt;
		          &lt;AlimonyExpenses/&gt;
		        &lt;/Expense&gt;
		        &lt;HighestGradeLevelCompleted&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/HighestGradeLevelCompleted&gt;
		        &lt;AliasMaidenNameORFormerMarriedName xsi:nil="true"/&gt;
		        &lt;ReferralInformation&gt;
		          &lt;ReferralMATerminationDate xsi:nil="true"/&gt;
		          &lt;ReferralReasonCode&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ReferralReasonCode&gt;
		          &lt;IsThisIndividualEmacipated xsi:nil="true"/&gt;
		        &lt;/ReferralInformation&gt;
		        &lt;HasAliasOrMaidenName xsi:nil="true"/&gt;
		        &lt;HispanicOrigin xsi:nil="true"/&gt;
		        &lt;SSNVerificationCode&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/SSNVerificationCode&gt;
		        &lt;PreventPregnancySurgery xsi:nil="true"/&gt;
		        &lt;ParentsOfThisChild&gt;
		          &lt;Parent2&gt;
		            &lt;IndividualNumber xsi:nil="true"/&gt;
		          &lt;/Parent2&gt;
		          &lt;Parent1&gt;
		            &lt;IndividualNumber xsi:nil="true"/&gt;
		          &lt;/Parent1&gt;
		        &lt;/ParentsOfThisChild&gt;
		        &lt;PregnancyDueDate xsi:nil="true"/&gt;
		        &lt;RenewalInformation&gt;
		          &lt;TargetSystemIndividualID xsi:nil="true"/&gt;
		          &lt;IsSSNProvidedByTargetSystem xsi:nil="true"/&gt;
		          &lt;IsThisIndividualNoLongerPresentInTheHousehold xsi:nil="true"/&gt;
		        &lt;/RenewalInformation&gt;
		        &lt;Relationships&gt;
		          &lt;Relationship&gt;
		            &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
		            &lt;Code&gt;B&lt;/Code&gt;
		          &lt;/Relationship&gt;
		        &lt;/Relationships&gt;
		        &lt;SpouseDeathDate xsi:nil="true"/&gt;
		        &lt;SeparationDate xsi:nil="true"/&gt;
		        &lt;SocialSecurityNumber xsi:nil="true"/&gt;
		        &lt;FsOrTANFCaseNumber xsi:nil="true"/&gt;
		        &lt;LastName&gt;Individual&lt;/LastName&gt;
		        &lt;FSTANFIndividualEBTNumber xsi:nil="true"/&gt;
		        &lt;TrainingInformation&gt;
		          &lt;IsAttendingTraining xsi:nil="true"/&gt;
		          &lt;Trainings/&gt;
		        &lt;/TrainingInformation&gt;
		        &lt;FirstName&gt;Second&lt;/FirstName&gt;
		        &lt;RaceInformation/&gt;
		        &lt;Sex&gt;
		          &lt;Code&gt;M&lt;/Code&gt;
		        &lt;/Sex&gt;
		        &lt;VeteranRelationInformation&gt;
		          &lt;DateVeteranEntered xsi:nil="true"/&gt;
		          &lt;DateVeteranLeft xsi:nil="true"/&gt;
		          &lt;VeteranName xsi:nil="true"/&gt;
		          &lt;BranchOfService&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/BranchOfService&gt;
		          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
		        &lt;/VeteranRelationInformation&gt;
		        &lt;MiddleInitial&gt;M&lt;/MiddleInitial&gt;
		        &lt;AppliedBenefits&gt;
		          &lt;Benefit&gt;
		            &lt;BenefitName&gt;
		              &lt;Code&gt;FS&lt;/Code&gt;
		            &lt;/BenefitName&gt;
		            &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
		            &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
		          &lt;/Benefit&gt;
		        &lt;/AppliedBenefits&gt;
		        &lt;IsFosterChild xsi:nil="true"/&gt;
		        &lt;IsHomeless xsi:nil="true"/&gt;
		        &lt;MigrantOrSeasonalWorker xsi:nil="true"/&gt;
		        &lt;TypeOfFacilityForWhichApplying&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/TypeOfFacilityForWhichApplying&gt;
		        &lt;IsRunaway xsi:nil="true"/&gt;
		        &lt;Suffix&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/Suffix&gt;
		        &lt;DateOfBirth&gt;2011-01-04&lt;/DateOfBirth&gt;
		        &lt;Education&gt;
		          &lt;SchoolCounty&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/SchoolCounty&gt;
		          &lt;TypeOfSchool&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/TypeOfSchool&gt;
		          &lt;RequiresChildCare xsi:nil="true"/&gt;
		          &lt;CurrentGrade xsi:nil="true"/&gt;
		          &lt;CharterOrPrivateSchoolType xsi:nil="true"/&gt;
		          &lt;SchoolBuilding xsi:nil="true"/&gt;
		          &lt;PartTimeORFullTime&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/PartTimeORFullTime&gt;
		          &lt;SchoolName xsi:nil="true"/&gt;
		          &lt;ExpectedGraduationDate xsi:nil="true"/&gt;
		          &lt;SchoolDistrict&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/SchoolDistrict&gt;
		        &lt;/Education&gt;
		        &lt;ReceivedLongTermCare&gt;
		          &lt;HowWereYourExpenseBeingPaid&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/HowWereYourExpenseBeingPaid&gt;
		        &lt;/ReceivedLongTermCare&gt;
		        &lt;ChildCare&gt;
		          &lt;CCScheduleNoOfHrs xsi:nil="true"/&gt;
		          &lt;ChildCareSchedule&gt;
		            &lt;Code xsi:nil="true"/&gt;
		          &lt;/ChildCareSchedule&gt;
		        &lt;/ChildCare&gt;
		        &lt;InterestedToVote&gt;
		          &lt;Code xsi:nil="true"/&gt;
		        &lt;/InterestedToVote&gt;
		      &lt;/Individual&gt;
		    &lt;/Individuals&gt;
		    &lt;DeletedIndividuals/&gt;
		  &lt;/People&gt;
		&lt;/CompassApplication&gt;</ns0:ApplicationDataXml>
		        <ns0:XmlMetadaCollection xsi:nil="true"/>
		        <ns0:ProgramCollection>
		          <ns0:ProgramDC>
		            <ns0:AppliedBenefit>FS</ns0:AppliedBenefit>
		            <ns0:IsRenewal>N</ns0:IsRenewal>
		            <ns0:PostScreeningType xsi:nil="true"/>
		            <ns0:ApplicationProcessingCode xsi:nil="true"/>
		            <ns0:PostScreeningResult>false</ns0:PostScreeningResult>
		          </ns0:ProgramDC>
		          <ns0:ProgramDC>
		            <ns0:AppliedBenefit>HC</ns0:AppliedBenefit>
		            <ns0:IsRenewal>N</ns0:IsRenewal>
		            <ns0:PostScreeningType xsi:nil="true"/>
		            <ns0:ApplicationProcessingCode xsi:nil="true"/>
		            <ns0:PostScreeningResult>false</ns0:PostScreeningResult>
		          </ns0:ProgramDC>
		        </ns0:ProgramCollection>
		        <ns0:IndividualCollection>
		          <cfloop from="1" to="#ArrayLen(arguments.soapData.INDIVIDUALIDENTIFIERDC)#" index="i">
			          <ns0:IndividualDC>
			            <ns0:IndividualNumber>#arguments.soapData.INDIVIDUALIDENTIFIERDC[i].individualNumber#</ns0:IndividualNumber>
			            <ns0:SequenceNumber xsi:nil="true"/>
			            <ns0:FirstName>First</ns0:FirstName>
			            <ns0:LastName>Individual</ns0:LastName>
			            <ns0:DateOfBirth>2000-01-05T05:00:00Z</ns0:DateOfBirth>
			            <ns0:SocialSecurityNumber>0</ns0:SocialSecurityNumber>
			            <ns0:IsHeadOfHousehold>Y</ns0:IsHeadOfHousehold>
			            <ns0:ProgramsCollection>
			              <ns0:IndividualProgramsDC>
			                <ns0:AppliedBenefit>FS</ns0:AppliedBenefit>
			                <ns0:IsSentByTargetSystem>N</ns0:IsSentByTargetSystem>
			                <ns0:isThisIndividualRenewing>N</ns0:isThisIndividualRenewing>
			              </ns0:IndividualProgramsDC>
			              <ns0:IndividualProgramsDC>
			                <ns0:AppliedBenefit>HC</ns0:AppliedBenefit>
			                <ns0:IsSentByTargetSystem>N</ns0:IsSentByTargetSystem>
			                <ns0:isThisIndividualRenewing>N</ns0:isThisIndividualRenewing>
			              </ns0:IndividualProgramsDC>
			            </ns0:ProgramsCollection>
			            <ns0:FosterIndicator xsi:nil="true"/>
			            <ns0:MigrantIndicator xsi:nil="true"/>
			            <ns0:RunawayIndicator xsi:nil="true"/>
			            <ns0:HomelessIndicator xsi:nil="true"/>
			            <ns0:FsTanfCode xsi:nil="true"/>
			            <ns0:MiddleInitial>M</ns0:MiddleInitial>
			            <ns0:Suffix xsi:nil="true"/>
			          </ns0:IndividualDC>
			         </cfloop>
		        </ns0:IndividualCollection>
		        <ns0:ChipOrABcontractorName xsi:nil="true"/>
		        <ns0:ChipOrABSelection xsi:nil="true"/>
		        <ns0:VerificationeSign xsi:nil="true"/>
		      </ns0:ApplicationDetailsData>
		      <ns0:SaveSequenceNumber>1</ns0:SaveSequenceNumber>
		      <ns0:ExpireToken>false</ns0:ExpireToken>
		    </ns0:SaveRequest>
		  </SOAP-ENV:Body>
		</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ApplicationProcess.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/ApplicationProcessService/SaveRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML">--->
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Eight.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Eight.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP EIGHT :: Save the application XML --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP NINE :: Determine verification documents to be submitted --->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:VerificationChecklistRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
			      <ns0:SecurityToken>#arguments.soapData.SecurityToken#</ns0:SecurityToken>
			    </ns0:VerificationChecklistRequest>
			  </SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/RulesManagementService.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/RulesManagementService/VerificationChecklistRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML">--->
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Nine.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Nine.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP NINE :: Determine verification documents to be submitted --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP TEN :: Save the application XML--->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:SaveRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
			      <ns0:SecurityToken xsi:nil="true"/>
			      <ns0:ApplicationDetailsData>
			        <ns0:County>01</ns0:County>
			        <ns0:SchoolDistrict>01110</ns0:SchoolDistrict>
			        <ns0:ApplicationType>W</ns0:ApplicationType>
			        <ns0:Applicationlanguage>1</ns0:Applicationlanguage>
			        <ns0:PrintLanguage>#arguments.soapData.PrintLanguage#</ns0:PrintLanguage>
			        <ns0:PrintStatus>#arguments.soapData.PrintStatus#</ns0:PrintStatus>
			        <ns0:CPOrganizationId>#arguments.soapData.OrganizationId#</ns0:CPOrganizationId>
			        <ns0:CpUserId>#arguments.soapData.USER#</ns0:CpUserId>
			        <ns0:NavigationMetaData>tab=0&amp;crd=0&amp;sec=7&amp;GS=Green&amp;HH=Green&amp;BN=Green&amp;ID=Green&amp;IN=Green&amp;EX=Green&amp;INS=Green&amp;WQ=Green&amp;RS=White&amp;SMR=White&amp;NS=White&amp;VER=White&amp;SUB=White</ns0:NavigationMetaData>
			        <ns0:ApplicationDataXml>&lt;CompassApplication xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&gt;
			  &lt;ApplicationNumber&gt;W9200208&lt;/ApplicationNumber&gt;
			  &lt;Household&gt;
			    &lt;OtherHouseholdSchoolDistrict xsi:nil="true"/&gt;
			    &lt;Qualification&gt;
			      &lt;ReceivedTANFinPasts6Months&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/ReceivedTANFinPasts6Months&gt;
			      &lt;HasAnyoneReceivedSSIInThePast&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/HasAnyoneReceivedSSIInThePast&gt;
			      &lt;ReceivingTANF&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/ReceivingTANF&gt;
			      &lt;AnyOneHasPaidMedicalBills&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/AnyOneHasPaidMedicalBills&gt;
			      &lt;ReceivingFS&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/ReceivingFS&gt;
			      &lt;DoesAnyOneHavePermanentDisabilityOrSpecialHealthCare&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/DoesAnyOneHavePermanentDisabilityOrSpecialHealthCare&gt;
			      &lt;HasAnyOneReceivedSSDInThePast&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasAnyOneReceivedSSDInThePast&gt;
			      &lt;AnyOneHasUnpaidMedicalBills&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/AnyOneHasUnpaidMedicalBills&gt;
			      &lt;AnyOneReceivingProtectiveServicesAsVictimOfDomesticViolence xsi:nil="true"/&gt;
			      &lt;AnyOneReceivingTreatmentForAlcoholOrDrugProblem xsi:nil="true"/&gt;
			      &lt;AnyOneDisabledBlindSeriouslyIllOrHasAlcoholOrDrugProblem xsi:nil="true"/&gt;
			    &lt;/Qualification&gt;
			    &lt;CCISOffice&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/CCISOffice&gt;
			    &lt;WhoHasBeenConvictedAFelony&gt;
			      &lt;IndividualNumbers/&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/WhoHasBeenConvictedAFelony&gt;
			    &lt;DistrictOffice&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/DistrictOffice&gt;
			    &lt;NumberOfMonthsInPA xsi:nil="true"/&gt;
			    &lt;Resources&gt;
			      &lt;HasMemberReceivedLongTermCare&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMemberReceivedLongTermCare&gt;
			      &lt;AnyoneClosedOrDepletedAccounts&gt;
			        &lt;ClosedAccounts/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyoneClosedOrDepletedAccounts&gt;
			      &lt;AnyOneEstablishTrust&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyOneEstablishTrust&gt;
			      &lt;AnyoneExpectingAnyResources&gt;
			        &lt;ExpectingMoneyCollection/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyoneExpectingAnyResources&gt;
			      &lt;AnyoneHaveCash&gt;
			        &lt;CashCollection/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyoneHaveCash&gt;
			      &lt;AnyoneBuyingNonResidentProperty&gt;
			        &lt;NonResidentialProperties/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyoneBuyingNonResidentProperty&gt;
			      &lt;HasMemberSoldTransferedProperty&gt;
			        &lt;SoldTransferredProperties/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMemberSoldTransferedProperty&gt;
			      &lt;AnyOwnORBuyingVehicle&gt;
			        &lt;Vehicles/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyOwnORBuyingVehicle&gt;
			      &lt;AnyoneHaveLifeInsurancePolicy&gt;
			        &lt;LifeInsuranceCollection/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyoneHaveLifeInsurancePolicy&gt;
			      &lt;AnyoneOwnBurialSpaceORPlot&gt;
			        &lt;BurialSpaces/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyoneOwnBurialSpaceORPlot&gt;
			      &lt;AnyoneHaveBurialORTrustAgreementWithBankORFuneralHome&gt;
			        &lt;BurialTrustAgreements/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/AnyoneHaveBurialORTrustAgreementWithBankORFuneralHome&gt;
			    &lt;/Resources&gt;
			    &lt;MobilePhoneNumber xsi:nil="true"/&gt;
			    &lt;HaveYouReceivedBenefitsInPA xsi:nil="true"/&gt;
			    &lt;FromHowManyYearsAtThisAddress xsi:nil="true"/&gt;
			    &lt;WhoHasBeenIssuedASummons&gt;
			      &lt;IndividualNumbers/&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/WhoHasBeenIssuedASummons&gt;
			    &lt;WhoWasConvictedForWelfareFraud&gt;
			      &lt;IndividualNumbers/&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/WhoWasConvictedForWelfareFraud&gt;
			    &lt;ApplicantAddress&gt;
			      &lt;City&gt;Camp Hill&lt;/City&gt;
			      &lt;State&gt;
			        &lt;Code&gt;PA&lt;/Code&gt;
			      &lt;/State&gt;
			      &lt;AddressLine1&gt;Corporate center&lt;/AddressLine1&gt;
			      &lt;AddressLine2 xsi:nil="true"/&gt;
			      &lt;ZIPExtension xsi:nil="true"/&gt;
			      &lt;ZIP&gt;17011&lt;/ZIP&gt;
			    &lt;/ApplicantAddress&gt;
			    &lt;OtherCurrentHousingSituation xsi:nil="true"/&gt;
			    &lt;IsWeatherizationSelected&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/IsWeatherizationSelected&gt;
			    &lt;VerficationDocumentInformation&gt;
			      &lt;Departments/&gt;
			    &lt;/VerficationDocumentInformation&gt;
			    &lt;FoodStampRepresentativeInformation&gt;
			      &lt;FoodStampsRepresentativeAvailable xsi:nil="true"/&gt;
			      &lt;FoodStampRepresentativeName xsi:nil="true"/&gt;
			      &lt;FoodStampRepresentativeAddress&gt;
			        &lt;AddressLine2 xsi:nil="true"/&gt;
			        &lt;ZIPExtension xsi:nil="true"/&gt;
			        &lt;City xsi:nil="true"/&gt;
			        &lt;State&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/State&gt;
			        &lt;AddressLine1 xsi:nil="true"/&gt;
			        &lt;ZIP xsi:nil="true"/&gt;
			      &lt;/FoodStampRepresentativeAddress&gt;
			      &lt;SocialSecurityNumber xsi:nil="true"/&gt;
			      &lt;PhoneNumber xsi:nil="true"/&gt;
			    &lt;/FoodStampRepresentativeInformation&gt;
			    &lt;InsuranceInformation&gt;
			      &lt;HealthInsuranceForChildrenFromWork&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HealthInsuranceForChildrenFromWork&gt;
			      &lt;DoesAnyoneHaveHealthInsurance&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/DoesAnyoneHaveHealthInsurance&gt;
			      &lt;DidAnyoneApplyingForHaveHealthInsuranceInLast90Days&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/DidAnyoneApplyingForHaveHealthInsuranceInLast90Days&gt;
			      &lt;DidAnyOfTheChildrenLoseInsuranceInPast6Months&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/DidAnyOfTheChildrenLoseInsuranceInPast6Months&gt;
			      &lt;Insurances/&gt;
			      &lt;DidTheyApplyForUnemploymentCompensation&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/DidTheyApplyForUnemploymentCompensation&gt;
			      &lt;IndividualHaveToPayForChildren&gt;
			        &lt;IndividualNumbers/&gt;
			      &lt;/IndividualHaveToPayForChildren&gt;
			      &lt;HasMemberCanGetInsuranceThroughJob&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMemberCanGetInsuranceThroughJob&gt;
			      &lt;IndividualHaveToPayForIt&gt;
			        &lt;IndividualNumbers/&gt;
			      &lt;/IndividualHaveToPayForIt&gt;
			    &lt;/InsuranceInformation&gt;
			    &lt;WhoIsCurrentlyFleeingFromLawEnforcementOfficials&gt;
			      &lt;IndividualNumbers/&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/WhoIsCurrentlyFleeingFromLawEnforcementOfficials&gt;
			    &lt;PreviousAddress&gt;
			      &lt;AddressLine2 xsi:nil="true"/&gt;
			      &lt;ZIPExtension xsi:nil="true"/&gt;
			      &lt;City xsi:nil="true"/&gt;
			      &lt;State&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/State&gt;
			      &lt;AddressLine1 xsi:nil="true"/&gt;
			      &lt;ZIP xsi:nil="true"/&gt;
			    &lt;/PreviousAddress&gt;
			    &lt;AdmissionDate xsi:nil="true"/&gt;
			    &lt;FromHowManyMonthsAtThisAddress xsi:nil="true"/&gt;
			    &lt;County&gt;
			      &lt;Code&gt;01&lt;/Code&gt;
			    &lt;/County&gt;
			    &lt;Expenses&gt;
			      &lt;DidTheHouseholdGetEnergyAssistanceSinceOctoberFirst xsi:nil="true"/&gt;
			      &lt;HasMemberPaysCareToAttendTraining&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMemberPaysCareToAttendTraining&gt;
			      &lt;SharesWithNonMember/&gt;
			      &lt;HasMembersPaysLegalFees&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMembersPaysLegalFees&gt;
			      &lt;HasMemberDrivesOrPaysWorkTransportation&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMemberDrivesOrPaysWorkTransportation&gt;
			      &lt;MealsIncludedInRent xsi:nil="true"/&gt;
			      &lt;HasMembersPaysAlimonyToNonMember&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMembersPaysAlimonyToNonMember&gt;
			      &lt;HasMembersPaysChildSupportToNonMember&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMembersPaysChildSupportToNonMember&gt;
			      &lt;HasMemeberPayForChildcareOrDisabledAdultCareToGoToWork&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMemeberPayForChildcareOrDisabledAdultCareToGoToWork&gt;
			      &lt;HasMemberPaysShelterOrUtilityExpenses&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMemberPaysShelterOrUtilityExpenses&gt;
			      &lt;HouseHoldShareExpense xsi:nil="true"/&gt;
			      &lt;UtilityExpense&gt;
			        &lt;FuelCostForHouse xsi:nil="true"/&gt;
			        &lt;UtilityOrFuelCompany&gt;
			          &lt;UtilityCompanyName xsi:nil="true"/&gt;
			          &lt;UtilityCompanyAccountNumber xsi:nil="true"/&gt;
			          &lt;Address&gt;
			            &lt;AddressLine2 xsi:nil="true"/&gt;
			            &lt;ZIPExtension xsi:nil="true"/&gt;
			            &lt;City xsi:nil="true"/&gt;
			            &lt;State&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/State&gt;
			            &lt;AddressLine1 xsi:nil="true"/&gt;
			            &lt;ZIP xsi:nil="true"/&gt;
			          &lt;/Address&gt;
			        &lt;/UtilityOrFuelCompany&gt;
			        &lt;UtilityCostOtherThanHeatingOrCooling xsi:nil="true"/&gt;
			        &lt;PrimaryHeatingSource&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/PrimaryHeatingSource&gt;
			        &lt;FuelDeliveryDate xsi:nil="true"/&gt;
			        &lt;Utilities&gt;
			          &lt;DoesAnyonePayForGas&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForGas&gt;
			          &lt;DoesAnyonePayForRentOrMortgage&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForRentOrMortgage&gt;
			          &lt;DoesAnyonePayForHomeInsurance&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForHomeInsurance&gt;
			          &lt;DoesAnyonePayForGarbage&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForGarbage&gt;
			          &lt;DoesAnyonePayForPropertyTaxes&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForPropertyTaxes&gt;
			          &lt;DoesAnyonePayForOilCoalWood&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForOilCoalWood&gt;
			          &lt;DoesAnyonePayForUtilityInstallationThisMonth&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForUtilityInstallationThisMonth&gt;
			          &lt;DoesAnyonePayForOtherUtilities&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForOtherUtilities&gt;
			          &lt;DoesAnyonePayForTelephone&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForTelephone&gt;
			          &lt;DoesAnyonePayForSewerage&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForSewerage&gt;
			          &lt;DoesAnyonePayForWater&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForWater&gt;
			          &lt;DoesAnyonePayForElectric&gt;
			            &lt;Frequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/Frequency&gt;
			            &lt;Code xsi:nil="true"/&gt;
			            &lt;Amount xsi:nil="true"/&gt;
			            &lt;NetExpenseAmount xsi:nil="true"/&gt;
			          &lt;/DoesAnyonePayForElectric&gt;
			        &lt;/Utilities&gt;
			        &lt;SecondaryHeatingSource&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/SecondaryHeatingSource&gt;
			        &lt;BilledSeparatelyForHeatingOrCooling xsi:nil="true"/&gt;
			        &lt;PayForHeatingOrCooling xsi:nil="true"/&gt;
			      &lt;/UtilityExpense&gt;
			      &lt;HasMembersPaidMedicalLastNintyDays&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/HasMembersPaidMedicalLastNintyDays&gt;
			    &lt;/Expenses&gt;
			    &lt;CurrentHousingSituation&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/CurrentHousingSituation&gt;
			    &lt;Income&gt;
			      &lt;PastEmployment&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/PastEmployment&gt;
			      &lt;NoIncomeExplanation xsi:nil="true"/&gt;
			      &lt;DoesAnyoneReceiveFinancialAssistanceForDisability xsi:nil="true"/&gt;
			      &lt;CurrentEmployment&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/CurrentEmployment&gt;
			      &lt;OtherIncome&gt;
			        &lt;IndividualNumbers/&gt;
			        &lt;Code&gt;N&lt;/Code&gt;
			      &lt;/OtherIncome&gt;
			    &lt;/Income&gt;
			    &lt;HousingAssistance&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/HousingAssistance&gt;
			    &lt;FoodStamps&gt;
			      &lt;TotalAssets xsi:nil="true"/&gt;
			      &lt;SubmitShortApplication xsi:nil="true"/&gt;
			      &lt;AnyoneMigrantWorker xsi:nil="true"/&gt;
			      &lt;HasReceivedFoodStamps xsi:nil="true"/&gt;
			      &lt;IncomeLowEnough xsi:nil="true"/&gt;
			      &lt;SubmitImmediately xsi:nil="true"/&gt;
			      &lt;ShelterLiving xsi:nil="true"/&gt;
			      &lt;RentExceedsIncome xsi:nil="true"/&gt;
			    &lt;/FoodStamps&gt;
			    &lt;PreviousBenefitInformation&gt;
			      &lt;AppliedORReceivedBenefitsInOtherState xsi:nil="true"/&gt;
			      &lt;PreviousStateBenefitDescription xsi:nil="true"/&gt;
			      &lt;PreviousCountyBenefitDescription xsi:nil="true"/&gt;
			    &lt;/PreviousBenefitInformation&gt;
			    &lt;HowtoContact&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/HowtoContact&gt;
			    &lt;AdditionalInformation&gt;
			      &lt;OptionalInformation xsi:nil="true"/&gt;
			      &lt;RequiredInterpreter&gt;#arguments.soapData.RequiredInterpreter#&lt;/RequiredInterpreter&gt;
			      &lt;LearnSource&gt;
			        &lt;Sources/&gt;
			        &lt;OtherLearnSource xsi:nil="true"/&gt;
			      &lt;/LearnSource&gt;
			      &lt;DoesAnyChildUnder21HaveParentNotLivingInHouseholdOrDeceased&gt;N&lt;/DoesAnyChildUnder21HaveParentNotLivingInHouseholdOrDeceased&gt;
			      &lt;DoesAnyoneNeedHelpForChildSupportOrInsuranceFromAbsentRelative&gt;N&lt;/DoesAnyoneNeedHelpForChildSupportOrInsuranceFromAbsentRelative&gt;
			      &lt;AnyOneHasASpouseNotLivingInHouseholdOrDeceased xsi:nil="true"/&gt;
			    &lt;/AdditionalInformation&gt;
			    &lt;CityTownship&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/CityTownship&gt;
			    &lt;WhoIsTheSelfRelationshipIndividual&gt;
			      &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
			    &lt;/WhoIsTheSelfRelationshipIndividual&gt;
			    &lt;DateMovedToPA xsi:nil="true"/&gt;
			    &lt;WhoIsOnProbationORParole&gt;
			      &lt;IndividualNumbers/&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/WhoIsOnProbationORParole&gt;
			    &lt;OtherHouseholdLanguagePreference xsi:nil="true"/&gt;
			    &lt;NursingHomeInformation&gt;
			      &lt;Address&gt;
			        &lt;AddressLine2 xsi:nil="true"/&gt;
			        &lt;ZIPExtension xsi:nil="true"/&gt;
			        &lt;City xsi:nil="true"/&gt;
			        &lt;State&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/State&gt;
			        &lt;AddressLine1 xsi:nil="true"/&gt;
			        &lt;ZIP xsi:nil="true"/&gt;
			      &lt;/Address&gt;
			      &lt;PreviouslyLivedInNursingFacility xsi:nil="true"/&gt;
			      &lt;NursingFacilityName xsi:nil="true"/&gt;
			      &lt;NursingFacilityEndDate xsi:nil="true"/&gt;
			      &lt;NursingFacilityStartDate xsi:nil="true"/&gt;
			    &lt;/NursingHomeInformation&gt;
			    &lt;FamilyHealthCareInformation&gt;
			      &lt;DoctorOrClinicAddress&gt;
			        &lt;AddressLine2 xsi:nil="true"/&gt;
			        &lt;ZIPExtension xsi:nil="true"/&gt;
			        &lt;City xsi:nil="true"/&gt;
			        &lt;State&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/State&gt;
			        &lt;AddressLine1 xsi:nil="true"/&gt;
			        &lt;ZIP xsi:nil="true"/&gt;
			      &lt;/DoctorOrClinicAddress&gt;
			      &lt;NameOfDoctorOrClinic xsi:nil="true"/&gt;
			    &lt;/FamilyHealthCareInformation&gt;
			    &lt;PreviousPhoneNumber xsi:nil="true"/&gt;
			    &lt;HouseholdLanguagePreference&gt;#arguments.soapData.HouseholdLanguagePreference#&lt;/HouseholdLanguagePreference&gt;
			    &lt;HouseholdSchoolDistrict&gt;
			      &lt;Code&gt;01110&lt;/Code&gt;
			    &lt;/HouseholdSchoolDistrict&gt;
			    &lt;WhoIsTheHeadOfHousehold&gt;
			      &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
			    &lt;/WhoIsTheHeadOfHousehold&gt;
			    &lt;CurrentLivingSituation&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/CurrentLivingSituation&gt;
			    &lt;DisqualifiedForAssistance xsi:nil="true"/&gt;
			    &lt;AppliedBenefitsWithDifferentNameORSSN xsi:nil="true"/&gt;
			    &lt;IsEveryoneApplyingForLI&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/IsEveryoneApplyingForLI&gt;
			    &lt;BestTimeToCall xsi:nil="true"/&gt;
			    &lt;DoYouChooseAnAuthorizedRepresentativeForFoodStampBenefits xsi:nil="true"/&gt;
			    &lt;WorkPhone&gt;
			      &lt;PhoneNumber xsi:nil="true"/&gt;
			      &lt;PhoneExtension xsi:nil="true"/&gt;
			    &lt;/WorkPhone&gt;
			    &lt;OtherCityTownship xsi:nil="true"/&gt;
			    &lt;AlternateMailingAddress&gt;
			      &lt;AlternateAddressEffectiveDate xsi:nil="true"/&gt;
			      &lt;Address&gt;
			        &lt;AddressLine2 xsi:nil="true"/&gt;
			        &lt;ZIPExtension xsi:nil="true"/&gt;
			        &lt;City xsi:nil="true"/&gt;
			        &lt;State&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/State&gt;
			        &lt;AddressLine1 xsi:nil="true"/&gt;
			        &lt;ZIP xsi:nil="true"/&gt;
			      &lt;/Address&gt;
			      &lt;IsThereAnAlternateMailingAddress xsi:nil="true"/&gt;
			      &lt;IsTheAddressEffectiveImmediately xsi:nil="true"/&gt;
			    &lt;/AlternateMailingAddress&gt;
			    &lt;PreviousCountyrecordNumber xsi:nil="true"/&gt;
			    &lt;EmailAddress xsi:nil="true"/&gt;
			    &lt;NumberOfYearsInPA xsi:nil="true"/&gt;
			    &lt;HomePhoneNumber xsi:nil="true"/&gt;
			  &lt;/Household&gt;
			  &lt;ApplicationInformation&gt;
			    &lt;RenewalInformation xsi:nil="true"/&gt;
			    &lt;LastSequenceNumberCreated&gt;3&lt;/LastSequenceNumberCreated&gt;
			    &lt;Comments xsi:nil="true"/&gt;
			    &lt;CommunityPartnerInformation&gt;
			      &lt;CommunityPartnerRightsRevoked xsi:nil="true"/&gt;
			      &lt;CommunityPartnerOrganizationID&gt;IDMUpgrade4530-1&lt;/CommunityPartnerOrganizationID&gt;
			      &lt;CommunityPartnerLastUserID xsi:nil="true"/&gt;
			      &lt;CommunityPartnerUserID&gt;b-kchetty&lt;/CommunityPartnerUserID&gt;
			    &lt;/CommunityPartnerInformation&gt;
			    &lt;ReferralIncomeScheduleIndicator&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/ReferralIncomeScheduleIndicator&gt;
			    &lt;SubmitServiceTargets/&gt;
			    &lt;PrintStatus&gt;#arguments.soapData.PrintStatus#&lt;/PrintStatus&gt;
			    &lt;ContractorInformation&gt;
			      &lt;ContractorName&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/ContractorName&gt;
			      &lt;ContractorTypeSelection&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/ContractorTypeSelection&gt;
			    &lt;/ContractorInformation&gt;
			    &lt;RequiredTranslator xsi:nil="true"/&gt;
			    &lt;OtherPrograms/&gt;
			    &lt;ProviderInformation&gt;
			      &lt;ProviderName&gt;IDM Upgrade&lt;/ProviderName&gt;
			      &lt;FWProjectName xsi:nil="true"/&gt;
			      &lt;CBOType&gt;TEST&lt;/CBOType&gt;
			      &lt;FWProjectID xsi:nil="true"/&gt;
			      &lt;ProviderType&gt;
			        &lt;Code&gt;C&lt;/Code&gt;
			      &lt;/ProviderType&gt;
			      &lt;FWContractorName xsi:nil="true"/&gt;
			      &lt;ProviderNumber xsi:nil="true"/&gt;
			      &lt;MedicalServiceType&gt;
			        &lt;Code xsi:nil="true"/&gt;
			      &lt;/MedicalServiceType&gt;
			      &lt;StartDateForHealthCareCoverage xsi:nil="true"/&gt;
			    &lt;/ProviderInformation&gt;
			    &lt;CompassSubmitDate xsi:nil="true"/&gt;
			    &lt;AgreedToRightsAndResponsibilities&gt;#arguments.soapData.AgreedToRightsAndResponsibilities#&lt;/AgreedToRightsAndResponsibilities&gt;
			    &lt;IsApplicationESigned&gt;#arguments.soapData.IsApplicationESigned#&lt;/IsApplicationESigned&gt;
			    &lt;Esignature&gt;
					&lt;Last4DigitsOfSSN xsi:nil="true"/&gt;
					&lt;CommunityPartnerInitials&gt;#arguments.soapData.CommunityPartnerInitials#&lt;/CommunityPartnerInitials&gt;
					&lt;ESignedIndividualNumber xsi:nil="true"/&gt;
					&lt;ESignatureAgreement&gt;
					&lt;Code&gt;Y&lt;/Code&gt;
					&lt;/ESignatureAgreement&gt;
					&lt;EsignedNoSSNIndicator&gt;
					&lt;Code xsi:nil="true"/&gt;
					&lt;/EsignedNoSSNIndicator&gt;
					&lt;IsESignedIndividualEmancipatedMinor&gt;
					&lt;Code xsi:nil="true"/&gt;
					&lt;/IsESignedIndividualEmancipatedMinor&gt;
				&lt;/Esignature&gt;
			    &lt;CCSTAFFAPPIndicator xsi:nil="true"/&gt;
			    &lt;EsignatureSelectionType&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/EsignatureSelectionType&gt;
			    &lt;ApplicationOrigin&gt;
			      &lt;Code&gt;C&lt;/Code&gt;
			    &lt;/ApplicationOrigin&gt;
			    &lt;LiheapProgramType&gt;
			      &lt;Code xsi:nil="true"/&gt;
			    &lt;/LiheapProgramType&gt;
			    &lt;ReleaseNumber xsi:nil="true"/&gt;
			    &lt;ApplicationLanguage&gt;
			      &lt;Code&gt;1&lt;/Code&gt;
			    &lt;/ApplicationLanguage&gt;
			    &lt;ApplicationType&gt;
			      &lt;Code&gt;W&lt;/Code&gt;
			    &lt;/ApplicationType&gt;
			    &lt;ApplicationStatus xsi:nil="true"/&gt;
			    &lt;ReferralId xsi:nil="true"/&gt;
			    &lt;MAWDInformation&gt;
			      &lt;ModeOfPaymentForMAWD xsi:nil="true"/&gt;
			      &lt;CoverageBeginForMAWD xsi:nil="true"/&gt;
			    &lt;/MAWDInformation&gt;
			    &lt;AppliedPrograms&gt;
			      &lt;Program&gt;
			        &lt;IsThisARenewal&gt;N&lt;/IsThisARenewal&gt;
			        &lt;Code&gt;FS&lt;/Code&gt;
			        &lt;TargetSystems/&gt;
			        &lt;RoutingLocation&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/RoutingLocation&gt;
			      &lt;/Program&gt;
			      &lt;Program&gt;
			        &lt;IsThisARenewal&gt;N&lt;/IsThisARenewal&gt;
			        &lt;Code&gt;HC&lt;/Code&gt;
			        &lt;TargetSystems/&gt;
			        &lt;RoutingLocation&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/RoutingLocation&gt;
			      &lt;/Program&gt;
			    &lt;/AppliedPrograms&gt;
			    &lt;PrintLanguage&gt;#arguments.soapData.PrintLanguage#&lt;/PrintLanguage&gt;
			  &lt;/ApplicationInformation&gt;
			  &lt;People&gt;
			    &lt;AbsentRelatives/&gt;
			    &lt;Individuals&gt;
			      &lt;Individual&gt;
			        &lt;Qualification&gt;
			          &lt;TANForCashAssistance&gt;
			            &lt;State&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/State&gt;
			          &lt;/TANForCashAssistance&gt;
			          &lt;WasSSIStoppedBecauseSocialSecurityIncreased xsi:nil="true"/&gt;
			          &lt;WasSSIStoppedBecauseSocialSecurityStarted xsi:nil="true"/&gt;
			        &lt;/Qualification&gt;
			        &lt;MaritalStatus&gt;
			          &lt;Code&gt;1&lt;/Code&gt;
			        &lt;/MaritalStatus&gt;
			        &lt;Citizenship&gt;
			          &lt;BirthCounty xsi:nil="true"/&gt;
			          &lt;OtherCountry xsi:nil="true"/&gt;
			          &lt;MothersMaidenFirstName xsi:nil="true"/&gt;
			          &lt;DateEnteredUS xsi:nil="true"/&gt;
			          &lt;BirthState&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/BirthState&gt;
			          &lt;BirthLastName xsi:nil="true"/&gt;
			          &lt;Country&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/Country&gt;
			          &lt;MothersMaidenLastName xsi:nil="true"/&gt;
			          &lt;BirthFirstName xsi:nil="true"/&gt;
			          &lt;Identification&gt;
			            &lt;LicensedState&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/LicensedState&gt;
			            &lt;DriversLicenceNumberOrStateId xsi:nil="true"/&gt;
			            &lt;Name xsi:nil="true"/&gt;
			          &lt;/Identification&gt;
			          &lt;Sponsor&gt;
			            &lt;Address&gt;
			              &lt;AddressLine2 xsi:nil="true"/&gt;
			              &lt;ZIPExtension xsi:nil="true"/&gt;
			              &lt;City xsi:nil="true"/&gt;
			              &lt;State&gt;
			                &lt;Code xsi:nil="true"/&gt;
			              &lt;/State&gt;
			              &lt;AddressLine1 xsi:nil="true"/&gt;
			              &lt;ZIP xsi:nil="true"/&gt;
			            &lt;/Address&gt;
			            &lt;MiddleInitial xsi:nil="true"/&gt;
			            &lt;LastName xsi:nil="true"/&gt;
			            &lt;HaveASponsor xsi:nil="true"/&gt;
			            &lt;Type xsi:nil="true"/&gt;
			            &lt;SponsorOrganizationName xsi:nil="true"/&gt;
			            &lt;FirstName xsi:nil="true"/&gt;
			          &lt;/Sponsor&gt;
			          &lt;INSSection xsi:nil="true"/&gt;
			          &lt;CitizenshipCode&gt;1&lt;/CitizenshipCode&gt;
			          &lt;BirthCity xsi:nil="true"/&gt;
			          &lt;AlienRegistrationNumber xsi:nil="true"/&gt;
			        &lt;/Citizenship&gt;
			        &lt;IsThisPersonAStudent&gt;N&lt;/IsThisPersonAStudent&gt;
			        &lt;Income&gt;
			          &lt;OtherIncomeSources/&gt;
			          &lt;PastEmployment&gt;
			            &lt;MonthlyIncome xsi:nil="true"/&gt;
			            &lt;PayRate xsi:nil="true"/&gt;
			            &lt;PhoneNumber xsi:nil="true"/&gt;
			            &lt;NumberOfHoursWorkedPerWeek xsi:nil="true"/&gt;
			            &lt;EmploymentStartDate xsi:nil="true"/&gt;
			            &lt;IncomeFrequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/IncomeFrequency&gt;
			            &lt;GrossIncome xsi:nil="true"/&gt;
			            &lt;OnStrike xsi:nil="true"/&gt;
			            &lt;EmployerName xsi:nil="true"/&gt;
			            &lt;StrikeStartDate xsi:nil="true"/&gt;
			            &lt;EmploymentEndDate xsi:nil="true"/&gt;
			            &lt;MostRecentPayDate xsi:nil="true"/&gt;
			            &lt;ReferralIncomeVerification&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/ReferralIncomeVerification&gt;
			            &lt;TargetSystemIncomeId xsi:nil="true"/&gt;
			            &lt;EmployerAddress&gt;
			              &lt;AddressLine2 xsi:nil="true"/&gt;
			              &lt;ZIPExtension xsi:nil="true"/&gt;
			              &lt;City xsi:nil="true"/&gt;
			              &lt;State&gt;
			                &lt;Code xsi:nil="true"/&gt;
			              &lt;/State&gt;
			              &lt;AddressLine1 xsi:nil="true"/&gt;
			              &lt;ZIP xsi:nil="true"/&gt;
			            &lt;/EmployerAddress&gt;
			          &lt;/PastEmployment&gt;
			          &lt;Employment/&gt;
			        &lt;/Income&gt;
			        &lt;ImmunizationInfo&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/ImmunizationInfo&gt;
			        &lt;DeletedBenefits/&gt;
			        &lt;MonthlyIncome xsi:nil="true"/&gt;
			        &lt;ActiveMedicaidStatus xsi:nil="true"/&gt;
			        &lt;Veteran&gt;
			          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
			          &lt;DateVeteranEntered xsi:nil="true"/&gt;
			          &lt;BranchOfService&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/BranchOfService&gt;
			          &lt;DateVeteranLeft xsi:nil="true"/&gt;
			          &lt;Status&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/Status&gt;
			        &lt;/Veteran&gt;
			        &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
			        &lt;BenefitsNotReceivedInformation&gt;
			          &lt;HasAppliedForBenefitButNotReceived&gt;N&lt;/HasAppliedForBenefitButNotReceived&gt;
			          &lt;Benefits/&gt;
			        &lt;/BenefitsNotReceivedInformation&gt;
			        &lt;RepresentativeContactInformation&gt;
			          &lt;RepresentativeContactPersons/&gt;
			          &lt;HasRepresentativeAttorneyOrContact xsi:nil="true"/&gt;
			        &lt;/RepresentativeContactInformation&gt;
			        &lt;IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
			        &lt;Pregnant xsi:nil="true"/&gt;
			        &lt;HasThePrePopulatedDataChanged xsi:nil="true"/&gt;
			        &lt;ResidentInResidentialInstitution xsi:nil="true"/&gt;
			        &lt;MedicalConditions&gt;
			          &lt;ReceivingDisabilityIncome&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ReceivingDisabilityIncome&gt;
			          &lt;DisabilityType&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/DisabilityType&gt;
			          &lt;ChildDisabilityType&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ChildDisabilityType&gt;
			          &lt;DisabilityOnsetDate xsi:nil="true"/&gt;
			          &lt;DisabilityDescription xsi:nil="true"/&gt;
			          &lt;AffectsAbilitytoCare xsi:nil="true"/&gt;
			          &lt;DevelopmentalAge xsi:nil="true"/&gt;
			          &lt;AffectsAbilitytoWork xsi:nil="true"/&gt;
			        &lt;/MedicalConditions&gt;
			        &lt;FamilyCareInformation&gt;
			          &lt;CareControlIndividuals/&gt;
			          &lt;IsFamilyCare xsi:nil="true"/&gt;
			        &lt;/FamilyCareInformation&gt;
			        &lt;FSTANFStatus xsi:nil="true"/&gt;
			        &lt;HaveYouBeenResidentOfPAFor90Days&gt;N&lt;/HaveYouBeenResidentOfPAFor90Days&gt;
			        &lt;Expense&gt;
			          &lt;LegalFeesPerMonthAmount xsi:nil="true"/&gt;
			          &lt;ChildOrDisabledAdultCareExpenses/&gt;
			          &lt;ChildSupportExpenses/&gt;
			          &lt;MedicalExpenses/&gt;
			          &lt;AlimonyExpenses/&gt;
			        &lt;/Expense&gt;
			        &lt;HighestGradeLevelCompleted&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/HighestGradeLevelCompleted&gt;
			        &lt;AliasMaidenNameORFormerMarriedName xsi:nil="true"/&gt;
			        &lt;ReferralInformation&gt;
			          &lt;ReferralMATerminationDate xsi:nil="true"/&gt;
			          &lt;ReferralReasonCode&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ReferralReasonCode&gt;
			          &lt;IsThisIndividualEmacipated xsi:nil="true"/&gt;
			        &lt;/ReferralInformation&gt;
			        &lt;HasAliasOrMaidenName xsi:nil="true"/&gt;
			        &lt;HispanicOrigin xsi:nil="true"/&gt;
			        &lt;SSNVerificationCode&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/SSNVerificationCode&gt;
			        &lt;PreventPregnancySurgery xsi:nil="true"/&gt;
			        &lt;ParentsOfThisChild&gt;
			          &lt;Parent2&gt;
			            &lt;IndividualNumber xsi:nil="true"/&gt;
			          &lt;/Parent2&gt;
			          &lt;Parent1&gt;
			            &lt;IndividualNumber xsi:nil="true"/&gt;
			          &lt;/Parent1&gt;
			        &lt;/ParentsOfThisChild&gt;
			        &lt;PregnancyDueDate xsi:nil="true"/&gt;
			        &lt;RenewalInformation&gt;
			          &lt;TargetSystemIndividualID xsi:nil="true"/&gt;
			          &lt;IsSSNProvidedByTargetSystem xsi:nil="true"/&gt;
			          &lt;IsThisIndividualNoLongerPresentInTheHousehold xsi:nil="true"/&gt;
			        &lt;/RenewalInformation&gt;
			        &lt;Relationships&gt;
			          &lt;Relationship&gt;
			            &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[2].individualNumber#&lt;/IndividualNumber&gt;
			            &lt;Code&gt;B&lt;/Code&gt;
			          &lt;/Relationship&gt;
			        &lt;/Relationships&gt;
			        &lt;SpouseDeathDate xsi:nil="true"/&gt;
			        &lt;SeparationDate xsi:nil="true"/&gt;
			        &lt;SocialSecurityNumber xsi:nil="true"/&gt;
			        &lt;FsOrTANFCaseNumber xsi:nil="true"/&gt;
			        &lt;LastName&gt;Individual&lt;/LastName&gt;
			        &lt;FSTANFIndividualEBTNumber xsi:nil="true"/&gt;
			        &lt;TrainingInformation&gt;
			          &lt;IsAttendingTraining xsi:nil="true"/&gt;
			          &lt;Trainings/&gt;
			        &lt;/TrainingInformation&gt;
			        &lt;FirstName&gt;First&lt;/FirstName&gt;
			        &lt;RaceInformation/&gt;
			        &lt;Sex&gt;
			          &lt;Code&gt;M&lt;/Code&gt;
			        &lt;/Sex&gt;
			        &lt;VeteranRelationInformation&gt;
			          &lt;DateVeteranEntered xsi:nil="true"/&gt;
			          &lt;DateVeteranLeft xsi:nil="true"/&gt;
			          &lt;VeteranName xsi:nil="true"/&gt;
			          &lt;BranchOfService&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/BranchOfService&gt;
			          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
			        &lt;/VeteranRelationInformation&gt;
			        &lt;MiddleInitial&gt;M&lt;/MiddleInitial&gt;
			        &lt;AppliedBenefits&gt;
			          &lt;Benefit&gt;
			            &lt;BenefitName&gt;
			              &lt;Code&gt;FS&lt;/Code&gt;
			            &lt;/BenefitName&gt;
			            &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
			            &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
			          &lt;/Benefit&gt;
			          &lt;Benefit&gt;
			            &lt;BenefitName&gt;
			              &lt;Code&gt;HC&lt;/Code&gt;
			            &lt;/BenefitName&gt;
			            &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
			            &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
			          &lt;/Benefit&gt;
			        &lt;/AppliedBenefits&gt;
			        &lt;IsFosterChild xsi:nil="true"/&gt;
			        &lt;IsHomeless xsi:nil="true"/&gt;
			        &lt;MigrantOrSeasonalWorker xsi:nil="true"/&gt;
			        &lt;TypeOfFacilityForWhichApplying&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/TypeOfFacilityForWhichApplying&gt;
			        &lt;IsRunaway xsi:nil="true"/&gt;
			        &lt;Suffix&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/Suffix&gt;
			        &lt;DateOfBirth&gt;2000-01-05&lt;/DateOfBirth&gt;
			        &lt;Education&gt;
			          &lt;SchoolCounty&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/SchoolCounty&gt;
			          &lt;TypeOfSchool&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/TypeOfSchool&gt;
			          &lt;RequiresChildCare xsi:nil="true"/&gt;
			          &lt;CurrentGrade xsi:nil="true"/&gt;
			          &lt;CharterOrPrivateSchoolType xsi:nil="true"/&gt;
			          &lt;SchoolBuilding xsi:nil="true"/&gt;
			          &lt;PartTimeORFullTime&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/PartTimeORFullTime&gt;
			          &lt;SchoolName xsi:nil="true"/&gt;
			          &lt;ExpectedGraduationDate xsi:nil="true"/&gt;
			          &lt;SchoolDistrict&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/SchoolDistrict&gt;
			        &lt;/Education&gt;
			        &lt;ReceivedLongTermCare&gt;
			          &lt;HowWereYourExpenseBeingPaid&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/HowWereYourExpenseBeingPaid&gt;
			        &lt;/ReceivedLongTermCare&gt;
			        &lt;ChildCare&gt;
			          &lt;CCScheduleNoOfHrs xsi:nil="true"/&gt;
			          &lt;ChildCareSchedule&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ChildCareSchedule&gt;
			        &lt;/ChildCare&gt;
			        &lt;InterestedToVote&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/InterestedToVote&gt;
			      &lt;/Individual&gt;
			      &lt;Individual&gt;
			        &lt;Qualification&gt;
			          &lt;TANForCashAssistance&gt;
			            &lt;State&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/State&gt;
			          &lt;/TANForCashAssistance&gt;
			          &lt;WasSSIStoppedBecauseSocialSecurityIncreased xsi:nil="true"/&gt;
			          &lt;WasSSIStoppedBecauseSocialSecurityStarted xsi:nil="true"/&gt;
			        &lt;/Qualification&gt;
			        &lt;MaritalStatus&gt;
			          &lt;Code&gt;1&lt;/Code&gt;
			        &lt;/MaritalStatus&gt;
			        &lt;Citizenship&gt;
			          &lt;BirthCounty xsi:nil="true"/&gt;
			          &lt;OtherCountry xsi:nil="true"/&gt;
			          &lt;MothersMaidenFirstName xsi:nil="true"/&gt;
			          &lt;DateEnteredUS xsi:nil="true"/&gt;
			          &lt;BirthState&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/BirthState&gt;
			          &lt;BirthLastName xsi:nil="true"/&gt;
			          &lt;Country&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/Country&gt;
			          &lt;MothersMaidenLastName xsi:nil="true"/&gt;
			          &lt;BirthFirstName xsi:nil="true"/&gt;
			          &lt;Identification&gt;
			            &lt;LicensedState&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/LicensedState&gt;
			            &lt;DriversLicenceNumberOrStateId xsi:nil="true"/&gt;
			            &lt;Name xsi:nil="true"/&gt;
			          &lt;/Identification&gt;
			          &lt;Sponsor&gt;
			            &lt;Address&gt;
			              &lt;AddressLine2 xsi:nil="true"/&gt;
			              &lt;ZIPExtension xsi:nil="true"/&gt;
			              &lt;City xsi:nil="true"/&gt;
			              &lt;State&gt;
			                &lt;Code xsi:nil="true"/&gt;
			              &lt;/State&gt;
			              &lt;AddressLine1 xsi:nil="true"/&gt;
			              &lt;ZIP xsi:nil="true"/&gt;
			            &lt;/Address&gt;
			            &lt;MiddleInitial xsi:nil="true"/&gt;
			            &lt;LastName xsi:nil="true"/&gt;
			            &lt;HaveASponsor xsi:nil="true"/&gt;
			            &lt;Type xsi:nil="true"/&gt;
			            &lt;SponsorOrganizationName xsi:nil="true"/&gt;
			            &lt;FirstName xsi:nil="true"/&gt;
			          &lt;/Sponsor&gt;
			          &lt;INSSection xsi:nil="true"/&gt;
			          &lt;CitizenshipCode&gt;1&lt;/CitizenshipCode&gt;
			          &lt;BirthCity xsi:nil="true"/&gt;
			          &lt;AlienRegistrationNumber xsi:nil="true"/&gt;
			        &lt;/Citizenship&gt;
			        &lt;IsThisPersonAStudent&gt;N&lt;/IsThisPersonAStudent&gt;
			        &lt;Income&gt;
			          &lt;OtherIncomeSources/&gt;
			          &lt;PastEmployment&gt;
			            &lt;MonthlyIncome xsi:nil="true"/&gt;
			            &lt;PayRate xsi:nil="true"/&gt;
			            &lt;PhoneNumber xsi:nil="true"/&gt;
			            &lt;NumberOfHoursWorkedPerWeek xsi:nil="true"/&gt;
			            &lt;EmploymentStartDate xsi:nil="true"/&gt;
			            &lt;IncomeFrequency&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/IncomeFrequency&gt;
			            &lt;GrossIncome xsi:nil="true"/&gt;
			            &lt;OnStrike xsi:nil="true"/&gt;
			            &lt;EmployerName xsi:nil="true"/&gt;
			            &lt;StrikeStartDate xsi:nil="true"/&gt;
			            &lt;EmploymentEndDate xsi:nil="true"/&gt;
			            &lt;MostRecentPayDate xsi:nil="true"/&gt;
			            &lt;ReferralIncomeVerification&gt;
			              &lt;Code xsi:nil="true"/&gt;
			            &lt;/ReferralIncomeVerification&gt;
			            &lt;TargetSystemIncomeId xsi:nil="true"/&gt;
			            &lt;EmployerAddress&gt;
			              &lt;AddressLine2 xsi:nil="true"/&gt;
			              &lt;ZIPExtension xsi:nil="true"/&gt;
			              &lt;City xsi:nil="true"/&gt;
			              &lt;State&gt;
			                &lt;Code xsi:nil="true"/&gt;
			              &lt;/State&gt;
			              &lt;AddressLine1 xsi:nil="true"/&gt;
			              &lt;ZIP xsi:nil="true"/&gt;
			            &lt;/EmployerAddress&gt;
			          &lt;/PastEmployment&gt;
			          &lt;Employment/&gt;
			        &lt;/Income&gt;
			        &lt;ImmunizationInfo&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/ImmunizationInfo&gt;
			        &lt;DeletedBenefits/&gt;
			        &lt;MonthlyIncome xsi:nil="true"/&gt;
			        &lt;ActiveMedicaidStatus xsi:nil="true"/&gt;
			        &lt;Veteran&gt;
			          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
			          &lt;DateVeteranEntered xsi:nil="true"/&gt;
			          &lt;BranchOfService&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/BranchOfService&gt;
			          &lt;DateVeteranLeft xsi:nil="true"/&gt;
			          &lt;Status&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/Status&gt;
			        &lt;/Veteran&gt;
			        &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[2].individualNumber#&lt;/IndividualNumber&gt;
			        &lt;BenefitsNotReceivedInformation&gt;
			          &lt;HasAppliedForBenefitButNotReceived xsi:nil="true"/&gt;
			          &lt;Benefits/&gt;
			        &lt;/BenefitsNotReceivedInformation&gt;
			        &lt;RepresentativeContactInformation&gt;
			          &lt;RepresentativeContactPersons/&gt;
			          &lt;HasRepresentativeAttorneyOrContact xsi:nil="true"/&gt;
			        &lt;/RepresentativeContactInformation&gt;
			        &lt;IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/IsThisPersonASpouseWidowParentORMinorChildOfAVeteran&gt;
			        &lt;Pregnant xsi:nil="true"/&gt;
			        &lt;HasThePrePopulatedDataChanged xsi:nil="true"/&gt;
			        &lt;ResidentInResidentialInstitution xsi:nil="true"/&gt;
			        &lt;MedicalConditions&gt;
			          &lt;ReceivingDisabilityIncome&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ReceivingDisabilityIncome&gt;
			          &lt;DisabilityType&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/DisabilityType&gt;
			          &lt;ChildDisabilityType&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ChildDisabilityType&gt;
			          &lt;DisabilityOnsetDate xsi:nil="true"/&gt;
			          &lt;DisabilityDescription xsi:nil="true"/&gt;
			          &lt;AffectsAbilitytoCare xsi:nil="true"/&gt;
			          &lt;DevelopmentalAge xsi:nil="true"/&gt;
			          &lt;AffectsAbilitytoWork xsi:nil="true"/&gt;
			        &lt;/MedicalConditions&gt;
			        &lt;FamilyCareInformation&gt;
			          &lt;CareControlIndividuals/&gt;
			          &lt;IsFamilyCare xsi:nil="true"/&gt;
			        &lt;/FamilyCareInformation&gt;
			        &lt;FSTANFStatus xsi:nil="true"/&gt;
			        &lt;HaveYouBeenResidentOfPAFor90Days&gt;N&lt;/HaveYouBeenResidentOfPAFor90Days&gt;
			        &lt;Expense&gt;
			          &lt;LegalFeesPerMonthAmount xsi:nil="true"/&gt;
			          &lt;ChildOrDisabledAdultCareExpenses/&gt;
			          &lt;ChildSupportExpenses/&gt;
			          &lt;MedicalExpenses/&gt;
			          &lt;AlimonyExpenses/&gt;
			        &lt;/Expense&gt;
			        &lt;HighestGradeLevelCompleted&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/HighestGradeLevelCompleted&gt;
			        &lt;AliasMaidenNameORFormerMarriedName xsi:nil="true"/&gt;
			        &lt;ReferralInformation&gt;
			          &lt;ReferralMATerminationDate xsi:nil="true"/&gt;
			          &lt;ReferralReasonCode&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ReferralReasonCode&gt;
			          &lt;IsThisIndividualEmacipated xsi:nil="true"/&gt;
			        &lt;/ReferralInformation&gt;
			        &lt;HasAliasOrMaidenName xsi:nil="true"/&gt;
			        &lt;HispanicOrigin xsi:nil="true"/&gt;
			        &lt;SSNVerificationCode&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/SSNVerificationCode&gt;
			        &lt;PreventPregnancySurgery xsi:nil="true"/&gt;
			        &lt;ParentsOfThisChild&gt;
			          &lt;Parent2&gt;
			            &lt;IndividualNumber xsi:nil="true"/&gt;
			          &lt;/Parent2&gt;
			          &lt;Parent1&gt;
			            &lt;IndividualNumber xsi:nil="true"/&gt;
			          &lt;/Parent1&gt;
			        &lt;/ParentsOfThisChild&gt;
			        &lt;PregnancyDueDate xsi:nil="true"/&gt;
			        &lt;RenewalInformation&gt;
			          &lt;TargetSystemIndividualID xsi:nil="true"/&gt;
			          &lt;IsSSNProvidedByTargetSystem xsi:nil="true"/&gt;
			          &lt;IsThisIndividualNoLongerPresentInTheHousehold xsi:nil="true"/&gt;
			        &lt;/RenewalInformation&gt;
			        &lt;Relationships&gt;
			          &lt;Relationship&gt;
			            &lt;IndividualNumber&gt;#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#&lt;/IndividualNumber&gt;
			            &lt;Code&gt;B&lt;/Code&gt;
			          &lt;/Relationship&gt;
			        &lt;/Relationships&gt;
			        &lt;SpouseDeathDate xsi:nil="true"/&gt;
			        &lt;SeparationDate xsi:nil="true"/&gt;
			        &lt;SocialSecurityNumber xsi:nil="true"/&gt;
			        &lt;FsOrTANFCaseNumber xsi:nil="true"/&gt;
			        &lt;LastName&gt;Individual&lt;/LastName&gt;
			        &lt;FSTANFIndividualEBTNumber xsi:nil="true"/&gt;
			        &lt;TrainingInformation&gt;
			          &lt;IsAttendingTraining xsi:nil="true"/&gt;
			          &lt;Trainings/&gt;
			        &lt;/TrainingInformation&gt;
			        &lt;FirstName&gt;Second&lt;/FirstName&gt;
			        &lt;RaceInformation/&gt;
			        &lt;Sex&gt;
			          &lt;Code&gt;M&lt;/Code&gt;
			        &lt;/Sex&gt;
			        &lt;VeteranRelationInformation&gt;
			          &lt;DateVeteranEntered xsi:nil="true"/&gt;
			          &lt;DateVeteranLeft xsi:nil="true"/&gt;
			          &lt;VeteranName xsi:nil="true"/&gt;
			          &lt;BranchOfService&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/BranchOfService&gt;
			          &lt;VerteranClaimNumber xsi:nil="true"/&gt;
			        &lt;/VeteranRelationInformation&gt;
			        &lt;MiddleInitial&gt;M&lt;/MiddleInitial&gt;
			        &lt;AppliedBenefits&gt;
			          &lt;Benefit&gt;
			            &lt;BenefitName&gt;
			              &lt;Code&gt;FS&lt;/Code&gt;
			            &lt;/BenefitName&gt;
			            &lt;IsThisProgramSentByTarget&gt;N&lt;/IsThisProgramSentByTarget&gt;
			            &lt;IsThisRenewal&gt;N&lt;/IsThisRenewal&gt;
			          &lt;/Benefit&gt;
			        &lt;/AppliedBenefits&gt;
			        &lt;IsFosterChild xsi:nil="true"/&gt;
			        &lt;IsHomeless xsi:nil="true"/&gt;
			        &lt;MigrantOrSeasonalWorker xsi:nil="true"/&gt;
			        &lt;TypeOfFacilityForWhichApplying&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/TypeOfFacilityForWhichApplying&gt;
			        &lt;IsRunaway xsi:nil="true"/&gt;
			        &lt;Suffix&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/Suffix&gt;
			        &lt;DateOfBirth&gt;2011-01-04&lt;/DateOfBirth&gt;
			        &lt;Education&gt;
			          &lt;SchoolCounty&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/SchoolCounty&gt;
			          &lt;TypeOfSchool&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/TypeOfSchool&gt;
			          &lt;RequiresChildCare xsi:nil="true"/&gt;
			          &lt;CurrentGrade xsi:nil="true"/&gt;
			          &lt;CharterOrPrivateSchoolType xsi:nil="true"/&gt;
			          &lt;SchoolBuilding xsi:nil="true"/&gt;
			          &lt;PartTimeORFullTime&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/PartTimeORFullTime&gt;
			          &lt;SchoolName xsi:nil="true"/&gt;
			          &lt;ExpectedGraduationDate xsi:nil="true"/&gt;
			          &lt;SchoolDistrict&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/SchoolDistrict&gt;
			        &lt;/Education&gt;
			        &lt;ReceivedLongTermCare&gt;
			          &lt;HowWereYourExpenseBeingPaid&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/HowWereYourExpenseBeingPaid&gt;
			        &lt;/ReceivedLongTermCare&gt;
			        &lt;ChildCare&gt;
			          &lt;CCScheduleNoOfHrs xsi:nil="true"/&gt;
			          &lt;ChildCareSchedule&gt;
			            &lt;Code xsi:nil="true"/&gt;
			          &lt;/ChildCareSchedule&gt;
			        &lt;/ChildCare&gt;
			        &lt;InterestedToVote&gt;
			          &lt;Code xsi:nil="true"/&gt;
			        &lt;/InterestedToVote&gt;
			      &lt;/Individual&gt;
			    &lt;/Individuals&gt;
			    &lt;DeletedIndividuals/&gt;
			  &lt;/People&gt;
			&lt;/CompassApplication&gt;</ns0:ApplicationDataXml>
			        <ns0:XmlMetadaCollection xsi:nil="true"/>
			        <ns0:ProgramCollection>
			          <ns0:ProgramDC>
			            <ns0:AppliedBenefit>FS</ns0:AppliedBenefit>
			            <ns0:IsRenewal>N</ns0:IsRenewal>
			            <ns0:PostScreeningType xsi:nil="true"/>
			            <ns0:ApplicationProcessingCode xsi:nil="true"/>
			            <ns0:PostScreeningResult>false</ns0:PostScreeningResult>
			          </ns0:ProgramDC>
			          <ns0:ProgramDC>
			            <ns0:AppliedBenefit>HC</ns0:AppliedBenefit>
			            <ns0:IsRenewal>N</ns0:IsRenewal>
			            <ns0:PostScreeningType xsi:nil="true"/>
			            <ns0:ApplicationProcessingCode xsi:nil="true"/>
			            <ns0:PostScreeningResult>false</ns0:PostScreeningResult>
			          </ns0:ProgramDC>
			        </ns0:ProgramCollection>
			        <ns0:IndividualCollection>
			          <ns0:IndividualDC>
			            <ns0:IndividualNumber>#arguments.soapData.INDIVIDUALIDENTIFIERDC[1].individualNumber#</ns0:IndividualNumber>
			            <ns0:SequenceNumber xsi:nil="true"/>
			            <ns0:FirstName>First</ns0:FirstName>
			            <ns0:LastName>Individual</ns0:LastName>
			            <ns0:DateOfBirth>2000-01-05T05:00:00Z</ns0:DateOfBirth>
			            <ns0:SocialSecurityNumber>0</ns0:SocialSecurityNumber>
			            <ns0:IsHeadOfHousehold>Y</ns0:IsHeadOfHousehold>
			            <ns0:ProgramsCollection>
			              <ns0:IndividualProgramsDC>
			                <ns0:AppliedBenefit>FS</ns0:AppliedBenefit>
			                <ns0:IsSentByTargetSystem>N</ns0:IsSentByTargetSystem>
			                <ns0:isThisIndividualRenewing>N</ns0:isThisIndividualRenewing>
			              </ns0:IndividualProgramsDC>
			              <ns0:IndividualProgramsDC>
			                <ns0:AppliedBenefit>HC</ns0:AppliedBenefit>
			                <ns0:IsSentByTargetSystem>N</ns0:IsSentByTargetSystem>
			                <ns0:isThisIndividualRenewing>N</ns0:isThisIndividualRenewing>
			              </ns0:IndividualProgramsDC>
			            </ns0:ProgramsCollection>
			            <ns0:FosterIndicator xsi:nil="true"/>
			            <ns0:MigrantIndicator xsi:nil="true"/>
			            <ns0:RunawayIndicator xsi:nil="true"/>
			            <ns0:HomelessIndicator xsi:nil="true"/>
			            <ns0:FsTanfCode xsi:nil="true"/>
			            <ns0:MiddleInitial>M</ns0:MiddleInitial>
			            <ns0:Suffix xsi:nil="true"/>
			          </ns0:IndividualDC>
			          <ns0:IndividualDC>
			            <ns0:IndividualNumber>#arguments.soapData.INDIVIDUALIDENTIFIERDC[2].individualNumber#</ns0:IndividualNumber>
			            <ns0:SequenceNumber xsi:nil="true"/>
			            <ns0:FirstName>Second</ns0:FirstName>
			            <ns0:LastName>Individual</ns0:LastName>
			            <ns0:DateOfBirth>2011-01-04T05:00:00Z</ns0:DateOfBirth>
			            <ns0:SocialSecurityNumber>0</ns0:SocialSecurityNumber>
			            <ns0:IsHeadOfHousehold>N</ns0:IsHeadOfHousehold>
			            <ns0:ProgramsCollection>
			              <ns0:IndividualProgramsDC>
			                <ns0:AppliedBenefit>FS</ns0:AppliedBenefit>
			                <ns0:IsSentByTargetSystem>N</ns0:IsSentByTargetSystem>
			                <ns0:isThisIndividualRenewing>N</ns0:isThisIndividualRenewing>
			              </ns0:IndividualProgramsDC>
			            </ns0:ProgramsCollection>
			            <ns0:FosterIndicator xsi:nil="true"/>
			            <ns0:MigrantIndicator xsi:nil="true"/>
			            <ns0:RunawayIndicator xsi:nil="true"/>
			            <ns0:HomelessIndicator xsi:nil="true"/>
			            <ns0:FsTanfCode xsi:nil="true"/>
			            <ns0:MiddleInitial>M</ns0:MiddleInitial>
			            <ns0:Suffix xsi:nil="true"/>
			          </ns0:IndividualDC>
			        </ns0:IndividualCollection>
			        <ns0:ChipOrABcontractorName xsi:nil="true"/>
			        <ns0:ChipOrABSelection xsi:nil="true"/>
			        <ns0:VerificationeSign xsi:nil="true"/>
			      </ns0:ApplicationDetailsData>
			      <ns0:SaveSequenceNumber>4</ns0:SaveSequenceNumber>
			      <ns0:ExpireToken>false</ns0:ExpireToken>
			    </ns0:SaveRequest>
			  </SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ApplicationProcess.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/ApplicationProcessService/SaveRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<cfset arguments.soapData.SaveResponse.Completed = soapResponseStruct.SaveResponse.Completed>
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data - Step 10">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT - Step 10">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML - Step 10">--->
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Ten.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Ten.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP TEN :: Save the application XML --->
		
		<!--- BEGIN WEB SERVICE CALL - STEP ELEVEN :: Submit the application--->
		<!--- Build SOAP XML --->
		<cfsavecontent variable="soapBody">
			<cfoutput>	
			<?xml version="1.0" encoding="utf-8"?>
			<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			  <SOAP-ENV:Body>
			    <ns0:SubmitRequest xmlns:ns0="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12">
			      <ns0:ApplicationNumber>#arguments.soapData.ApplicationNumber#</ns0:ApplicationNumber>
			      <ns0:SecurityToken>#arguments.soapData.SecurityToken#</ns0:SecurityToken>
			    </ns0:SubmitRequest>
			  </SOAP-ENV:Body>
			</SOAP-ENV:Envelope>
			</cfoutput>
		</cfsavecontent>
		
		<cfhttp url="https://www.humanservices-t.state.pa.us/Compass.RIAServices/ApplicationProcess.svc/secured" charset="utf-8" method="POST" Result="httpResponse">
			<cfhttpparam type="header" name="Cookie" value="#SMString#">
			<cfhttpparam type="header" name="UserAgent" value="SM Client">
			<cfhttpparam type="header" name="SOAPAction" value="http://schemas.dpw.state.pa.us/IntegratedEligibility/COMPASS/RiaServices/2009/12/ApplicationProcessService/SubmitRequest">
			<cfhttpparam type="header" name="content-length" value="#len(soapBody)#">
			<cfhttpparam type="Header" name="charset" value="utf-8" />
		 	<cfhttpparam type="xml" value="#trim(soapBody)#">
		 	<cfhttpparam type="Header" name="Accept-Encoding" value="deflate;q=0">
		</cfhttp>
		
		<!--- Process service response --->
		<cfif find( "200", httpResponse.statusCode )>
		 
			<!--- Parse the XML SOAP response. --->
			<cfset soapResponse = xmlParse(Trim(httpResponse.fileContent)) />
			<!--- Get the BODY of the SOAP response --->
			<cfset soapResponseConvert = xmlSearch(soapResponse, "//s:Body")>
			<!--- Convert the XML to a Struct for easier access to the data --->
			<cfset soapResponseStruct =  ConvertXmlToStruct(soapResponseConvert[1], structnew())>
			
			<!---<cfdump var="#soapData#" label="SESSION SOAP data - Step 11">
			<cfdump var="#soapResponseStruct#" label="SOAP data converted in to STRUCT - Step 11">
			<cfdump var="#soapResponse#" label="SOAP data parsed XML - Step 11">--->
			
			<cfif IsDefined('soapResponseStruct.fault')>
				<P>ERROR: An error occurred in processing the data in Step Eleven.</P>
				<cfset arguments.soapData.userProcessed = FALSE>
			</cfif>	
			
			<!--- All steps completed and all data elements validated --->		
			<cfset arguments.soapData.userProcessed = TRUE>
		
		<cfelse>
			<P>ERROR: A connection to the web service could not be established in Step Eleven.</P>
			<cfset arguments.soapData.userProcessed = FALSE>
		</cfif>
		<!--- END WEB SERVICE CALL - STEP ELEVEN :: Submit the application--->

		
	<cfreturn soapData/>
</cffunction>

<!--- Validation Functions --->

<!--- Helper Functions --->
<cffunction name="ConvertXmlToStruct" access="private" returntype="struct" output="false"
				hint="Parse raw XML response body into ColdFusion structs and arrays and return it.">
	<cfargument name="xmlNode" type="string" required="true" />
	<cfargument name="str" type="struct" required="true" />
	<!---Setup local variables for recurse: --->
	<cfset var i = 0 />
	<cfset var axml = arguments.xmlNode />
	<cfset var astr = arguments.str />
	<cfset var n = "" />
	<cfset var tmpContainer = "" />
	<!--- For each children of context node: --->
	<cfloop from="1" to="#arrayLen(axml.XmlChildren)#" index="i">
		<!--- Read XML node name without namespace: --->
		<cfset n = replace(axml.XmlChildren[i].XmlName, axml.XmlChildren[i].XmlNsPrefix&":", "") />
		<!--- If key with that name exists within output struct ... --->
		<cfif structKeyExists(astr, n)>
			<!--- ... and is not an array... --->
			<cfif not isArray(astr[n])>
				<!--- ... get this item into temp variable, ... --->
				<cfset tmpContainer = astr[n] />
				<!--- ... setup array for this item beacuse we have multiple items with same name, ... --->
				<cfset astr[n] = arrayNew(1) />
				<!--- ... and reassing temp item as a first element of new array: --->
				<cfset astr[n][1] = tmpContainer />
				<!---
					If context child node has child nodes (which means it will be complex type): --->
				<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
					<!--- recurse call: get complex item: --->
					<cfset astr[n][arrayLen(astr[n])+1] = ConvertXmlToStruct(axml.XmlChildren[i], structNew()) />
				<cfelse>
					<!--- else: assign node value as last element of array: --->
					<cfset astr[n][arrayLen(astr[n])+1] = axml.XmlChildren[i].XmlText />
				</cfif>
			<cfelse>
				<!--- Item is already an array: --->
				<!---
					If context child node has child nodes (which means it will be complex type): --->
				<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
					<!--- recurse call: get complex item: --->
					<cfset astr[n][arrayLen(astr[n])+1] = ConvertXmlToStruct(axml.XmlChildren[i], structNew()) />
				<cfelse>
					<!--- else: assign node value as last element of array: --->
					<cfset astr[n][arrayLen(astr[n])+1] = axml.XmlChildren[i].XmlText />
				</cfif>
			</cfif>
		<cfelse>
			<!---
				This is not a struct. This may be first tag with some name.
				This may also be one and only tag with this name.
			--->
			<!---
					If context child node has child nodes (which means it will be complex type): --->
			<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
				<!--- recurse call: get complex item: --->
				<cfset astr[n] = ConvertXmlToStruct(axml.XmlChildren[i], structNew()) />
			<cfelse>
				<!--- else: assign node value as last element of array: --->
				<!--- if there are any attributes on this element--->
				<cfif IsStruct(aXml.XmlChildren[i].XmlAttributes) AND StructCount(aXml.XmlChildren[i].XmlAttributes) GT 0>
					<!--- assign the text --->
					<cfset astr[n] = axml.XmlChildren[i].XmlText />
						<!--- check if there are no attributes with xmlns: , we dont want namespaces to be in the response--->
					 <cfset attrib_list = StructKeylist(axml.XmlChildren[i].XmlAttributes) />
					 <cfloop from="1" to="#listLen(attrib_list)#" index="attrib">
						 <cfif ListgetAt(attrib_list,attrib) CONTAINS "xmlns:">
							 <!--- remove any namespace attributes--->
							<cfset Structdelete(axml.XmlChildren[i].XmlAttributes, listgetAt(attrib_list,attrib))>
						 </cfif>
					 </cfloop>
					 <!--- if there are any atributes left, append them to the response--->
					 <cfif StructCount(axml.XmlChildren[i].XmlAttributes) GT 0>
						 <cfset astr[n&'_attributes'] = axml.XmlChildren[i].XmlAttributes />
					</cfif>
				<cfelse>
					 <cfset astr[n] = axml.XmlChildren[i].XmlText />
				</cfif>
			</cfif>
		</cfif>
	</cfloop>
	<!--- return struct: --->
	<cfreturn astr />
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
 
	<!---
		Create the default struct in which we will hold
		the response cookies. This struct will contain structs
		and will be keyed on the name of the cookie to be set.
	--->
	<cfset LOCAL.Cookies = StructNew() />
 
	<!---
		Get a reference to the cookies that werew returned
		from the page request. This will give us an numericly
		indexed struct of cookie strings (which we will have
		to parse out for values). BUT, check to make sure
		that cookies were even sent in the response. If they
		were not, then there is not work to be done.
	--->
	<cfif NOT StructKeyExists(
		ARGUMENTS.Response.ResponseHeader,
		"Set-Cookie"
		)>
 
		<!---
			No cookies were send back in the response. Just
			return the empty cookies structure.
		--->
		<cfreturn LOCAL.Cookies />
 
	</cfif>
 
 
	<!---
		ASSERT: We know that cookie were returned in the page
		response and that they are available at the key,
		"Set-Cookie" of the reponse header.
	--->
 
 
	<!---
		Now that we know that the cookies were returned, get
		a reference to the struct as described above.
	--->
	<cfset LOCAL.ReturnedCookies = ARGUMENTS.Response.ResponseHeader[ "Set-Cookie" ] />
 
 
	<!--- Loop over the returned cookies struct. --->
	<cfloop
		item="LOCAL.CookieIndex"
		collection="#LOCAL.ReturnedCookies#">
 
 
		<!---
			As we loop through the cookie struct, get
			the cookie string we want to parse.
		--->
		<cfset LOCAL.CookieString = LOCAL.ReturnedCookies[ LOCAL.CookieIndex ] />
 
 
		<!---
			For each of these cookie strings, we are going to
			need to parse out the values. We can treate the
			cookie string as a semi-colon delimited list.
		--->
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
 
 
			<!---
				Get the name as the first part of the pair
				sepparated by the equals sign.
			--->
			<cfset LOCAL.Name = ListFirst( LOCAL.Pair, "=" ) />
 
			<!---
				Check to see if we have a value part. Not all
				cookies are going to send values of length,
				which can throw off ColdFusion.
			--->
			<cfif (ListLen( LOCAL.Pair, "=" ) GT 1)>
 
				<!--- Grab the rest of the list. --->
				<cfset LOCAL.Value = ListRest( LOCAL.Pair, "=" ) />
 
			<cfelse>
 
				<!---
					Since ColdFusion did not find more than one
					value in the list, just get the empty string
					as the value.
				--->
				<cfset LOCAL.Value = "" />
 
			</cfif>
 
 
			<!---
				Now that we have the name-value data values,
				we have to store them in the struct. If we are
				looking at the first part of the cookie string,
				this is going to be the name of the cookie and
				it's struct index.
			--->
			<cfif (LOCAL.Index EQ 1)>
 
				<!---
					Create a new struct with this cookie's name
					as the key in the return cookie struct.
				--->
				<cfset LOCAL.Cookies[ LOCAL.Name ] = StructNew() />
 
				<!---
					Now that we have the struct in place, lets
					get a reference to it so that we can refer
					to it in subseqent loops.
				--->
				<cfset LOCAL.Cookie = LOCAL.Cookies[ LOCAL.Name ] />
 
 
				<!--- Store the value of this cookie. --->
				<cfset LOCAL.Cookie.Value = LOCAL.Value />
 
 
				<!---
					Now, this cookie might have more than just
					the first name-value pair. Let's create an
					additional attributes struct to hold those
					values.
				--->
				<cfset LOCAL.Cookie.Attributes = StructNew() />
 
			<cfelse>
 
				<!---
					For all subseqent calls, just store the
					name-value pair into the established
					cookie's attributes strcut.
				--->
				<cfset LOCAL.Cookie.Attributes[ LOCAL.Name ] = LOCAL.Value />
 
			</cfif>
 
		</cfloop>
 
 
	</cfloop>
 
 
	<!--- Return the cookies. --->
	<cfreturn LOCAL.Cookies />
</cffunction>

