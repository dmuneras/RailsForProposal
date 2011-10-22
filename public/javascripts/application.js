// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$('document').ready(function(){
    
    $("ul.tabs").tabs("div.panes > div.container");
  
    $(".user-nav div").mouseover(function(){
	$(this).css('background-color','#000');	
	$(this).children("a").css('color', "#fff");
    });
   
    $(".user-nav div").mouseout(function(){
	$(this).css('background-color', '#93988F');
	$("#user-nav div a").css('color', "#000");	
    });


    $('input.ui-datepicker').dateinput({
	format: 'dddd / dd.mm.yyyy',
	change: function() {
		var isoDate = this.getValue('yyyy-mm-dd');

		$("#backendValue").val(isoDate);
	}	
    });

    $("#add-existing-section").click(function(){
	$("#new_section").css({'display':'block', 'background-color' : '#93988F'});
	$(this).hide();
	$("#exposeMask").show(400);
	$('#new_section').expose();
    });


    $("#hide-existing-section").click(function(){
	$("#add-existing-section").css('display', 'block');
	$("#new_section").hide(400);
	$("#exposeMask").hide(400);

    });

    $("#create-existing-section").click(function(){

	$("#new_section").css('display', 'none');
    });

    $("#general-info").tabs("#general-info div.pane", {tabs: 'h2', effect: 'slide', initialIndex: null});

  
});