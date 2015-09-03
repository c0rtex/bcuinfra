<cfparam name="attributes.table" type="string">
<cfparam name="attributes.source" type="string">
<cfparam name="attributes.drop" type="boolean" default="false">

<cfif attributes.drop>
	<cfquery name="droptable" datasource="#attributes.source#">
		DROP TABLE #attributes.table#
	</cfquery>
</cfif>

<cfswitch expression="#attributes.table#">

<cfcase value="address">
	<cfquery name="createtable" datasource="#attributes.source#">
		  CREATE TABLE address (
		  id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
		  street VARCHAR(50) DEFAULT NULL,
		  city VARCHAR(50) DEFAULT NULL,
		  state VARCHAR(50) DEFAULT NULL,
		  zip VARCHAR(50) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


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
		  KEY _dta_index_answerfield_14_1803153469__K1_K9_K3 (answerfield_id, state_id, answerfield)
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


<cfcase value="areacodes_import">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE areacodes_import (
		  areacode_id INTEGER(11) NOT NULL,
		  zipcode CHAR(10) DEFAULT NULL,
		  areacode CHAR(10) DEFAULT NULL,
		  last_updated CHAR(10) DEFAULT NULL,
		PRIMARY KEY (areacode_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="batch_submission">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE batch_submission (
		  batch_submission_id DECIMAL(18,0) NOT NULL,
		  screening_id DECIMAL(18,0) DEFAULT NULL,
		  source VARCHAR(50) DEFAULT NULL,
		  date_time DATETIME NOT NULL,
		  status_message VARCHAR(500) DEFAULT NULL,
		  batch_id DECIMAL(18,0) DEFAULT NULL,
		  client_id VARCHAR(150) DEFAULT NULL,
		  reentry_number VARCHAR(50) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="batchcontrol">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE batchcontrol (
		  batch_id INTEGER(11) NOT NULL AUTO_INCREMENT,
		  start_date DATETIME NOT NULL,
		  records_count INTEGER(11) DEFAULT NULL,
		  batch_status INTEGER(11) DEFAULT 0,
		  batch_action INTEGER(11) DEFAULT 0,
		PRIMARY KEY (batch_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="bcu_news">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE bcu_news (
		  news_id INTEGER(11) NOT NULL AUTO_INCREMENT,
		  date_added DATETIME NOT NULL,
		  archived SMALLINT(6) NOT NULL,
		  news LONGTEXT,
		  title VARCHAR(255) NOT NULL,
		  date_updated DATETIME DEFAULT NULL,
		  active BOOLEAN DEFAULT NULL,
		PRIMARY KEY (news_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="bdtssabatch">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE bdtssabatch (
		  bdtssabatch_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
		  client_id INTEGER(11) DEFAULT NULL,
		  ct_thrd_pty_xnd VARCHAR(60) DEFAULT NULL,
		  ct_mail_xnd VARCHAR(60) NOT NULL,
		  ct_receive_medicare_xnd VARCHAR(60) DEFAULT NULL,
		  ct_older_xnd VARCHAR(60) DEFAULT NULL,
		  ct_ss_disblty_xnd VARCHAR(60) DEFAULT NULL,
		  ct_live VARCHAR(60) DEFAULT NULL,
		  ct_mrtl_stus VARCHAR(60) DEFAULT NULL,
		  be_sav_lmt_xnd VARCHAR(60) DEFAULT NULL,
		  be_send_mspinfo_cd VARCHAR(53) DEFAULT NULL,
		  be_thrd_fnm VARCHAR(60) DEFAULT NULL,
		  be_thrd_mnm VARCHAR(60) DEFAULT NULL,
		  be_thrd_lnm VARCHAR(60) DEFAULT NULL,
		  be_thrd_rel VARCHAR(60) DEFAULT NULL,
		  be_thrd_rel_oth VARCHAR(60) DEFAULT NULL,
		  be_thrd_phnarea VARCHAR(53) DEFAULT NULL,
		  be_thrd_phnexch VARCHAR(53) DEFAULT NULL,
		  be_thrd_phnnum VARCHAR(53) DEFAULT NULL,
		  be_thrd_addrln_1 VARCHAR(60) DEFAULT NULL,
		  be_thrd_apt_no VARCHAR(60) DEFAULT NULL,
		  be_thrd_addrln_2 VARCHAR(60) DEFAULT NULL,
		  be_thrd_addrln_3 VARCHAR(60) DEFAULT NULL,
		  be_thrd_addr_city VARCHAR(60) DEFAULT NULL,
		  be_thrd_addr_st VARCHAR(60) DEFAULT NULL,
		  be_thrd_addr_zip5 VARCHAR(53) DEFAULT NULL,
		  be_clnt_fnm VARCHAR(60) DEFAULT NULL,
		  be_clnt_mnm VARCHAR(60) DEFAULT NULL,
		  be_clnt_lnm VARCHAR(60) DEFAULT NULL,
		  be_clnt_sfx VARCHAR(60) DEFAULT NULL,
		  be_clnt_cossn VARCHAR(53) DEFAULT NULL,
		  be_clnt_dob_month VARCHAR(53) DEFAULT NULL,
		  be_clnt_dob_day VARCHAR(53) DEFAULT NULL,
		  be_clnt_dob_year VARCHAR(53) DEFAULT NULL,
		  be_clnt_wrkd_l2yr_xnd VARCHAR(60) DEFAULT NULL,
		  be_wh_apply VARCHAR(60) DEFAULT NULL,
		  be_sav_lmt_xnd1 VARCHAR(60) DEFAULT NULL,
		  be_noncl_fnm VARCHAR(60) DEFAULT NULL,
		  be_noncl_mnm VARCHAR(60) DEFAULT NULL,
		  be_noncl_lnm VARCHAR(60) DEFAULT NULL,
		  be_noncl_sfx VARCHAR(60) DEFAULT NULL,
		  be_noncl_cossn VARCHAR(53) DEFAULT NULL,
		  be_noncl_dob_month VARCHAR(53) DEFAULT NULL,
		  be_noncl_dob_day VARCHAR(53) DEFAULT NULL,
		  be_noncl_dob_year VARCHAR(53) DEFAULT NULL,
		  be_noncl_wrkd_l2yr_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_chg_addr_sw VARCHAR(53) DEFAULT NULL,
		  be_clnt_mail_addrln_1 VARCHAR(60) DEFAULT NULL,
		  be_clnt_mail_apt_no VARCHAR(60) DEFAULT NULL,
		  be_clnt_mail_addrln_2 VARCHAR(60) DEFAULT NULL,
		  be_clnt_mail_addrln_3 VARCHAR(60) DEFAULT NULL,
		  be_clnt_mail_addr_city VARCHAR(60) DEFAULT NULL,
		  be_clnt_mail_addr_st VARCHAR(60) DEFAULT NULL,
		  be_clnt_mail_addr_zip5 VARCHAR(53) DEFAULT NULL,
		  be_clnt_phnarea VARCHAR(53) DEFAULT NULL,
		  be_clnt_phnexch VARCHAR(53) DEFAULT NULL,
		  be_clnt_phnnum VARCHAR(53) DEFAULT NULL,
		  be_cntct_fnm VARCHAR(60) DEFAULT NULL,
		  be_cntct_lnm VARCHAR(60) DEFAULT NULL,
		  be_cntct_phnarea VARCHAR(53) DEFAULT NULL,
		  be_cntct_phnexch VARCHAR(53) DEFAULT NULL,
		  be_cntct_phnnum VARCHAR(53) DEFAULT NULL,
		  be_rltvs_sup VARCHAR(53) DEFAULT NULL,
		  be_res_bank_acc_xnd VARCHAR(60) DEFAULT NULL,
		  be_res_bank_acc_amt VARCHAR(53) DEFAULT NULL,
		  be_res_invst_xnd VARCHAR(60) DEFAULT NULL,
		  be_res_invst_amt VARCHAR(53) DEFAULT NULL,
		  be_res_csh_xnd VARCHAR(60) DEFAULT NULL,
		  be_res_csh_amt VARCHAR(53) DEFAULT NULL,
		  be_clnt_buexp_sw VARCHAR(60) DEFAULT NULL,
		  be_noncl_buexp_sw VARCHAR(60) DEFAULT NULL,
		  be_restt_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_ss_benefits_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_ss_benefits_amt VARCHAR(53) DEFAULT NULL,
		  be_noncl_ss_benefits_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_ss_benefits_amt VARCHAR(53) DEFAULT NULL,
		  be_clnt_rr_incm_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_rr_incm_amt VARCHAR(53) DEFAULT NULL,
		  be_noncl_rr_incm_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_rr_incm_amt VARCHAR(60) DEFAULT NULL,
		  be_clnt_va_benefits_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_va_benefits_amt VARCHAR(53) DEFAULT NULL,
		  be_noncl_va_benefits_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_va_benefits_amt VARCHAR(60) DEFAULT NULL,
		  be_clnt_pens_annuit_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_pens_annuit_amt VARCHAR(53) DEFAULT NULL,
		  be_noncl_pens_annuit_xnd VARCHAR(255) DEFAULT NULL,
		  be_noncl_pens_annuit_amt VARCHAR(53) DEFAULT NULL,
		  be_clnt_oth_incm_xnd VARCHAR(255) DEFAULT NULL,
		  be_clnt_oth_incm_amt VARCHAR(53) DEFAULT NULL,
		  be_clnt_oth_incm_typ VARCHAR(255) DEFAULT NULL,
		  be_noncl_oth_incm_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_oth_incm_amt VARCHAR(53) DEFAULT NULL,
		  be_noncl_oth_incm_typ VARCHAR(60) DEFAULT NULL,
		  be_incm_decrs_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_earn_wgs_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_earn_wgs_amt VARCHAR(53) DEFAULT NULL,
		  be_noncl_earn_wgs_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_earn_wgs_amt VARCHAR(60) DEFAULT NULL,
		  be_clnt_earn_loss_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_earn_amt VARCHAR(53) DEFAULT NULL,
		  be_noncl_earn_loss_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_earn_amt VARCHAR(53) DEFAULT NULL,
		  be_wgs_decrs_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_stop_wrk_xnd VARCHAR(60) DEFAULT NULL,
		  be_clnt_stop_wrk_month VARCHAR(53) DEFAULT NULL,
		  be_clnt_stop_wrk_year VARCHAR(53) DEFAULT NULL,
		  be_noncl_stop_wrk_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_stop_wrk_month VARCHAR(53) DEFAULT NULL,
		  be_noncl_stop_wrk_year VARCHAR(53) DEFAULT NULL,
		  be_clnt_pay_disblty_xnd VARCHAR(60) DEFAULT NULL,
		  be_noncl_pay_disblty_xnd VARCHAR(60) DEFAULT NULL,
		  be_thrd_sub_sw VARCHAR(60) DEFAULT NULL,
		  be_clnt_sub_sw VARCHAR(60) DEFAULT NULL,
		  be_noncl_sub_sw VARCHAR(60) DEFAULT NULL,
		  bdtsource VARCHAR(50) DEFAULT NULL,
		  ssasubmission INTEGER(11) DEFAULT 0
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="CDATA">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE CDATA (
		  cfid CHAR(64) DEFAULT NULL,
		  app CHAR(64) DEFAULT NULL,
		  data LONGTEXT,
UNIQUE KEY id1 (cfid, app)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="CGLOBAL">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE CGLOBAL (
		  cfid CHAR(64) DEFAULT NULL,
		  data LONGTEXT,
		  lvisit DATETIME DEFAULT NULL,
KEY id2 (cfid),
KEY id3 (lvisit)
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
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
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


<cfcase value="click">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE click (
		  click_id INTEGER(11) NOT NULL AUTO_INCREMENT,
		  url_id INTEGER(11) NOT NULL,
		  screening_id INTEGER(11) DEFAULT NULL,
		  prev_screening_id INTEGER(11) DEFAULT NULL,
		  cfid INTEGER(11) NOT NULL,
		  cftoken INTEGER(11) NOT NULL,
		  source_id INTEGER(11) DEFAULT NULL,
		  org_id INTEGER(11) DEFAULT NULL,
		  partner_id INTEGER(11) DEFAULT NULL,
		  subset_id INTEGER(11) DEFAULT NULL,
		  language_id CHAR(2) DEFAULT NULL,
		  access_id INTEGER(11) DEFAULT NULL,
		  oe_client_id INTEGER(11) DEFAULT NULL,
		  oe_user_id INTEGER(11) DEFAULT NULL,
		  preset_state_id CHAR(2) DEFAULT NULL,
		  test_flag TINYINT(4) UNSIGNED DEFAULT NULL,
		  target_flag TINYINT(4) UNSIGNED NOT NULL,
		  oe_flag TINYINT(4) UNSIGNED NOT NULL,
		  click_datetime DATETIME NOT NULL,
		  form_id INTEGER(11) DEFAULT NULL,
		  form_target VARCHAR(250) DEFAULT NULL,
		PRIMARY KEY (click_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="conf_contact">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE conf_contact (
  contactID INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  orgName VARCHAR(255) DEFAULT NULL,
  contactName VARCHAR(255) DEFAULT NULL,
  addr1 VARCHAR(255) DEFAULT NULL,
  addr2 VARCHAR(255) DEFAULT NULL,
  city VARCHAR(255) DEFAULT NULL,
  state VARCHAR(255) DEFAULT NULL,
  zip VARCHAR(255) DEFAULT NULL,
  primaryPhone VARCHAR(255) DEFAULT NULL,
  agencyPhone VARCHAR(255) DEFAULT NULL,
  alternatePhone VARCHAR(255) DEFAULT NULL,
  fax VARCHAR(255) DEFAULT NULL,
  tty VARCHAR(255) DEFAULT NULL,
  email VARCHAR(255) DEFAULT NULL,
  web VARCHAR(255) DEFAULT NULL,
  ncoaID VARCHAR(255) DEFAULT NULL,
  outreachLink TINYINT(4) UNSIGNED DEFAULT NULL,
  outreachPublicize TINYINT(4) UNSIGNED DEFAULT NULL,
  outreachMailing TINYINT(4) UNSIGNED DEFAULT NULL,
  outreachBooth TINYINT(4) UNSIGNED DEFAULT NULL,
  outreachWorkshop TINYINT(4) UNSIGNED DEFAULT NULL,
  outreachOther TINYINT(4) UNSIGNED DEFAULT NULL,
  outreachOtherText LONGTEXT,
  outreachPartner TINYINT(4) UNSIGNED DEFAULT NULL,
  outreachMemberInfo TINYINT(4) UNSIGNED DEFAULT NULL,
  comments LONGTEXT,
  contactDate DATETIME DEFAULT NULL
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


<cfcase value="db_name">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE db_name (
  name VARCHAR(255) NOT NULL,
  ip VARCHAR(255) NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="dba_trace_slow_screening">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE dba_trace_slow_screening (
  RowNumber INTEGER(11) NOT NULL AUTO_INCREMENT,
  EventClass INTEGER(11) DEFAULT NULL,
  TextData LONGTEXT,
  ApplicationName VARCHAR(128) DEFAULT NULL,
  NTUserName VARCHAR(128) DEFAULT NULL,
  LoginName VARCHAR(128) DEFAULT NULL,
  CPU INTEGER(11) DEFAULT NULL,
  `Reads` BIGINT(20) DEFAULT NULL,
  Writes BIGINT(20) DEFAULT NULL,
  Duration BIGINT(20) DEFAULT NULL,
  ClientProcessID INTEGER(11) DEFAULT NULL,
  SPID INTEGER(11) DEFAULT NULL,
  StartTime DATETIME DEFAULT NULL,
  EndTime DATETIME DEFAULT NULL,
  BinaryData LONGBLOB,
		PRIMARY KEY (RowNumber)
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


<cfcase value="display_5066">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE display_5066 (
  display_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  displaygroup_id INTEGER(11) DEFAULT NULL,
  display_code VARCHAR(64) NOT NULL,
  display_name VARCHAR(128) NOT NULL,
  display_desc VARCHAR(255) DEFAULT NULL,
  active_flag TINYINT(4) UNSIGNED NOT NULL
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


<cfcase value="display_language_5066">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE display_language_5066 (
  display_id INTEGER(11) NOT NULL,
  language_id CHAR(2) NOT NULL,
  display_text LONGTEXT NOT NULL,
  update_flag TINYINT(4) UNSIGNED NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="display_temp">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE display_temp (
  display_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  displaygroup_id INTEGER(11) DEFAULT NULL,
  display_code VARCHAR(64) NOT NULL,
  display_name VARCHAR(128) NOT NULL,
  display_desc VARCHAR(255) DEFAULT NULL,
  active_flag TINYINT(4) UNSIGNED NOT NULL,
		PRIMARY KEY (display_id),
KEY _dta_index_display_temp_14_834102012__K3_K1 (display_code, display_id)
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


<cfcase value="economicsecurityindex">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE economicsecurityindex (
  economicsecurityindex_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  county_id INTEGER(11) DEFAULT NULL,
  singlewithmortgage INTEGER(11) DEFAULT NULL,
  singlewithoutmortgage INTEGER(11) DEFAULT NULL,
  singlerenter INTEGER(11) DEFAULT NULL,
  jointwithmortgage INTEGER(11) DEFAULT NULL,
  jointwithoutmortgage INTEGER(11) DEFAULT NULL,
  jointrenter INTEGER(11) DEFAULT NULL,
  increasegoodhealth INTEGER(11) DEFAULT NULL,
  descreasebadhealth INTEGER(11) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="entrypoing_entrypointgroup_5066">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE entrypoing_entrypointgroup_5066 (
  entrypoint_id INTEGER(11) NOT NULL,
  entrypointgroup_id INTEGER(11) NOT NULL
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
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="entrypoint_5066">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE entrypoint_5066 (
  entrypoint_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
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
  modify_date DATETIME NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
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


<cfcase value="entrypointgroup_5066">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE entrypointgroup_5066 (
  entrypointgroup_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  name VARCHAR(255) NOT NULL,
  state_id CHAR(2) DEFAULT NULL,
  active_flag INTEGER(11) NOT NULL,
  notes LONGTEXT
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="envvar">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE envvar (
  envvar_id INTEGER(11) NOT NULL,
  envvar_name VARCHAR(64) NOT NULL,
		PRIMARY KEY (envvar_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="epic_results">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE epic_results (
  Col001 VARCHAR(255) DEFAULT NULL,
  Col002 VARCHAR(255) DEFAULT NULL,
  Col003 VARCHAR(255) DEFAULT NULL,
  Col004 VARCHAR(255) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="epicssabatch">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE epicssabatch (
  bdtssabatch_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  client_id VARCHAR(50) DEFAULT NULL,
  ct_thrd_pty_xnd VARCHAR(60) DEFAULT NULL,
  ct_mail_xnd VARCHAR(60) NOT NULL,
  ct_receive_medicare_xnd VARCHAR(60) DEFAULT NULL,
  ct_older_xnd VARCHAR(60) DEFAULT NULL,
  ct_ss_disblty_xnd VARCHAR(60) DEFAULT NULL,
  ct_live VARCHAR(60) DEFAULT NULL,
  ct_mrtl_stus VARCHAR(60) DEFAULT NULL,
  be_sav_lmt_xnd VARCHAR(60) DEFAULT NULL,
  be_send_mspinfo_cd VARCHAR(53) DEFAULT NULL,
  be_thrd_fnm VARCHAR(60) DEFAULT NULL,
  be_thrd_mnm VARCHAR(60) DEFAULT NULL,
  be_thrd_lnm VARCHAR(60) DEFAULT NULL,
  be_thrd_rel VARCHAR(60) DEFAULT NULL,
  be_thrd_rel_oth VARCHAR(60) DEFAULT NULL,
  be_thrd_phnarea VARCHAR(53) DEFAULT NULL,
  be_thrd_phnexch VARCHAR(53) DEFAULT NULL,
  be_thrd_phnnum VARCHAR(53) DEFAULT NULL,
  be_thrd_addrln_1 VARCHAR(60) DEFAULT NULL,
  be_thrd_apt_no VARCHAR(60) DEFAULT NULL,
  be_thrd_addrln_2 VARCHAR(60) DEFAULT NULL,
  be_thrd_addrln_3 VARCHAR(60) DEFAULT NULL,
  be_thrd_addr_city VARCHAR(60) DEFAULT NULL,
  be_thrd_addr_st VARCHAR(60) DEFAULT NULL,
  be_thrd_addr_zip5 VARCHAR(53) DEFAULT NULL,
  be_clnt_fnm VARCHAR(60) DEFAULT NULL,
  be_clnt_mnm VARCHAR(60) DEFAULT NULL,
  be_clnt_lnm VARCHAR(60) DEFAULT NULL,
  be_clnt_sfx VARCHAR(60) DEFAULT NULL,
  be_clnt_cossn VARCHAR(53) DEFAULT NULL,
  be_clnt_dob_month VARCHAR(53) DEFAULT NULL,
  be_clnt_dob_day VARCHAR(53) DEFAULT NULL,
  be_clnt_dob_year VARCHAR(53) DEFAULT NULL,
  be_clnt_wrkd_l2yr_xnd VARCHAR(60) DEFAULT NULL,
  be_wh_apply VARCHAR(60) DEFAULT NULL,
  be_sav_lmt_xnd1 VARCHAR(60) DEFAULT NULL,
  be_noncl_fnm VARCHAR(60) DEFAULT NULL,
  be_noncl_mnm VARCHAR(60) DEFAULT NULL,
  be_noncl_lnm VARCHAR(60) DEFAULT NULL,
  be_noncl_sfx VARCHAR(60) DEFAULT NULL,
  be_noncl_cossn VARCHAR(53) DEFAULT NULL,
  be_noncl_dob_month VARCHAR(53) DEFAULT NULL,
  be_noncl_dob_day VARCHAR(53) DEFAULT NULL,
  be_noncl_dob_year VARCHAR(53) DEFAULT NULL,
  be_noncl_wrkd_l2yr_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_chg_addr_sw VARCHAR(53) DEFAULT NULL,
  be_clnt_mail_addrln_1 VARCHAR(60) DEFAULT NULL,
  be_clnt_mail_apt_no VARCHAR(60) DEFAULT NULL,
  be_clnt_mail_addrln_2 VARCHAR(60) DEFAULT NULL,
  be_clnt_mail_addrln_3 VARCHAR(60) DEFAULT NULL,
  be_clnt_mail_addr_city VARCHAR(60) DEFAULT NULL,
  be_clnt_mail_addr_st VARCHAR(60) DEFAULT NULL,
  be_clnt_mail_addr_zip5 VARCHAR(53) DEFAULT NULL,
  be_clnt_phnarea VARCHAR(53) DEFAULT NULL,
  be_clnt_phnexch VARCHAR(53) DEFAULT NULL,
  be_clnt_phnnum VARCHAR(53) DEFAULT NULL,
  be_cntct_fnm VARCHAR(60) DEFAULT NULL,
  be_cntct_lnm VARCHAR(60) DEFAULT NULL,
  be_cntct_phnarea VARCHAR(53) DEFAULT NULL,
  be_cntct_phnexch VARCHAR(53) DEFAULT NULL,
  be_cntct_phnnum VARCHAR(53) DEFAULT NULL,
  be_rltvs_sup VARCHAR(53) DEFAULT NULL,
  be_res_bank_acc_xnd VARCHAR(60) DEFAULT NULL,
  be_res_bank_acc_amt VARCHAR(53) DEFAULT NULL,
  be_res_invst_xnd VARCHAR(60) DEFAULT NULL,
  be_res_invst_amt VARCHAR(53) DEFAULT NULL,
  be_res_csh_xnd VARCHAR(60) DEFAULT NULL,
  be_res_csh_amt VARCHAR(53) DEFAULT NULL,
  be_clnt_buexp_sw VARCHAR(60) DEFAULT NULL,
  be_noncl_buexp_sw VARCHAR(60) DEFAULT NULL,
  be_restt_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_ss_benefits_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_ss_benefits_amt VARCHAR(53) DEFAULT NULL,
  be_noncl_ss_benefits_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_ss_benefits_amt VARCHAR(53) DEFAULT NULL,
  be_clnt_rr_incm_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_rr_incm_amt VARCHAR(53) DEFAULT NULL,
  be_noncl_rr_incm_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_rr_incm_amt VARCHAR(60) DEFAULT NULL,
  be_clnt_va_benefits_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_va_benefits_amt VARCHAR(53) DEFAULT NULL,
  be_noncl_va_benefits_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_va_benefits_amt VARCHAR(60) DEFAULT NULL,
  be_clnt_pens_annuit_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_pens_annuit_amt VARCHAR(53) DEFAULT NULL,
  be_noncl_pens_annuit_xnd VARCHAR(255) DEFAULT NULL,
  be_noncl_pens_annuit_amt VARCHAR(53) DEFAULT NULL,
  be_clnt_oth_incm_xnd VARCHAR(255) DEFAULT NULL,
  be_clnt_oth_incm_amt VARCHAR(53) DEFAULT NULL,
  be_clnt_oth_incm_typ VARCHAR(255) DEFAULT NULL,
  be_noncl_oth_incm_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_oth_incm_amt VARCHAR(53) DEFAULT NULL,
  be_noncl_oth_incm_typ VARCHAR(60) DEFAULT NULL,
  be_incm_decrs_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_earn_wgs_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_earn_wgs_amt VARCHAR(53) DEFAULT NULL,
  be_noncl_earn_wgs_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_earn_wgs_amt VARCHAR(60) DEFAULT NULL,
  be_clnt_earn_loss_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_earn_amt VARCHAR(53) DEFAULT NULL,
  be_noncl_earn_loss_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_earn_amt VARCHAR(53) DEFAULT NULL,
  be_wgs_decrs_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_stop_wrk_xnd VARCHAR(60) DEFAULT NULL,
  be_clnt_stop_wrk_month VARCHAR(53) DEFAULT NULL,
  be_clnt_stop_wrk_year VARCHAR(53) DEFAULT NULL,
  be_noncl_stop_wrk_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_stop_wrk_month VARCHAR(53) DEFAULT NULL,
  be_noncl_stop_wrk_year VARCHAR(53) DEFAULT NULL,
  be_clnt_pay_disblty_xnd VARCHAR(60) DEFAULT NULL,
  be_noncl_pay_disblty_xnd VARCHAR(60) DEFAULT NULL,
  be_thrd_sub_sw VARCHAR(60) DEFAULT NULL,
  be_clnt_sub_sw VARCHAR(60) DEFAULT NULL,
  be_noncl_sub_sw VARCHAR(60) DEFAULT NULL,
  ssasubmission INTEGER(11) DEFAULT 0
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
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
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


<cfcase value="gavob">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE gavob (
  screening_id INTEGER(11) DEFAULT NULL,
  total DOUBLE(15,3) DEFAULT NULL,
  date_created DATETIME DEFAULT NULL,
  org_id INTEGER(11) DEFAULT NULL
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
  hardrule_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(64) NOT NULL,
		PRIMARY KEY (hardrule_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="hardrule_answerfield">
	<cfquery name="createtable" datasource="#attributes.source#">
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


<cfcase value="kpdata">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE kpdata (
  BDTID VARCHAR(255) DEFAULT NULL,
  ApplicantBurial VARCHAR(255) DEFAULT NULL,
  ApplicantChangeAddress VARCHAR(255) DEFAULT NULL,
  ApplicantSSN VARCHAR(255) DEFAULT NULL,
  ApplicantDOBDay VARCHAR(255) DEFAULT NULL,
  ApplicantDOBMonth VARCHAR(255) DEFAULT NULL,
  ApplicantDOBYear VARCHAR(255) DEFAULT NULL,
  ApplicantSelfEmpNetEarn INTEGER(11) DEFAULT NULL,
  ApplicantSelfEmpEarnLoss VARCHAR(255) DEFAULT NULL,
  ApplicantWageAmount INTEGER(11) DEFAULT NULL,
  ApplicantWageExpect VARCHAR(255) DEFAULT NULL,
  ApplicantFirstName VARCHAR(255) DEFAULT NULL,
  ApplicantHasLifeInsurance VARCHAR(255) DEFAULT NULL,
  ApplicantLastName VARCHAR(255) DEFAULT NULL,
  ApplicantSelfEmpNetLoss VARCHAR(255) DEFAULT NULL,
  ApplicantCity VARCHAR(255) DEFAULT NULL,
  ApplicantState VARCHAR(255) DEFAULT NULL,
  ApplicantZip VARCHAR(255) DEFAULT NULL,
  ApplicantAdd1 VARCHAR(255) DEFAULT NULL,
  ApplicantAdd2 VARCHAR(255) DEFAULT NULL,
  ApplicantAdd3 VARCHAR(255) DEFAULT NULL,
  ApplicantAptNo VARCHAR(255) DEFAULT NULL,
  ApplicantMidInitial VARCHAR(255) DEFAULT NULL,
  ApplicantOtherIncomeMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantOtherIncomeType VARCHAR(255) DEFAULT NULL,
  ApplicantHasOtherIncome VARCHAR(255) DEFAULT NULL,
  ApplicantHasDisabilityExpenses VARCHAR(255) DEFAULT NULL,
  ApplicantPensionMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantHasPension VARCHAR(255) DEFAULT NULL,
  ApplicantAreaCode VARCHAR(255) DEFAULT NULL,
  ApplicantPhoneExchange VARCHAR(255) DEFAULT NULL,
  ApplicantPhoneNumber VARCHAR(255) DEFAULT NULL,
  ApplicantRailroadMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantHasRailroadIncome VARCHAR(255) DEFAULT NULL,
  ApplicantSuffix VARCHAR(255) DEFAULT NULL,
  ApplicantHasSSBenefits VARCHAR(255) DEFAULT NULL,
  ApplicantSSMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantStopWorkMonth VARCHAR(255) DEFAULT NULL,
  ApplicantPlansStopWork VARCHAR(255) DEFAULT NULL,
  ApplicantStopWorkYear VARCHAR(255) DEFAULT NULL,
  ApplicantConsent VARCHAR(255) DEFAULT NULL,
  ApplicantVetMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantHasVetBenefits VARCHAR(255) DEFAULT NULL,
  ApplicantHasWorked VARCHAR(255) DEFAULT NULL,
  ContactFirstName VARCHAR(255) DEFAULT NULL,
  ContactLastName VARCHAR(255) DEFAULT NULL,
  ContactAreaCode VARCHAR(255) DEFAULT NULL,
  ContactPhoneExchange VARCHAR(255) DEFAULT NULL,
  ContactPhoneNumber VARCHAR(255) DEFAULT NULL,
  HouseholdExpensesMonthly VARCHAR(255) DEFAULT NULL,
  HasHouseholdExpenses VARCHAR(255) DEFAULT NULL,
  HouseholdExpensesIncrease VARCHAR(255) DEFAULT NULL,
  LifeInsuranceAmount VARCHAR(255) DEFAULT NULL,
  PayForBurial VARCHAR(255) DEFAULT NULL,
  SpouseSSN VARCHAR(255) DEFAULT NULL,
  SpouseDOBMonth VARCHAR(255) DEFAULT NULL,
  SpouseDOBDay VARCHAR(255) DEFAULT NULL,
  SpouseDOBYear VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpNetEarn VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpEarnLoss VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpEarnMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasWages VARCHAR(255) DEFAULT NULL,
  SpouseWageAmount VARCHAR(255) DEFAULT NULL,
  SpouseFirstName VARCHAR(255) DEFAULT NULL,
  SpouseHasLifeInsurance VARCHAR(255) DEFAULT NULL,
  SpouseLastName VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpNetLoss VARCHAR(255) DEFAULT NULL,
  SpouseMidInitial VARCHAR(255) DEFAULT NULL,
  SpouseOtherIncomeMonthly VARCHAR(255) DEFAULT NULL,
  SpouseOtherIncomeType VARCHAR(255) DEFAULT NULL,
  SpouseHasOtherIncome VARCHAR(255) DEFAULT NULL,
  SpouseHasDisabilityExpenses VARCHAR(255) DEFAULT NULL,
  SpousePensionMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasPension VARCHAR(255) DEFAULT NULL,
  SpouseRailroadMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasRailroadIncome VARCHAR(255) DEFAULT NULL,
  SpouseSuffix VARCHAR(255) DEFAULT NULL,
  SpouseSSAmount VARCHAR(255) DEFAULT NULL,
  SpouseHasSSBenefits VARCHAR(255) DEFAULT NULL,
  SpouseStopWorkMonth VARCHAR(255) DEFAULT NULL,
  SpousePlansStopWork VARCHAR(255) DEFAULT NULL,
  SpouseStopWorkYear VARCHAR(255) DEFAULT NULL,
  SpouseConsent VARCHAR(255) DEFAULT NULL,
  SpouseVetAmountMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasVetBenefits VARCHAR(255) DEFAULT NULL,
  SpouseHasWorked VARCHAR(255) DEFAULT NULL,
  ApplicantBankAmount VARCHAR(255) DEFAULT NULL,
  ApplicantHasBankAccount VARCHAR(255) DEFAULT NULL,
  ApplicantOtherCashAmount VARCHAR(255) DEFAULT NULL,
  ApplicantHasOtherCash VARCHAR(255) DEFAULT NULL,
  ApplicantInvestAmount VARCHAR(255) DEFAULT NULL,
  ApplicantHasInvestments VARCHAR(255) DEFAULT NULL,
  ApplicantHasOtherRealEstate VARCHAR(255) DEFAULT NULL,
  NumDependents VARCHAR(255) DEFAULT NULL,
  AssetsWorthMore VARCHAR(255) DEFAULT NULL,
  CompleterCity VARCHAR(255) DEFAULT NULL,
  CompleterState VARCHAR(255) DEFAULT NULL,
  CompleterZip VARCHAR(255) DEFAULT NULL,
  CompleterAdd1 VARCHAR(255) DEFAULT NULL,
  CompleterAdd2 VARCHAR(255) DEFAULT NULL,
  CompleterAdd3 VARCHAR(255) DEFAULT NULL,
  CompleterAptNo VARCHAR(255) DEFAULT NULL,
  CompleterFirstName VARCHAR(255) DEFAULT NULL,
  CompleterLastName VARCHAR(255) DEFAULT NULL,
  CompleterMidInitial VARCHAR(255) DEFAULT NULL,
  CompleterAreaCode VARCHAR(255) DEFAULT NULL,
  CompleterPhoneExchange VARCHAR(255) DEFAULT NULL,
  CompleterPhoneNumber VARCHAR(255) DEFAULT NULL,
  CompleterRelationship VARCHAR(255) DEFAULT NULL,
  CompleterRelationshipDescr VARCHAR(255) DEFAULT NULL,
  CompleterConsent VARCHAR(255) DEFAULT NULL,
  ApplicantWagesDecreased VARCHAR(255) DEFAULT NULL,
  SpouseMedicareApply VARCHAR(255) DEFAULT NULL,
  State VARCHAR(255) DEFAULT NULL,
  MailApp VARCHAR(255) DEFAULT NULL,
  MaritalStatus VARCHAR(255) DEFAULT NULL,
  Older VARCHAR(255) DEFAULT NULL,
  HasMedicare VARCHAR(255) DEFAULT NULL,
  HasDisabilityBenefits VARCHAR(255) DEFAULT NULL,
  ApplyThirdParty VARCHAR(255) DEFAULT NULL,
  HasFoodStamps VARCHAR(255) DEFAULT NULL,
  HasMedicaid VARCHAR(255) DEFAULT NULL,
  HasAKSeniorCare VARCHAR(255) DEFAULT NULL,
  HasAZCoopeRx VARCHAR(255) DEFAULT NULL,
  HasCADrugDiscount VARCHAR(255) DEFAULT NULL,
  HasConnPACE VARCHAR(255) DEFAULT NULL,
  HasDEDPAP VARCHAR(255) DEFAULT NULL,
  HasHIRxPlus VARCHAR(255) DEFAULT NULL,
  HasILCaresRx VARCHAR(255) DEFAULT NULL,
  HasILRxBuyClub VARCHAR(255) DEFAULT NULL,
  HasINHoosierRx VARCHAR(255) DEFAULT NULL,
  HasMAPrescrAdvantage VARCHAR(255) DEFAULT NULL,
  HasMDPharmAssist VARCHAR(255) DEFAULT NULL,
  HasMDSPDAP VARCHAR(255) DEFAULT NULL,
  HasMEDEL VARCHAR(255) DEFAULT NULL,
  HasMERxPlus VARCHAR(255) DEFAULT NULL,
  HasMIRx VARCHAR(255) DEFAULT NULL,
  HasMORxAssistPlan VARCHAR(255) DEFAULT NULL,
  HasMTBigSkyRx VARCHAR(255) DEFAULT NULL,
  HasNHPDP VARCHAR(255) DEFAULT NULL,
  HasNJPAAD VARCHAR(255) DEFAULT NULL,
  HasNJSeniorGold VARCHAR(255) DEFAULT NULL,
  HasNVSeniorRx VARCHAR(255) DEFAULT NULL,
  HasNYEPIC VARCHAR(255) DEFAULT NULL,
  HasOHBestRx VARCHAR(255) DEFAULT NULL,
  HasOHBuckeye VARCHAR(255) DEFAULT NULL,
  HasORPDAP VARCHAR(255) DEFAULT NULL,
  HasPAPACE VARCHAR(255) DEFAULT NULL,
  HasPAPACENET VARCHAR(255) DEFAULT NULL,
  HasRIPAE VARCHAR(255) DEFAULT NULL,
  HasSCGAPS VARCHAR(255) DEFAULT NULL,
  HasHealthyVermonters VARCHAR(255) DEFAULT NULL,
  HasVTVHAP VARCHAR(255) DEFAULT NULL,
  HasVTVPharmLevel1 VARCHAR(255) DEFAULT NULL,
  HasVTVPharmLevel2 VARCHAR(255) DEFAULT NULL,
  HasVTVPharmLevel3 VARCHAR(255) DEFAULT NULL,
  HasVTVScript VARCHAR(255) DEFAULT NULL,
  HasVTScriptExp VARCHAR(255) DEFAULT NULL,
  HasWISeniorCare VARCHAR(255) DEFAULT NULL,
  HasWVGoldenMountain VARCHAR(255) DEFAULT NULL,
  HasWYPDAP VARCHAR(255) DEFAULT NULL,
  HasMSP VARCHAR(255) DEFAULT NULL,
  HasSSI VARCHAR(255) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="kpdata2">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE kpdata2 (
  BDTID VARCHAR(255) DEFAULT NULL,
  ApplicantBurial VARCHAR(255) DEFAULT NULL,
  ApplicantChangeAddress VARCHAR(255) DEFAULT NULL,
  ApplicantSSN VARCHAR(255) DEFAULT NULL,
  ApplicantDOBDay VARCHAR(255) DEFAULT NULL,
  ApplicantDOBMonth VARCHAR(255) DEFAULT NULL,
  ApplicantDOBYear VARCHAR(255) DEFAULT NULL,
  ApplicantSelfEmpNetEarn VARCHAR(255) DEFAULT NULL,
  ApplicantSelfEmpEarnLoss VARCHAR(255) DEFAULT NULL,
  ApplicantSelfEmpEarnMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantWageAmount VARCHAR(255) DEFAULT NULL,
  ApplicantWageExpect VARCHAR(255) DEFAULT NULL,
  ApplicantFirstName VARCHAR(255) DEFAULT NULL,
  ApplicantHasLifeInsurance VARCHAR(255) DEFAULT NULL,
  ApplicantLastName VARCHAR(255) DEFAULT NULL,
  ApplicantSelfEmpNetLoss VARCHAR(255) DEFAULT NULL,
  ApplicantCity VARCHAR(255) DEFAULT NULL,
  ApplicantState VARCHAR(255) DEFAULT NULL,
  ApplicantZip VARCHAR(255) DEFAULT NULL,
  ApplicantAdd1 VARCHAR(255) DEFAULT NULL,
  ApplicantAdd2 VARCHAR(255) DEFAULT NULL,
  ApplicantAdd3 VARCHAR(255) DEFAULT NULL,
  ApplicantAptNo VARCHAR(255) DEFAULT NULL,
  ApplicantMidInitial VARCHAR(255) DEFAULT NULL,
  ApplicantOtherIncomeMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantOtherIncomeType VARCHAR(255) DEFAULT NULL,
  ApplicantHasOtherIncome VARCHAR(255) DEFAULT NULL,
  ApplicantHasDisabilityExpenses VARCHAR(255) DEFAULT NULL,
  ApplicantPensionMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantHasPension VARCHAR(255) DEFAULT NULL,
  ApplicantAreaCode VARCHAR(255) DEFAULT NULL,
  ApplicantPhoneExchange VARCHAR(255) DEFAULT NULL,
  ApplicantPhoneNumber VARCHAR(255) DEFAULT NULL,
  ApplicantRailroadMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantHasRailroadIncome VARCHAR(255) DEFAULT NULL,
  ApplicantSuffix VARCHAR(255) DEFAULT NULL,
  ApplicantHasSSBenefits VARCHAR(255) DEFAULT NULL,
  ApplicantSSMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantStopWorkMonth VARCHAR(255) DEFAULT NULL,
  ApplicantPlansStopWork VARCHAR(255) DEFAULT NULL,
  ApplicantStopWorkYear VARCHAR(255) DEFAULT NULL,
  ApplicantConsent VARCHAR(255) DEFAULT NULL,
  ApplicantVetMonthly VARCHAR(255) DEFAULT NULL,
  ApplicantHasVetBenefits VARCHAR(255) DEFAULT NULL,
  ApplicantHasWorked VARCHAR(255) DEFAULT NULL,
  ContactFirstName VARCHAR(255) DEFAULT NULL,
  ContactLastName VARCHAR(255) DEFAULT NULL,
  ContactAreaCode VARCHAR(255) DEFAULT NULL,
  ContactPhoneExchange VARCHAR(255) DEFAULT NULL,
  ContactPhoneNumber VARCHAR(255) DEFAULT NULL,
  HouseholdExpensesMonthly VARCHAR(255) DEFAULT NULL,
  HasHouseholdExpenses VARCHAR(255) DEFAULT NULL,
  HouseholdExpensesIncrease VARCHAR(255) DEFAULT NULL,
  LifeInsuranceAmount VARCHAR(255) DEFAULT NULL,
  PayForBurial VARCHAR(255) DEFAULT NULL,
  SpouseSSN VARCHAR(255) DEFAULT NULL,
  SpouseDOBMonth VARCHAR(255) DEFAULT NULL,
  SpouseDOBDay VARCHAR(255) DEFAULT NULL,
  SpouseDOBYear VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpNetEarn VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpEarnLoss VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpEarnMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasWages VARCHAR(255) DEFAULT NULL,
  SpouseWageAmount VARCHAR(255) DEFAULT NULL,
  SpouseFirstName VARCHAR(255) DEFAULT NULL,
  SpouseHasLifeInsurance VARCHAR(255) DEFAULT NULL,
  SpouseLastName VARCHAR(255) DEFAULT NULL,
  SpouseSelfEmpNetLoss VARCHAR(255) DEFAULT NULL,
  SpouseMidInitial VARCHAR(255) DEFAULT NULL,
  SpouseOtherIncomeMonthly VARCHAR(255) DEFAULT NULL,
  SpouseOtherIncomeType VARCHAR(255) DEFAULT NULL,
  SpouseHasOtherIncome VARCHAR(255) DEFAULT NULL,
  SpouseHasDisabilityExpenses VARCHAR(255) DEFAULT NULL,
  SpousePensionMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasPension VARCHAR(255) DEFAULT NULL,
  SpouseRailroadMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasRailroadIncome VARCHAR(255) DEFAULT NULL,
  SpouseSuffix VARCHAR(255) DEFAULT NULL,
  SpouseSSAmount VARCHAR(255) DEFAULT NULL,
  SpouseHasSSBenefits VARCHAR(255) DEFAULT NULL,
  SpouseStopWorkMonth VARCHAR(255) DEFAULT NULL,
  SpousePlansStopWork VARCHAR(255) DEFAULT NULL,
  SpouseStopWorkYear VARCHAR(255) DEFAULT NULL,
  SpouseConsent VARCHAR(255) DEFAULT NULL,
  SpouseVetAmountMonthly VARCHAR(255) DEFAULT NULL,
  SpouseHasVetBenefits VARCHAR(255) DEFAULT NULL,
  SpouseHasWorked VARCHAR(255) DEFAULT NULL,
  ApplicantBankAmount VARCHAR(255) DEFAULT NULL,
  ApplicantHasBankAccount VARCHAR(255) DEFAULT NULL,
  ApplicantOtherCashAmount VARCHAR(255) DEFAULT NULL,
  ApplicantHasOtherCash VARCHAR(255) DEFAULT NULL,
  ApplicantInvestAmount VARCHAR(255) DEFAULT NULL,
  ApplicantHasInvestments VARCHAR(255) DEFAULT NULL,
  ApplicantHasOtherRealEstate VARCHAR(255) DEFAULT NULL,
  NumDependents VARCHAR(255) DEFAULT NULL,
  AssetsWorthMore VARCHAR(255) DEFAULT NULL,
  CompleterCity VARCHAR(255) DEFAULT NULL,
  CompleterState VARCHAR(255) DEFAULT NULL,
  CompleterZip VARCHAR(255) DEFAULT NULL,
  CompleterAdd1 VARCHAR(255) DEFAULT NULL,
  CompleterAdd2 VARCHAR(255) DEFAULT NULL,
  CompleterAdd3 VARCHAR(255) DEFAULT NULL,
  CompleterAptNo VARCHAR(255) DEFAULT NULL,
  CompleterFirstName VARCHAR(255) DEFAULT NULL,
  CompleterLastName VARCHAR(255) DEFAULT NULL,
  CompleterMidInitial VARCHAR(255) DEFAULT NULL,
  CompleterAreaCode VARCHAR(255) DEFAULT NULL,
  CompleterPhoneExchange VARCHAR(255) DEFAULT NULL,
  CompleterPhoneNumber VARCHAR(255) DEFAULT NULL,
  CompleterRelationship VARCHAR(255) DEFAULT NULL,
  CompleterRelationshipDescr VARCHAR(255) DEFAULT NULL,
  CompleterConsent VARCHAR(255) DEFAULT NULL,
  ApplicantWagesDecreased VARCHAR(255) DEFAULT NULL,
  SpouseMedicareApply VARCHAR(255) DEFAULT NULL,
  State VARCHAR(255) DEFAULT NULL,
  MailApp VARCHAR(255) DEFAULT NULL,
  MaritalStatus VARCHAR(255) DEFAULT NULL,
  Older VARCHAR(255) DEFAULT NULL,
  HasMedicare VARCHAR(255) DEFAULT NULL,
  HasDisabilityBenefits VARCHAR(255) DEFAULT NULL,
  ApplyThirdParty VARCHAR(255) DEFAULT NULL,
  HasFoodStamps VARCHAR(255) DEFAULT NULL,
  HasMedicaid VARCHAR(255) DEFAULT NULL,
  HasAKSeniorCare VARCHAR(255) DEFAULT NULL,
  HasAZCoopeRx VARCHAR(255) DEFAULT NULL,
  HasCADrugDiscount VARCHAR(255) DEFAULT NULL,
  HasConnPACE VARCHAR(255) DEFAULT NULL,
  HasDEDPAP VARCHAR(255) DEFAULT NULL,
  HasHIRxPlus VARCHAR(255) DEFAULT NULL,
  HasILCaresRx VARCHAR(255) DEFAULT NULL,
  HasILRxBuyClub VARCHAR(255) DEFAULT NULL,
  HasINHoosierRx VARCHAR(255) DEFAULT NULL,
  HasMAPrescrAdvantage VARCHAR(255) DEFAULT NULL,
  HasMDPharmAssist VARCHAR(255) DEFAULT NULL,
  HasMDSPDAP VARCHAR(255) DEFAULT NULL,
  HasMEDEL VARCHAR(255) DEFAULT NULL,
  HasMERxPlus VARCHAR(255) DEFAULT NULL,
  HasMIRx VARCHAR(255) DEFAULT NULL,
  HasMORxAssistPlan VARCHAR(255) DEFAULT NULL,
  HasMTBigSkyRx VARCHAR(255) DEFAULT NULL,
  HasNHPDP VARCHAR(255) DEFAULT NULL,
  HasNJPAAD VARCHAR(255) DEFAULT NULL,
  HasNJSeniorGold VARCHAR(255) DEFAULT NULL,
  HasNVSeniorRx VARCHAR(255) DEFAULT NULL,
  HasNYEPIC VARCHAR(255) DEFAULT NULL,
  HasOHBestRx VARCHAR(255) DEFAULT NULL,
  HasOHBuckeye VARCHAR(255) DEFAULT NULL,
  HasORPDAP VARCHAR(255) DEFAULT NULL,
  HasPAPACE VARCHAR(255) DEFAULT NULL,
  HasPAPACENET VARCHAR(255) DEFAULT NULL,
  HasRIPAE VARCHAR(255) DEFAULT NULL,
  HasSCGAPS VARCHAR(255) DEFAULT NULL,
  HasHealthyVermonters VARCHAR(255) DEFAULT NULL,
  HasVTVHAP VARCHAR(255) DEFAULT NULL,
  HasVTVPharmLevel1 VARCHAR(255) DEFAULT NULL,
  HasVTVPharmLevel2 VARCHAR(255) DEFAULT NULL,
  HasVTVPharmLevel3 VARCHAR(255) DEFAULT NULL,
  HasVTVScript VARCHAR(255) DEFAULT NULL,
  HasVTScriptExp VARCHAR(255) DEFAULT NULL,
  HasWISeniorCare VARCHAR(255) DEFAULT NULL,
  HasWVGoldenMountain VARCHAR(255) DEFAULT NULL,
  HasWYPDAP VARCHAR(255) DEFAULT NULL,
  HasMSP VARCHAR(255) DEFAULT NULL,
  HasSSI VARCHAR(255) DEFAULT NULL
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


<cfcase value="logPageViews">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE logPageViews (
  id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  dateCreated DATETIME NOT NULL,
  county_id CHAR(50) DEFAULT NULL,
  program_id CHAR(50) DEFAULT NULL,
  state_id CHAR(50) DEFAULT NULL,
  zipcode CHAR(50) DEFAULT NULL,
  partner_id CHAR(50) DEFAULT NULL,
  address CHAR(100) NOT NULL,
  host CHAR(100) NOT NULL,
  referer CHAR(100) NOT NULL,
  agent VARCHAR(255) NOT NULL,
  page CHAR(100) NOT NULL,
  cfid CHAR(100) DEFAULT NULL,
  cftoken CHAR(100) DEFAULT NULL,
  application_id CHAR(10) NOT NULL DEFAULT '0'
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="medenrollment">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE medenrollment (
  confirmationnumber VARCHAR(50) DEFAULT NULL,
  submitdate DATETIME DEFAULT NULL,
  firstname VARCHAR(50) DEFAULT NULL,
  lastname VARCHAR(50) DEFAULT NULL,
  dob DATETIME DEFAULT NULL,
  zip CHAR(5) DEFAULT NULL,
  sponsor_id VARCHAR(10) DEFAULT NULL,
  source_id CHAR(10) DEFAULT NULL,
  referring_id VARCHAR(50) DEFAULT NULL,
  trans_id INTEGER(11) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="mp_acronym">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE mp_acronym (
  acronym_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  letter VARCHAR(50) NOT NULL,
  acronym VARCHAR(50) NOT NULL,
  term LONGTEXT NOT NULL,
		PRIMARY KEY (acronym_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="mp_codebook2">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE mp_codebook2 (
  codebook_id INTEGER(11) NOT NULL,
  variable_label VARCHAR(50) DEFAULT NULL,
  short_title VARCHAR(100) DEFAULT NULL,
  long_title VARCHAR(255) DEFAULT NULL,
  program VARCHAR(100) DEFAULT NULL,
  type_of_variable VARCHAR(50) DEFAULT NULL,
  origin VARCHAR(50) DEFAULT NULL,
  nature_of_calculation VARCHAR(100) DEFAULT NULL,
  agency VARCHAR(100) DEFAULT NULL,
  `2009` VARCHAR(255) DEFAULT NULL,
  `2008` VARCHAR(255) DEFAULT NULL,
  `2007` VARCHAR(255) DEFAULT NULL,
  `2006` VARCHAR(255) DEFAULT NULL,
  `2005` VARCHAR(255) DEFAULT NULL,
  `2004` VARCHAR(255) DEFAULT NULL,
  `2003` VARCHAR(255) DEFAULT NULL,
  notes_and_sources LONGTEXT,
  acronyms VARCHAR(255) DEFAULT NULL,
  uses_of_the_data LONGTEXT
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="mp_codebook2_3">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE mp_codebook2_3 (
  codebook_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  variable_label VARCHAR(50) DEFAULT NULL,
  short_title VARCHAR(100) DEFAULT NULL,
  long_title VARCHAR(255) DEFAULT NULL,
  program VARCHAR(100) DEFAULT NULL,
  type_of_variable VARCHAR(50) DEFAULT NULL,
  origin VARCHAR(50) DEFAULT NULL,
  nature_of_calculation VARCHAR(100) DEFAULT NULL,
  agency VARCHAR(100) DEFAULT NULL,
  `2009` VARCHAR(255) DEFAULT NULL,
  `2008` VARCHAR(255) DEFAULT NULL,
  `2007` VARCHAR(255) DEFAULT NULL,
  `2006` VARCHAR(255) DEFAULT NULL,
  `2005` VARCHAR(255) DEFAULT NULL,
  `2004` VARCHAR(255) DEFAULT NULL,
  `2003` VARCHAR(255) DEFAULT NULL,
  notes_and_sources LONGTEXT,
  acronyms VARCHAR(255) DEFAULT NULL,
  uses_of_the_data LONGTEXT,
		PRIMARY KEY (codebook_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="mp_codebook2_backup">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE mp_codebook2_backup (
  codebook_id INTEGER(11) NOT NULL,
  variable_label VARCHAR(50) DEFAULT NULL,
  short_title VARCHAR(100) DEFAULT NULL,
  long_title VARCHAR(255) DEFAULT NULL,
  program VARCHAR(100) DEFAULT NULL,
  type_of_variable VARCHAR(50) DEFAULT NULL,
  origin VARCHAR(50) DEFAULT NULL,
  nature_of_calculation VARCHAR(100) DEFAULT NULL,
  agency VARCHAR(100) DEFAULT NULL,
  `2009` VARCHAR(255) DEFAULT NULL,
  `2008` VARCHAR(255) DEFAULT NULL,
  `2007` VARCHAR(255) DEFAULT NULL,
  `2006` VARCHAR(255) DEFAULT NULL,
  `2005` VARCHAR(255) DEFAULT NULL,
  `2004` VARCHAR(255) DEFAULT NULL,
  `2003` VARCHAR(255) DEFAULT NULL,
  notes_and_sources LONGTEXT,
  acronyms VARCHAR(255) DEFAULT NULL,
  uses_of_the_data LONGTEXT
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="mp_dataelement_bak">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE mp_dataelement_bak (
  dataelement_id INTEGER(11) NOT NULL,
  fips INTEGER(11) DEFAULT NULL,
  state VARCHAR(50) DEFAULT NULL,
  county VARCHAR(50) DEFAULT NULL,
  year INTEGER(11) DEFAULT NULL,
  level VARCHAR(50) DEFAULT NULL,
  partdelg INTEGER(11) DEFAULT NULL,
  listargets INTEGER(11) DEFAULT NULL,
  enrolledpdp INTEGER(11) DEFAULT NULL,
  enrolledma INTEGER(11) DEFAULT NULL,
  enrolledretiree INTEGER(11) DEFAULT NULL,
  enrolledother INTEGER(11) DEFAULT NULL,
  lisduals INTEGER(11) DEFAULT NULL,
  lismspssi INTEGER(11) DEFAULT NULL,
  lisothernodeem INTEGER(11) DEFAULT NULL,
  mspenrollees INTEGER(11) DEFAULT NULL,
  totalpd INTEGER(11) DEFAULT NULL,
  totallis INTEGER(11) DEFAULT NULL,
  totalliselg INTEGER(11) DEFAULT NULL,
  totalcovered INTEGER(11) DEFAULT NULL,
  totalautoenroll INTEGER(11) DEFAULT NULL,
  ssitotal INTEGER(11) DEFAULT NULL,
  snapeleg60 INTEGER(11) DEFAULT NULL,
  snapelegall INTEGER(11) DEFAULT NULL,
  partsnapadjall INTEGER(11) DEFAULT NULL,
  partsnapall INTEGER(11) DEFAULT NULL,
  partsnapeld INTEGER(11) DEFAULT NULL,
  tothhfedmax INTEGER(11) DEFAULT NULL,
  tothh100fpl INTEGER(11) DEFAULT NULL,
  tothh150fpl INTEGER(11) DEFAULT NULL,
  liheappartheathh INTEGER(11) DEFAULT NULL,
  liheappartcoolhh INTEGER(11) DEFAULT NULL,
  cpstotpop65 INTEGER(11) DEFAULT NULL,
  cpsfpl100 INTEGER(11) DEFAULT NULL,
  cpsfpl125 INTEGER(11) DEFAULT NULL,
  cpsfpl135 INTEGER(11) DEFAULT NULL,
  cpsfpl150 INTEGER(11) DEFAULT NULL,
  cpsfpl185 INTEGER(11) DEFAULT NULL,
  cpsfpl200 INTEGER(11) DEFAULT NULL,
  asc100fpl INTEGER(11) DEFAULT NULL,
  asc125fpl INTEGER(11) DEFAULT NULL,
  asc150fpl INTEGER(11) DEFAULT NULL,
  asc200fpl INTEGER(11) DEFAULT NULL,
  asc300fpl INTEGER(11) DEFAULT NULL,
  pdconcen DOUBLE(15,3) DEFAULT NULL,
  lisconcen DOUBLE(15,3) DEFAULT NULL,
  mspconcen DOUBLE(15,3) DEFAULT NULL,
  partratepd DOUBLE(15,3) DEFAULT NULL,
  coveragerate DOUBLE(15,3) DEFAULT NULL,
  partratelis DOUBLE(15,3) DEFAULT NULL,
  listargetrate DOUBLE(15,3) DEFAULT NULL,
  autoenrollrate DOUBLE(15,3) DEFAULT NULL,
  listopd DOUBLE(15,3) DEFAULT NULL,
  chnglistargtrate DOUBLE(15,3) DEFAULT NULL,
  lostdeemed INTEGER(11) DEFAULT NULL,
  lostdeemrate DOUBLE(15,3) DEFAULT NULL,
  state_abbv VARCHAR(4) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="mp_dataelement2">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE mp_dataelement2 (
  dataelement_id INTEGER(11) NOT NULL,
  fips INTEGER(11) DEFAULT NULL,
  state VARCHAR(50) DEFAULT NULL,
  county VARCHAR(50) DEFAULT NULL,
  year INTEGER(11) DEFAULT NULL,
  level VARCHAR(50) DEFAULT NULL,
  partdelg INTEGER(11) DEFAULT NULL,
  listargets INTEGER(11) DEFAULT NULL,
  enrolledpdp INTEGER(11) DEFAULT NULL,
  enrolledma INTEGER(11) DEFAULT NULL,
  enrolledretiree INTEGER(11) DEFAULT NULL,
  enrolledother INTEGER(11) DEFAULT NULL,
  lisduals INTEGER(11) DEFAULT NULL,
  lismspssi INTEGER(11) DEFAULT NULL,
  lisothernodeem INTEGER(11) DEFAULT NULL,
  mspenrollees INTEGER(11) DEFAULT NULL,
  totalpd INTEGER(11) DEFAULT NULL,
  totallis INTEGER(11) DEFAULT NULL,
  totalliselg INTEGER(11) DEFAULT NULL,
  totalcovered INTEGER(11) DEFAULT NULL,
  totalautoenroll INTEGER(11) DEFAULT NULL,
  ssitotal INTEGER(11) DEFAULT NULL,
  snapeleg60 INTEGER(11) DEFAULT NULL,
  snapelegall INTEGER(11) DEFAULT NULL,
  partsnapadjall INTEGER(11) DEFAULT NULL,
  partsnapall INTEGER(11) DEFAULT NULL,
  partsnapeld INTEGER(11) DEFAULT NULL,
  tothhfedmax INTEGER(11) DEFAULT NULL,
  tothh100fpl INTEGER(11) DEFAULT NULL,
  tothh150fpl INTEGER(11) DEFAULT NULL,
  liheappartheathh INTEGER(11) DEFAULT NULL,
  liheappartcoolhh INTEGER(11) DEFAULT NULL,
  cpstotpop65 INTEGER(11) DEFAULT NULL,
  cpsfpl100 INTEGER(11) DEFAULT NULL,
  cpsfpl125 INTEGER(11) DEFAULT NULL,
  cpsfpl135 INTEGER(11) DEFAULT NULL,
  cpsfpl150 INTEGER(11) DEFAULT NULL,
  cpsfpl185 INTEGER(11) DEFAULT NULL,
  cpsfpl200 INTEGER(11) DEFAULT NULL,
  asc100fpl INTEGER(11) DEFAULT NULL,
  asc125fpl INTEGER(11) DEFAULT NULL,
  asc150fpl INTEGER(11) DEFAULT NULL,
  asc200fpl INTEGER(11) DEFAULT NULL,
  asc300fpl INTEGER(11) DEFAULT NULL,
  pdconcen DOUBLE(15,3) DEFAULT NULL,
  lisconcen DOUBLE(15,3) DEFAULT NULL,
  mspconcen DOUBLE(15,3) DEFAULT NULL,
  partratepd DOUBLE(15,3) DEFAULT NULL,
  coveragerate DOUBLE(15,3) DEFAULT NULL,
  partratelis DOUBLE(15,3) DEFAULT NULL,
  listargetrate DOUBLE(15,3) DEFAULT NULL,
  autoenrollrate DOUBLE(15,3) DEFAULT NULL,
  listopd DOUBLE(15,3) DEFAULT NULL,
  chnglistargtrate DOUBLE(15,3) DEFAULT NULL,
  lostdeemed INTEGER(11) DEFAULT NULL,
  lostdeemrate DOUBLE(15,3) DEFAULT NULL,
  state_abbv VARCHAR(4) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="mp_dataelement2_backup">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE mp_dataelement2_backup (
  dataelement_id INTEGER(11) NOT NULL,
  fips INTEGER(11) DEFAULT NULL,
  state VARCHAR(50) DEFAULT NULL,
  county VARCHAR(50) DEFAULT NULL,
  year INTEGER(11) DEFAULT NULL,
  level VARCHAR(50) DEFAULT NULL,
  partdelg INTEGER(11) DEFAULT NULL,
  listargets INTEGER(11) DEFAULT NULL,
  enrolledpdp INTEGER(11) DEFAULT NULL,
  enrolledma INTEGER(11) DEFAULT NULL,
  enrolledretiree INTEGER(11) DEFAULT NULL,
  enrolledother INTEGER(11) DEFAULT NULL,
  lisduals INTEGER(11) DEFAULT NULL,
  lismspssi INTEGER(11) DEFAULT NULL,
  lisothernodeem INTEGER(11) DEFAULT NULL,
  mspenrollees INTEGER(11) DEFAULT NULL,
  totalpd INTEGER(11) DEFAULT NULL,
  totallis INTEGER(11) DEFAULT NULL,
  totalliselg INTEGER(11) DEFAULT NULL,
  totalcovered INTEGER(11) DEFAULT NULL,
  totalautoenroll INTEGER(11) DEFAULT NULL,
  ssitotal INTEGER(11) DEFAULT NULL,
  snapeleg60 INTEGER(11) DEFAULT NULL,
  snapelegall INTEGER(11) DEFAULT NULL,
  partsnapadjall INTEGER(11) DEFAULT NULL,
  partsnapall INTEGER(11) DEFAULT NULL,
  partsnapeld INTEGER(11) DEFAULT NULL,
  tothhfedmax INTEGER(11) DEFAULT NULL,
  tothh100fpl INTEGER(11) DEFAULT NULL,
  tothh150fpl INTEGER(11) DEFAULT NULL,
  liheappartheathh INTEGER(11) DEFAULT NULL,
  liheappartcoolhh INTEGER(11) DEFAULT NULL,
  cpstotpop65 INTEGER(11) DEFAULT NULL,
  cpsfpl100 INTEGER(11) DEFAULT NULL,
  cpsfpl125 INTEGER(11) DEFAULT NULL,
  cpsfpl135 INTEGER(11) DEFAULT NULL,
  cpsfpl150 INTEGER(11) DEFAULT NULL,
  cpsfpl185 INTEGER(11) DEFAULT NULL,
  cpsfpl200 INTEGER(11) DEFAULT NULL,
  asc100fpl INTEGER(11) DEFAULT NULL,
  asc125fpl INTEGER(11) DEFAULT NULL,
  asc150fpl INTEGER(11) DEFAULT NULL,
  asc200fpl INTEGER(11) DEFAULT NULL,
  asc300fpl INTEGER(11) DEFAULT NULL,
  pdconcen DOUBLE(15,3) DEFAULT NULL,
  lisconcen DOUBLE(15,3) DEFAULT NULL,
  mspconcen DOUBLE(15,3) DEFAULT NULL,
  partratepd DOUBLE(15,3) DEFAULT NULL,
  coveragerate DOUBLE(15,3) DEFAULT NULL,
  partratelis DOUBLE(15,3) DEFAULT NULL,
  listargetrate DOUBLE(15,3) DEFAULT NULL,
  autoenrollrate DOUBLE(15,3) DEFAULT NULL,
  listopd DOUBLE(15,3) DEFAULT NULL,
  chnglistargtrate DOUBLE(15,3) DEFAULT NULL,
  lostdeemed INTEGER(11) DEFAULT NULL,
  lostdeemrate DOUBLE(15,3) DEFAULT NULL,
  state_abbv VARCHAR(4) DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="news">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE news (
  news_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  news_dte DATETIME DEFAULT NULL,
  news_ncoa_id INTEGER(11) DEFAULT NULL,
  news_hed VARCHAR(512) DEFAULT NULL,
  news_status INTEGER(11) DEFAULT NULL,
  news_added DATETIME DEFAULT NULL,
		PRIMARY KEY (news_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="`option`">
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


<cfcase value="pageview">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE pageview (
  pageview_id INTEGER(11) NOT NULL,
  server_id INTEGER(11) DEFAULT NULL,
  cfid INTEGER(11) DEFAULT NULL,
  cftoken INTEGER(11) DEFAULT NULL,
  is_redirect TINYINT(4) UNSIGNED NOT NULL,
  pageview_datetime DATETIME NOT NULL,
		PRIMARY KEY (pageview_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="pageview_envvar">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE pageview_envvar (
  pageview_id INTEGER(11) NOT NULL,
  envvar_id INTEGER(11) NOT NULL,
  var_value VARCHAR(255) NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="pageview_sessionvar">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE pageview_sessionvar (
  pageview_id INTEGER(11) NOT NULL,
  sessionvar_id INTEGER(11) NOT NULL,
  var_value VARCHAR(16) NOT NULL
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


<cfcase value="phone_5066">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE phone_5066 (
  phone_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  entrypoint_id INTEGER(11) NOT NULL,
  phonetype_id INTEGER(11) NOT NULL,
  number VARCHAR(255) NOT NULL,
  sort INTEGER(11) NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="phone_temp">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE phone_temp (
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
  /*
  KEY _dta_index_program_14_279672044__K12_K1_K3_K15_4 (program_code, active_flag, program_id, state_id, sort),
  KEY _dta_index_program_14_279672044__K2_K5_K15_1_3_4_6_7_8_9_10_11_1 (program_id, state_id, program_code, desc_display_id, url, exclude_flag, significant_flag, programgroup_id, active_flag, funder_id, reference_id, legacy_prg_id, legacy_pri_sec, create_user_id, create_date, modify_user_id, modify_date, programcategory_id, name_display_id, sort),
  KEY _dta_index_program_14_279672044__K4 (program_code),
  KEY _dta_index_program_14_279672044__K5_K2_K15_1_3_4_6_7_8_9_10_11_1 (program_id, state_id, program_code, desc_display_id, url, exclude_flag, significant_flag, programgroup_id, active_flag, funder_id, reference_id, legacy_prg_id, legacy_pri_sec, create_user_id, create_date, modify_user_id, modify_date, name_display_id, programcategory_id, sort)
  */
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


<cfcase value="program_answerfield_original">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE program_answerfield_original (
  program_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="program_dollarvalue">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE program_dollarvalue (
  program_id INTEGER(11) NOT NULL,
  dollarvalue DOUBLE(15,3) NOT NULL,
  formula LONGTEXT,
  eval_order INTEGER(11) DEFAULT NULL
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


<cfcase value="`rule`">
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


<cfcase value="screening">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE screening (
  screening_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  prev_screening_id INTEGER(11) DEFAULT NULL,
  cfid BIGINT(20) NOT NULL,
  cftoken BIGINT(20) NOT NULL,
  source_id INTEGER(11) DEFAULT NULL,
  org_id INTEGER(11) DEFAULT NULL,
  partner_id INTEGER(11) DEFAULT NULL,
  subset_id INTEGER(11) DEFAULT NULL,
  language_id CHAR(2) DEFAULT NULL,
  access_id INTEGER(11) DEFAULT NULL,
  client_id VARCHAR(64) DEFAULT NULL,
  user_id VARCHAR(64) DEFAULT NULL,
  preset_state_id CHAR(2) DEFAULT NULL,
  test_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  start_datetime DATETIME NOT NULL,
  end_datetime DATETIME DEFAULT NULL,
		PRIMARY KEY (screening_id),
KEY _dta_index_screening_14_1294627655__K2_K3_K4_K5_K6_K7_K8_K10_K14 (screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id, subset_id, access_id, test_flag, language_id, client_id, user_id, preset_state_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="screening_answerfield">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE screening_answerfield (
  screening_id INTEGER(11) NOT NULL,
  answerfield_id INTEGER(11) NOT NULL,
  responsetype INTEGER(11) NOT NULL,
  response VARCHAR(64) DEFAULT NULL,
  option_id INTEGER(11) DEFAULT NULL,
  pagenum INTEGER(11) NOT NULL,
  retained_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  derived_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  approximation_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  submit_datetime DATETIME NOT NULL,
  encryption_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  encrypted_response LONGTEXT,
KEY _dta_index_screening_answerfield_c_5_848722076__K1 (screening_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="screening_program">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE screening_program (
  screening_id INTEGER(11) NOT NULL,
  program_id INTEGER(11) NOT NULL,
  unseen_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  buffer_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  maybe_flag TINYINT(4) UNSIGNED DEFAULT NULL
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


<cfcase value="screening_tmp">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE screening_tmp (
  screening_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  prev_screening_id INTEGER(11) DEFAULT NULL,
  cfid BIGINT(20) NOT NULL,
  cftoken BIGINT(20) NOT NULL,
  source_id INTEGER(11) DEFAULT NULL,
  org_id INTEGER(11) DEFAULT NULL,
  partner_id INTEGER(11) DEFAULT NULL,
  subset_id INTEGER(11) DEFAULT NULL,
  language_id CHAR(2) DEFAULT NULL,
  access_id INTEGER(11) DEFAULT NULL,
  client_id VARCHAR(64) DEFAULT NULL,
  user_id VARCHAR(64) DEFAULT NULL,
  preset_state_id CHAR(2) DEFAULT NULL,
  test_flag TINYINT(4) UNSIGNED DEFAULT NULL,
  start_datetime DATETIME NOT NULL,
  end_datetime DATETIME DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="sessionvar">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE sessionvar (
  sessionvar_id INTEGER(11) NOT NULL,
  sessionvar_name VARCHAR(16) NOT NULL,
		PRIMARY KEY (sessionvar_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="shipsenroll">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE shipsenroll (
  cso_id INTEGER(11) DEFAULT NULL,
  shipsreferring_id VARCHAR(255) DEFAULT NULL,
  orgname VARCHAR(255) DEFAULT NULL,
  firstname VARCHAR(255) DEFAULT NULL,
  lastname VARCHAR(255) DEFAULT NULL,
  addressline1 VARCHAR(255) DEFAULT NULL,
  addressline2 VARCHAR(255) DEFAULT NULL,
  city VARCHAR(255) DEFAULT NULL,
  state VARCHAR(255) DEFAULT NULL,
  zip VARCHAR(255) DEFAULT NULL,
  primaryphone VARCHAR(255) DEFAULT NULL,
  f12 VARCHAR(255) DEFAULT NULL,
  f13 VARCHAR(255) DEFAULT NULL
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


<cfcase value="spider">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider (
  spider_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_root VARCHAR(250) DEFAULT NULL,
  spider_path VARCHAR(250) DEFAULT NULL,
  spider_template VARCHAR(250) DEFAULT NULL,
  spider_source LONGTEXT,
  spider_status INTEGER(11) DEFAULT NULL,
  spider_assigned_to VARCHAR(50) DEFAULT NULL,
  spider_uuid VARCHAR(50) DEFAULT NULL,
  spider_queries INTEGER(11) DEFAULT NULL,
  spider_custom_tags INTEGER(11) DEFAULT NULL,
  spider_includes INTEGER(11) DEFAULT NULL,
  spider_datestamp DATETIME DEFAULT NULL,
		PRIMARY KEY (spider_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_custom_tag">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_custom_tag (
  spider_custom_tag_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_custom_tag_uuid VARCHAR(50) DEFAULT NULL,
  spider_custom_tag_custom_tag VARCHAR(4000) DEFAULT NULL,
		PRIMARY KEY (spider_custom_tag_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_include">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_include (
  spider_include_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_include_spider_id INTEGER(11) DEFAULT NULL,
  spider_include_include_spider_id INTEGER(11) DEFAULT NULL,
		PRIMARY KEY (spider_include_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_param">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_param (
  spider_param_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_param_param VARCHAR(250) DEFAULT NULL,
  spider_param_uuid VARCHAR(50) DEFAULT NULL,
		PRIMARY KEY (spider_param_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_param_spider">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_param_spider (
  spider_param_spider_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_param_spider_param_id INTEGER(11) DEFAULT NULL,
  spider_param_spider_spider_id INTEGER(11) DEFAULT NULL,
  spider_param_spider_query_id INTEGER(11) DEFAULT NULL,
		PRIMARY KEY (spider_param_spider_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_query">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_query (
  spider_query_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_query_spider_id INTEGER(11) DEFAULT NULL,
  spider_query_no INTEGER(11) DEFAULT NULL,
  spider_query_query LONGTEXT,
  spider_query_tables VARCHAR(4000) DEFAULT NULL,
  spider_query_params VARCHAR(4000) DEFAULT NULL,
  spider_query_status INTEGER(11) DEFAULT NULL,
  spider_query_uuid VARCHAR(50) DEFAULT NULL,
		PRIMARY KEY (spider_query_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_table">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_table (
  spider_table_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_table_name VARCHAR(50) DEFAULT NULL,
  spider_table_uuid VARCHAR(50) DEFAULT NULL,
		PRIMARY KEY (spider_table_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_table_spider">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_table_spider (
  spider_table_spider_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_table_spider_table_id INTEGER(11) DEFAULT NULL,
  spider_table_spider_spider_id INTEGER(11) DEFAULT NULL,
  spider_table_spider_query_id INTEGER(11) DEFAULT NULL,
		PRIMARY KEY (spider_table_spider_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_tag">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_tag (
  spider_tag_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_tag_custom_tag_id INTEGER(11) DEFAULT NULL,
  spider_tag_spider_id INTEGER(11) DEFAULT NULL,
		PRIMARY KEY (spider_tag_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="spider_template">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE spider_template (
  spider_template_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  spider_template_path VARCHAR(250) DEFAULT NULL,
  spider_template_template VARCHAR(250) DEFAULT NULL,
  spider_template_assigned_to VARCHAR(50) DEFAULT NULL,
  spider_template_status VARCHAR(50) DEFAULT NULL,
  spider_template_uuid VARCHAR(50) DEFAULT NULL,
  spider_template_added DATETIME DEFAULT NULL,
		PRIMARY KEY (spider_template_id)
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


<cfcase value="survey">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE survey (
  survey_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  screening_id INTEGER(11) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state_id CHAR(2) NOT NULL,
  phone VARCHAR(255) DEFAULT NULL,
  email VARCHAR(255) DEFAULT NULL,
  learn LONGTEXT,
		PRIMARY KEY (survey_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="sysdiagrams">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE sysdiagrams (
  name VARCHAR(128) NOT NULL,
  principal_id INTEGER(11) NOT NULL,
  diagram_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  version INTEGER(11) DEFAULT NULL,
  definition LONGBLOB,
		PRIMARY KEY (diagram_id),
UNIQUE KEY UK_principal_name (principal_id, name),
KEY diagram_id (diagram_id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tablecleaner">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tablecleaner (
  tablecleaner_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  tablecleaner_table_name LONGTEXT,
  tablecleaner_status INTEGER(11) DEFAULT NULL,
  tablecleaner_virus INTEGER(11) DEFAULT NULL,
  tablecleaner_virus_cols LONGTEXT,
  tablecleaner_viruses LONGTEXT,
		PRIMARY KEY (tablecleaner_id)
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


<cfcase value="tbl_hints">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_hints (
  id DECIMAL(18,0) NOT NULL,
  keyword VARCHAR(50) DEFAULT NULL,
  definition LONGTEXT,
  mod_dt DATETIME DEFAULT NULL,
		PRIMARY KEY (id)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tbl_id">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_id (
  id INTEGER(11) NOT NULL
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


<cfcase value="tbl_nextkey">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_nextkey (
  tablename VARCHAR(32) NOT NULL,
  nextkey DECIMAL(18,0) NOT NULL
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


<cfcase value="tbl_tally">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_tally (
  bcu INTEGER(11) NOT NULL,
  rx INTEGER(11) NOT NULL,
  brand INTEGER(11) NOT NULL,
  generic INTEGER(11) NOT NULL,
  drug INTEGER(11) NOT NULL,
  updated DATETIME NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tbl_user_ans">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_user_ans (
  RecID DECIMAL(18,0) NOT NULL,
  CLIENTNUM DECIMAL(18,0) NOT NULL,
  IDNUMBER DECIMAL(18,0) DEFAULT NULL,
  ZIP DECIMAL(18,0) DEFAULT NULL,
  CFID DECIMAL(18,0) DEFAULT NULL,
  CFTOKEN DECIMAL(18,0) DEFAULT NULL,
  BLIND CHAR(1) DEFAULT NULL,
  ABUSED CHAR(1) DEFAULT NULL,
  ALZHEIMER CHAR(1) DEFAULT NULL,
  CITIZEN VARCHAR(30) DEFAULT NULL,
  CLIENT VARCHAR(12) DEFAULT NULL,
  CLIENT1 VARCHAR(12) DEFAULT NULL,
  CLIENT_OTHER VARCHAR(50) DEFAULT NULL,
  PAGECOUNT INTEGER(11) DEFAULT NULL,
  COUNTY VARCHAR(50) DEFAULT NULL,
  DEP_CARE CHAR(1) DEFAULT NULL,
  DEP_CARE_COSTS VARCHAR(12) DEFAULT NULL,
  DEP_CHILD CHAR(2) DEFAULT NULL,
  DEP_TAX CHAR(1) DEFAULT NULL,
  DEV_CTRY CHAR(1) DEFAULT NULL,
  DISABLED CHAR(1) DEFAULT NULL,
  DOB CHAR(4) DEFAULT NULL,
  EMERG_NEEDS CHAR(1) DEFAULT NULL,
  FAM_MEM CHAR(4) DEFAULT NULL,
  FDSTMP_RECEIVE CHAR(1) DEFAULT NULL,
  FED_GOV CHAR(1) DEFAULT NULL,
  FRAIL CHAR(1) DEFAULT NULL,
  GENDER CHAR(12) DEFAULT NULL,
  GOV CHAR(1) DEFAULT NULL,
  HH_ASSET_AUTO1 VARCHAR(12) DEFAULT NULL,
  HH_ASSET_AUTO2 VARCHAR(12) DEFAULT NULL,
  HH_ASSET_BANK VARCHAR(12) DEFAULT NULL,
  HH_ASSET_CASH VARCHAR(12) DEFAULT NULL,
  HH_ASSET_HOME VARCHAR(12) DEFAULT NULL,
  HH_ASSET_IRREVOCABLE VARCHAR(12) DEFAULT NULL,
  HH_ASSET_LIFE_CASH VARCHAR(12) DEFAULT NULL,
  HH_ASSET_LIFE_FACE VARCHAR(12) DEFAULT NULL,
  HH_ASSET_OTHER_A VARCHAR(12) DEFAULT NULL,
  HH_ASSET_RETIREMENT VARCHAR(12) DEFAULT NULL,
  HH_ASSET_REVOCABLE VARCHAR(12) DEFAULT NULL,
  HH_ASSET_STOCKS VARCHAR(12) DEFAULT NULL,
  HH_ASSET_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  HH_DISABLED VARCHAR(12) DEFAULT NULL,
  HH_INCOME_CASH_ASSIST VARCHAR(12) DEFAULT NULL,
  HH_INCOME_DIVIDENDS VARCHAR(12) DEFAULT NULL,
  HH_INCOME_EARNED VARCHAR(12) DEFAULT NULL,
  HH_INCOME_OTHER_NW VARCHAR(12) DEFAULT NULL,
  HH_INCOME_PRI_RETIRE VARCHAR(12) DEFAULT NULL,
  HH_INCOME_RR_BEN VARCHAR(12) DEFAULT NULL,
  HH_INCOME_SS_DISABLE VARCHAR(12) DEFAULT NULL,
  HH_INCOME_SS_RETIRE VARCHAR(12) DEFAULT NULL,
  HH_INCOME_SSI VARCHAR(12) DEFAULT NULL,
  HH_INCOME_TANF VARCHAR(12) DEFAULT NULL,
  HH_INCOME_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  HH_INCOME_TOTAL_UNEARNED VARCHAR(12) DEFAULT NULL,
  HH_INCOME_UNEMPLOY VARCHAR(12) DEFAULT NULL,
  HH_INCOME_VET_BEN VARCHAR(12) DEFAULT NULL,
  HOME_RECEIVE VARCHAR(12) DEFAULT NULL,
  HOMEBOUND VARCHAR(12) DEFAULT NULL,
  HOUSEDURATION VARCHAR(12) DEFAULT NULL,
  HOUSING VARCHAR(20) DEFAULT NULL,
  IMPAIRMENT_SUB_EMP_DIS VARCHAR(12) DEFAULT NULL,
  IMPAIRMENT_SUB_EMP_IMP VARCHAR(12) DEFAULT NULL,
  INT_ALZHEIMER CHAR(1) DEFAULT NULL,
  INT_ASSISTECH CHAR(1) DEFAULT NULL,
  INT_BLIND CHAR(1) DEFAULT NULL,
  INT_DEAF CHAR(1) DEFAULT NULL,
  INT_EDU CHAR(1) DEFAULT NULL,
  INT_ELDER_NUT CHAR(1) DEFAULT NULL,
  INT_EMP CHAR(1) DEFAULT NULL,
  INT_INC_EXCL CHAR(1) DEFAULT NULL,
  INT_LOW_INC_HOUSE CHAR(1) DEFAULT NULL,
  INT_MEDICARE CHAR(1) DEFAULT NULL,
  INT_SR_HOUSING CHAR(1) DEFAULT NULL,
  INT_TAXES CHAR(1) DEFAULT NULL,
  INT_TRANS_PERSONAL CHAR(1) DEFAULT NULL,
  INT_VOL CHAR(1) DEFAULT NULL,
  LEGAL CHAR(1) DEFAULT NULL,
  LIHEAP_RECEIVE CHAR(1) DEFAULT NULL,
  MANAGEMENT CHAR(1) DEFAULT NULL,
  MARITAL_STAT VARCHAR(64) DEFAULT NULL,
  MED_COSTS VARCHAR(12) DEFAULT NULL,
  MED_RECEIVE CHAR(1) DEFAULT NULL,
  MEDICARE_RECEIVE CHAR(1) DEFAULT NULL,
  MISCSELF VARCHAR(12) DEFAULT NULL,
  MISCSPOUSE VARCHAR(12) DEFAULT NULL,
  NO_HH_MEMBERS VARCHAR(12) DEFAULT NULL,
  OVER_60 VARCHAR(12) DEFAULT NULL,
  PRI_RESIDENT VARCHAR(12) DEFAULT NULL,
  PROPERTY_TAX VARCHAR(12) DEFAULT NULL,
  RAILROAD VARCHAR(12) DEFAULT NULL,
  REALPROPERTY_VALUE VARCHAR(12) DEFAULT NULL,
  RECEIVE_PUB_HOUSING VARCHAR(12) DEFAULT NULL,
  RECEIVE_SECTION8 VARCHAR(12) DEFAULT NULL,
  RENT VARCHAR(12) DEFAULT NULL,
  RR_RECEIVE_2 VARCHAR(12) DEFAULT NULL,
  RR_YEARS VARCHAR(12) DEFAULT NULL,
  RX_DRUGCOSTS VARCHAR(12) DEFAULT NULL,
  RX_INS VARCHAR(12) DEFAULT NULL,
  RX_INS_CO_PAY VARCHAR(12) DEFAULT NULL,
  S_ASSET_AUTO1 VARCHAR(12) DEFAULT NULL,
  S_ASSET_AUTO2 VARCHAR(12) DEFAULT NULL,
  S_ASSET_CASH VARCHAR(12) DEFAULT NULL,
  S_ASSET_HOME VARCHAR(12) DEFAULT NULL,
  S_ASSET_IRREVOCABLE VARCHAR(12) DEFAULT NULL,
  S_ASSET_LIFE_CASH VARCHAR(12) DEFAULT NULL,
  S_ASSET_LIFE_FACE VARCHAR(12) DEFAULT NULL,
  S_ASSET_OTHER_A VARCHAR(12) DEFAULT NULL,
  S_ASSET_RETIREMENT VARCHAR(12) DEFAULT NULL,
  S_ASSET_REVOCABLE VARCHAR(12) DEFAULT NULL,
  S_ASSET_STOCKS VARCHAR(12) DEFAULT NULL,
  S_ASSET_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  S_INCOME_CASH_ASSIST VARCHAR(12) DEFAULT NULL,
  S_INCOME_DIVIDENDS VARCHAR(12) DEFAULT NULL,
  S_INCOME_EARNED VARCHAR(12) DEFAULT NULL,
  S_INCOME_OTHER_NW VARCHAR(12) DEFAULT NULL,
  S_INCOME_PRI_RETIRE VARCHAR(12) DEFAULT NULL,
  S_INCOME_RR_BEN VARCHAR(12) DEFAULT NULL,
  S_INCOME_SS_DISABLE VARCHAR(12) DEFAULT NULL,
  S_INCOME_SS_RETIRE VARCHAR(12) DEFAULT NULL,
  S_INCOME_SSI VARCHAR(12) DEFAULT NULL,
  S_INCOME_TANF VARCHAR(12) DEFAULT NULL,
  S_INCOME_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  S_INCOME_TOTAL_UNEARNED VARCHAR(12) DEFAULT NULL,
  S_INCOME_UNEMPLOY VARCHAR(12) DEFAULT NULL,
  S_INCOME_VET_BEN VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_AUTO1 VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_AUTO2 VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_BANK VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_CASH VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_HOME VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_IRREVOCABLE VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_LIFE_CASH VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_LIFE_FACE VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_OTHER_A VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_RETIREMENT VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_REVOCABLE VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_STOCKS VARCHAR(12) DEFAULT NULL,
  S_SP_ASSET_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_CASH_ASSIST VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_DIVIDENDS VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_EARNED VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_OTHER_NW VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_PRI_RETIRE VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_RR_BEN VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_SS_DISABLE VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_SS_RETIRE VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_SSI VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_TANF VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_TOTAL_UNEARNED VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_UNEMPLOY VARCHAR(12) DEFAULT NULL,
  S_SP_INCOME_VET_BEN VARCHAR(12) DEFAULT NULL,
  SHELTER_COSTS VARCHAR(12) DEFAULT NULL,
  QUESCOUNT VARCHAR(12) DEFAULT NULL,
  SKIPASSETS VARCHAR(12) DEFAULT NULL,
  SKIPINC VARCHAR(12) DEFAULT NULL,
  SOLD VARCHAR(12) DEFAULT NULL,
  SP_ALZHEIMER VARCHAR(12) DEFAULT NULL,
  SP_ASSET_AUTO1 VARCHAR(12) DEFAULT NULL,
  SP_ASSET_AUTO2 VARCHAR(12) DEFAULT NULL,
  SP_ASSET_CASH VARCHAR(12) DEFAULT NULL,
  SP_ASSET_HOME VARCHAR(12) DEFAULT NULL,
  SP_ASSET_IRREVOCABLE VARCHAR(12) DEFAULT NULL,
  SP_ASSET_LIFE_CASH VARCHAR(12) DEFAULT NULL,
  SP_ASSET_LIFE_FACE VARCHAR(12) DEFAULT NULL,
  SP_ASSET_OTHER_A VARCHAR(12) DEFAULT NULL,
  SP_ASSET_RETIREMENT VARCHAR(12) DEFAULT NULL,
  SP_ASSET_REVOCABLE VARCHAR(12) DEFAULT NULL,
  SP_ASSET_STOCKS VARCHAR(12) DEFAULT NULL,
  SP_ASSET_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  SP_BLIND VARCHAR(12) DEFAULT NULL,
  SP_DEC_BLIND VARCHAR(12) DEFAULT NULL,
  SP_DEP VARCHAR(12) DEFAULT NULL,
  SP_DEP_CARE VARCHAR(12) DEFAULT NULL,
  SP_DISABLED VARCHAR(12) DEFAULT NULL,
  SP_DOB VARCHAR(12) DEFAULT NULL,
  SP_FED_GOV VARCHAR(12) DEFAULT NULL,
  SP_GOV VARCHAR(12) DEFAULT NULL,
  SP_HOMEBOUND VARCHAR(12) DEFAULT NULL,
  SP_INCOME_CASH_ASSIST VARCHAR(12) DEFAULT NULL,
  SP_INCOME_DIVIDENDS VARCHAR(12) DEFAULT NULL,
  SP_INCOME_EARNED VARCHAR(12) DEFAULT NULL,
  SP_INCOME_OTHER_NW VARCHAR(12) DEFAULT NULL,
  SP_INCOME_PRI_RETIRE VARCHAR(12) DEFAULT NULL,
  SP_INCOME_RR_BEN VARCHAR(12) DEFAULT NULL,
  SP_INCOME_SS_DISABLE VARCHAR(12) DEFAULT NULL,
  SP_INCOME_SS_RETIRE VARCHAR(12) DEFAULT NULL,
  SP_INCOME_SSI VARCHAR(12) DEFAULT NULL,
  SP_INCOME_TANF VARCHAR(12) DEFAULT NULL,
  SP_INCOME_TOTAL_COMPLETE VARCHAR(12) DEFAULT NULL,
  SP_INCOME_TOTAL_UNEARNED VARCHAR(12) DEFAULT NULL,
  SP_INCOME_UNEMPLOY VARCHAR(12) DEFAULT NULL,
  SP_INCOME_VET_BEN VARCHAR(12) DEFAULT NULL,
  SP_RAILROAD VARCHAR(12) DEFAULT NULL,
  SP_RR_YEARS VARCHAR(12) DEFAULT NULL,
  SP_SS_YEARS CHAR(2) DEFAULT NULL,
  SP_VET_DIS_PERM VARCHAR(12) DEFAULT NULL,
  SP_VET_DISABILITY VARCHAR(12) DEFAULT NULL,
  SP_VET_HON VARCHAR(12) DEFAULT NULL,
  SP_VET_NONEMP VARCHAR(12) DEFAULT NULL,
  SP_VETERAN VARCHAR(12) DEFAULT NULL,
  SS_RECEIVE CHAR(1) DEFAULT NULL,
  SS_YEARS VARCHAR(12) DEFAULT NULL,
  SSD_RECEIVE VARCHAR(12) DEFAULT NULL,
  SSD_RECEIVE_2 VARCHAR(12) DEFAULT NULL,
  SSI_RECEIVE CHAR(1) DEFAULT NULL,
  ST CHAR(2) DEFAULT NULL,
  STATEDURATION VARCHAR(12) DEFAULT NULL,
  STRONGPATH VARCHAR(64) DEFAULT NULL,
  TEL_COSTS CHAR(1) DEFAULT NULL,
  TEL_DISCONNECT VARCHAR(12) DEFAULT NULL,
  UNEMP_RECEIVE CHAR(1) DEFAULT NULL,
  UTILITY CHAR(1) DEFAULT NULL,
  VET_ALASKA CHAR(1) DEFAULT NULL,
  VET_CAMPAIGN CHAR(1) DEFAULT NULL,
  VET_DIS_CERTIFIED CHAR(1) DEFAULT NULL,
  VET_DIS_PERM CHAR(1) DEFAULT NULL,
  VET_DISABILITY CHAR(1) DEFAULT NULL,
  VET_HON CHAR(1) DEFAULT NULL,
  VET_KOREAN CHAR(1) DEFAULT NULL,
  VET_LEGALRES CHAR(1) DEFAULT NULL,
  VET_NONEMP CHAR(1) DEFAULT NULL,
  VET_SP_DIED CHAR(1) DEFAULT NULL,
  VET_WARTIME CHAR(1) DEFAULT NULL,
  VETERAN CHAR(1) DEFAULT NULL,
  WANTCHIPS CHAR(1) DEFAULT NULL,
  WORK_STATUS VARCHAR(12) DEFAULT NULL,
  REMOTE_ADD VARCHAR(20) DEFAULT NULL,
  USER_AGENT VARCHAR(100) DEFAULT NULL,
  CSO_ID DECIMAL(5,0) DEFAULT NULL,
  SAT_OFF_ID DECIMAL(6,0) DEFAULT NULL,
  START_TIME DATETIME DEFAULT NULL,
  END_TIME DATETIME DEFAULT NULL,
  RACE VARCHAR(50) DEFAULT NULL,
  LEARN VARCHAR(50) DEFAULT NULL,
  CITY VARCHAR(50) DEFAULT NULL,
  OTHERCITY VARCHAR(50) DEFAULT NULL,
  POVERTYINDEX FLOAT(9,3) DEFAULT NULL,
  partner_id INTEGER(11) DEFAULT NULL,
  HISPANIC VARCHAR(32) DEFAULT NULL,
  OTHER_RACE VARCHAR(32) DEFAULT NULL,
  OTHER_LEARN VARCHAR(32) DEFAULT NULL,
  OTHER_HISPANIC VARCHAR(32) DEFAULT NULL,
KEY IX_tbl_user_ans (CSO_ID, RecID)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tbl_user_info">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_user_info (
  clientNum DECIMAL(18,0) NOT NULL,
  user_name VARCHAR(100) NOT NULL,
  date_added DATETIME DEFAULT NULL,
  client_id INTEGER(11) DEFAULT NULL,
  user_id INTEGER(11) DEFAULT NULL,
KEY IX_tbl_user_info (client_id, user_id, clientNum)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tbl_user_prgid">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_user_prgid (
  prg_id VARCHAR(50) NOT NULL,
  clientnum DECIMAL(18,0) NOT NULL,
  DateCreated DATETIME DEFAULT NULL,
  unseen TINYINT(4) UNSIGNED DEFAULT NULL,
KEY indexes (prg_id, clientnum, unseen),
KEY tbl_user_prgid4 (clientnum)
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tbl_user_subset">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_user_subset (
  clientnum DECIMAL(18,0) NOT NULL,
  subset_id INTEGER(11) NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tbl_user_ta">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_user_ta (
  clientnum DECIMAL(10,0) DEFAULT NULL,
  ConfirmationNumber VARCHAR(25) DEFAULT NULL,
  SubmitDate VARCHAR(50) DEFAULT NULL,
  FirstName VARCHAR(50) DEFAULT NULL,
  LastName VARCHAR(50) DEFAULT NULL,
  DOB VARCHAR(50) DEFAULT NULL,
  Zip VARCHAR(9) DEFAULT NULL,
  SponsorID VARCHAR(25) DEFAULT NULL,
  SourceID VARCHAR(25) DEFAULT NULL,
  ReferringID VARCHAR(25) DEFAULT NULL,
  TransID VARCHAR(25) DEFAULT NULL,
  TA_ID INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  CreateDate DATETIME DEFAULT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="tbl_user_trans">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE tbl_user_trans (
  trans_id INTEGER(11) NOT NULL AUTO_INCREMENT primary key,
  DNumber CHAR(5) DEFAULT NULL,
  CreateDate DATETIME DEFAULT NULL,
  clientnum DECIMAL(18,0) DEFAULT NULL
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


<cfcase value="user_usertype">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE user_usertype (
  user_id INTEGER(11) NOT NULL,
  usertype_id INTEGER(11) NOT NULL
		)ENGINE=MyISAM
		CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';
		</cfquery>
	</cfcase>


<cfcase value="usertype">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE usertype (
  usertype_id INTEGER(11) NOT NULL AUTO_INCREMENT,
  usertype_code VARCHAR(16) NOT NULL,
  usertype_name VARCHAR(64) NOT NULL,
  usertype_desc VARCHAR(255) DEFAULT NULL,
		PRIMARY KEY (usertype_id)
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


<cfcase value="`entrypoint_temp`">
	<cfquery name="createtable" datasource="#attributes.source#">
		CREATE TABLE `entrypoint_temp` (
  `entrypoint_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `subname` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state_id` char(2) DEFAULT NULL,
  `zipcode` char(5) DEFAULT NULL,
  `zipcode_plus4` char(4) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `hours_display_id` int(11) DEFAULT NULL,
  `info_display_id` int(11) DEFAULT NULL,
  `contact_title` varchar(64) DEFAULT NULL,
  `contact_first` varchar(64) DEFAULT NULL,
  `contact_middle` varchar(64) DEFAULT NULL,
  `contact_last` varchar(64) DEFAULT NULL,
  `contact_suffix` varchar(64) DEFAULT NULL,
  `privatephone` varchar(255) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `active_flag` int(11) NOT NULL,
  `notes` longtext,
  `create_user_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_user_id` int(11) NOT NULL,
  `modify_date` datetime NOT NULL,
  		PRIMARY KEY (`entrypoint_id`)
) ENGINE=MyISAM AUTO_INCREMENT=54633 DEFAULT CHARSET=latin1;
		</cfquery>
	</cfcase>
</cfswitch>