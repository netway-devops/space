{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'contacts/contact_notify.tpl.php');
{/php}

<div class="row-fluid">
    <div class="span12">
        <div class="form-horizontal">
            <p>&nbsp;</p>
            <div class="control-group">
                <label class="control-label" for="field_email">Email * </label>
                <div class="controls">
                    <input type="text" id="field_email" name="email" value="{$submit.email}" class="input-xlarge" />
                </div>
            </div>
            
            <div class="row-fluid">
                <div class="span6">
                    <div class="control-group">
                        <label class="control-label" for="field_firstname">Firstname </label>
                        <div class="controls">
                            <input type="text" id="field_firstname" name="firstname" value="{$submit.firstname}" class="input-large" />
                        </div>
                    </div>
                </div>
                <div class="span6">
                    <div class="control-group">
                        <label class="control-label" for="field_lastname">Lastname </label>
                        <div class="controls">
                            <input type="text" id="field_lastname" name="lastname" value="{$submit.lastname}" class="input-large" />
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label" for="field_phonenumber">Phone </label>
                <div class="controls">
                    <input type="text" id="field_phonenumber" name="phonenumber" value="{$submit.phonenumber}" class="input-xlarge" />
                </div>
            </div>
            
            {*
            <div class="control-group">
                <label class="control-label" for="field_email">Receive related email notifications</label>
                <div class="controls">
                    <input type="radio" name="notifyAll" value="1" /> &nbsp; <b>All service</b>
                    &nbsp;
                    <input type="radio" name="notifyAll" value="" checked="checked" /> &nbsp; <b>By service</b>
                </div>
            </div>
            *}
            
            <p class="add-contact pl19">Receive related email notifications <br /><br /></p>
            
            {if count($domains)}
            <div class="control-group">
                <label class="control-label">&nbsp;</label>
                <div class="controls">
                    <input type="checkbox" name="notifyAllDomain"  id="notifyAllDomain" value="1" /> &nbsp; <b>All domain</b><br /><br />
                    
                    <div class="offset1">
                    {foreach from=$domains item=o name=floop}
                    {if  ($smarty.foreach.floop.iteration%2)}<div class="row-fluid">{/if}
                        <div class="span5">
                            <input id="domains_{$o.id}_notify" name="privileges[domains][{$o.id}][notify]" type="checkbox" value="1" class="notifyDomain"  {if $submit.privileges.domains[$o.id].notify} checked="checked" {/if} /> &nbsp; {$o.name}
                        </div>
                    {if ! ($smarty.foreach.floop.iteration%2) || ($smarty.foreach.floop.iteration == $smarty.foreach.floop.total)}</div>{/if}
                    {/foreach}
                    </div>
                </div>
            </div>
            {/if}
            
            {if count($services)}
            <div class="control-group">
                <label class="control-label">&nbsp;</label>
                <div class="controls">
                    <input type="checkbox" name="notifyAllService" id="notifyAllService" value="1" /> &nbsp; <b>All Service</b><br /><br />
                    
                    {foreach from=$aServiceCategory key=catName item=aItem name=floop}
                    <div class="offset1"><input type="checkbox" name="notifyService" value="1" class="notifyService notifyService_ notifyService_cat{$smarty.foreach.floop.iteration}" accesskey="{$smarty.foreach.floop.iteration}" /> &nbsp; <b>{$catName}</b></div>
                    <div class="offset2">
                    {foreach from=$aItem key=serviceId item=idx}
                        <div>
                            <input id="services_{$serviceId}_notify" name="privileges[services][{$serviceId}][notify]" type="checkbox" value="1" class="notifyService notifyService_{$smarty.foreach.floop.iteration} notifyService_item" accesskey="{$smarty.foreach.floop.iteration}" {if $submit.privileges.services[$serviceId].notify} checked="checked" {/if} /> 
                            &nbsp; {$services[$idx].name} {if $services[$idx].domain} for {$services[$idx].domain}{/if}
                        </div>
                    {/foreach}
                    </div>
                    {/foreach}
                </div>
            </div>
            {/if}
            
        </div>
    </div>
    
</div>


<script type="text/javascript" src="{$template_dir}js/chosen.min.js"></script>
{literal}
    <script>
        $(document).ready(function(){
            
            $('#notifyAllDomain').click( function () {
                if ($(this).is(':checked')) {
                    $('.notifyDomain').prop('checked', true);
                } else {
                    $('.notifyDomain').prop('checked', false);
                }
            });
            
            $('.notifyDomain').click( function () {
                if ($('.notifyDomain:not(":checked")').length) {
                    $('#notifyAllDomain').prop('checked', false);
                } else {
                    $('#notifyAllDomain').prop('checked', true);
                }
            });
            
            $('#notifyAllService').click( function () {
                if ($(this).is(':checked')) {
                    $('.notifyService').prop('checked', true);
                } else {
                    $('.notifyService').prop('checked', false);
                }
            });
            
            $('.notifyService').click( function () {
                if ($('.notifyService:not(":checked")').length) {
                    $('#notifyAllService').prop('checked', false);
                } else {
                    $('#notifyAllService').prop('checked', true);
                }
            });
            
            $('.notifyService_').click( function () {
                var idx     = $(this).attr('accesskey');
                if ($(this).is(':checked')) {
                    $('.notifyService_'+idx+'').prop('checked', true);
                } else {
                    $('.notifyService_'+idx+'').prop('checked', false);
                }
                if ($('.notifyService:not(":checked")').length) {
                    $('#notifyAllService').prop('checked', false);
                } else {
                    $('#notifyAllService').prop('checked', true);
                }
            });
            
            $('.notifyService_item').click( function () {
                var idx     = $(this).attr('accesskey');
                if ($('.notifyService_'+idx+':not(":checked")').length) {
                    $('.notifyService_cat'+idx+'').prop('checked', false);
                } else {
                    $('.notifyService_cat'+idx+'').prop('checked', true);
                }
                if ($('.notifyService:not(":checked")').length) {
                    $('#notifyAllService').prop('checked', false);
                } else {
                    $('#notifyAllService').prop('checked', true);
                }
            });
            
            $('.notifyService_item').each( function () {
                var idx     = $(this).attr('accesskey');
                if ($('.notifyService_'+idx+':not(":checked")').length) {
                    $('.notifyService_cat'+idx+'').prop('checked', false);
                } else {
                    $('.notifyService_cat'+idx+'').prop('checked', true);
                }
            });
            
            if (! $('.notifyService_item:not(":checked")').length) {
                $('#notifyAllService').prop('checked', true);
            }
            if (! $('.notifyDomain:not(":checked")').length) {
                $('#notifyAllDomain').prop('checked', true);
            }

            $('#formEditContact').submit( function () {
                $.post('?cmd=addresshandle&action=updateNotificationContact&contactId={/literal}{$submit.id}{literal}', $('#formEditContact').serialize(), function (data) {
                    var oResult = jQuery.parseJSON(data);
                    if (oResult.result.success == '1') {
                        window.location = '{/literal}{$ca_url}profiles/&act={$act}{literal}';
                    }
                });
                return false;
            });
            
        });
    </script>

{/literal}