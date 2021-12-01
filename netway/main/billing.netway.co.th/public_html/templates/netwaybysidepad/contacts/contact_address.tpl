{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'contacts/contact_address.tpl.php');
{/php}
<input id="field_email" name="email" type="hidden" value="{if $submit.email}{$submit.email}{else}{$oClient->email}{/if}" />
<input id="field_password" name="password" type="hidden" value="{if $submit.password}{$submit.password}{else}{$newPassword}{/if}" />
<input id="field_password2" name="password2" type="hidden" value="{if $submit.password}{$submit.password}{else}{$newPassword}{/if}" />
<input id="field_country" name="country" type="hidden" value="{if $submit.country}{$submit.country}{else}TH{/if}" />
<input id="field_addresstype" name="addresstype" type="hidden" value="{if $submit.addresstype}{$submit.addresstype}{else}Invoice{/if}" />
<input id="billing_payinvoice" name="privileges[billing][payinvoice]" type="hidden" value="1" />

<div class="row-fluid">
    <div class="span6">
        <div class="form-horizontal">
            <p>&nbsp;</p>
            <div class="control-group">
                <label class="control-label" for="field_type">ประเภท * </label>
                <div class="controls">
                    <select  id="field_type"  name="type" onchange="{literal}if ($(this).val()=='Private') {$('#organizationName').hide();} else {$('#organizationName').show();}{/literal}">
                        <option value="Company" {if $submit.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                        <option value="Private" {if $submit.company=='0'}selected="selected"{/if}>{$lang.Private}</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    
    <div class="span6">
        <div class="form-horizontal">
            <p>&nbsp;</p>
            <div id="organizationName" class="control-group iscomp">
                <label class="control-label" for="field_companyname">Organization *</label>
                <div class="controls">
                    <input type="text" id="field_companyname" name="companyname" value="{$submit.companyname}" />
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span12">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_taxid">เลขประจำตัวผู้เสียภาษี * </label>
                <div class="controls">
                    <input type="text" id="field_taxid" name="taxid" value="{$submit.taxid}" /><br />
                    กรุณาระบุ เลขประจำตัวผู้เสียภาษี กรณีเป็นนิติบุคคล / เลขประจำตัวประชาชน กรณีเป็นบุคคลธรรมดา
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span6">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_firstname">ชื่อ * </label>
                <div class="controls">
                    <input type="text" id="field_firstname" name="firstname" value="{$submit.firstname}" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="span6">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_lastname">นามสกุล * </label>
                <div class="controls">
                    <input type="text" id="field_lastname" name="lastname" value="{$submit.lastname}" />
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span12">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_address1">ที่อยู่ 1 * </label>
                <div class="controls">
                    <input type="text" id="field_address1" name="address1" value="{$submit.address1}" class="input-xxlarge" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="field_address2">ที่อยู่ 2 </label>
                <div class="controls">
                    <input type="text" id="field_address2" name="address2" value="{$submit.address2}" class="input-xxlarge" />
                </div>
            </div>
        </div>
    </div>
    
</div>

<div class="row-fluid">
    <div class="span6">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_city">เขต * </label>
                <div class="controls">
                    <input type="text" id="field_city" name="city" value="{$submit.city}" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="span6">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_state">จังหวัด * </label>
                <div class="controls">
                    <input type="text" id="field_state" name="state" value="{$submit.state}" />
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span6">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_postcode"> รหัสไปรษณีย์ * </label>
                <div class="controls">
                    <input type="text" id="field_postcode" name="postcode" value="{$submit.postcode}" />
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span6">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_phonenumber">Phone * </label>
                <div class="controls">
                    <input type="text" id="field_phonenumber" name="phonenumber" value="{$submit.phonenumber}" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="span6">
        <div class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="field_fax">Fax </label>
                <div class="controls">
                    <input type="text" id="field_fax" name="fax" value="{$submit.fax}" />
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="{$template_dir}js/chosen.min.js"></script>
{literal}
    <script>
        $(document).ready(function(){
            $(".chzn-select").chosen();
            if ($('#field_type option:checked').val() == 'Private') {
                $('#organizationName').hide();
            }
            $('#field_type, #field_companyname').change( function () {
                $.post('?cmd=addresshandle&action=updateContactType&clientId={/literal}{$submit.id}{literal}',{
                        contactType     : $('#field_type option:checked').val(),
                        companyName     : $('#field_companyname').val()
                    }, function () {});
            });
        });
    </script>

{/literal}