{foreach from=$c.items item=cit}
    <input type="hidden" id="custom_field_{$kk}_{$cit.id}" name="custom[{$kk}][{$cit.id}]"  value="{$c.data[$cit.id]|htmlspecialchars}"/> {$cit.name}
    <span id="custom_field_display_{$kk}_{$cit.id}"></span>
    
    <div id="fileUploaderAttachment_{$kk}_{$cit.id}">
        <noscript><p>Please enable JavaScript to use file uploader.</p></noscript>
    </div>
    
    <script language="JavaScript">
    {literal}
    $(document).ready(function () {
        
        {/literal}{if $details.status == 'Pending' || (isset($admindata.id) && $admindata.id)}{literal}
        if (typeof qq != 'undefined') {
        
        var uploader_{/literal}{$kk}_{$cit.id}{literal}   = new qq.FileUploader({
            element: document.getElementById('fileUploaderAttachment_{/literal}{$kk}_{$cit.id}{literal}'),
            action: '?cmd=supporthandle&action=customfieldFileupload',
            params: {
                type:'{/literal}{if isset($details.tld_id) && $details.tld_id}Domain{else}Hosting{/if}{literal}',
                accountId:{/literal}{if $details.id}{$details.id}{else}0{/if}{literal},
                catId:{/literal}{if $kk}{$kk}{else}0{/if}{literal},
                configId:{/literal}{if $cit.id}{$cit.id}{else}0{/if}{literal}
            },
            uploadButtonText: 'Upload new file',
            onComplete: function(id, fileName, responseJSON){
                if (typeof responseJSON.filename != 'undefined') {
                    var oldFile     = $('#custom_field_{/literal}{$kk}_{$cit.id}{literal}').val();
                    $('#custom_field_{/literal}{$kk}_{$cit.id}{literal}').val(''+responseJSON.filename+'');
                    $('#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}').text(fileName);
                    
                    var inputVal        = $('#custom_field_{/literal}{$kk}_{$cit.id}{literal}').val();
                    var n               = inputVal.indexOf('::');
                    var fileId          = inputVal.substring(0, n);
                    if (fileId != '') {
                        $('#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}').html('<a class="delbtn" href="" onclick="if (confirm(\'Are you sure you want to delete this file?\')){$.post(\'?cmd=supporthandle&action=customfieldDeleteFile\', {filename:\''+oldFile+'\',type:\'{/literal}{if isset($details.tld_id) && $details.tld_id}Domain{else}Hosting{/if}{literal}\',accountId:{/literal}{$details.id}{literal},catId:{/literal}{$kk}{literal},configId:{/literal}{$cit.id}{literal}}, function (){ $(\'#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}\').html(\'\');});return false;}" style="float:left;">delete</a> &nbsp; <a href="?cmd=root&amp;action=download&amp;type=downloads&amp;id='+ fileId +'" target="_blank">'+ $('#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}').text() +'</a>');
                    }
                    
                    if (oldFile != '') {
                        $.post('?cmd=supporthandle&action=customfieldDeleteFile', {filename:oldFile}, function (){});
                    }
                    
                    $('.qq-upload-success').fadeOut({duration:2000});
                    
                } else {
                    $('#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}').text('');
                }
            }
        });

        }
        {/literal}{/if}{literal}
        
        var oldFile     = $('#custom_field_{/literal}{$kk}_{$cit.id}{literal}').val();
        if (oldFile != '') {
            $('#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}').text(oldFile);
            
            var inputVal        = $('#custom_field_{/literal}{$kk}_{$cit.id}{literal}').val();
            var n               = inputVal.indexOf('::');
            var fileId          = inputVal.substring(0, n);
            if (fileId != '') {
                $('#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}').html('<a class="delbtn" href="" onclick="if (confirm(\'Are you sure you want to delete this file?\')){$.post(\'?cmd=supporthandle&action=customfieldDeleteFile\', {filename:\''+oldFile+'\',type:\'{/literal}{if isset($details.tld_id) && $details.tld_id}Domain{else}Hosting{/if}{literal}\',accountId:{/literal}{$details.id}{literal},catId:{/literal}{$kk}{literal},configId:{/literal}{$cit.id}{literal}}, function (){ $(\'#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}\').html(\'\');});return false;}" style="float:left;">delete</a> &nbsp; <a href="?cmd=root&amp;action=download&amp;type=downloads&amp;id='+ fileId +'" target="_blank">'+ $('#custom_field_display_{/literal}{$kk}_{$cit.id}{literal}').text() +'</a>');
            }

        }
        
    });
    {/literal}
    </script>
    
{/foreach}