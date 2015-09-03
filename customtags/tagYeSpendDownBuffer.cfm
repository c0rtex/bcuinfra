<!----=======================================
DESCRIPTION: Checks to see if user is eligible for the SpendDown income disregard rule
CALLED BY: procBuffer
GOES TO: Caller
REQUIRED: rule = the eligibility rule as a string
RETURNS: answer = YES or NO dependant on if user is eligible
NOTE: The manipulation of the numbers is determined by the content staff
      the rule by structure gives us the single person limit, and the married limit  the rule will be 
      structured assuch  spenddown-singlelimit-marriedlimit so  we do a get token function 
      to set the limits within the tag,  then we offset that limit cus this is the buffer.
      There is also the cahnce that the limit will be in the form of an income table set to household 
      members      
============================================---->
<!--- debug Rule:: <CFOUTPUT>#attributes.Rule#-then, struct_mem1[22] #struct_mem1[22]#--#EVALUATE("#struct_mem1[22]# ")#</cfoutput><br> DEBUG:||<CFOUTPUT>#attributes.rule#</cfoutput>|| --->

<!--- Notes on how (the changes to) this tag work with procBuffer.cfm --->   
<!--- When there is 'spenddowninc', a Rule (looped over in procBuffer.cfm) will invoke this custom tag.  However, that rule may or may not be a rule which has 'struct_mem' in it; because struct_mem(1-8)[1-however many] is not available locally to the call to the custom tag, if struct_mem exists, it is: --->
<!--- evaluated and replaced into the rule string, such that a rule like 'spenddowninc lte struct_mem1[22] would become 'spenddowninc lte 1708', where 1708 is also passed into this tag for the purposed of an 'if' test.  The evaluation of sturct_mem itself takes place on procbuffer.cfm, at '<cfset passMeIn = FINDNOCASE("struct_mem", strRule, 1)>' --->

<cfif not IsDefined("attributes.PassMeIn")>
	<cfset passMeIn = "">
<cfelse>	
	<cfset passMeIn = attributes.PassMeIn>
</cfif>
<cfif len(trim(PassMeIn)) is 0> 
   <cfset self = gettoken(attributes.Rule,2,"-")>
   <cfset self_spouse = gettoken(attributes.Rule,3,"-")>

   <cfif session.MARITAL_STAT NEQ "Married"> 
      <cfif session.S_INCOME_EARNED gt 65>
         <cfset figure = ((Session.S_income_earned - 65) / 2)>
      <cfelse>
         <cfset figure = 0>
      </cfif>

      <cfset finalfigure = session.S_INCOME_TOTAL_UNEARNED + figure>
      <cfset finalfigure = finalfigure - session.med_costs>
      <cfif finalfigure lte (self + 100)>
         <cfset answer = "YES">
      <cfelse>
         <cfset answer = "NO">
      </cfif>

   <cfelseif session.MARITAL_STAT EQ "Married">
      <cfif session.S_INCOME_EARNED gt 65>
         <cfset figure = ((Session.S_income_earned - 65) / 2)>
      <cfelse>
         <cfset figure = 0>
      </cfif>

      <cfset finalfigure = session.S_INCOME_TOTAL_UNEARNED + figure>
      <cfset finalfigure = finalfigure + session.SP_INCOME_TOTAL_COMPLETE>
      <cfset finalfigure = finalfigure - session.med_costs>
                  
      <cfif finalfigure lte (self_spouse + 100)>
         <cfset answer = "YES">
      <cfelse>
         <cfset answer = "NO">
      </cfif>

   <cfelse>
      <cfset answer = "NO">
   </cfif>

   <cfset caller.answer = answer>
<cfelse><!--- 'struct_mem' is passed as part of the rule --->
         
   <cfif #session.S_INCOME_EARNED# gt 65>
      <cfset figure = ((#Session.S_income_earned# - 65) / 2)>
   <cfelse>
      <cfset figure = 0>
   </cfif>
   
   <cfset selfnewincome = session.S_INCOME_TOTAL_UNEARNED + figure>
   <cfset rest_hh_income = Session.HH_INCOME_TOTAL_COMPLETE - Session.S_INCOME_TOTAL_COMPLETE>
   <cfset finalfigure = selfnewincome + rest_hh_income>
   
   
   <!--- <cfset finalfigure = #finalfigure# - #session.med_costs# - 100> --->
   <cfset finalfigure = finalfigure - session.med_costs>
               
   <!--- Rule (before):#Attributes.Rule#<br>
   <cfset Rule = #ReplaceNoCase(#Attributes.Rule#, "spenddowninc", "#finalfigure#", "ALL")#>
   Rule (after spenddowninc replaced by finalfigure):#Rule#<br> --->
   
   <!--- In lieu of the Rule (formed in the cfset in the 3 above commented-out lines), 
   the following NEW LOGIC --->
   <!--- PassMeIn: the already-evaluated struct-Mem amount for this instance --->
   <!--- PassMeIn < FinalFigure < PMI + 100 --->
   <cfif PassMeIn lt FinalFigure>
      <cfif FinalFigure lt (PassMeIn + 100)>
         <cfset answer = "YES">
      <cfelse>
         <cfset answer = "NO">
      </cfif>
   <cfelse>
   <!--- the only 'yes' to be returned is when final figure is between pmi and pmi +100, so: --->
      <cfset answer = "NO">
   </cfif>

   <cfset caller.answer = answer>
</cfif>         
            