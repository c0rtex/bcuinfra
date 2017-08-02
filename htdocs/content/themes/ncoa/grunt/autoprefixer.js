module.exports = {
	options: {
		browsers: ['last 2 versions', 'ie 8', 'ie 9', 'ie 10', 'ie 11']
	},
    dev: {
        expand: true,
        cwd: '<%= paths.dist %>/css',
        src: 'main.css',
        dest: '<%= paths.dist %>/css'
    },
    styleguide: {
        expand: true,
        cwd: '<%= paths.dist %>/css',
        src: 'styleguide.css',
        dest: '<%= paths.dist %>/css'
    }
};