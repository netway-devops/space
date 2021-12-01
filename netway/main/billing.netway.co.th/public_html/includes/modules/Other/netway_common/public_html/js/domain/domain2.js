
var aAvailableTld = [];

var img = '{$system_url}includes/modules/Other/netway_common/public_html/js/domain/images/';
var htmlLoading = '<div id="domain-loading" style="margin-top:-30px;">';
    //htmlLoading += '<center><img src="' + img + 'ajax-loading.gif" alt="" /></center>';
    htmlLoading += '<center><img src="https://billing.netway.co.th/templates/netwaybysidepad/images/netway-loading.gif" alt="" width="70px" /><br/><p style="margin-top: 10px; color: #555;"> กำลังค้นหาโดเมน...</center>';
    htmlLoading += '</div>';
var firstSelect = 0;
var discountPrice = 0;


$(document).ready(function(){
    
    var divResponse = $('#domain-checker-result');
    
    $('#check-now').click(function(){
        var domain = $('#domain-checker-txt').val();
        var action = $(this).val();
        if(action == 'suggestion') action = 'orderDomain';
        var hostingOnly = 0;
        if($('input[name=noDomain]:checked').val() == 0) action = 'orderHostingOnly';

        if(domain != ''){
        	$('.load-result').show();
            divResponse.html(htmlLoading);
            $.post(
                '?cmd=domainhandle&action=' + action ,
                {
                    domainName: domain ,
                    action: action
                } ,
                function(data){                    
                    var data = data.data;
                    if(data === undefined){
                        divResponse.html('<div style="text-align: center;  color: #ff6000; font-size: 18px; margin-top: 40px;">โอ๊ะ!! เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้ง</div>');
                        return false;
                    }
                    
                    if(action == 'checkWhois'){
                        if(data.error){
                            divResponse.html('<div class="alert alert-danger" style="padding: 30px; text-align: center; font-size: 18px;">'+data.errorMsg+'</div>');
                        }else{                                                                                                      
                            var responseStr = '';
                            if(data.response == ''){
                                responseStr =   '<div class="result-border" style="text-align: center; padding: 50px 0 5px 0;"><i class="fa fa-check-circle" aria-hidden="true" style="color: #70ca2d; margin-right: 5px; font-size: 24px;"></i><font style="font-size: 24px;"> โดเมน ' + data.sld + data.tld +' ('+domain+')'+ ' <font style="font-size: 26px; color: #24ad24;">ว่าง</font>สามารถจดได้</font>';
                                responseStr +=   '<br><a href="/domain-order?domain='+data.sld + data.tld+'"><button id="" class="btn-check" name="" style="margin-top: 30px;">โดเมนว่าง ต้องการจดโดเมนในชื่อนี้ &nbsp;<i class="fa fa-chevron-circle-right" aria-hidden="true"></i> </button></a>';
                            }else{
                                if(!data.netwayDomain){
                                    responseStr = '<div class="result-border" style="height: 350px; overflow-y: scroll;line-height: 30px;">' + data.response + '</div><br>';
                                    responseStr +=   '<br><h2><font style="color: #70ca2d; margin-right: 5px; font-size: 24px;"><i class="fa fa-check-circle" aria-hidden="true"></i></font><font style="font-weight: 100;  font-size: 20px;">ถ้าคุณเป็นเจ้าของโดเมน ' + data.sld + data.tld + '&nbsp;&nbsp; "คุณสามารถย้ายผู้ดูแลโดเมนมาที่ Netway ได้"</font></h2>';
                                    responseStr +=   '<br><a href="/domain-order?domain='+data.sld + data.tld+'"><button id="" class="btn-check pull-right" name="" style="margin-top: 20px;">ต้องการย้ายโดเมนมาที่ Netway &nbsp;<i class="fa fa-chevron-circle-right" aria-hidden="true"></i> </button></a>';
                                }else{
                                    responseStr = '<div class="result-border"  style="height: 350px; overflow-y: scroll;line-height: 30px;">' + data.response + '</div>';
                                }
                            }
                            divResponse.html(responseStr);
                        }
                        
                    }else if(action == 'orderHostingOnly'){
                        
                        if(data.error){
                            divResponse.html(data.errorMsg);
                        }else{
                            window.location.assign('/domain-order');
                        }
                        
                    }else if(action == 'orderDomain' || action == 'suggestion'){
                        firstSelect = 0;
                        
                        if(data.error){
                            $('#domain-order-result').html('<div class="alert alert-danger" style="padding: 30px; text-align: center; font-size: 18px;">'+data.errorMsg+'<div>');
                            $tldDomain =  [".com", ".net"];
                            $.each($tldDomain, function(index, value){
                                console.log( data.domainName+value);
                                $.post(
                                '?cmd=domainhandle&action=orderDomain'  ,
                                {
                                    domainName: data.domainName+value,
                                } ,
                                
                                function(data){
                                    var data = data.data;
                                    var firstRow   =   0;
                                    var responseStr = '';
                                    var responseStrX = '';
                            
                                    if(data.extra !== undefined){
                                        $.each(data.extra , function(index , value){
                                            
                                            var option = '';
                                            $.each(data.price[value.tld] , function(priceIndex , priceValue){
                                                option+= '<option value="'+priceValue.period+'-' + priceValue.register + '">'+ priceValue.period +' ปี ราคา ' + priceValue.register + ' บาท</option>';
                                            });
                                    
                                            var documentRequest =   '';
                                            
                                            if(data.document[value.tld].reg_document != ''){
                                                
                                                documentRequest += '<tr><td colspan="3"><div class="panel panel-primary alert alert-primar " style="width: 100%;">';
                                                documentRequest += '<div class="panel-heading  ">โดเมน '+index+ ' ' + data.document[value.tld].reg_document +' <a style="color: #fff555;" href="'+data.document[value.tld].reg_document_kb+'" target="_blank">(อ่านเพิ่มเติม)</a></div>';
                                                documentRequest += '</div></td></tr>';
                                                
                                            }
                                        
                                            var select = '<input onclick="showNext(this)" type="checkbox" name="selected_tld['+value.sld+value.tld+']" value="1" id="'+value.tld+'"/> ';
                                            responseStrX +=   '<tr><td>'+select+value.sld+value.tld+'</td><td>'+data.price[value.tld][0].register+' บาท/ปี</td><td align="center"><select name="selected_period['+value.sld+value.tld+'][period]" >'+option+'</select></td></tr>';
                                            if(documentRequest != ''){
                                                responseStrX +=   documentRequest;
                                            }
                                            responseStrX +=   '<tr><td colspan="3"><hr class="domain-order"></td></tr>'; 
                                            
                                        });
                                    }
                                    
                                    $.each(data.main.tld , function(index , value){
                                        console.log('cc'+value);
                                        //alert(index);
                                        var option = '';
                                                $.each(data.price[index] , function(priceIndex , priceValue){
                                                    option+= '<option value="'+priceValue.period+'-' + priceValue.register + '">'+ priceValue.period +' ปี ราคา ' + priceValue.register + ' บาท</option>';
                                                });
                                        
                                        var documentRequest =   '';
                                        
                                        if(data.document[index].reg_document != ''){
                                            
                                            documentRequest += '<tr><td colspan="3"><div class="panel panel-primary" style="width: 100%; color: #0085cd; background-color: #cce5ff; border-color: #b8daff;">';
                                            documentRequest += '<div class="panel-heading" >โดเมน '+index+ ' ' + data.document[index].reg_document +' <a style="color: #6d70ff;" href="'+data.document[index].reg_document_kb+'" target="_blank">(อ่านเพิ่มเติม)</a></div>';
                                            documentRequest += '</div></td></tr>';
                                            
                                        }
                                        
                                        if(firstRow == 0){
                                            if(value == 1){
                                                responseStr +=  '<div class="table-responsive"><table  class="table borderless">';
                                        
                                                if(!data.netwayDomain){
                                                    responseStr +=   '<tr class="tr-Unavailable"><th align="center">รายการ</th><th align="center">ราคา</th><th align="center">จำนวน</th></tr>';
                                                    responseStr +=  '<tr><td><input checked onclick="showNext(this)" type="checkbox" class="g-txt16"  name="selected_tld_transfer['+data.main.sld+index+']" value="1" id="'+index+'"/>'+data.main.sld+index+'<font color="red" style="font-weight: 600;">&nbsp;&nbsp;ไม่ว่าง</font> กรณีเป็นโดเมนของคุณกรุณาเลือกเพื่อทำคำสั่งซื้อ ย้ายโดเมน </p>  </td><td style="font-weight: 600;">'+data.price[index][0].register+' บาท/ปี</td><td align="center"><select name="selected_period['+data.main.sld+index+'][period]">'+option+'</select></td></tr>';
                                                    firstSelect = 1;
                                                }else{
                                                    responseStr +=  '<tr><td>'+data.main.sld+index+' <font color="red" style="font-weight: 600;">ไม่ว่าง</font> และอยู่ที่ Netway อยู่แล้ว</td></tr>';
                                                }
                                                responseStr +=  '</table></div><hr>';
                                                responseStr +=  '<table width="100%" class="table borderless">';
                                                responseStr +=  '<tr  class="tr-available" ><th align="center" >รายการ</th><th align="center">ราคา</th><th align="center">จำนวน</th></tr>';
                                                firstRow++;
                                                responseStr += responseStrX;
                                            }else{
                                                var select = '<input checked onclick="showNext(this)" type="checkbox" class="option-input checkbox"  name="selected_tld['+data.main.sld+index+']" value="1" id="'+index+'"/> ';
                                                responseStr +=   '<table width="100%" class="table borderless">';
                                                responseStr +=   '<tr style="vertical-align: middle; color: #0052cd; height: 50px; border-bottom: 2px solid #0052cd;"><th align="center" width="61%">รายการ</th><th align="center">ราคา</th><th align="center">จำนวน</th></tr>';
                                                responseStr +=   '<tr><td class="blue">'+select+data.main.sld+index+'</td><td><p style="font-weight: 600;">'+data.price[index][0].register+' บาท/ปี </p></td><td align="center"><select class="form-control" name="selected_period['+data.main.sld+index+'][period]">'+option+'</select></td></tr>';
                                                if(documentRequest != ''){
                                                    responseStr +=   documentRequest;
                                                }
                                                responseStr +=   '<tr><td colspan="3"><hr class="domain-order"></td></tr>';
                                                firstRow+=2;
                                                firstSelect = 1;
                                            }
                                        }
                                        firstRow++;
                                        if(firstRow > 3 && value == 0){
                                            var select = '<input onclick="showNext(this)" type="checkbox" name="selected_tld['+data.main.sld+index+']" value="1" id="'+index+'"/> ';
                                            responseStr +=   '<tr><td>'+select+data.main.sld+index+'</td><td style="font-weight: 600;">'+data.price[index][0].register+' บาท/ปี</td><td align="center"><select name="selected_period['+data.main.sld+index+'][period]">'+option+'</select></td></tr>';
                                            if(documentRequest != ''){
                                                responseStr +=   documentRequest;
                                            }
                                            
                                            responseStr +=   '<tr><td colspan="3"><hr class="domain-order"></td></tr>';
                                        }else if(firstRow > 3 && value == 1){
                                            var select = '<!--<input  type="checkbox" disabled="disabled" /> -->';
                                            responseStr +=   '<tr><td>'+select+data.main.sld+index+'</td><td colspan="2"><font color="red">ไม่สามารถจดได้ </font></td></tr>';
                                            responseStr +=   '<tr><tr><td colspan="3"><hr class="domain-order"></td></tr>';
                                        }
                                        });
                                    
                                        responseStr +=   '</table>';
                                        if(firstSelect == 1){
                                            responseStr +=   '<button id="next-step" class="btn-confirm pull-right" name="" style="padding: 9px 20px;  border-radius: .25rem;">ต่อไป &nbsp;&nbsp;<i class="fa fa-chevron-circle-right" aria-hidden="true"></i></button>';
                                        }else{
                                            responseStr +=   '<button style="display: none; padding: 9px 20px;  border-radius: .25rem; background-color: #ff3d00;" id="next-step" class="btn-check pull-right" name="">ต่อไป &nbsp;&nbsp;<i class="fa fa-chevron-circle-right" aria-hidden="true"></button>';
                                        }
                                        divResponse.html(responseStr);



                                }
                                );
                            });
                        }else{
                            var firstRow   =   0;
                            var responseStr = '';
                            var responseStrX = '';
                            
                            if(data.extra !== undefined){
                                $.each(data.extra , function(index , value){
                                    
                                    var option = '';
                                    $.each(data.price[value.tld] , function(priceIndex , priceValue){
                                        option+= '<option value="'+priceValue.period+'-' + priceValue.register + '">'+ priceValue.period +' ปี ราคา ' + priceValue.register + ' บาท</option>';
                                    });
                            
                                    var documentRequest =   '';
                                    
                                    if(data.document[value.tld].reg_document != ''){
                                        
                                        documentRequest += '<tr><td colspan="3"><div class="panel panel-primary alert alert-primar " style="width: 100%;">';
                                        documentRequest += '<div class="panel-heading  ">โดเมน '+index+ ' ' + data.document[value.tld].reg_document +' <a style="color: #fff555;" href="'+data.document[value.tld].reg_document_kb+'" target="_blank">(อ่านเพิ่มเติม)</a></div>';
                                        documentRequest += '</div></td></tr>';
                                        
                                    }
                                
                                    var select = '<input onclick="showNext(this)" type="checkbox" name="selected_tld['+value.sld+value.tld+']" value="1" id="'+value.tld+'"/> ';
                                    responseStrX +=   '<tr><td>'+select+value.sld+value.tld+'</td><td>'+data.price[value.tld][0].register+' บาท/ปี</td><td align="center"><select name="selected_period['+value.sld+value.tld+'][period]" >'+option+'</select></td></tr>';
                                    if(documentRequest != ''){
                                        responseStrX +=   documentRequest;
                                    }
                                    responseStrX +=   '<tr><td colspan="3"><hr class="domain-order"></td></tr>'; 
                                    
                                });
                            }
                            
                            
                            $.each(data.main.tld , function(index , value){
                                //alert(index);
                                var option = '';
                                        $.each(data.price[index] , function(priceIndex , priceValue){
                                            option+= '<option value="'+priceValue.period+'-' + priceValue.register + '">'+ priceValue.period +' ปี ราคา ' + priceValue.register + ' บาท</option>';
                                        });
                                
                                var documentRequest =   '';
                                
                                if(data.document[index].reg_document != ''){
                                    
                                    documentRequest += '<tr><td colspan="3"><div class="panel panel-primary" style="width: 100%; color: #0085cd; background-color: #cce5ff; border-color: #b8daff;">';
                                    documentRequest += '<div class="panel-heading" >โดเมน '+index+ ' ' + data.document[index].reg_document +' <a style="color: #6d70ff;" href="'+data.document[index].reg_document_kb+'" target="_blank">(อ่านเพิ่มเติม)</a></div>';
                                    documentRequest += '</div></td></tr>';
                                    
                                }
                                
                                if(firstRow == 0){
                                    if(value == 1){
                                        responseStr +=  '<div class="table-responsive"><table  class="table borderless">';
                                
                                        if(!data.netwayDomain){
                                            responseStr +=   '<tr class="tr-Unavailable"><th align="center">รายการ</th><th align="center">ราคา</th><th align="center">จำนวน</th></tr>';
                                            responseStr +=  '<tr><td><input checked onclick="showNext(this)" type="checkbox" class="g-txt16"  name="selected_tld_transfer['+data.main.sld+index+']" value="1" id="'+index+'"/>'+data.main.sld+index+'<font color="red" style="font-weight: 600;">&nbsp;&nbsp;ไม่ว่าง</font> กรณีเป็นโดเมนของคุณกรุณาเลือกเพื่อทำคำสั่งซื้อ ย้ายโดเมน </p>  </td><td style="font-weight: 600;">'+data.price[index][0].register+' บาท/ปี</td><td align="center"><select name="selected_period['+data.main.sld+index+'][period]">'+option+'</select></td></tr>';
                                            firstSelect = 1;
                                        }else{
                                            responseStr +=  '<tr><td>'+data.main.sld+index+' <font color="red" style="font-weight: 600;">ไม่ว่าง</font> และอยู่ที่ Netway อยู่แล้ว</td></tr>';
                                        }
                                        responseStr +=  '</table></div><hr>';
                                        responseStr +=  '<table width="100%" class="table borderless">';
                                        responseStr +=  '<tr  class="tr-available" ><th align="center" >รายการ</th><th align="center">ราคา</th><th align="center">จำนวน</th></tr>';
                                        firstRow++;
                                        responseStr += responseStrX;
                                    }else{
                                        var select = '<input checked onclick="showNext(this)" type="checkbox" class="option-input checkbox"  name="selected_tld['+data.main.sld+index+']" value="1" id="'+index+'"/> ';
                                        responseStr +=   '<table width="100%" class="table borderless">';
                                        responseStr +=   '<tr style="vertical-align: middle; color: #0052cd; height: 50px; border-bottom: 2px solid #0052cd;"><th align="center" width="61%">รายการ</th><th align="center">ราคา</th><th align="center">จำนวน</th></tr>';
                                        responseStr +=   '<tr><td class="blue">'+select+data.main.sld+index+'</td><td><p style="font-weight: 600;">'+data.price[index][0].register+' บาท/ปี </p></td><td align="center"><select class="form-control" name="selected_period['+data.main.sld+index+'][period]">'+option+'</select></td></tr>';
                                        if(documentRequest != ''){
                                            responseStr +=   documentRequest;
                                        }
                                        responseStr +=   '<tr><td colspan="3"><hr class="domain-order"></td></tr>';
                                        firstRow+=2;
                                        firstSelect = 1;
                                    }
                                }
                                firstRow++;
                                if(firstRow > 3 && value == 0){
                                    var select = '<input onclick="showNext(this)" type="checkbox" name="selected_tld['+data.main.sld+index+']" value="1" id="'+index+'"/> ';
                                    responseStr +=   '<tr><td>'+select+data.main.sld+index+'</td><td style="font-weight: 600;">'+data.price[index][0].register+' บาท/ปี</td><td align="center"><select name="selected_period['+data.main.sld+index+'][period]">'+option+'</select></td></tr>';
                                    if(documentRequest != ''){
                                        responseStr +=   documentRequest;
                                    }
                                    
                                    responseStr +=   '<tr><td colspan="3"><hr class="domain-order"></td></tr>';
                                }else if(firstRow > 3 && value == 1){
                                    var select = '<!--<input  type="checkbox" disabled="disabled" /> -->';
                                    responseStr +=   '<tr><td>'+select+data.main.sld+index+'</td><td colspan="2"><font color="red">ไม่สามารถจดได้ </font></td></tr>';
                                    responseStr +=   '<tr><tr><td colspan="3"><hr class="domain-order"></td></tr>';
                                }
                            });
                            
                            responseStr +=   '</table>';
                            if(firstSelect == 1){
                                responseStr +=   '<button id="next-step" class="btn-confirm pull-right" name="" style="padding: 9px 20px;  border-radius: .25rem;">ต่อไป &nbsp;&nbsp;<i class="fa fa-chevron-circle-right" aria-hidden="true"></i></button>';
                            }else{
                                responseStr +=   '<button style="display: none; padding: 9px 20px;  border-radius: .25rem; background-color: #ff3d00;" id="next-step" class="btn-check pull-right" name="">ต่อไป &nbsp;&nbsp;<i class="fa fa-chevron-circle-right" aria-hidden="true"></button>';
                            }
                            divResponse.html(responseStr);
                        }
                        
                    }
                    
                }
            );
        }
    });
    
    $("#domain-checker-txt").autocomplete({
        source: aAvailableTld
    });
    
    $('#domain-checker-txt').keydown(function (event) {
        if(event.which == 110 || event.which == 190){
            if($(this).val().indexOf('.') <= 1){
                _getTld($(this).val());
            }
        }
    });
    
    _getTld($('#domain-checker-txt').val());
    
    
    $('#hosting-plan').change(function(){

        $optionStr  =   '';
        
        $.each(listHostingPlan[$(this).val()].price , function(index , value){
            var checked = '';
            if(index == 'Annually') checked = 'selected';
            $optionStr+= '<option '+checked+' value="'+value+'">'+value.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")+' บาท / '+index+'</option>';
            
        });
        
        $('#hosting-plan-price')
            .find('option')
            .remove()
            .end()
            .append($optionStr)
        ;
        addHostingToCart();
        calculateInCartPriceWithHosting();
        
    });
    
    $('#hosting-plan-price').change(function(){
        addHostingToCart();
        calculateInCartPriceWithHosting();
    });
        
    $('#interesting').change(function(){

        addHostingToCart();
        if($(this).val() == 1){
            $('#show-select-hosting-plan').show();
            calculateInCartPriceWithHosting();
        }else{
            $('#show-select-hosting-plan').hide();
            calculateInCartPriceWithHosting();
        }
    });
    
    $('#promoform').click(function(event){
        event.preventDefault();
        $('#cartSummary').addLoader();
        var coupon = $('input[name="promocode"]').val();
        $.getJSON('?cmd=domainhandle&action=getCoupon&couponCode='+ coupon + '&listOrder=' + JSON.stringify(listDomainOrder), function (data) {
            discountPrice = data.data.discountPrice;
            if(discountPrice == 0){ 
                $('#InvalidCouponcode').show(); 
                $('#validCouponcode').hide();
            }else{ 
                $('#InvalidCouponcode').hide();
                $('#validCouponcode').html("<font color=\"green\">Success to apply coupon code your discount is "+ discountPrice +" Bath</font> ");
                $('#validCouponcode').show();
            }
            calculateInCartPriceWithHosting();
            $('#preloader').remove();
        });
        
    });
    
    $('#hostname').change(function(){
        addHostingToCart();
    });
    
    $('.epp_code').each(function(){
        $(this).blur(function(){
             $.post(
            '?cmd=domainhandle&action=addEppCode' ,
            {
                epp_code:   $(this).val() ,
                domain: $(this).attr('id')                
            } ,
            function(data){
                
            });
        });
    });
    
    $('#hosting-plan').val($('#hosting-plan').val()).trigger('change');
    $('.vtip_applied').focus();

    
});

function addHostingToCart(){
    if($('#interesting').val() == 1){
        var priceStr    =   $('#hosting-plan-price :selected').text();
        priceStr        =   priceStr.split('/');
        $.post(
            '?cmd=domainhandle&action=addHostingToCart' ,
            {
                hostname:   $('#hostname').val() ,
                product_id: $('#hosting-plan').val(),
                billing_cycle: priceStr[1].trim()
            } ,
            function(data){
                
        });
    }else if($('#interesting').val() == 0){
        $.post(
            '?cmd=domainhandle&action=addHostingToCart' ,
            {
                clearHosting:  1  
            } ,
            function(data){
                
        });
    }
}

function nl2br (str, is_xhtml) {   
    var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br />' : '<br>';    
    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1'+ breakTag +'$2');
}

function calculateInCartPriceWithHosting(){
    var samary      =   0;
    var discount    =   discountPrice;
    var totalPrice  =   0;
    var vatRate     =   0.07;
    var vat         =   0;
    
    $.each(listDomainOrder , function(index , value){
        samary  =    samary + parseFloat(value.price);
    });
    
    if($('#interesting').val() == 1){
        samary  =   samary + parseFloat($('#hosting-plan-price').val());
    }
    
    samary      =   samary.toFixed(2);
    discount    =   parseFloat(discount).toFixed(2);
    totalPrice  =   parseFloat(samary) - discount;
    vat         =   parseFloat(totalPrice)*vatRate;
    vat         =   vat.toFixed(2);
    totalPrice  =   parseFloat(totalPrice)+parseFloat(vat);
    totalPrice  =   totalPrice.toFixed(2);
    
    $('span#domain-cart-sammary').html('<p class="domain-cart-price-text">รวม ' + samary.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' บาท</p>');
    $('span#domain-cart-discount').html('<p class="domain-cart-price-text"><a id="couponOpenModal" onclick="couponModalToggle()">Coupon Code <i class="fa fa-ticket" aria-hidden="true"></i></a> ส่วนลด ' + discount.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' บาท</p>');
    $('span#domain-cart-vat').html('<p class="domain-cart-price-text">VAT(7%) ' + vat.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' บาท</p>');
    $('span#domain-cart-total').html('<p class="domain-cart-price-text">ยอดรวมชำระ ' + totalPrice.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' บาท</p>');
    if(totalPrice <= 0){
        $('#checkout-now').hide();
    }else{
        $('#checkout-now').show();
    }
}

function couponModalToggle(){
    $('#couponModal').modal('toggle');
}

function _getTld(domainName){
    $.get( "listdomain.json", function( data ) {
        var oTld =   data.tld;
        $.each( oTld, function( key, value ) {
            aAvailableTld.push(domainName + value.name);
        });
    });
}

function showNext(ele){
        if($(ele).is(':checked')){
            firstSelect++;
        }else{
            firstSelect--;
        }
        if(firstSelect >= 1 ){
            $('#next-step').show();
        }else{
            $('#next-step').hide();
        }
}
