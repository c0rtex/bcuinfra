<cfcomponent persistent="true" entityname="user" table="user">
	<cfproperty name="id" fieldtype="id" column="user_id">
	<cfproperty name="user_type" fieldtype="many-to-one" fkcolumn="usertype_id" cfc="user_type">
	<cfproperty name="user_name" column="username">
	<cfproperty name="password">
	<cfproperty name="first_name" column="firstname">
	<cfproperty name="last_name" column="lastname">
	<cfproperty name="email">
	<cfproperty name="is_active" column="active">
	<cfproperty name="last_login_date">
	<cfproperty name="create_user" fieldtype="many-to-one" fkcolumn="create_user_id" cfc="user">
	<cfproperty name="create_date">
	<cfproperty name="modify_user" fieldtype="many-to-one" fkcolumn="modify_user_id" cfc="user">
	<cfproperty name="modify_date">
	<cfproperty name="address" fieldtype="many-to-one" fkcolumn="address_id" cfc="address">
</cfcomponent>