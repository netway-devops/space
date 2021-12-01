 $(document).ready(function(){

 	$("#tab1").click(function(){

		$("#tab1").attr("class", "tab_current");

		$("#tab2").attr("class", "tab_non");

		$("#tab3").attr("class", "tab_non");

		$("#tab4").attr("class", "tab_non");

		

		document.getElementById('divtab1').style.display = '';

		document.getElementById('divtab2').style.display = 'none';

		document.getElementById('divtab3').style.display = 'none';

		document.getElementById('divtab4').style.display = 'none';

 	});

 	$("#tab2").click(function(){

		$("#tab1").attr("class", "tab_non");

		$("#tab2").attr("class", "tab_current");

		$("#tab3").attr("class", "tab_non");

		$("#tab4").attr("class", "tab_non");

		

		document.getElementById('divtab1').style.display = 'none';

		document.getElementById('divtab2').style.display = '';

		document.getElementById('divtab3').style.display = 'none';

		document.getElementById('divtab4').style.display = 'none';

 	});

	$("#tab3").click(function(){

		$("#tab1").attr("class", "tab_non");

		$("#tab2").attr("class", "tab_non");

		$("#tab3").attr("class", "tab_current");

		$("#tab4").attr("class", "tab_non");

		

		document.getElementById('divtab1').style.display = 'none';

		document.getElementById('divtab2').style.display = 'none';

		document.getElementById('divtab3').style.display = '';

		document.getElementById('divtab4').style.display = 'none';

 	});

	$("#tab4").click(function(){

		$("#tab1").attr("class", "tab_non");

		$("#tab2").attr("class", "tab_non");

		$("#tab3").attr("class", "tab_non");

		$("#tab4").attr("class", "tab_current");

		

		document.getElementById('divtab1').style.display = 'none';

		document.getElementById('divtab2').style.display = 'none';

		document.getElementById('divtab3').style.display = 'none';

		document.getElementById('divtab4').style.display = '';

 	});

	

});