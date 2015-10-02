<?PHP

//TBD - Need to move DB connections to DB help functions
$bcudb = new wpdb('esidtc','W6ApuXec','esidtc','172.31.33.35');
$bcudb->show_errors();

set_include_path("http://esidtc.benefitscheckup.org/wp-content/themes/shebang/js/");
?>

<div class="span8" id="printContent">  
	<section id="calculators"> 
    	<div class="body-header-wrapper">	<h2><i class="icon-table "></i>  Calculators </h2>	
			<div class="body-header" style="z-index: 999;">
            	<div class="body-header-inner">
                	<div class="">
                        
                  	</div>
            	</div>
          	</div>
     		<div></div>
     	</div>
       	<div class="">
         	<div action="" method="get" id="commentForm" class="well cmxform">
                <section
class="tool-page-square-group col-1"><div
class="qs-sort-container"></div><div
class="topic-sort-all qs-sorter home-sort-hidden"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/should-you-refinance" data-id="3236" data-status="publish" data-issue-everyday-money="1"  data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/redcalculatorhouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To 1) cut your payment, 2) pay it off faster, 3) get cash, or 4) switch to a fixed or adjustable rate loan.</p></div><h3 class="square-tease-h">Figure Out "If You Refinance ..."</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/stocks-or-bonds" data-id="7958" data-status="publish" data-issue-investing-2="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/safetycone.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>See how much your savings might grow in average, good, and bad times.</p></div><h3 class="square-tease-h">Figure Out "Stocks or Bonds?"</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/build-a-better-tomorrow" data-id="6433" data-status="publish" data-issue-investing-2="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/buildabettertomorrow.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Build a plan to get where you want to go.</p></div><h3 class="square-tease-h">Figure Out a Better Tomorrow</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/make-a-budget-in-3-min" data-id="6234" data-status="publish" data-issue-everyday-money="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/wallet3.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Know where your money goes, to spend smarter and live within your means.</p></div><h3 class="square-tease-h">Figure Out a Budget in 3 Minutes</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/a-reserve-for-unemployment" data-id="954" data-status="publish" data-issue-everyday-money="1"  data-issue-reserves-insurance="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/investments-debt.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To protect yourself you need a reserve, usually about 2-4 months’ pay.</p></div><h3 class="square-tease-h">Figure Out a Reserve for Unemployment</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/target-your-retirement" data-id="170" data-status="publish" data-issue-investing-2="1"  data-issue-retirement="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Retirement planner if you're approaching retirement.</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if 50 or over)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/figure-out-a-retirement-plan-for-those-under-50" data-id="9384" data-status="publish"><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>How much to save &amp; how much you'll need in 10 years to be "on-track"</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if under 50)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/move-or-stay-put" data-id="6376" data-status="publish" data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/movehouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>It changes what you own, what you owe, &amp; your monthly expenses.</p></div><h3 class="square-tease-h">Figure Out How Moving Changes Your Finances</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/how-much-life-insurance" data-id="6729" data-status="publish" data-issue-reserves-insurance="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/insurance-alt.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get a personal estimate in 6 minutes or less.</p></div><h3 class="square-tease-h">Figure Out How Much Life Insurance You Need</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/savings-as-a-source-of-retirement-income" data-id="3340" data-status="publish" data-issue-everyday-money="1"  data-issue-retirement="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/annuities2.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get what you need, without out-living your savings.</p></div><h3 class="square-tease-h">Figure Out How to Get Income from Retirement Savings</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/figure-out-how-to-pay-down-debt" data-id="10014" data-status="publish"><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/wallet3.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>See how quickly you could be out from under.</p></div><h3 class="square-tease-h">Figure Out How to Pay Off Credit Card Debt</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/control-your-spending" data-id="107" data-status="publish" data-issue-everyday-money="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/purse1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Small changes can have a big impact.</p></div><h3 class="square-tease-h">Figure Out Where to Cut Spending</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/mortgage-analyzer" data-id="729" data-status="publish" data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/house-calculator.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Eight in 10 Americans choose a 30-year fixed-rate mortgage. Should you?</p></div><h3 class="square-tease-h">Figure Out Your Best Mortgage</h3></a></div><div
class="topic-sort-retirement home-sort-hidden qs-sorter"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/target-your-retirement" data-id="170" data-status="publish" data-issue-investing-2="1"  data-issue-retirement="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Retirement planner if you're approaching retirement.</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if 50 or over)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/figure-out-a-retirement-plan-for-those-under-50" data-id="9384" data-status="publish"><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>How much to save &amp; how much you'll need in 10 years to be "on-track"</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if under 50)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/savings-as-a-source-of-retirement-income" data-id="3340" data-status="publish" data-issue-everyday-money="1"  data-issue-retirement="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/annuities2.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get what you need, without out-living your savings.</p></div><h3 class="square-tease-h">Figure Out How to Get Income from Retirement Savings</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/how-much-life-insurance" data-id="6729" data-status="publish" data-issue-reserves-insurance="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/insurance-alt.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get a personal estimate in 6 minutes or less.</p></div><h3 class="square-tease-h">Figure Out How Much Life Insurance You Need</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/control-your-spending" data-id="107" data-status="publish" data-issue-everyday-money="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/purse1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Small changes can have a big impact.</p></div><h3 class="square-tease-h">Figure Out Where to Cut Spending</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/stocks-or-bonds" data-id="7958" data-status="publish" data-issue-investing-2="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/safetycone.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>See how much your savings might grow in average, good, and bad times.</p></div><h3 class="square-tease-h">Figure Out "Stocks or Bonds?"</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/make-a-budget-in-3-min" data-id="6234" data-status="publish" data-issue-everyday-money="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/wallet3.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Know where your money goes, to spend smarter and live within your means.</p></div><h3 class="square-tease-h">Figure Out a Budget in 3 Minutes</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/mortgage-analyzer" data-id="729" data-status="publish" data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/house-calculator.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Eight in 10 Americans choose a 30-year fixed-rate mortgage. Should you?</p></div><h3 class="square-tease-h">Figure Out Your Best Mortgage</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/should-you-refinance" data-id="3236" data-status="publish" data-issue-everyday-money="1"  data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/redcalculatorhouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To 1) cut your payment, 2) pay it off faster, 3) get cash, or 4) switch to a fixed or adjustable rate loan.</p></div><h3 class="square-tease-h">Figure Out "If You Refinance ..."</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/move-or-stay-put" data-id="6376" data-status="publish" data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/movehouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>It changes what you own, what you owe, &amp; your monthly expenses.</p></div><h3 class="square-tease-h">Figure Out How Moving Changes Your Finances</h3></a></div><div
class="topic-sort-everyday-money home-sort-hidden qs-sorter"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/make-a-budget-in-3-min" data-id="6234" data-status="publish" data-issue-everyday-money="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/wallet3.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Know where your money goes, to spend smarter and live within your means.</p></div><h3 class="square-tease-h">Figure Out a Budget in 3 Minutes</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/control-your-spending" data-id="107" data-status="publish" data-issue-everyday-money="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/purse1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Small changes can have a big impact.</p></div><h3 class="square-tease-h">Figure Out Where to Cut Spending</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/a-reserve-for-unemployment" data-id="954" data-status="publish" data-issue-everyday-money="1"  data-issue-reserves-insurance="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/investments-debt.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To protect yourself you need a reserve, usually about 2-4 months’ pay.</p></div><h3 class="square-tease-h">Figure Out a Reserve for Unemployment</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/should-you-refinance" data-id="3236" data-status="publish" data-issue-everyday-money="1"  data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/redcalculatorhouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To 1) cut your payment, 2) pay it off faster, 3) get cash, or 4) switch to a fixed or adjustable rate loan.</p></div><h3 class="square-tease-h">Figure Out "If You Refinance ..."</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/savings-as-a-source-of-retirement-income" data-id="3340" data-status="publish" data-issue-everyday-money="1"  data-issue-retirement="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/annuities2.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get what you need, without out-living your savings.</p></div><h3 class="square-tease-h">Figure Out How to Get Income from Retirement Savings</h3></a></div><div
class="topic-sort-housing home-sort-hidden qs-sorter"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/move-or-stay-put" data-id="6376" data-status="publish" data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/movehouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>It changes what you own, what you owe, &amp; your monthly expenses.</p></div><h3 class="square-tease-h">Figure Out How Moving Changes Your Finances</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/should-you-refinance" data-id="3236" data-status="publish" data-issue-everyday-money="1"  data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/redcalculatorhouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To 1) cut your payment, 2) pay it off faster, 3) get cash, or 4) switch to a fixed or adjustable rate loan.</p></div><h3 class="square-tease-h">Figure Out "If You Refinance ..."</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/mortgage-analyzer" data-id="729" data-status="publish" data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/house-calculator.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Eight in 10 Americans choose a 30-year fixed-rate mortgage. Should you?</p></div><h3 class="square-tease-h">Figure Out Your Best Mortgage</h3></a></div><div
class="topic-sort-investing-2 home-sort-hidden qs-sorter"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/stocks-or-bonds" data-id="7958" data-status="publish" data-issue-investing-2="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/safetycone.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>See how much your savings might grow in average, good, and bad times.</p></div><h3 class="square-tease-h">Figure Out "Stocks or Bonds?"</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/build-a-better-tomorrow" data-id="6433" data-status="publish" data-issue-investing-2="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/buildabettertomorrow.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Build a plan to get where you want to go.</p></div><h3 class="square-tease-h">Figure Out a Better Tomorrow</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/target-your-retirement" data-id="170" data-status="publish" data-issue-investing-2="1"  data-issue-retirement="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Retirement planner if you're approaching retirement.</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if 50 or over)</h3></a></div><div
class="topic-sort-reserves-insurance home-sort-hidden qs-sorter"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/a-reserve-for-unemployment" data-id="954" data-status="publish" data-issue-everyday-money="1"  data-issue-reserves-insurance="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/investments-debt.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To protect yourself you need a reserve, usually about 2-4 months’ pay.</p></div><h3 class="square-tease-h">Figure Out a Reserve for Unemployment</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/how-much-life-insurance" data-id="6729" data-status="publish" data-issue-reserves-insurance="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/insurance-alt.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get a personal estimate in 6 minutes or less.</p></div><h3 class="square-tease-h">Figure Out How Much Life Insurance You Need</h3></a></div><div
class="topic-sort-retirement home-sort-hidden qs-sorter"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/target-your-retirement" data-id="170" data-status="publish" data-issue-investing-2="1"  data-issue-retirement="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Retirement planner if you're approaching retirement.</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if 50 or over)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/figure-out-a-retirement-plan-for-those-under-50" data-id="9384" data-status="publish"><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>How much to save &amp; how much you'll need in 10 years to be "on-track"</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if under 50)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/savings-as-a-source-of-retirement-income" data-id="3340" data-status="publish" data-issue-everyday-money="1"  data-issue-retirement="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/annuities2.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get what you need, without out-living your savings.</p></div><h3 class="square-tease-h">Figure Out How to Get Income from Retirement Savings</h3></a></div><div
class="topic-sort-savings-and-debt home-sort-hidden qs-sorter"><a
class="square-tease" href="http://squaredaway.bc.edu/calculators/a-reserve-for-unemployment" data-id="954" data-status="publish" data-issue-everyday-money="1"  data-issue-reserves-insurance="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/investments-debt.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To protect yourself you need a reserve, usually about 2-4 months’ pay.</p></div><h3 class="square-tease-h">Figure Out a Reserve for Unemployment</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/target-your-retirement" data-id="170" data-status="publish" data-issue-investing-2="1"  data-issue-retirement="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Retirement planner if you're approaching retirement.</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if 50 or over)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/figure-out-a-retirement-plan-for-those-under-50" data-id="9384" data-status="publish"><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/target1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>How much to save &amp; how much you'll need in 10 years to be "on-track"</p></div><h3 class="square-tease-h">Figure Out a Retirement Plan (if under 50)</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/should-you-refinance" data-id="3236" data-status="publish" data-issue-everyday-money="1"  data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/redcalculatorhouse.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>To 1) cut your payment, 2) pay it off faster, 3) get cash, or 4) switch to a fixed or adjustable rate loan.</p></div><h3 class="square-tease-h">Figure Out "If You Refinance ..."</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/mortgage-analyzer" data-id="729" data-status="publish" data-issue-housing="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/house-calculator.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Eight in 10 Americans choose a 30-year fixed-rate mortgage. Should you?</p></div><h3 class="square-tease-h">Figure Out Your Best Mortgage</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/stocks-or-bonds" data-id="7958" data-status="publish" data-issue-investing-2="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/safetycone.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>See how much your savings might grow in average, good, and bad times.</p></div><h3 class="square-tease-h">Figure Out "Stocks or Bonds?"</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/build-a-better-tomorrow" data-id="6433" data-status="publish" data-issue-investing-2="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/buildabettertomorrow.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Build a plan to get where you want to go.</p></div><h3 class="square-tease-h">Figure Out a Better Tomorrow</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/savings-as-a-source-of-retirement-income" data-id="3340" data-status="publish" data-issue-everyday-money="1"  data-issue-retirement="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/annuities2.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Get what you need, without out-living your savings.</p></div><h3 class="square-tease-h">Figure Out How to Get Income from Retirement Savings</h3></a> <a
class="square-tease" href="http://squaredaway.bc.edu/calculators/control-your-spending" data-id="107" data-status="publish" data-issue-everyday-money="1"  data-issue-savings-and-debt="1" ><img
class="square-tease-img" src="http://squaredaway.bc.edu/wp-content/uploads/purse1.png" /><h4 class="square-tease-label content-type calculators-tag">Calculator</h4><div
class="square-tease-sub"><p>Small changes can have a big impact.</p></div><h3 class="square-tease-h">Figure Out Where to Cut Spending</h3></a></div> </section>
            </div>
		</div>
    </section>
</div> <!--span8-->
<div class="span4">
   	<div class="well sidebar-nav " style="z-index: 999; position: static; width:220px; top: 191px;">
        <legend><i class="icon-list-alt "></i> Show </legend>
        <ol class="nav nav-list">
        	<li class="active square-filter-item tag-page-square-filter-item filter-active first"><a data-target="topic-sort-all" class="trigger-qs"><i class="icon-??"></i> All</a></li>
            <li class="square-filter-item tag-page-square-filter-item"><a data-target="topic-sort-everyday-money" class="trigger-qs-everyday-money trigger-qs"><i class="icon-??"></i> Everyday Money</a></li>
            <li class="square-filter-item tag-page-square-filter-item"><a data-target="topic-sort-housing" class="trigger-qs-housing trigger-qs"><i class="icon-??"></i> Housing</a></li>
            <li class="square-filter-item tag-page-square-filter-item"><a data-target="topic-sort-investing-2" class="trigger-qs-investing-2 trigger-qs"><i class="icon-??"></i> Investing</a></li>
            <li class="square-filter-item tag-page-square-filter-item"><a data-target="topic-sort-reserves-insurance" class="trigger-qs-reserves-insurance trigger-qs"><i class="icon-??"></i> Reserves &amp; Insurance</a></li>
            <li class="square-filter-item tag-page-square-filter-item"><a data-target="topic-sort-retirement" class="trigger-qs-retirement trigger-qs"><i class="icon-??"></i> Retirement</a></li>
            <li class="square-filter-item tag-page-square-filter-item last"><a data-target="topic-sort-savings-and-debt" class="trigger-qs-savings-and-debt trigger-qs"><i class="icon-??"></i> Savings and Debt</a></li>
      	</ol>		
    </div>	  
</div>
