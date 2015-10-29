var ddi;

;(function() {

   function DrawDownInputs() {
      this.bindHandlers();
      this.view = new DrawDownInputsView();
      this.model = new SquaredAwayModel();
      this.calculate();
   }
   
	DrawDownInputs.prototype.bindHandlers = function() {
		var eventString = 'keypress blur change click';
		$('.instant-save').bind(eventString, $.proxy(saveToFieldAndCaclulate, this));
		
		function saveToFieldAndCaclulate(e){
			var field = $(e.target).data('field');
			var value = $(e.target).val();
			if (value == parseInt(value)){
				value = toNumber(value);
			}
			this.model[field] = value;
			shebangSaveValue(field, value);
			this.calculate();
		}
	}
   
	DrawDownInputs.prototype.calculate = function(e){
		this.model.calculate();
		this.model.save();
   		this.view.render(this.model);
	}
   
	function DrawDownInputsView(){
   
	}
   
	DrawDownInputsView.prototype.render = function(data){
		trace(data);
		this.renderValues(data);
		this.renderYearlyExpenses(data.drawdown_yearly_expenses, data.drawdown_yearly_expenses_cys, data.drawdown_cut_pct);
		this.renderYearlyIncome(data.drawdown_yearly_income);
		this.renderYearlyGoal(data.drawdown_need_from_savings, data.drawdown_need_from_savings_cys);
		this.renderMarriage(data.marital_status_gender);
	}
	
	DrawDownInputsView.prototype.renderValues = function(values){
		for (var i in values){
			var elm = $('.rec-value[data-field="'+i+'"]');
			var val = values[i];
			if (val == parseFloat(val)){
				val = addCommas(toNumber(val));
			}
			if (elm.is("input")){
				elm.value(val);
			} else {
				elm.html(val);
			}
		}
	}
	
	DrawDownInputsView.prototype.renderYearlyGoal = function(goal, goal_cys){
		$('#drawdown_need_from_savings').countTo(roundTo(goal, 10));
		if (goal_cys != goal){
			$('#text-drawdown_need_from_savings_cys').fadeIn();
			$('#drawdown_need_from_savings_cys').text('$'+addCommas(roundTo(goal_cys, 10)));
		} else {
			$('#text-drawdown_need_from_savings_cys').fadeOut();
		}
	}
	
	DrawDownInputsView.prototype.renderYearlyIncome = function(income){
		$('#drawdown_yearly_income').countTo(roundTo(income, 10));
		
		
	}
	
	DrawDownInputsView.prototype.renderYearlyExpenses = function(exp, exp_cys, cys_pct){
		$('#drawdown_yearly_expenses').countTo(roundTo(exp, 10));
		if (exp_cys && exp != exp_cys){
			$('#text-drawdown_yearly_expenses_cys').fadeIn();
			$('#text-drawdown_yearly_expenses_cys strong').text('$'+addCommas(roundTo(exp_cys,100)));
			$('#text-drawdown_yearly_expenses_cys span[data-field="drawdown_cut_pct"]').text(cys_pct);
		} else {
			$('#text-drawdown_yearly_expenses_cys').fadeOut();
		}
	}
   
	DrawDownInputsView.prototype.renderMarriage = function(marriage){
		if (marriage == 0){
			$('.viz-figure-col-male').css('opacity', 1);
			$('.viz-figure-col-female').css('opacity', 0);
		} else if (marriage == 1){
			$('.viz-figure-col-male').css('opacity', 0);
			$('.viz-figure-col-female').css('opacity', 1);
		} else if (marriage == 3){
			$('.viz-figure-col-male').css('opacity', 1);
			$('.viz-figure-col-female').css('opacity', 1);
		}
	}
	
	function SquaredAwayModel(){
		this.loadFromDefaults();
		this.loadFromUser();
		this.calculate();
		this.save();
	}
	
	SquaredAwayModel.prototype.loadFromUser = function(){
		var model = this;
		$('.ls-value').each(function(){
			var field = $(this).data('field');
			var userValue = shebangGetValue(field);
			if (userValue != null){
				model[field] = userValue;
			}
		});
	}
	
	SquaredAwayModel.prototype.save = function(){
		for(var i in this){
			var val = this[i];
			shebangSaveValue(i, val);
		}
	}
	
	SquaredAwayModel.prototype.calculate = function(){
		var yearExpenseMult = 1 - (this.drawdown_cut_pct/100);
	
		this.drawdown_monthly_income = this.ss_benefit_amount_self + this.ss_benefit_amount_spouse + this.other_income;
		this.drawdown_yearly_income = 12 * this.drawdown_monthly_income;
		this.drawdown_yearly_expenses = 12 * this.current_monthly_consumption;
		this.drawdown_yearly_expenses_cys = this.drawdown_yearly_expenses*yearExpenseMult;
		var diff = this.drawdown_yearly_expenses_cys - this.drawdown_yearly_income;
		this.drawdown_need_from_savings = this.drawdown_yearly_expenses - this.drawdown_yearly_income;
		this.drawdown_need_from_savings_cys = Math.max(0, diff);
	}
	
	SquaredAwayModel.prototype.loadFromDefaults = function(){
		var model = this;
		var json = $('#shebang_defaults').html();
		var defs = JSON.parse(json);
		for (var i in defs){
			var row = defs[i];
			var key = row.c_key;
			this[key] = row.c_value;
		}
	}
   
	ddi = new DrawDownInputs();

})();