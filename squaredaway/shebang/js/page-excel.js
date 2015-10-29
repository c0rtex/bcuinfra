$(document).ready(function(){
	$('.excel-class-sample').wrap('<section class="excel-upload-output excel-upload-sample"></section>');
	$('.excel-upload-output').show();
	$('tr').each(function(){
		var tr = $(this);
		var td = tr.find('td').first();
		td.addClass('normal');
		var className = td.text();
		tr.addClass('excel-output-'+className);
		if (tr.is('[class*="gap"]')){
			return;
		}
		var sample = tr.find('td').eq(1);
		if (!sample.html().length){
			tr.find('td').eq(1).text('I am some sample text');
		}
	});
});