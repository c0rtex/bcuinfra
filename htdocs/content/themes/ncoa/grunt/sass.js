module.exports = {
    options: {
        outputStyle: "compressed"
    },
    dist: {
        files: [ {
            expand: true,
            cwd:  '<%= paths.src %>/scss',
            src: [ 'main.scss', 'main-vendor.scss', 'print.scss' ],
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