<cfsilent>
<cfparam name="attributes.form" type="string" default="bcuQuestionnaire">
<cfparam name="attributes.mode" type="string" default="">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.aflistvarname" type="string" default="">

<cfif attributes.mode eq ''>
	<cf_handleScreening action="get" element="mode" var="attributes.mode">
</cfif>

<cfif attributes.mode neq 'print' and session.screening.prepopulate>
	<cf_handleScreeningAnswerfield action="get" code="#attributes.code#" element="error" var="hasError">
	<cfif hasError eq ''>
		<cf_handleScreeningAnswerfield action="get" code="#attributes.code#" element="pre" var="matchVal">
	<cfelse>
		<cf_handleScreeningAnswerfield action="get" code="#attributes.code#" element="val" var="matchVal">
	</cfif>
<cfelseif attributes.mode neq 'print'>
	<cf_handleScreeningAnswerfield action="get" code="#attributes.code#" element="val" var="matchVal">
	<cfif matchVal eq ''>
		<cf_getAnswerfieldDefault mode="#attributes.mode#" code="#attributes.code#" default="" var="matchVal">
	</cfif>
</cfif>

<cfif attributes.mode neq 'print' and matchVal neq '' and session.state_id neq ''>
	<cfset boxVal = session.state_id>
	<cfset boxColor = 'black'>
	<cfset boxBack = "##ccffcc">
<cfelse>
	<cfset boxVal = 'n/a'>
	<cfset boxColor = "##666666">
	<cfset boxBack = "##dddddd">
</cfif>
<cf_cacheStatePool action="get" state_id="#session.state_id#" var="stobj">

</cfsilent><cfif attributes.mode neq 'print'><cfoutput><script language="javascript">
<!--
var zyxzip_#attributes.code#_save = '#matchVal#';
var stcode = '';
var stname = '';
// -->
</script><table border="0" cellspacing="0" cellpadding="0"><tr><td align="right"><input type="hidden" name="zyxzip_#attributes.code#_change" value="" /><input type="text" name="#attributes.code#" value="#HTMLEditFormat(matchVal)#" size="6" maxlength="5" onKeyUp="
	jQuery.noConflict(); 
	if (this.value.length == 5) {
                        	var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(this.value);
							if(!isValidZip){alert('You must enter a valid zipcode containing all numbers. Please try again');this.value='';return false};
                            var zipEl = this.form.zyxzip_#attributes.code#_abbrev;
                            myVal = this.value;
                            THAT = this;
                            jQuery.ajax({
                                url: '/com/bcu/ZipFunctions.cfc?method=getStateFromZip',
                                datatype:'json',
                                data: 'zipcode='+myVal, 
                                cache:false,
                                success: function(StateId){
                                    var newcode = eval('('+StateId+')');
                                    
                                    if(!newcode || StateId == 'false'){
                                    	stcode = '';
                                    	stname = '';
                                    	alert(THAT.value + ' is an invalid zip code.  Please try again.');
                                        THAT.value = zyxzip_#attributes.code#_save;
                                    	zipEl.value = '??';
										zipEl.style.color = 'black';
										zipEl.style.background = '##ffcccc';
                                        return false;
                                    }else{
                                    	stcode = newcode.DATA[0][0];
                                        stname = newcode.DATA[0][1];
                                        zipEl.value = stcode;
                                        zipEl.style.color = 'black';
                                        if (stcode == '#session.state_id#'){
                                            zipEl.style.background = '##ccffcc';
                                        }else{
                                            zipEl.style.background = '##ccccff';
                                        }
                                    };
                                    
                                }
                            });
						} else {
							stcode = '';
							this.form.zyxzip_#attributes.code#_abbrev.value = 'n/a';
							this.form.zyxzip_#attributes.code#_abbrev.style.color = '##666666';
							this.form.zyxzip_#attributes.code#_abbrev.style.background = '##dddddd';
						}
						var changecode = this.form.zyxzip_#attributes.code#_change.value;
						if (stcode == '' && changecode != '')
							this.form.zyxzip_#attributes.code#_change.value = '';
						else if (stcode != '')
							this.form.zyxzip_#attributes.code#_change.value = stcode;
					
					" onBlur="
						var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(this.value);
						if(!isValidZip){alert('You must enter a valid zipcode containing all 5 numbers. Please try again');this.value='';return false};
						<!---alert('Blur ' + zyxzip_#attributes.code#_save + ' : ' + this.value);--->
						if (zyxzip_#attributes.code#_save != this.value) {
                        	var zipEl = this.form.zyxzip_#attributes.code#_abbrev;
							<!---alert('values have changed');--->
								<!---alert('zip looks valid');--->
                                THAT = this;
                                 jQuery.ajax({
                                    url: '/com/bcu/ZipFunctions.cfc?method=isZipInState',
                                    datatype:'json',
                                    data: 'zipcode='+this.value+'&state_id=#session.state_id#', 
                                    cache:false,
                                    success: function(StateId){
                                        var newcode = eval('('+StateId+')');
                                        if(!newcode && stname != ''){
                                        	if (confirm('The zip code ' + THAT.value + ' is located in ' + stname + '.  Would you like to fill out a questionnaire for ' + stname + '?')) {
                                                alert('Please wait a moment while the questions update.');
                                                document.#attributes.form#.zyxzip_#attributes.code#_change.value = stcode;
                                                document.#attributes.form#.zyxzip_state_change.value = 'zyxzip_#attributes.code#_change';
                                                document.#attributes.form#.submit();
                                            } else {
                                                <!---alert('Please enter a valid zip code for #stobj.name#.'); --->
                                                THAT.value = zyxzip_#attributes.code#_save;
                                                if (THAT.value.length == 5) {
                                                    zipEl.value = stcode;
                                                    zipEl.style.color = 'black';
                                                    if (stcode == '#session.state_id#')
                                                        zipEl.style.background = '##ccffcc';
                                                    else
                                                        zipEl.style.background = '##ccccff';
                                                } else {
                                                    stcode = '';
                                                    zipEl.value = 'n/a';
                                                    zipEl.style.color = '##666666';
                                                    zipEl.style.background = '##dddddd';
                                                }
                                                THAT.form.zyxzip_#attributes.code#_change.value = stcode;
                                                THAT.focus();
                                                THAT.select();
                                            };
                                        };
                                    }
                                });
						} else {
							<!---alert('values still same');--->
						}
"></td><td>&nbsp;</td><td><input type="text" name="zyxzip_#attributes.code#_abbrev" size="1" value="#boxVal#" disabled style="font-size: 7pt; font-weight: bold; color: #boxColor#; background: #boxBack#; border-width: 1px; border-color: black; border-style: dotted;"></td></tr></table></cfoutput><cfelse>__________</cfif><cfsilent>

<cfif attributes.mode neq 'print' and attributes.aflistvarname neq ''>
	<cfset "caller.#attributes.aflistvarname#" = ListAppend(Evaluate("caller.#attributes.aflistvarname#"), "s-#attributes.code#")>
</cfif>

</cfsilent>

<!---

if (confirm('The zip code ' + this.value + ' is located in ' + statename + '.  Would you like to fill out a questionnaire for ' + statename + '?')) {
	alert('Please wait a moment while the questions update.');
	document.#attributes.form#.zyxzip_#attributes.code#_change.value = state;
	document.#attributes.form#.zyxzip_state_change.value = 'zyxzip_#attributes.code#_change';
	document.#attributes.form#.submit();
} else {
	<!---alert('Please enter a valid zip code for #stobj.name#.'); --->
	this.value = zyxzip_#attributes.code#_save;
	if (this.value.length == 5) {
		stcode = getStateFromZip(this.value);
		this.form.zyxzip_#attributes.code#_abbrev.value = stcode;
		this.form.zyxzip_#attributes.code#_abbrev.style.color = 'black';
		if (stcode == '#session.state_id#')
			this.form.zyxzip_#attributes.code#_abbrev.style.background = '##ccffcc';
		else
			this.form.zyxzip_#attributes.code#_abbrev.style.background = '##ccccff';
	} else {
		stcode = '';
		this.form.zyxzip_#attributes.code#_abbrev.value = 'n/a';
		this.form.zyxzip_#attributes.code#_abbrev.style.color = '##666666';
		this.form.zyxzip_#attributes.code#_abbrev.style.background = '##dddddd';
	}
	this.form.zyxzip_#attributes.code#_change.value = stcode;
	this.focus();
	this.select();
}
--->