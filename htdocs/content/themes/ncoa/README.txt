# Welcome to the NCOA theme readme!

This theme uses a CSS preprocessor called Sass (compiled via a javascript task manager called Grunt). So please do not make edits manually to any CSS files - because they will be overwritten by Sass and Grunt. 


# Instructions for first time users

  * Use NVM (node version manager) to switch to the version of node indicated in the .nvmrc file at the root of this theme. If you have NVM installed, run 'nvm use' in the terminal at the root of the theme and it will switch automatically
  * Run 'npm install' at the root of the theme to download all of the project-specific node modules listed in the package.json file.


# Instructions for compiling CSS

  * Run 'grunt watch'
  * Make your change to a Scss partial (located in ncoa > assets > scss)
  * Click save (grunt will automatically compiled your Scss into CSS)


# Background

  * In October 2016 Sass was used to create the BenefitsCheckup.org website.
  * Afterwards Sass was not used, and CSS updates were made directly to the compiled CSS file.
  * In May 2017, while doing some major updates to the site with a new agency (Echo&Co), it was decided to use Sass once again to speed up front end work.
  * However since the compiled CSS file had received a large amount of updates since October 2016, the decision was made to convert the compiled CSS into a single partial, and archive the old Sass partials.


# Todo / Open-ended items
  
  * Grunt is currently not being used to handle javascript. Maybe this needs to happen?

