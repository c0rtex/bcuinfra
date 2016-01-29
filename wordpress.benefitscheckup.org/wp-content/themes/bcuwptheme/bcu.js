jQuery(document).ready(function () {
    reDraw()

    //$("#options_bcuqc_interest_category").appendTo("#bcu_upper_section");
    //$("#question_dob").appendTo("#bcu_upper_section");
    //
    //
    //if (detectIE()){
    //    $("#question_zip").appendTo("#bcu_upper_section");
    //    $("#options_bcuqc_income").appendTo("#bcu_upper_section");
    //    console.log("Is IE");
    //}

    console.log(navigator.appVersion);

    var $zip_code = jQuery('#bcuQuickcheckForm input#zip');
    var validated = 0;

    createColumns();

    checkOverlayParam();

    /*
     * Set responsive menu actions.
     */
    responsiveMenu();

    $(window).resize(function () {
        responsiveMenu();
        responsiveQcTable();
    });

    $(window).on("orientationchange", function (event) {
        responsiveQcTable();
        responsiveMenu();
    });

    //$("#esiMenuToggleButton").click(function () {
    //    $("#main-nav").toggle();
    //});


    $(".modal").on("shown.bs.modal", function () {
        $(document.body).addClass("frozenBody")
    });

    $(".modal").on("hidden.bs.modal", function () {
        $(document.body).removeClass("frozenBody")
    });

    $("#esiMenuToggleButton").click(function () {
        $("#main-nav").toggle();
    });

    jQuery('#esiQuickcheckResultsButton').on('click', function (e) {
        e.preventDefault();

        trySubmit(e);

        // Properly validate the entered ZIP code and link it to a state
        $zip_code.keyup(function () {
            console.log("keyup5");
            console.log($zip_code.val().length);
            if (jQuery(this).val().length == 5) {
                console.log("5");
                var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(jQuery(this).val());
                if (!isValidZip) {
                    //alert('You must enter a valid ZIP code containing all numbers. Please try again');
                    if (jQuery('#invalidZipLetters').length == 0) {
                        removeZipAlerts();
                        $zip_code.before('<div id="invalidZipLetters" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> <strong>You must enter a valid ZIP code containing all numbers. Please try again.</strong></div>');
                    }
                    jQuery(this).val('');
                    return false;
                }

                var threeDigits = jQuery(this).val().substring(0, 3);
//console.log ("three gidig" + threeDigits);
                if (threeDigits == "006" || threeDigits == "007" || threeDigits == "008" || threeDigits == "009" || threeDigits == "969") {

                    if (jQuery('#invalidZip').length == 0) {

                        removeZipAlerts();
                        $zip_code.before('<div id="invalidZip" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> The zip code you entered is invalid. Please enter a zip code for the U.S. or District of Columbia.</div>');
                    }
                    jQuery(this).val('');
                    return false;
                }

                var myVal = jQuery(this).val();
                jQuery.ajax({
                    url: 'https://www.benefitscheckup.org/cf/com/bcu/ZipFunctions.cfc?method=getStateFromZip',
                    datatype: 'json',
                    data: 'zipcode=' + myVal,
                    cache: false,
                    success: function (StateId) {
                        var newcode = eval('(' + StateId + ')');
//console.log("invliad zip length "+jQuery('#invalidZip').length);
                        if (!newcode || StateId == 'false') {
                            stcode = '';
                            stname = '';
                            if (jQuery('#invalidZip').length == 0) {

                                removeZipAlerts();
                                $zip_code.before('<div id="invalidZip" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> This is an invalid ZIP code. Please try again.</div>');
                            }
                            jQuery('#zyxzip_zip_abbrev').val('??');
                            jQuery('#zyxzip_zip_abbrev').css('color', 'black');
                            jQuery('#zyxzip_zip_abbrev').css('background', '#ffcccc');
                            return false;
                        } else {

                            removeZipAlerts();

                            stcode = newcode.DATA[0][0];
                            stname = newcode.DATA[0][1];
                            jQuery('#zyxzip_zip_abbrev').val(stcode);
                            jQuery('#zyxzip_zip_abbrev').css('color', 'black');
                            if (stcode == 'NY') {
                                jQuery('#zyxzip_zip_abbrev').css('background', '#ccffcc');
                            } else {
                                jQuery('#zyxzip_zip_abbrev').css('background', '#ccccff');
                            }
                        }
                        ;
                    }
                });
            } else {
                stcode = '';
                jQuery('#zyxzip_zip_abbrev').val('n/a');
                jQuery('#zyxzip_zip_abbrev').css('color', '#666666');
                jQuery('#zyxzip_zip_abbrev').css('background', '#dddddd');
            }
        });

        $zip_code.blur(function () {
            var isValidZip = /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(jQuery(this).val());
            if (!isValidZip) {
                //alert('You must enter a valid ZIP code containing all 5 numbers. Please try again');

                removeZipAlerts();
                $zip_code.before('<div id="invalidZipNumbers" class="alert alert-danger alert-bcuQuickCheck"><i class="icon-warning-sign"></i> <strong>You must enter a valid ZIP code containing all 5 numbers. Please try again.</strong></div>');
                jQuery(this).val('');
                return false;
            }
            ;

            jQuery.ajax({
                url: 'https://www.benefitscheckup.org/cf/com/bcu/ZipFunctions.cfc?method=isZipInState',
                datatype: 'json',
                data: 'zipcode=' + jQuery(this).val() + '&state_id=NY',
                cache: false,
                success: function (StateId) {
                    var newcode = eval('(' + StateId + ')');
                    if (!newcode && stname != '') {
                        if (1 == 1) {
                            if ($zip_code.val().length == 5) {
                                jQuery('#zyxzip_zip_abbrev').val(stcode);
                                jQuery('#zyxzip_zip_abbrev').css('color', 'black');

                                jQuery('#zyxzip_zip_abbrev').css('background', '#ccccff');

                            } else {
                                stcode = '';
                                jQuery('#zyxzip_zip_abbrev').val('n/a');
                                jQuery('#zyxzip_zip_abbrev').css('color', '#666666');
                                jQuery('#zyxzip_zip_abbrev').css('background', '#dddddd');
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
            if (jQuery('#invalidZip').length != 0) {
                jQuery('#invalidZip').remove();
            }
            if (jQuery('#invalidZipNumbers').length != 0) {
                jQuery('#invalidZipNumbers').remove();
            }
            if (jQuery('#invalidZipLetters').length != 0) {
                jQuery('#invalidZipLetters').remove();
            }
        }

        //clears all alerts
        function clearErrorsOnHide() {
            $(".alert").remove();
        }

        function trySubmit(e) {
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


        }


        //clear all alerts when the modal dialog is closed.
        $(".modal").on("hidden.bs.modal", clearErrorsOnHide);
    });

    $("div#question_bcuqc_interest_category.row-fluid").removeAttr('id');
});
function createColumns() {
    $("#esiQuickcheckCheckboxes").prepend("<div id='last-column' class='last-column'></div>");
    $("#esiQuickcheckCheckboxes").prepend("<div id='first-column' class='first-column'></div>");
    $("#esiQuickcheckCheckboxes > div.checkbox:lt(4)").appendTo('.first-column');
    $("#esiQuickcheckCheckboxes > div.checkbox:lt(4)").appendTo('.last-column');
    responsiveQcTable();
}

/**
 * Check if overlay overlay has been set to true
 */
function checkOverlayParam() {
    function getURLParameter(name) {
        return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null
    }

    //if the overlay URL parameter is set to true then show the quick check modal.
    if (getURLParameter("overlay") == "true") {
        jQuery('#bcu_quickcheck').modal('show')
    }
}
/**
 * Remove the second column from the table and appends the to the
 * end of the first column. Should resolve small screen text overflow issue.
 */
function responsiveQcTable() {

    var food = "#tr_bcuqc_category_foodsupp";
    var utility = "#tr_bcuqc_category_utility";
    var taxes = "#tr_bcuqc_category_property_taxrelief";
    var veteran = "#tr_bcuqc_category_veteran";

    if ($(window).width() <= 480) {
        $("#last-column").children().appendTo("#first-column")
    } else {
        $(food).appendTo("#last-column");
        $(utility).appendTo("#last-column");
        $(taxes).appendTo("#last-column");
        $(veteran).appendTo("#last-column");
    }
}

/**
 * Adjusts the menu to adjust when medium or smaller screens are being used.
 */
function responsiveMenu() {

    if ($(window).width() <= 700) {

        $("#esiMenuToggleButton").css("display", "block");
        $("#getStartedESIButton").appendTo($("h2.feature"));
        $("#top-bar").css("margin-top", "30px");
        $("#getStartedESIButtonImg").css("margin-top", "25px");
        $("#getStartedESIButtonImg").css("margin-bottom", "25px");

        $("#logo.statistics").hide();
        $("#main-nav").hide();

    } else {
        $("#esiMenuToggleButton").css("display", "none");
        $("#esiMenuToggleButton").hide();
        $("#logo.statistics").show();
        $("#main-nav").show();
        $("#top-bar").css("margin-top", "0px");
        $("#getStartedESIButtonImg").css("margin-top", "0px");
        $("#getStartedESIButtonImg").css("margin-top", "0px");
    }
}

/**
 * detect IE
 * returns version of IE or false, if browser is not Internet Explorer
 */
function detectIE() {
    var ua = window.navigator.userAgent;

    var msie = ua.indexOf('MSIE ');
    if (msie > 0) {
        // IE 10 or older => return version number
        return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
    }

    var trident = ua.indexOf('Trident/');
    if (trident > 0) {
        // IE 11 => return version number
        var rv = ua.indexOf('rv:');
        return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
    }

    var edge = ua.indexOf('Edge/');
    if (edge > 0) {
        // Edge (IE 12+) => return version number
        return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
    }

    // other browser
    return false;
}

function appendTo(section) {
    return function (element) {
        element.appendTo(section)
    }
}

function reDraw() {
    var leftColumn = "#left_questions_column";
    var containerBlock = $("#bcu_upper_section");

    var zipBlock = $("#question_zip");
    var dobBlock = $("#question_dob");
    var incomeBlock = $("#bcuqc_income_group");

    var leftColumnBlock = $(leftColumn);

    [zipBlock, dobBlock, incomeBlock].forEach(appendTo(leftColumnBlock));

    var interestBlock = $("question_bcuqc_interest_category");
    interestBlock.appendTo(containerBlock);
    interestBlock.addClass("span6");
}