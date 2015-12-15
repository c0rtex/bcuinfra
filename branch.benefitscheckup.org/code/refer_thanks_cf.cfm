<cfsilent>
<cfparam name="email" default="">
<cfparam name="email2" default="">
<cfparam name="name" default="">
<cfparam name="error1" default="">
<cfparam name="error2" default="">

</cfsilent>
<cfoutput><h1>Thanks for the Referral</h1>
<p class="text1">
<span class="error1">* Email sent to #email2#</span>
</p>
<p class="text1">Thank you for referring a friend!  If you want to refer another friend enter a new email address in the space below.</p>
<p class="text1">
<form action="refera.cfm" method="post">
<p class="text1"><strong>Your Name:</strong><br />
<input name="name" type="text" size="60" value="#name#" />
<cfif error2 IS 1>
<p class="text1"><span class="error1">* ERROR! Please enter your name</span></p>
<cfelse>
</p>
</cfif>
<p class="text1">
<strong>Email address of your friend:</strong> <input name="email" type="text" size="60" value="#email#" /> <input type="submit" value="send" class="b1" />
<cfif error1 IS 1>
<p class="text1"><span class="error1">* ERROR! Please enter a valid email address</span></p>
<cfelse>
</cfif>
</form>
</p>
</cfoutput>