
<!DOCTYPE html>
<html>
<head>
  <style>
  span { background:#def3ca; padding:3px; float:left; }
  </style>
  <script src="/wp-content/themes/bootswatch/bootstrap/js/jquery.js"></script>
</head>
<body>
<!--span8-->
<div class="span4">
   	<div class="well sidebar-nav" >
        <legend><i class="icon-list-alt "></i> Completion Status</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#basics"><i class="icon-pencil "></i> Basics <span style="display: none;" id="status-basics">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></span></a></li>
            <li class=""><a href="#income"><i class="icon-money "></i> Income <span style="display: none;" id="status-income">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></span></a></li>
            <li class=""><a href="#employment"><i class="icon-briefcase "></i> Employment <span style="display: none;" id="status-employment">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></span></a></li>
            <li class=""><a href="#debt"><i class="icon-bar-chart "></i> Debt <span style="display: none;" id="status-debt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></span></a></li>
            <li class=""><a href="#housing"><i class="icon-building "></i> Housing <span style="display: none;" id="status-housing">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></span></a></li>
            <li class=""><a href="#health"><i class="icon-medkit "></i> Health <span style="display: none;" id="status-health">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></span></a></li>
	     <li class=""><a href="#interested"><i class="icon-question-sign "></i> More Info <span style="display: none;" id="status-interested">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-check "></i><em><strong>Completed</strong></em></span></a></li>
        </ol><br />
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li><a data-toggle="modal" role="button" href="#detailedinstructions"><i class="icon-book "></i> Instructions </a></li>
	      <li><a data-toggle="modal" role="button" href="#printable"><i class="icon-print "></i> Printable Questionnaire </a></li>
           <li><a data-toggle="modal" role="button" href="#referafriend"><i class="icon-link "></i> Refer A Friend </a></li>
		<li ><input class="btn btn-large btn-primary " id="view_results" type="submit" value="View Results" ></li>
        </ol>		
    </div>	  
</div>

  <button id="hidr">Hide</button>
<button id="showr">Show</button>
<div>
 
  <span>Once</span> <span>upon</span> <span>a</span>
  <span>time</span> <span>there</span> <span>were</span>
  <span>three</span> <span>programmers...</span>
 
</div>
<script>
$("#hidr").click(function () {
  $("#status-basics").hide("fast", function () {
    // use callee so don't have to name the function
    $(this).prev().hide("fast", arguments.callee);
  });
});
$("#showr").click(function () {
  $("#status-basics").show(2000);
});
</script>
 
</body>
</html>