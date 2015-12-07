<!--- Remember to escape double quotes with "" and # with ## --->
<cfset mytext = "<p><strong><em>Online resource expands growing list of food assistance programs</em></strong></p><p><b>Media Contact</b>:<br> Ken Schwartz (ken.schwartz@ncoa.org) Tel: 202-600-3131<br>Connie Hofmann (chofmann@aboutscp.com) Tel:  610-687-5495</p><p><b>Washington, DC - June 30, 2010</b> - BenefitsCheckUp today announced the addition of three federally-funded food assistance programs for seniors with low or limited income to its growing list of online benefits resources.  The additional programs include the Commodity Supplemental Food Program, the Emergency Food Assistance Program, and the Senior Farmers' Market Nutrition Program.  These three programs will be combined with SNAP, the Supplemental Nutrition Assistance Program (formerly the Food Stamp program) that is currently provided on BenefitsCheckUp, to create a more comprehensive listing of food benefits.  Seniors can access the free online database of more than 2,000 benefits programs at www.benefitscheckup.org.</p> <p>This expanded offering of food assistance programs is important to seniors who struggle to meet their basic needs.  According to a <a href=""http://www.ers.usda.gov/Briefing/FoodSecurity/stats_graphs.htm##food_secure"">2008 report</a> from the United States Department of Agriculture (USDA), approximately 17 percent of U.S. households with an elderly member were categorized as food insecure.  This means these households were uncertain of having, or unable to acquire, enough food to meet the needs of all their members due to insufficient money or other resources for food.</p><p>""Ensuring seniors have access to needed food assistance is an important part of our mission,"" said Stuart Spector, senior vice president at NCOA. ""BenefitsCheckUp is a valuable tool that helps vulnerable older adults improve their health and well-being by providing access to an array of nutrition programs in a comprehensive, easy-to-use format.""</p><p>Seniors and their caregivers can use BenefitsCheckUp to conduct a self-screening survey to learn if they are eligible for benefits, find details about the programs and where they are available, and get instructions on how to apply.  The additional food assistance programs are integrated into the comprehensive screening process, making the benefits more widely available, and the online experience more user-friendly for visitors.</p>
<p>The following federal food assistance programs, offered by the USDA, are now featured on BenefitsCheckUp: <p>
<p><strong>Commodity Supplemental Food Program</strong> helps to improve the health of eligible individuals by supplementing their diets with nutritious foods.  Participants receive a monthly food package that includes canned fruits and vegetables, canned meats, pasta or rice, dry beans or peanut butter, fruit juices, dry cereals, cheese, and powdered and canned milk.<p>
<p><strong>The Emergency Food Assistance Program</strong> provides emergency food and nutrition assistance at no cost.  The program is offered at local food pantries and soup kitchens.<p>
<p><strong>Senior Farmers' Market Nutrition Program</strong> provides low-income seniors with coupons that can be exchanged for select foods at farmers' markets, roadside stands, and community-supported agriculture programs. <p>
<p>BenefitsCheckUp is a free online service maintained by the National Council on Aging (NCOA) that houses more than 2,000 federal, state, and local benefits programs for seniors to find help with the cost of health care, prescription drugs, food, housing, utility bills, and more.  Enrollment forms for most programs are provided as part of BenefitsCheckUp's interactive screening process.  Since 2001, more than 2.5 million people have used the service, identifying benefits valued at more than $8.5 billion.<p><p align=""center"">**********</p><p><b>About NCOA</b><BR>
The National Council on Aging is a nonprofit service and advocacy organization headquartered in Washington, DC. NCOA is a national voice for older Americans - especially those who are vulnerable and disadvantaged - and the community organizations that serve them. It brings together nonprofit organizations, businesses, and government to develop creative solutions that improve the lives of all older adults. NCOA works with thousands of organizations across the country to help seniors find jobs and benefits, improve their health, live independently and remain active in their communities. For more information, please visit <a href=""http://www.ncoa.org"" onclick=""window.open(this.href, '_blank', 'toolbar=no,location=no,directories=no,resizable=yes,scrollbars=yes,width=700,height=500'); return false;"">www.ncoa.org</a>.</p><p align=""center"">## ## ##</p>">

<!---cfquery name="insertNews" datasource="#application.dbSrc#">

INSERT INTO [BCU].[dbo].[bcu_news]
           ([date_added]
           ,[archived]
           ,[news]
           ,[title]
           ,[date_updated]
           ,[active])
     VALUES
           (now()
           ,0
           ,'#mytext#'
           ,'BenefitsCheckUp "Beefs Up" Food Security for Seniors'
           ,now()
           ,1)

</cfquery--->

<cfquery name="updateNews" datasource="#application.dbSrc#">

	Update bcu_news
	Set news = '#mytext#'
	where news_id = 59
</cfquery >

