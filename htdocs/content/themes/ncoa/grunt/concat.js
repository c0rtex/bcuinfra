module.exports = {
	libs: {
		src:[
			'<%= paths.node_modules %>/jquery/dist/jquery.js',
			'<%= paths.node_modules %>/angular/angular.js',
			'<%= paths.node_modules %>/angular-route/angular-route.js',
			'<%= paths.node_modules %>/angular-ui-router/release/angular-ui-router.js',
			'<%= paths.node_modules %>/angular-animate/angular-animate.js',
			'<%= paths.node_modules %>/angular-scroll/angular-scroll.js',
			'<%= paths.node_modules %>/angular-local-storage/dist/angular-local-storage.js',
			'<%= paths.node_modules %>/bootstrap-sass/assets/javascripts/bootstrap.js',	
			'<%= paths.node_modules %>/odometer/odometer.js',
			'<%= paths.node_modules %>/slick-carousel/slick/slick.js'
		],
		dest: '<%= paths.dist %>/js/libs.js'
	},
	app: {
		src:[		
			'<%= paths.src %>/js/app.js',
			'<%= paths.src %>/js/directives/**/*.js',			
			'<%= paths.src %>/js/services/**/*.js',
			'<%= paths.src %>/js/factory/**/*.js',
			'<%= paths.src %>/js/controllers/**/*.js',
			'<%= paths.src %>/js/map/map-config.js',
			'<%= paths.src %>/js/map/pin-config.js',
			'<%= paths.src %>/js/map/map-interact.js',
			'<%= paths.src %>/js/jquery.quicksearch.js',
			'<%= paths.src %>/js/jquery.multiselect.js'
		],
		dest: '<%= paths.dist %>/js/app.js'
	},
	styleguide: {
		src:[
			'<%= paths.src %>/js/styleguide.js',
			'<%= paths.src %>/js/directives/**/*.js'
			
		],
		dest: '<%= paths.dist %>/js/styleguide.js'
	}
};