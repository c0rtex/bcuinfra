<!--sets a list box of all states. If attibute all is yes, "All" is a choice-->

<CFSET display_all = "yes">

<SELECT NAME="st" SIZE="1">
	<CFIF ISDEFINED("attributes.all")>
		<CFSET display_all = attributes.all>
	</CFIF>
	<CFIF display_all>
    <OPTION VALUE="All">All</option>
	</CFIF>
    <OPTION VALUE="AK">AK</option>
    <OPTION VALUE="AL">AL</option>
    <OPTION VALUE="AR">AR</option>
    <OPTION VALUE="AZ">AZ</option>
    <OPTION VALUE="CA">CA</option>
    <OPTION VALUE="CO">CO</option>
    <OPTION VALUE="CT">CT</option>
    <OPTION VALUE="DE">DE</option>
	<OPTION VALUE="DC">DC</option>
    <OPTION VALUE="FL">FL</option>
	<OPTION VALUE="FD">FD</option>
    <OPTION VALUE="GA">GA</option>
    <OPTION VALUE="HI">HI</option>
    <OPTION VALUE="IA">IA</option>
    <OPTION VALUE="ID">ID</option>
    <OPTION VALUE="IL">IL</option>
    <OPTION VALUE="IN">IN</option>
    <OPTION VALUE="KS">KS</option>
    <OPTION VALUE="KY">KY</option>
    <OPTION VALUE="LA">LA</option>
    <OPTION VALUE="MA">MA</option>
    <OPTION VALUE="MD">MD</option>
    <OPTION VALUE="ME">ME</option>
    <OPTION VALUE="MI">MI</option>
    <OPTION VALUE="MN">MN</option>
	<OPTION VALUE="MN2">MN2</option>
    <OPTION VALUE="MO">MO</option>
    <OPTION VALUE="MS">MS</option>
    <OPTION VALUE="MT">MT</option>
    <OPTION VALUE="NC">NC</option>
    <OPTION VALUE="ND">ND</option>
    <OPTION VALUE="NE">NE</option>
    <OPTION VALUE="NH">NH</option>
    <OPTION VALUE="NJ">NJ</option>
    <OPTION VALUE="NM">NM</option>
    <OPTION VALUE="NV">NV</option>
    <OPTION VALUE="NY">NY</option>
    <OPTION VALUE="OH">OH</option>
    <OPTION VALUE="OK">OK</option>
    <OPTION VALUE="OR">OR</option>
    <OPTION VALUE="PA">PA</option>
    <OPTION VALUE="RI">RI</option>
    <OPTION VALUE="SC">SC</option>
    <OPTION VALUE="SD">SD</option>
    <OPTION VALUE="TN">TN</option>
    <OPTION VALUE="TX">TX</option>
	<OPTION VALUE="UT">UT</option>
    <OPTION VALUE="VA">VA</option>
    <OPTION VALUE="VT">VT</option>
    <OPTION VALUE="WA">WA</option>
    <OPTION VALUE="WI">WI</option>
    <OPTION VALUE="WV">WV</option>
    <OPTION VALUE="WY">WY</option>
  </SELECT>
