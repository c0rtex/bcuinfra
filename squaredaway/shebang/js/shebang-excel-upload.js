$(document).ready(function(){
	addClassesToSelectMenus();
	destroyTagsInCalcs();
	activateCalculators();
	cleanCalculators();
	fixCalculators();
	bindCalcHandlers();
	activateCalculators();
	$('.excel-upload-output').fadeIn();
	try {
		articleNavigator.refresh();
		$('#fixed-article-body-nav').localScroll({duration: 1000, onAfter: articleNavigator.resetClicked});
	} catch(e){
		trace('articleNavigator not found');
	}
	
	function addClassesToSelectMenus(){
		
	}
	
	function bindCalcHandlers(){
		$('.excel-upload-output select').addClass('excel-calc-select');
		$('.excel-calc-input, .excel-calc-select').live('change', function(){
			setTimeout(onCalcChange, 100);
		});
	}
	
	function wrapNumbers(text){
		var ta = text.split(' ');
		for (var i = 0; i<ta.length; i++){
			var word = ta[i];
			if (word.match(/\d+/g)){
				word = '<strong class="excel-bold-number">'+word+'</strong>';
				ta[i] = word;
			}
		}
		return ta.join(' ');
	}
	
	function onCalcChange(e){
		$('.trigger-update-paragraph').each(function(i){
			var input = $(this);
			var name = $(this).attr('name');
			var p = $('.content[name="'+name+'"]');
			var text = input.val();
			text = wrapNumbers(text);
			p.html(text);
		});
		
		//update markers on left to text in body
		$('.dynamic-header-marker').each(function(i){
			var tr = $(this);
			var index = tr.data('index');
			var text = tr.text();
			var li = $('#article-body-nav-item-'+index);
			li.find('a').text(text);
		});
		
		
	}
	
	function randomString(len) {
		var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
		var randomstring = '';
		for (var i=0; i<len; i++) {
			var rnum = Math.floor(Math.random() * chars.length);
			randomstring += chars.substring(rnum,rnum+1);
		}
		return randomstring;
	}	
	
	function activateCalculators(){
		setTimeout(function(){
			try {
				$('.excel-calc-input').trigger('change');
			} catch(e){
				trace('I dont htink so');
			}
		}, 300);
		
		
	}
	
	function destroyTagsInCalcs(){
		$('.mystyles').remove();
		$('.wizardbuttons').remove();
		$('#lightalert').remove();
		$('#fadealert').remove();
		$('img[src*="spreadsheetconverter"]').closest('table').remove();
	}
	
	function fixCalculatorText(table){
		$('tr.excel-output-text input, tr.excel-output-header-marker input, tr[class*="billboard"] input, tr.excel-output-text-oversize input, tr.excel-output-text-bullets input, tr.excel-output-text-bullet').each(function(){
			var input = $(this);
			var tr = input.closest('tr');
			var text = input.val();
			var p = $('<div class="content" data-from-class="'+tr.attr('class')+'"></div>');
			if (tr.hasClass('excel-output-text-bullets') ||tr.hasClass('excel-output-text-bullets')){
				p = $('<li class="content" data-from-class="'+tr.attr('class')+'"></li>');
			}
			var id = randomString(5);
			input.attr('id', input.attr('name'));
			p.text(text);
			p.attr('data-input', input.attr('name'));
			p.attr('name', input.attr('name'));
			input.addClass('trigger-update-paragraph');
			input.after(p);
			input.hide();
		});
	}
	
	function fixCalculatorDataRows(table){
		var testClass = 'excel-output-data-input';
		var test = '[class*="input"]';
		table.find('tr').each(function(){
			var tr = $(this);
			if (tr.filter(test).length){
				if (!tr.prev(test).length){
					//its the first in row
					tr.addClass('open-group');
				}
				if (!tr.next(test).length){
					tr.addClass('close-group');
				}
			} else {
			}
		}); 
	}
	
	function fixCalculatorBillboards(table){
		table.children('tbody').children('tr[class*="billboard"]').each(function(){
			trace('found one');
			var tr = $(this);
			var prev = tr.prev('[class*="billboard"]');
			var table = $('<table><tbody></tbody></table>');
			var holder;
			if (prev.length){
				//second or later in a set
				table = prev.find('table');
			} else {
				holder = $('<td colspan="100"></td>');
				holder.append(table);
			}
			var tds = tr.find('td');
			var newTR = $('<tr></tr>');
			tds.each(function(){
				var td = $(this);
				var input = td.find('input');
				if (input.length || $.trim(td.text()).length){
					newTR.append(td);
				}
			});
			table.find('tbody').append(newTR);
			newTR.addClass(tr.attr('class'));
			if (!prev.length){
				//first in the set so we should attach the table
				tr.find('td').remove();
				tr.append(holder);
				tr.removeClass('excel-output-billboard-big');
				tr.removeClass('excel-output-billboard-small');
				tr.removeClass('excel-output-billboard-large');
				tr.addClass('excel-output-billboard-container');
			} else {
				//weve moved subsequent ones so lets kill their tr
				tr.remove();
			}
		});
	}
	
	function fixCalculatorMarkers(table){
		$('.article-body-nav li.article-body-nav-item').not('.dynamic').addClass('flat');
		table.find('[class*="marker"]').each(function(){
			var tr = $(this);
			var gap = $('<tr class="gap before-marker"><td colspan="10"></td></tr>');
			tr.before(gap);
			var title = $.trim(tr.text());
			tr.attr('id', title);
			var index = $('.article-body-nav').children().length + 1;
			tr.attr('data-index', index);
			tr.addClass('dynamic-header-marker');
			var li = $('<li id="article-body-nav-item-'+index+'" class="article-body-nav-item dynamic"> <a href="#'+title+'">'+title+'</a></li>');
			var parentID = tr.closest('.ui-article-block').attr('id');
			var starter = $('.article-body-nav a[href="#'+parentID+'"]').closest('li');
			if (starter.next('.dynamic').length){
				//our starter has a dynamic after it
				var dynamics = starter.nextUntil('.flat');
				trace(dynamics);
				starter = dynamics.last();
			}
			starter.after(li);
		});
	}	
	
	function assignClassToRow(tr, rowClass){
		tr.attr('data-excel-class', rowClass);
		var classes = rowClass.split(' ');
		$.each(classes, function(index, val){
			var nc = 'excel-output-'+val;
			tr.addClass(nc);
		});
		
		if (rowClass.indexOf('header') > -1 || rowClass.indexOf('text') > -1){
			if (rowClass.indexOf('column') == -1){
				// DOESNT have match on column in class name
				var goodbye = tr.find('td:gt(0)');
				var children = goodbye.find('*').length;
				if (!children){
					goodbye.remove();
					trace("IM DOING IT");
					var td = tr.find('td').first();
					td.attr('colspan', 10);
					if (rowClass.indexOf('bullet') > 0){
						td.wrapInner('<li class="content assignClassToRow"></li>');
					} else {
						td.wrapInner('<div class="content assignClassToRow"></div>');
					}
				} 
			}
			if (rowClass.indexOf('column') > -1){
				return;
			}
		}
	}
	
	function assignClassToCells(tr){
		tr.find('td').each(function(){
			var td = $(this);
			var text = $.trim(td.text().toLowerCase());
			if (text.indexOf('per') == 0){
				td.addClass('align-left');
			}
		});
	}
	
	function getAndDestroyClassTD(tr){
		var rowClass = 'gap';
		var td = tr.find('td').first();
		var tdText = $.trim(td.text());
		if (tdText){
			rowClass= tdText;			
		}
		td.remove();
		return rowClass;
	}
	
	function fixCalculators(){
		if ($('.excel-upload-output').length){
			
			$('.excel-upload-output tr').each(function(i){
				
				var tr = $(this);
				if (!tr.text().length && i == 0){
					tr.remove();
				}
				var rowClass = getAndDestroyClassTD(tr);
				
				assignClassToRow(tr, rowClass);
				
				assignClassToCells(tr);
				var td = tr.find('td').not(':first');
				td.each(function(){
					var input = $(this).find('input');
					if (tr.is('[class*="input"]')){
						if (!input.length){
							$(this).addClass('excel-calc-label-small');
						}
					}
				});
				
			});
			
			
			$('.excel-upload-output tr').css('height', 'auto');
			//$('[class*="input"], [class*="total"]').find('input[readonly="readonly"]').addClass('excel-calc-result').closest('tr').addClass('excel-output-result');
			$('[class*="input"], [class*="total"]').find('input[readonly="readonly"]').addClass('excel-calc-result');
			$('input').not('[readonly="readonly"]').addClass('excel-calc-input');
			$('.excel-calc-input').addClass('text-input-large-dollar');
			$('.excel-upload-output table').css('width', 'auto');
			$('.excel-upload-output table tr td span').css('display', 'inline');
			$('.excel-upload-output table').each(function(){
				fixCalculatorDataRows($(this));
				fixCalculatorText($(this));
				fixCalculatorMarkers($(this));
				fixCalculatorBillboards($(this));
			});
			try {
				articleNavigator.refresh();
			} catch(e){
				trace('no articleNavigator found');
			}
		}
	}
	
	function cleanCalculators(){
		$('.excel-upload-output').each(function(){
			var html = $(this).html();
			try {
				$(this).html($.trim(html));
			} catch(e){
				trace('error trimming in cleanCalculators');
			}
		});
	}

});

function trace(msg){
	try {
		console.log(msg);
	} catch(e) {};
}

function onEnterPress(name){
	trace('sent to ' + name);
}	