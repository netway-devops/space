<link href="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/css/domain.css?v={$hb_version}" rel="stylesheet" media="all" />

<script src="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/reserveword.js"></script>
<script src="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/punycode.js"></script>
<script src="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/domain.js"></script>


    
    <script type="text/javascript">
    	
		var system_url = "{$system_url}";
		
 {literal}
    	
		var loop = 0;
        var aMoreTldExist = {};
		var aMore = {};
		var sld = '';
		
		$(document).ready(function() {

			contentHtml = httpGet(urlTld);
			$.domain.init.tld();
			
			var html = '<tr>';
			html += '        <th width="75%" align="left">&nbsp;</th>';
			html += '        <th width="30%">&nbsp;</th>';
			html += '        <th width="5%">&nbsp;&nbsp;&nbsp;&nbsp;</th>';
			html += '  </tr>';
			$('.checker tr:last').after(html);
			
			
			var ltdcount = 0;
			{/literal}
                {foreach from=$domain item=doms key=kk name=domainsloop}
				  sld = "{$doms.sld}";
                  aMoreTldExist["{$doms.tld}"] = "{$doms.tld}";
				  ltdcount++;
                {/foreach}
            {literal}
			
			
			// start load popular
			if (ltdcount == 1) {
				
				html = '<table width="100%" cellpadding="0" cellspacing="0" class="table-more-extension" id="table-more-extension">';
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
				html += '<div class="button06" style="float:none; margin: 20px  0px 20px 270px; width: 130px;">';
                html += '  <div>';
                html += '      <input type="button" onclick="orders_submit();" value="Register selected" />';
                html += '  </div>';
                html += '</div>';
                $('#show-more-extension').html(html);
				
				
				var aTld = $.domain.getTldPopular();
                if (sld.match(/^xn--/gi)) {
                    aTld = $.domain.getXn();
                }
 
                jQuery.each(aTld, function(key, value) {
                    if (aMoreTldExist[key] == undefined) {
						var trId = key.replace(/\./g, "");
	                    var trHtml = '<tr class="status-row" id="tr-domain-' + trId + '" >';
	                    trHtml += '        <td align="center">';
	                    trHtml += '            <img src="' + system_url + 'includes/modules/Other/netway_common/public_html/js/domain/images/ajax-loading2.gif" alt="" />';
	                    trHtml += '        </td>';
	                    trHtml += '        <td align="center"><strong>' + sld + '' + key + '</strong></td>';
	                    trHtml += '        <td align="center">status</td>';
	                    trHtml += '    </tr>';
	                    $('#table-more-extension tr:last').after(trHtml);
						
						params = '?cmd=checkdomain&register=1&action=checkdomain&singlecheck=1&domain_cat=1&sld=' + sld + '&tld=' + key;
                        $.post(params, function(data) {
							
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
							
							
                            if (data.match(/Available\! Order Now/)) {
                                $("#table-more-extension tr#tr-domain-" + trId).replaceWith('<tr class="status-row">' + $.domain.parse_response(data) + '</tr>');
								aMore[key] = key;
                            } else {
                                $("#table-more-extension tr#tr-domain-" + trId).remove();
                            }
                        
                        });
					
						
						
					}
				});
				
			}
			//end
			
			
			
			
		});
		
		
		function orders_submit() {
			
		   jQuery.each(aMoreTldExist, function(key, value) {
		      $('#my-domain-submit').append('<input type="hidden" name="tld[' + sld + '' + key + ']" value="' + key + '"/>');
              $('#my-domain-submit').append('<input type="hidden" name="sld[' + sld + '' + key + ']" value="' + sld + '"/>');
              $('#my-domain-submit').append('<input type="hidden" name="period[' + sld + '' + key + ']" value="1"/>');
		   });
		   
		   
		   jQuery.each(aMore, function(key, value) {
				
				$("input[name='tld[" + sld + "" + key + "]']:checked").each(function () {
                    $('#my-domain-submit').append('<input type="hidden" name="tld[' + sld + '' + key + ']" value="' + key + '"/>');
                    $('#my-domain-submit').append('<input type="hidden" name="sld[' + sld + '' + key + ']" value="' + sld + '"/>');
                    $('#my-domain-submit').append('<input type="hidden" name="period[' + sld + '' + key + ']" value="1"/>');
                });
				
		   });
		   
		   
		   $('#my-domain-submit').submit();
		}
		
		function postLoop(count) {
	         setTimeout(function() {
	             if (loop >= count) {
	                 loop = 0;
	                 $('#my-domain-submit').submit();
	             } else {
	                 postLoop(count);
	             }
	         }, 50);
        }


        function loadMoreExtension2() {
			
			html = '<table width="100%" cellpadding="0" cellspacing="0" class="table-more-extension" id="table-more-extension">';
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
            html += '<div class="button06" style="float:none; margin: 20px  0px 20px 270px; width: 130px;">';
            html += '  <div>';
            html += '      <input type="button" onclick="orders_submit();" value="Register selected" />';
            html += '  </div>';
            html += '</div>';
            $('#show-more-extension').html(html);
			
			var aTld = $.domain.getTld();
            if (sld.match(/^xn--/gi)) {
                aTld = $.domain.getXn();
            }
			
			jQuery.each(aTld, function(key, value) {
                if (aMoreTldExist[key] == undefined) {
					
					
					    var trId = key.replace(/\./g, "");
                        var trHtml = '<tr class="status-row" id="tr-domain-' + trId + '" >';
                        trHtml += '        <td align="center">';
                        trHtml += '            <img src="' + system_url + 'includes/modules/Other/netway_common/public_html/js/domain/images/ajax-loading2.gif" alt="" />';
                        trHtml += '        </td>';
                        trHtml += '        <td align="center"><strong>' + sld + '' + key + '</strong></td>';
                        trHtml += '        <td align="center">status</td>';
                        trHtml += '    </tr>';
                        $('#table-more-extension tr:last').after(trHtml);
                        
                        params = '?cmd=checkdomain&register=1&action=checkdomain&singlecheck=1&domain_cat=1&sld=' + sld + '&tld=' + key;
                        $.post(params, function(data) {
                            
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
                            
                            if (data.match(/Available\! Order Now/)) {
                                $("#table-more-extension tr#tr-domain-" + trId).replaceWith('<tr class="status-row">' + $.domain.parse_response(data) + '</tr>');
                                aMore[key] = key;
                            } else {
                                $("#table-more-extension tr#tr-domain-" + trId).remove();
                            }
                        
                        });
					
					
					
				}
			});
			
			
		}

        function loadMoreExtension() {
			
			
			
			var aTld = $.domain.getTld();
			if (sld.match(/^xn--/gi)) {
                aTld = $.domain.getXn();
            }
			
			var aTldCart2 = {};
			var count = 0;
			
			html = '<tr>';
			html += '    <td align="center" colspan="3">';
			html += '        <div id="domain-loading">';
            html += '           <center><img src="' + system_url + 'includes/modules/Other/netway_common/public_html/js/domain/images/ajax-loader_blue.gif" alt="" /></center>';
            html += '        </div>';
			html += '    </td>';
			html += '</tr>';
            $('.checker tr:last').after(html);
						
			
            jQuery.each(aTld, function(key, value) {
				
				
                if (aMoreTldExist[key] == undefined) {
					
					
					
					/*
					var trId = key.replace(/\./g, "");
			        var trHtml = '<tr class="status-row" id="tr-domain-' + trId + '" >';
			        trHtml += '        <td align="center">';
			        trHtml += '            <img src="' + system_url + 'includes/modules/Other/netway_common/public_html/js/domain/images/ajax-loading2.gif" alt="" />';
			        trHtml += '        </td>';
			        trHtml += '        <td align="center"><strong>' + sld + '' + key + '</strong></td>';
			        trHtml += '        <td align="center">status</td>';
			        trHtml += '    </tr>';
			        $('.checker tr:last').after(trHtml);
			        */
					
					params = '?cmd=checkdomain&register=1&action=checkdomain&singlecheck=1&domain_cat=1&sld=' + sld + '&tld=' + key;
			        $.post(params, function(data) {
						
						    /*
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
                            */
							
							if (data.match(/Available\! Order Now/)) {
                                //$(".checker tr#tr-domain-" + trId).replaceWith('<tr class="status-row">' + $.domain.parse_response(data) + '</tr>');
								
								$('#my-domain-submit').append('<input type="hidden" name="tld[' + sld + '' + key + ']" value="' + key + '"/>');
                                $('#my-domain-submit').append('<input type="hidden" name="sld[' + sld + '' + key + ']" value="' + sld + '"/>');
                                $('#my-domain-submit').append('<input type="hidden" name="period[' + sld + '' + key + ']" value="1"/>');
								
						    } else {
								//$(".checker tr#tr-domain-" + trId).remove();
							}
						
						
						    loop++;
						
			        });
					
					
					count++;
					
					
                } else {
					
					$('#my-domain-submit').append('<input type="hidden" name="tld[' + sld + '' + key + ']" value="' + key + '"/>');
                    $('#my-domain-submit').append('<input type="hidden" name="sld[' + sld + '' + key + ']" value="' + sld + '"/>');
                    $('#my-domain-submit').append('<input type="hidden" name="period[' + sld + '' + key + ']" value="1"/>');
				}
				
            });
			
			
			postLoop(count);
			
			
			
		}

    </script>
{/literal}


<form action="{$ca_url}cart&amp;step=1&amp;cat_id=register" method="post" id="my-domain-submit">
    <input type="hidden" name="tld_cat" value="{$category.id}" /> <!-- tld_car=1 -->
    <input type="hidden" name="ref"  value="1"/>
    <input type='hidden' name='domain' value='illregister'/>       
</form>