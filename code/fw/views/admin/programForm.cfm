<h1>EDIT PROGRAM</h1>
<cfset program = event.getArg("program") />
<cfset prgSnapshot = program.getInstanceMemento() />
<cfset nameDisplayLangs  = program.getDisplayName().getDisplaylanguages() /> 
<Cfset descDisplayLangs = program.getDisplayDesc().getDisplayLanguages() />
<cfoutput>
	<div class="nowEditing">
		<b>NOW EDITING</b>: #program.getProgram_code()#
    </div>
</cfoutput>
<script type="text/javascript">

</script>
<div class="formContainer">

<cfoutput>
<div style="float:left;width:300px;margin:10px;">
	<b>PROGRAM INFO</b><br />
	Program Category ID: #program.getProgramcategory_id()#<br />
    Program State ID: #program.getState_id()#<br />
    Program Code: #program.getProgram_code()#<br />
    Program Name Display ID: #program.getName_display_id()#<br />
    Program Desc. Dislay ID: #program.getDesc_display_id()#<br />
    Program URL: #program.getUrl()#<br />
    Program Exclude Flag: #program.getExclude_flag()#<br />
    Program Significant Flag: #program.getSignificant_flag()#<br />
    Program Active Flag: #yesnoformat(program.getActive_flag())#<br />
    Program Funder ID: #program.getFunder_id()#<br />
    Program Reference ID: #program.getReference_id()#<br />
    Program Last Update: #dateFormat(program.getLast_update(), "mm/dd/yyyy")#<br />
    Program Notes: #program.getNotes()#<br />
    Program Supersort: #program.getSupersort()#<br />
    Program Sort: #program.getSort()#<br />
    Program Legacy Program ID: #program.getLegacy_prg_id()#<br />
    Program Legacy Pri Sec?: #program.getLegacy_pri_sec()#<br />
    <br />
    <b>PROGRAM CATEGORY FOR PROGRAM ID - #program.getProgram_id()#:</b><br />
    Program Category Display ID: #program.getProgramCategory().getDisplay_id()#<br />
    Program Category Code: #program.getProgramCategory().getCode()#<br />
	Program Category Legacy Code: #program.getProgramCategory().getLegacy_code()#<br />
    Program Category Desc: #program.getProgramCategory().getDescription()# <br />
    Program Category Sort: #program.getProgramCategory().getSort()#<br />
	<br />
</div>
<div style="float:left;width:550px;margin:10px;border-left:1px dotted ##ccc;padding-left:4px;">

    <b>NAME DISPLAY INFO FOR PROGRAM ID - #program.getProgram_id()#:</b><br />
    Display ID: #program.getDisplayName().getDisplay_id()#<br />
    Display Code: #program.getDisplayName().getDisplay_code()#<br />
    Display Name: #program.getDisplayName().getDisplay_name()#<br />
    Display Description: #program.getDisplayName().getDisplay_desc()#<br />
    Display Active FLag: #program.getDisplayName().getActive_flag()#<br />
    <cfloop from="1" to="#arrayLen(nameDisplayLangs)#" index="i">
    	<div style="padding-left:20px;">
        	<b>NAME LANGUAGE IN <span style="font-size:14px;">#nameDisplayLangs[i].getLanguage_id()#</span></b><br />
			Language Text: #nameDisplayLangs[i].getDisplay_text()#<br />
            Update Flag: #nameDisplayLangs[i].getUpdate_flag()#<br />
        </div>
    </cfloop>
    <br />
    <b>DESCRIPTION DISPLAY INFO FOR PROGRAM ID - #program.getProgram_id()#:</b><br />
    Display ID: #program.getDisplayDesc().getDisplay_id()#<br />
    Display Code: #program.getDisplayDesc().getDisplay_code()#<br />
    Display Name: #program.getDisplayDesc().getDisplay_name()#<br />
    Display Description: #program.getDisplayDesc().getDisplay_desc()#<br />
    Display Active FLag: #program.getDisplayDesc().getActive_flag()#<br />
    <cfloop from="1" to="#arrayLen(descDisplayLangs)#" index="i">
    	<div style="padding-left:20px;">
        	<b>DESCRIPTION LANGUAGE IN <span style="font-size:14px;">#descDisplayLangs[i].getLanguage_id()#</span></b><br />
			Language Text: #descDisplayLangs[i].getDisplay_text()#<br />
            Update Flag: #descDisplayLangs[i].getUpdate_flag()#<br />
        </div>
    </cfloop>
    <br  />
</div>
</cfoutput>
     <form name="editUser" id="editUser" action="index.cfm?event=admin.processUserEdit" method="post">
    	<!---<input type="hidden" name="program_id" value="<cfoutput>#user.getProgram_id()#</cfoutput>" />
        <input type="hidden" name="modify_user_id" value="<cfoutput>#session.user.getUser_id()#</cfoutput>" />
        <input type="hidden" name="modify_date" value="<cfoutput>#now()#</cfoutput>" />
        <input type="hidden" name="last_login_date" value="<cfoutput>#user.getLast_login_date()#</cfoutput>" />
        <input type="hidden" name="create_date" value="<cfoutput>#program.getCreate_date()#</cfoutput>" />
        <input type="hidden" name="create_user_id" value="<cfoutput>#program.getCreate_user_id()#</cfoutput>" />
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
