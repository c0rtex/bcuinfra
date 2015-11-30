<cfset number = int(rand() * 1000)>
<cffile action="WRITE" file="#session.strPDFPath#ServiceCallTesting#number#.txt" output="testing">
<cfoutput>#session.strPDFPath#testing#number#.txt</cfoutput>