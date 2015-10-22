//;(function($){
	var body;
	var goalTabsAPI;
	var basicNumberFormat = {format:"#,###", locale:"us"};
	
	function trace(msg){
		try {
			console.log(msg);
		} catch(e){
            console.log(e);
        }
	}	

	$(document).ready(function(){
		body = $('body');
		$('select').change(shebangInstantSave);
		checkForActionMenu();
		initSavingsTabs();
		initAddYourOwnTip();
		makeSmallExpensesEditable();
		getCheckedToDosForActionPlan();
		initActionDrawer();
		initActionPlan();
		initEmailReminder();
		initGoalCalculator();
		initGoalAmount();
		initGoalSelect();
		initCheckboxesCode();
		checkIfGoalIsAlreadyReached();
		initFixedScroll();
		initCSSRefresh();
	});
	
	function initCSSRefresh(){
		$('.todo-goal-h1').text($('.todo-goal-h1').text());
	}
	
	function initFixedScroll(){
		$('#site-container').before($('#frame-menu'));
		if ($('#frame-menu:visible').length){
			$('#global-hdr').addClass('no-margin');
			$('#frame-menu').fixedScroll({topLimit:0});
		}
	}
	
	function checkForActionMenu(){
	if(body.hasClass('where-people-spend-2') || body.hasClass('how-to-do-it')){
			$('body').addClass('action-menu-on');
		}
	}
	
	function initGoalSelect(){
		if (!$('#goal-select').length){
			return;
		}
		var option = $('#goal-select option:selected');
		$('#custom-goal-form').hide();
		$('#goal-select').bind('change click', onGoalSelect);
		//$('#goal-select').each(onGoalSelect);
		selectTabFromGoal($('#goal-select').val());
		$('#cys-user-interest-rate').bind('change click keyup', onInterestRateAdjust);
		onOverallReady();
		var ir = option.data('interest-rate');
		if (ir > 0){
			$('#cys-interest-rate-group').fadeIn();
		} else {
			$('#cys-interest-rate-group').hide();
		}
		$('#goal-select').trigger('change');
	}
	
	function onInterestRateAdjust(){
		var val = $(this).val();
		shebangSaveValue('cys-user-interest-rate', val);
		onOverallReady();
	}
	
	function selectTabFromGoal(goal){
		var tabs = $(".enter-goal-toggle").data('tabs');
		$('.enter-goal-toggle a, .enter-goal-toggle li').removeClass('active');
		if (goal == 'house' || goal == 'college' || goal == 'trip' || goal ==  'car' || goal == 'credit-card' || goal == 'retirement'){
			tabs.click(0);
			$('.enter-goal-toggle li').eq(0).addClass('active');
		} else if(goal == 'default'){
			var index = tabs.getIndex();
			$('.enter-goal-toggle li').eq(index).addClass('active');
			tabs.click(index);
		} else {
			try {
				tabs.click(0);
				tabs.next();
			} catch(e) {
				trace('tabs not loaded yet');
			}
			$('.enter-goal-toggle li').eq(1).addClass('active');
		}
	}
	
	function onGoalSelect(e){
		var select = $(this);
		var option = $(this).find(':selected');
		var val = select.val();
		if (!val){
			return;
		}
		val = val.toLowerCase();
		var type = option.data('interest-rate-type');
		var rate = option.data('interest-rate');
		if (!type){
			type = '';
		}
		shebangSaveValue('cys-user-interest-rate-type', type);
		selectTabFromGoal(val);
		$("#cys-user-interest-rate").val(rate);
	
		shebangSaveValue('cys-user-interest-rate', rate);
		if (rate > 0){
			$('#cys-interest-rate-group').fadeIn();
		} else {
			$('#cys-interest-rate-group').fadeOut();
		}
		if (val == 'custom'){
			$('#custom-goal-form').show();
			$('#enter-goal-form').hide();
		} else {
			$('#enter-goal-form').show();
			$('#custom-goal-form').hide();
		}
		onOverallReady();
		shebangSaveValue('cys_goal_slug', val);
		var goalName = option.text();
		shebangSaveValue('cys_goal_name', goalName);
		var defaultAmount = option.data('default-amount');
		var currentAmount = $('#overall-savings-input');
		if (!currentAmount.length || currentAmount == 0 || !currentAmount){
			$('#overall-savings-input').val(defaultAmount);
		}
	}	
	
	function initCheckboxesCode(){
		$('.checkbox-input').each(function(){
			if (!$(this).attr('data-tdid')){
				var r = Math.round(Math.random() * 10000);
				$(this).attr('data-tdid', 't'+r);
			}
		});
	}
	
	function initSavingsTabs(){
		$("#spending-cat-tabs").tabs("#spending-cats > .pane",{
			current:'active'
		});
 		$('.spending-cat-more, .spending-cat-tab a, .spending-cat-back').click(function(){
    		//jared
			if ($(window).scrollTop() > 450){
				$.scrollTo(400, 500);
			}
		});	
	}
	
	function formatInput(){
		var val = toNumber($(this).val());
		$(this).val(addCommas(val));
	}
	
	function saveInput(){
		var input = $(this);
		if (input.attr('data-field')){
			shebangSaveValue(input.attr('data-field'), input.val());
		}
	}
	
	function initGoalCalculator(){
		$('#overall-savings-input').bind('blur keyup click change', onOverallReady);
		$('#overall-savings-input').bind('blur click change', shebangInstantSave);
		$('#overall-savings-input').returnKey(onOverallReady);
		
		$('#finish-month-select').bind('blur change click', onOverallReady);
		$('#finish-year-select').bind('blur change click', onOverallReady);
		
		$('#monthly-savings-input').bind('blur keyup click', onMonthlyReady);
		$('#monthly-savings-input').returnKey(onMonthlyReady);
		
		$('#goal-annual-input').bind('blur keyup click', onYearlyReady);
		$('#goal-annual-input').returnKey(onYearlyReady);
		
		var d = new Date();
		var cm = d.getMonth() + 1;
		var nextYear = (d.getFullYear()) + 2;
		if (toLower($('#finish-month-select').val()) == 'default'){
			$('#finish-month-select option[value="'+cm+'"]').attr('selected', 'selected');
		}
		if (toLower($('#finish-year-select').val()) == 'default'){
			$('#finish-year-select option[value="'+nextYear+'"]').attr('selected', 'selected');
		}
		$('#custom-goal-input').blur(onCustomGoalReady);
		
		$('#monthly-savings-input').trigger('blur');
		
		
		$('.enter-goal-toggle-item').click(function(){
			$('.enter-goal-toggle-item').removeClass('active');
			$(this).addClass('active');
			var ctab = $('.enter-goal-toggle-item').index($(this));
			shebangSaveValue('cys_goal_tab', ctab);
		});
		
		var ii = $('.enter-goal-toggle').attr('data-start-index');
		$(".enter-goal-toggle").tabs("#enter-goal-form > .pane",{
			current:'active', initialIndex:Number(ii),
		});	
		trace($(".enter-goal-toggle").data('tabs'));
		//$('.enter-goal-toggle').data('tabs').click(0);
		
		if ($('.todo-target .value.goal').text() == '0' || !$('.todo-target .value.goal').text()){
			$('.enter-goal-summary').hide();
		}
	}
	
	function onCustomGoalReady(e){
		var customGoal = $(this).val();
		shebangSaveValue('cys_custom_goal', customGoal);
		shebangSaveValue('cys_goal_name', customGoal);
	}
	
	function onYearlyReady(){
		var perYear = $('#goal-annual-input').val();
		perYear = toNumber(perYear);
		var perMonth = Math.round(perYear / 12);
		calcMonthToOverall(perMonth);
		$('#monthly-savings-input').val(addCommas(perMonth));
		var pyf = addCommas(Math.round(perYear));
		shebangSaveValue('cys_yearly_goal', pyf);
		shebangSaveValue('cys_monthly_goal', perMonth);
	}
	
	function calcMonthToOverall(perMonth){
		if (isDateReady()){
			var delta = getMonthDelta();
			var overall = Math.round(perMonth * delta);
			var pmf = addCommas(Math.round(perMonth));
			if (overall){
				$('#overall-savings-input').val(addCommas(overall));
			}
			updateMonthlyFields(pmf);
		}
	}
	
	function calcSavingsNeededPerMonth(amt, months){
		var perMonth = 0;
		var ir = Math.abs(toNumber(shebangGetValue('cys-user-interest-rate')) / 100);
		var calcType = shebangGetValue('cys-user-interest-rate-type');
		if (ir){
			var c = ir/12;
			var n = months;
			/* this is the loan numerator */
			console.log('ir = ' + ir);
			trace(c);
			trace('months = ' + months);
			var numerator = amt * (c * Math.pow(1 + c, n));
			trace('n = ' + numerator);
			if (calcType == 'savings'){
				numerator = amt * c;
				trace('using savings!');
			} 
			trace(calcType);
			var denominator = Math.pow(1 + c, n) - 1;
			trace('d = ' + denominator);
			perMonth = numerator/denominator;
		} else {
			perMonth = amt / months;
		}
		console.log('perMonth = ' + perMonth);
		return Math.round(perMonth);	
	}
	
	function calcOverallToMonth(amt){
		var delta = getMonthDelta();
		var perMonth = calcSavingsNeededPerMonth(amt, delta);
		updateMonthlyFields(perMonth);
		$('#monthly-savings-input').val(perMonth);
		shebangSaveValue('cys_monthly_goal', perMonth);
		$('.todo-target .goal').text(perMonth);
	}
	
	function calcOverallToYear(amt){
		var delta = getMonthDelta();
		var perMonth = amt/delta;
		var perYear = Math.round(perMonth * 12);
		$('#goal-annual-input').val(perYear);
		shebangSaveValue('cys_yearly_goal', perYear);
		shebangSaveValue('cys_monthly_goal', perMonth);
	}
	
	function updateMonthlyFields(perMonth){
		$('.enter-goal-bar-saved .value.saved').text(perMonth);
		$('.enter-goal-summary .value.goal').text(addCommas(perMonth));
		$('.enter-goal-summary').fadeIn();
		$('#savings-menu .value.goal').text(perMonth);
	}
	
	function onMonthlyReady(){
		var perMonth = $('#monthly-savings-input').val();
		perMonth = toNumber(perMonth);
		calcMonthToOverall(perMonth);
		var perYear = Math.round(perMonth * 12);
		$('#goal-annual-input').val(Math.round(perYear)); 
		shebangSaveValue('cys_monthly_goal', perMonth);
	}
	
	function getMonthDelta(){
		var y = $('#finish-year-select').val();
		var m = $('#finish-month-select').val();
		var date = new Date();
		var dy = y - date.getFullYear();
		var dm = m - date.getMonth();
		var delta = dy * 12 + dm - 1;
		return delta;
	}
	
	function isDateReady(){
		if (!$('#finish-year-select').length){
			return false;
		}
		var y = $('#finish-year-select').val().toLowerCase();
		var m = $('#finish-month-select').val().toLowerCase();
		if (y == 'default' || m == 'default'){
			return false;
		}
		return true;
	}
	
	function onOverallReady(e){
		if (isDateReady()){
			var amt = $('#overall-savings-input').val();
			amt = toNumber(amt);
			calcOverallToMonth(amt);
			calcOverallToYear(amt);
		}
	}
	
	function initAddYourOwnTip(){
		$('.add-your-own-tip input:checkbox').each(function(){
			var id = 'ayo-'+Math.round(Math.random()*10000);
			var cb = $(this);
			var parent = $(this).closest('.pane').attr('id');
			cb.data('id', id);
			cb.data('parent', parent);
			cb.attr('data-parent', parent)
			cb.attr('data-id', id);
		})
		var af = $('.add-your-own-tip .spending-savings');
		$('.add-your-own-tip .add-your-own-name').blur(addYourOwnReady);
		af.bind('blur', addYourOwnReady);
		$('.add-your-own-tip').live('blur', addYourOwnReady);
	}
	
	function addYourOwnReady(){
		var tr = $(this).closest('.add-your-own-tip');
		var amtField = tr.find('.add-your-own-amount');
		var amt = amtField.val();
		var cb = tr.find('input:checkbox');
		var id = cb.data('id');
		var nameField = tr.find('.add-your-own-name');
		var text = nameField.val();
		var parent = cb.data('parent');
		if (!amt){
			trace('amount not ready');
			amtField.focus();
			return;
		}
		if (!text){
			trace('item not ready');
			nameField.focus();
			return;
		}
		if (parseInt(amt) == 0 || !amt){
			//no amount entered
			amtField.focus();
		} else {
			cb.attr('checked', 'checked');
			save_todo(text, amt, id, parent);
			sendToActionPlan(cb, text, amt, id, true);
			updateSavings();
		}
	}

	function makeSmallExpensesEditable(){
		$('td.spending-savings').each(function(){
			var amt = toNumber($(this).text());
			if ($(this).text() == '$-'){
				amt = '-';
			}
			if (amt){
				var input = $('<span class="dollar">$</span><input type="text" value="'+amt+'" class="spending-savings blank-input add-your-own-amount instant-blanking">');
			} else {
				var input = $('<span class="dollar">$</span><input type="text" placeholder="0" class="spending-savings blank-input add-your-own-amount">');
			}
			$(this).html(input);
		});
		$('.instant-blanking').focus(function(){
			var input = $(this);
			if (input.val() == input.attr('placeholder')){
				input.val('');
			}
		});
		$('.instant-blanking').blur(function(){
			var input = $(this);
			if (!input.val()){
				input.val(input.attr('placeholder'));
			}
		});
		
		$('.add-your-own-name').live('blur', function(){
			var input = $(this);
			var cb = input.closest('tr').find('input:checkbox');
			cb.attr('value', input.val());
			var id = cb.data('id');
			update_todo_field(id, 'value', input.val());
		})
	}
	
	function initActionDrawer(){
		$('#action-menu a.dropdown-trigger').click(toggleDropDown);
		$('.todo-no-items').show();
		$('.todo-move, .todo-changes').each(function(){
			var sec = $(this);
			sec.hide();
			if (sec.find('td').length){
				sec.show();
				$('.todo-no-items').hide();
			}
		});
	}	
	
	function initActionPlan(){
		$('.checkoff-todo input:checkbox').change(function(e){
			var curretPct = $('.action-prog-bar-leader').width() / $('.action-prog-bar').width() * 100;
			var rem = 100 - curretPct;
			var cb = $(this);
			var pctPerItem = rem / $('.todo-type:visible').length;
			var newPct = curretPct + pctPerItem;
			if (cb.is(':checked')){
				cb.parents('tr').find('.todo-type').addClass('checked').removeClass('unchecked');
				update_todo_field(cb.data('id'), 'status', 'checked');
			} else {
				cb.parents('tr').find('.todo-type').removeClass('checked').addClass('unchecked');
				update_todo_field(cb.data('id'), 'status', 'new');
				newPct = curretPct - pctPerItem;
			}
			setActionPlanProgressToPct(newPct);
			shebangSaveValue('cys_current_pct', Math.round(newPct));
			goNextActionItem();
		});
		var cp = toNumber($('.pct-complete-number').text().replace('%', ''));
		setActionPlanProgressToPct(cp);
	}
	
	function goNextActionItem(){
		var nextUp = $('.todo-container .todo-table .todo-type.unchecked').first().text().trim();
		if (!nextUp){
			nextUp = "You've completed all your Action Plan items";
		}
		$('.action-progress .next-step').html('<span class="next-step-label">Next step:</span> '+nextUp);
	}	
	
	function setActionPlanProgressToPct(pct){
		$('.action-prog-bar-leader').css('width', pct+'%');
		$('.action-progress .pct-complete-number').text(Math.round(pct)+'%');
	}
	
	function showRemindComplete(uemail, ufreq, fadeTime){
		$('#remind-email-output').text(uemail);
		$('#remind-time-output').text(ufreq);
		$('.remind-form').fadeOut(fadeTime, function(){
			$('.remind-complete-msg').fadeIn();
		});
	}
	
	function saveEmailData(uemail, ufreq, parent){
		$.post('/wp-content/themes/shebang/_ajax/shebang-save-email.php', {uemail:uemail, ufreq:ufreq, content:parent}, trace);
	}
	
	function initEmailReminder(){
		$('.remind-button').click(function(e){
			e.preventDefault();
			var planner = $('body').data('post-parent-slug');
			var uemail = $('#remind-email-input').val();
			var ufreq = $('#remind-time-select').val();
			shebangSaveValue('cys_remind_email', uemail);
			shebangSaveValue('cys_remind_freq', ufreq);
			saveEmailData(uemail, ufreq, planner);
			showRemindComplete(uemail, ufreq, 500);
			$('.action-prog-bar-leader').css('width', '75%');
			$('.action-progress .pct-complete-number').text('75%'); 	
			goNextActionItem();
			
		});
		$('.change-remind-btn, .change-remind-link').click(function(e){
			e.preventDefault();
			$('.remind-complete-msg').fadeOut(300, function(){
				$('.remind-form').fadeIn(300);
			});
		});
		$('.cancel-remind-btn').click(function(e){
			$('#remind-email-input').val('');
		});
		
		if ($('#remind-email-input').val()){
			var freq = $('#remind-time-select').val();
			var email = shebangGetValue('cys_remind_email');
			showRemindComplete(email, freq, 1);
			goNextActionItem();
		}
	}	
	
	function toggleDropDown(){
		var ul = $('#action-menu .action-list');
		//ul.css('top', $('#action-menu').position().top + $('#action-menu').outerHeight() + 5);
		if (ul.is(":visible")){
			ul.slideUp();
		} else {
			ul.slideDown();
		}
	}
	
	function initGoalAmount(){
		$('input[name=save]').blur(function(){
			updateGoalAmount($(this).val());			
		});
		$('input[name=save]').keyup(function(){
			updateGoalAmount($(this).val());
		});
		var saved = toNumber($('#savings-menu .value.saved').text());
		var goal = toNumber($('#savings-menu .value.goal').text());
	}
	
	function updateGoalAmount(amt){
		trace('updategoalamount');
		if (amt == 0){
			amt = '0';
		}
		amt = toNumber(amt);
		var goal = addCommas(amt);
		if (!goal){
			goal = '0';
		}
		$('.money-number .value.goal').text(goal);
		if (amt == 0){
			$('.money-number .value.goal').addClass('gray');
			$('.money-number .money-goal').hide();
			$('.money-number .slash').hide();
		} else {
			$('.money-number .value.goal').removeClass('gray');
			$('.money-number .money-goal').show();
			$('.money-number .slash').show();
		}	
		updateSavings();
	}
	
	
	function updateSavings(){
		var val = getSavings();
		var goalAmt = getGoal();
		var pct = (val)/goalAmt;
		//updateGoalBar(pct);
		$('.money-saved .money-number .value.saved').countTo({to:val, speed:400, format:basicNumberFormat});
		shebangSaveValue('cys_savings', val);
	}
	
	function getGoal(){
		var goalAmt = $('.money-number .value.goal').text();
		return toNumber(goalAmt);
	}
	
	function getSavings(){
		var tds = cysGetTodos();
		var savings = 0;
		for (var i = 0; i<tds.length; i++){
			savings += toNumber(tds[i].amount);
		}
		return savings;
	}
	
	function checkSavingsAgainstGoal(){
		trace('checkSavingsAgainstGoal');
		var goal = getGoal();
		if (goal > 0){
			var saved = getSavings();
			if (saved >= goal){
				//user has hit goal
				showSavingsFlag(true)
			} else if (saved < goal){
				showSavingsFlag(false);
			} else {
				// I have no idea
			}
		}
	}
	
	var smUsed = false;
	
	function checkIfGoalIsAlreadyReached(){
		var goal = getGoal();
		if (goal > 0){
			var saved = getSavings();
			if (saved >= goal){
				smUsed = true;	
			}
		}
	}
	
	function showSavingsFlag(opt){
		if (opt){
			var sm = $('#spending-modal');
			if (smUsed){
				trace('already used');
				return;
			}
			$('#spending-modal').modal();
			smUsed = true;
			$('.close-modal, #simplemodal-overlay').click(closeModal);
		}
	}
	
	function closeModal(){
		$.modal.close();
	}
	
	function cysGetTodos(){
		var cys_todos = shebangGetValue('cys_todos');
		if (!cys_todos){
			cys_todos = new Array();
		}
		trace('cys_todos = ' + cys_todos);
		/*
		var ids = new Array();
		var na = new Array();
		for (var i = 0; i<cys_todos.length; i++){
			var todo = cys_todos[i];
			if ($.inArray(todo.id, ids) == -1 && todo.value.length){
				ids.push(todo.id);
				na.push(todo);
			}
		}
		return na;
		*/
		return cys_todos;
	}
	
	function getCheckedToDosForActionPlan(){
		if (!$('body').hasClass('make-a-plan')){
			trace('exit');
			return;
		}
		var tds = cysGetTodos();
		for (var i = 0; i<tds.length; i++){
			var td = tds[i];
			var tr = $('<tr class="checkoff-todo row-'+i+'"></tr>');
			var td1 = $('<td class="checkbox-container"><input type="checkbox" name="todo-'+td.id+'" id="todo-'+td.id+'" value="'+td.label+'" class="checkbox-input" data-id="'+td.id+'"/></td>');
			var td2 = $('<td class="todo-type unchecked"><label for="todo-'+td.id+'" class="checkbox-label">'+td.label+'</label></td>');
			var td3 = $('<td class="todo-savings"><span class="dollar">$</span>'+td.amount+'</td>');
			var td4 = $('<td class="todo-link"><a href="#" class="link-text help-me-do-it">Help me do it &raquo;</a></td>');
			if (td.status == 'checked'){
				td2.removeClass('unchecked');
				td2.addClass('checked');
				td1.find('input:checkbox').attr('checked', 'checked');
			}
			tr.append(td1).append(td2).append(td3).append(td4);
			$('#cys-action-items').append(tr);
		}
		
	}
	function find_todo_index(id){
		var cys_todos = cysGetTodos();
		for (var i = 0; i<cys_todos.length; i++){
			var td = cys_todos[i];
			if (td.id == id){
				return i;
			}
		}
		return -1;
	}
	
	function update_todo_field(id, field, amount){
		var cys_todos = cysGetTodos();
		var i = find_todo_index(id);
		if (!i && i != 0){
			return;
		}
		cys_todos[i][field] = amount;
		$('.action-drawer-item[id="'+id+'"]').find('.amount').html(amount);
		shebangSaveValue('cys_todos', cys_todos);
	}
	
//})(jQuery);