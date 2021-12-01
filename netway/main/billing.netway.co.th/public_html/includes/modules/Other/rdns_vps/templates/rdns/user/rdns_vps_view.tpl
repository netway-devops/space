<script type="text/javascript">
    var account_id = "{$service.id}";
{literal}

    $(document).ready(function () {
    
        data = {
            cmd: 'rdns_vps',
            action: 'doViewrDns',
            account_id: account_id
        };
    
        $.ajax({
            type: 'POST',
            data: data,
            success: function(data) {
            
                if (data.aResponse.view.isValid == 'true' || data.aResponse.view.isValid == true) {
                    
                    isHtmlBtn = false;
                    
                    html = '<form id="rv-form-rdns-vps">'
                    html += '<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >';
                    html += '   <tr>';
                    html += '       <th width="120">IP</th>';
                    html += '       <th>Hostname</th>';
                    html += '   </tr>';
                    
                    
                    jQuery.each(data.aResponse.view, function(key, value) {
                    
                            jQuery.each(value, function(key2, value2) {
                            
                                isHtmlBtn = true;
                                
                                if (key2 == 'ptrcontent') {
                                    html += '<tr>';
                                    html += '<td style="padding-top:15px;font-weight:bold">' + key + '</td>';
                                    html += '<td>';
                                    
                                    if (value.ptrzone == '') {
                                        html += '   <input disabled="disabled" name="rdns[' + key + '][' + key2 + ']" value="Unable to load related .in-addr.arpa zone" type="text" style="width:350px;" />';
                                    } else {
                                        html += '   <input name="rdns[' + key + '][' + key2 + ']" value="' + value2 + '" type="text" style="width:350px;" />';
                                    }
                                    
                                    html += '</td>';
                                     html += '</tr>';
                                } else {
                                    html += '   <input type="hidden" name="rdns[' + key + '][' + key2 + ']" value="' + value2 + '" />';
                                }
                                
                                
                                
                            });
                        
                        
                    });
                    
                    
                    
                    html += '</table>';
                    
                    if (isHtmlBtn == true) {
                    
                        html += '<div class="form-actions" style="text-align: center">';
                        html += '   <input type="button" onclick="UpdaterDnsVps();" style="font-weight:bold" value="Update Reverse DNS" class="btn btn-info ">';
                        html += '   <div class="clear"></div>';
                        html += '</div>';
                        
                    }
                    
                    html += '</form>';
                    
                    $('#rv-display-rdns-vps').html(html);
                    
                } else {
                    
                    msgError = '<div id="errors">';
                    msgError += '   <div class="notifications alert alert-error" style="display:block">';
                    msgError += '       <button type="button" class="close" data-dismiss="alert">×</button>';
                    msgError += '       <span>' + data.aResponse.view.raiseError + '</span>';
                    msgError += '   </div>';
                    msgError += '</div>';
                    
                    $('#rv-display-rdns-vps').html(msgError);
                    
                }
                
            },
            error: function(xhr,error) {
            }
        });
                
    });
    
    
    function UpdaterDnsVps() {
    
        data = {
            cmd: 'rdns_vps',
            action: 'doUpdaterDns',
            account_id: account_id,
            ptr: $('#rv-form-rdns-vps').serializeArray()
        };
        
        $('body').css({'cursor':'wait'});
        $.ajax({
            type: 'POST',
            data: data,
            success: function(data) {
                parse_response(data);
                $('body').css({'cursor':'default'});
            },
            error: function(xhr,error) {
            }
        });
        
    }
    
{/literal}

</script>

<div id='rv-display-rdns-vps'></div>