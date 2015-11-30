<cfcomponent persistent="true" entityname="entry_point" table="entrypoint">
    <cfproperty name="id" fieldtype="id" column="entrypoint_id">
    <cfproperty name="code">
    <cfproperty name="name">
    <cfproperty name="sub_name" column="subname">
    <cfproperty name="address1">
    <cfproperty name="address2">
    <cfproperty name="address3">
    <cfproperty name="city">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="zipcode">
    <cfproperty name="zipcode_plus4">
    <cfproperty name="email">
    <cfproperty name="url">
    <cfproperty name="hours_display" fieldtype="many-to-one" fkcolumn="hours_display_id" cfc="display">
    <cfproperty name="info_display" fieldtype="many-to-one" fkcolumn="info_display_id" cfc="display">
    <cfproperty name="contact_title">
    <cfproperty name="contact_first">
    <cfproperty name="contact_middle">
    <cfproperty name="contact_last">
    <cfproperty name="contact_suffix">
    <cfproperty name="privatephone">
    <cfproperty name="active_flag">
    <cfproperty name="notes">
</cfcomponent>