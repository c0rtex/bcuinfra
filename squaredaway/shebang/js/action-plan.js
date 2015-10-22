$(document).ready(function(){
	initActionPlan();
	initEmailReminder();
});

function initActionPlan(){
		$('.checkoff-todo input:checkbox').change(function(e){
			var curretPct = $('.action-prog-bar-leader').width() / $('.action-prog-bar').width() * 100;
			var rem = 100 - curretPct;
			var cb = $(this);
			var pctPerItem = rem / $('.todo-type:visible').length;
			var newPct = curretPct + pctPerItem;
			if (cb.is(':checked')){
				cb.parents('tr').find('.todo-type').addClass('checked').removeClass('unchecked');
				update_todo(cb.data('id'), 'checked');
			} else {
				cb.parents('tr').find('.todo-type').removeClass('checked').addClass('unchecked');
				update_todo(cb.data('id'), 'new');
				newPct = curretPct - pctPerItem;
			}
			setActionPlanProgressToPct(newPct);
			shebangSaveValue('draw_down_current_pct', Math.round(newPct));
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
	
	function saveEmailData(uemail, ufreq, parent, content){
		trace('save for ' + parent);
		$.post('/wp-content/themes/shebang/_ajax/shebang-save-email.php', {uemail:uemail, ufreq:ufreq, treatment:parent, content:''}, trace);
	}
	
	function initEmailReminder(){
		$('.remind-button').click(function(e){
			e.preventDefault();
			var planner = $('body').data('post-parent-slug');
			var uemail = $('#remind-email-input').val();
			var ufreq = $('#remind-time-select').val();
			shebangSaveValue('cys_remind_email', uemail);
			shebangSaveValue('cys_remind_freq', ufreq);
			var content = '';
			saveEmailData(uemail, ufreq, planner, content);
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
	