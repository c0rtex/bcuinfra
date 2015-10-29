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

<script type="text/javascript" src="<?php echo get_bloginfo('template_url'); ?>/js/planner-savings-as-a-source-of-retirement-income.js"></script>

<section class="drawdown-wrap with-viz">

<!-- ================================= --> 
<!-- ! Drawdown Visualization   	   --> 
<!-- ================================= -->

<?php 
$currpage = 2;
include('drawdown-graph.php'); ?>

<!-- ================================= --> 
<!-- ! Drawdown Options   	   		   --> 
<!-- ================================= -->

<section class="drawdown-option-section">
	<h3 class="drawdown-list-h">1. Live on the Interest</h3>
	<ul class="drawdown-option-list">
		<li class="drawdown-option-item interest-only-item">
			<div class="option-radio-wrap col-1">
				<input type="radio" name="drawdown_option" value="1" id="interest_only" class="option-list-radio-btn check-btn" />
			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="interest_only" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4899); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4899); ?></p>
				</label>
			</div>
		</li>
		<li class="drawdown-option-item interest-abv-item">
			<div class="option-radio-wrap col-1">
				<input type="radio" name="drawdown_option" value="2" id="interest_above_inflation" class="option-list-radio-btn check-btn" />
			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="interest_above_inflation" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4909); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4909); ?></p>
				</label>
			</div> <!-- /.option-description -->
		</li>
	</ul>
	
	<h3 class="drawdown-list-h">2. Draw an Income</h3>
	<ul class="drawdown-option-list">
		<li class="drawdown-option-item set-amt-item option-active">
			<div class="option-radio-wrap col-1">

				<input type="radio" name="drawdown_option" value="3" id="set_amount" class="option-list-radio-btn check-btn option-active" checked />

			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="set_amount" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4912); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4912); ?></p>
				</label>
				<fieldset class="form-field-large option-draw-amt-field option-fieldset">
					<label class="option-form-label">How Much Will You Draw?</label>
					<select id="set_amount_dollar" class="select-input-large">
						<option value="3500">$3,500</option>
						<option value="4000">$4,000</option>
						<option value="4500">$4,500</option>
						<option value="5000">$5,000</option>
						<option value="5500">$5,500</option>
						<option value="6000">$6,000</option>
					</select>
				</fieldset> <!-- /.option-draw-set-field -->
			</div> <!-- /.option-description -->
		</li>
		<li class="drawdown-option-item set-pct-item">
			<div class="option-radio-wrap col-1">
				<input type="radio" name="drawdown_option" value="4" id="set_percent" class="option-list-radio-btn check-btn" />
			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="set_percent" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4914); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4914); ?></p>
				</label>
				<fieldset class="form-field-large option-draw-pct-field option-fieldset">
					<label class="option-form-label">How Much Will You Draw?</label>
					<select id="set_percentage" class="select-input-large">
							<option value="3">3.0%</option>
							<option value="3.5">3.5%</option>
							<option value="4">4.0%</option>
							<option value="4.5">4.5%</option>
							<option value="5">5.0%</option>
							<option value="5.5">5.5%</option>
							<option value="6">6.0%</option>
					</select>
				</fieldset>
			</div> <!-- /.option-description -->
		</li>
		<li class="drawdown-option-item rqd-item">
			<div class="option-radio-wrap col-1">
				<input type="radio" name="drawdown_option" value="5" id="rmd" class="option-list-radio-btn check-btn" />
			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="rmd" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4917); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4917); ?></p>
				</label>
			</div> <!-- /.option-description -->
		</li>
	</ul>
	
	<h3 class="drawdown-list-h">3. Buy an Annuity</h3>
	<ul class="drawdown-option-list">
		<li class="drawdown-option-item annuity-item">
			<div class="option-radio-wrap col-1">
				<input type="radio" name="drawdown_option" value="6" id="inflation_protected_annuity" class="option-list-radio-btn check-btn" />
			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="inflation_protected_annuity" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4919); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4919); ?></p>
				</label>
			</div> <!-- /.option-description -->
		</li>
		<li class="drawdown-option-item delay-ss-item">
			<div class="option-radio-wrap col-1">
				<input type="radio" name="drawdown_option" value="7" id="delay_claiming" class="option-list-radio-btn check-btn" />
			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="delay_claiming" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4921); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4921); ?></p>
				</label>
			</div> <!-- /.option-description -->
		</li>
		<li class="drawdown-option-item alda-item">
			<div class="option-radio-wrap col-1">
				<input type="radio" name="drawdown_option" value="8" id="alda" class="option-list-radio-btn check-btn" />
			</div> <!-- /.option-list-radio-btn-wrap -->
			<div class="option-description col-2">
				<label for="alda" class="option-label">
					<h4 class="option-label-h"><?= get_editable_title(4923); ?></h4>
					<p class="option-txt"><?= get_editable_furniture(4923); ?></p>
				</label>
			</div> <!-- /.option-description -->
		</li>
	</ul>
</section>

</section> <!-- /.drawdown-wrap -->
