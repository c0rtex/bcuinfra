<cfcomponent>
	<cfscript>
		this.customtagpaths = "/opt/bcu/apps/bcu_code/dc.benefitscheckup.org/customtags";
		this.name = "DataCollector";
		this.clientmanagement = "Yes";
                this.sessionmanagement = "Yes";
                this.sessiontimeout = CreateTimeSpan(0,1,0,0);
                this.applicationtimeout = CreateTimeSpan(1,0,0,0);
	</cfscript>
	<cffunction  name="OnSessionStart"
        access="public"
        returntype="void"
        output="false"
        hint="Fires ONLY ONCE when session first created and not when session renewed/restarted.">

	<cfscript>
		application.dbSrc="BCU_QA";
		application.dbSrcQA="BCU_DEV";
		application.subsetsUseViews="true";
		application.serverPathBCU="data.benefitscheckup.org";
		application.rootPathBCU="/opt/bcu/apps/bcu_code/dc.benefitscheckup.org/code";
		application.rootSlash = "/";
		application.maintenanceFlag = "false";
		request.subsetsUseViews = application.subsetsUseViews;
	
		session.transfertype="https";
		session.serverpath="https://data.benefitscheckup.org";
		session.added_dt="now()";
		session.mod_dt="now()";
		session.user_id="0";
		session.user="";
		session.usertype="";
		session.user_level="";
		session.level="5";
		session.email="true";
		
		application.website_url = "https://redesign.benefitscheckup.org";
		website_url = "https://redesign.benefitscheckup.org";
		website_path = "/var/www/redesign/redesign.benefitscheckup.org/code";
		path_slash = "/";
		application.website_url = website_url;	
	</cfscript>
	</cffunction>
</cfcomponent>

