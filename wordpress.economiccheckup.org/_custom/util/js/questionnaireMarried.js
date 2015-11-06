jQuery(function($){

//hide the Spouse and Joint fields when the person is not married and upon page load
$("div[id^=\'sp_\']").hide();
$("div[id^=\'s_sp_\']").hide();


//hide the Spouse and Joint fields when the person is not married and show them when married
$("#select_esi_marital").on("change", function(){ 
  if ($(this).val() == "4-married") { //check the selected option etc.
     //console.log("Married");
     $("div[id^='sp_']").show();
     $("div[id^='s_sp_']").show();
  }
  else {
     $("div[id^='sp_']").hide();
     $("div[id^='s_sp_']").hide();

}
});




});







