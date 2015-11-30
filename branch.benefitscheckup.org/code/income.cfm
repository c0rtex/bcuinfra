<script src="include/business_rules.js"></script>
<script language="JavaScript" src="include/DynamicOptionList.js"></script>
<script language="JavaScript">
// First example
var listIncomeEarned = new DynamicOptionList("s_income_earned","income_earned_General");
listIncomeEarned.addOptions("", "Select an Initial Range first", "0");
listIncomeEarned.addOptions("0", "0");
listIncomeEarned.addOptions("1", "Select a Detailed Range Between 1-999", "1", "1-99", "1", "100-199", "100", "200-299", "200", "300-399", "300", "400-499", "400", "500-599", "500", "600-699", "600", "700-799", "700", "800-899", "800", "900-999", "900");
listIncomeEarned.addOptions("1000", "Select a Detailed Range Between 1,000-1,999", "1000", "1,000-1,099", "1000", "1,100-1,199", "1100", "1,200-1,299", "1200", "1,300-1,399", "1300", "1,400-1,499", "1400", "1,500-1,599", "1500", "1,600-1,699", "1600", "1,700-1,799", "1700", "1,800-1,899", "1800", "1,900-1,999", "1900");
listIncomeEarned.addOptions("2000", "Select a Detailed Range Between 2,000-2,999", "2000", "2,000-2,099", "2000", "2,100-2,199", "2100", "2,200-2,299", "2200", "2,300-2,399", "2300", "2,400-2,499", "2400", "2,500-2,599", "2500", "2,600-2,699", "2600", "2,700-2,799", "2700", "2,800-2,899", "2800", "2,900-2,999", "2900");
listIncomeEarned.addOptions("3000", "Select a Detailed Range Between 3,000-3,999", "3000", "3,000-3,099", "3000", "3,100-3,199", "2100", "3,200-3,299", "3200", "3,300-3,399", "3300", "3,400-3,499", "3400", "3,500-3,599", "3500", "3,600-3,699", "3600", "3,700-3,799", "3700", "3,800-3,899", "3800", "3,900-3,999", "3900");
listIncomeEarned.addOptions("4000", "Select a Detailed Range Between 4,000-4,999", "4000", "4,000-4,099", "4000", "4,100-4,199", "4100", "4,200-4,299", "4200", "4,300-4,399", "4300", "4,400-2,499", "4400", "4,500-4,599", "4500", "4,600-4,699", "4600", "4,700-4,799", "4700", "4,800-4,899", "4800", "4,900-4,999", "4900");
listIncomeEarned.addOptions("5000", "5000+", "5000");
//Set Default Value
listIncomeEarned.setDefaultOption("5000","5000");
listIncomeEarned.setDefaultOption("0","0");

var listIncomeOtherNW = new DynamicOptionList("s_income_other_nw","income_other_nw_General");
listIncomeOtherNW.addOptions("", "Select an Initial Range first", "0");
listIncomeOtherNW.addOptions("0", "0");
listIncomeOtherNW.addOptions("1", "Select a Detailed Range Between 1-999", "1", "1-99", "1", "100-199", "100", "200-299", "200", "300-399", "300", "400-499", "400", "500-599", "500", "600-699", "600", "700-799", "700", "800-899", "800", "900-999", "900");
listIncomeOtherNW.addOptions("1000", "Select a Detailed Range Between 1,000-1,999", "1000", "1,000-1,099", "1000", "1,100-1,199", "1100", "1,200-1,299", "1200", "1,300-1,399", "1300", "1,400-1,499", "1400", "1,500-1,599", "1500", "1,600-1,699", "1600", "1,700-1,799", "1700", "1,800-1,899", "1800", "1,900-1,999", "1900");
listIncomeOtherNW.addOptions("2000", "Select a Detailed Range Between 2,000-2,999", "2000", "2,000-2,099", "2000", "2,100-2,199", "2100", "2,200-2,299", "2200", "2,300-2,399", "2300", "2,400-2,499", "2400", "2,500-2,599", "2500", "2,600-2,699", "2600", "2,700-2,799", "2700", "2,800-2,899", "2800", "2,900-2,999", "2900");
listIncomeOtherNW.addOptions("3000", "Select a Detailed Range Between 3,000-3,999", "3000", "3,000-3,099", "3000", "3,100-3,199", "2100", "3,200-3,299", "3200", "3,300-3,399", "3300", "3,400-3,499", "3400", "3,500-3,599", "3500", "3,600-3,699", "3600", "3,700-3,799", "3700", "3,800-3,899", "3800", "3,900-3,999", "3900");
listIncomeOtherNW.addOptions("4000", "Select a Detailed Range Between 4,000-4,999", "4000", "4,000-4,099", "4000", "4,100-4,199", "4100", "4,200-4,299", "4200", "4,300-4,399", "4300", "4,400-2,499", "4400", "4,500-4,599", "4500", "4,600-4,699", "4600", "4,700-4,799", "4700", "4,800-4,899", "4800", "4,900-4,999", "4900");
listIncomeOtherNW.addOptions("5000", "5000+", "5000");
//Set Default Value
listIncomeOtherNW.setDefaultOption("5000","5000");
listIncomeOtherNW.setDefaultOption("0","0");

function init() {
	var theform;
	if (document.formThird) {
		theform = document.formThird;
		listIncomeEarned.init(theform);
		listIncomeOtherNW.init(theform);
		if (document.formThird.income_earned_General) {
			if (document.formThird.income_earned_General.value != "") {
				document.formThird.income_earned_General.selectedIndex = parseInt(document.formThird.income_earned_General.value.split("|")[3], 10);
			}
		}
		if (document.formThird.income_other_nw_General) {
			if (document.formThird.income_other_nw_General.value != "") {
				document.formThird.income_other_nw_General.selectedIndex = parseInt(document.formThird.income_other_nw_General.value.split("|")[3], 10);
			}
		}
		if (document.formThird.s_asset_other_a) {
			if (document.formThird.s_asset_other_a.value != "") {
				document.formThird.s_asset_other_a.selectedIndex = parseInt(document.formThird.s_asset_other_a.value.split("|")[3], 10);
			}
		}

		if (document.formThird.income_earned_General) {
			if (document.formThird.income_earned_General.selectedIndex != 0) {
				showIncomeEarned();
				listIncomeEarned.populate();
				if (document.formThird.s_income_earned) {
					if (document.formThird.s_income_earned.value != "") {
						document.formThird.s_income_earned.selectedIndex = parseInt(document.formThird.s_income_earned.value.split("|")[3], 10);
					}
				}
			}
		}
		if (document.formThird.income_other_nw_General) {
			if (document.formThird.income_other_nw_General.selectedIndex != 0) {
				showIncomeOtherNW();
				listIncomeOtherNW.populate();
				if (document.formThird.s_income_other_nw) {
					if (document.formThird.s_income_other_nw.value != "") {
						document.formThird.s_income_other_nw.selectedIndex = parseInt(document.formThird.s_income_other_nw.value.split("|")[3], 10);
					}
				}
			}
		}
		
		
	}
}

function showIncomeEarned() {

	var objEl = document.getElementById("sections_income_earned")
	if (document.formThird.income_earned_General) {
		if ((document.formThird.income_earned_General.selectedIndex == 0) || (document.formThird.income_earned_General.selectedIndex == 1) ||
			(document.formThird.income_earned_General.selectedIndex == 7)) {
			objEl.style.display = "none";
		}
		else {
			objEl.style.display ="";
			document.formThird.s_income_earned.selectedIndex = 0;
		}
	}
}

function showIncomeOtherNW() {

	var objEl = document.getElementById("sections_income_other_nw")
	if (document.formThird.income_other_nw_General) {
		if ((document.formThird.income_other_nw_General.selectedIndex == 0) || (document.formThird.income_other_nw_General.selectedIndex == 1) ||
			(document.formThird.income_other_nw_General.selectedIndex == 7)) {
			objEl.style.display = "none";
		}
		else {
			objEl.style.display ="";
			document.formThird.s_income_other_nw.selectedIndex = 0;
		}
	}
}
</script>
