app.directive('medicationSelector',['Drugs', '$state', function(Drugs, $state){
	return {
		restrict: 'E',
		scope: {answer_field:"=answerField"},
		templateUrl: '/content/themes/ncoa/resources/views/directives/med-selector/medication-selector.html?'+(new Date()),
		link: function(scope, elm){

			Drugs.setDrugs(scope.answer_field.options);

			scope.category = $state.params.category;

			var drugs = Drugs.getDrugs();

			for(var i=0; i<drugs.length; i++) {
				var option = $("<option/>",{value:drugs[i].code, text:drugs[i].display});
				option.appendTo($("#multiselect"));
			}

			$("#multiselect").multiSelect({
				selectableHeader: "<p class='bold'>Available Medications</p><input type='text' class='form-control' autocomplete='off' placeholder='Search...'>",
				selectionHeader: "<p class='bold'>My Medication List</p>",
				selectableFooter: "<button class='btn btn-secondary add' disabled>Add to My List</button>",
				selectionFooter: "<button class='btn btn-secondary remove' disabled>Remove from My List</button>",
				afterInit: function(ms){
					var that = this,
						$selectableSearch = that.$selectableUl.prev(),
						selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)';

					that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
						.on('keydown', function(e){
							if (e.which === 40){
								that.$selectableUl.focus();
								return false;
							}
						});
				},
				afterSelect: function(){
					this.qs1.cache();
					$('.ms-selectable .ms-list .selected').removeClass('selected');
					$('.ms-selectable .add').attr('disabled', true);
				},
				afterDeselect: function(values){
					this.qs1.cache();
					$('.ms-selectable .ms-list .selected').removeClass('selected');
					$('.ms-selection .remove').attr('disabled', true);
				}
			});

			$('.ms-selectable').on('click', 'button.add', function(){
				var selected = $('.ms-selectable .ms-list .selected span').map(function(){
					return Drugs.codeByName($(this).html());
				}).get();
				$('#multiselect').multiSelect('select', selected);
				for (var i=0;i<selected.length;i++) {
					scope.$root.answers[scope.category][selected[i]] = 'y';
				}
			});

			$('.ms-selection').on('click', 'button.remove', function(){
				var selected = $('.ms-selection .ms-list .selected span').map(function(){
					return Drugs.codeByName($(this).html());
				}).get();
				$('#multiselect').multiSelect('deselect', selected);
				for (var i=0;i<selected.length;i++) {
					delete scope.$root.answers[scope.category][selected[i]];
				}
			});
		}
	}
}]);