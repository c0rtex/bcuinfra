<?php
	$max_age = 100;
	$pi = get_post_info();
?>
<section id="drawdown-viz-wrap" class="interactive-chart-container viz-container">

	<!-- Info Input Column -->
	<section class="viz-info-col col-1">
		<h3 class="form-label your-info-label">Your Information:</h3>

		<div class="form-field-small-dollar viz-savings-field">
			<h4 class="form-label-small">Savings:</h4>
			<span class="dollar">$</span>
			<?php if ($pi->post_name == 'consider-your-options') { ?>
				<h2 class="savings-page-2" id="savings_page_2">100,000</h2>
				<input type="hidden" id="ret_savings" value="100000" step="100" min="100000" max="100000"/> 
			<?php } else { ?>
				<input type="number" id="ret_savings" value="100000" class="instant-save ret-savings" data-field="ret_savings" step="100" min="0" max="99000000"/> 
			<?php } ?>
		</div> <!-- /.form-field -->
		
		<div class="form-field-small viz-retire-age-field">
			<label class="retire-age-label col-1 info-box-before tip-trigger">Retire At:
			<div class="tooltip"><?= get_editable_furniture(5042); ?></div></label>
			<!--<input type="number" id="retirement_age" value="65" data-field="retirement_age" class="instant-save retirement_age col-2" step="1" min="62" max="70"/> -->
			<select id="retirement_age" data-field="retirement_age" class="select-input-small instant-save retirement_age col-2">
				<option value="62">62</option>
				<option value="63">63</option>
				<option value="64">64</option>
				<option value="65" selected="selected">65</option>
				<option value="66">66</option>
				<option value="67">67</option>
				<option value="68">68</option>
				<option value="69">69</option>
				<option value="70">70</option>
			</select>
		</div>
		
		<div class="form-field-small viz-marital-status-field">
			<select id="marital_status_gender" class="select-input-small instant-save marital-status-select" data-field="marital_status_gender">
				<option value="0">Single, Male</option>
				<option value="1">Single, Female</option>
				<option value="3" selected="selected">Married</option>
			</select>
		</div>
	</section> <!-- /.viz-info-column -->
	
	<!-- Graph Column -->
	<section class="viz-graph-col col-2">
		<h3 class="viz-graph-h viz-graph-h-options">If You <span id="dd_selected_option_name">Draw a Set Amount</span>: <span id="year-income-heading">3,500</span> <span class="viz-graph-sub-h">Adjusted to keep pace with inflation</span></h3>
		<h3 class="viz-graph-h viz-graph-h-dash">Income &amp; Savings Over Time</h3>

		<section class="viz-age-wrap slider-input-container">

			<!-- Viz Age Slider -->
			<input type="range" min="65" max="100" id="age_projection" class="slider-input" value="89" class="instant-save"/> 
			<table class="age-tick-marks">
				<tr>
					<?php 
					for ($i=62; $i<=$max_age; $i++) {
						echo '<td class="age-tick-td" id="age-tick-'.$i.'"><div class="age-tick"><span class="age-tick-yrs-group"><span class="age-tick-yr">'.$i.'</span> <span class="age-tick-txt">yrs</span></span></div></td>';
					}
					?>
				</tr>
			</table>

			<!-- Viz Age Selector-->
			<article id="viz-age-selector" class="viz-age-selector">
				<div class="viz-age-thumb current-selected-age">89</div>
				<div class="viz-age-selector-bar"></div>
			</article> <!-- /#viz-age-selector -->

		</section> <!-- /.viz-age-wrap -->
		
		<section class="viz-savings-wrap">
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

		<section class="viz-income-wrap">
			<h3 class="viz-graph-h3">Yearly Income</h3>
			<article class="income-graph-wrapper">
				<article class="viz-need-group">
					<h3 class="need-label form-label"><span class="form-label-light">What You Need:</span> $<span id="what-you-need">4,000</span></h3>
					<div id="what_you_need_line">.</div>
				</article> <!-- /.viz-need-group -->

				<article class="viz-really-need-group">
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
	</section> <!-- /.viz-graph-col -->

	<!-- Figure / Output Column -->
	<section class="viz-figure-col col-3">
	 	<article class="drawdown-graph-num-col viz-odds-alive-group">
	 		<div class="graph-col-fig col-1"><span id="odds_alive" class="odds-alive">64.5%</span></div>
	 		<div class="graph-col-txt col-2"><div class="info-box tip-trigger">Chances of being alive at age <span id="current-selected-age">89</span><div class="tooltip"><?= get_editable_furniture(4931); ?></div></div>
	 			</div> <!-- /.graph-col-txt -->
	 	</article>
	 	<article class="viz-legend-group viz-figure-savings-group">
			<div class="drawdown-graph-num-col viz-likely-savings-group">
		 		<div class="graph-col-fig col-1"><span class="dollar">$</span><span id="likely_savings">80,000</span></div>
		 		<div class="graph-col-txt col-2">Likely Savings</div>
		 	</div>
		 	<div class="drawdown-graph-num-col viz-bad-savings-group">
		 		<div class="graph-col-fig col-1"><span class="dollar">$</span><span id="bad_case_savings">80,000</span></div>
		 		<div class="graph-col-txt col-2">If Things Go Badly</div>
		 	</div>
	 	</article>
	 	<article class="viz-legend-group viz-figure-income-group">
			<div class="drawdown-graph-num-col viz-likely-income-group">
		 		<div class="graph-col-fig col-1"><span class="dollar">$</span><span id="likely_income">4,000</span></div>
		 		<div class="graph-col-txt col-2">Likely Income</div>
		 	</div>
		 	<div class="drawdown-graph-num-col viz-bad-income-group">
		 		<div class="graph-col-fig col-1"><span class="dollar">$</span><span id="bad_case_income">4,000</span></div>
		 		<div class="graph-col-txt col-2">If Things Go Badly</div>
		 	</div>
		 </article> 
	</section> <!-- /.viz-figure-col -->
</section> <!-- /.drawdown-viz-wrap -->
