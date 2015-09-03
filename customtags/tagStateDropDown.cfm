<!----=======================================
DESCRIPTION: Tag containing all the states in drop down format
CALLED BY: N/A
GOES TO: N/A
REQUIRED:N/A
OPTIONAL ATTRIBUTES: Selected=two letter abbreviation of the state that should be selected
============================================---->
<CFIF IsDefined('Attributes.Selected')>
	<CFSET StateSelected = #Attributes.Selected#>
<CFELSE>
	<CFSET StateSelected = "ZZ">
</CFIF>

<CFSET StateList = "AK,AL,AR,AZ,CA,CO,CT,DE,DC,FL,GA,HI,IA,ID,IL,IN,KS,KY,LA,MA,MD,ME,MI,MN,MO,MS,MT,NC,ND,NE,NH,NJ,NM,NV,NY,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VA,VT,WA,WI,WV,WY">

<SELECT NAME="st" SIZE="1">
	<CFLOOP Index="state" List="#StateList#" Delimiters=",">
			
			<CFIF #state# IS StateSelected>
				<CFOUTPUT><option value="#state#" selected>#state#</option></CFOUTPUT>	
			<CFELSE>
				<CFOUTPUT><option value="#state#">#state#</option></CFOUTPUT>
			</CFIF>
			
	</CFLOOP>
</SELECT>