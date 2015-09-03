<cfif IsDefined('URL.partner_id') AND URL.partner_id NEQ ''>
	<cfset session.partner_id = URL.partner_id>
</cfif>
<style>
#taxReliefMap
{
	background: url(/cf/images/taxReliefMap.png) no-repeat 100px 0px;
	height: 450px;
}
#button-container
{
	float: right;
}
#wantToFind
{
	font-size: 12px;
}
.centerForm
{
	margin:-250px 0 250px 265px;
}
.leftForm
{
	margin:0px 0px 0px 50px !important;
}
INPUT#taxReliefZip
{
	font-size: 14px;
	margin-top: 0px;
	width: 200px;
}
#stateMap
{
	float: left;
	width: 375px;
	margin-left: 0px;
}
#taxReliefStateContainer
{
	margin-top: 25px;
}
#stateMap
{
	float: left;
	<cfif SESSION.partner_id EQ 0 or SESSION.partner_id EQ 77 >
		width: 400px;
	<cfelse>
		width: 315px;
	</cfif>
	margin-left: 50px;
}
#taxReliefStateContainer
{
	margin-top: 25px;
}
#statePrograms
{
	width: 300px;
	float: left;
	margin-left: 50px;
	background: #EDF6F9;
	padding: 10px 20px 20px 30px;
}
#statePrograms UL
{
	list-style: none;
	margin: 20px 0 0 -30px;
}
#statePrograms UL LI
{
	padding-bottom: 5px;
}
.screeningh2 {
    padding: 0 0 10px !important;
}
#content
{
	margin-top: 20px;
}
#stateImage
{
	max-width: 350px !important;
}
</style>

<cfif IsDefined("SESSION.partner_id") AND SESSION.partner_id EQ 77>
<style>
#content
{
	margin-top: 0px;
}
</style>
</cfif>

<script type="text/javascript">
jQuery(document).ready(function(){
   
   	$('#go-button').click(function() {
	  if($('#taxReliefZip').val() == '' 
	  		|| $('#taxReliefZip').val() == 'Enter Your 5 Digit Zip Code' 
	  		|| $('#taxReliefZip').val().length < 5) {
          alert('You must enter a valid zip code before clicking the Go button.');
      return false;
      } 
	});
   	
	//form submit handler
	$("#taxReliefForm").submit(function(event) {
	
	    /* stop form from submitting normally */
	    event.preventDefault();
	    
			//jQuery ajax call to CFC
			$.ajax({
			    url: "taxRelief.cfc"
			  , type: "post"
			  // tell jQuery we're getting HTML back
			  , dataType: "html"
			  // send the data to the CFC
			  , data: {
			    // the method in the CFC to run
			      method: "getTaxReliefValues"
			    /*
			      send other arguments to CFC
			    */
			    // send the zip entered by the user
			    , taxReliefZip: $("#taxReliefZip").val()
			  }
			  // this gets the data returned on success
			  , success: function (data){
			    // this area is for jQuery calls to show/hide divs, etc
			    //alert(data);
			    $('#taxReliefMap').hide();
			    $('#taxReliefState').html(data);
			    $('#taxReliefState').show();
			    $('#wantToFind').show();
			    $('#taxRelief_p').hide();
			    $('#taxRelief_p_state').show();
			    $('#taxReliefContainer').removeClass('centerForm');
			    $('#taxReliefContainer').addClass('leftForm');
			    $('#taxReliefContainer').css({'margin':'0px 0px 0px 50px !important','float':'left','clear':'both'});
			  }
			  // this runs if an error
			  , error: function (xhr, textStatus, errorThrown){
			    // show error
			    alert(errorThrown);
			  }
			});
	});    
   
});
</script>

<h1 id="taxRelief_h1" class="indexh1" <cfif SESSION.partner_id NEQ 0>align="center"</cfif>><cf_displayText code="site_fit_toolkit_locator_title" group="site"></h1>
<p id="taxRelief_p" class="text1"><strong>Need Help Finding Tax Relief Programs?</strong>  Quickly find tax relief programs that
can help save you money.  Simply enter your zip code and you will get a list of
tax relief programs available in your area.  You will get general program
information including web links, application forms, and office contacts.
</p>

<p id="taxRelief_p_state" class="text1" style="display:none;"><strong>Need Help Finding Tax Relief Programs?</strong>  Quickly find tax relief programs that
can help save you money. To get information about the programs, just click on
the program you are interested in. You will get general program information
including web links, application forms, and office contacts. To find tax relief
programs in another area, just enter a new zip code below.
</p>

<div id="taxReliefMap" style="display:block;"></div>

<div id="taxReliefState" style="display:none;clear:both;"></div>

<div id="showButtons" style="display:none;clear:both;float:right;margin-bottom:-30px; margin-left:400px;"><a href="##" id="hideFactSheet"><img src="img/backToRelief.gif" alt="Back to Tax Relief Programs" border="0" /></a><img style="cursor:pointer;" src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" />
</div>

<div id="showOfficeButtons" style="display:none;clear:both;float:right;margin-bottom:-30px; margin-left:455px;"><a href="##" id="showFactSheet" class="getFactSheet"><img src="img/backToFactSheet.gif" alt="Back to Fact Sheet" border="0" /></a><img style="cursor:pointer;" src="img/print_this_page.gif" alt="Print this Page" onclick="self.print();" border="0" />
</div>

<div id="loadFactSheet" style="display:none;clear:both; min-height:600px;"></div>

<div id="taxReliefContainer" class="centerForm" style="width:290px;">
	<p id="wantToFind" style="display:none;"><strong>Want to find tax relief programs in another area?</strong></p>
	<form action="" id="taxReliefForm" method="post">
		<input id="taxReliefZip" type="text" name="taxReliefZip" 
				maxlength="5" 
				placeholder="Enter Your 5 Digit Zip Code" 
				value="Enter Your 5 Digit Zip Code" 
				onClick="if (form.taxReliefZip.value=='Enter Your 5 Digit Zip Code') {form.taxReliefZip.value='';}" />
		<div id="button-container">
			<a href="#" id="go-button" class="go-button"><input type="image" class="go-button" src="/wp-content/uploads/2011/09/go.png" alt="GO" title="GO" /></a>
		</div>
	</form> 
</div>