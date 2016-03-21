$(document).ready(function () {
    console.log("this script works at all test");

    responsiveMenu();

    liheapFix();

    $(window).resize(function () {
        responsiveMenu();
    });

    $("#esiMenuToggleButton").click(function () {
        $("#main-nav").toggle();
    })

    $("#esi_incomesupport").keydown(function (e) { //alow numeric input only
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
                // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });

    /*
     <?php
     // Scroll to the first alert if the submitted form had errors
     if(isset($_GET['badresponselist'])) {
     echo '$(".alert-danger")[0].scrollIntoView(true);';
     }
     ?>
     */


    validated = 1;

    // Properly validate the entered ZIP code and link it to a state
    $('#esi_zip').keyup(function () {
        console.log("keyup5");
        console.log($('#esi_zip').val().length);
        if ($(this).val().length == 5) {
            console.log("5");
            var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test($(this).val());
            if (!isValidZip) {
                //alert('You must enter a valid ZIP code containing all numbers. Please try again');
                if ($('#invalidZipLetters').length == 0) {
                    removeZipAlerts();
                    $('#esi_zip').before('<div id="invalidZipLetters" class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>You must enter a valid ZIP code containing all numbers. Please try again.</strong></div>');
                }
                $(this).val('');
                return false
            }
            ;

            var threeDigits = $(this).val().substring(0, 3);
//console.log ("three gidig" + threeDigits);
            if (threeDigits == "006" || threeDigits == "007" || threeDigits == "008" || threeDigits == "009" || threeDigits == "969") {

                if ($('#invalidZip').length == 0) {

                    removeZipAlerts();
                    $('#esi_zip').before('<div id="invalidZip" class="alert alert-danger"><i class="icon-warning-sign"></i> The zip code you entered is invalid. Please enter a zip code for the U.S. or District of Columbia.</div>');
                }
                $(this).val('');
                return false;
            }

            var myVal = $(this).val();
            jQuery.ajax({
                url: 'https://www.benefitscheckup.org/cf/com/bcu/ZipFunctions.cfc?method=getStateFromZip',
                datatype: 'json',
                data: 'zipcode=' + myVal,
                cache: false,
                success: function (StateId) {
                    var newcode = eval('(' + StateId + ')');
//console.log("invliad zip length "+$('#invalidZip').length);
                    if (!newcode || StateId == 'false') {
                        stcode = '';
                        stname = '';
                        if ($('#invalidZip').length == 0) {

                            removeZipAlerts();
                            $('#esi_zip').before('<div id="invalidZip" class="alert alert-danger"><i class="icon-warning-sign"></i> This is an invalid ZIP code.  Please try again.</div>');
                        }
                        $('#zyxzip_zip_abbrev').val('??');
                        $('#zyxzip_zip_abbrev').css('color', 'black');
                        $('#zyxzip_zip_abbrev').css('background', '#ffcccc');
                        return false;
                    } else {

                        removeZipAlerts();

                        stcode = newcode.DATA[0][0];
                        stname = newcode.DATA[0][1];
                        $('#zyxzip_zip_abbrev').val(stcode);
                        $('#zyxzip_zip_abbrev').css('color', 'black');
                        if (stcode == 'NY') {
                            $('#zyxzip_zip_abbrev').css('background', '#ccffcc');
                        } else {
                            $('#zyxzip_zip_abbrev').css('background', '#ccccff');
                        }
                    }
                    ;
                }
            });
        } else {
            stcode = '';
            $('#zyxzip_zip_abbrev').val('n/a');
            $('#zyxzip_zip_abbrev').css('color', '#666666');
            $('#zyxzip_zip_abbrev').css('background', '#dddddd');
        }
    });

    $('#esi_zip').blur(function () {
        var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test($(this).val());
        if (!isValidZip) {
            //alert('You must enter a valid ZIP code containing all 5 numbers. Please try again');

            removeZipAlerts();
            $('#esi_zip').before('<div id="invalidZipNumbers" class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>You must enter a valid ZIP code containing all 5 numbers. Please try again.</strong></div>');
            $(this).val('');
            return false
        }
        ;

        jQuery.ajax({
            url: 'https://www.benefitscheckup.org/cf/com/bcu/ZipFunctions.cfc?method=isZipInState',
            datatype: 'json',
            data: 'zipcode=' + $(this).val() + '&state_id=NY',
            cache: false,
            success: function (StateId) {
                var newcode = eval('(' + StateId + ')');
                if (!newcode && stname != '') {
                    if (1 == 1) {
                        if ($('#esi_zip').val().length == 5) {
                            $('#zyxzip_zip_abbrev').val(stcode);
                            $('#zyxzip_zip_abbrev').css('color', 'black');

                            $('#zyxzip_zip_abbrev').css('background', '#ccccff');

                        } else {
                            stcode = '';
                            $('#zyxzip_zip_abbrev').val('n/a');
                            $('#zyxzip_zip_abbrev').css('color', '#666666');
                            $('#zyxzip_zip_abbrev').css('background', '#dddddd');
                        }
                    }
                    ;
                }
                ;
            },
            error: function () {
                console.log("Ajax error for the zip validation.");
            }
        });
    });


    function removeZipAlerts() {
        if ($('#invalidZip').length != 0) {
            $('#invalidZip').remove();
        }
        if ($('#invalidZipNumbers').length != 0) {
            $('#invalidZipNumbers').remove();
        }
        if ($('#invalidZipLetters').length != 0) {
            $('#invalidZipLetters').remove();
        }

    }

    // Define the function to validate the form on submission
    function validateForm(inputs) {
        // Clear out all previous alerts
        $('.alert').remove();
        validated = 1;

        // Begin to check which fields need to filled in
        jQuery.each(inputs, function (i, val) {
            if ($("#" + i).val() == '') {
                $("#" + i).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>' + val + '</strong> must not be left blank</div>');
                validated = 0;
            }
            ;
        });
    }


    function validateFormCheckboxRadio(inputsCheckboxRadio) {
        $('.alert').remove();
        validated = 1;

        // Begin to check which fields need to filled in
        jQuery.each(inputsCheckboxRadio, function (i, val) {
//console.log (("#" + i));
            //if( $("#" + i).find('input:checked').length > 0) {
            if (!$("#" + i).find('input:checked').length > 0) {
                if (i == "esiQuickcheckCheckboxes") {

                    $("#" + i).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong> You must select at least one area of interest.</div>');
                }
                else {
                    $("#" + i).before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>' + val + '</strong> is a required field.</div>');
                }
                validated = 0;
            }
            ;
        });
    }


    // Start the validation on form submission
    $('#esiForm').submit(function () {
        // Create an array of input IDs and their names for fields that cannot be blank
        var inputs = {
            "select_esi_client": "Form Completion",
            "esi_zip": "Zip Code",
            "esi_birth_month": "Birth Month",
            "esi_birth_year": "Birth Year",
            "select_esi_marital": "Marital Status",
            "select_esi_basicneeds": "Basic Needs",
            "esi_incomesupport": "Income Dependents",
            "select_esi_housingtype": "Housing Type",
            "select_esi_ratehealth": "Rate Health"
        };

        validateForm(inputs);

        // Validate specific input parameters
        if ($('#esi_zip').val().length != 5) {
            $("#esi_zip").before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>Zip Code</strong> must be 5 digits</div>');
            validated = 0;
        }
        if ($('#zyxzip_zip_abbrev').val() == '??') {
            $("#esi_zip").before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>Zip Code</strong> is not valid</div>');
            validated = 0;
        }
        if ($("#esi_incomesupport").val() != '' && !$.isNumeric($('#esi_incomesupport').val())) {
            $("#esi_incomesupport").before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>Income Dependents</strong> must be numeric</div>');
            validated = 0;
        }

        // Validate benefits checkboxes and money inputs
        var inputs = {
            "receive_msp": "receive_msp_amount",
            "receive_lis": "receive_lis_amount",
            "fdstmp_receive": "receive_snap_amount",
            "liheap_receive": "receive_liheap_amount",
            "med_receive": "receive_medicaid_amount",
            "receive_propertytax": "receive_property_tax_amount"
        };

        jQuery.each(inputs, function (i, input) {
            if ($("#" + i).is(':checked') && $('#' + input).val() == '') {
                $("#" + input).parents(':eq(3)').before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> A value must be entered.</div>');
                validated = 0;
            }
            ;
        });

        if (validated == 0) {
            // Do not submission if the form fails validation
            $(".alert-danger")[0].scrollIntoView(true);
            $("#basics .well").prepend('<div class="alert alert-danger"><i class="icon-warning-sign"></i> We\'re sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</div>');
            return false;
        }
    });

    $('#esiQuickcheckSubmit').click(function () { //submit form upon clicking on button-like link
        $('#esiQuickcheckForm').submit();
        return false;
    })

    $('#esiQuickcheckForm').submit(function () {
        // Create an array of input IDs and their names for fields that cannot be blank
        var inputsCheckboxRadio = {"esiQuickcheckCheckboxes": "Interest Categories"};
        var inputs = {"esi_zip": "Zip Code"};

        validateForm(inputs);
        validateFormCheckboxRadio(inputsCheckboxRadio);
//console.log ("validated ");
//console.log(validated);
//console.log ("zip ");
//console.log($("#esi_zip").val());


        // Validate specific input parameters
        if ($('#esi_zip').val().length != 5) {
            $("#esi_zip").before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>Zip Code must be 5 digits</strong></div>');
            validated = 0;
        }
        if ($('#zyxzip_zip_abbrev').val() == '??') {
            $("#esi_zip").before('<div class="alert alert-danger"><i class="icon-warning-sign"></i> <strong>Zip Code is not valid</strong></div>');
            validated = 0;
        }

        if (validated == 0) {
            // Do not submission if the form fails validation
            //$(".alert-danger")[0].scrollIntoView(true);
            //$("#esiQuickcheckForm").prepend('<div class="alert alert-danger"><i class="icon-warning-sign"></i> We\'re sorry, but some responses are missing or were completed incorrectly. Please correct the problems where indicated below.</div>');
            return false;
        }
    });


    /* hidden.bs.modal event example */
    $('#esi_quickcheck').on('hidden.bs.modal', function () {
        //window.alert('hidden event fired!');

        $('#esi_quickcheck .alert').remove();
        $('#esi_quickcheck .alert-danger').remove();
    })


});


function PrintDiv() {
    $(".printReport").hide();
    var divToPrint = document.getElementById('printContent');
    var popupWin = window.open('', '_blank');
    popupWin.document.open();
    popupWin.document.write('<html><body onload="window.print()"><img id="logo" alt="EconomicCheckUp" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" src="/wp-content/uploads/2013/08/EconomicCheckUp_NCOA_small.jpg"><BR />' + divToPrint.innerHTML + '</html>');
    popupWin.document.close();
    $(".printReport").show();
}
function PrintDivCanvas(imgCanvas, imgCanvasCount) {
    $(".printReport").hide();
    var divToPrint = document.getElementById('printContent');
//console.log("In called func canvasImgCount: "+imgCanvasCount);
    if (imgCanvasCount == 1) {  //avoiding repeated images
//$("#flot-placeholder").hide();
        $("#flot-placeholder").append('<img src="' + imgCanvas + '"/>');
    }
//document.getElementById('canvasImage').setAttribute('src',vara); 
//console.log("Canvas img printing: "+imgCanvas);
    var popupWin = window.open('', '_blank');
    popupWin.document.open();
    popupWin.document.write('<html><body onload="window.print()"><img id="logo" alt="EconomicCheckUp" title="EconomicCheckUp - A Holistic Approach to Helping Older Adults in Need" src="/wp-content/uploads/2013/08/EconomicCheckUp_NCOA_small.jpg"><BR />' + divToPrint.innerHTML + '</html>');
    popupWin.document.close();
    $(".printReport").show();
}


function responsiveMenu() {

    if ($(window).width() <= 700) {

        $("#esiMenuToggleButton").css("display", "block");
        $("#getStartedESIButton").appendTo($("h2.feature"));
        $("#top-bar").css("margin-top", "30px");
        $("#getStartedESIButtonImg").css("margin-top", "25px");
        $("#getStartedESIButtonImg").css("margin-bottom", "25px");

        $("#logo.statistics").hide();
        $("#main-nav").hide();

    }

    else {
        $("#esiMenuToggleButton").css("display", "none");
        $("#esiMenuToggleButton").hide();
        $("#logo.statistics").show();
        $("#main-nav").show();
        $("#top-bar").css("margin-top", "0px");
        $("#getStartedESIButtonImg").css("margin-top", "0px");
        $("#getStartedESIButtonImg").css("margin-top", "0px");
    }

    //  Check if overlay overlay has been set to true
    function getURLParameter(name) {
        return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null
    }

    //if the overlay URL parameter is set to true then show the quick check modal dialog.
    if (getURLParameter("overlay") == "true") {
        jQuery('#esi_quickcheck').modal('show')
    }

}

function liheapFix(){
    $("#liheap_link").attr('href', "#liheap_info");
    $("#liheap_link").attr('data-toggle', "modal");
    $("#liheap_link").attr('data-backdrop', "static");


    $("#liheap_link2").attr('href', "#liheap_info");
    $("#liheap_link2").attr('data-toggle', "modal");
    $("#liheap_link2").attr('data-backdrop', "static");


    $('*[id*=liheap_link]:visible').each(function() {
        $(this).attr('href', "#liheap_info");
        $(this).attr('data-toggle', "modal");
        $(this).attr('data-backdrop', "static");
    });
}


