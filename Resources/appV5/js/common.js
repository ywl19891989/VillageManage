// JavaScript Document
$(document).ready(function(){
	set_right_body_width();
});

$(window).resize(function(){
	set_right_body_width();
});

function set_right_body_width(){
	var bodyWidth = $(document.body).width();
	var leftMenuWidth = $('#J_left_menu').width();
	var rightBodyWidth = bodyWidth - leftMenuWidth - 10;
	$('#J_right_body').css('width', rightBodyWidth);
}