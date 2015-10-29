var cysList;

;(function() {

	function CYSList() {
		this.bindHandlers();
		this.view = new CYSListView();
		this.model = new CYSListModel();
		this.refresh();
	}
   
	CYSList.prototype.bindHandlers = function() {
		$('.trigger-cys-todo').live('click', onActionPlanItemSelect);
		
		$('.add-your-own-amount').numeric();
		
		$('.add-your-own-name').live('blur', function(){
			var input = $(this);
			var cb = input.closest('tr').find('input:checkbox');
			cb.val(input.val());
			input.data('checkbox', cb);
		});
		
		$('.add-your-own-amount').live('blur', function(){
			var input = $(this);
			var cb = input.closest('tr').find('input:checkbox');
			cb.attr('data-amount', input.val());
			input.data('checkbox', cb);
			trace(cb.data('id'));
			THIS.model.updateField(cb.data('id'), 'amount', input.val());
			THIS.refresh();
		});
		
		
		var THIS = this;
		
		function onActionPlanItemSelect(e){
			var cb = $(this);
			var id = cb.data('id');
			var body = $('body');
			var tr = cb.closest('tr');
			var value = cb.data('amount');
			var text = cb.val();
			
			if (cb.is(':checked')){	
				trace('check');
				$('.cys-todo-id-'+id).attr('checked', 'true');
				THIS.sailToActionPlan(cb, text, value, id, true);
				tr.find('.checkbox-label').addClass('green');
				THIS.saveToDo(cb, value, id, cb.data('parent'));
				if (body.hasClass('where-people-spend-2')){
					setTimeout(checkSavingsAgainstGoal, 1250);
				} 
			} else {
				trace('uncheck');
				$('.cys-todo-id-'+id).each(function(){
					$(this).removeAttr('checked');
				});
				tr.find('.checkbox-label').removeClass('green');
				THIS.deleteToDo(id);
			}
			THIS.refresh();
		}
	}
	
	CYSList.prototype.reset = function(){
		this.model.reset();
	}
	
	CYSList.prototype.refresh = function(){
		this.model.refresh();
		var savings = this.model.savings;
		var goal = this.model.goal;
		var pct = savings/goal;
		for (var i = 0; i<this.model.todos.length; i++){
			var cb = null;
			var todo = this.model.todos[i];
			this.view.addToActionPlan(cb, todo.label, todo.amount, todo.id);
		}
		this.view.updateSavings(savings);
		this.view.updateGoalBar(pct);
		this.view.updateChecks(this.model.todos);
		this.view.updateValues(this.model.todos);
	}
	
	CYSList.prototype.deleteToDo = function(id){
		this.model.delete(id);
		this.view.removeFromActionPlan(id);
	}
	
	CYSList.prototype.saveToDo = function(cb, amount, id, parent){
		this.model.add(cb.val(), amount, id, parent);
	}
   
   	CYSList.prototype.sailToActionPlan = function(cb, text, value, id, animate){
   		if (animate){
   			trace('sailing!!!');
			this.view.sailToActionPlan(cb, text);
		}
		this.view.addToActionPlan(cb, text, value, id);
	}
	
	function CYSListView(){
   		this.actionPlanMenu = new ActionPlanMenu();
	}
   
	CYSListView.prototype.sailToActionPlan = function(cb, text){
		var tr = cb.closest('tr');
		/* something with sail to is broken will fix at some point*/
		tr.sailTo($('#action-menu'), {duration:800, text:text, textTarget:'.action-menu-action-h1 .action-item'});
	}
	
	CYSListView.prototype.refresh = function(){
		//this.refreshGoalAmount();
	}
	
	CYSListView.prototype.removeFromActionPlan = function(id){
		this.actionPlanMenu.remove(id);
	}
	
	CYSListView.prototype.addToActionPlan = function(cb, text, value, id){
		if (this.actionPlanMenu.idExists(id)){
			trace('update');
			this.actionPlanMenu.update(cb, text, value, id);
		} else {
			trace('add');
			this.actionPlanMenu.add(cb, text, value, id);
		}
		this.actionPlanMenu.refresh();
	}
	
	CYSListView.prototype.updateValues = function(todos){
		for (var i = 0; i<todos.length; i++){
			var todo = todos[i];
			// add-your-own-amount 
			
			var cb= $('.cys-todo-id-'+todo.id);
			var tr = cb.closest('tr');
			var input = tr.find('input.spending-savings');
			trace(input);
			input.val(todo.amount);
			var span = tr.find('.spending-savings-value');
			span.text(todo.amount);
			cb.attr('data-amount', todo.amount);
		}
	}
	
	CYSListView.prototype.updateChecks = function(todos){
		for (var i = 0; i<todos.length; i++){
			var id = todos[i].id;
			$('.cys-todo-id-'+id).attr('checked', 'checked');
		}
	}
	
	CYSListView.prototype.updateSavings = function(savings){
		var from = 'cv';
		if (!$('.money-saved .money-number .value.saved').val()){
			from = 0;
		}
		$('.money-saved .money-number .value.saved').countTo({to:savings, from:from, speed:400, addCommas:true});
	}
	
	CYSListView.prototype.updateGoalBar = function(pct){
		pct = Math.min(pct, 1);
		var pt = pct * 100;
		var mbl = $('.money-bar-leader');
		mbl.css({width:pt + '%'});
	}
	
	function ActionPlanMenu(){
		this.ids = new Array();
	}
	
	
	ActionPlanMenu.prototype.add = function(cb, text, value, id){
		this.ids.push(id);
		var liString = '<tr class="row-3 action-drawer-item" data-tdid="'+id+'" data-id="'+id+'"><td class="todo-type unchecked first"><label for="tires" class="checkbox-label">'+text+'</label></td><td class="todo-savings last">';
		if (value){
			liString += '<span class="dollar">$</span><span class="amount">'+value+'</span>';
		}
		liString += '</td></tr>';
		var li = $(liString);
		trace(li);
		$('.everyday-table .todo-table-body').append(li);
		$('.todo-no-items').hide();
	}
	
	ActionPlanMenu.prototype.update = function(cb, text, amt, tdid){
		var tr = $('.todo-section [data-tdid="'+tdid+'"]');
		tr.find('.amount').text(amt);
		tr.find('label').text(text);
	}
	
	ActionPlanMenu.prototype.remove = function(id){
		_.without(this.ids, id);
		$('tr[data-id="'+id+'"]').remove();
	}
	
	ActionPlanMenu.prototype.refresh = function(){
		$('.todo-table').each(function(){
			var table = $(this);
			if (table.find('td').length){
				table.show();
				table.closest('.todo-section').show();
			} else {
				table.closest('.todo-section').hide();
			}	
		});
	}
	
	ActionPlanMenu.prototype.idExists = function(id){
		var yes = _.indexOf(this.ids, id);
		if (yes > -1){
			return true;
		}
		return false;
	}
   
	function CYSListModel(){
		this.savings = shebangGetValue('cys_savings', 0);
		this.goal = shebangGetValue('cys_monthly_goal', 0);
		if (!this.goal){
			this.goal = shebangGetValue('cys_yearly_goal') / 12;
		}
   		this.todos = new Array();
   		if (shebangGetValue('cys_todos')){
   			this.todos = shebangGetValue('cys_todos');
   		}
	}
	
	CYSListModel.prototype.reset = function(){
		this.todos = new Array();
		this.save();
	}
	
	CYSListModel.prototype.add = function(label, amount, id, parent){
		var obj = {amount:amount, status:'new', label:label, id:id, parent:parent};
		this.todos.push(obj);
		if (name){
			this.save();
		}
	}
	
	CYSListModel.prototype.save = function(){
		shebangSaveValue('cys_todos', this.todos);
		shebangSaveValue('cys_savings', this.savings);
	}
	
	CYSListModel.prototype.find = function(id){
		for (var i = 0; i<this.todos.length; i++){
			var td = this.todos[i];
			trace(td.id);
			if (td.id == id){
				return i;
			}
		}
		return -1;
	}
	
	CYSListModel.prototype.updateField = function(id, field, value){
		var i = this.find(id);
		if (i < 0){
			trace('No index found');
			return;
		}
		this.todos[i][field] = value;
		this.save();
	}
	
	CYSListModel.prototype.updateStatus = function(id, status){
		var index = this.find(id);
		this.todos[index].status = status;
		this.save();
	}
	
	CYSListModel.prototype.refresh = function(){
		var savings = 0;
		for (var i = 0; i<this.todos.length; i++){
			var todo = this.todos[i];
			if (todo.amount){
				savings += parseInt(todo.amount);
			}
		}
		this.savings = savings;
		this.save();
	}
	
	CYSListModel.prototype.delete = function(id){
		var index = this.find(id);
		if (index > -1){
			if (this.todos.length == 1){
				this.todos = new Array();
			} else {
				var na = new Array();
				for (var i = 0; i<this.todos.length; i++){
					if (this.todos[i].id != id){
						na.push(this.todos[i]);
					}
				}
				this.todos = na;
			}
			this.save();
		}
	}
   
	cysList = new CYSList();

})();