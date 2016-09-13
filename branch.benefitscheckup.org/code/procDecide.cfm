<cfif form.over60 eq "Yes" or form.medicare eq "Yes">
<cflocation url="http://pparx.benefitscheckup.org">
<cfelse>
<cflocation url="http://www.pparx.org">
</cfif>