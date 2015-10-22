<?php
	$max_age = 100;
	$pi = get_post_info();
?>

<section class="viz-savings-wrap" style="display:none;">
   <h3 class="viz-graph-h3">Savings</h3>
   <table class="drawdown-savings-graph">
      <tr>
         <?php 
         for ($i=62; $i<=$max_age; $i++) {
            echo '<td class="savings-graph-bar" id="savingsgraph-'.$i.'"><div class="savings-remaining dd-bar">.</div><div class="savings-badly dd-bar">.</div></td>';
         }
         ?>
      </tr>
   </table> 
</section> <!-- /.viz-savings-wrap -->

<section id="drawdown-viz-wrap" class="interactive-chart-container viz-container">

	<div class="graph-tooltip">
        <article class="viz-figure-col-container-header">At Age <span id="current-selected-age">89</span></article>
        
	 	<article class="viz-legend-group viz-figure-income-group">
			<div class="drawdown-graph-num-col viz-likely-income-group">
				<div class="graph-col-fig col-1">
					<span class="dollar">$</span>
					<span id="likely_income">4,000</span>
				</div>
		 		<div class="graph-col-txt label-padding col-2">Yearly Income</div>
		 	</div>
            
		</article>
		<article class="viz-legend-group viz-figure-savings-group">
			<div class="drawdown-graph-num-col viz-likely-savings-group">
				<div class="graph-col-fig col-1">
					<span class="dollar">$</span><span id="likely_savings">80,000</span>
				</div>
		 		<div class="graph-col-txt label-padding col-2">Savings Remaining</div>
			</div>		 	
		 </article> 
		 <article class="viz-legend-group viz-figure-alive-group">
		 	<div class="drawdown-graph-num-col viz-alive-group">
				<div class="graph-col-fig col-1">
					<span class="pct"></span>
				</div>
				<div class="graph-col-txt label-padding col-2">% Chance that you are alive</div>
			</div>
		</article>
    </div>
	<!-- Graph Column -->
	<section class="viz-graph-col col-1">
	<!--	<h3 class="viz-graph-h viz-graph-h-options">If You <span id="dd_selected_option_name">Draw a Set Amount</span>: <span id="year-income-heading">3,500</span> <span class="viz-graph-sub-h">Adjusted to keep pace with inflation</span></h3>-->
		
            <section class="viz-graph-header">
             <article class="col-1">

                <h3 class="viz-graph-h viz-graph-h-dash">Estimated Yearly Income: 
                  <?php if ($pi->post_name == 'consider-your-options') { ?>
                     <span id="selected_option_title">Draw $<span id="selected-option-title-amount">3,500</span> from Savings</span>
                  <?php } else { ?>
                     From Savings
                  <?php } ?>
                </h3>
                  <h3 class="viz-graph-h3 badly"><input type="checkbox" name="things_go_badly" id="things_go_badly" value="badly" /><div class="info-box tip-trigger text-badly">If Things go Badly<div class="tooltip"><?= get_editable_furniture(7352); ?></div></div></h3>

             </article>   
             <article class="col-2">   
             <?php if ($pi->post_name == 'consider-your-options') { ?>
                  <div class="form-field-small-dollar viz-savings-field" style="display: none;">
                        <h4 class="form-label-small initial-savings-label">Initial Savings:</h4>
                        
                       
                        <h2 class="savings-page-2" id="savings_page_2">100,000</h2>
                        <input type="hidden" id="ret_savings" value="100000" step="100" min="100000" max="100000"/> 
                                       
                   </div> <!-- /.form-field -->
                <?php } else { ?>
                     <div class="form-field-small-dollar viz-savings-field">
                        <h4 class="form-label-small initial-savings-label">Income Goal:</h4>
                        <span class="initial-savings-dollar">$</span>
                       
                        <h2 class="savings-page-2" id="income_goal">12,000</h2>
                   
                        <input type="number" style="display: none;" id="ret_savings" value="100000" class="instant-save ret-savings" data-field="ret_savings" step="100" min="0" max="99000000"/> 
                    
                   </div> <!-- /.form-field -->
                   
                   
                   <div class="form-field-small-dollar viz-savings-field-cys ls-boolean-display" data-field="drawdown_cut_pct">
                        <h4 class="form-label-small initial-savings-label">If you cut <span class="pct ls-value" data-field="drawdown_cut_pct">0</span><span class="pct-symbol">%</span>: </h4>
                        <span class="initial-savings-dollar">$</span> 
                        <h2 class="savings-page-2 ls-value" id="drawdown_need_from_savings_cys">12,000</h2> 
                   </div> <!-- /.form-field -->
                <?php } ?>
                </article>
        </section>
		
		<section class="viz-income-wrap">
		
			<article class="income-graph-wrapper">
				
            <article class="viz-need-group" style="display:none;">
					<h3 class="need-label form-label"><span class="form-label-light">What You Need:</span> $<span id="what-you-need">4,000</span></h3>
					<div id="what_you_need_line">.</div>
				</article> <!-- /.viz-need-group -->

				<article class="viz-really-need-group" style="display:none;">
					<h3 class="really-need-label form-label"><span class="form-label-light"><em>Really</em> Need:</span> $<span id="really-need">3,000</span></h3>
					<div id="really_need_line">.</div>
				</article> <!-- /.viz-really-need-group -->
				<table class="drawdown-income-graph">
					<tr>
						<?php 
						for ($i=62; $i<=100; $i++) {
							echo '<td class="income-graph-bar" id="incomegraph-'.$i.'"><div class="yearly-income dd-bar">.</div><div class="yearly-income-badly dd-bar">.</div></td>';
						}
						?>
					</tr>
				</table>
			</article> <!-- /.income-graph-wrapper -->
		</section> <!-- /.viz-income-wrap -->
        
        	<section class="viz-age-wrap slider-input-container">

			<!-- Viz Age Slider -->
			<input type="range" min="65" max="100" id="age_projection" class="slider-input" value="89" class="instant-save"/> 
			<table class="age-tick-marks">
				<tr>
					<?php 
					for ($i=62; $i<=$max_age; $i++) {
						echo '<td class="age-tick-td" id="age-tick-'.$i.'"><div class="age-tick">';
						if ($i % 5 == 0) {
						   echo '<span class="age-tick-yrs-group"><span class="age-tick-yr">'.$i.'</span> <span class="age-tick-txt">yrs</span></span>';
						}
						echo '</div></td>';
					}
					?>
				</tr>
			</table>

		</section> <!-- /.viz-age-wrap -->
        
	</section> <!-- /.viz-graph-col -->

	<!-- Figure / Output Column -->
	<section class="viz-figure-col viz-figure-col-container col-2">
	 	
	 	
      <article class="viz-figure-col-container-header">At Age <span id="current-selected-age2">89</span></article>
        
	 	<article class="viz-legend-group viz-figure-income-group">
			<div class="drawdown-graph-num-col viz-likely-income-group">
		 		<div class="graph-col-fig col-1"><span class="dollar">$</span><span id="likely_income2">4,000</span></div>
		 		<div class="graph-col-txt lable-padding col-2">Yearly Income</div>
		 	</div>
            
            </article>
            <article class="viz-legend-group viz-figure-savings-group">
            	<div class="drawdown-graph-num-col viz-likely-savings-group">
		 		<div class="graph-col-fig col-1"><span class="dollar">$</span><span id="likely_savings2">80,000</span></div>
		 		<div class="graph-col-txt lable-padding col-2">Savings Remaining</div>
		 	</div>
		 	
		 </article> 
         
         <article class="drawdown-graph-num-col viz-odds-alive-group">
	 		<!--<div class="chances-figures"></div>-->
	 		<table class="figure-graph">
	 		   <tr>
	 		      <td class="male-stat-bar">
	 		         <div id="male_mask">.</div>
	 		         <div id="male_bar">.</div>
	 		      </td>
	 		      <td class="female-stat-bar">
	 		         <div id="female_mask">.</div>
	 		         <div id="female_bar">.</div>
	 		      </td>
	 		   </tr>
	 		</table>
	 		<!--
	 		<div class="alive-statistic">
	 		   <span id="alive-text">Chances of being alive:</span>
	 		   
	 		</div>
	 		-->
	 		<div class="graph-col-txt"><div class="info-box tip-trigger"><span id="alive-percentage">Even</span> <span class="alive-label">chance of being alive:</span><div class="tooltip"><?= get_editable_furniture(4931); ?></div></div>
	 			</div> <!-- /.graph-col-txt -->
	 	</article>
	</section> <!-- /.viz-figure-col -->
</section> <!-- /.drawdown-viz-wrap -->
