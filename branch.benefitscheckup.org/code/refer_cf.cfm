<cfsilent>

<cfparam name="friends_name" default="">
<cfparam name="your_name" default="">
<cfparam name="your_email" default="">
<cfparam name="email1" default="">
<cfparam name="name" default="">
<cfparam name="message" default="">
<cfparam name="error1" default="">
<cfparam name="error2" default="">
<cfparam name="error3" default="">
<cfparam name="thanks" default="">

</cfsilent>
<cfoutput><cfif thanks IS "y">
<h1 class="h1">Thanks for the Referral</h1>
<p class="text1">
<span class="error1">* Email sent to #email2#</span>
</p>
<p class="text1">Thank you for referring a friend!  If you want to refer another friend enter a new email address in the space below.</p>

<cfelse>
<h1 class="h1">Refer a Friend</h1>
<p class="text1">Many older people need help paying for prescription drugs, health care, utilities and other basic needs, but don&rsquo;t know about the programs out there that can help them.  If you know someone who needs help finding benefits, fill out the form below to send them an email and refer them to BenefitsCheckUp.</p>
</cfif>
<p class="text1">
<form action="refera.cfm" method="post">
<p class="text1">
<strong>Enter your friend's name:</strong><br />
<input name="friends_name" type="text" size="50" value="#friends_name#" /> <font color="red">*optional</font>
<p class="text1">
<strong>Enter your friend's email address:</strong><br />
<input name="email1" type="text" size="50" value="#email1#" /> <font color="red">*required</font>
<cfif error1 IS 1>
<p class="text1"><span class="error1">* ERROR! Please enter a valid email address</span></p>
<cfelse>
</cfif>
<p class="text1">
<strong>Enter your name:</strong><br />
<input name="your_name" type="text" size="50" value="#your_name#" /> <font color="red">*required</font>
<cfif error2 IS 1>
<p class="text1"><span class="error1">* ERROR! Please enter your name</span></p>
<cfelse>
</cfif>
</p>
<p class="text1">
<strong>Enter your email address:</strong><br />
<input name="your_email" type="text" size="50" value="#your_email#" /> <font color="red">*required</font>
<cfif error3 IS 1>
<p class="text1"><span class="error1">* ERROR! Please enter a valid email address</span></p>
<cfelse>
</cfif>
<p class="text1">
<strong>Add your own personal message:</strong>  <font color="red">(optional)</font><br />
<textarea name="message" cols="50" rows="10">#message#</textarea>
</p>
<p class="text1">
<input type="submit" value="send message" class="b1" />
</p>
<p class="text1">&nbsp;</p>
<p class="text1">&nbsp;</p>
<p class="text1"><strong>The email you send will look like the following:</strong><br /></p>
<p class="text1">
To: yourfriend@theiraddress.com<br />
From: Your Name<br />
Subject: I've found a helpful site! 
<p class="text1">
<strong>[YOUR PERSONAL MESSAGE GOES HERE] </strong>
</p>
<p class="text1">I think you'll find the BenefitsCheckUp website very helpful.</p>
<p class="text1">
Just go to http://www.BenefitsCheckUp.org to learn about benefit programs you may be eligible for.  You could receive help paying for prescription drugs, energy bills, property taxes, and more.  If you are eligible for Medicare and have limited income and resources, you can also apply online for Extra Help available through Medicare's Prescription Drug Coverage.  It&rsquo;s simple, it's fast, and it's free!
</p>
<p class="text1">
This email was sent to you by [your name]. BenefitsCheckUp respects your privacy and will not contact you. 
</p>



</form>

</cfoutput>