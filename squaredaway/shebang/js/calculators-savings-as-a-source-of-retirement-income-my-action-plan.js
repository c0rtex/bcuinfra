;(function($){

	$(document).ready(function(){
		loadSavingsSliderPcts();
		loadOtherOptions();
		initPrint();
	});
	
	function initPrint(){
		$('.trigger-print').click(function(e){
			e.preventDefault();
			window.print();
		});
	}
	
	function loadOtherOptions(){	
		
	}
	
	function loadSavingsSliderPcts(){
		$('.action-plan-pct-source').hide();
		var pcts = shebangGetValue('drawdown-pcts');
		if (pcts == null || !pcts){
			$('.your-plan-section').remove();
		}
		for (var i = 0; i<pcts.length; i++){
			var row = pcts[i];
			if (row == null){
			
			} else if (row.pct > 0){
				var tr = $('.action-plan-pct-source').clone();
				tr.removeClass('action-plan-pct-source');
				tr.find('.action-pct').text(Math.round(row.pct) + '%');
				
				if (row.title == 'Using Savings to Delay your Claim on Social Security'){
					row.title = 'Using Savings to Delay Claiming Social Security';
				}
				tr.find('.action-name').text(row.title);
				tr.show();
				$('.action-plan-your-plan-body').append(tr);
			} else {
				trace('somethings fd');
			}
		}
	}
	
})(jQuery);