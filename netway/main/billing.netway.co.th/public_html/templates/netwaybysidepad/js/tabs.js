

$(document).ready(function(){
	$(".menu > li, .more, .resellmenu, .primaryMenuSelect > option, .emailtab, .intregratetab > li").click(function(e){
		switch(e.target.id){
			case "subject":
				//change status & style menu
				$("#subject").addClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.subject").fadeIn();
				$("div.learn").css("display", "none");
				$("div.gprice").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "learn":
				//change status & style menu
				$("#subject").removeClass("active");
				$("#learn").addClass("active");
				$("#gprice").removeClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.learn").fadeIn();
				$("div.subject").css("display", "none");
				$("div.gprice").css("display", "none");
				$("div.tab4").css("display", "none");
				$("div.tab5").css("display", "none");
				$("div.tab6").css("display", "none");
				$("div.tab7").css("display", "none");
				$("div.tab8").css("display", "none");
				$("div.tab9").css("display", "none");
				$("div.tab10").css("display", "none");
				$("div.tab11").css("display", "none");
			break;
			case "gprice":
				//change status & style menu
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").addClass("active");
				$("#tab4").removeClass("active");
				$("#tab5").removeClass("active");
				$("#tab6").removeClass("active");
				$("#tab7").removeClass("active");
				$("#tab8").removeClass("active");
				$("#tab9").removeClass("active");
				$("#tab10").removeClass("active");
				$("#tab11").removeClass("active");
				//display selected division, hide others
				$("div.gprice").fadeIn();
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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
				$("#subject").removeClass("active");
				$("#learn").removeClass("active");
				$("#gprice").removeClass("active");
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
				$("div.gprice").css("display", "none");
				$("div.subject").css("display", "none");
				$("div.learn").css("display", "none");
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

$(document).ready(function(){
	$(".team-menu > li").click(function(e){
		switch(e.target.id){
			case "sale":
				//change status & style menu
				$("#sale").addClass("team-active");
				$("#technical").removeClass("team-active");
				//display selected division, hide others
				$("div.sale").fadeIn();
				$("div.technical").css("display", "none");
			break;
			case "technical":
				//change status & style menu
				$("#sale").removeClass("team-active");
				$("#technical").addClass("team-active");
				//display selected division, hide others
				$("div.technical").fadeIn();
				$("div.sale").css("display", "none");
			break;
		}
		//alert(e.target.id);
		return false;
	});
});

$(document).ready(function(){
	$(".website-menu > li").click(function(e){
		switch(e.target.id){
			case "company":
				//change status & style menu
				$("#company").addClass("website-active");
				$("#ecommerce").removeClass("website-active");
				//display selected division, hide others
				$("div.company").fadeIn();
				$("div.ecommerce").css("display", "none");
			break;
			case "ecommerce":
				//change status & style menu
				$("#company").removeClass("website-active");
				$("#ecommerce").addClass("website-active");
				//display selected division, hide others
				$("div.ecommerce").fadeIn();
				$("div.company").css("display", "none");
			break;
		}
		//alert(e.target.id);
		return false;
	});
});

