$(document).ready(function(){
	$(".add_tab").addClass("hidden");
//	$(".edit_tab").addClass("hidden");
	$("#search").addClass("toggle_shown");
	$("#add_entry").addClass("toggle_hidden");
//	$("#edit_entry").addClass("toggle_hidden");
	$("#search").click(function(){
		$(".query_results").empty();
		$(this).removeClass("toggle_hidden").addClass("toggle_shown");
		$("#add_entry").removeClass("toggle_shown").addClass("toggle_hidden");
//		$("#edit_entry").removeClass("toggle_shown").addClass("toggle_hidden");
		$(".add_tab").addClass("hidden");
//		$(".edit_tab").addClass("hidden");
		$(".search_tab").removeClass("hidden");
	});
	$("#add_entry").click(function(){
		$("#add").hide();
		$(".query_results").empty();
		$(this).removeClass("toggle_hidden").addClass("toggle_shown");
		$("#search").removeClass("toggle_shown").addClass("toggle_hidden");
//		$("#edit_entry").removeClass("toggle_shown").addClass("toggle_hidden");
		$(".search_tab").addClass("hidden");	
//		$(".edit_tab").addClass("hidden");		
		$(".add_tab").removeClass("hidden");
	});
	/*$("#edit_entry").click(function(){
		$(this).removeClass("toggle_hidden").addClass("toggle_shown");
		$("#search").removeClass("toggle_shown").addClass("toggle_hidden");
		$("#add_entry").removeClass("toggle_shown").addClass("toggle_hidden");
		$(".search_tab").addClass("hidden");	
		$(".add_tab").addClass("hidden");		
		$(".edit_tab").removeClass("hidden");
	});*/
	$(".delete").click(function(e){
		e.preventDefault();
		var myData = "d_id=" + $("#up_d_id").html();
		//console.log($("#up_d_id").html());
		jQuery.ajax({
			type: "GET",
			url: "php/delete.php",
			dataType: "text",
			data: myData,
			success: function(response) {
				console.log("ajax Success!");
				$(".res_form").remove();
				$(".result_title").html("Entry deleted successfully").fadeOut(2000,function(){
					$(this).remove();
					var url = location.href;
					//location.href=url.substring(0, url.indexOf('?'));
				});
			},
			error: function(){
				console.log("Ajax Error!");
			}
		})
	});
	$(".done").click(function(e){
		e.preventDefault();
		var myData = {
			"d_id" : $("#up_d_id").html(),
			"name" : $("#up_name").html(),
			"blood_type" : $("#up_blood_type").html(),
			"contact_no" : $("#up_contact_no").html(),
			"city" : $("#up_city").html(),
			"last_donated" : $("#up_last_donated").html()
		};
		jQuery.ajax({
			type: "GET",
			url: "php/edit.php",
			dataType: "text",
			data: myData,
			success: function(response) {
				console.log("ajax Success!");
				$(".query_results").append("<div id='up_title' class='result_title'>Value updated</div>");
				$("#up_title").css('margin-top',10).fadeOut(3000,function(){
					$(this).remove();
				});
			},
			error: function(){
				console.log("Ajax Error!");
			}
		})
	});
	$("button[name='add']").click(function(e){
		e.preventDefault();
		var myData = {
			"d_id" : null,//$("input[name='d_id']").val(),
			"name" : $("input[name='name']").val(),
			"blood_type" : $("input[name='blood_type']").val(),
			"contact_no" : $("input[name='contact_no']").val(),
			"city" : $("input[name='city']").val(),
			"last_donated" : $("input[name='last_donated']").val()
		};
		jQuery.ajax({
			type: "GET",
			url: "php/add.php",
			dataType: "text",
			data: myData,
			success: function(response) {
				console.log("Ajax Success!");
				$("#add_form").trigger("reset");
				$("#add").html("Entry added successfully").show(function(){
					$(this).fadeOut(3000);
				});
			},
			error: function(){
				console.log("Ajax Error!");
				$("#add").html("Cannot add entry").show(function(){
					$(this).fadeOut(3000);
				});
			}
		})
	});
	$("select.select").change(function(){
		$(this).css("color","black");
	});
});