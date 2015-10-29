var gsaLifeStage;

$(document).ready(function(){
	bindHandlers();
	$('#gsa-picker-life-stage').hide();
	$('#gsa-picker-issue').hide();
	var ht = $('.gsa-selection-container').outerHeight();
	ht = Math.max(ht, 418);
	$('.gsa-selection-container').css('max-height', ht);
	$('.gsa-results-container').hide();
	$('.trigger-see-more').hide();
	$('.square-tease').removeClass('nth-1 nth-2 nth-3');
	$('.gsa-selection-life-stages li').hide();
	var ht = $('.gsa-selection-container').outerHeight();
	ht = Math.max(ht, 451);
	$('.gsa-selection-container').data('safe-height', ht);
	$('.gsa-selection-container').height(ht);
	///$('.listing-square-group').hide();
});

function bindHandlers(){
	$('.trigger-life-stage').click(onLifeStageClick);
	$('.trigger-age').click(onAgeClick);
	$('.trigger-see-more').live('click', onSeeMoreClick);
	$('.trigger-see-less').live('click', onSeeLessClick);
	$('.trigger-issue').bind('click', onIssueClick);
}

function onSeeLessClick(e){
	e.preventDefault();
	var section = $(this).closest('.gsa-results-container');
	section = section.find('.listing-square-group:visible');
	var safeHeight = section.data('safe-height');
	if (!safeHeight){
		safeHeight = 220;
	}
	section.animate({height:safeHeight});
	resetSeeMore($(this), 'trigger-see-more');
}

function onSeeMoreClick(e){
	e.preventDefault();
	var section = $(this).closest('.gsa-results-container');
	section = section.find('.listing-square-group:visible');
	var safeHeight = section.height();
	section.data('safe-height', safeHeight);
	var targetHeight = Math.ceil(section.find('.square-tease').length / 3) * 220;
	section.height(safeHeight);
	section.animate({height:targetHeight});
	resetSeeMore($(this), 'trigger-see-less');
}

function onAgeClick(e){
	e.preventDefault();
	$('#gsa-picker-life-stage').fadeIn();
	if (!$('#gsa-picker-issue:visible').length){
		$('.gsa-selections').css('width', '66.667%');
		$('.gsa-selection').css('width', '48%');
		$('.gsa-selection').eq(0).css('margin-right', '1.75%');
	}
	var ids = $(this).data('valid-life-stages').split(',');
	$('.gsa-selection-life-stages li[data-life-stage-id="367"]').addClass('keep').slideDown();
	$.each(ids, function(index, value){
		$('.gsa-selection-life-stages li[data-life-stage-id="'+value+'"]').addClass('keep');
	});
	$('.gsa-selection-life-stages li.keep').slideDown();
	var ageLength = $('#gsa-picker-age li').length;
	var stageLength = $('.gsa-selection-life-stages li.keep').length;
	var base = $('.gsa-selection-container').data('safe-height');
	base += 40;
	if (stageLength > ageLength){
		var d = stageLength - ageLength;
		var ht = d * $('.gsa-selection-life-stages li').first().outerHeight();
		base += ht;
		trace('base = ' + base);
		$('.gsa-selection-container').css('max-height', base);
		$('.gsa-selection-container').height(base);
	} else {
		$('.gsa-selection-container').css('max-height', base);
		$('.gsa-selection-container').height(base);
	}
	$('.gsa-selection-life-stages li').not('.keep').slideUp();
	$('.keep').removeClass('keep');
	
}

function onIssueClick(e){
	e.preventDefault();
	if ($('#gsa-before-finished:visible').length){
		//not visible yet
		$.scrollTo('#gsa-before-finished', 800);
	} else {
		trace('nadda');
	}
	showSquares(gsaLifeStage);
	var a = $(this);
	var slug = a.data('issue-slug');
	var groups = $('.listing-square-group:visible');
	groups.eq(0).each(function(){
		var original = $(this);
		original.css('position', 'static');
		original.parent().css('position', 'relative');
		var group = original.clone();
		var squares = group.find('.square-tease');
		var sortedSquares = squares.sorted({
			reversed: true,
			by: function(sq){
				var v = 0;
				if ($(sq).data('issue-'+slug)){
					v = $(sq).data('issue-'+slug);
				}
				return v;
			}
		});
		var ids = '';
		sortedSquares.each(function(){
			ids += $(this).data('id');
		});
		if (original.data('currentSquares') != ids){
			original.quicksand(sortedSquares, {adjustHeight:false, attribute:'data-id'});
			original.data('currentSquares', ids);
		}
	});
}

function onLifeStageClick(e){
	trace('onLifeStageClick start');
	e.preventDefault();
	var trigger = $(this);
	gsaLifeStage = trigger.data('life-stage-slug');
	$('#gsa-picker-issue').fadeIn();
	$('.gsa-selections').css('width', '100%');
	$('.gsa-selection').css('width', '32%');
	$('.gsa-selection').eq(1).css('margin-right', '1.75%');
	if (!$('#gsa-before-finished:visible').length){
		//if the before finished is hidden
		trace('show some squares');
		showSquares(gsaLifeStage);
	}
}

function showSquares(lifeStage){
	$('.gsa-results-container').slideDown();
	$('#gsa-before-finished').slideUp();
	var currentLifeStage = $('.gsa-results-container').data('life-stage', lifeStage);
	if (currentLifeStage == lifeStage){
		return;
	}	
	$('.gsa-results-container').data('life-stage', lifeStage);
	trace('----HIDERS----');
	var hiders = $('.listing-square-group').not('[data-life-stage-slug="'+lifeStage+'"]');
	trace(hiders);
	hiders.slideUp(function(){
		hiders.hide();
	});
	var showGroup = $('.listing-square-group[data-life-stage-slug="'+lifeStage+'"]');
	trace('++++SHOWERS++++');
	showGroup.slideDown(onShowGroupComplete);
	trace(showGroup);
	trace('now NOT showing ' + lifeStage);
}

function resetSeeMore(anc, className){
	className = className.replace('.', '');
	if (className == 'trigger-see-more'){
		anc.text('See More');
		anc.addClass('trigger-see-more');
		anc.removeClass('trigger-see-less');
	} else {
		anc.text('See Less');
		anc.addClass('trigger-see-less');
		anc.removeClass('trigger-see-more');
	}
}

function onShowGroupComplete(e){
	var group = $(this);
	var squares = group.find('.square-tease');
	var container = group.closest('.gsa-results-container');
	var trigger = container.find('.trigger-see-more-or-less');
	resetSeeMore(trigger, 'trigger-see-more');
	if (squares.length > 3){
		trigger.fadeIn();
	} else {
		trigger.fadeOut();
	}
}

function trace(msg){
	console.log(msg);
}
