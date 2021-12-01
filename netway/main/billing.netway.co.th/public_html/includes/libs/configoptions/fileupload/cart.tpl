{php}
include_once(APPDIR_LIBS . 'configoptions/fileupload/cart.tpl.php');
{/php}
{foreach from=$cf.items item=cit}
    <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]" 
        id="custom_field_{$cf.id}" value="{$contents[1][$cf.id][$cit.id].val}" 
        class="styled custom_field custom_field_{$cf.id}" type="hidden"
        onchange="if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"/>  
    <span id="custom_field_display_{$cf.id}"></span>
    <div id="fileUploaderAttachment_{$cf.id}">
        <noscript><p>Please enable JavaScript to use file uploader.</p></noscript>
    </div>
    
    <script language="JavaScript">
    {literal}
    $(document).ready(function () {
        
        if (typeof qq != 'undefined') {

        var uploader_{/literal}{$cf.id}{literal}   = new qq.FileUploader({
            element: document.getElementById('fileUploaderAttachment_{/literal}{$cf.id}{literal}'),
            action: '?cmd=supporthandle&action=customfieldFileupload',
            uploadButtonText: 'Upload file',
            onComplete: function(id, fileName, responseJSON){
                if (typeof responseJSON.filename != 'undefined') {
                    var oldFile     = $('#custom_field_{/literal}{$cf.id}{literal}').val();
                    $('#custom_field_{/literal}{$cf.id}{literal}').val(''+responseJSON.filename+'');
                    $('#custom_field_display_{/literal}{$cf.id}{literal}').text(fileName);
                    
                    if (oldFile != '') {
                        $.post('?cmd=supporthandle&action=customfieldDeleteFile', {filename:oldFile}, function (){});
                    }
                    
                    $('.qq-upload-success').fadeOut({duration:2000});
                    
                } else {
                    $('#custom_field_display_{/literal}{$cf.id}{literal}').text('');
                }
            }
        });
        
        }

        var oldFile     = $('#custom_field_{/literal}{$cf.id}{literal}').val();
        if (oldFile != '') {
            $('#custom_field_display_{/literal}{$cf.id}{literal}').text(oldFile);
        }
        
    });
    {/literal}
    </script>
    
    
    <br/>
{/foreach}