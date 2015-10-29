function updateKeyValuePosition(){
	var tsg = $('.target-short-group');
	setTimeout(function(){
		var shortY = 0
		var th = (shortY + $('#graph-short_by').data('height'))/2 - 17;
		var limit = $('.target-ret-income-group').height();
		th = Math.max(th, limit);
		th = Math.min(th, 150);
		tsg.css('top', th);
	}, 600);
}