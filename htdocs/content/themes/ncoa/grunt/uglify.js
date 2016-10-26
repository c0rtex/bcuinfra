module.exports = {
     scripts: {
        files: [
            {
                expand: true,
                cwd: '<%= paths.dist %>/js',
                src: '*.js',
                dest: '<%= paths.dist %>/js'
            }
        ]
    },
};