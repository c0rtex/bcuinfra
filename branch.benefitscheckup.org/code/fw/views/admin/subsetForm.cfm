<h1>EDIT SUBSET</h1>
<cfset subset = event.getArg("subset") />
<cfset sbtSnapshot = subset.getInstanceMemento() />
<cfset displayLangs  = subset.getDisplay().getDisplaylanguages() /> 
<!---
<cfset descDisplayLangs = subset.getDisplayDesc().getDisplayLanguages() />
 --->
<cfoutput>
	<div class="nowEditing">
		<b>NOW EDITING</b>: #subset.getSubset_id()#
    </div>
</cfoutput>
<script type="text/javascript">

</script>
<div class="formContainer">

<cfoutput>
<div style="float:left;width:300px;margin:10px;">
<cfdump var="#subset#" expand="no">
	<b>SUBSET INFO</b><br />
	Subset Type ID: #subset.getsubsettype_id()#<br />
    Subset Code: #subset.getCode()#<br />
    Subset Description: #subset.getDescription()#<br />
    <!---Program Name Display ID: #subset.getName_display_id()#<br />
    Program Desc. Dislay ID: #subset.getDesc_display_id()#<br />
    Program URL: #subset.getUrl()#<br />
    Program Exclude Flag: #subset.getExclude_flag()#<br />
    Program Significant Flag: #subset.getSignificant_flag()#<br />
    Program Active Flag: #yesnoformat(subset.getActive_flag())#<br />
    Program Funder ID: #subset.getFunder_id()#<br />
    Program Reference ID: #subset.getReference_id()#<br />
    Program Last Update: #dateFormat(subset.getLast_update(), "mm/dd/yyyy")#<br />
    Program Notes: #subset.getNotes()#<br />
    Program Supersort: #subset.getSupersort()#<br />
    Program Sort: #subset.getSort()#<br />
    Program Legacy Program ID: #subset.getLegacy_prg_id()#<br />
    Program Legacy Pri Sec?: #subset.getLegacy_pri_sec()#<br />
    <br />
    <b>PROGRAM CATEGORY FOR PROGRAM ID - #subset.getProgram_id()#:</b><br />
    Program Category Display ID: #subset.getProgramCategory().getDisplay_id()#<br />
    Program Category Code: #subset.getProgramCategory().getCode()#<br />
	Program Category Legacy Code: #subset.getProgramCategory().getLegacy_code()#<br />
    Program Category Desc: #subset.getProgramCategory().getDescription()# <br />
    Program Category Sort: #subset.getProgramCategory().getSort()#---><br />
	<br />
</div>
<div style="float:left;width:550px;margin:10px;border-left:1px dotted ##ccc;padding-left:4px;">

    <b>DISPLAY INFO FOR SUBSET ID - #subset.getSubset_id()#:</b><br />
    Display ID: #subset.getDisplay().getDisplay_id()#<br />
    Display Code: #subset.getDisplay().getDisplay_code()#<br />
    Display Name: #subset.getDisplay().getDisplay_name()#<br />
    Display Description: #subset.getDisplay().getDisplay_desc()#<br />
    Display Active FLag: #subset.getDisplay().getActive_flag()#<br />
    <cfloop from="1" to="#arrayLen(displayLangs)#" index="i">
    	<div style="padding-left:20px;">
        	<b>NAME LANGUAGE IN <span style="font-size:14px;">#displayLangs[i].getLanguage_id()#</span></b><br />
			Language Text: #displayLangs[i].getDisplay_text()#<br />
            Update Flag: #displayLangs[i].getUpdate_flag()#<br />
        </div>
    </cfloop>
    <br />
    <!--- <b>DESCRIPTION DISPLAY INFO FOR PROGRAM ID - #subset.getProgram_id()#:</b><br />
    Display ID: #subset.getDisplayDesc().getDisplay_id()#<br />
    Display Code: #subset.getDisplayDesc().getDisplay_code()#<br />
    Display Name: #subset.getDisplayDesc().getDisplay_name()#<br />
    Display Description: #subset.getDisplayDesc().getDisplay_desc()#<br />
    Display Active FLag: #subset.getDisplayDesc().getActive_flag()#<br />
    <cfloop from="1" to="#arrayLen(descDisplayLangs)#" index="i">
    	<div style="padding-left:20px;">
        	<b>DESCRIPTION LANGUAGE IN <span style="font-size:14px;">#descDisplayLangs[i].getLanguage_id()#</span></b><br />
			Language Text: #descDisplayLangs[i].getDisplay_text()#<br />
            Update Flag: #descDisplayLangs[i].getUpdate_flag()#<br />
        </div>
    </cfloop>
    <br  /> --->
</div>
</cfoutput>
     <form name="editUser" id="editUser" action="index.cfm?event=admin.processUserEdit" method="post">
    	<!---<input type="hidden" name="subset_id" value="<cfoutput>#user.getProgram_id()#</cfoutput>" />
        <input type="hidden" name="modify_user_id" value="<cfoutput>#session.user.getUser_id()#</cfoutput>" />
        <input type="hidden" name="modify_date" value="<cfoutput>#now()#</cfoutput>" />
        <input type="hidden" name="last_login_date" value="<cfoutput>#user.getLast_login_date()#</cfoutput>" />
        <input type="hidden" name="create_date" value="<cfoutput>#subset.getCreate_date()#</cfoutput>" />
        <input type="hidden" name="create_user_id" value="<cfoutput>#subset.getCreate_user_id()#</cfoutput>" />
    <table cellpadding="0" cellspacing="0" border="0">
    	<tr>
        	<td>Username: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="username" name="username" value="<cfoutput>#user.getUsername()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Password: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="password" name="password" value="<cfoutput>#user.getPassword()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Fist Name: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="firstame" name="firstname" value="<cfoutput>#user.getFirstname()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Last Name: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="lastname" name="lastname" value="<cfoutput>#user.getLastName()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Email: </td>
            <td><input onblur="javascript:validate(this);" type="text" id="email" name="email" value="<cfoutput>#user.getEmail()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Active: </td>
            <td>Yes: <input type="radio" name="active" value="true" checked="checked" />&nbsp;No: <input type="radio" name="active" value="false" /></td>
        </tr>
        <tr>
        	<td>Street: </td>
            <td><input type="text" id="street" name="street" value="<cfoutput>#address.getStreet()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>City: </td>
            <td><input type="text" id="city" name="city" value="<cfoutput>#address.getCity()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>State: </td>
            <td><input type="text" id="state" name="state" value="<cfoutput>#address.getState()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Zipcode: </td>
            <td><input type="text" id="zip" name="zip" value="<cfoutput>#address.getZip()#</cfoutput>" /></td>
        </tr>
        <tr>
        	<td>Select Roles: </td>
            <td>
            	<cfloop query="roles">
					<cfoutput>#roles.usertype_name#</cfoutput>:<input <cfif user.hasRole(roles.usertype_code)>checked</cfif> type="checkbox" name="role_ids" value="<cfoutput>#roles.usertype_id#</cfoutput>" /><br />
                </cfloop>
            </td>
        </tr>
        <tr>
        	<td colspan="2"><input type="submit" id="submit" value="Edit User" name="submit" /></td>
        </tr>
    </table> --->
    </form>
</div>
<br />
