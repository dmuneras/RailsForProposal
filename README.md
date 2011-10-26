RailsForProposal
================

Introduction
------------

Web Application to manage RFPs collaboratively.

This application is developed by students of EAFIT university to improve the managment of RFP inside the companies. 

The application have 2 components: RFP managment and  RFP statistics, the second one is use to identify behaviors
inside the company process and help to find the strengths and weaknesses of the company when its trying to choose
the best RFPs.

Gem list
--------

gem 'rails', '3.0.7'					=> Framework MVC.

gem 'railroady'						=> Gem use to create diagrams.

gem 'nifty-generators', :group => :development          => Gem to generate pretty scaffolds, migrations and more.

gem 'formtastic'	       	  		        => Gem to create in a easier way forms.

gem 'jquery-rails'					=> Gem to add JQUERY(javascript library to the aplication).

gem 'authlogic' 					=> Gem to add the user managment to the application(sessions, current_user).


Plugins list
------------

open_flash_chart                                       => Plugin to create charts in flash format

validation_reflection				       => Plugin to improve the formastic's validations

Server
------

We are using Heroku, but in heroku you can't upload files, for this reason in this host is 
impossible see all the funcionalities of the application. 

