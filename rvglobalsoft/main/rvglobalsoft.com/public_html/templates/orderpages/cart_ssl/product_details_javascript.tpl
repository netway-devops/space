<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="{$template_dir}css/jquery.datetimepicker.css"/ >
<script src="{$template_dir}js/jquerydate.js"></script>
<script src="{$template_dir}js/jquery.datetimepicker.js"></script>-->
<style>
{literal}
.divTable {
    display:  table;
    width: 100%;
    background-color:#e4e4e4;
    border:0px solid  #dfdfdf;
    border-spacing:5px;
    padding:10px 0px;
    /*cellspacing:poor IE support for  this*/
    /* border-collapse:separate;*/
}
.divRow {
    display:table-row;
    width:auto;
}
.divCell {
    float:left;/*fix for  buggy browsers*/
    display:table-column;
    width:auto;
    text-align: left;
    padding-left: 10px;
    /* background-color:#ccc; */
}

#progressBar {
        width: 400px;
        height: 22px;
        border: 1px solid #111;
        background-color: #292929;
}
#progressBar div {
        height: 100%;
        color: #fff;
        text-align: right;
        line-height: 22px; /* same as #progressBar height if we want text middle aligned */
        width: 0;
        background-color: #0099ff;
}

{/literal}
</style>

<script type="text/javascript">;
var chkinOrder = "{$chkinOrder}";
var RVL_TEMPLATE_URL = "{$template_dir}";
var RVL_BASEURL = "{$ca_url}";
var cartItems       = "{$cartItems}";
var domainName = "";

{literal}

$(document).ready(function(){
  var Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3}}return t}}
  $('.hidSAN').hide();
  $('.hidSERV').hide();

  $('.showSAN').click(function(){
    $('.hidSAN').show();
    $('.showSAN').hide();
  });

  $('#cancelSAN').click(function(){
    $('.hidSAN').hide();
    $('.showSAN').show();
    $('#additional_domain').val('0');
    $('#price_summary_san_num').text('0');
    $('#price_summary_san_plural').text('');
    updatePrice();
  });

  $('#cancelSERV').click(function(){
    $('.hidSERV').hide();
    $('.showSERV').show();
    $('#additional_server').val(1);
    $('#price_summary_server_num').text('0');
    $('#price_summary_server_plural').text('');
    updatePrice();
  });

  $('.showSERV').click(function(){
    $('.hidSERV').show();
    $('.showSERV').hide();
  });

  $('.priceClass').change(function(){
    var id = $(this).val();
    var price = $('#priceNum' + id).val();
    var support_san = $('#support_san').val();
    var sText = (id/12 > 1) ? 's' : '';
    if(support_san){
        $('#sanInfoPrice').html(numberWithCommas(getSANPrice()));
        $('#perYear').text(id/12 + ' year' + sText);
    }
    $('#price_summary_product_year').text(id/12 + ' Year' + sText);

    $('#selectedPrice').val(price);

    $('.priceBox').css('border', '4px solid grey');
    $('.priceHead').css('background-color', 'black');
    $('.priceSave').attr('color', 'black');
    $('#priceBox' + id).css('border', '4px solid #73c90e');
    $('#priceHead' + id).css('background-color', '#7ed320');
    $('#priceSave' + id).attr('color', '#7ed320');

    $('#selectedPrice').val(price);

    if(id != 12){
        $("#hashing option[value*='SHA1']").prop('disabled', true);
        $('#hashing').val('SHA2-256');
    } else {
        $("#hashing option[value*='SHA1']").prop('disabled', false);
    }

    var coupon_data = $('#promo_code_data').val();
    if(typeof coupon_data != 'undefined' && coupon_data != ''){
        chkCoupon($('#promo_code_text').val().trim(), $('input[class=priceClass]:checked', '#frmMr').val(), $('#ssl_id').val(), $('#cid').val())
    } else {
        $('#promo_code_error').html('');
        updatePrice();
    }
  });

  $('#additional_domain').change(function(){
    $('#price_summary_san_num').text($('#additional_domain').val());
    if($('#additional_domain').val() > 1){
        $('#price_summary_san_plural').text('s');
    } else {
        $('#price_summary_san_plural').text('');
    }

    updatePrice();
  });

  $('#additional_server').change(function(){
    $('#price_summary_server_num').text($('#additional_server').val()-1);
    if($('#additional_server').val()-1 > 1){
        $('#price_summary_server_plural').text('s');
    } else {
        $('#price_summary_server_plural').text('');
    }

    updatePrice();
  });

  function getSANPrice(){
    var period = $('input[class=priceClass]:checked', '#frmMr').val();
    var pSan = '{/literal}{$sanPriceJS}{literal}';
    pSan = JSON.parse(pSan);
    pSan = parseFloat(pSan[period]).toFixed(2);

    if(pSan == 'NaN'){
        pSan = 0.00;
    }

    return pSan;
  }

  function numberWithCommas(x) {
    x = x.toString();
    //x = x.replace('.00', '');
    return x.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

  function updatePrice(){
    var price = $('#selectedPrice').val().replace(',', '');
    var support_san = $('#support_san').val();
    var san = 0;
    var serv = 1;
    var pSan = 0;
    var pServ = 0;
    var priceSan = 0.00;
    var priceServ = 0.00;

    if(support_san){
        var san = (typeof $('#additional_domain').val() != 'undefined') ? $('#additional_domain').val() : 0.00;
        var serv = (typeof $('#additional_server').val() != 'undefined' && $('#additional_server').val() > 0) ? $('#additional_server').val() : 1;
        var pSan = getSANPrice();
        var pServ = {/literal}{$servPrice|number_format:2}{literal};

        var priceSan = parseFloat(san*pSan).toFixed(2);
        var priceServ = ((serv*(parseFloat(price) + parseFloat(san*pSan)))-(parseFloat(price) + parseFloat(san*pSan))).toFixed(2);
        $('#price_summary_san_price').text(numberWithCommas(priceSan));
        $('#price_summary_server_price').text(numberWithCommas(priceServ));

    }

    $('#price_summary_product_price').text(numberWithCommas(price));
    var total = serv*(parseFloat(price) + parseFloat(san*pSan));// + parseFloat(serv*pServ);
    total = total.toFixed(2);

    var coupon_data = $('#promo_code_data').val();
    if(typeof coupon_data != 'undefined' && coupon_data != ''){
        coupon_data = JSON.parse(Base64.decode(coupon_data));
        var mainPrice = price;
        var calPrice = price;
        var haveType = false;
        // price = main
        // san = priceSan
        // serv = priceServ
        priceSan = parseFloat(priceSan);
        serv = parseFloat(serv);
        var discount = 0.00;
        var specialCode = false;

        switch(coupon_data.type){
            case 'fixed' :
                calPrice -= coupon_data.value;
                haveType = true;
                break;
            case 'percent' :
                cal = (100-coupon_data.value)/100;
                calPrice *= cal;
                haveType = true;
                if(coupon_data.value == 100.00 || coupon_data.value == '100.00'){
                    specialCode = true;
                }
                break;
        }

        if(haveType){
            sum = (calPrice+priceSan)*(serv-1);
            discount += mainPrice-calPrice;
            discount += priceServ-sum;
            discount = discount.toFixed(2);
            sum += calPrice;
            sum += priceSan;
            sum = sum.toFixed(2);

            $('#totalPrice').val(sum);
            $('#totalShow').text(numberWithCommas(sum));
            $('#promo_code_discount').text(numberWithCommas(discount));

            $('#promo_code_used').val(1);
            $('.promo_code_discount_div').show();
            $('#promo_code_name').text(coupon_data.code);
            $('#promo_code_code').val(coupon_data.code);

            if(specialCode){
                $('#totalShow').text('0.01');
                $('#promo_code_discount').text(numberWithCommas(total-0.01));
            }
        } else {
            $('#totalPrice').val(total);
            $('#totalShow').text(numberWithCommas(total));
        }
    } else {
        $('#totalPrice').val(total);
        $('#totalShow').text(numberWithCommas(total));
    }

  }

  function chkCoupon(code, cycle, pid, cid){
    $('#promo_code_error').html('');
    $('.boxTable').addLoader();
    $.ajax({
        url: RVL_BASEURL,
        type: 'POST',
        data:  {
            cmd: 'module'
            , module: 'ssl'
            , action: 'ajax_get_promo_code'
            , code : code
            , pid : pid
            , cyc : cycle
            , cid : cid
        },
        success: function(data){
            $('#preloader').hide();
            aResponse = data.aResponse;
            //console.log(aResponse);
            if(typeof aResponse.messageError != 'undefined'){
                $('#promo_code_text').val('');
                $('#promo_code_div').hide();
                $('#promo_code_link').show();
                $('#promo_code_used').val(0);
                $('#promo_code_code').val('');
                $('#promo_code_data').val('');
                $('.promo_code_discount_div').hide();
                $('#promo_code_error').html(aResponse.messageError);
            } else {
                $('#promo_code_error').html('');
            }
            updatePrice();
        }
    });
  }

  $('#nextButton').click(function(){
    $('#nextButton').hide();
    $('#nextStep').show();
    $('#additional_domain').attr('disabled', true);
    $('#additional_server').attr('disabled', true);
    $('#cancelSAN').hide();
    $('#cancelSERV').hide();
  });

  $('#backFirst').click(function(){
    $('#nextButton').show();
    $('#nextStep').hide();
    $('#additional_domain').attr('disabled', false);
    $('#additional_server').attr('disabled', false);
    $('#cancelSAN').show();
    $('#cancelSERV').show();
  });

  $("#change_ssl").change(function(){
      if($(this).val() != 'Change SSL'){
          location = 'index.php?/cart/ssl&rvaction=chklogin&ssl_id='+$(this).val();
      }
  });

  $("#editCSR").click(function(){
      $(".format_textarea").show();
      $(".order").hide();
  });

  /*$("#submitCSROption1").change(function(){
      $("#toselect").show();
      $(".format_textarea").toggle();
      $(".csr_data").focus();
      $("#submitcsrlaster").hide();
  });*/
  $("#submitCSROption0").click(function(){
      $(".format_textarea").hide();
      $("#submitcsrlaster").show();
      $(".order").hide();
      $("#editCSR").hide();
      $("#csr_data").val('');
      $('#progressBar').hide();
      $( '#csr_errorblock' ).html('');
  });

  $("#upload_csr").live( 'change', function () {
      $("#submit_upload_csr").click();
      $('#form_upload_csr').trigger("reset");
  });

  $("#form_upload_csr").submit(function(){
         var formObj = $(this);
                var formURL = formObj.attr("action");
                var formData = new FormData(this);
                $.ajax({
                    url: formURL,
                    type: 'POST',
                    data:  formData,
                    mimeType:"multipart/form-data",
                    contentType: false,
                    cache: false,
                    processData:false,
                    dataType: 'json',
                success: function(data)
                {
                    console.log(data);
                    if (data.aResponse == undefined) {
                        alert('ERROR: Cannot get response!!');
                        return false;
                    } else {
                        aResponse = data.aResponse;
                    }

                    if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                        alert('ERROR: ' + aResponse.message);
                        return false;
                    } else if (aResponse.status != undefined && aResponse.status == 'success') {
                       $("#csr_data").val(aResponse.message);
                    } else {
                        alert('ERROR: Cannot process !!');
                        return false;
                    }
                }
                });
  });

  $("#ch_same_address").change(function() {
            $(".not_same_address").toggle();

  });

  $("#hide").click(function(){
    $("div.products-detail").hide();
  });

  $("#show").click(function(){
    $("div.products-detail").show();
  });

  //$("#submitcsrlaster").hide();
  $("input[name=checkbox]").click(function(){
  		$("#submitcsrnow, #submitcsrlaster").toggle();
  });

  //$( "#txt_date" ).datetimepicker();

  /////////////////// main /////////////////////////
  checksslincart();
  $('#csr_whoistomain').hide();
  csrmodule();
  /*$("#checkbox").change(function() {
    	if(this.checked) {
        	$("#fieldcontact").val("0");
        	$("#csr_data").val('');
        	$('#progressBar').hide();
   			$('.order').hide();
   			$('.step2').hide();
   			$('.step3').hide();

    	}
    	 else {
    	 	$("#fieldcontact").val("");
    	 }
	});*/
  /////////////////////////////////////////////////



  function checksslincart(){
  	if(chkinOrder == 1){
  		if(cartItems > 0) {
//        	$.get('{/literal}{$system_url}{$ca_url}{literal}cart&cart=clear&order=0&idx='+ cartItems, function (data) {
//            		cartItems--;
//            		return false;
//        		});
//    		}

	  		var myIntv  = setInterval(function (){
	            $.get('{/literal}{$system_url}{$ca_url}{literal}cart&cart=clear&order=0&idx='+ cartItems, function (data) {
	                cartItems--;
		            if (cartItems < 0) {
		            	clearInterval(myIntv);
		            }
	            });
	        }, 1500);
  		}
	}
  }

 //////////////// csr module //////////////////////
  function csrmodule() {
  	$('#progressBar').hide();
   	$('.order').hide();
   	$('.step2').hide();
   	$('.step3').hide();

   	$("#validate_button").click(function() {
   		$("#fieldcontact").val("1");
        $('#progressBar').show();
        progress(1, $('#progressBar'));
        $('.order').hide();
        $('.step2').hide();
        $('.step3').hide();


       	$('#whois_domaininfo').html('');
        $('#whois_emailinfo').html('');
       	var csr = $("#csr_data").val();
        var sslId = $( "#ssl_id" ).val();

        validateCsr(sslId ,csr);

    });
    function progress(percent, $element) {
        var progressBarWidth = percent * $element.width() / 100;
        $element.find('div').animate({ width: progressBarWidth }, 500).html(percent + "%&nbsp;");
    }


   	 function validateCsr(sslId, csr)
    {
        progress(10, $( '#progressBar'));
        writeCsrError('');
        var clientContact = {};
        var isSan = false;
        $.ajax({
            type: "POST"
            , url: RVL_BASEURL
            , data: {
                cmd: 'module'
                , module: 'ssl'
                , action: 'getClientContact'
                , client_login_id: $('#client_login_id').val()
            }
            , success: function(data){
                progress(20, $('#progressBar'));
                if (data.aResponse == undefined) {
                    writeCsrError("Cannot get client contact id!!");
                    return false;
                } else {
                    aResponse = data.aResponse;
                    clientContact.firstname = aResponse.firstname;
                    clientContact.lastname = aResponse.lastname;
                    clientContact.email = aResponse.email;
                    clientContact.companyname = aResponse.companyname;
                    clientContact.address = aResponse.address1;
                    clientContact.city = aResponse.city;
                    clientContact.state = aResponse.state;
                    clientContact.country = aResponse.country;
                    clientContact.postcode = aResponse.postcode;
                    clientContact.phonenumber = aResponse.phonenumber;
                    clientContact.job = '';
                    clientContact.ext = '';
                    if(aResponse.address2 != undefined && aResponse.address2 != ''){
                        clientContact.address += ' ' + aResponse.address2;
                    }
                    if(aResponse.address3 != undefined && aResponse.address3 != ''){
                        clientContact.address += ' ' + aResponse.address3;
                    }
                    console.log(clientContact);
                }
                $.ajax({
                    type: "POST"
                    , url: RVL_BASEURL
                    , data: {
                        cmd: 'module'
                        , module: 'ssl'
                        , action: 'ajax_parse_csr'
                        , ssl_id: sslId
                        , csr: csr
                        }
                    , success: function(data) {
                        console.log(data);
                        progress(40, $( '#progressBar'));
                        if (data.aResponse == undefined) {
                            writeCsrError("Cannot get response from api!!");
                            return false;
                        } else {
                            aResponse = data.aResponse;
                        }

                        if (!aResponse.Status) {
                            writeCsrError(aResponse.Error[0].ErrorMessage);
                            return false;
                        }

                        if (aResponse.Status != undefined && aResponse.Status) {
                            progress(50, $('#progressBar'));
                            arrayCsrKey = ['CN', 'O', 'OU', 'L', 'ST', 'C', 'KeyAlgorithm', 'KeyLength', 'Signature'];
                            arrayCsrKey = ['CommonName', 'Organization', 'OrganizationUnit', 'Locality', 'State', 'Country', 'KeyAlgorithm', 'SignatureAlgorithm'];
                            var isWildCard = $('#wild_card').val();
                            if (aResponse.Status) {
                                onError = 0;
                                csrData = aResponse;

                                if(isWildCard == '1'){
                                    if(csrData['CommonName'].toLowerCase().substring(0, 2) != '*.'){
                                        writeCsrError('CSR for SSL Certificate Wildcard must be generated with the common name started with "*" only (' + csrData['CommonName'] + ').');
                                        return false;
                                    }
                                } else {
                                    if(csrData['CommonName'].toLowerCase().substring(0, 2) == '*.'){
                                        writeCsrError('Any CSR consists "*" in the common name will not be able to submit here. (Except SSL Certificate with Wildcard)');
                                        return false;
                                    }
                                }

                                if(csrData['CommonName'].toLowerCase().substr(-4) != '.jp'){
                                    for (key in arrayCsrKey) {
                                        id = 'csr_' + arrayCsrKey[key].toLowerCase();
                                        writeCsrStatus(id, '');
                                        if (typeof csrData[arrayCsrKey[key]] != 'undefined') {
                                            writeCsrData(id, csrData[arrayCsrKey[key]]);
                                            if (id == 'csr_commonname') {
                                                $('#commonname').val(csrData[arrayCsrKey[key]]);
                                            }
                                        } else {
                                            writeCsrData(id, '');
                                        }
                                    }

                                    $('.step2').show();
                                } else {
                                    writeCsrError("Sorry, any CSR generated with the common name as .jp extension as your \"" + csrData['CommonName'] + "\" cannot be ordered SSL Certificate here.");
                                    onError = 1;
                                }

                                if (onError == 0) {
                                    progress(60, $('#progressBar'));
                                    $.ajax({
                                        type: "POST"
                                        , url: RVL_BASEURL
                                        , data: {
                                            cmd: 'module'
                                            , module: 'ssl'
                                            , action: 'getwhoisdomain'
                                            , domain: csrData.CommonName
                                        }
                                        , success: function(data) {
                                            console.log(data);
                                            progress(80, $('#progressBar'));

                                            if (data.aResponse == undefined) {
                                                writeCsrError("Cannot get response from api!!");
                                                return false;
                                            }

                                            whoisData = data.aResponse;
                                            regrinfo = {
                                                owner: {},
                                                tech: {},
                                                admin: {}
                                            };

                                            //if(whoisData.admin.warning == 'no address' && whoisData.tech.warning == 'no address' && whoisData.owner.warning == 'no address'){
                                                //$('.whoisWarning').show();
                                            //}

                                            if(typeof whoisData.admin != 'undefined'){
                                                if(typeof whoisData.admin.firstName != 'undefined'){
                                                    $('#txt_name').val(whoisData.admin.firstName);
                                                }
                                                if(typeof whoisData.admin.lastName != 'undefined' && whoisData.admin.lastName != null){
                                                    $('#txt_lastname').val(whoisData.admin.lastName);
                                                }
                                                if(typeof whoisData.admin.email != 'undefined' && whoisData.admin.email != null){
                                                    $('#txt_email').val(whoisData.admin.email);
                                                }
                                                if(typeof whoisData.admin.organization != 'undefined' && whoisData.admin.organization != null){
                                                    $('#txt_org').val(whoisData.admin.organization);
                                                }
                                                if(typeof whoisData.admin.address != 'undefined' && whoisData.admin.address != null){
                                                    $('#txt_address').val(whoisData.admin.address);
                                                }
                                                if(typeof whoisData.admin.city != 'undefined' && whoisData.admin.city != null){
                                                    $('#txt_city').val(whoisData.admin.city);
                                                }
                                                if(typeof whoisData.admin.state != 'undefined' && whoisData.admin.state != null){
                                                    $('#txt_state').val(whoisData.admin.state);
                                                }
                                                if(typeof whoisData.admin.country != 'undefined' && whoisData.admin.country != null){
                                                    $('#txt_country').val(whoisData.admin.country);
                                                }
                                                if(typeof whoisData.admin.postal != 'undefined' && whoisData.admin.postal != null){
                                                    $('#txt_post').val(whoisData.admin.postal);
                                                }
                                                if(typeof whoisData.admin.phone != 'undefined' && whoisData.admin.phone != null){
                                                    $('#txt_tel').val(whoisData.admin.phone);
                                                }
                                                $('#txt_job').val('');
                                                $('#txt_ext').val('');
                                            }

                                            $.ajax({
                                                type: "POST"
                                                , url: RVL_BASEURL
                                                , data: {
                                                    cmd: 'module'
                                                    , module: 'ssl'
                                                    , action: 'ajax_getemaillist'
                                                    , domain: csrData.CommonName
                                                }
                                                , success: function(data) {
                                                    emailApprovalList = data.aResponse;
                                                    emailApprovalOtp = '';
                                                    console.log(emailApprovalList);
                                                    var emailApprovalDup = [];
                                                    var emailApprovalKey = [];
                                                    if(typeof emailApprovalList != 'undefined' ){
                                                        for(i = 0; i < emailApprovalList.length; i++){
                                                            splitEmail = emailApprovalList[i].split('@');
                                                            if(typeof emailApprovalDup[splitEmail[1]] == 'undefined'){
                                                                emailApprovalDup[splitEmail[1]] = [];
                                                                emailApprovalKey.push(splitEmail[1]);
                                                            }
                                                            emailApprovalDup[splitEmail[1]].push(emailApprovalList[i]);
                                                        }
                                                    
                                                    }
                                                    ind = 1;
                                                    for(j = 0; j < emailApprovalKey.length; j++){
                                                        headChk = 0;
                                                        for(i = 0; i < emailApprovalDup[emailApprovalKey[j]].length; i++){
                                                            if(headChk == 0){
                                                                if(emailApprovalDup[emailApprovalKey[j]].length <= 2){
                                                                    emailApprovalOtp = emailApprovalOtp + '<b>Registered Domain Contacts</b><br>';
                                                                    headChk = 1;
                                                                } else {
                                                                    switch(emailApprovalKey[j].split('.').length){
                                                                        case 2:
                                                                            emailApprovalOtp = emailApprovalOtp + '<b>Level 2 Domain Addresses</b><br>';
                                                                            headChk = 1;
                                                                            break;
                                                                        case 3:
                                                                            emailApprovalOtp = emailApprovalOtp + '<b>Level 3 Domain Addresses</b><br>';
                                                                            headChk = 1;
                                                                            break;
                                                                        case 4:
                                                                            emailApprovalOtp = emailApprovalOtp + '<b>Level 4 Domain Addresses</b><br>';
                                                                            headChk = 1;
                                                                            break;
                                                                    }
                                                                }
                                                            }
                                                            emailApprovalOtp = emailApprovalOtp
                                                                + '<label for="email_approval_' + ind + '">'
                                                                + '<input type="radio" id="email_approval_' + ind
                                                                + '" name="email_approval" value="'+ emailApprovalDup[emailApprovalKey[j]][i] +'" />'
                                                                + emailApprovalDup[emailApprovalKey[j]][i] + '</label><br>';
                                                            ind = ind+1;
                                                        }
                                                        emailApprovalOtp = emailApprovalOtp + '<br>';
                                                    }

                                                    for(x in emailApprovalDup){
                                    					if(emailApprovalDup[x].length == 5){
                                    						if(typeof findMinDomain == "undefined"){
                                    							var findMinDomainLength = x.split(".").length;
                                    							var findMinDomain = x;
                                    							domainName = x;
                                    						} else {
                                    							if(x.split(".").length < findMinDomainLength){
                                    								findMinDomainLength = x.split(".").length;
                                    								findMinDomain = x;
                                    								domainName = x;
                                    							}
                                    						}
                                    					}
                                    				}


                                                    $('#whois_emailinfo').html(emailApprovalOtp);
                                                    $('#email_approval_1').attr('checked','checked');


                                                    progress(90, $('#progressBar'));
                                                    domainDetail = '';



                                                    if (domainDetail == '') {
                                                         domainDetail = '<font color="red"><b>Cannot found domain owner in the WHOIS information for your domain name, please Update WHOIS Information.</b></font>';
                                                    }

                                                    if(typeof $('#sanInclude').val() != 'undefined' && $('#sanInclude').val() > 0){
                                                        var sanIncludeNum = parseInt($('#sanInclude').val());
                                                        var sanNum = (parseInt($('#additional_domain').val())) ? parseInt($('#additional_domain').val()) : 0;
                                                        var totalSan = parseInt(sanIncludeNum+sanNum)-1;
                                                        var sanArea = '<table>';
                                                        var addDo = 0;
                                                        var csrSanCount = 0;
                                                        isSan = true;
                                                        var pCode = '{/literal}{$ssl_productcode}{literal}';

                                                        for(i = 0; i < totalSan; i++){
                                                            var sanText = 'Included Domain';
                                                            sanArea = sanArea + '<tr>';
                                                            if(i >= sanIncludeNum-1){
                                                                sanText = 'Additional Domain';
                                                                if(addDo == 0){
                                                                    addDo = 1;
                                                                }
                                                            }
                                                            sanArea = sanArea + '<td width="160px"><b>' + sanText + ' ';
                                                            if(addDo == 0){
                                                                sanArea = sanArea + (i+1);
                                                            } else {
                                                                sanArea = sanArea + addDo++;
                                                            }
                                                            if(sanNum > 0 || i == 0){
                                                                sanArea = sanArea + '</b> <font color="red">*</font></td>';
                                                            } else {
                                                                sanArea = sanArea + '</b></td>';
                                                            }
                                                            sanArea = sanArea + '<td>: <input id="sanDomain' + (i+1) + '" name="sanDomain[]" type="text" value="';
                                                            if(typeof csrData.DNSNames[csrSanCount] != 'undefined'){
                                                                sanArea = sanArea + csrData.DNSNames[csrSanCount++];
                                                            }
                                                            sanArea = sanArea + '"/>';
                                                            if(pCode == 'QuickSSLPremium'){
                                                                if(domainName.substring(0, 4) == 'www.'){
                                                                    //sanArea += '.' + csrData.CommonName.substring(4);
                                                                    sanArea += '.' + domainName.substring(4);
                                                                } else {
                                                                	//sanArea += '.' + csrData.CommonName;
                                                                	sanArea += '.' + domainName;
                                                                }
                                                            }
                                                            sanArea = sanArea + '</td></tr>';
                                                        }

                                                        sanArea = sanArea + '</table>';
                                                        $('#sanArea').html(sanArea);
                                                    }

                                                    $('#whois_domaininfo').html(domainDetail);
                                                    progress(100, $('#progressBar'));
                                                    $('.step3').show();
                                                    $('.order').show();

                                                    $('#progressBar').hide();
                                                    $(".format_textarea").toggle();
                                                    $("#toselect").toggle();
                                                    $("#editCSR").show();

                                                    $(".not_same_address").show();
                                                    $('#techContactDiv').css('padding-bottom', '');
                                                    $('#txt_name_1').val(clientContact.firstname);
                                                    $('#txt_lastname_1').val(clientContact.lastname);
                                                    $('#txt_email_1').val(clientContact.email);
                                                    $('#txt_org_1').val(clientContact.companyname);
                                                    $('#txt_address_1').val(clientContact.address);
                                                    $('#txt_city_1').val(clientContact.city);
                                                    $('#txt_state_1').val(clientContact.state);
                                                    $('#txt_country_1').val(clientContact.country);
                                                    $('#txt_post_1').val(clientContact.postcode);
                                                    $('#txt_tel_1').val(clientContact.phonenumber);
                                                    $('#txt_job_1').val(clientContact.job);
                                                    $('#txt_ext_1').val(clientContact.ext);

                                                    $('#techInfoType').change(function(){
                                                        var techType = $('#techInfoType').val();
                                                        var firstname = $('#txt_name').val();
                                                        var lastname = $('#txt_lastname').val();
                                                        var email = $('#txt_email').val();
                                                        var organization = $('#txt_org').val();
                                                        var address = $('#txt_address').val();
                                                        var city = $('#txt_city').val();
                                                        var state = $('#txt_state').val();
                                                        var country = $('#txt_country').val();
                                                        var postal = $('#txt_post').val();
                                                        var phone = $('#txt_tel').val();
                                                        var title = $('#txt_job').val();
                                                        var ext= $('#txt_ext').val();

                                                        switch(techType){
                                                            case 'sameAdmin' :
                                                                $(".not_same_address").hide();
                                                                $('#techContactDiv').css('padding-bottom', '0px');
                                                                break;
                                                            case 'sameBilling' :
                                                                $(".not_same_address").show();
                                                                $('#techContactDiv').css('padding-bottom', '');
                                                                firstname = clientContact.firstname;
                                                                lastname = clientContact.lastname;
                                                                email = clientContact.email;
                                                                organization = clientContact.companyname;
                                                                address = clientContact.address;
                                                                city = clientContact.city;
                                                                state = clientContact.state;
                                                                country = clientContact.country;
                                                                postal = clientContact.postcode;
                                                                phone = clientContact.phonenumber;
                                                                title = clientContact.job;
                                                                ext= clientContact.ext;
                                                                break;
                                                            case 'sameTech' :
                                                                $(".not_same_address").show();
                                                                $('#techContactDiv').css('padding-bottom', '');
                                                                if(typeof whoisData.tech != 'undefined' && typeof whoisData.tech.firstName != 'undefined' && typeof whoisData.tech.lastName != 'undefined' && typeof whoisData.tech.email != 'undefined' && typeof whoisData.tech.organization != 'undefined' && typeof whoisData.tech.address != 'undefined' && typeof whoisData.tech.city != 'undefined' && typeof whoisData.tech.state != 'undefined' && typeof whoisData.tech.country != 'undefined' && typeof whoisData.tech.postal != 'undefined' && typeof whoisData.tech.phone != 'undefined'){
                                                                    firstname = whoisData.tech.firstName;
                                                                    lastname = whoisData.tech.lastName;
                                                                    email = whoisData.tech.email;
                                                                    organization = whoisData.tech.organization;
                                                                    address = whoisData.tech.address;
                                                                    city = whoisData.tech.city;
                                                                    state = whoisData.tech.state;
                                                                    country = whoisData.tech.country;
                                                                    postal = whoisData.tech.postal;
                                                                    phone = whoisData.tech.phone;
                                                                    title = '';
                                                                    ext= '';
                                                                } else {
                                                                    firstname = '';
                                                                    lastname = '';
                                                                    email = '';
                                                                    organization = '';
                                                                    address = '';
                                                                    city = '';
                                                                    state = '';
                                                                    country = '';
                                                                    postal = '';
                                                                    phone = '';
                                                                    title = '';
                                                                    ext= '';
                                                                }
                                                                break;
                                                        }
                                                        $('#txt_name_1').val(firstname);
                                                        $('#txt_lastname_1').val(lastname);
                                                        $('#txt_email_1').val(email);
                                                        $('#txt_org_1').val(organization);
                                                        $('#txt_address_1').val(address);
                                                        $('#txt_city_1').val(city);
                                                        $('#txt_state_1').val(state);
                                                        $('#txt_country_1').val(country);
                                                        $('#txt_post_1').val(postal);
                                                        $('#txt_tel_1').val(phone);
                                                        $('#txt_job_1').val(title);
                                                        $('#txt_ext_1').val(ext);
                                                    });
                                                }, error: function(xhr,error){
                                                    respError = $.parseJSON(xhr.responseText);
                                                    alert("Generate email approval failed!! " + respError.message);
                                                }
                                            });
                                        }
                                        , error: function(xhr,error) {
                                            respError = $.parseJSON(xhr.responseText);
                                            alert( "Whois API connection has error!! " + respError.message);
                                        }
                                    });
                                }
                            } else {
                                writeCsrError("Cannot read data info from CSR!!");
                                return false;
                            }
                        } else {
                            writeCsrError("Unknow status response!!");
                            return false;
                        }
                    }
                    , error: function(xhr,error) {
                        respError = $.parseJSON(xhr.responseText);
                        alert( "Whois API connection has error!! " + respError.message);
                    }
               });
            }
            , error: function(xhr,error) {
                respError = $.parseJSON(xhr.responseText);
                alert( "GetClientDetail has error!! " + respError.message);
            }
        });
    }

   function writeCsrError(msg)
    {
        if (msg == '') {
            $( '#csr_errorblock' ).html('');
        } else {
            $( '#csr_errorblock' ).html($( '#csr_errorblock' ).html() + '<p class="message-error"><font color=red>' + msg + '</font></p>');
        }
    }

    function writeCsrData(id, val)
    {
        $( '#' + id + '_data').html(val);
    }

    function writeCsrStatus(id, val)
    {
        code = '';
        if (val == 0) {
            code = '';
            //code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_disable.gif" />';
        }
        if (val == 1) {
            code = '';
           // code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_enable.gif" />';
        }
        $( '#' + id + '_status').html(code);
    }
  }




  ///////////////// submit ///////////////////////
        	//$dns_name = '';
        	//$server_amount = ($server_amount > 1) ? $server_amount : 1;
  $("#frmMr").submit(function(){
	  //var pCode = '{/literal}{$ssl_productcode}{literal}';
	  //var validityPeriod = $("input[name='ssl_price']").map(function(){if($(this).attr("checked"))return $(this).val();}).get();
	  //var san_amount = (typeof $("#additional_domain").val() != 'undefined') ? $("#additional_domain").val() : false;
	  //var server_amount = (typeof $("#additional_server").val() != 'undefined') ? $("#additional_server").val() : 1;
	  //var dns_name = (typeof $("input[name^='sanDomain']").val() != 'undefined') ? $("input[name^='sanDomain']").map(function(){return $(this).val();}).get() : '';

	  //validityPeriod = validityPeriod[0];

  		var filteremail 	= /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$/;
  		var vaAlpha = /^([\d\w\s\.,]{0,})$/;
  		vaAlpha = /^[a-zA-Z0-9\,\.\\\/\_\-\s]*$/;
  		var textValidate = /^[a-zA-Z0-9]*$/;
  		//var validateSAN     = /^(www.)*([a-zA-Z0-9]{1,})[\.](([a-zA-Z0-9\-]{2,})|([a-zA-Z0-9\-]{2,}[\.]{1,}[a-zA-Z0-9\-]{2,})){1,}$/;
  		var validateOrganize = /^[a-zA-Z0-9\,\.\\\/\_\-\s@&!()\']*$/;
        var validateAddress = /^[a-zA-Z0-9\,\.\\\/\_\-\s@()\']*$/;
  		var validateSAN = /^([a-zA-Z0-9\-]*\.){0,}[a-zA-Z0-9\-]*(\.[a-zA-Z\-]{2,5})?\.[a-zA-Z]{2,3}$/;
  		var countryJPError = "We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.<br><br>Please contact <a href='https://rvglobalsoft.com/tickets/new&deptId=3' target='_blank'>RVStaff</a>";

  		if($('#submitCSROption0').is(':checked')){
  		    //alert('here');
  		    $('#additional_domain').attr('disabled', false);
            $('#additional_server').attr('disabled', false);
  		    checksslincart();
            return true;
  		}
  		if ($('#fieldcontact').val()==0) {
  		    $('#additional_domain').attr('disabled', false);
            $('#additional_server').attr('disabled', false);
  			checksslincart();
  			return true;
  		} else {
  		    var sanList = $('input[name="sanDomain[]"]').map(function(){return $(this).val();}).get();
  		    var dnsName = '';
  		    var dnsChk = [];
  		    var pCode = '{/literal}{$ssl_productcode}{literal}';

  		    if($('#support_san').val()){
  		        if(typeof $('#additional_domain').val() != 'undefined'){
      		        var sanAdd = $('#additional_domain').val();
  		        } else {
      		        var sanAdd = 0;
  		        }
  		        var sanIncluded = $('#sanInclude').val();
  		        var sanCheck = 0;
  		    }

  		    if(pCode == 'QuickSSLPremium'){
  		        //validateSAN = /^(www.)*([a-zA-Z0-9\.]{1,})([a-zA-Z0-9]){1,}$/;
  		    }
  		    var haveSAN = false;

  		    if(sanList.length > 0){
      		    for(i = 0; i < sanList.length; i++){
      		        sanList[i] = sanList[i].trim();
      		        if(sanList[i].trim() != ''){
      		            haveSAN = true;
      		        }
      		    }

      		    if(haveSAN){
          		    for(i = 0; i < sanList.length; i++){
          		        sanList[i] = sanList[i].trim();
          		        if(sanList[i] == '' && sanAdd > 0){
          		            alert("Please complete each domain name field before submitting form.");
          		            $('#sanDomain' + (i+1)).focus();
          		            return false;
          		        } else if(pCode == 'QuickSSLPremium' && sanList[i] != ''){
				  		    var commonname = '.' + domainName;
          		        	if(commonname.substring(0, 5) == '.www.'){
          		        		cn = '.' + commonname.substring(5);
                            } else {
                            	cn = commonname;
                            }
          		            sanList[i] = sanList[i] + cn;
          		        }


                        if(sanList[i] != ''){
              		        if((dnsChk.indexOf(sanList[i]) >= 0 || sanList[i] == $('#csr_cn_data').html())){
              		            alert("You cannot order the duplicated domain name.");
              		            $('#sanDomain' + (i+1)).focus();
              		            return false;
              		        } else if(validateSAN.test(sanList[i]) == false){
              		            alert("Invalid domain name.");
              		            $('#sanDomain' + (i+1)).focus();
              		            return false;

              		        } else if(sanList[i].toLowerCase().search('.jp') != -1){
                                alert('Sorry, any domain names registered with .jp extension as sample "' + sanList[i] + '", will not be able to order SSL Certificate here.');
                                $('#sanDomain' + (i+1)).focus();
                                return false;
                            } else {
              		            if(dnsName == ''){
              		                dnsName = sanList[i];
              		            } else {
              		                dnsName += ',' + sanList[i];
              		            }
              		            dnsChk.push(sanList[i]);
              		        }
          		        }
          		        sanCheck++;
          		    }

          		    if(sanList.length > 0){
          		        $('#dns_name').val(dnsName);
          		    }
          		} else if(sanAdd == 0){
          		    alert('SAN package requires at least 1 domain name. Please insert the domain name in the field before submitting the order.');
          		    $('#sanDomain1').focus();
          		    return false;
      		    } else {
      		        alert("Please complete each domain name field before submitting form.");
                    $('#sanDomain1').focus();
                    return false;
      		    }
  		    }
  		    
  		    var organizeCheck = {o_name: 'Organize Name', o_phone: 'Phone Number', o_address: 'Address', o_city: 'City', o_state: 'State/Province', o_country: 'Country', o_postcode: 'Postal Code'};

            for(key in organizeCheck){
                if(typeof $('#' + key).val() == 'undefined'){
                    continue;
                } else if($('#' + key).val() == ''){
                    alert('Field \'' + organizeCheck[key] + '\' required.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'o_country' && $('#' + key).val() == 'JP'){
                    alert('We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
                    $('#' + key).focus();
                    return false;
                } else if((key == 'o_address') && validateAddress.test($('#' + key).val()) == false){
                    alert('Field \'' + organizeCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if((key == 'o_city' || key == 'o_state') && vaAlpha.test($('#' + key).val()) == false){
                    alert('Field \'' + organizeCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if((key == 'o_name') && validateOrganize.test($('#' + key).val()) == false){
                    alert('Field \'' + organizeCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'o_phone' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim() == ''){
                    alert('Field \'' + organizeCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'o_phone' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                    alert('Field \'' + organizeCheck[key] + '\' have no numeric character.');
                    $('#' + key).focus();
                    return false;
                }
            }

//  			if ($('#varidate').val()!="1"){

            $("#admin_error_div").hide();
            $("#admin_error_text").html("");
            $("#tech_error_div").hide();
            $("#tech_error_text").html("");
            $('#adminContactDiv').css('height', '90%');
            $('#techContactDiv').css('height', '100%');

            if ($("#txt_country").val() != 'JP'){
                $("#admin_error_div").hide();
                $("#admin_error_text").html("");
            }

            var contactCheck = {txt_name: 'First name', txt_lastname: 'Last name', txt_email: 'Email Address', txt_org: 'Organization Name', txt_job: 'Job Title', txt_address: 'Address', txt_city: 'City', txt_state: 'State/Region', txt_country: 'Country', txt_post: 'Postal Code', txt_tel: 'Phone Number'};

            for(key in contactCheck){
                if(typeof $('#' + key).val() == 'undefined'){
                    continue;
                } else if($('#' + key).val() == ''){
                    alert('Field \'' + contactCheck[key] + '\' required.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'txt_country' && $('#' + key).val() == 'JP'){
                    alert('We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
                    $('#' + key).focus();
                    return false;
                } else if((key == 'txt_name' || key == 'txt_lastname' || key == 'txt_job' || key == 'txt_city' || key == 'txt_state') && (vaAlpha.test($('#' + key).val()) == false)){
                    alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if((key == 'txt_org') && validateOrganize.test($('#' + key).val()) == false){
                    alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if((key == 'txt_address') && validateAddress.test($('#' + key).val()) == false){
                    alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'txt_tel' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim() == ''){
                    alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'txt_tel' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                    alert('Field \'' + contactCheck[key] + '\' have no numeric character.');
                    $('#' + key).focus();
                    return false;
                }
            }

            if($('#techInfoType').val() == 'sameAdmin'){
                $('#txt_name_1').val($('#txt_name').val());
                $('#txt_lastname_1').val($('#txt_lastname').val());
                $('#txt_email_1').val($('#txt_email').val());
                $('#txt_org_1').val($('#txt_org').val());
                $('#txt_address_1').val($('#txt_address').val());
                $('#txt_city_1').val($('#txt_city').val());
                $('#txt_state_1').val($('#txt_state').val());
                $('#txt_country_1').val($('#txt_country').val());
                $('#txt_post_1').val($('#txt_post').val());
                $('#txt_tel_1').val($('#txt_tel').val());
                $('#txt_job_1').val($('#txt_job').val());
                $('#txt_ext_1').val($('#txt_ext').val());
            } else {
                for(key in contactCheck){
                    if(typeof $('#' + key + '_1').val() == 'undefined'){
                        continue;
                    } else if($('#' + key + '_1').val() == ''){
                        alert('Field \'' + contactCheck[key] + '\' required.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if(key == 'txt_country' && $('#' + key + '_1').val() == 'JP'){
                        alert('We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if((key == 'txt_name' || key == 'txt_lastname' || key == 'txt_job' || key == 'txt_city' || key == 'txt_state') && (vaAlpha.test($('#' + key + '_1').val()) == false)){
                        alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if((key == 'txt_org') && validateOrganize.test($('#' + key + '_1').val()) == false){
                        alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if((key == 'txt_address') && validateAddress.test($('#' + key + '_1').val()) == false){
                        alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if(key == 'txt_tel' && $('#' + key + '_1').val().replace(/[^\+0-9\.]/g,'').trim() == ''){
                        alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if(key == 'txt_tel' && $('#' + key + '_1').val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                        alert('Field \'' + contactCheck[key] + '\' have no numeric character.');
                        $('#' + key + '_1').focus();
                        return false;
                    }
                }
            }

            if(typeof $('#o_phone').val() != 'undefined'){
                $('#o_phone').val($('#o_phone').val().replace(/[^\+0-9\.]/g, ''));
            }
            $('#txt_tel').val($('#txt_tel').val().replace(/[^\+0-9\.]/g, ''));
            $('#txt_tel_1').val($('#txt_tel_1').val().replace(/[^\+0-9\.]/g, ''));

			$('#additional_domain').attr('disabled', false);
            $('#additional_server').attr('disabled', false);

			checksslincart();

//			$.ajax({
//		          url: RVL_BASEURL,
//		          type: 'POST',
//		          data:  {
//		              cmd: 'module'
//		              , module: 'ssl'
//		              , action: 'ajax_validate_order'
//		              , product_code: pCode
//		              , csr: $("#csr_data").val()
//		              , server_type: $("select[name='servertype']").val()
//		              , is_wildcard: $("#wild_card").val()
//		              , hashing_algorithm: $("select[name='hashing']").val()
//		              , validityPeriod: validityPeriod
//		              , server_amount: server_amount
//		              , san_amount: san_amount
//		              , ssl_id: $("#ssl_id").val()
//		              , dns_name: dns_name
//		          },
//		          success: function(data){
//		              console.log(data);
//		              var aResponse = data.aResponse;
//		              if(!aResponse.status){
//		                  alert(aResponse.error[0].ErrorMessage);
//			              return false;
//		              } else {
//		              }
//		      	  }
//			  });
			return true;
  		}
  		checksslincart();
  });


  $("#txt_date").change(function(){
  	var localdate = $( "#txt_date" ).val();
  	var mdate= new Date(localdate).toISOString().replace(/T/, ' ').replace(/\..+/, '');
  		$("#mdate").val(mdate);

  });

    $('#promo_code_link').click(function(){
        $('#promo_code_div').show();
        $('#promo_code_link').hide();
    });

    $('#promo_code_text').keypress(function(event) {
        if (event.keyCode == 13) {
            $('#promo_code_submit').click();
            event.preventDefault();
        }
    });

    $('#promo_code_submit').click(function(){
        var code = $('#promo_code_text').val().trim();
        var cyc = $('input[class=priceClass]:checked', '#frmMr').val();
        var cal = 0.00;
        var price = $('#priceNum' + cyc).val();
        var cid = $('#cid').val();

        price = parseFloat(price.replace(',', ''));


        $('#promo_code_error').html('');
        $('.boxTable').addLoader();

        $.ajax({
            url: RVL_BASEURL,
            type: 'POST',
            data:  {
                cmd: 'module'
                , module: 'ssl'
                , action: 'ajax_get_promo_code'
                , code : code
                , pid : $('#ssl_id').val()
                , cyc : cyc
                , cid : cid
            },
            success: function(data){
                $('#preloader').hide();
                aResponse = data.aResponse;
                if(aResponse){
                    if(typeof aResponse.messageError != 'undefined'){
                        $('#promo_code_error').html(aResponse.messageError);
                        $('#promo_code_used').val(0);
                        $('#promo_code_code').val('');
                        $('#promo_code_data').val('');
                    } else {
                        $('#promo_code_used').val(1);
                        $('#promo_code_code').val(code);
                        $('#promo_code_data').val(Base64.encode(JSON.stringify(aResponse)));
                        $('#promo_code_div').hide();
                        updatePrice();
                    }
                } else {
                    $('#promo_code_text').val('');
                    $('#promo_code_div').hide();
                    $('#promo_code_link').show();
                    $('#promo_code_used').val(0);
                    $('#promo_code_code').val('');
                    $('#promo_code_data').val('');
                }
            }
        });
    });

    $('#promo_code_remove').click(function(){
        $('.promo_code_discount_div').hide();
        $('#promo_code_div').hide();
        $('#promo_code_link').show();
        $('#promo_code_text').val('');
        $('#promo_code_data').val('');
        $('#promo_code_code').val('');
        $('#promo_code_used').val(0);
        updatePrice();
    });

});
{/literal}
</script>


