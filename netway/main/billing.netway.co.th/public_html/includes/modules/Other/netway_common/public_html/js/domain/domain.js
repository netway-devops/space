/**
*
* Domain Search, Whois, Suggestion, Prices
* @auther Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
*
**/
var api = 'RVDomainAjax.php?';
var post = 'https://netway.co.th/index.php?';
var img = 'https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/images/';
var urlTld = 'https://netway.co.th/index.php?/checkdomain/domain-registrations/';
var urlTld2 = 'https://netway.co.th/listdomain.json';
var contentHtml = '';
var sld = 'yourdomain';
var tld = '.com';
var type = 'order';
var loop = 0;
var aLtd = {
	'.com': ['.com'],
	'.net': ['.net'],
	'.uk': ['.uk'],
	'.co.th': ['.co.th'],
	'.in.th': ['.in.th'],
	'.ac.th': ['.ac.th'],
	'.go.th': ['.go.th'],
	'.or.th': ['.or.th'],
	'.mi.th': ['.mi.th'],
	'.net.th': ['.net.th'],
	'.cc': ['.cc'],
	'.tv': ['.tv'],
	'.org': ['.org'],
	'.biz': ['.biz'],
	'.info': ['.info'],
	'.eu': ['.eu'],
	'.mobi': ['.mobi'],
	'.name': ['.name'],
	'.asia': ['.asia']
};
var aTldPopular = {
	'.com': ['.com'],
	'.net': ['.net'],
	'.co.th': ['.co.th'],
	'.in.th': ['.in.th'],
	'.org': ['.org']
};
var aTldXn = {
	'.com': ['.com'],
	'.net': ['.net']
};


checkURL = document.URL;
if (checkURL.match(/127\.0\.0\.1/gi) || checkURL.match(/192\.168\.1\./gi) || checkURL.match(/localhost/gi)) {
	post = checkURL.replace(/index\.php[\s\S]*/gim, "");
	urlTld2 = post+ "listdomain.json";
	post += "index.php?";
	
	urlTld = post + "/checkdomain/domain-registrations/";
}


(function(jQuery) {
	
	 $.domain = {};
	 
	 $.domain.init = function(settings) {
		 
		options = jQuery.extend({
			id: '#container-code',
			type: 'order', // order | whois | suggestion | prices
			api: ''
		}, settings);
		
		$.domain.api(options.api);
		
		
		htmlLoading = '<div id="domain-loading">';
		htmlLoading += '        <center><img src="' + img + 'ajax-loading.gif" alt="" /></center>';
		htmlLoading += '</div>';

		$(options.id).html(htmlLoading);
		
		if(options.type == 'order'){

           $.post(api + 'action=dname', function(data) {
                contentHtml = data;
                $.domain.init.make();
                $.domain.init.tld();
                $(options.id).html($.domain.init.html(options));
            }); 

		}
		else{

        	contentHtml = httpGet(urlTld);
            if (contentHtml == '') {
                $.post(api + 'action=tld', function(data) {
                    contentHtml = data;
                    $.domain.init.tld();
                    $(options.id).html($.domain.init.html(options));
                });
            } else {
                $.domain.init.tld();
                $(options.id).html($.domain.init.html(options));
            }
      }
                
     };
     
     
     $.domain.init.make = function() {
         var arrData =JSON.parse(contentHtml);
         contentHtml = "<!-- START TLD COPY -->";
         contentHtml += '  <ul class="tldDropDown">';
         
          try {
             jQuery.each(arrData['tld'], function(key, value) {
                 contentHtml += '   <li title="'+value['name']+'" onclick="';
                 contentHtml += "$.domain.tld('"+value['name']+"');";
                 contentHtml +=  '$.domain.tldDropDown();">'+value['name']+'</li>';
             });
         } catch (e) {}
         
         contentHtml += '</ul>';
         contentHtml += '<!-- END TLD COPY --> ';
    
   
     };
     
	 
	 $.domain.init.tld = function() {};
	 $.domain.init.tld_ = function() {
		 
			htmlTLD = contentHtml;
            htmlTLD = htmlTLD.replace(/[\s\S]*START TLD COPY -->/gim, "");
            htmlTLD = htmlTLD.replace(/<!-- END TLD COPY[\s\S]*/gim, "");

            if (htmlTLD.match(/\.tld\(\'(.*?)\'\)\;/g)) {
            	htmlTLD = htmlTLD.match(/\.tld\(\'(.*?)\'\)\;/g);
                
                for (i=0;i<htmlTLD.length;i++) {
                	key = htmlTLD[i].replace(/\.tld\(\'/, "");
                	key = key.replace(/\'\)\;/, "");

                	if (key.match(/^\.[a-z0-9-]+/)) {
                		aLtd[key] = key;
                	}
                }
            }
        
     };
	 
	 $.domain.init.html = function(options) {
		 	 
		 if (options.type == 'prices') {
			 
			 htmlPrices = contentHtml;
			 htmlPrices = htmlPrices.replace(/[\s\S]*START PRICING COPY -->/gim, "");
			 htmlPrices = htmlPrices.replace(/<!-- END PRICING COPY[\s\S]*/gim, "");
			 htmlPrices = htmlPrices.replace(/display:none;/gim, "");
			 htmlPrices = htmlPrices.replace(/style=\"display:none\"/gim, "");
			 
			 return htmlPrices;
		 }
		 
		 // Book Mark
		 bookMark = document.URL;
		 bookMark = bookMark.replace(/\#[\s\S]*/gim, "");
		 
		 html = '		<div id="domain-bookmark">';
		 html += '			<a href="' + bookMark + '#target-domain-bookmark" name="target-domain-bookmark"></a>';
		 html += '		</div>';
		 
		 html += '	<div class="container-step1">';
		 
		 if (options.type == 'whois') {
			 html += '		<h1 class="title06">Start whois domain search here...</h1>';
	     } else if (options.type == 'suggestion') {
	    	 html += '		<h1 class="title06">Start domain suggestion search here...</h1>';
	     } else {
	    	 html += '		<h1 class="title06">Start your domain search here...</h1>';
	     }
		 
		 html += '		<div class="domain-in">';
		 // html += '			<form action="" method="post">';
	     html += '				<span class="domain-in-01">www.</span>';
	     html += '				<div class="domain-in-02">';
	     
	     // html += '					<input type="text" name="sld" id="sld" value="yourdomain" onblur="if(this.value==\'\') this.value=\'yourdomain\';" onfocus="if(this.value==\'yourdomain\') this.value=\'\';" onkeypress="return goEnter(event, options.type);" />';	     
	     if (options.type == 'whois') {
	    	 html += '					<input style="width:225px;" type="text" name="sld" id="sld" value="yourdomain" onblur="if(this.value==\'\') this.value=\'yourdomain\';" onfocus="if(this.value==\'yourdomain\') this.value=\'\';" onkeypress="return goEnter(event, \'whois\');" />';
	     } else if (options.type == 'suggestion') {
	    	 html += '					<input style="width:225px;" type="text" name="sld" id="sld" value="yourdomain" onblur="if(this.value==\'\') this.value=\'yourdomain\';" onfocus="if(this.value==\'yourdomain\') this.value=\'\';" onkeypress="return goEnter(event, \'suggestion\');" />';
	     } else {
	    	 html += '					<input style="width:225px;" type="text" name="sld" id="sld" value="yourdomain" onblur="if(this.value==\'\') this.value=\'yourdomain\';" onfocus="if(this.value==\'yourdomain\') this.value=\'\';" onkeypress="return goEnter(event, \'order\');" />';
	     }
	     
	     html += '				</div>';
	     html += '				<div class="domain-in-03">';
	     html += '					<div class="mainTld" onclick="$.domain.mainTld();">.com</div>';
	     html += '					<div class="dropbg">';
	     /*
	     html += '						<ul class="tldDropDown">';
	     
	     try {
	    	 jQuery.each(aLtd, function(key, value) {
	    		 html += '					<li title="' + value + '" onclick="$.domain.tld(\'' + value + '\')">' + value + '</li>';
	         });
	     } catch (e) {}
	     
	     html += '						</ul>';
	     */
	     
	     htmlTLD = contentHtml;
	     htmlTLD = htmlTLD.replace(/[\s\S]*START TLD COPY -->/gim, "");
	     htmlTLD = htmlTLD.replace(/<!-- END TLD COPY[\s\S]*/gim, "");
	     
	     html += htmlTLD;
	     
	     html += '					</div>';
	     html += '				</div>';
	     html += '				<div class="button01">';
	     html += '					<div>';
	     
	     if (options.type == 'whois') {
	    	 html += '						<input type="button" onclick=\'return $.domain.whois();\' value="GO" />';
	     } else if (options.type == 'suggestion') {
	    	 html += '						<input type="button" onclick=\'return $.domain.suggestion();\' value="GO" />';
	     } else {
	    	 html += '						<input type="button" onclick=\'return $.domain.orders();\' value="GO" />';
	     }
	     
	     html += '					</div>';
	     html += '				</div>';
	     // html += '			</form>';
	     html += '		</div>';
	     html += '		<div class="cleart"></div>';
	     html += '		<div class="clear"></div>';
	     html += '		<div id="container-diplays"></div>';
	     html += '		<div class="domain-after">';
	     html += '			<div class="kol-1"></div>';
	     html += '			<div class="kol-2"></div>';
	     html += '		</div>';
	     html += '		<div class="clear"></div>';
	     html += '		<div class="clear"></div>';
	     html += '		<div class="linia1" style="display:none;"></div>';
	     html += '		<div class="transfer-after" style="display:none;">';
	     html += '			<div class="kol-1">';
	     html += '				<h3 class="title08">Starting at</h3>';
	     html += '				<div class="cost01" style="padding-bottom: 10px">450.00<span>per year!</span></div>';
	     html += '			</div>';
	     html += '			<div class="kol-2">';
	     html += '				<h3 class="title08">Supported TLDs:</h3>';
	     html += '				<ul class="list-domain">';
	     
	     try {
	    	 jQuery.each(aLtd, function(key, value) {
	    		 html += '			<li>' + value + '</li>';
	         });
	     } catch (e) {}
	     
	     html += '				</ul>';
	     html += '				<div class="cleart"></div>';
	     html += '			</div>';
	     html += '		</div>';
	     html += '	</div>';	            
	     
		 return html;
	 };
	 
	 
	 $.domain.checkdomain = function() {
		 
	 };
	 
	 
	 $.domain.orders_validate = function(paramTld) {
		
		 checkBool = false;
		 jQuery.each(aTldXn, function(key, value) {
			if (paramTld == value) {
				checkBool = true;
			}
		 });
		 if (checkBool == false) {
			 alert('xn-- not support extension.');
			 checkBool = false;
		 }
		 return checkBool;
	 };
	 
	 $.domain.orders_submit = function() {

		 if ($('input[type=checkbox]:checked').length == 0) {
			 alert('Please select one or more.');
		 } else {
			 $('#domain-submit').submit();
		 }
		 
	 };
	 
	 	 
	 $.domain.orders_more = function() {
		 
		 $('#domain-more').hide();
		 
		 try {
			 jQuery.each(aLtd, function(key, value) {
				 
				 if ($.reserveword.isReserveword(sld, key) == true) {
					 return; // Continues
				 }
				 
				 if (sld != key)  {
					if (aTldPopular[key] == undefined) {
						
						var trId = key.replace(/\./g, "");
                        var trHtml = '<tr class="status-row" id="tr-domain-' + trId + '" >';
                        trHtml += '		<td align="center">';
                        trHtml += '			<img src="' + img + 'ajax-loading2.gif" alt="" />';
                        trHtml += '		</td>';
                        trHtml += '		<td align="center"><strong>' + sld + '' + key + '</strong></td>';
                        trHtml += '		<td align="center">status</td>';
                        trHtml += '	</tr>';
                        $('#domain-table tr:last').after(trHtml);
                        
                        // TODO
                        params = 'cmd=checkdomain&register=1&action=checkdomain&singlecheck=1&domain_cat=1&';
                        //params = 'cmd=checkdomain&register=1&action=checkdomain&singlecheck=1&domain_cat=31&';
                        $.post(api + params + 'sld=' + sld + '&tld=' + key, function(data) {
                        	if (data.match(/href\=\"checkdomain\&action\=whois/)) {
                        		data = data.replace(/href\=\"checkdomain/g, 'href="' + post + '/checkdomain');
                			}
                       	 	if (data.match(/value="(.*)" check/gi)) {
								aMatches = data.match(/value="(.*)" check/gi);
                              	if (aMatches[0] != undefined) {
                              	   trId = aMatches[0].replace(/value=\"/g, "");
                                   trId = trId.replace(/\" check/g, "");
                                   trId = trId.replace(/\./g, "");
                             	}
							}
							if (data.match(/\&amp\;tld=(.*)" onclick/gi)) {
								aMatches = data.match(/\&amp\;tld=(.*)" onclick/gi);
								trId = aMatches[0].replace(/\&amp\;tld=/g, "");
								trId = trId.replace(/\" onclick/g, "");
								trId = trId.replace(/\./g, "");
							}
							data = data.replace(/checked=\"checked\"/g, "");
							
							$("#domain-table tr#tr-domain-" + trId).replaceWith('<tr class="status-row">' + $.domain.parse_response(data) + '</tr>');
                        });
					}
				 }
			  });
			 
		 } catch (e) {}
		 
	 };
	 
	 
	 $.domain.loops = function(count) {
		 setTimeout(function() {
			 if (loop >= count) {
				 loop = 0;
				 $('#domain-submit').submit();
			 } else {
				 $.domain.loops(count);
			 }
         }, 50);
	 };
	 
	 
	 $.domain.orders = function(settings) {
		 
		 // Book Mark
		 window.location = $("#domain-bookmark").find("a").attr("href");
		 
		 sld = jQuery('#sld').val();
		 var minStr = 3;
		 var arr = [".co.th", ".in.th", ".go.th", ".or.th", ".ac.th", ".mi.th", ".go.th", ".net.th"];
		 if(arr.indexOf(tld) != -1){
		     minStr = 2;
		 }
		 
		 if (sld.length < minStr || sld.length > 63) {
		     alert('ไม่สามารถดำเนินการต่อได้ เนื่องจากการจดโดเมนต้องประกอบด้วยตัวอักขระอย่างน้อย '+ minStr +' ตัวอักษร แต่ไม่เกิน 63 ตัวอักษร ค่ะ กรุณาลองใหม่');
		     return false;
		 }
		 
		 options = jQuery.extend({
			id: '#container-diplays',
			sld: sld,
			tld: tld,
			type: 'order'
		 }, settings);
		 $.domain.sld(options.sld);
		 $.domain.type(options.type);

		 
		 if ($.reserveword.isReserveword(sld, options.tld) == true) {
			 alert("Domain is reserve words " + sld);
			 return false;
		 }
		 
		 if (sld.match(/^[a-z0-9-]+$/gi)) {
		 } else {
			sld = 'xn--' + punycode.encode(sld);
			if ($.domain.orders_validate(options.tld) == false) {
				return false;
			}
		 }
		 
         html = '<div id="domain-loading">';
         html += '	<center><img src="' + img + 'ajax-loading.gif" alt="" /></center>';
         html += '</div>';
         $(options.id).html(html);
         
		 html = '<form action="' + post + '/cart&amp;step=1&amp;cat_id=register&amp;tld_cat=1&amp;ref=1&amp;domain=illregister" method="post" id="domain-submit">';
		 html += '<table width="100%" cellpadding="0" cellspacing="0" class="domain-table" id="domain-table">';
         html += '  <colgroup>';
         html += '      <col width="5%" />';
         html += '      <col width="31%" />';
         html += '      <col width="31%" />';
         html += '      <col width="33%" />';
         html += '  </colgroup>';
         html += '  <tr class="status-head">';
         html += '      <td align="center">&nbsp;</td>';
         html += '      <td align="center">Domain</td>';
         html += '      <td align="center">Status</td>';
         html += '      <td align="center">Period</td>';
         html += '  </tr>';
         html += '</table>';
         html += '<div class="button06" style="float:none; margin: 20px auto; width: 130px;">';
         html += '	<div align="center">';
         html += '		<input type="button" onclick="$.domain.orders_submit();" value="สั่งซื้อโดเมนที่คุณต้องการ" />';
         html += '	</div>';
         html += '</div>';
         html += '<a href="javascript::void(0);" id="domain-more" class="btn-domain" onclick="$.domain.orders_more();">เลือกนามสกุลโดเมนอื่น </a>';
         html += '</form>';
         
         // TODO
		 //params = 'cmd=checkdomain&register=1&action=checkdomain&singlecheck=1&domain_cat=1&';
         
         var regType    = $('input[name="transfer"]:checked').val();
         if (regType == '1') {
             params = 'cmd=checkdomain&transfer=1&action=checkdomain&singlecheck=1&domain_cat=1&';
         } else {
             params = 'cmd=checkdomain&register=1&action=checkdomain&singlecheck=1&domain_cat=1&';
         }
         
		 $.post(api + params + 'sld=' + sld + '&tld=' + options.tld, function(data) {
		 	 
			 
			 var resp = $.domain.parse_response(data);
			 if (resp.match(/href\=\"checkdomain\&action\=whois/)) {
				 resp = resp.replace(/href\=\"checkdomain/g, 'href="' + post + '/checkdomain');
			 }

			 
			 $(options.id).html(html);
			 $('#domain-table tr:last').after('<tr class="status-row">' + resp + '</tr>');
			 
			 if (resp.match(/Available\! Order Now/)) {
				 
				 $('#domain-submit').hide();
				 
				 html = '<div id="domain-loading">';
		         html += '	<center><img src="' + img + 'ajax-loading.gif" alt="" /></center>';
		         html += '</div>';
		         $(options.id).append(html);
				 
		         
				 /*
				 var aTld = aTldPopular;
				 if (sld.match(/^xn--/gi)) {
					aTld = aTldXn;
				 }
				 var count = 0;
				 jQuery.each(aTld, function(key, value) {
					 if (options.tld != key)  {
						 $.post(api + params + 'sld=' + sld + '&tld=' + key, function(data1) {
							 $('#domain-table tr:last').after('<tr class="status-row">' + $.domain.parse_response(data1) + '</tr>');
							 loop++;
						 });
						 count++;
					 }
				 });
				 
				 $.domain.loops(count);
				 */
		         $('#domain-submit').submit();
				 
			 } else {
			     
			     // TODO Etc extension
				 
				try {
					
					 var aTld = aTldPopular;
					 if (sld.match(/^xn--/gi)) {
						$('#domain-more').hide();
						aTld = aTldXn;
					 }
					 jQuery.each(aTld, function(key, value) {
						 
						 if ($.reserveword.isReserveword(sld, key) == true) {
							 return; // Continues
						 }
						 
						 if (options.tld != key)  {
							 
							 trId = key.replace(/\./g, "");
	                         var trHtml = '<tr class="status-row" id="tr-domain-' + trId + '" >';
	                         trHtml += '		<td align="center">';
	                         trHtml += '			<img src="' + img + 'ajax-loading2.gif" alt="" />';
	                         trHtml += '		</td>';
	                         trHtml += '		<td align="center"><strong>' + sld + '' + key + '</strong></td>';
	                         trHtml += '		<td align="center">status</td>';
	                         trHtml += '	</tr>';
	                         $('#domain-table tr:last').after(trHtml);
	                         
	                         
	                         $.post(api + params + 'sld=' + sld + '&tld=' + key, function(data1) {
	                        	if (data1.match(/href\=\"checkdomain\&action\=whois/)) {
	                        		data1 = data1.replace(/href\=\"checkdomain/g, 'href="' + post + '/checkdomain');
	                			}
	                        	if (data1.match(/value="(.*)" check/gi)) {
									aMatches = data1.match(/value="(.*)" check/gi);
	                               	if (aMatches[0] != undefined) {
	                                	trId = aMatches[0].replace(/value=\"/g, "");
	                                    trId = trId.replace(/\" check/g, "");
	                                    trId = trId.replace(/\./g, "");
	                              	}
								}
								if (data1.match(/\&amp\;tld=(.*)" onclick/gi)) {
									aMatches = data1.match(/\&amp\;tld=(.*)" onclick/gi);
									trId = aMatches[0].replace(/\&amp\;tld=/g, "");
									trId = trId.replace(/\" onclick/g, "");
									trId = trId.replace(/\./g, "");
								}
								$("#domain-table tr#tr-domain-" + trId).replaceWith('<tr class="status-row">' + $.domain.parse_response(data1) + '</tr>');
	                         });
	                         
	                         
	                         
						   }
					  });
					 
				} catch (e) {}
						     
			 }
			 
			 
		 });
		 
		 
	 };
	 
	 $.domain.whois = function(settings) {
		 
		 sld = jQuery('#sld').val();
		 options = jQuery.extend({
			id: '#container-diplays',
			sld: sld,
			tld: tld
		 }, settings);
		 $.domain.sld(options.sld);
		 
		 if (sld.match(/^[a-z0-9-]+$/gi)) {
		 } else {
			$('#domain-more').hide();
			sld = 'xn--' + punycode.encode(sld);
			if ($.domain.orders_validate(options.tld) == false) {
				return false;
			}
		 }
		 
		 html = '<div id="domain-loading">';
         html += '	<center><img src="' + img + 'ajax-loading.gif" alt="" /></center>';
         html += '</div>';
         $(options.id).html(html);
		 
		 
		 $.post(api + '/checkdomain&action=whois&sld=' + sld + '&tld=' + options.tld, function(data) {
		    if (data == '') {
		        data  = '<p>&nbsp;</p><p align="center" style="color:red;"> ไม่พบข้อมูล whois สำหรับ domain ที่ต้องการค้นหา <br />'
		          +'กรณีที่ต้องการจดโดเมนใหม่ กรุณาเลือกสั่งซื้อโดเมน</p><p>&nbsp;</p>';
		    }
     		$(options.id).html(data);
 		 });
		 
	 };
	 
	 $.domain.suggestion = function(settings) {
		 
		 sld = jQuery('#sld').val();
		 options = jQuery.extend({
			id: '#container-diplays',
			sld: sld,
			tld: tld,
			type: 'suggestion'
		 }, settings);
		 $.domain.sld(options.sld);
		 $.domain.type(options.type);
		 
		 if ($.reserveword.isReserveword(sld, options.tld) == true) {
			 alert("Domain is reserve words " + sld);
			 return false;
		 }
		 
		 if (sld.match(/^[a-z0-9-]+$/gi)) {
		 } else {
			sld = 'xn--' + punycode.encode(sld);
			if ($.domain.orders_validate(options.tld) == false) {
				return false;
			}
		 }
		 
		 
		 html = '<div id="domain-loading">';
         html += '	<center><img src="' + img + 'ajax-loading.gif" alt="" /></center>';
         html += '</div>';
         $(options.id).html(html);
		 
         
         //params = 'cmd=checkdomain&action=checkdomain&singlecheck=1&domain_cat=1&';
         params = 'cmd=checkdomain&action=checkdomain&singlecheck=1&domain_cat=32&';
         $.post(api + params + 'sld=' + sld + '&tld=' + options.tld + '&suggestions=10', function(data) {
        	 
        	 
        	 html = '<form action="' + post + '/cart&amp;step=1&amp;cat_id=register&amp;tld_cat=1&amp;ref=1&amp;domain=illregister" method="post" id="domain-submit">';
    		 html += '<table width="100%" cellpadding="0" cellspacing="0" class="domain-table" id="domain-table">';
             html += '  <colgroup>';
             html += '      <col width="5%" />';
             html += '      <col width="31%" />';
             html += '      <col width="31%" />';
             html += '      <col width="33%" />';
             html += '  </colgroup>';
             html += '  <tr class="status-head">';
             html += '      <td align="center">&nbsp;</td>';
             html += '      <td align="center">Domain</td>';
             html += '      <td align="center">Status</td>';
             html += '      <td align="center">Period</td>';
             html += '  </tr>';
                          
             html += '  <tr class="status-head" id="tr-domain-keyword">';
             html += '  </tr>';             
             
             html += '<tbody id="suggestions" style="display:none" >';
        	 html += '	<tr class="status-head">';
        	 html += '		<td/>';
        	 html += '		<td align="center">';
        	 html += '			Recommended names';
        	 html += '		</td>';
        	 html += '		<td colspan="2"/>';
        	 html += '	</tr>';
        	 html += '	<tr id="sgtpl" style="display:none" class="status-row-white">';
        	 html += '		<td align="center">&nbsp;<input type="checkbox" name="tld[$t_sld$t_tld]" value="$t_tld" />';
        	 html += '			<input type="hidden" name="sld[$t_sld$t_tld]" value="$t_sld" />';
        	 html += '		</td>';
        	 html += '		<td align="center">';
        	 html += '			<strong>$t_sld$t_tld</strong>';
        	 html += '		</td>';
        	 html += '<td align="center"><b style="color:#6D9D2C">Available! Order Now.</b></td>';
        	 html += '<td align="right">';
        	 html += '<div class="select-status">';
        	 html += '<div>';
        	 html += '<select  style="padding: 0;" name="period[$t_sld$t_tld]">';
        	 html += '<option value="$t_period">$t_period Year/s @ $t_price</option>';
        	 html += '</select>';
        	 html += '</div>';
        	 html += '</div>';
        	 html += '</td>';
        	 html += '</tr>';
        	 html += '</tbody>';
        	 
             
             
             html += '</table>';
             html += '<div class="button06" style="float:none; margin:20px auto; width: 130px;">';
             html += '	<div>';
             html += '		<input type="button" onclick="$.domain.orders_submit();" value="สั่งซื้อโดเมนที่คุณต้องการ" />';
             html += '	</div>';
             html += '</div>';
             html += '</form>';
        	 
        	 
        	 
        	 
        	 
			 $(options.id).html(html);
			 			 
			 
			 data = $.domain.parse_response(data);
			 var aMatchs = data.match(/^<td[\s\S]*?<script/gm);
			 if (aMatchs != null) {
				 aMatchs = aMatchs[0].replace(/<script$/g, "");
				 $("#domain-table tr#tr-domain-keyword").replaceWith('<tr class="status-row">' + aMatchs + '</tr>');
			 }
			 
			 
			 output = data.replace(/^<td[\s\S]*?<script/gm, "");
			 output = '<script' + output;
			 $(options.id).append(output);
			 
			 
         });
		 
		 
	 };
	 
	 $.domain.tld = function(param) {
		 tld = param;
	 };
	 
	 $.domain.sld = function(param) {
		 sld = param;
	 };
	 
	 $.domain.type = function(param) {
		 type = param;
	 };
	 
	 $.domain.api = function(param) {
		 if (param != '') {
			 
			 api = param;
			 
			 checkURL = document.URL;
			 if (checkURL.match(/netway\.co\.th/gi)) {
			 } else {
				 
				 var protocal = 'http://';
                 if (checkURL.match(/http:\/\/www\./)) {
                	 protocal = 'http://www.';
            	 } else if (checkURL.match(/https:\/\/www\./)) {
            		 protocal = 'https://www.';
               	 } else if (checkURL.match(/http:\/\//)) {
               		 protocal = 'http://';
            	 } else if (checkURL.match(/https:\/\//)) {
            		 protocal = 'https://';
            	 }
                 
                 api = protocal + param;
			 }
			 
		 }
	 };
	 
	 $.domain.getTldPopular = function() {
		 return aTldPopular;
	 };
	 
	 $.domain.getTld = function() {
		 return aLtd;
	 };
	 
	 $.domain.getXn = function() {
		 return aTldXn;
	 };
	 
	 $.domain.getApi = function() {
		 return api;
	 };
	 
	 $.domain.isEmpty = function(obj) {
		 
		if (typeof obj == "string") {
			if (obj.length > 0)
		    	return false;
		}
		    
		for (var prop in obj) {
			if (obj.hasOwnProperty(prop))
		    	return false;
		}

		return true;
	 };
	 
	 $.domain.parse_response = function(data) {

		if (data.indexOf('<!-- {')!=0)
			return false;
		return data.substr(data.indexOf('-->')+3, data.length);
	 };
		 
	 $.domain.mainTld = function() {
		 
		 if ($('div.dropbg').hasClass('shown'))
             $('div.dropbg').hide().removeClass('shown');
         else {
             $('div.dropbg').show().addClass('shown');
         }
		 
         return true;
	 };
	 
	 $.domain.tldDropDown = function() {
		 
		 $('input[name=tld]').val(tld);
	 	 $('div.mainTld').html(tld);
	     $('div.dropbg').hide().removeClass('shown');
	     
	 };
	 
	 
	 	 
})(jQuery);



function addSuggestions(list) {
	
	if (type == 'order')
		return false;
	
	
	if (list.length > 0) {
		var style = $('#suggestions tr:last:not(#sgtpl)').length? !$('#suggestions tr:last:not(#sgtpl)').hasClass('status-row-white'): !$('#sgtpl').hasClass('status-row-white');
		for(var i=0; i<list.length;i++){
			var html = $('#sgtpl').html().replace(new RegExp('\\$t_sld','g'),list[i].sld).replace(new RegExp('\\$t_tld','g'),list[i].tld);
			var tr = $('#sgtpl').clone().attr('id','').html(html);
			var sel = tr.find('select').html();
			tr.find('select').html('');
	
			for(var s=0; s<list[i].price.length; s++){
			tr.find('select').append(sel
				.replace(new RegExp('\\$t_period','g'),list[i].price[s].period).replace(new RegExp('\\$t_price','g'),list[i].price[s].register));
			}
			tr.attr('class','');
			if(style)
				tr.addClass('status-row-white');
			style = !style;
			tr.appendTo( '#suggestions' ).addClass('status-row').show();
		}
		$('#suggestions').fadeIn();
	}
}


function httpGet(url) {
	
	checkURL = document.URL;
	httpContent = "";
	
	if (checkURL.match(/netway\.co\.th/gi) || checkURL.match(/127\.0\.0\.1/gi) 
		 || checkURL.match(/192\.168\.1\./gi) || checkURL.match(/localhost/gi)) {
		
		var xmlHttp = null;
	    xmlHttp = new XMLHttpRequest();
	    xmlHttp.open("GET", url, false );
	    xmlHttp.send(null);
	    httpContent = xmlHttp.responseText;
	}
	
	return httpContent;
}

function goEnter(e, goType) {
	
	if (e.keyCode == 13) {
		if (goType == 'whois') {
	    	 $.domain.whois();
	    } else if (goType == 'suggestion') {
	    	 $.domain.suggestion();
	    } else {
	    	 $.domain.orders();
	    }
        return false;
    }
	
}
