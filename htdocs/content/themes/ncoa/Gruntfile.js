'use strict';

module.exports = function (grunt) {

	var theme_base = 'resources';
	var node_modules = 'node_modules';

	// Load grunt tasks automagically.
	require('load-grunt-config')(grunt, {
		data: {
			paths: {
				base: theme_base,
				node_modules: node_modules,
				src: 'assets',
				dist: theme_base + '/assets',
			}
		}
	});
};