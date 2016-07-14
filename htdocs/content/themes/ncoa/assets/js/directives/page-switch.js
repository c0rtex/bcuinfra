app.directive('pageSwitch',['$state', 'Income','$filter', function($state, Income, $filter){
	return {
		link: function(scope, elm){
			
			scope.preState = $state.current.data.prev;
			scope.nextState = $state.current.data.next;
			
			scope.switchPage = function(stateName){
				$state.go(stateName);
			}


			/*
			** When page is changed successfully then populate all options and links with from and to states to go to.
			*/
			scope.$on('$stateChangeSuccess', function() {
				scope.preState = ('data' in $state.current ) ? $state.current.data.prev : '';
				scope.nextState = ('data' in $state.current ) ? $state.current.data.next : '';
				scope.currentState = $state.current.name.split(".")[1];
				scope.isResults = ($state.current.name.split(".")[1] == "results");
				scope.showOptions = ($state.current.name.split('.')[1] == "results" || $state.current.name.split(".")[1] == "initial-results");

				if(document.querySelector('.page-wrapper h1'))
					document.querySelector('.page-wrapper h1').scrollIntoView();
				// else
				// 	document.querySelector('.page').scrollIntoView();
			});


			/*
			** Will watch the changing of state and look for the fincances questions to make sure that if they choose items for the sales grid then it will show that panel if not move to the next panel. This will 
			** also catch if they go back from the results page they won't get the loader again.
			*/
			scope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams, options) {


				var incomes = $filter('filter')(scope.questionnaire.incomes, {selected: true});
				var assets = $filter('filter')(scope.questionnaire.assets, {selected: true});				

				if(fromState.name == "questionnaire.finances-income" && toState.name == "questionnaire.finances-income-grid" && incomes.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets');
				}else if(fromState.name == "questionnaire.finances-assets" && toState.name == "questionnaire.finances-income-grid" && incomes.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-income');
				}else if(fromState.name == "questionnaire.finances-assets" && toState.name == "questionnaire.finances-assets-grid" && assets.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.loader');
				}else if(fromState.name == "questionnaire.results" && toState.name == "questionnaire.finances-assets-grid" && assets.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets');
				}else if(fromState.name == "questionnaire.results" && toState.name == "questionnaire.loader" && assets.length != 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets-grid');
				}else if(fromState.name == "questionnaire.results" && toState.name == "questionnaire.loader" && assets.length == 0){
					event.preventDefault(); 
					$state.transitionTo('questionnaire.finances-assets');
				}
			});


		}
	}
}]);