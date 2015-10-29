<?php
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/shebang-ssa.js"></script>';
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/planner-target-target.js?r='.rand(0, 500).'"></script>';
	echo '<script type="text/javascript" src="'.get_bloginfo('template_url').'/js/planner-target-generic.js?r='.rand(0, 500).'"></script>';
	include_once('fields-target.php');
?>

<section class="three-things-box interactive-box">
	<div class="three-things-container interactive-container">

		<section class="col-1 effect-container">
		
			<!-- Control Your Spending -->
			<article class="effect-group cys-group">
				<h3 class="effect-header">Control Your Spending & Save More</h3>
				<input id="effect-spendless-amt" value="0" type="hidden" class="ls-value" data-field="effect-spendless-amt" />
				<div class="effect-text">
					<p><?php echo get_editable_furniture(397); ?></p>
					<p><em>What happens if you save 5 percent more?</em></p>
				</div> <!-- /.effect-text -->
				<div class="effect-btn-container">
					<a href="#" class="trigger-spending effect-button">See the effect</a>
				</div>
			</article>
			
			<!-- Work Longer -->
			<article class="effect-group work-longer-group">
				<h3 class="effect-header">Work Longer</h3>
				<input id="effect-retire-age" value="62" type="hidden" class="ls-value" data-field="effect-retire-age" />
				<div class="effect-text">
					<p>If you work to age 70, the latest age you can claim a higher Social Security benefit, you can often double the income you'd get if you retire at 62.</p>
					<p><em>What happens if you retire at 70?</em></p>
				</div> <!-- /.effect-text -->
				<div class="effect-btn-container">
					<a href="#" class="trigger-work-longer effect-button">See the effect</a>
				</div>
			</article>
			
			<!-- Use Your House -->
			<article class="effect-group house-group">
				<h3 class="effect-header info-box tip-trigger">Use Your House
					<div class="tooltip"><?php echo get_editable_furniture(347); ?></div></h3>
				<div class="effect-text">
					<p><?php echo get_editable_furniture(394); ?></p>
					<p><em>What happens if you downsize at retirement?</em></p>
				</div> <!-- /.effect-text -->
				<div class="effect-btn-container">
					<a href="#" class="trigger-use-your-house effect-button">See the effect</a>
				</div>
			</article>

			<!-- Make a Plan button -->			
			<a href="<?php $np = get_next_slide(); echo $np->permalink ?>" class="make-plan-btn">Make a Plan<span class="make-plan-arrow">&rsaquo;</span></a>

		</section> <!-- /.col-1 .effect-container -->

		<section id="short-output" class="col-2 output">
			<div class="graph-overall-container">
				<h2 class="graph-header info-box tip-trigger">Retirement Income <span class="form-label-light">at Age 62</span><div class="tooltip"><?php echo get_editable_furniture('mi-target-ret-income-at-62'); ?></div></h2>
				<?php
					include('graph-target.php');
				?>
				
				<div class="graph-overlay-group">
					<article id="house-overlay" class="graph-overlay">
						<p class="graph-overlay-txt"><?php echo get_editable_furniture(345); ?></p>
					</article>
	
					<article id="work-overlay" class="graph-overlay">
						<p class="graph-overlay-txt"><?php echo get_editable_furniture(343); ?></p>
					</article>
	
					<article id="control-overlay" class="graph-overlay">
						<p class="graph-overlay-txt"><?php echo get_editable_furniture(341); ?></p>
					</article>
				</div> <!-- /.graph-overlay-group -->
					
				<small class="estimate-note">
					<?php echo get_editable_furniture(259); ?>
				</small>
			
			</div> <!-- /.graph-overall-container -->
		</section> <!-- /.col-2 .output -->
	</section> <!-- /.three-things-box -->