// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$('document').ready(function(){

    $("#add-existing-section").click(function(){

	$("#new_section").css('display', 'block');
	$(this).hide();
	$("#hide-existing-section").css('display', 'block');
    });


    $("#hide-existing-section").click(function(){

	$("#new_section").css('display', 'none');
	$(this).hide();
	$("#add-existing-section").css('display', 'block');
    });

    $("#create-existing-section").click(function(){

	$("#new_section").css('display', 'none');
    });


})