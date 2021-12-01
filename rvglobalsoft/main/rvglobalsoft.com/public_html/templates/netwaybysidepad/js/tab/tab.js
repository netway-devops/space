

$(document).ready(function(){
	$(".menu > li, .tab_menu, .tab_install").click(function(e){
		switch(e.target.id){
			case "tab1":
				//change status & style menu
				$("#tab1").addClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab1").fadeIn();
				$("div.tab2").css("display", "none");
				$("div.tab3").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab2":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").addClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab2").fadeIn();
				$("div.tab1").css("display", "none");
				$("div.tab3").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab3":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").addClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab3").fadeIn();
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab4":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").addClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab4").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab5":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").addClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab5").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab6":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").addClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab6").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab7":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").addClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab7").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab8":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").addClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab8").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab9":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").addClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab9").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "tab10":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").addClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.tab10").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			
			case "tab11":
				//change status & style menu
				$("#tab1").removeClass("active");
				$("#tab2").removeClass("active");
				$("#tab3").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").addClass("active");
				//display selected division, hide others
				$("div.tab11").fadeIn();
				$("div.tab3").css("display", "none");
				$("div.tab1").css("display", "none");
				$("div.tab2").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
			break;
		}
		//alert(e.target.id);
		return false;
	});
});