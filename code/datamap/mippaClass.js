// JavaScript Document
/*
$(xml).find('item').each(function(){
        var item_text = $(this).text();

        $('<li></li>')
            .html(item_text)
            .appendTo('ol');
    });
*/

var mippaTool = function(){
	MSTATE = "";
	MDATA = "";
	MZIP = "";
	MPROGRAM = "";
	PROGRAM_LIST = "1931,1932,1933"; // List of programs to be used for mippa tool. This is currently not in the DB
	PROG_DROP = jQuery('select#programSel');
	DATA_DROP = jQuery('select#dataSel');
	LONGDESC = false;
	ROWORDER = "DESC";
	STATEORDER = "ASC";
	newCounties = "";
	FIRSTCLICK = true;
	THAT = this; // Inheritence fix
	return this;
}

mippaTool.prototype = {
	init : function(){
		this.populateProgramsSel(PROGRAM_LIST);
		// MH Bug 5302 Comment 3
		DATA_LIST1 = ""; //MH 5-21-10 Bug 5302 - Set Data list to blank to enable 'Select Program First' option display
		this.populateDataSel(DATA_LIST1);
		//MH END
		jQuery('#zipForm').submit(function(){
			THAT.captureZipForm(this);	
			return false;
		});
		jQuery(DATA_DROP).change(function(){
			THAT.processData(this);
		});
		this.setCFVars();
		$('#dataUses1').css("display","none");
		$('#dataUses2').css("display","none");
	},
	
	printLongDesc : function(){
		
	},
	clearPage : function(){
		MPROGRAM = "";
		MZIP = "";
		MSTATE = "";
		jQuery(DATA_DROP).html("");
		jQuery(PROG_DROP).html("");
		jQuery("#zipCode").val("");
		this.populateProgramsSel(PROGRAM_LIST);
		this.setCFVars();
		// MH Bug 5302 Comment 3
		DATA_LIST2 = ""; //MH 5-21-10 Bug 5302 - Set Data list to blank to enable 'Select Program First' option display
		this.populateDataSel(DATA_LIST2);
		jQuery("#entryPoints").html("Looking for help for you or your clients? This section provides the location and contact information for an agency that can provide more information about the program that you have chosen. In addition, you can search for other organizations near you by using the Zip Code search box.");
		jQuery('#progName').html("this Project");
		jQuery('#aboutText').html("WELCOME to our data map where you will find information to support your organization's benefits outreach and enrollment activities. Through this map you will find data about Medicare Part D, the Low-Income Subsidy and the Medicare Savings Programs.");
		jQuery("#jQueryUITabs1 > ul").tabs('select', 0).tabs("disable",  1).tabs("disable",  2).tabs("disable",  3);
		jQuery("#entryPointsState").html("").css({"display":"","padding":0,"border-top":"none"});
		jQuery('#dataInfo').css("display","none");
		//jQuery("#jQueryUITabs1 > ul a.clickTrack").unbind("click");
		LONGDESC = false;
		$('#jQueryUITabs1-0').css("height","400px");
		$('#homeHolder').css("display","");
		$('#homeLongDesc').css("display","none");
		// PRINT CLASSES REMOVED
		$('.progDataForm, #leftCol,.tabTitle,#jQueryUITabs1 ul,#jQueryUITabs1-1,#jQueryUITabs1-2,#jQueryUITabs1-3,#dataInfo,#rightCol,#header,#dataInfo').removeClass("noprintLong");
		$('#whatsNew1').css("display","");
		$('#whatsNew2').css("display","");
		$('#dataUses1').css("display","none");
		$('#dataUses2').css("display","none");
		jQuery('#xtraHelp').css('display','none');
	},
	setCFVars : function(){
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=setvars",
			datatype:'json',
			data: "program_id="+MPROGRAM+"&zipcode="+MZIP+"&state="+MSTATE,
			cache:false,
			success: function(progInfo){
			}
		});
	},
	backToStates : function(){
		MZIP = "";
		MSTATE = "";
		jQuery(".stateTotals").css("display","");
		this.setCFVars();
		this.populateTrends();
		var elVal = jQuery("#dataSel").val();
		this.getRankingInfo(elVal);
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=getStateTotals",
			data: {"data":MDATA}, 
			datatype:"json",
			cache:false,
			success: function(stateVals){
				var newVals = eval("("+stateVals+")");
				jQuery('#stateTotals .stateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],false));
				jQuery('.stateTotals .strippedStateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],true));
				jQuery('.stateTotals .ranTotalName').html("UNITED STATES");
				jQuery('#stateTotals .stateYear, .stateTotals .stateYear').html(newVals.DATA[0][1]);
			}
		});
		//console.log(MSTATE);
		//jQuery("#entryPointsState").html("To find your State Health Insurance Program office, please enter a zip below.");
	},
	processState : function (stateId){
		//console.log(stateId);
		var elVal = jQuery("#dataSel").val();
		MSTATE = stateId;
		jQuery(".stateTotals").css("display","none");
		this.setCFVars();
		this.populateTrends();
		this.getRankingInfo(elVal);
		jQuery('#rankStateTotals').show("slow");
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=getCountyTotals",
			data: {"data":MDATA,"state":MSTATE}, 
			datatype:"json",
			cache:false,
			success: function(stateVals){
				var newVals = eval("("+stateVals+")");
				jQuery('#stateTotals .stateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],false));
				jQuery('.stateTotals .strippedStateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],true));
				jQuery('.stateTotals .ranTotalName').html(newVals.DATA[0][3].toUpperCase());
				jQuery('#stateTotals .stateYear, .stateTotals .stateYear').html(newVals.DATA[0][1]);
			}
		});
	},
	captureZipForm : function(el){
		var elVal = jQuery("#zipCode").val()
		MZIP = elVal;
		if(MPROGRAM == 1933){
			var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(MZIP);
			if(!isValidZip){alert("Please enter a zip code.");return false};
			$.ajax({
				url: "/cf/com/bcu/mippaHandler.cfc?method=processZip",
				datatype:'json',
				data: "zipcode="+MZIP, 
				cache:false,
				success: function(mCode){
					var newcode = eval("("+mCode+")");
					if(!newcode || mCode == "false"){
						alert("Please enter a valid zip code.");
						return false;
					};
					THAT.setCFVars();
					THAT.getEntryPoints(MPROGRAM);
					THAT.getShipEntryPoints(MZIP);
					jQuery('.stateTotals').css("display","none");
				}
			});
		}else{
			if(MPROGRAM == ""){alert("You must first select a Program."); return false};
			var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(MZIP);
			if(!isValidZip){alert("Please enter a zip code.");return false};
			
			$.ajax({
				url: "/cf/com/bcu/mippaHandler.cfc?method=processZip",
				datatype:'json',
				data: "zipcode="+MZIP, 
				cache:false,
				success: function(mCode){
					var newcode = eval("("+mCode+")");
					if(!newcode || mCode == "false"){
						alert("Please enter a valid zip code.");
						return false;
					};
					THAT.setCFVars();
					THAT.getShipEntryPoints(MZIP);
					THAT.getEntryPoints();
					jQuery('#stateTotals').css("display","none");
				}
			});
			
		};
		
	},
	populateProgramsSel : function(){ // populates programSel drop down on page load
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=getPrograms",
			datatype:'json',
			data: "program_id_list="+PROGRAM_LIST, 
			cache:false,
			success: function(programs){
				var newPrograms = eval("("+programs+")");
				THAT.populateDropdown(PROG_DROP,newPrograms);
			}
		});
		jQuery(PROG_DROP).change(function(){
			THAT.processProgram(this);
		});
	},
	getShipEntryPoints : function(zipVal){ // populates the ship entry points once a zip is entered and validated.
		if(typeof(zipVal) != "undefined" && zipVal != ""){
			jQuery("#entryPointsState").html('<div style="background:url(/cf/img/ajaxload.gif) center no-repeat;height:40px; width:40px;"></div>');
			jQuery.ajax({
				url: "shipEntryPoints.cfm",
				data: "zipcode="+zipVal, 
				datatype:"html",
				cache:false,
				success: function(html){
					myhtml = html;
					jQuery("#entryPointsState").html(myhtml).css({"display":"block","padding":"4px 0 8px 0","border-top":"1px solid black"});
				}
			});
		}else{
			if(MPROGRAM != 1933){
				jQuery("#entryPointsState").html("To find your State Health Insurance Program office, please enter a zip below.");
			}else if(MPROGRAM == 1933){
				jQuery("#entryPointsState").html("");
			}
		}
		// To find your State Health Insurance Program office, please enter a zip below.
	},
	getEntryPoints : function(el){
		var elVal = jQuery('#programSel').val();
		
		if(elVal != ""){
			jQuery("#entryPoints").html('<div style="background:url(/cf/img/ajaxload.gif) center no-repeat;height:40px; width:40px;"></div>');
			jQuery.ajax({
				url: "mippaEntryPoints2.cfm",
				data: "program_id="+elVal, 
				datatype:"html",
				cache:false,
				success: function(html){
					myhtml = html;
					jQuery("#entryPoints").html(myhtml).css({"display":"block","padding":"0 0 8px 0"});
				}
			});
		}else{
			jQuery("#entryPoints").html("This section provides the location and contact information for an agency that can provide more information about the benefit that you have chosen. In addition, you can search for other organizations near you by using the Zip Code search box.");
		}
	},
	populateDataSel : function(data_list){
		if (data_list == ""){
			jQuery("#dataSel").html("");
			jQuery("#dataSel").append('<option value="">- Select Program First -</option>');
		}
		else{
			$.ajax({
				url: "/cf/com/bcu/mippaHandler.cfc?method=getdataSets",
				datatype:'json',
				data: "data_id_list="+data_list, 
				cache:false,
				success: function(dataSets){
					var newDataSets = eval("("+dataSets+")");
					THAT.populateDropdown(DATA_DROP,newDataSets);
				}
			});
		}
	},
	processProgram : function(el){
		var elVal = jQuery(el).val();
		MPROGRAM = elVal;
		if(MZIP == ""){
			var zipVal = jQuery("#zipCode").val()
			MZIP = zipVal;
		}
		if(MPROGRAM == 1932){
			var optList = "8,13,14,15,18,19,21,46,50,51,52,54,55,56";
			jQuery('#xtraHelp').show('fast');
		}else if(MPROGRAM == 1933){
			var optList = "16,47";
			jQuery('#xtraHelp').css('display','none');
		}else if(MPROGRAM == 1931){
			var optList = "7,9,10,11,12,17,20,45,48,49,53";
			jQuery('#xtraHelp').css('display','none');
		}else if(MPROGRAM == ""){
			jQuery('#xtraHelp').css('display','none');
			var optList = "";
			MPROGRAM = "";
		};
		if(MPROGRAM != ""){
			this.setCFVars();
			this.populateDataSel(optList);
			this.getEntryPoints(MPROGRAM);
			this.getShipEntryPoints(MZIP);
			this.setProgramText(MPROGRAM);
			//this.setTrendsGraph(MPROGRAM,MDATA,MSTATE);
			
		}else{
			MSTATE = "";
			jQuery(DATA_DROP).html("");
			jQuery(DATA_DROP).append('<option value="">- Select Program First -</option>');
			jQuery("#entryPoints").html("Looking for help for you or your clients? This section provides the location and contact information for an agency that can provide more information about the program that you have chosen. In addition, you can search for other organizations near you by using the Zip Code search box.");
			jQuery('#progName').html("this Project");
			jQuery('#aboutText').html("WELCOME to our data map where you will find information to support your organization's benefits outreach and enrollment activities. Through this map you will find data about Medicare Part D, the Low-Income Subsidy and the Medicare Savings Programs.");
			jQuery("#jQueryUITabs1 > ul").tabs('select', 0).tabs("disable",  1).tabs("disable",  2).tabs("disable",  3);
			jQuery("#entryPointsState").html("").css({"display":"","padding":0,"border-top":"none"});
			jQuery('#dataInfo').css("display","none");
			//jQuery("#jQueryUITabs1 > ul a.clickTrack").unbind("click");
			jQuery('#whatsNew1').css("display","");
			jQuery('#whatsNew2').css("display","");
			jQuery('#dataUses1').css("display","none");
			jQuery('#dataUses2').css("display","none");
		};
		if(LONGDESC){
			this.showDesc();
		};
	},
	processTabClick : function(el){
		LONGDESC = false;
		$('#jQueryUITabs1-0').css("height","400px");
		$('#homeHolder').css("display","");
		$('#homeLongDesc').css("display","none");
		myHref = $(el).attr("href");
		//selectedTab = $("#jQueryUITabs1").tabs().data("selected.tabs");
		//console.log($("#jQueryUITabs1 ul").index);
		if(myHref === "#jQueryUITabs1-1"){
			if(MSTATE != "" && !FIRSTCLICK){	
				$.ajax({
					url: "/cf/com/bcu/mippaHandler.cfc?method=getStateMapcode",
					data: {"state":MSTATE}, 
					datatype:"json",
					cache:false,
					success: function(newText){
						var newcode = eval("("+newText+")");
						//THAT.loadFlash(newcode.DATA[0][0]);
						//return code = newcode.DATA[0][0];
						jQuery('.stateTotals').css("display","none");
						THAT.loadFlash(newcode.DATA[0][0]);
					}
				});
			}else{
				this.loadFlash(0)
			}
			FIRSTCLICK = false;	
		}
		if(MDATA != ''){
			$('#whatsNew1').css("display","none");
			$('#whatsNew2').css("display","none");
			$('#dataUses1').css("display","");
			$('#dataUses2').css("display","");
		};
		// PRINT CLASSES REMOVED
		$('.progDataForm, #leftCol,.tabTitle,#jQueryUITabs1 ul,#jQueryUITabs1-1,#jQueryUITabs1-2,#jQueryUITabs1-3,#dataInfo,#rightCol,#header,#dataInfo').removeClass("noprintLong");
		/*MH 5/21/10 Bug 5155 Shows Notes When Tab is clicked*/
		jQuery('#dataInfo').css('display','');
		/*MH End*/
	},
	showDesc : function(){
		var tempProgId = "";
		if(MPROGRAM == 1931){
			tempProgId = 1934;	
		}else if(MPROGRAM == 1932){
			tempProgId = 1935;	
		}else if(MPROGRAM == 1933){
			tempProgId = 1936;	
		};
		if(tempProgId != ''){
			LONGDESC = true;
			jQuery("#jQueryUITabs1 > ul").tabs('select', 0);
			$('#jQueryUITabs1-0').css("height","100%","padding-bottom", "20px","overflow", "auto");
			
			this.setLongText(tempProgId);
			
			//PRINT CLASSES ADDED.
			$('.progDataForm, #leftCol,.tabTitle,#jQueryUITabs1 ul,#jQueryUITabs1-1,#jQueryUITabs1-2,#jQueryUITabs1-3,#dataInfo,#rightCol,#header,#dataInfo').addClass("noprintLong");
		}else{
			LONGDESC = false;
			$('#jQueryUITabs1-0').css("height","100%");
			$('#homeHolder').css("display","");
			$('#homeLongDesc').css("display","none");
		};
		/*MH* 5/21/10 Bug 5155 Hide Notes when showing Program Description*/
		jQuery('#dataInfo').css('display','none');
		/*MH END*/
		jQuery('#whatsNew1').css("display","");
		jQuery('#whatsNew2').css("display","");
		jQuery('#dataUses1').css("display","none");
		jQuery('#dataUses2').css("display","none");
	},
	setLongText: function(progId){
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=getProgramInfo",
			datatype:'json',
			data: "program_id="+progId,
			cache:false,
			success: function(progInfo){
				newprogInfo = eval("("+progInfo+")");
				/*
				if (jQuery.browser.msie) {
					if(jQuery.browser.version = 8){
						$('#jQueryUITabs1-0, #homeLongDesc').css({"display":"block","height":"auto"});
					}else{
				  		$('#jQueryUITabs1-0, #homeLongDesc').css("height","auto");
					};
				}else{
					$('#jQueryUITabs1-0').css("height","auto");
				};
				*/
				
				$('#jQueryUITabs1-0').css("height","100%","min-height","400px","padding-bottom","30px","overflow","auto");
				$('#homeHolder').hide();
				$('#homeLongDesc').show();
				
				/*
				$('#homeHolder').hide("fast");
				$('#homeLongDesc').show('fast',function(){
					if(jQuery.browser.msie){
						this.style.removeAttribute('filter');
						jQuery(this).css("height","auto");
						$('#jQueryUITabs1-0').css({"height":"auto","poistion":"relative"});
					};
				});
				*/
				$('#longDescTitle h2').html(newprogInfo.DATA[0][0]);
				$('#longDescTxt').html(newprogInfo.DATA[0][1]);
			}
		});
	},
	setProgramText : function(val){
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=getProgramInfo",
			datatype:'json',
			data: "program_id="+val,
			cache:false,
			success: function(progInfo){
				newprogInfo = eval("("+progInfo+")");
				THAT.testFunct(newprogInfo.DATA[0][0],newprogInfo.DATA[0][1]);
			}
		});
	},
	testFunct : function(ugh,ugh1){
		jQuery('#progName').html("<br>"+ugh);
		jQuery('#aboutText').html(ugh1);
	},
	processData : function(el){
		var elVal = jQuery(el).val();
		MDATA = elVal;
		if(elVal == ""){
			MDATA = "";
			jQuery("#jQueryUITabs1 > ul").tabs('select', 0).tabs("disable",  1).tabs("disable",  2).tabs("disable",  3);
			jQuery('#dataInfo').css("display","none");
			jQuery('#whatsNew1').css("display","");
			jQuery('#whatsNew2').css("display","");
			jQuery('#dataUses1').css("display","none");
			jQuery('#dataUses2').css("display","none");
			//jQuery("#jQueryUITabs1 > ul a.clickTrack").unbind("click");
		}else{
			/*jQuery("#jQueryUITabs1 > ul a.clickTrack").click(function(){
				THAT.processTabClick();
				
			});*/
			jQuery("#jQueryUITabs1 > ul").tabs("enable",  1);
			jQuery("#jQueryUITabs1 > ul").tabs("enable",  2);
			jQuery("#jQueryUITabs1 > ul").tabs("enable",  3);
			
			
			jQuery('#whatsNew1').css('display','none');
			jQuery('#whatsNew2').css('display','none');
					
			$.ajax({
				url: "/cf/com/bcu/mippaHandler.cfc?method=getDataInfo",
				datatype:'json',
				data: "data_id="+elVal, 
				cache:false,
				success: function(dataInfo){
					var newDataInfo = eval("("+dataInfo+")");
					jQuery('.dataA').html(newDataInfo.DATA[0][0])
					jQuery('#dataB').html('<span style="text-decoration:underline;font-weight:bold;">Sources:</span><br />'+newDataInfo.DATA[0][1])
					//jQuery('#dataC').html(newDataInfo.DATA[0][2])
					jQuery('#dataD').html('<span style="text-decoration:underline;font-weight:bold;">Acronyms:</span><br />'+newDataInfo.DATA[0][2]);
					jQuery('#dataInfo').css('display','');
				}
			});
			$.ajax({
				url: "/cf/com/bcu/mippaHandler.cfc?method=getDataUsesInfo",
				datatype:'json',
				data: "data_id="+elVal, 
				cache:false,
				success: function(dataUsesInfo){
					var newDataUsesInfo = eval("("+dataUsesInfo+")");
					jQuery('#dataUses').html(newDataUsesInfo.DATA[0][0]);
					jQuery('#dataUses1').css("display","");
					jQuery('#dataUses2').css("display","");
				}
			});
			this.getRankingInfo(elVal);
		};
		jQuery('.dataElTitle').html(jQuery('#dataSel option:selected').html());
		
		
		if(MSTATE != ""){
			jQuery('.stateTotals').css("display","none");
			$.ajax({
				url: "/cf/com/bcu/mippaHandler.cfc?method=getStateMapcode",
				data: {"state":MSTATE}, 
				datatype:"json",
				cache:false,
				success: function(newText){
					var newcode = eval("("+newText+")");
					THAT.loadFlash(newcode.DATA[0][0]);
					
				}
			});
		}else{
			this.loadFlash(0);
		}
		this.populateTrends();
		//setVars(elVal);
	},
	populateTrends : function(){
		if(MDATA != ''){
			jQuery.ajax({
				url: "mippaGraphs.cfm",
				data: "data_id="+MDATA, 
				datatype:"html",
				cache:false,
				success: function(html){
					myhtml = html;
					jQuery("#trendsCont").html(myhtml).css({"display":"block","padding":"0 0 8px 0"});
				}
			});
		}
	},
	loadFlash : function(mapCode){
		jQuery('#flashmap3').remove("");
		tempEl = document.createElement("div");
		tempEl.id = "flashmap3";
		jQuery(tempEl).css("z-index",1);
		jQuery('#flashholder').prepend(jQuery(tempEl));
		if(typeof(mapcode) != 'undefined' || mapCode != ""){
			var code = mapCode;
		}else{
			var code = 0;
		};
		if(jQuery('#flashmap3').length){
			var randNum = Math.floor(Math.random()*11);
			var flashVars = {"xmlfile1":"us_city_map/states.cfm","show_map":code};
			var params = {"wmode":"transparent"}; 
            var attributes = {}; 
			swfobject.embedSWF("us_city_map/golden_usa_external.swf", "flashmap3", "550", "448", "9.0.0", false,flashVars,params,attributes);
			if(MSTATE == ""){
				jQuery('.stateTotals').show("slow");
			};
			jQuery('#rankStateTotals').show("slow");
			if(MSTATE != ""){
				$.ajax({
					url: "/cf/com/bcu/mippaHandler.cfc?method=getCountyTotals",
					data: {"data":MDATA,"state":MSTATE}, 
					datatype:"json",
					cache:false,
					success: function(stateVals){
						var newVals = eval("("+stateVals+")");
						jQuery('#stateTotals .stateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],false));
						jQuery('.stateTotals .strippedStateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],true));
						jQuery('.stateTotals .ranTotalName').html(newVals.DATA[0][3].toUpperCase());
						jQuery('#stateTotals .stateYear, .stateTotals .stateYear').html(newVals.DATA[0][1]);
					}
				});
			}else{
				$.ajax({
					url: "/cf/com/bcu/mippaHandler.cfc?method=getStateTotals",
					data: {"data":MDATA}, 
					datatype:"json",
					cache:false,
					success: function(stateVals){
						var newVals = eval("("+stateVals+")");
						jQuery('#stateTotals .stateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],false));
						jQuery('.stateTotals .strippedStateVal').html(THAT.convertMapTotals(newVals.DATA[0][0],newVals.DATA[0][2],true));
						jQuery('.stateTotals .ranTotalName').html("UNITED STATES");
						jQuery('#stateTotals .stateYear, .stateTotals .stateYear').html(newVals.DATA[0][1]);
					}
				});
			}
		};
		//var stateDataTemp = document.createElement("div");
		//stateDataTemp.id = "stateTotals";
		//jQuery('#flashholder').append(jQuery(stateDataTemp));
		//jQuery(stateDataTemp).html("<b>UNITED STATES<b><br>Year: <br> 'VALUE'<br>");
	},
	sortRankingsTable : function(col,dir){
		if(MDATA != ""){
			$.ajax({
					url: "/cf/com/bcu/mippaHandler.cfc?method=getRankingInfo",
					datatype:'json',
					data: {"data_id":MDATA,"sortCol":col,"rankOrder":dir,"mzip":MZIP,"mstate":MSTATE}, 
					cache:false,
					success: function(ranking){
						var newRankings = eval("("+ranking+")");
						THAT.buildRankingsTable(newRankings);
					}
				});
		};
	},
	getRankingInfo : function(elVal){
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=getRankingInfo",
			datatype:'json',
			data: "data_id="+elVal+"&mzip="+MZIP+"&mstate="+MSTATE, 
			cache:false,
			success: function(ranking){
				var newRankings = eval("("+ranking+")");
				//console.log("I am getting Rank" + newRankings.DATA);
				THAT.buildRankingsTable(newRankings);
			}
		});
	},
	toggleSortOrder : function(order){
		if(order == "DESC"){
			newOrder = "ASC";
		}else if(order == "ASC"){
			newOrder = "DESC";
		}
		return newOrder;
	},
	getCounties : function(stateId){
		$.ajax({
			url: "/cf/com/bcu/mippaHandler.cfc?method=getCountiesAsJSON",
			datatype:'json',
			data: "state="+MSTATE, 
			cache:false,
			success: function(counties){
				newCounties = eval("("+counties+")");
			}
		});
		
	},
	buildRankingsTable : function(miniJson){
		var amtText = "Number";
		jQuery('#rankingsCont').html("");
		if(miniJson.DATA == ""){
			jQuery('#rankingsCont').html("<h3>County Level Data is not available for this data set at this time.</h3>")	
			jQuery("#countyDisc").css("display","none");
		}else{
			if(MSTATE != ""){
				columnSort = 'county';
				columnName = 'County Name';
				jQuery("#countyDisc").css("display","");
			}else{
				columnSort = 'state_name';
				columnName = 'State Name';
				jQuery("#countyDisc").css("display","none");
			};
			
			//MAIN
			var rTable = document.createElement("table");
			rTable.cellPadding = 0;
			rTable.cellSpacing = 0;
			rTable.width = "100%";
			rTable.id = "rankingsTable";
			
			//First Row
			var rTableTr1 = document.createElement("tr");
			rTableTr1.width = "100%";
			jQuery(rTable).append(rTableTr1);
			
			//First data
			var rTableTd1 = document.createElement("td");
			rTableTd1.vAlign = "top";
			jQuery(rTableTr1).append(rTableTd1);
			
			//left table
			var rTableLeft = document.createElement("table");
			rTableLeft.cellPadding = 0;
			rTableLeft.cellSpacing = 0;
			rTableLeft.align = "left";
			rTable.id = "rankingsTableLeft";
			jQuery(rTableTd1).append(rTableLeft);
			
			// first row left table
			var rTableLeftTr1 = document.createElement("tr");
			rTableLeftTr1.className = "rankingsTableHeader";
			jQuery(rTableLeft).append(rTableLeftTr1);
			
			//firtst data left table
			var rTableLeftTd1 = document.createElement("td");
			rTableLeftTd1.width = "28";
			rTableLeftTr1.appendChild(rTableLeftTd1);
			
			var rTableRankDiv = document.createElement("div");
			rTableRankDiv.id = "rankLeft";
			rTableRankDiv.innerHTML = "Rank";
			rTableLeftTd1.appendChild(rTableRankDiv);
			
			
			jQuery(rTableRankDiv).click(function(){
				THAT.sortRankingsTable('Row',ROWORDER);
				ROWORDER = THAT.toggleSortOrder(ROWORDER);
				STATEORDER = "ASC";
			}).css("cursor","pointer");
			
			//second data left table
			var rTableLeftTd2 = document.createElement("td");
			rTableLeftTd2.width = "128";
			jQuery(rTableLeftTr1).append(rTableLeftTd2);
			
			var rTableStateLDiv = document.createElement("div");
			rTableStateLDiv.id = "stateLeft";
			rTableStateLDiv.innerHTML = columnName;
			rTableLeftTd2.appendChild(rTableStateLDiv);
			
			var arrowState = document.createElement("img");
			arrowState.className = "rankArrows";
			arrowState.src = "arrow.gif";
			arrowState.border = 0;
			rTableStateLDiv.appendChild(arrowState);
			
			jQuery(rTableStateLDiv).click(function(){
				THAT.sortRankingsTable(columnSort,STATEORDER);
				STATEORDER = THAT.toggleSortOrder(STATEORDER);
				ROWORDER = "ASC";
			}).css("cursor","pointer");
			
			//third data left table
			var rTableLeftTd3 = document.createElement("td");
			//rTableLeftTd3.id = "leftNum";
			//rTableLeftTd3.innerHTML = "Number";
			rTableLeftTd3.width = "78";
			jQuery(rTableLeftTr1).append(rTableLeftTd3);
			
			var rTableNumLDiv = document.createElement("div");
			rTableNumLDiv.id = "leftNum";
			rTableLeftTd3.appendChild(rTableNumLDiv);
			
			var arrowNum = document.createElement("img");
			arrowNum.className = "rankArrows";
			arrowNum.src = "arrow.gif";
			arrowNum.border = 0;
			rTableNumLDiv.appendChild(arrowNum);
			
			jQuery(rTableLeftTd3).click(function(){
				THAT.sortRankingsTable('Row',ROWORDER);
				ROWORDER = THAT.toggleSortOrder(ROWORDER);
				STATEORDER = "ASC";
			}).css("cursor","pointer");
	
			//second data
			var rTableTd2 = document.createElement("td");
			rTableTd2.vAlign = "top";
			jQuery(rTableTr1).append(rTableTd2);
			
			//right table
			var rTableRight = document.createElement("table");
			rTableRight.cellPadding = 0;
			rTableRight.cellSpacing = 0;
			rTableRight.align = "right";
			rTable.id = "rankingsTableRight";
			jQuery(rTableTd2).append(rTableRight);
			
			// first row right table
			var rTableRightTr1 = document.createElement("tr");
			rTableRightTr1.className = "rankingsTableHeader";
			jQuery(rTableRight).append(rTableRightTr1);
			
			//firtst data right table
			var rTableRightTd1 = document.createElement("td");
			rTableRightTd1.innerHTML = "Rank";
			rTableRightTd1.width = "28";
			rTableRightTr1.appendChild(rTableRightTd1);
			
			jQuery(rTableRightTd1).click(function(){
				
				THAT.sortRankingsTable('Row',ROWORDER);
				ROWORDER = THAT.toggleSortOrder(ROWORDER);
				STATEORDER = "ASC";
			}).css("cursor","pointer");
			
			//second data right table
			var rTableRightTd2 = document.createElement("td");
			//rTableRightTd2.innerHTML = "State Name";
			rTableRightTd2.width = "128";
			jQuery(rTableRightTr1).append(rTableRightTd2);
			
			var rTableStateRDiv = document.createElement("div");
			rTableStateRDiv.id = "stateRight";
			rTableStateRDiv.innerHTML = columnName;
			rTableRightTd2.appendChild(rTableStateRDiv);
			
			var arrowStateR = document.createElement("img");
			arrowStateR.className = "rankArrows";
			arrowStateR.src = "arrow.gif";
			arrowStateR.border = 0;
			rTableStateRDiv.appendChild(arrowStateR);
			
			jQuery(rTableRightTd2).click(function(){
				THAT.sortRankingsTable(columnSort,STATEORDER);
				STATEORDER = THAT.toggleSortOrder(STATEORDER);
				ROWORDER = "ASC";
			}).css("cursor","pointer");
			
			
			//third data right table
			var rTableRightTd3 = document.createElement("td");
			//rTableRightTd3.id = "rightNum";
			//rTableRightTd3.innerHTML = "Number";
			rTableRightTd3.width = "78";
			jQuery(rTableRightTr1).append(rTableRightTd3);
			
			var rTableNumRDiv = document.createElement("div");
			rTableNumRDiv.id = "rightNum";
			rTableRightTd3.appendChild(rTableNumRDiv);
			
			var arrowNumR = document.createElement("img");
			arrowNumR.className = "rankArrows";
			arrowNumR.src = "arrow.gif";
			arrowNumR.border = 0;
			rTableNumRDiv.appendChild(arrowNumR);
			
			jQuery(rTableRightTd3).click(function(){
				THAT.sortRankingsTable('Row',ROWORDER);
				ROWORDER = THAT.toggleSortOrder(ROWORDER);
				STATEORDER = "ASC";
			}).css("cursor","pointer");
			
			
		
			for(var i=0; i<miniJson.DATA.length;i++){
				var tempNum = miniJson.DATA[i][2];
				var counter = i + 1;
					tempNum += '';
					nX = tempNum.split(".");
					nX1 = nX[0];
					nX2 = nX[1];
					if(nX.length > 1 && nX1 == 0){
						var newNum = this.convertToPercent(tempNum);
						amtText = "Percent";
					}else if(nX.length > 1 && nX1 ==1){
						var newNum = "100%";
						amtText = "Percent";
					}else if( nX1 == 0 && nX2 == 0){
						var newNum = "No Data";
					}else {
						var newNum = this.addCommas(tempNum);
					}
				if(MSTATE != ""){
					myMod = (miniJson.DATA.length/2);	
				}else{
					myMod = 25;
				};
				if(i <= myMod){
					var rTableLeftTr = document.createElement("tr");
					rTableLeftTr.id = "row_"+miniJson.DATA[i][3];
					jQuery(rTableLeft).append(rTableLeftTr);
					
					var rTableLeftTd1 = document.createElement("td");
					jQuery(rTableLeftTd1).css({"font-size":"larger"});
					rTableLeftTd1.innerHTML = counter;
					jQuery(rTableLeftTr).append(rTableLeftTd1);
					
					var rTableLeftTd2 = document.createElement("td");
					jQuery(rTableLeftTd2).css({"text-align":"left","font-weight":"bold","font-size":"larger"});
					rTableLeftTd2.innerHTML = miniJson.DATA[i][0];
					jQuery(rTableLeftTr).append(rTableLeftTd2);
					
					var rTableLeftTd3 = document.createElement("td");
					rTableLeftTd3.innerHTML = newNum;
					jQuery(rTableLeftTr).append(rTableLeftTd3);
				}else{
					var rTableRightTr = document.createElement("tr");
					rTableRightTr.id = "row_"+miniJson.DATA[i][3];
					jQuery(rTableRight).append(rTableRightTr);
					
					var rTableRightTd1 = document.createElement("td");
					jQuery(rTableRightTd1).css({"font-size":"larger"});
					rTableRightTd1.innerHTML = counter;
					jQuery(rTableRightTr).append(rTableRightTd1);
					
					var rTableRightTd2 = document.createElement("td");
					jQuery(rTableRightTd2).css({"text-align":"left","font-weight":"bold","font-size":"larger","display":"block"});
					rTableRightTd2.innerHTML = miniJson.DATA[i][0];
					jQuery(rTableRightTr).append(rTableRightTd2);
					
					
					var rTableRightTd3 = document.createElement("td");
					rTableRightTd3.innerHTML = newNum;
					jQuery(rTableRightTr).append(rTableRightTd3);
					
				}
			};
			
			jQuery('#rankingsCont').append(rTable);
			
			jQuery('#rightNum').html(amtText).append(arrowNumR);
			jQuery('#leftNum').html(amtText).append(arrowNum);
		}
	},
	populateDropdown : function(el,data){ // generic dropdown populator
		jQuery(el).html("");
		jQuery(el).append('<option value="">- Select One -</option>');
		for(var i=0;i<data.DATA.length;i++){
			jQuery(el).append('<option value="'+data.DATA[i][0]+'">'+data.DATA[i][1]+'</option>');
		};
	},
	addCommas : function (nStr){
		nStr += '';
		x = nStr.split('.');
		x1 = x[0];
		x2 = x.length > 1 ? '.' + x[1] : '';
		var rgx = /(\d+)(\d{3})/;
		while (rgx.test(x1)) {
			x1 = x1.replace(rgx, '$1' + ',' + '$2');
		}
		return x1 + x2;
	},
	convertToPercent : function(fraction) {
		var newPercent = (fraction * 100) ;
		var dec = 2;
		var result = Math.round(newPercent*Math.pow(10,dec))/Math.pow(10,dec);
		result += '';
		var x = result.split('.');
		if(typeof(x[1]) != 'undefined' && x[1].length == 1){
			result = result + "0";
		}else if(typeof(x[1]) == 'undefined' || x[1].length == 0){
			result = result + ".00";
		}
		return result + '%';
	} ,
	convertMapTotals : function(mapNum,numType,ugh){
		var amtText = "<b>Number:</b> ";
		if(typeof(mapNum) == 'undefined' || mapNum == ''){
			mapNum = 0;
		}else if(numType == 'percent' && mapNum < 1){
			mapNum = this.convertToPercent(mapNum);
			amtText = "<b>Percent:</b> ";
		}else if(numType == 'percent' && mapNum == 1){
			mapNum = "100%";
			amtText = "<b>Percent:</b> ";
		}else{
			mapNum = this.addCommas(mapNum);
		};
		if(ugh){
			return mapNum;
		}else{
			return amtText + mapNum;
		};
	}
}