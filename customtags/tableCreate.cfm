<cfparam name="attributes.table" type="string">
<cfparam name="attributes.source" type="string">
<cfparam name="attributes.drop" type="boolean" default="false">

<cfif attributes.drop>
	<cfquery name="droptable" datasource="#attributes.source#">
		DROP TABLE #attributes.table#
	</cfquery>
</cfif>

<cfswitch expression="#attributes.table#">
	<cfcase value="alt_url_partner">
		<cfquery name="createtable" datasource="#attributes.source#">
		  CREATE TABLE alt_url_partner (
		  alt_url_partner_id INTEGER(11) NOT NULL AUTO_INCREMENT,
		  url_id INTEGER(11) NOT NULL,
		  partner_id INTEGER(11) NOT NULL,
		  alt_url_id INTEGER(11) NOT NULL,
		  PRIMARY KEY (alt_url_partner_id)
  		  )ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE answerfield (
  answerfield_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  answerfieldtype_id INTEGER(11) NOT NULL,
  answerfield VARCHAR(64) NOT NULL,
  display_id INTEGER(11) DEFAULT NULL,
  short_display_id INTEGER(11) DEFAULT NULL,
  spq_display_id INTEGER(11) DEFAULT NULL,
  print_display_id INTEGER(11) DEFAULT NULL,
  max_length INTEGER(11) DEFAULT NULL,
  default_value VARCHAR(64) DEFAULT NULL,
  spq_default_value VARCHAR(64) DEFAULT NULL,
  oe_default_value VARCHAR(64) DEFAULT NULL,
  required_flag TINYINT(4) UNSIGNED NOT NULL,
  rule_id INTEGER(11) DEFAULT NULL,
  validation_id INTEGER(11) DEFAULT NULL,
  state_id CHAR(2) DEFAULT NULL,
  answerfield_desc VARCHAR(255) DEFAULT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
PRIMARY KEY (answerfield_id),
KEY aid_stid_ansfd (answerfield_id, state_id, answerfield)
)ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="answerfield_option">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE answerfield_option (
  answerfield_id INTEGER(11) NOT NULL,
  option_id INTEGER(11) NOT NULL,
  sort INTEGER(11) NOT NULL
)ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="answerfield_relationship">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE answerfield_relationship (
  left_answerfield_id INTEGER(11) NOT NULL,
  right_answerfield_id INTEGER(11) NOT NULL,
  relationship_id INTEGER(11) NOT NULL
)ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="answerfield_subset_partner">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE answerfield_subset_partner (
  answerfield_id INTEGER(11) NOT NULL,
  subset_id INTEGER(11) DEFAULT NULL,
  partner_id INTEGER(11) DEFAULT NULL,
  default_value VARCHAR(64) DEFAULT NULL,
  background_flag TINYINT(4) UNSIGNED NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="answerfieldtype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE answerfieldtype (
  answerfieldtype_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(16) NOT NULL,
  name VARCHAR(64) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (answerfieldtype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="city">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE city (
  city_id CHAR(6) NOT NULL,
  state_id CHAR(2) NOT NULL,
  pref_city_id CHAR(6) DEFAULT NULL,
  city_name VARCHAR(255) NOT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  valid INTEGER(11) NOT NULL,
  county_id CHAR(6) DEFAULT NULL,
  update_valid INTEGER(11) DEFAULT NULL,
PRIMARY KEY (city_id)
)ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="city_zip">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE city_zip (
  city_id CHAR(6) NOT NULL,
  zipcode CHAR(5) NOT NULL,
  postal_city_id CHAR(6) DEFAULT NULL,
  exclude_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  valid INTEGER(11) DEFAULT NULL,
  update_valid INTEGER(11) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="county">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE county (
  county_id CHAR(5) NOT NULL,
  state_id CHAR(2) NOT NULL,
  county_name VARCHAR(255) NOT NULL,
  valid INTEGER(11) NOT NULL,
  map_id INTEGER(11) DEFAULT NULL,
  update_valid INTEGER(11) DEFAULT NULL,
PRIMARY KEY (county_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="display">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE display (
  display_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  displaygroup_id INTEGER(11) DEFAULT NULL,
  display_code VARCHAR(64) NOT NULL,
  display_name VARCHAR(128) NOT NULL,
  display_desc VARCHAR(255) DEFAULT NULL,
  active_flag TINYINT(4) UNSIGNED NOT NULL,
PRIMARY KEY (display_id),
KEY _dta_index_display_14_834102012__K3_K1 (display_code, display_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="display_language">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE display_language (
  display_id INTEGER(11) NOT NULL,
  language_id CHAR(2) NOT NULL,
  display_text LONGTEXT NOT NULL,
  update_flag TINYINT(4) UNSIGNED NOT NULL,
KEY _dta_index_display_language2_c_14_914102297__K1_K2 (display_id, language_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="displaygroup">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE displaygroup (
  displaygroup_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  displaygroup_code VARCHAR(16) NOT NULL,
  displaygroup_name VARCHAR(64) NOT NULL,
  displaygroup_desc VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (displaygroup_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="entrypoint">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE entrypoint (
  entrypoint_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(64) NOT NULL,
  name VARCHAR(255) NOT NULL,
  subname VARCHAR(255) DEFAULT NULL,
  address1 VARCHAR(255) DEFAULT NULL,
  address2 VARCHAR(255) DEFAULT NULL,
  address3 VARCHAR(255) DEFAULT NULL,
  city VARCHAR(255) DEFAULT NULL,
  state_id CHAR(2) DEFAULT NULL,
  zipcode CHAR(5) DEFAULT NULL,
  zipcode_plus4 CHAR(4) DEFAULT NULL,
  email VARCHAR(255) DEFAULT NULL,
  url VARCHAR(255) DEFAULT NULL,
  hours_display_id INTEGER(11) DEFAULT NULL,
  info_display_id INTEGER(11) DEFAULT NULL,
  contact_title VARCHAR(64) DEFAULT NULL,
  contact_first VARCHAR(64) DEFAULT NULL,
  contact_middle VARCHAR(64) DEFAULT NULL,
  contact_last VARCHAR(64) DEFAULT NULL,
  contact_suffix VARCHAR(64) DEFAULT NULL,
  privatephone VARCHAR(255) DEFAULT NULL,
  last_update DATETIME DEFAULT NULL,
  active_flag INTEGER(11) NOT NULL,
  notes LONGTEXT,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
PRIMARY KEY (entrypoint_id)
)ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="entrypoint_city">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE entrypoint_city (
  entrypoint_id INTEGER(11) NOT NULL,
  city_id CHAR(6) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="entrypoint_county">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE entrypoint_county (
  entrypoint_id INTEGER(11) NOT NULL,
  county_id CHAR(5) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="entrypoint_entrypointgroup">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE entrypoint_entrypointgroup (
  entrypoint_id INTEGER(11) NOT NULL,
  entrypointgroup_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="entrypoint_zip">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE entrypoint_zip (
  entrypoint_id INTEGER(11) NOT NULL,
  zipcode CHAR(5) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="entrypointgroup">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE entrypointgroup (
  entrypointgroup_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  state_id CHAR(2) DEFAULT NULL,
  active_flag INTEGER(11) NOT NULL,
  notes LONGTEXT,
PRIMARY KEY (entrypointgroup_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="error">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE error (
  error_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  error_code VARCHAR(64) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
PRIMARY KEY (error_id)
)ENGINE=MyISAM CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="form">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE form (
  form_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  formtag_id INTEGER(11) NOT NULL,
  form_name VARCHAR(255) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  state_id CHAR(2) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="form_formtype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE form_formtype (
  form_id INTEGER(11) NOT NULL,
  formtype_id INTEGER(11) NOT NULL,
  string VARCHAR(255) NOT NULL,
  active INTEGER(11) DEFAULT NULL,
  form_date DATETIME DEFAULT NULL,
  form_day_ignore_flag INTEGER(11) DEFAULT NULL,
  entry_date DATETIME DEFAULT NULL,
  entry_day_ignore_flag INTEGER(11) DEFAULT NULL,
KEY _dta_index_form_formtype_c_14_1474104292__K2_K4 (formtype_id, active)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="format">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE format (
  format_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  format_code VARCHAR(32) NOT NULL,
  format_name VARCHAR(64) NOT NULL,
  format_desc VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="formclass">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE formclass (
  formclass_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  class_code VARCHAR(16) NOT NULL,
  class_name VARCHAR(64) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="formtag">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE formtag (
  formtag_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  formclass_id INTEGER(11) NOT NULL,
  tag_name VARCHAR(255) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="formtype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE formtype (
  formtype_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  type_code VARCHAR(16) NOT NULL,
  type_name VARCHAR(64) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="funder">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE funder (
  funder_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  legacy_code INTEGER(11) DEFAULT NULL,
PRIMARY KEY (funder_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="gridcolumn">
		<cfquery name="createtable" datasource="#attributes.source#">

CREATE TABLE gridcolumn (
  gridcolumn_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(32) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  help_id INTEGER(11) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  sort INTEGER(11) NOT NULL,
PRIMARY KEY (gridcolumn_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="gridrow">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE gridrow (
  gridrow_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(32) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  help_id INTEGER(11) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  sort INTEGER(11) NOT NULL,
PRIMARY KEY (gridrow_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="gridrow_gridcolumn_answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">

CREATE TABLE gridrow_gridcolumn_answerfield
CREATE TABLE gridrow_gridcolumn_answerfield (
  gridrow_id INTEGER(11) NOT NULL,
  gridcolumn_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="hardrule">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE hardrule (
				hardrule_id int INTEGER(11) NOT NULL AUTO_INCREMENT,
				`code` varchar (64) NOT NULL,
				PRIMARY KEY (hardrule_id)
			)
		</cfquery>
	</cfcase>

	<cfcase value="hardrule_answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE hardrule_answerfield
CREATE TABLE hardrule_answerfield (
  hardrule_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="help">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE help (
  help_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  helptype_id INTEGER(11) NOT NULL,
  help_code VARCHAR(64) NOT NULL,
  keyword VARCHAR(64) DEFAULT NULL,
  title_display_id INTEGER(11) DEFAULT NULL,
  display_id INTEGER(11) NOT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
PRIMARY KEY (help_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="helptype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE helptype (
  helptype_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(16) NOT NULL,
  name VARCHAR(64) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (helptype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="image">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE image (
  image_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL,
  filename VARCHAR(255) DEFAULT NULL,
  width INTEGER(11) DEFAULT NULL,
  height INTEGER(11) DEFAULT NULL,
  alt_display_id INTEGER(11) DEFAULT NULL,
  description LONGTEXT,
PRIMARY KEY (image_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="language">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE language (
  language_id CHAR(2) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  default_flag TINYINT(4) UNSIGNED NOT NULL,
  active TINYINT(4) UNSIGNED NOT NULL,
PRIMARY KEY (language_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="option">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE `option` (
  option_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  option_code VARCHAR(32) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  include_flag TINYINT(4) UNSIGNED NOT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
PRIMARY KEY (option_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="option_subset_partner">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE option_subset_partner (
  option_id INTEGER(11) NOT NULL,
  subset_id INTEGER(11) DEFAULT NULL,
  partner_id INTEGER(11) DEFAULT NULL,
  include_flag TINYINT(4) UNSIGNED NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="page">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE page (
  page_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  page_code VARCHAR(32) NOT NULL,
  subset_id INTEGER(11) DEFAULT NULL,
  title_display_id INTEGER(11) DEFAULT NULL,
  display_id INTEGER(11) DEFAULT NULL,
  page_desc VARCHAR(255) DEFAULT NULL,
  postrecap TINYINT(4) UNSIGNED NOT NULL,
  sort INTEGER(11) DEFAULT NULL,
PRIMARY KEY (page_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="partnertype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE partnertype (
  partnertype_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(16) NOT NULL,
  name VARCHAR(64) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (partnertype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="phone">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE phone (
  phone_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  entrypoint_id INTEGER(11) NOT NULL,
  phonetype_id INTEGER(11) NOT NULL,
  number VARCHAR(255) NOT NULL,
  sort INTEGER(11) NOT NULL,
PRIMARY KEY (phone_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="phonetype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE phonetype (
  phonetype_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(16) NOT NULL,
  display_id INTEGER(11) NOT NULL,
PRIMARY KEY (phonetype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program (
  program_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  programcategory_id INTEGER(11) NOT NULL,
  programgroup_id INTEGER(11) DEFAULT NULL,
  state_id CHAR(2) DEFAULT NULL,
  program_code VARCHAR(32) NOT NULL,
  name_display_id INTEGER(11) NOT NULL,
  desc_display_id INTEGER(11) NOT NULL,
  url VARCHAR(255) DEFAULT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  significant_flag TINYINT(4) UNSIGNED NOT NULL,
  active_flag TINYINT(4) UNSIGNED NOT NULL,
  funder_id INTEGER(11) DEFAULT NULL,
  reference_id INTEGER(11) DEFAULT NULL,
  last_update DATETIME DEFAULT NULL,
  notes LONGTEXT,
  supersort INTEGER(11) DEFAULT NULL,
  sort INTEGER(11) NOT NULL,
  legacy_prg_id VARCHAR(32) DEFAULT NULL,
  legacy_pri_sec INTEGER(11) DEFAULT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program_answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program_answerfield (
  program_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL,
  rule_flag TINYINT(4) UNSIGNED NOT NULL,
KEY _dta_index_program_answerfield_14_1246627484__K2_K1 (answerfield_id, program_id),
KEY _dta_index_program_answerfield_c_14_1246627484__K2 (answerfield_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program_entrypointgroup">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program_entrypointgroup (
  program_id INTEGER(11) NOT NULL,
  entrypointgroup_id INTEGER(11) NOT NULL,
  sort INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program_form">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program_form (
  program_id INTEGER(11) NOT NULL,
  form_id INTEGER(11) NOT NULL,
  sort INTEGER(11) DEFAULT NULL,
  formula VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program_parent">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program_parent (
  program_id INTEGER(11) NOT NULL,
  parent_program_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program_proximity">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program_proximity (
  program_id INTEGER(11) NOT NULL,
  proximity_id INTEGER(11) NOT NULL,
  sort INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program_requisite">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program_requisite (
  program_id INTEGER(11) NOT NULL,
  requisite_id INTEGER(11) NOT NULL,
  sort INTEGER(11) NOT NULL,
KEY _dta_index_program_requisite_14_423672557__K1_K2_K3 (program_id, requisite_id, sort)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="program_rule">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE program_rule (
  program_id INTEGER(11) NOT NULL,
  rule_id INTEGER(11) NOT NULL,
  sort INTEGER(11) NOT NULL,
KEY _dta_index_program_rule_14_375672386__K1_K2_K3 (program_id, rule_id, sort)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="programcategory">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE programcategory (
  programcategory_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  display_id INTEGER(11) NOT NULL,
  code VARCHAR(16) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  legacy_code INTEGER(11) DEFAULT NULL,
  sort INTEGER(11) NOT NULL,
PRIMARY KEY (programcategory_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="programgroup">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE programgroup (
  programgroup_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(32) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  blurb_display_id INTEGER(11) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  sort INTEGER(11) NOT NULL,
PRIMARY KEY (programgroup_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="programtext">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE programtext (
  programtext_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  rec LONGTEXT,
  summary LONGTEXT,
  program_id INTEGER(11) DEFAULT NULL,
  type VARCHAR(50) DEFAULT NULL,
  benefit INTEGER(11) DEFAULT NULL,
  answerfield VARCHAR(50) DEFAULT NULL,
  template VARCHAR(50) DEFAULT NULL,
  actions LONGTEXT,
  sortorder INTEGER(11) DEFAULT NULL,
  Active INTEGER(11) DEFAULT NULL,
  alt_rec LONGTEXT,
  alt_summary LONGTEXT,
  enrollment_flag VARCHAR(50) DEFAULT NULL,
PRIMARY KEY (programtext_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="programvalue">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE programvalue (
  programvalue_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  program_id INTEGER(11) NOT NULL,
  state_id CHAR(2) DEFAULT NULL,
  dollarvalue DOUBLE(15,3) NOT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME DEFAULT NULL,
  rule_text LONGTEXT,
PRIMARY KEY (programvalue_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="protocol">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE protocol (
  protocol_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  protocol VARCHAR(16) NOT NULL,
PRIMARY KEY (protocol_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="proximity">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE proximity (
  proximity_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(16) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (proximity_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="question">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE question (
  question_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  dep_question_id INTEGER(11) DEFAULT NULL,
  question_code VARCHAR(32) NOT NULL,
  questioncategory_id INTEGER(11) NOT NULL,
  questionheader_id INTEGER(11) DEFAULT NULL,
  questiontype_id INTEGER(11) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  short_display_id INTEGER(11) DEFAULT NULL,
  spq_display_id INTEGER(11) DEFAULT NULL,
  print_display_id INTEGER(11) DEFAULT NULL,
  format_id INTEGER(11) DEFAULT NULL,
  rule_id INTEGER(11) DEFAULT NULL,
  include_flag TINYINT(4) UNSIGNED NOT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  suppress_qno_flag TINYINT(4) UNSIGNED NOT NULL,
  spq_exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  sort INTEGER(11) NOT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="question_answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE question_answerfield (
  question_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL,
  state_id CHAR(2) DEFAULT NULL,
  rule_id INTEGER(11) DEFAULT NULL,
  sort INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="question_gridcolumn">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE question_gridcolumn (
  question_id INTEGER(11) NOT NULL,
  gridcolumn_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="question_gridrow">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE question_gridrow (
  question_id INTEGER(11) NOT NULL,
  gridrow_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="question_help">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE question_help (
  question_id INTEGER(11) NOT NULL,
  help_id INTEGER(11) NOT NULL,
  state_id CHAR(2) DEFAULT NULL,
  rule_id INTEGER(11) DEFAULT NULL,
  sort INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="questioncategory">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE questioncategory (
  questioncategory_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  display_id INTEGER(11) NOT NULL,
  questioncategory_code VARCHAR(16) NOT NULL,
  questioncategory_desc VARCHAR(255) DEFAULT NULL,
  sort INTEGER(11) NOT NULL,
PRIMARY KEY (questioncategory_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="questionheader">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE questionheader (
  questionheader_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  code VARCHAR(64) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  description VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="questiontype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE questiontype (
  questiontype_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  code VARCHAR(32) NOT NULL,
  name VARCHAR(64) NOT NULL,
  description VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="quote">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE quote (
  quote_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  quote_code VARCHAR(32) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  active TINYINT(4) UNSIGNED NOT NULL,
PRIMARY KEY (quote_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="recap">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE recap (
  recap_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  recap_code VARCHAR(32) NOT NULL,
  display_id INTEGER(11) DEFAULT NULL,
  formula LONGTEXT NOT NULL,
  recap_desc VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (recap_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="reference">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE reference (
  reference_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
PRIMARY KEY (reference_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="relationship">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE relationship (
  relationship_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(32) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (relationship_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="requisite">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE requisite (
  requisite_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(32) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  def_display_id INTEGER(11) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (requisite_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="resultpage">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE resultpage (
  resultpage_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(32) NOT NULL,
  filename VARCHAR(128) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  resultpage_desc VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (resultpage_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="rule">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE `rule` (
  rule_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(64) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  rule_text LONGTEXT NOT NULL,
  rx_program_id INTEGER(11) DEFAULT NULL,
  legacy_pri_sec INTEGER(11) DEFAULT NULL,
PRIMARY KEY (rule_id),
KEY _dta_index_rule_14_327672215__K1_2 (code, rule_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="rule_answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE rule_answerfield (
  rule_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="screening_submission">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE screening_submission (
  submission_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  screening_id INTEGER(11) NOT NULL,
  reentry_number INTEGER(11) DEFAULT NULL,
  submission_status INTEGER(11) DEFAULT NULL,
  submission_result LONGTEXT,
  ssn_hash CHAR(32) DEFAULT NULL,
  file_name CHAR(100) DEFAULT NULL,
  post_start_time DATETIME NOT NULL,
  post_finish_time DATETIME DEFAULT NULL,
PRIMARY KEY (submission_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="sitetext">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE sitetext (
  sitetext_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  sitetext_code VARCHAR(64) NOT NULL,
  display_id INTEGER(11) NOT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
PRIMARY KEY (sitetext_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="source">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE source (
  source_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  source_code VARCHAR(16) NOT NULL,
  source_name VARCHAR(64) NOT NULL,
PRIMARY KEY (source_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="state">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE state (
  state_id CHAR(2) NOT NULL,
  statetype_id INTEGER(11) NOT NULL,
  state_name VARCHAR(255) NOT NULL,
  state_map_code INTEGER(11) DEFAULT NULL,
  state_map_code2 INTEGER(11) DEFAULT NULL,
PRIMARY KEY (state_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="statetype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE statetype (
  statetype_id INTEGER(11) NOT NULL,
  statetype_name VARCHAR(255) NOT NULL,
  statetype_desc VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (statetype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="subset">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset (
  subset_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  subsettype_id INTEGER(11) NOT NULL,
  code VARCHAR(32) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  display_id INTEGER(11) NOT NULL,
  alt_display_id INTEGER(11) DEFAULT NULL,
  spq_display_id INTEGER(11) DEFAULT NULL,
  oe_name VARCHAR(64) DEFAULT NULL,
  intro_display_id INTEGER(11) DEFAULT NULL,
  resultpage_id INTEGER(11) DEFAULT NULL,
  shadow_subset_id INTEGER(11) DEFAULT NULL,
  branding_partner_id INTEGER(11) DEFAULT NULL,
  active_flag TINYINT(4) UNSIGNED NOT NULL,
  test_flag TINYINT(4) UNSIGNED NOT NULL,
  eform_flag TINYINT(4) UNSIGNED NOT NULL,
  report_flag TINYINT(4) UNSIGNED NOT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
PRIMARY KEY (subset_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="subset_answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_answerfield (
  subset_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL,
  recap_id INTEGER(11) DEFAULT NULL,
  required TINYINT(4) UNSIGNED NOT NULL,
  preset_value VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="subset_gridrow">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_gridrow (
  subset_id INTEGER(11) NOT NULL,
  gridrow_id INTEGER(11) NOT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="subset_partner">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_partner (
  subset_id INTEGER(11) NOT NULL,
  partner_id INTEGER(11) NOT NULL,
  resultpage_id INTEGER(11) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="subset_partner_shadow">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_partner_shadow (
  subset_id INTEGER(11) NOT NULL,
  partner_id INTEGER(11) NOT NULL,
  shadow_subset_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="subset_program">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_program (
  subset_id INTEGER(11) NOT NULL,
  program_id INTEGER(11) NOT NULL,
  exclude_flag INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="subset_program_base">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_program_base (
  subset_id INTEGER(11) NOT NULL,
  program_id INTEGER(11) NOT NULL,
KEY _dta_index_subset_program_base_14_1006626629__K1_K2 (subset_id, program_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="subset_program_sum">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_program_sum (
  subset_id INTEGER(11) NOT NULL,
  program_id INTEGER(11) NOT NULL,
KEY _dta_index_subset_program_sum_14_1022626686__K1_K2 (subset_id, program_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="subset_programcategory">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_programcategory (
  subset_id INTEGER(11) NOT NULL,
  programcategory_id INTEGER(11) NOT NULL,
  exclude_flag INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="subset_question">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_question (
  subset_id INTEGER(11) NOT NULL,
  question_id INTEGER(11) NOT NULL,
  page_id INTEGER(11) DEFAULT NULL,
  required_flag TINYINT(4) UNSIGNED NOT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  options_flag TINYINT(4) UNSIGNED NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="subset_requisite">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subset_requisite (
  subset_id INTEGER(11) NOT NULL,
  requisite_id INTEGER(11) NOT NULL,
  sort INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="subsettype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE subsettype (
  subsettype_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  subsettype_name VARCHAR(32) NOT NULL,
  subsettype_description VARCHAR(255) DEFAULT NULL,
  deprecated_flag TINYINT(4) UNSIGNED NOT NULL,
PRIMARY KEY (subsettype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_answerfield_list">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_answerfield_list (
  answerfield VARCHAR(50) NOT NULL,
  RecID DECIMAL(18,0) NOT NULL,
  answerfieldtype_id INTEGER(11) DEFAULT NULL,
PRIMARY KEY (RecID),
KEY _dta_index_tbl_answerfield_list_14_962102468__K1_K2_K3 (answerfield, RecID, answerfieldtype_id),
KEY _dta_index_tbl_answerfield_list_14_962102468__K3_K1 (answerfieldtype_id, answerfield)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>
	
    <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_entry, tbl_entry_grp, tbl_funding_list which are being archived
	<cfcase value="tbl_entry">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE tbl_entry] (
				[group_id] [numeric](10, 0) NOT NULL,
				[org_name] [varchar] (255) NULL,
				[org_name2] [varchar] (255) NULL,
				[address] [varchar] (255) NULL,
				[address1] [varchar] (255) NULL,
				[address2] [varchar] (255) NULL,
				[city] [varchar] (255) NULL,
				[st] [varchar] (20) NULL,
				[zip] [varchar] (20) NULL,
				[county] [varchar] (255) NULL,
				[counties_served] [text] NULL,
				[cities_served] [text] NULL,
				[zips_served] [text] NULL,
				[phone_no] [varchar] (255) NULL,
				[fax] [varchar] (255) NULL,
				[email] [varchar] (255) NULL,
				[web_site] [varchar] (255) NULL,
				[hours] [varchar] (255) NULL,
				[contact_title] [varchar] (50) NULL,
				[private_ph] [varchar] (100) NULL,
				[contact_frstnm] [varchar] (50) NULL,
				[contact_lstnm] [varchar] (50) NULL,
				[added_by] [varchar] (50) NULL,
				[added_dt] [smalldatetime] NULL,
				[mod_by] [varchar] (50) NULL,
				[mod_dt] [smalldatetime] NULL,
				[org_id] [numeric](10, 0) NOT NULL,
				[RecID] [numeric](10, 0) NOT NULL
			)
		</cfquery>
	</cfcase>

	<cfcase value="tbl_entry_grp">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE tbl_entry_grp] (
				[group_name] [varchar] (200) NULL,
				[group_id] [numeric] (10, 0) NULL,
				[RecID] [numeric] (18, 0) IDENTITY (1, 1) NOT NULL,
				[mod_dt] [datetime] NULL,
				PRIMARY KEY (RecID)
			)
		</cfquery>
	</cfcase>

	<cfcase value="tbl_funding_list">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE tbl_funding_list] (
				[funding_type] [varchar] (50) NULL,
				[id_number] [varchar] (50) NULL,
				[added_by] [varchar] (50) NULL,
				[added_dt] [datetime] NULL,
				[mod_by] [varchar] (50) NULL,
				[mod_dt] [datetime] NULL,
				[RecID] [numeric](18, 0) NOT NULL
			)
		</cfquery>
	</cfcase>--->

	<cfcase value="tbl_generic">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_generic (
  generic_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  generic_name VARCHAR(255) NOT NULL,
PRIMARY KEY (generic_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="tbl_inc_new">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_inc_new (
  tbl_nm CHAR(255) DEFAULT NULL,
  mem1 CHAR(50) DEFAULT NULL,
  mem2 CHAR(50) DEFAULT NULL,
  mem3 CHAR(50) DEFAULT NULL,
  mem4 CHAR(50) DEFAULT NULL,
  mem5 CHAR(50) DEFAULT NULL,
  mem6 CHAR(50) DEFAULT NULL,
  mem7 CHAR(50) DEFAULT NULL,
  mem8 CHAR(50) DEFAULT NULL,
  st CHAR(50) DEFAULT NULL,
  county CHAR(50) DEFAULT NULL,
  moddate VARCHAR(50) DEFAULT NULL,
  tbl_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  proc_id INTEGER(11) DEFAULT NULL,
PRIMARY KEY (tbl_id),
KEY _dta_index_tbl_inc_new_temp_temp_temp_temp_temp_temp_temp_14_137 (mem1, tbl_nm, st),
KEY _dta_index_tbl_inc_new_temp_temp_temp_temp_temp_temp_temp_14_138 (mem2, tbl_nm, st),
KEY _dta_index_tbl_inc_new_temp_temp_temp_temp_temp_temp_temp_14_139 (mem1, mem2, proc_id, tbl_nm),
KEY tbl_id (tbl_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="tbl_major_cat_list">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_major_cat_list (
  major_cat VARCHAR(40) DEFAULT NULL,
  code VARCHAR(32) NOT NULL,
  id_number INTEGER(11) DEFAULT NULL,
  added_by VARCHAR(50) DEFAULT NULL,
  added_dt DATETIME DEFAULT NULL,
  mod_by VARCHAR(50) DEFAULT NULL,
  mod_dt DATETIME DEFAULT NULL,
  RecID DECIMAL(18,0) NOT NULL,
  Sort_order DECIMAL(18,0) DEFAULT NULL,
PRIMARY KEY (RecID)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_mx_asset">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_mx_asset (
  tbl_id DECIMAL(5,0) DEFAULT NULL,
  tbl_nm VARCHAR(255) DEFAULT NULL,
  st CHAR(2) DEFAULT NULL,
  single DECIMAL(12,2) DEFAULT NULL,
  couple DECIMAL(12,2) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_mx_income">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_mx_income (
  tbl_id DECIMAL(5,0) DEFAULT NULL,
  tbl_nm VARCHAR(255) DEFAULT NULL,
  st CHAR(2) DEFAULT NULL,
  single_max DECIMAL(12,2) DEFAULT NULL,
  single_min DECIMAL(12,2) DEFAULT NULL,
  couple_max DECIMAL(12,2) DEFAULT NULL,
  couple_min DECIMAL(12,2) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_opt">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_opt (
  option_nm VARCHAR(255) DEFAULT NULL,
  field_nm VARCHAR(30) DEFAULT NULL,
  fieldtext VARCHAR(50) DEFAULT NULL,
  validation VARCHAR(50) DEFAULT NULL,
  opt_type VARCHAR(30) DEFAULT NULL,
  opt_id DECIMAL(18,0) NOT NULL,
  sort_id INTEGER(11) DEFAULT NULL,
PRIMARY KEY (opt_id),
KEY _dta_index_tbl_opt_14_1570104634__K2_K3 (field_nm, fieldtext),
KEY _dta_index_tbl_opt_14_1570104634__K2_K7_1_3_4_5_6 (option_nm, fieldtext, validation, opt_type, opt_id, field_nm, sort_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_partner">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_partner (
  partner_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  partner_code VARCHAR(16) NOT NULL,
  partner_name VARCHAR(64) NOT NULL,
  partner_url VARCHAR(255) DEFAULT NULL,
  alt_name VARCHAR(64) DEFAULT NULL,
  partnertype_id INTEGER(11) NOT NULL,
  bcu_display_id INTEGER(11) DEFAULT NULL,
  partner_wrapper VARCHAR(255) DEFAULT NULL,
  partner_header VARCHAR(255) DEFAULT NULL,
  partner_footer VARCHAR(255) DEFAULT NULL,
  partner_css VARCHAR(255) DEFAULT NULL,
  partner_titlebar VARCHAR(255) DEFAULT NULL,
  wrapper_id INTEGER(11) DEFAULT NULL,
  cms_doc_no VARCHAR(255) DEFAULT NULL,
  login_only_flag TINYINT(4) UNSIGNED NOT NULL,
  report_flag TINYINT(4) UNSIGNED NOT NULL,
  learn_flag TINYINT(4) UNSIGNED NOT NULL,
  race_flag TINYINT(4) UNSIGNED NOT NULL,
  hispanic_flag TINYINT(4) UNSIGNED NOT NULL,
  links_flag TINYINT(4) UNSIGNED NOT NULL,
  pdf_logo_flag TINYINT(4) UNSIGNED NOT NULL,
  notes LONGTEXT,
  demo TINYINT(4) UNSIGNED DEFAULT NULL,
  parent TINYINT(4) UNSIGNED DEFAULT NULL,
PRIMARY KEY (partner_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_prg_all">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_prg_all (
  RecID DECIMAL(18,0) NOT NULL,
  code VARCHAR(32) DEFAULT NULL,
  prg_id VARCHAR(50) DEFAULT NULL,
  order_num INTEGER(11) DEFAULT NULL,
  pri_sec INTEGER(11) DEFAULT NULL,
  prg_nm VARCHAR(255) DEFAULT NULL,
  prg_desc LONGTEXT,
  st VARCHAR(3) DEFAULT NULL,
  proximity VARCHAR(6) DEFAULT NULL,
  firstproximity VARCHAR(6) DEFAULT NULL,
  comment VARCHAR(255) DEFAULT NULL,
  added_dt DATETIME DEFAULT NULL,
  added_by VARCHAR(50) DEFAULT NULL,
  mod_by VARCHAR(50) DEFAULT NULL,
  mod_dt DATETIME DEFAULT NULL,
  id INTEGER(11) DEFAULT NULL,
  include BOOLEAN NOT NULL,
  source VARCHAR(50) DEFAULT NULL,
  dollar_amount DECIMAL(18,0) NOT NULL,
  Cat_ID INTEGER(11) DEFAULT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL,
  inactive_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  significant_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  childrens_flag TINYINT(4) UNSIGNED DEFAULT NULL,
PRIMARY KEY (RecID),
KEY _dta_index_tbl_prg_all_14_759673754__K1_K22 (RecID, inactive_flag),
KEY _dta_index_tbl_prg_all_14_759673754__K1_K8_K22_K5_K3 (RecID, st, inactive_flag, pri_sec, prg_id),
KEY _dta_index_tbl_prg_all_14_759673754__K22 (inactive_flag),
KEY _dta_index_tbl_prg_all_14_759673754__K3 (prg_id),
KEY _dta_index_tbl_prg_all_14_759673754__K3_K24_K20_K1_K4_K6_8_16 (st, id, prg_id, childrens_flag, Cat_ID, RecID, order_num, prg_nm),
KEY _dta_index_tbl_prg_all_14_759673754__K8 (st),
KEY _dta_index_tbl_prg_all_14_759673754__K8_K1_K22 (st, RecID, inactive_flag),
KEY i_prg_all1 (prg_id, prg_nm, st),
KEY IX_tbl_prg_all (prg_id, st, id),
KEY IX_tbl_prg_all_1 (Cat_ID)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

    <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_prg_entry which is being archived
    <cfcase value="tbl_prg_entry">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE tbl_prg_entry] (
				[group_id] [int] NULL,
				[org_id] [int] NULL,
				[prg_id] [varchar] (50) NULL,
				[added_by] [varchar] (50) NULL,
				[added_dt] [smalldatetime] NULL,
				[RecID] [numeric](18, 0) IDENTITY (1, 1) NOT NULL,
				PRIMARY KEY (RecID)
			)
		</cfquery>
	</cfcase>--->

	<cfcase value="tbl_questions_new">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_questions_new (
  question_id INTEGER(11) NOT NULL,
  answerfield VARCHAR(50) DEFAULT NULL,
  category VARCHAR(50) DEFAULT NULL,
  order_num VARCHAR(50) DEFAULT NULL,
  pri_sec VARCHAR(50) DEFAULT NULL,
  question LONGTEXT,
  type VARCHAR(50) DEFAULT NULL,
  validation VARCHAR(50) DEFAULT NULL,
  client VARCHAR(50) DEFAULT NULL,
  textlength INTEGER(11) DEFAULT NULL,
  dep_field VARCHAR(50) DEFAULT NULL,
  dep_op VARCHAR(50) DEFAULT NULL,
  dep_criteria VARCHAR(50) DEFAULT NULL,
  dep_formula VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	 <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_req_mat, tbl_req_mat_list which are being archived
    <cfcase value="tbl_req_mat">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE tbl_req_mat] (
				[prg_id] [varchar] (50) NULL,
				[req_mat] [varchar] (255) NULL,
				[added_by] [varchar] (50) NULL,
				[added_dt] [datetime] NULL,
				[mod_by] [varchar] (50) NULL,
				[mod_dt] [datetime] NULL,
				[mat_id] [varchar] (50) NULL,
				[req_id] [numeric] (18, 0) NOT NULL
			)
		</cfquery>
	</cfcase>

	<cfcase value="tbl_req_mat_list">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE tbl_req_mat_list] (
				[code] [varchar] (32) NULL,
				[req_mat] [varchar] (255) NULL,
				[added_by] [varchar] (50) NULL,
				[added_dt] [datetime] NULL,
				[mod_by] [varchar] (50) NULL,
				[mod_dt] [datetime] NULL,
				[mat_id] [numeric] (18, 0) NOT NULL,
				[definition] [text] NULL
			)
		</cfquery>
	</cfcase>--->

	<cfcase value="tbl_rules">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_rules (
  prg_id VARCHAR(50) NOT NULL,
  elig_rule LONGTEXT NOT NULL,
  RecID INTEGER(11) NOT NULL AUTO_INCREMENT,
  pri_sec VARCHAR(50) DEFAULT NULL,
PRIMARY KEY (RecID),
KEY _dta_index_tbl_rules_14_983674552__K1 (prg_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_RX_Detail">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_RX_Detail (
  RXDetail_ID INTEGER(11) NOT NULL AUTO_INCREMENT,
  answerfield_id INTEGER(11) DEFAULT NULL,
  Opt_ID INTEGER(11) DEFAULT NULL,
  MFR_ID INTEGER(11) DEFAULT NULL,
  Price INTEGER(11) DEFAULT NULL,
  PriceRating INTEGER(11) DEFAULT NULL,
PRIMARY KEY (RXDetail_ID)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_RX_MFR">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_RX_MFR (
  MFR_ID INTEGER(11) NOT NULL AUTO_INCREMENT,
  MFR_Name VARCHAR(250) DEFAULT NULL,
  Discount_Amount INTEGER(11) DEFAULT NULL,
PRIMARY KEY (MFR_ID)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="tbl_RX_PrgDetail">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_RX_PrgDetail (
  RXPrg_ID INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRG_ID VARCHAR(50) DEFAULT NULL,
  DNumber CHAR(5) DEFAULT NULL,
  StateList VARCHAR(255) DEFAULT NULL,
  CardName VARCHAR(100) DEFAULT NULL,
  SponsorName VARCHAR(100) DEFAULT NULL,
  Address VARCHAR(250) DEFAULT NULL,
  LocatorEnable BOOLEAN DEFAULT NULL,
  CMSEnable BOOLEAN DEFAULT NULL,
PRIMARY KEY (RXPrg_ID)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_RX_Scenarios">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_RX_Scenarios (
  State CHAR(2) DEFAULT NULL,
  Template_name VARCHAR(50) DEFAULT NULL,
  Scenario CHAR(10) DEFAULT NULL,
  SortOrder INTEGER(11) DEFAULT NULL,
  Display_level INTEGER(11) DEFAULT NULL,
  Program VARCHAR(50) DEFAULT NULL,
  RxScenario_ID INTEGER(11) NOT NULL AUTO_INCREMENT,
PRIMARY KEY (RxScenario_ID)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_st">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_st (
  st VARCHAR(3) NOT NULL,
  include VARCHAR(1) NOT NULL,
PRIMARY KEY (st)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="tbl_zip">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tbl_zip (
  ID INTEGER(11) NOT NULL,
  Detail VARCHAR(50) DEFAULT NULL,
  Zip VARCHAR(50) DEFAULT NULL,
  CountofCity SMALLINT(6) DEFAULT NULL,
  CityStName VARCHAR(50) DEFAULT NULL,
  LastLineCity VARCHAR(50) DEFAULT NULL,
  State VARCHAR(50) DEFAULT NULL,
  County VARCHAR(50) DEFAULT NULL,
  `3Digit FIPS County` VARCHAR(50) DEFAULT NULL,
  `5Digit FIPS County` VARCHAR(50) DEFAULT NULL,
  Lat_degree FLOAT(9,3) DEFAULT NULL,
  Lon_degree FLOAT(9,3) DEFAULT NULL,
  Lat FLOAT(9,3) DEFAULT NULL,
  Lon FLOAT(9,3) DEFAULT NULL,
  AreaCode VARCHAR(50) DEFAULT NULL,
  TimeZone VARCHAR(50) DEFAULT NULL,
  H INTEGER(11) DEFAULT NULL,
  V INTEGER(11) DEFAULT NULL,
  FromCensus BOOLEAN NOT NULL,
  temp_old INTEGER(11) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="tblCookCountyCities">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE tblCookCountyCities (
  RecID INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  Zip INTEGER(11) DEFAULT NULL,
  PostalCity VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="template">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE template (
  template_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  filename VARCHAR(255) NOT NULL,
  name VARCHAR(64) DEFAULT NULL,
  canonical_flag TINYINT(4) UNSIGNED NOT NULL,
  source_flag TINYINT(4) UNSIGNED NOT NULL,
  prev_flag TINYINT(4) UNSIGNED NOT NULL,
  org_flag TINYINT(4) UNSIGNED NOT NULL,
  partner_flag TINYINT(4) UNSIGNED NOT NULL,
  subset_flag TINYINT(4) UNSIGNED NOT NULL,
  language_flag TINYINT(4) UNSIGNED NOT NULL,
  access_flag TINYINT(4) UNSIGNED NOT NULL,
  client_flag TINYINT(4) UNSIGNED NOT NULL,
  user_flag TINYINT(4) UNSIGNED NOT NULL,
  state_flag TINYINT(4) UNSIGNED NOT NULL,
  test_flag TINYINT(4) UNSIGNED NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (template_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="url">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE url (
  url_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  protocol_id INTEGER(11) DEFAULT NULL,
  url VARCHAR(255) NOT NULL,
  url_code VARCHAR(16) NOT NULL,
  url_description VARCHAR(255) DEFAULT NULL,
  link_text VARCHAR(255) DEFAULT NULL,
  target_flag TINYINT(4) UNSIGNED NOT NULL,
  active_flag TINYINT(4) UNSIGNED NOT NULL,
PRIMARY KEY (url_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="user">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE user (
  user_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  usertype_id INTEGER(11) NOT NULL,
  username VARCHAR(16) NOT NULL,
  password VARCHAR(16) NOT NULL,
  firstname VARCHAR(64) NOT NULL,
  lastname VARCHAR(64) NOT NULL,
  email VARCHAR(128) DEFAULT NULL,
  active TINYINT(4) UNSIGNED DEFAULT NULL,
  last_login_date DATETIME DEFAULT NULL,
  create_user_id INTEGER(11) NOT NULL,
  create_date DATETIME NOT NULL,
  modify_user_id INTEGER(11) NOT NULL,
  modify_date DATETIME NOT NULL,
  address_id INTEGER(11) DEFAULT NULL,
PRIMARY KEY (user_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="validation">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE validation (                           
  validation_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  validation_code VARCHAR(32) NOT NULL,
  formula LONGTEXT NOT NULL,
  display_id INTEGER(11) NOT NULL,
  validation_desc VARCHAR(255) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="wrapper">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE wrapper (
  wrapper_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  wrapper_partner_id INTEGER(11) DEFAULT NULL,
  wrapper_partner_category INTEGER(11) DEFAULT NULL,
  wrapper_partner_subcategory INTEGER(11) DEFAULT NULL,
  wrapper_type INTEGER(11) DEFAULT NULL,
  wrapper_code VARCHAR(32) DEFAULT NULL,
  wrapper_description VARCHAR(255) DEFAULT NULL,
  wrapper_index VARCHAR(50) DEFAULT NULL,
  wrapper_template VARCHAR(64) DEFAULT NULL,
  wrapper_css VARCHAR(64) DEFAULT NULL,
  wrapper_menu_css VARCHAR(64) DEFAULT NULL,
  wrapper_header LONGTEXT,
  wrapper_footer LONGTEXT,
  wrapper_left_col VARCHAR(1) DEFAULT NULL,
  wrapper_right_col VARCHAR(1) DEFAULT NULL,
  wrapper_cover_image VARCHAR(250) DEFAULT NULL,
  wrapper_logo VARCHAR(250) DEFAULT NULL,
  wrapper_logo_alt_text VARCHAR(250) DEFAULT NULL,
  wrapper_logo_link VARCHAR(250) DEFAULT NULL,
  wrapper_title VARCHAR(250) DEFAULT NULL,
  wrapper_link VARCHAR(250) DEFAULT NULL,
  wrapper_custom_subset INTEGER(11) DEFAULT NULL,
  wrapper_custom_title VARCHAR(150) DEFAULT NULL,
  wrapper_custom_time VARCHAR(150) DEFAULT NULL,
  wrapper_custom_whatithelps INTEGER(11) DEFAULT NULL,
  wrapper_custom_subset2 INTEGER(11) DEFAULT NULL,
  wrapper_custom_title2 VARCHAR(150) DEFAULT NULL,
  wrapper_custom_time2 VARCHAR(150) DEFAULT NULL,
  wrapper_comprehensive INTEGER(11) DEFAULT NULL,
  wrapper_pda INTEGER(11) DEFAULT NULL,
  wrapper_rx INTEGER(11) DEFAULT NULL,
  wrapper_disaster INTEGER(11) DEFAULT NULL,
  wrapper_pap_custom_name VARCHAR(250) DEFAULT NULL,
  wrapper_pap INTEGER(11) DEFAULT NULL,
  wrapper_more_programs LONGTEXT,
  wrapper_moreprograms_template VARCHAR(50) DEFAULT NULL,
  wrapper_afc VARCHAR(50) DEFAULT NULL,
  wrapper_external INTEGER(11) DEFAULT NULL,
  wrapper_external_title VARCHAR(150) DEFAULT NULL,
  wrapper_external_title_graphic VARCHAR(50) DEFAULT NULL,
  wrapper_external_text VARCHAR(250) DEFAULT NULL,
  wrapper_external_time VARCHAR(50) DEFAULT NULL,
  wrapper_external_link VARCHAR(250) DEFAULT NULL,
  wrapper_optional_box_text LONGTEXT,
  wrapper_status INTEGER(11) DEFAULT NULL,
  wrapper_deployment_status INTEGER(11) DEFAULT NULL,
  wrapper_get_started_now LONGTEXT,
  wrapper_bcu_logo VARCHAR(250) DEFAULT NULL,
  wrapper_bcu_logo_alt_text VARCHAR(250) DEFAULT NULL,
  wrapper_bcu_link VARCHAR(250) DEFAULT NULL,
  wrapper_checksum VARCHAR(250) DEFAULT NULL,
  wrapper_changes LONGTEXT,
  wrapper_logo_margin_top INTEGER(11) DEFAULT NULL,
  wrapper_logo_margin_right INTEGER(11) DEFAULT NULL,
  wrapper_menu INTEGER(11) DEFAULT NULL,
  wrapper_top_menu LONGTEXT,
  wrapper_footer_custom LONGTEXT,
  wrapper_printed_text LONGTEXT,
  wrapper_menu_ie_css VARCHAR(250) DEFAULT NULL,
  wrapper_additional_css VARCHAR(250) DEFAULT NULL,
  wrapper_special_link VARCHAR(50) DEFAULT NULL,
  wrapper_special_text VARCHAR(512) DEFAULT NULL,
  wrapper_special INTEGER(11) DEFAULT NULL,
  wrapper_tag1 LONGTEXT,
  wrapper_tag2 LONGTEXT,
  wrapper_tag3 LONGTEXT,
  wrapper_custom_js LONGTEXT,
  wrapper_lis_link_direct INTEGER(11) DEFAULT NULL,
  wrapper_pap_whatithelps INTEGER(11) DEFAULT NULL,
  wrapper_cover_image_alt_text VARCHAR(512) DEFAULT NULL,
  TEST5 VARCHAR(512) DEFAULT NULL,
  wrapper_risk_calculator INTEGER(11) DEFAULT NULL,
  wrapper_show_header INTEGER(11) DEFAULT NULL,
  wrapper_show_footer INTEGER(11) DEFAULT NULL,
  wrapper_left_col_ad VARCHAR(50) DEFAULT NULL,
  wrapper_menu_ad INTEGER(11) DEFAULT NULL,
  wrapper_as_of INTEGER(11) DEFAULT NULL,
  wrapper_bcu_text_logo INTEGER(11) DEFAULT NULL,
  wrapper_menu_ad_html LONGTEXT,
  wrapper_left_col_ad_html LONGTEXT,
  wrapper_iframe INTEGER(11) DEFAULT NULL,
  wrapper_afc_popup INTEGER(11) DEFAULT NULL,
  wrapper_needed_title VARCHAR(250) DEFAULT NULL,
  wrapper_screening_order VARCHAR(250) DEFAULT NULL,
  wrapper_whatithelps INTEGER(11) DEFAULT NULL,
PRIMARY KEY (wrapper_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="xassettype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xassettype (
  assettype_id INTEGER(11) NOT NULL,
  assettype_name VARCHAR(64) NOT NULL,
  assettype_varname VARCHAR(32) NOT NULL,
  sort INTEGER(11) NOT NULL,
  definition VARCHAR(32) DEFAULT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL DEFAULT 0,
PRIMARY KEY (assettype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="xincass">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xincass (
  incass_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  incass_name VARCHAR(64) NOT NULL,
  incass_varname VARCHAR(32) NOT NULL,
  self_single_text LONGTEXT NOT NULL,
  self_married_text LONGTEXT NOT NULL,
  other_single_text LONGTEXT NOT NULL,
  other_married_text LONGTEXT NOT NULL,
  exclude VARCHAR(255) DEFAULT NULL,
  work_flag INTEGER(11) DEFAULT NULL,
  sort INTEGER(11) NOT NULL,
PRIMARY KEY (incass_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="xincometype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xincometype (
  incometype_id INTEGER(11) NOT NULL,
  incometype_name VARCHAR(64) NOT NULL,
  incometype_varname VARCHAR(32) NOT NULL,
  sort INTEGER(11) NOT NULL,
  definition VARCHAR(32) DEFAULT NULL,
  exclude_flag TINYINT(4) UNSIGNED NOT NULL DEFAULT 0,
PRIMARY KEY (incometype_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="xsubset">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xsubset (
  subset_id INTEGER(11) NOT NULL,
  subsettype_id INTEGER(11) NOT NULL,
  code VARCHAR(32) DEFAULT NULL,
  subset_name VARCHAR(255) NOT NULL,
  subset_longname VARCHAR(255) DEFAULT NULL,
  subset_description VARCHAR(255) DEFAULT NULL,
  subset_text LONGTEXT,
  qaire_name VARCHAR(255) DEFAULT NULL,
  alt_name VARCHAR(255) DEFAULT NULL,
  all_flag INTEGER(11) DEFAULT NULL,
  drug_flag INTEGER(11) DEFAULT NULL,
  grid_flag INTEGER(11) DEFAULT NULL,
  optional_flag INTEGER(11) DEFAULT NULL,
  rec_flag INTEGER(11) DEFAULT NULL,
  eform_flag INTEGER(11) DEFAULT NULL,
  schip_flag INTEGER(11) DEFAULT NULL,
  state_flag INTEGER(11) DEFAULT NULL,
  report_flag TINYINT(4) UNSIGNED NOT NULL,
PRIMARY KEY (subset_id)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="xsubset_answerfield">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xsubset_answerfield (
  subset_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL,
  value VARCHAR(64) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<!--- MH: 5/12/10 Removed reference to xsubset_category since it is being archived on BCUQA 
    <cfcase value="xsubset_category">
		<cfquery name="createtable" datasource="#attributes.source#">
			CREATE TABLE xsubset_category] (
				[subset_id] [int] NOT NULL,
				[category_id] [int] NOT NULL,
				[exclude_flag] [int] NULL
			)
		</cfquery>
	</cfcase>--->
	<cfcase value="xsubset_program">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xsubset_program (
  subset_id INTEGER(11) NOT NULL,
  program_id INTEGER(11) NOT NULL,
  exclude_flag INTEGER(11) DEFAULT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

		</cfquery>
	</cfcase>

	<cfcase value="xsubset_xassettype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xsubset_xassettype (
  subset_id INTEGER(11) NOT NULL,
  assettype_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="xsubset_xincass">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xsubset_xincass (
  subset_id INTEGER(11) NOT NULL,
  incass_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="xsubset_xincometype">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE xsubset_xincometype (
  subset_id INTEGER(11) NOT NULL,
  incometype_id INTEGER(11) NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>

	<cfcase value="zip">
		<cfquery name="createtable" datasource="#attributes.source#">
CREATE TABLE zip (
  zipcode CHAR(5) NOT NULL,
  state_id CHAR(2) NOT NULL,
  county_id CHAR(5) DEFAULT NULL,
  latitude FLOAT(9,3) DEFAULT NULL,
  longitude FLOAT(9,3) DEFAULT NULL,
  valid INTEGER(11) NOT NULL,
PRIMARY KEY (zipcode)
)ENGINE=MyISAM
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>
</cfswitch>