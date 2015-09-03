<cfparam name="gohome" default="true">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars redirect="#evaluate("not #gohome#")#">
<cf_cacheWrapperQuery query="wrapper" partner_id="#session.partner_id#">

<!--- Reroute inactive PLs to consumer home --->
<cfoutput>
	<CFQUERY datasource="#APPLICATION.dbSrc#" NAME="stat">
		select wrapper_status from wrapper
		where wrapper_partner_id = #session.partner_id#
    </CFQUERY>
	<cfif stat.wrapper_status EQ 0>
    	<cflocation url="/index.php">
        <cfabort>
    </cfif>
    </cfoutput>

<!--- Set guts --->
<cfparam name="link" default="">



<cfif session.partner_id eq 0 and (1 eq 0)>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.pack.js"></script>
<script>
//Code from Queness
$(document).ready(function() {	

	//select all the a tag with name equal to modal
	$('a[name=modal]').click(function(e) {
		//Cancel the link behavior
		e.preventDefault();
		
		//Get the A tag
		var id = $(this).attr('href');
	
		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(1000);	
		$('#mask').fadeTo("slow",0.6);	
	
		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();
              
		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
	
		//transition effect
		$(id).fadeIn(2000); 
	
	});
	
	//if close button is clicked
	$('.window .close').click(function (e) {
		//Cancel the link behavior
		e.preventDefault();
		$('#mask, .window').hide(); 
	});		
	
	//if mask is clicked
	$('#mask').click(function () {
		$(this).hide();
		$('.window').hide();
	});			
	
});

$(window).load(function() {
    $('a#myLinkyLink[name=modal]').trigger("click");
});

</script>


<style>
#mask {
  position:absolute;
  left:0;
  top:0;
  z-index:9000;
  background-color:#000;
  display: none;
}

#boxes .window {
  position:absolute;
  left:0;
  top:0;
  width:440px;
  height:200px;
  display:none;
  z-index:9999;
  padding:20px;
}
#boxes #dialog1 {
  width:745px; 
  height:320px;
}
#dialog1 .d-closeMe {
  width:745px; 
  height:28px;
}

#dialog1 .d-middle {
  float:left;
  background:url(images/oneAway_main.png) no-repeat 0 0 transparent; 
  width:745px; 
  height:292px;
}


#dialog1 .d-tellCongress {
  float:right;
  width:745px; 
  height:45px;
  margin-top: -42px;
}

d-tellCongress {

margin-top: -45px;

}

</style>






<div id="boxes">
<a href="#dialog1" name="modal" id="myLinkyLink"></a>
<!-- Start of OneAway Dialog -->  
<div id="dialog1" class="window">
  <div class="d-closeMe"> <a href="#"class="close"/><img src="images/oneAway_top.png" border="0" /></a> </div>
  <div class="d-middle"></div>
<div class="d-tellCongress"><a href="#"class="close"/><img src="images/nothankyou.png" border="0" /></a>

<a href="http://www.oneaway.org/Tell-Congress?utm_source=BCU&utm_medium=Referral&utm_campaign=BCU_11-07-01"><img border="0" style="margin-left:510px; margin-top:-20px" src="images/oneAway_button.png"></a> </div>
</div>


<!-- End of OneAway Dialog -->  
<!-- Mask to cover the whole screen -->
<div id="mask"></div>
</div>




</cfif>

<cfif wrapper.recordcount IS 0>
	<cfset guts = "index_cf.cfm">
<cfelse>
	<cfset guts = "#wrapper.wrapper_index#">
</cfif>

<cfif Not IsDefined('session.org_id')>
	<cfset session.org_id = 0>
</cfif>

<cfif session.org_id GT 0>
	<cf_tagHeader log="false" randomimage="y">
	<cfinclude template="find_benefits2_cf.cfm">
	<cf_tagFooter>
<cfelse>
	<cf_tagHeader log="false" guts="#guts#" show_left_col="y" rightcol="rightcol_partners.cfm" randomimage="y">
	<cfinclude template="#guts#">
	<cf_tagFooter rightcol="rightcol_partners.cfm">
</cfif>
