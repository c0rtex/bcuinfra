<?php 

$programs = $soapClient->getProgByCat($state_id,93,$programcategory_id);
//if there are programs output the category section
$thischecked = false;
foreach ($fields as $f => $row)
					{
						if ($row["ANSWERFIELD"] == $interested) {
						$zip = $row["RESPONSE"];
						//echo "field:".$interested;
						$thischecked = true;			
						}
						

					}

if ($thischecked == true) {
?>

<section id="programlist">  	
        <div class="body-header-wrapper">	<h2><i class="icon-<?php echo $iconcode; ?>"> </i> <?php echo $cat_title; ?></h2>	
          	
     	</div>
        <div class="">
			<div action="" method="get" id="commentForm" class="well cmxform">
			   <?php echo $sectionSummary ?>
	  <ol class="nav nav-list">
	    			

				<?php 
				foreach ($programs as $p => $row2)
					{
						$prog_title = $row2["DISPLAY_TEXT"];
						$program_id = $row2["PROGRAM_ID"];
						$program_code = $row2["PROGRAM_CODE"];
						$legacy_code = $row2["LEGACY_PRG_ID"];
						
				?>
				<li id="<?php echo $program_code ?>" class="">	
				<?php	 
				echo " <a target='blank' href='/cf/frmDetails.cfm?prg_id=".$legacy_code."&state_id=".$state_id."&county=".$county."&zip=".$zip."&screeningID=".$screeningID."&shadowID=".$shadowID."&src=quickcheck'><i class='icon-info-sign '></i>".$prog_title." </a></li>";
				
						//echo $program_id;
						//echo "<br>";
					}
				//print_r($programs);
				if (sizeOf($programs) == ''){
					echo "We do not have information on programs of interest of this category available in your area at the moment.";
				}
			     ?> 
		</ol>
            </div>
        </div>
  	</section>
<?php

//end program category output 
}
?>
