jQuery(document).ready(function() {
  var $zip_code = jQuery('#bcuQuickcheckForm input#zip');
  var validated = 0;

  jQuery('#esiQuickcheckResultsButton').on('click', function(e) {
    e.preventDefault();

    validated = 1;
    // Validate specific input parameters
    removeZipAlerts();
    jQuery('#invalidInterest').remove();
    if ($zip_code.val().length != 5) {
      $zip_code.before('<div id="invalidZipNumbers" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> <strong>You must enter a valid ZIP code containing all 5 numbers. Please try again.</strong></div>');
      validated = 0;
    }
    if (jQuery('#zyxzip_zip_abbrev').val() == '??') {
      $zip_code.before('<div id="invalidZip" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> This is an invalid ZIP code. Please try again.</div>');
      validated = 0;
    }
    if (!(jQuery('#esiQuickcheckCheckboxes :checkbox:checked').length > 0)) {
      jQuery('#esiQuickcheckCheckboxes').before('<div id="invalidInterest" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> <strong>You must select at least one area of interest.</strong></div>');
      validated = 0;
    }

    if (validated == 0) {
      // Do not submission if the form fails validation
      return false;
    }
    else {
      jQuery('form#bcuQuickcheckForm').submit();
    }

  });

  // Properly validate the entered ZIP code and link it to a state
  $zip_code.keyup(function() {
    console.log("keyup5");
    console.log ($zip_code.val().length);
    if (jQuery(this).val().length == 5) {
      console.log("5");
      var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(jQuery(this).val());
      if(!isValidZip){
        //alert('You must enter a valid ZIP code containing all numbers. Please try again');
        if (jQuery('#invalidZipLetters').length == 0){
          removeZipAlerts();
          $zip_code.before('<div id="invalidZipLetters" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> <strong>You must enter a valid ZIP code containing all numbers. Please try again.</strong></div>');
        }
        jQuery(this).val('');
        return false;
      };

      var threeDigits = jQuery(this).val().substring (0, 3);
//console.log ("three gidig" + threeDigits);
      if (threeDigits == "006" || threeDigits == "007" || threeDigits == "008" || threeDigits == "009" || threeDigits == "969"){

        if (jQuery('#invalidZip').length == 0){

          removeZipAlerts();
          $zip_code.before('<div id="invalidZip" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> The zip code you entered is invalid. Please enter a zip code for the U.S. or District of Columbia.</div>');
        }
        jQuery(this).val('');
        return false;
      }

      var myVal = jQuery(this).val();
      jQuery.ajax({
        url: 'https://www.benefitscheckup.org/cf/com/bcu/ZipFunctions.cfc?method=getStateFromZip',
        datatype:'json',
        data: 'zipcode='+myVal,
        cache:false,
        success: function(StateId){
          var newcode = eval('('+StateId+')');
//console.log("invliad zip length "+jQuery('#invalidZip').length);
          if(!newcode || StateId == 'false'){
            stcode = '';
            stname = '';
            if (jQuery('#invalidZip').length == 0){

              removeZipAlerts();
              $zip_code.before('<div id="invalidZip" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> This is an invalid ZIP code. Please try again.</div>');
            }
            jQuery('#zyxzip_zip_abbrev').val('??');
            jQuery('#zyxzip_zip_abbrev').css('color','black');
            jQuery('#zyxzip_zip_abbrev').css('background','#ffcccc');
            return false;
          } else {

            removeZipAlerts();

            stcode = newcode.DATA[0][0];
            stname = newcode.DATA[0][1];
            jQuery('#zyxzip_zip_abbrev').val(stcode);
            jQuery('#zyxzip_zip_abbrev').css('color','black');
            if (stcode == 'NY'){
              jQuery('#zyxzip_zip_abbrev').css('background','#ccffcc');
            } else {
              jQuery('#zyxzip_zip_abbrev').css('background','#ccccff');
            }
          };
        }
      });
    } else {
      stcode = '';
      jQuery('#zyxzip_zip_abbrev').val('n/a');
      jQuery('#zyxzip_zip_abbrev').css('color','#666666');
      jQuery('#zyxzip_zip_abbrev').css('background','#dddddd');
    }
  });

  $zip_code.blur(function() {
    var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(jQuery(this).val());
    if(!isValidZip){
      //alert('You must enter a valid ZIP code containing all 5 numbers. Please try again');

      removeZipAlerts();
      $zip_code.before('<div id="invalidZipNumbers" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> <strong>You must enter a valid ZIP code containing all 5 numbers. Please try again.</strong></div>');
      jQuery(this).val('');
      return false;
    };

    jQuery.ajax({
      url: 'https://www.benefitscheckup.org/cf/com/bcu/ZipFunctions.cfc?method=isZipInState',
      datatype:'json',
      data: 'zipcode='+jQuery(this).val()+'&state_id=NY',
      cache:false,
      success: function(StateId){
        var newcode = eval('('+StateId+')');
        if(!newcode && stname != ''){
          if (1 ==1) {
            if ($zip_code.val().length == 5) {
              jQuery('#zyxzip_zip_abbrev').val(stcode);
              jQuery('#zyxzip_zip_abbrev').css('color','black');

              jQuery('#zyxzip_zip_abbrev').css('background','#ccccff');

            } else {
              stcode = '';
              jQuery('#zyxzip_zip_abbrev').val('n/a');
              jQuery('#zyxzip_zip_abbrev').css('color','#666666');
              jQuery('#zyxzip_zip_abbrev').css('background','#dddddd');
            }
          };
        };
      },
      error: function(){
        console.log ("Ajax error for the zip validation.");
      }
    });
  });


  function removeZipAlerts(){
    if (jQuery('#invalidZip').length != 0){
      jQuery('#invalidZip').remove();
    }
    if (jQuery('#invalidZipNumbers').length != 0){
      jQuery('#invalidZipNumbers').remove();
    }
    if (jQuery('#invalidZipLetters').length != 0){
      jQuery('#invalidZipLetters').remove();
    }

  }

  jQuery('#esiQuickcheckCheckboxes').prepend('<div class="last-column"></div>');
  jQuery('#esiQuickcheckCheckboxes').prepend('<div class="first-column"></div>');
  jQuery('#esiQuickcheckCheckboxes > div.checkbox:lt(4)').appendTo('.first-column');
  jQuery('#esiQuickcheckCheckboxes > div.checkbox:lt(3)').appendTo('.last-column');
});