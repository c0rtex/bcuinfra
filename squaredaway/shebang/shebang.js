$(document).ready(function() {

if ( $(window).width() <= 700) {      
$(".spendingTable").removeClass ("spending-table table-lined");

} 
else {
}
})

var ajax = '/wp-content/themes/shebang/_ajax/';
var months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

function initGraph(){
	$('.bar-graph-bar').each(function(){
		var val = $(this).find('.amount').html();
		$(this).data('value', val);
	});
}

function initSliderGroups(){
	$('.slider-group[type=range]').each(function(){
		var slider = $(this);
		var group = $(this).data('group');
		var input = $('input[data-group='+group+']');
	});
}

function initNumberFields(){
	/*$('.sample5').numeric({allow:"."});*/
	try {
		//$('input[type="number"]').numeric({allow:".,"});
	} catch(e){
		trace('Numeric Plugin not loaded');
	}

}

function initBrowserWarning(){
	/*
	if ($('body').hasClass('post-type-planners') || $('body').hasClass('post-type-calculator') || $('body').hasClass('post-type-calculators')){
		if (!$.browser.webkit){
			$('#optimized-modal').modal();
		}
	}
	*/

	// DS: Now warn only for IE 9 and lower and only once on site entry.

	if(!shebangGetValue("browser_warning_done") && $.browser.msie && parseFloat($.browser.version) < 10) {
		$('#optimized-modal').modal();
		shebangSetValue("browser_warning_done", true);
	}
}

function initCloseButtons(){
	$('.action-close-btn').click(function(e){
		e.preventDefault();
		$(this).closest('div, article').slideUp();
	})
}

function initTargetRetIncome(){
	$('span[data-field="target_ret_income_temp"]').each(function(){
		var trit = shebangGetValue('target_ret_income_temp');
		var tri = shebangGetValue('target_ret_income');
		// DS: Round to 10 to match bar graph
		if (!trit || trit == null || trit > tri){
			// $(this).html(addCommas(roundTo(tri, 100)));
			$(this).html(addCommas(roundTo(tri, 10)));
		} else {
			// $(this).html(addCommas(roundTo(tri, 100)));

			// ... and I think this is supposed to be trit
			// $(this).html(addCommas(roundTo(tri, 10)));
			$(this).html(addCommas(roundTo(trit, 10)));
		}
	});
}

function initToolTips(){
	$('.tip-trigger').hoverIntent(function(){
		$(this).addClass('tip-active');
	}, function(){
		$(this).removeClass('tip-active');
	});

	$('.tooltip').each(function(){
		var html = $(this).html();
		html = html.replace('Advanced', '<strong>Advanced</strong>');
		$(this).html(html);
	});

	$('body').click(function(){
		$('.tip-trigger').removeClass('.tip-active');
	});
}

// DS: Prevent input outside of defined range on retirement age.

function initRetirementAgeInput () {
	$("#planned_ret_age").blur(function () {
		var intVal = parseInt(this.value);
		var min = $(this).attr("min");
		var max = $(this).attr("max");
		if(isNaN(intVal) || intVal < parseInt(min)) {
			this.value = min;
		}
		else if (intVal > parseInt(max)) {
			this.value = max;
		}

		shebangSaveValue("retirement_age", this.value);
	});
}

// DS: Fix range input display for non-supporting browsers

function fixRangeInputs () {
	if(!Modernizr.inputtypes.range) {
		$(".slider-input").height(15);
	}
	else if ($.browser.msie) {
		var css = {
				"background-image":"none",
				// CTW

				"height":"auto",
				"width":"auto",

				// DS: The explicit height breaks the other ones. Putting it only on the ont that needs it.
				// "height":"11px",
				// "width":"349px",
				"padding":"0px",

				// End CTW
				"position":"relative",
				"top":"15px"
		};
		$(".slider-input").css(css);
		$("#mtg-length-slider").css("top", "-15px");
		$("#target_consumption_delta").css({"top":"-10px", "height":"11px", "width":"349px"});
	}
}

$(window).load(function () {
	setTimeout(fixRangeInputs, 2);
});

$(document).ready(function(){
	initToolTips();
	initNumberFields();
	initCloseButtons();
	setDefaultsToLocalStorage();
	setValuesFromTotalStorage();
	setFormatsFromTotalStorage();
	setPctsFromAmts();
	setBooleanDisplayFromLocalStorage();
	initGraph();
	$('.instant-save').bind('blur click', shebangInstantSave);
	setGraphContainers();
	initContentEditable();
	initAdvanced();
	initExplainers();
	initModals();
	initSliderGroups();
	initTargetRetIncome();
	initBrowserWarning();

	initRetirementAgeInput();
	// fixRangeInputs();

	function setPctsFromAmts(){
		$('.pct-from-amt').each(function(){
			var input = $(this);
			var num = shebangGetValue(input.data('num'));
			if (num == null){
				num = $('#'+input.data('num')).val();
			}
			var den = shebangGetValue(input.data('den'));
			if (den == null){
				den = $('#'+input.data('den')).val();
			}
			var pct = num / den;
			input.val(roundTo(pct * 100, 1));
		});
	}

	function setFormatsFromTotalStorage(){
		$('.ls-format').each(function(){
			var format = $(this).data('format');
			if (format == 'num-to-month'){
				var val = $(this).html();
				var m = val-1;
				var month = months[m];
				$(this).html(month);
			}
		});
	}

	function setDefaultsToLocalStorage(){
		if (!$('#shebang_defaults').length){
			return;
		}
		var json = $('#shebang_defaults').text();
		if (!json){
			return;
		}
		var def = JSON.parse(json);
		for (var i = 0; i<def.length; i++){
			var row = def[i];
			var val = shebangGetValue(row.c_key);
			if (val == null){
				shebangSaveValue(row.c_key, row.c_value);
			}
		}
	}

	function setBooleanDisplayFromLocalStorage(){
		//for conditional display
		$('.ls-boolean-display').each(function(){
			var elm = $(this);
			elm.hide();
			var field = elm.attr('data-field');
			if (shebangGetValue(field)){
				elm.show();
			}
		});

		$('.ls-boolean-remove').each(function(){
			var elm = $(this);
			elm.hide();
			var field = elm.attr('data-field');
			if (shebangGetValue(field)){
				elm.show();
			} else {
				elm.remove();
			}
		});

	}

	function setValuesFromTotalStorage(){
		$('.ls-value').each(function(){
			var elm = $(this);

			var field = elm.attr('data-field');
			if (!field){
				field = elm.attr('id');
			}
			var val = $.totalStorage(field);
			trace(field + ' = ' + val);
			if (val == null){
				var fallback = elm.data('field-fallback');
				val = $.totalStorage(fallback);
			}
			if (!val && val != 0){
				return;
			}
			if (elm.is(':radio')){
				$('input[data-fiedl="'+field+'"]').removeAttr('checked');
				var sel = 'input[data-field="'+field+'"][value="'+val+'"]';
				var obj = $(sel);
				if (!obj.length){
					sel = 'input[id="'+field+'"][value="'+val+'"]';
					obj = $(sel);
				}
				obj.attr('checked', 'true');
			} else if (elm.is(':checkbox')){
				trace(field);
				if (val){
					elm.attr('checked', true);
				} else {
					elm.removeAttr('checked');
				}
			} else if (elm.is('input')){
				elm.val(val);
			} else if (elm.is('select')){
				elm.val(val);
				elm.find('option').removeAttr('selected')
				elm.find('option[value="'+val+'"]').attr('selected', 'selected');
			} else {
				if(toNumber(val) == val){
					if (elm.hasClass('round-to-1')){
						val = roundTo(val, 1);
					}
					if (elm.hasClass('round-to-10')){

						val = roundTo(val, 10);
					}
					if (elm.hasClass('round-to-100')){
						val = roundTo(val, 100);
					}

					if(elm.attr("data-field")=="savings_at_retirement") {
						val = roundTo(val, 10000);
					}

					if (!elm.hasClass('no-commas')){
						val = addCommas(val);
					}

					elm.html(val);
				} else {
					elm.html(val);
				}
			}

		});
	}

	function initModals(){
		$('.close-modal').click(function(){
			$.modal.close();
		});
	}

	function initContentEditable(){
		$('.contenteditable.furniture').blur(updateContentEditable);
		$('.contenteditable.furniture-title').blur(updateContentEditableTitle);$('.contenteditable.custom').blur(updateContentEditableCustom);
		$('.contenteditable').each(function(){
			var parent = $(this).parent();
			if (parent.css('display') == 'block'){
				$(this).css('display', 'block');
			}
		});
	}

	function updateContentEditableTitle(){
		var span = $(this);
		var pid = span.attr('data-pid');
		var title = span.text();
		$.post(ajax+'update-post.php', {pid:pid, title:title}, onContentSaved);
	}

	function updateContentEditable(){
		var span = $(this);
		var pid = span.attr('data-pid');
		var content = span.text();
		$.post(ajax+'update-post.php', {pid:pid, content:content}, onContentSaved);
	}

	function updateContentEditableCustom(){
		var span = $(this);
		var pid = span.attr('data-pid');
		var key = span.attr('data-key');
		var content = span.html();
		$.post(ajax+'update-post-custom.php', {pid:pid, key:key, content:content}, onContentSaved);
	}

	function onContentSaved(data){
		trace(data);
	}

	function initAdvanced(){
		trace('initAdvanced');
		$('.hidden-advanced').hide();
		$('.trigger-advanced').click(function(e){
			trace('advanced click!!!');
			e.preventDefault();
			if ($('.hidden-advanced:visible').length){
				$('.hidden-advanced').hide();
				$(this).removeClass('advanced-active');
			} else {
				$('.hidden-advanced').show();
				$(this).addClass('advanced-active');
			}
		});
	}

	function initExplainers(){
		$('.explanations-hidden').hide();
		$('.explanations-trigger').click(function(e){
			e.preventDefault();
			if ($('.explanations-hidden:visible').length){
				$('.explanations-hidden').hide();
				$(this).removeClass('active-explanations');
			} else {
				$('.explanations-hidden').show();
				$(this).addClass('active-explanations');
			}
		});
	}

});

function setGraphContainers(){
	$('.graph-container').each(function(){
		var mh = $(this).css('height');
		$(this).css('max-height', mh);
	});
}

function getGraphUnit(maxVal){
	var maxh = toNumber($('.graph-container').css('max-height'));
	var unit = maxh / maxVal;
	return unit;
}

function getGraphMaxVal(){
	var max = 0;
	$('.bar-graph-bar').each(function(){
		var val = toNumber($(this).data('value'));
		if (val > 0){
			max += val;
		}
	});
	return max;
}

function redrawBarGraph(maxVal){
	if (!maxVal){
		maxVal = getGraphMaxVal();
	}
	$('.bar-graph-bar').each(function(){
		var htmlID = $(this).attr('id');
		var val = $(this).find('.amount').html();
		if (val == '' || val == null){
			return;
		}
		if (val){
			val = toNumber(val.replace('$', ''));
		}
		if (val){
			updateBarGraphBar(htmlID, val);
		} else {
			hideBarGraphBar(htmlID);
		}
	});
	$('.bar-graph-bar').each(function(){
		var htmlID = $(this).attr('id');
		var val = $(this).data('value');
		if (val){
			redrawBarGraphBar(htmlID, val, maxVal);
		} else {
			hideBarGraphBar(htmlID);
		}
	});
}

function getCurrentSlideName(){
	return $('body').attr('data-slide-name');
}

function redrawBarGraphBar(htmlID, value, maxVal){
	var sel = '#graph-'+htmlID;
	var obj = $(sel);
	if (!obj.length){
		obj = $('#'+htmlID);
	}
	obj.data('value', toNumber(value));
	var th = value * getGraphUnit(maxVal);
	if (th < 18){
		obj.addClass('too-small-bar');
	} else {
		obj.removeClass('too-small-bar');
	}

	if (th > 0){
		if (!obj.is(':visible')){
			obj.height(0);
		}
		obj.show();
		obj.height(th);
		var to = obj.data('timeout');
		clearTimeout(to);
	} else {
		hideBarGraphBar(htmlID);
	}
	obj.data('height', th);
}

function getBarGraphValue(htmlID){
	var sel = '#graph-'+htmlID;
	var obj = $(sel);
	if (!obj.length){
		obj = $('#'+htmlID);
	}
	return obj.data('value');
}

function updateBarGraphBar(htmlID, value){
	var sel = '#graph-'+htmlID;
	var obj = $(sel);
	if (!obj.length){
		obj = $('#'+htmlID);
	}
	obj.find('.amount').html(''+addCommas(roundTo(value, 10)));
	obj.data('value', toNumber(value));
	if (value > 0){
		obj.fadeIn();
	}
	var id = $(htmlID);
	if (id.length){
		id.val(value);
	} else {
		var hid = $('<input type="hidden" />');
		hid.attr('id', htmlID);
		hid.val(value);
		$('body').append(hid);
	}
}

function hideBarGraphBar(htmlID){
	var sel = '#graph-'+htmlID;
	var obj = $(sel);
	if (!obj.length){
		obj = $('#'+htmlID);
	}
	if (obj.css('display') == 'none'){
		return;
	}
	obj.height(0);
	obj.attr('data-height', 0);
	obj.data('value', 0);
	obj.fadeOut();
	trace('------------------');
	trace('hide ' + htmlID);
}

function getFieldByPerson(field, person){
	var sel = $('.'+field+'.field-'+person);
	if (sel){
		return $(sel).val();
	}
	return 0;
}

function shebangUpdatePageValue(id, val){
	$('#'+id).val(val);
	$('#'+id).text(val);
	return val;
}

function shebangInstantSave(){
	var input = $(this);
	var field = input.attr('data-field');
	var id = input.attr('id');
	if (!field){
		field = id;
	}
	var val = input.val();
	if (input.is(':checkbox')){
		if (input.is(':checked')){
			val = 'on';
		} else {
			val = 0;
		}
	}
	$.totalStorage(field, val);
}

function shebangGetValue(field){
	return $.totalStorage(field);
}

function shebangSetValue(field, val){
	return shebangSaveValue(field, val);
}

function shebangSaveValue(field, val){
	return $.totalStorage($.trim(field), val);
}

function roundTo(num, place){
	var nn = Math.round(num/place);
	return nn * place;
}

function addCommas(nStr){
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}

function toNumber(val){
	var str = String(val);
	str = str.replace(/[^\d.-]/g, "");
	var num = Number(str);
	return num;
}

function toLower(str){
	if (str){
		return str.toLowerCase();
	}
	return str;
}

function toBoolean(val){
	if (val == 0 || val == false || val == '0' || val == 'false' || val == ''){
		return false;
	} else {
		return true;
	}
}

function shebang_log(key, val, msg){
	//$.post(ajax+'shebang-log.php', {key:key, val:val, msg:msg}, trace);
}
