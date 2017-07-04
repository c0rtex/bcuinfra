'use strict';

// there is a .nvmrc file at the root of the theme that gives a 
// specific node version that we *know* works with the versions
// of node modules indicated in that package.json file. To use
// the version of node in the .nvmrc file, download and start
// using NVM (node version manager)

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