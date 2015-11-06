!function ($) {

  $(function(){

    var $window = $(window)


    //Questionnaire content

    ////QUESTIONS 8 and 9: Show additional question content if checkbox is checked

//code to make the checkboxes stay checked upon page reload

$(".checkboxSubQuestionAdditional").each(function () {
  //console.log("gets here at all");
  $theCheckbox = $(this);
  showHideByCheckbox ($theCheckbox, "subQuestionAdditional_", "show", "prefix");

     })


//do this upon changing the checkbor
$(".checkboxSubQuestionAdditional").change(function () {


  $theCheckbox = $(this);
  showHideByCheckbox ($theCheckbox, "subQuestionAdditional_", "show", "prefix");

    })



//QUESTIONS 11 and 12: Enable and disable the input fields in QUESTION 12 based on checkboxes in QUESTION 11

//do this upon page load
$("#receive_msp, #receive_lis").each(function () {


  $theCheckbox = $(this);
  showHideByCheckbox ($theCheckbox, "_amount", "display", "suffix");

    })

$(".benefitsCheckbox").each(function () {


  $theCheckbox = $(this);
  showHideByCheckboxClass ($theCheckbox, "_class", "display", "suffix");

    })




//do this upon changing the checkbox
$("#receive_msp, #receive_lis").change(function () {


  $theCheckbox = $(this);
  showHideByCheckbox ($theCheckbox, "_amount", "display", "suffix");

    })

$(".benefitsCheckbox").change(function () {


  $theCheckbox = $(this);
  showHideByCheckboxClass ($theCheckbox, "_class", "display", "suffix");

    })




function showHideByCheckbox (theCheckbox, fieldIdInfo, command, fieldIdInfoType){
  //console.log("Checkbox in function id " + theCheckbox.attr("id"));
if (fieldIdInfoType == "prefix"){
  $fieldId = "#" + fieldIdInfo + theCheckbox.attr("id");
}
else if (fieldIdInfoType == "suffix"){
  $fieldId = "#" + theCheckbox.attr("id") + fieldIdInfo;
}
  //console.log("fieldId: " + $fieldId);
        if($("#"+theCheckbox.attr("id")).is(":checked")){
  //console.log("gets into checked at all");
 if (command=="show"){
  $($fieldId).show();
}
 else if (command=="display"){
  $($fieldId).prop("disabled", false);
}
        }
        else{ //checkbox is unchecked
 if (command=="show"){
  //console.log("gets into unchecked at all");
  $($fieldId).hide();
//disable all input fields in this div
  $($fieldId + " input").val('');

}
else if (command=="display"){
  //console.log("gets into unchecked at all");
  $($fieldId).prop("disabled", true);
  $($fieldId).val('');
}
}
 

}



function showHideByCheckboxClass (theCheckbox, fieldIdInfo, command, fieldIdInfoType){
  //console.log("Checkbox in function id " + theCheckbox.attr("id"));
if (fieldIdInfoType == "prefix"){
  $fieldId = fieldIdInfo + theCheckbox.attr("id"); //this is indeed a class in this function, not id
}
else if (fieldIdInfoType == "suffix"){
  $fieldId = theCheckbox.attr("id") + fieldIdInfo;
}
  //console.log("fieldId: " + $fieldId);
        if($("#"+theCheckbox.attr("id")).is(":checked")){
  //console.log("gets into checked at all");
 if (command=="show"){
  $("."+$fieldId).show();
}
 else if (command=="display"){
  $("."+$fieldId).prop("disabled", false);
}
        }
        else{ //checkbox is unchecked
 if (command=="show"){
  //console.log("gets into unchecked at all");
console.log("."+fieldId);
  $("."+$fieldId).hide();
}
else if (command=="display"){
  $("."+$fieldId).prop("disabled", true);
  //console.log("gets into unchecked at all");
  $("."+$fieldId).val('');
}
}
 

}







  

    // side bar
    setTimeout(function () {
      $('.bs-docs-sidenav').affix({
        offset: {
          top: function () { return $window.width() <= 980 ? 290 : 210 }
        , bottom: 270
        }
      })
    }, 100)

    // make code pretty
    window.prettyPrint && prettyPrint()

    // add-ons
    $('.add-on :checkbox').on('click', function () {
      var $this = $(this)
        , method = $this.attr('checked') ? 'addClass' : 'removeClass'
      $(this).parents('.add-on')[method]('active')
    })

    // add tipsies to grid for scaffolding
    if ($('#gridSystem').length) {
      $('#gridSystem').tooltip({
          selector: '.show-grid > [class*="span"]'
        , title: function () { return $(this).width() + 'px' }
      })
    }

  

    // steve demo
    $("a[data-toggle=tooltip]")
      .tooltip()
      .click(function(e) {
        e.preventDefault()
	var el = this;
      //$(el).popover('show');
      $(".popover > h3").append('<span class="close icon icon-remove"></span>')
                        .find('.close').on('click', function(e) {
                            e.preventDefault();
                            $(el).popover('hide');
                        }
       );

     })
 
    $('a[data-toggle="tab"]').on('shown', function (e) {
 	 e.target // activated tab
  	e.relatedTarget // previous tab
    })

    // popover display
    $("a[data-toggle=popover]")
      .popover()
      .click(function(e) {
        e.preventDefault()
      var el = this;
      //$(el).popover('show');
var thePopover = $(this).next().children().nextAll("h3");
      //$(".popover > h3").append('<span class="close icon icon-remove"></span>')
      $(thePopover).append('<span class="close icon icon-remove"></span>')
                        .find('.close').on('click', function(e) {
                            e.preventDefault();
                            $(el).popover('hide');
                        }
      );
     })     




    // button state demo
    $('#fat-btn')
      .click(function () {
        var btn = $(this)
        btn.button('loading')
        setTimeout(function () {
          btn.button('reset')
        }, 3000)
      })

    // carousel demo
    $('#myCarousel').carousel()

    // javascript build logic
    var inputsComponent = $("#components.download input")
      , inputsPlugin = $("#plugins.download input")
      , inputsVariables = $("#variables.download input")

    // toggle all plugin checkboxes
    $('#components.download .toggle-all').on('click', function (e) {
      e.preventDefault()
      inputsComponent.attr('checked', !inputsComponent.is(':checked'))
    })

    $('#plugins.download .toggle-all').on('click', function (e) {
      e.preventDefault()
      inputsPlugin.attr('checked', !inputsPlugin.is(':checked'))
    })

    $('#variables.download .toggle-all').on('click', function (e) {
      e.preventDefault()
      inputsVariables.val('')
    })

    // request built javascript
    $('.download-btn .btn').on('click', function () {

      var css = $("#components.download input:checked")
            .map(function () { return this.value })
            .toArray()
        , js = $("#plugins.download input:checked")
            .map(function () { return this.value })
            .toArray()
        , vars = {}
        , img = ['glyphicons-halflings.png', 'glyphicons-halflings-white.png']

    $("#variables.download input")
      .each(function () {
        $(this).val() && (vars[ $(this).prev().text() ] = $(this).val())
      })

      $.ajax({
        type: 'POST'
      , url: /\?dev/.test(window.location) ? 'http://localhost:3000' : 'http://bootstrap.herokuapp.com'
      , dataType: 'jsonpi'
      , params: {
          js: js
        , css: css
        , vars: vars
        , img: img
      }
      })
    })
  })

// Modified from the original jsonpi https://github.com/benvinegar/jquery-jsonpi
$.ajaxTransport('jsonpi', function(opts, originalOptions, jqXHR) {
  var url = opts.url;

  return {
    send: function(_, completeCallback) {
      var name = 'jQuery_iframe_' + jQuery.now()
        , iframe, form

      iframe = $('<iframe>')
        .attr('name', name)
        .appendTo('head')

      form = $('<form>')
        .attr('method', opts.type) // GET or POST
        .attr('action', url)
        .attr('target', name)

      $.each(opts.params, function(k, v) {

        $('<input>')
          .attr('type', 'hidden')
          .attr('name', k)
          .attr('value', typeof v == 'string' ? v : JSON.stringify(v))
          .appendTo(form)
      })

      form.appendTo('body').submit()
    }
  }
})

}(window.jQuery)
