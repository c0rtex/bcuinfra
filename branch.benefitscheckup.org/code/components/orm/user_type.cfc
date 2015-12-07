<cfcomponent persistent="true" entityname="user_type" table="usertype">
	<cfproperty name="id" fieldtype="id" column="usertype_id">
	<cfproperty name="code" column="usertype_code">
	<cfproperty name="name" column="usertype_name">
	<cfproperty name="description" column="usertype_desc">
</cfcomponent>