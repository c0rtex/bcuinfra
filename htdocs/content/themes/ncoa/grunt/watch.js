module.exports = {
	options: {
    	livereload: false
    },
    gruntfile: {
        files: ['Gruntfile.js']
    },
    sass: {
    	files: [ '<%= paths.src %>/scss/**/*.scss' ],
        tasks: ['build-css']
    },
    scripts:{
        files: [ '<%= paths.src %>/js/**/*.js' ],
        tasks: ['concat:app']
    },
    styleguide:{
        files: [ '<%= paths.src %>/js/**/*.js', '<%= paths.src %>/sass/styleguide.scss', '<%= paths.src %>/sass/pages/_styleguide.scss' ],
        task: ['styleguide']
    }
}