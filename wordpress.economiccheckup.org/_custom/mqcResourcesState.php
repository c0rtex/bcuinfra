

<?php

echo '

<script>
$(document).ready(function() {
canvasImgCount = 0;
});
</script>


<div class="span3">
   	<div class="well whitewell sidebar-nav" style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-file-alt "></i> Resources</legend>
        <ol class="nav nav-list">
            <li class="active"><a href="#contact"><i class="icon-fixed-width"></i>Aon Hewitt Navigators</a></li>
	      	<li class=""><a href="#other"><i class="icon-user-md"></i>Other Health Plans</a></li>
<li></li>


            <li><form><a data-toggle="modal" role="button" href="#" onClick="console.log(canvasImgCount);canvasImgCount = canvasImgCount + 1;javascript:PrintDivCanvasMMM(canvasImgCount);"><i class="icon-print "></i> Printable Report</a></form></li>
       		<li></li>
        </ol>		
    </div>
</div>


                     		<div id="imageToPrint"></div>
';


?>


