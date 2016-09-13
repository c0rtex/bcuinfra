<!--
You are free to copy and use this sample in accordance with the terms of the
Apache license (http://www.apache.org/licenses/LICENSE-2.0.html)
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>
      Google Visualization API Sample
    </title>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['corechart']});
    </script>
    <!---script type="text/javascript" 
src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1','packages':['corechart'],'language':'ru'}]}">
</script--->
    <script type="text/javascript">
		function getUrlVars() {
			var vars = {};
			var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
				vars[key] = value;
			});
			return vars;
		}
		
		<cfoutput>
        	var #toScript(chartIncome, "Income")#;
			var #toScript(chartBenefits, "Benefits")#;
			var #toScript(chartIncomeAndBenefits, "IncomeAndBenefits")#;
			var #toScript(chartExpenses, "Expenses")#;
			var #toScript(chartXXXX, "Basic")#;
    	</cfoutput>
		//var Income = getUrlVars()["chartIncome"];
		//var Benefits = getUrlVars()["chartBenefits"];
		//var IncomeAndBenefits = getUrlVars()["chartIncomeAndBenefits"];
		//var Expenses = getUrlVars()["chartExpenses"];
		//var Basic = getUrlVars()["chartXXXX"];
		
      function drawVisualization() {
        // Create and populate the data table.
        var data = google.visualization.arrayToDataTable([
          ['Month', 'Amount needed to cover basic necessities *', 'Income', 'Benefits', 'Expenses'],
          ['Basic Needs ($' + parseInt(Basic) + ')', parseInt(Basic), 0, 0, 0],
          ['Income & Benefits ($' + parseInt(IncomeAndBenefits) + ')', 0, parseInt(Income), parseInt(Benefits), 0],
          ['Expenses ($' + parseInt(Expenses) + ')', 0, 0, 0, parseInt(Expenses)]
        ]);
      
        // Create and draw the visualization.
        var ac = new google.visualization.ComboChart(document.getElementById('visualization'));
        ac.draw(data, {
          isStacked: true,
		  enableInteractivity: false,
		  legend: {position: 'bottom'},
		  chartArea: {width: 550},
          backgroundColor: {stroke: '#CDCBCB', strokeWidth: 2, fill: '#F6F6F6'},
          title : 'Monthly Income, Benefits, and Expenses',
		  titleTextStyle: {fontSize: 24},
          width: 650,
          height: 400,
          vAxis: {gridlines: {count: 6}, minValue: 0, baseline: 0, format: '$#,###'},
          seriesType: 'bars',
          colors:['#AEBC37', '#00468B', '#CCDAE8', '#F47735']
        });
      }

      google.setOnLoadCallback(drawVisualization);
    </script>
  </head>
  <body style="font-family: Arial; border: 0 none;">
  	<div id="visualization" style="width: 650px; font-family: Arial;"></div>
    <div>
    	<BR />
    	<table border=4 bordercolor="#CCCCCC" bgcolor="#fdb813" cellpadding=0 cellspacing=0>
			<tr>
            	<td align="center" width="640" style="font-size: 20px; color: #FFFFFF; font-weight:bold; font-family:'Arial';">
                	<cfoutput>
					<cfif chartIncomeAndBenefits EQ chartExpenses>Your monthly income and benefits equals your expenses.
                    <cfelseif chartIncomeAndBenefits LT chartExpenses>
                    	<cfset shortfall = #chartExpenses# - #chartIncomeAndBenefits#>
                    	Your monthly income and benefits to expenses shortfall is $#shortfall#
                    <cfelse>
                    	<cfset surplus = #chartIncomeAndBenefits# - #chartExpenses#>
                        Your monthly income and benefits to expenses surplus is $#surplus#
                    </cfif>
                    </cfoutput>
                    </font>
               	</td>
           	</tr>
		</table>
        <table border=0 cellpadding=0 cellspacing=0>
			<tr>
            	<td width="640">
                	<p style="font-size:12px;">
						<!--- If the elder index was used (num people income supports = 1 or 2--->
                        <cfif session.esi_incomesupport EQ 1 or session.esi_incomesupport EQ 2>
                            * Basic necessities include housing, health care, transportation, food, and long-term care. This amount was calculated using the Elder Index for your county. You can find more on the Elder Index methodology designed by Wider Opportunities for Women and the Gerontology Institute at the University of Massachusetts Boston here: <a href="http://www.basiceconomicsecurity.org" target="_blank">www.basiceconomicsecurity.org</a>.  
                        <!--- If 200% of FPL was used (num people income supports GT 2 --->
                        <cfelse>
                            * Basic necessities include housing, health care, transportation, food, and long-term care.
                        </cfif>
                    </p>
                </td>
            </tr>
		</table>
    </div>
    <!---div>
    	<BR />
    	<table cellspacing="0" cellpadding="0" bordercolor="#CCCCCC" border="4" bgcolor="#00468b">
        	<!--- For later use: If 1 or 2 people in household XXXX value is #esiMonthlyIncomeByLocation# --->
            <!--- If 3 or more people in household XXXX value is (#getPoverty.povLevel# * 2 --->
			<tr><td align="center" width="590"><font size="+2" color="white" family="Arial" weight="bold">$<cfoutput>#url.chartXXXX#</cfoutput><BR />to Acheive Economic Security</font></td></tr>
		</tbody></table>
	</div--->
  </body>
</html>
