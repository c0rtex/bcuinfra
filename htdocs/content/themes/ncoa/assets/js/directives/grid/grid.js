app.directive('grid', [function () {
	return {
	  restrict: 'E',
	  scope: {
	  	title: "@",
	  	description: "@"
	  },
	  templateUrl: '/content/themes/ncoa/resources/views/directives/grid/grid-tpl.html',
	  link: function (scope, element, attr) {
	  	
	  }
	}
}]);