<?php
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/shebang-ssa.js"></script>';
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/planner-target-target.js?r='.rand(0, 500).'"></script>';
	include_once('fields-target.php');
?>

<section class="target-main-box interactive-box">
	<div class="target-main-container interactive-container">

		<form id="target-main-form" class="col-1 target-main-container">

		<!-- DS: Carrying over pension data -->
		<!-- Now reading this from local storage
		<input type="hidden" id="pension_benefit_self" data-field="pension_benefit_self" class="instant-save pension-benefit field-self ls-value" value="0" />
		<input type="hidden" id="pension_benefit_spouse" data-field="pension_benefit_spouse" class="instant-save pension-benefit field-spouse ls-value" value="0" />
		-->
			<!-- Control Your Spending Fieldset -->
			<fieldset class="cys-fieldset effect-group">
				<h3 class="effect-header info-box tip-trigger">Control Your Spending & Save More
				<div class="tooltip">
					<?php echo get_editable_furniture(6582);?>
				</div>
				</h3>
				<p class="effect-subheader">How Much Less Would You Spend Each Month?</p>
				<div class="col-1 form-field-large-dollar">
					<span class="dollar">$</span>
					<input id="effect-spendless-amt" type="number" value="0" step="25" min="0" class="ls-value" data-group="effect-spend-less" data-field="effect-spendless-amt"/>
				</div> <!-- /.col-1 -->
				<div class="col-2 spendless-slider-group">
					<input id="effect-spendless-pct" class=" effect-spendless-slider slider-input ls-value" type="range" name="spendless-slider" min="0" max="12" value="0" data-group="effect-spend-less" data-field="effect-spendless-pct" />
				</div> <!-- /.spendless-slider-group -->
			</fieldset> <!-- /.cys-fieldset -->


			<!-- Work Longer Fieldset -->
			<fieldset class="work-longer-fieldset effect-group">
				<h3 class="effect-header info-box tip-trigger">Work Longer
					<div class="tooltip">
						<?php echo get_editable_furniture(6584); ?>
					</div>
				</h3>
				<p class="effect-subheader">Retire at Age:</p>

				<div class="col-1 form-field-large">
					<input id="effect-retire-age" type="number" class="slider-group ls-value" data-group="effect-ret-age" data-field="retirement_age" value="62" min="62" max="70" />
				</div> <!-- /.col-1 -->

				<div class="col-2 retire-age-slider-group">
					<input id="effect-retire-age-slider" class="effect-retire-age-slider slider-input slider-group ls-value" data-group="effect-ret-age" type="range" name="retireage" min="62" max="70" value="62" data-field="retirement_age"/>
				</div> <!-- /.col-2 -->
			</fieldset> <!-- /.work-longer-fieldset -->


			<!-- Use Your House Fieldset -->
			<fieldset class="house-fieldset effect-group">
				<h3 class="effect-header tip-trigger info-box">Use Your House at Retirement
					<div class="tooltip">
						<?php echo get_editable_furniture(6586); ?>
					</div>
				</h3>
				<p class="effect-subheader">Go to Advanced to Enter Your Information</p>
				<ul class="effect-house-list">

					<li class="effect-house-item">
						<input id="downsize-house" class="effect-house-checkbox tip-trigger ls-value" type="checkbox" name="usehouse" value="downsize" data-field="downsize-house" />
						<label class="effect-house-label tip-trigger" for="downsize-house">Downsize
						<div class="tooltip"><?php echo get_editable_furniture(6588); ?></div></label></li>

					<li class="effect-house-item">
						<input id="reverse-mortgage" class="effect-house-checkbox ls-value" type="checkbox" name="reversemortgage" value="revmortgage" data-field="reverse-mortgage" />
						<label class="effect-house-label tip-trigger" for="reverse-mortgage">Get a Reverse Mortgage
						<div class="tooltip"><?php echo get_editable_furniture(369); ?></div></label></li>

				</ul> <!-- effect-house-list -->

				<article id="effect-house-advanced" class="effect-house-advanced hidden-advanced">
					<fieldset class="current-home-val-group">
						<div class="form-field-med-dollar">
							<span class="dollar">$</span>
							<p class="form-label-small">Current Home Value</p>
							<input id="home_val" type="number" name="current-home-val" value="175000" data-field="home_val" class="ls-value" step="2500"/>
						</div>
					</fieldset>

					<fieldset class="downsized-home-group">
						<div class="form-field-med-dollar">
							<span class="dollar">$</span>
							<p class="form-label-small">Downsized Home Value</p>
							<input id="home_val_new" type="number" name="home_val_new" data-field="home_val_new" value="125000" class="ls-value" step="2500"/>
						</div>
					</fieldset>

					<fieldset class="overall-savings-group">
						<div class="form-field-med-dollar">
							<span class="dollar">$</span>
							<p class="form-label-small">Cut in Utilities, Insurance, Upkeep, and Taxes</p>
							<input id="downsizing_savings_other" type="number" class="ls-value" name="house-overall-savings" data-field="downsizing_savings_other" value="150" step="10" />
							<span class="month">/month</span>
						</div>
					</fieldset>
				</article> <!-- /#effect-house-advanced -->


			</fieldset> <!-- /.house-fieldset -->


			<!-- Risks Fieldset -->
			<fieldset class="risks-fieldset effect-group">
				<h3 class="effect-header">Risks to Consider</h3>
				<p class="effect-subheader">See What Would Happen If...</p>
				<ul class="effect-risk-list">
					<li class="effect-risk-item" id="spouse-dies-wrapper"><input id="spouse-dies" class="effect-risk-checkbox target-death ls-value"  type="checkbox" name="risks" value="death-spouse" data-field="spouse-dies" /> <label class="effect-risk-label tip-trigger info-box" for="spouse-dies">Spouse Dies<div class="tooltip">See Explanations</div></label></li>

					<li class="effect-risk-item" id="market-tanks-wrapper"><input id="market-tanks" class="effect-risk-checkbox ls-value" type="checkbox" name="risks" value="markettanks" data-field="market-tanks" /> <label class="effect-risk-label" for="market-tanks">Market Tanks</label></li>

					<li class="effect-risk-item" id="you-die-wrapper"><input id="you-die" class="effect-risk-checkbox target-death ls-value" type="checkbox" name="risks" value="death-self" data-field="you-die"  /> <label class="effect-risk-label tip-trigger  info-box" for="you-die">You Die<div class="tooltip">See Explanations</div></label></li>

				</ul> <!-- /.effect-risk-list -->
			</fieldset> <!-- /.risks-fieldset -->

			<!-- Advanced button -->
			<div class="advanced-btn-container">

				<a href="#" id="target-main-trigger" class="advanced-btn trigger-advanced">Advanced<span class="advanced-arrow">&rsaquo;</span></a>

				<a class="make-plan-btn" href="<?php $np = get_next_slide(); echo $np->permalink ?>">Finished<span class="make-plan-arrow">&rsaquo;</span></a>

			</div> <!-- /.advanced-container -->

		</form> <!-- /.#target-main-form -->

		<section id="short-output" class="col-2 output">
			<div class="graph-overall-container">
				<h2 class="graph-header">Retirement Income</h2>
				<?php
					include('graph-target.php');
				?>
				<small class="estimate-note">
					<?php echo get_editable_furniture(259); ?>
				</small>
			</div> <!-- /.graph-overall-container -->
		</section> <!-- /.col-2 .output -->

	</div> <!-- interactive-box -->
</section> <!-- interactive-container -->


	<!-- ================================= -->
	<!-- ! Congratulations! Modal   -->
	<!-- ================================= -->

	<div id="target-success-modal" class="modal">
		<h3 class="modal-header">Nice work!</h3>
		<p class="modal-msg">It looks like you've found enough savings to reach your goal. Now go ahead to your Action Plan &mdash; or keep finding more ways to save.</p>
		<ul class="modal-next-btns">
			<li class="col-1"><?php
				echo '<a class="modal-next-btn" href="'.get_next_slide()->permalink.'">';
			?>
			Take Action<span class="next-arrow">&rsaquo;</span></a></li>
			<li class="col-2"><a class="modal-back-btn close-modal">Modify Plan</a></li>
		</ul>
	</div> <!-- /.cut-spending-modal -->
