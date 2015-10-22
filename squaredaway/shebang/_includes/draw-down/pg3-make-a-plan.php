<?php
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_age_odds').'</div>';

echo '<div class="hidden">'.shebang_get_json_payload('drawdown_interest_only_factors').'</div>';

echo '<div class="hidden">'.shebang_get_json_payload('drawdown_dollar_3500').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_dollar_4000').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_dollar_4500').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_dollar_5000').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_dollar_5500').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_dollar_6000').'</div>';

echo '<div class="hidden">'.shebang_get_json_payload('drawdown_factors_3').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_factors_3_5').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_factors_4').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_factors_4_5').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_factors_5').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_factors_5_5').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_factors_6').'</div>';

echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_62').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_63').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_64').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_65').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_66').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_67').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_68').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_69').'</div>';
echo '<div class="hidden">'.shebang_get_json_payload('drawdown_rmd_70').'</div>';

echo '<div class="hidden">'.shebang_get_json_payload('drawdown_inflation_protected_annuity').'</div>';

echo '<div class="hidden">'.shebang_get_json_payload('drawdown_delay_claiming').'</div>';

echo '<div class="hidden">'.shebang_get_json_payload('drawdown_alda').'</div>';
?>

<input type="hidden" value="65" id="retirement_age" />
<input type="hidden" value="3" id="marital_status_gender" />

<section class="drawdown-wrap with-viz">

<!-- ================================= --> 
<!-- ! Drawdown Visualization   	   --> 
<!-- ================================= -->

<?php 
$currpage = 3;
include('drawdown-graph.php'); ?>

<!-- ================================= --> 
<!-- ! Drawdown Dashboard   	   	   --> 
<!-- ================================= -->

<section class="drawdown-option-table">
	<table class="option-table">
		<thead>
        <tr class="total-row">
				<td class="option-name">
					<h3 class="option-name-h">Total</h3>
					<div id="exceed-notice" class="dd-flag">
						<p class="dd-flag-txt">You've used more than you have in savings!</p>
					</div> <!-- /.exceed-notice -->
				</td>
				<td class="option-slider">
					<p class="total-pct-group"><span id="total_pct" class="total-pct">100</span> <span class="total-pct-label">% of savings used</span></p>	
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="total_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">&nbsp;
					<span class="total-pct-label">of </span><span class="dollar">$</span><span id="initial_savings">100000</span>
				</td>
				
			</tr>
			
		</thead>	
        </table>	
<table class="option-table">
		<tbody>
   
			<tr class="int-abv-row">
				<td class="option-name">
					<h3 class="option-name-h">Live on the Interest Above Inflation</h3>
                        <div class="slider-control-container">
                        <button class="sliderUp"></button>
                        <button class="sliderDown"></button>
                        </div>
				</td>
				<td class="option-slider">
					<div class="slider-input-container">
						<input type="range" min="0" max="100000" id="interest_above_inflation_slider" class="slider-input instant-save ls-value" value="0" step="1000" data-action-plan-name="Living on the Interest Above Inflation"/> 
					</div>
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="interest_above_inflation_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">&nbsp;
					
				</td>
			
			</tr>
			<tr class="set-amt-row">
				<td class="option-name">
					<h3 class="option-name-h">Draw a Set Amount</h3>
                        <div class="slider-control-container">
                        <button class="sliderUp"></button>
                        <button class="sliderDown"></button>
                        </div>

				</td>
				<td class="option-slider">
					<div class="slider-input-container">
						<input type="range" min="0" max="100000" id="set_amount_slider" class="slider-input instant-save ls-value" value="0" step="1000" data-action-plan-name="Drawing a Set Amount"/> 
					</div>
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="set_amount_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">
					<div class="input-offset"><fieldset class="form-field-tiny set-amt-fieldset">
						<select id="set_amount_dollar_plan" class="select-input-tiny ls-value instant-save" name="set_amount_dollar_plan">
							<option value="3500">$3,500</option>
							<option value="4000">$4,000</option>
							<option value="4500" selected>$4,500</option>
							<option value="5000">$5,000</option>
							<option value="5500">$5,500</option>
							<option value="6000">$6,000</option>
						</select>
						<label class="field-mod-txt" for="set_amount_dollar_plan"><?= get_post_title(4925); ?></label> 
					</fieldset> <!-- .set-amt-fieldset -->
                    </div>
				</td>
				
			</tr>
			<tr class="set-pct-row">
				<td class="option-name">
					<div class="input-offset"><h3 class="option-name-h">Draw a Set Percentage</h3></div>
                    <div class="slider-control-container">
                        <button class="sliderUp"></button>
                        <button class="sliderDown"></button>
                        </div>
					
	
				</td>
				<td class="option-slider">
					<div class="slider-input-container">
						<input type="range" min="0" max="100000" id="set_percent_slider" class="slider-input ls-value instant-save" value="0" step="1000" data-action-plan-name="Drawing a Set Percentage"/> 
					</div>
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="set_percent_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">
                <div class="input-offset">
                <fieldset class="form-field-tiny set-pct-fieldset">		
							<select id="set_percentage_plan" class="select-input-tiny" name="set_percentage_plan">
								<option value="3">3.0%</option>
								<option value="3.5">3.5%</option>
								<option value="4">4.0%</option>
								<option value="4.5">4.5%</option>
								<option value="5">5.0%</option>
								<option value="5.5">5.5%</option>
								<option value="6">6.0%</option>
						</select>
						<label class="field-mod-txt" for="set_percentage_plan">of your savings at this time</label>
					</fieldset> <!-- .set-pct-fieldset -->
					</div>
				</td>
			</tr>
			<tr class="rqd-row">
				<td class="option-name">
					<h3 class="option-name-h">Draw the Required Minimum Distribution</h3>
                    <div class="slider-control-container">
                        <button class="sliderUp"></button>
                        <button class="sliderDown"></button>
                        </div>
				</td>
				<td class="option-slider">
					<div class="slider-input-container">
						<input type="range" min="0" max="100000" id="rmd_slider" class="slider-input instant-save" value="0" step="1000" data-action-plan-name="Drawing the Required Minimum Distribution"/> 
					</div>
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="rmd_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">&nbsp;
					
				</td>
			
			</tr>
			<tr class="annuity-row">
				<td class="option-name">
					<h3 class="option-name-h">Buy an Inflation-Proof Annuity</h3>
                    <div class="slider-control-container">
                        <button class="sliderUp"></button>
                        <button class="sliderDown"></button>
                        </div>
				</td>
				<td class="option-slider">
					<div class="slider-input-container">
						<input type="range" min="0" max="100000" id="inflation_proof_annuity_slider" class="slider-input instant-save ls-value" value="0" step="1000" data-action-plan-name="Buying an Inflation-Proof Annuity" /> 
					</div>
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="inflation_proof_annuity_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">&nbsp;
					
				</td>
				
			</tr>
			<tr class="delay-ss-row">
				<td class="option-name">
					<h3 class="option-name-h">Delay Claiming Social Security</h3>
                    <div class="slider-control-container">
                        <button class="sliderUp"></button>
                        <button class="sliderDown"></button>
                        </div>
	<!-- 				<input type="checkbox" name="delay_claiming_selected" id="delay_claiming_selected" value="0" /> Select this option -->
				</td>
				<td class="option-slider">
					<div class="slider-input-container">
						<input type="range" min="0" max="100000" id="delay_claiming_slider" class="slider-input instant-save ls-value" value="0" step="1000" data-action-plan-name="Using Savings to Delay your Claim on Social Security"/> 
					</div>
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="delay_claiming_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">&nbsp;
					
				</td>
			
			</tr>
			<tr class="annuity-85-row">
				<td class="option-name">
					<h3 class="option-name-h">Buy an Annuity Beginning at Age 85</h3>
                    <div class="slider-control-container">
                        <button class="sliderUp"></button>
                        <button class="sliderDown"></button>
                        </div>
				</td>
				<td class="option-slider">
					<div class="slider-input-container">
						<input type="range" min="0" max="100000" id="alda_slider" class="slider-input instant-save ls-value" value="0" step="1000" data-action-plan-name="Buying an Annuity Beginning at Age 85"/> 
					</div>
				</td>
				<td class="option-slider-amount option-fig">
					<span class="dollar">$</span><span id="alda_amount">0</span>
				</td>
				<td class="option-initial-savings option-fig">&nbsp;
					
				</td>
				
			</tr>
			
		</tbody>
	</table>
		
</section> <!-- /.drawdown-option-table -->

<!-- ================================= --> 
<!-- ! What Next   	   	   			   --> 
<!-- ================================= -->

<section class="what-next-group">

<div class="frame-title-container"><p class="frame-title">What To Do Next &hellip;</p></div>
	<ul class="what-next-list">
		<li class="what-next-item"><h2 class="what-next-h">If You Don't Have Enough: <a href="my-action-plan#options-if-you-dont-have-enough">Learn About Your Options &raquo;</a> </li>
		<li class="what-next-item"><h2 class="what-next-h">If You Have a Plan That Works: <a href="my-action-plan">Go To Your Action Plan &raquo;</a> </li>
	</ul>
</section> <!-- /.what-next-group -->

</section> <!-- /.drawdown-wrap -->