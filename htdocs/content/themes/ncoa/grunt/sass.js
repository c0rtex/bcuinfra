module.exports = {
    dist: {
        files: [ {
            expand: true,
            cwd:  '<%= paths.src %>/scss',
            src: [ 'main.scss' ],
            dest: '<%= paths.dist %>/css',
            ext: '.css'
        } ]
    },
    styleguide:{
    	files: [
    		{
    			expand: true,
	            cwd:  '<%= paths.src %>/scss',
	            src: [ 'styleguide.scss' ],
	            dest: '<%= paths.dist %>/css',
	            ext: '.css'
    		}
    	]
    }
};