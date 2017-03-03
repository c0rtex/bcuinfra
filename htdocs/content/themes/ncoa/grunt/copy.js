module.exports = {
    fonts: {
    	files:[
	    	{
	    		expand: true,
	    		cwd: '<%= paths.node_modules %>/bootstrap-sass/assets/fonts',
		        src: '**/*',
		        dest: '<%= paths.dist %>/fonts/'
		    }
        ]
    },
    chosenpngs:{
    	files:[
	    	{
	    		expand: true,
	    		cwd: '<%= paths.node_modules %>/chosenjs',
		        src: '*.png',
		        dest: '<%= paths.dist %>/images/'
	    	}
    	]
    }

};