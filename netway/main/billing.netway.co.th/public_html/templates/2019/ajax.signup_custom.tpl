{*
    * จัดหน้าลงทะเบียนใหม่ของ hostbill interface ไม่ดี
*}

<div class="row-fluid">
    
    <hr />
    
    {assign var=k value='email'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    {assign var=k value='password'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    {assign var=k value='password2'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    <hr />
    
    <div class="row-fluid">
        {assign var=k value='firstname'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}
        
        {assign var=k value='lastname'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}

    </div>
    
    <div class="row-fluid">&nbsp;</div>
    
    {assign var=k value='type'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    {assign var=k value='companyname'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span6">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    {assign var=k value='taxid'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span6">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
                <br />
                กรุณาระบุ เลขประจำตัวผู้เสียภาษี กรณีเป็นนิติบุคคล / เลขประจำตัวประชาชน กรณีเป็นบุคคลธรรมดา
            </div>
        </div>
    </div>
    {/if}
    
    {assign var=k value='departmentposition'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span6">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    <div class="row-fluid">&nbsp;</div>
    
    {assign var=k value='address1'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span6">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    {assign var=k value='address2'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span2">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span6">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    <div class="row-fluid">
        {assign var=k value='city'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}
        
        {assign var=k value='state'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}

    </div>
    
    <div class="row-fluid">
        {assign var=k value='country'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}
        
        {assign var=k value='postcode'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}

    </div>
    
    <div class="row-fluid">&nbsp;</div>
    
    <div class="row-fluid">
        {assign var=k value='phonenumber'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}
        
        {assign var=k value='fax'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}

    </div>
    
    <div class="row-fluid">
        {assign var=k value='mobile'} {assign var=field value=$fields[$k]}
        {if isset($fields[$k])}
        <div class="span6 {$field.type}">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
        {/if}

    </div>
    
    <hr />
    
    {assign var=k value='howdidyou'} {assign var=field value=$fields[$k]}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    
    {foreach from=$fields item=field name=floop key=k}
    {if in_array($k, array(
        'email', 'password', 'password2',
        'firstname', 'lastname',
        'type', 'companyname', 'taxid', 'departmentposition',
        'address1', 'address2', 'city', 'state', 'country', 'postcode',
        'phonenumber', 'fax', 'mobile',
        'howdidyou', 'googleauthenticator', 'googleauthenticatorcode'
        ))}
        {continue}
    {/if}
    {if isset($fields[$k])}
    <div class="row-fluid {$field.type}">
        <div class="span12">
            <div class="span4">
                {include file="`$template_path`ajax.signup_fieldlabel.tpl"}
            </div>
            <div class="span8">
                {include file="`$template_path`ajax.signup_fieldtype.tpl"}
            </div>
        </div>
    </div>
    {/if}
    {/foreach}
    
</div>


<script type="text/javascript" src="{$template_dir}js/chosen.min.js"></script>
{literal}
    <script>
        $(document).ready(function(){
            {/literal}{if $cmd=='cart' && $step!=2}{literal}$("#field_country, #state_input, #state_select").change(function(){var e=this;$.post("?cmd=cart&action=regionTax",{country:$("#field_country").val(),state:$("#state_select:visible").length>0?$("#state_select").val():$("#state_input").val()},function(t){if(t==1){$(e).parents("form").append('<input type="hidden" name="autosubmited" value="true" />').submit()}})}){/literal}{/if}{literal}
            $(".chzn-select").chosen();
            
            {/literal}{if $submit.type && $submit.type=='Private'}{literal}
                $('.Company').hide();
            {/literal}{else}{literal}
                $('.Private').hide();
            {/literal}{/if}{literal}
            
            $('#field_type').change( function () {
                if ($(this).val() == 'Company') {
                    $('.Private').hide();
                    $('.Company').show();
                } else {
                    $('.Company').hide();
                    $('.Private').show();
                }
            });
            
        });
        function singup_image_reload(){
            var d = new Date();    
            $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
            return false;
        }
    </script>
{/literal}