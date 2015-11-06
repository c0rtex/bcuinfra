
$(document).ready(function() {


$("form#selectState").submit(function( event ) {

if ($("#selectAState option:selected").text() == "Select Your State"){

alert( "Please select a state or territory before clicking Go." );
event.preventDefault();
}
});

})
