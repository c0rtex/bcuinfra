<cfparam name="application.dbSrc" default="BCU_QA">
<cfparam name="application.dbSrcQA" default="BCU_DEV">
<cfparam name="application.subsetsUseViews" default="true">
<cfparam name="application.serverPathBCU" default="data.benefitscheckup.org">
<cfparam name="application.rootPathBCU" default="/opt/bcu/apps/bcu_code/dc.benefitscheckup.org/code">
<cfparam name="application.rootSlash" default="/">
<cfset application.maintenanceFlag = false>

<cfset request.subsetsUseViews = application.subsetsUseViews>

<CFPARAM NAME="session.transfertype" DEFAULT="https">
<CFPARAM NAME="session.serverpath" DEFAULT="#session.transfertype#://data.benefitscheckup.org">
<CFPARAM NAME="session.added_dt" DEFAULT="now()">
<CFPARAM NAME="session.mod_dt" DEFAULT="now()">
<CFPARAM NAME="session.user_id" DEFAULT="0">
<CFPARAM NAME="session.user" DEFAULT="">
<CFPARAM NAME="session.usertype" DEFAULT="">
<CFPARAM NAME="session.user_level" DEFAULT="">
<CFPARAM NAME="session.level" DEFAULT="5">
<cfparam name="session.email" default="true">

<cfset website_url = "http://redesign.benefitscheckup.org">
<cfset website_path = "/var/www/redesign/redesign.benefitscheckup.org/code">
<cfset path_slash = "/">



