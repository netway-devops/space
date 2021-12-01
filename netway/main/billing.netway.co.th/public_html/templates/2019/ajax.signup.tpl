{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.signup.tpl.php');
{/php}

<div class="row">
    <div class="col-12 col-md-6">
        {foreach from=$fields item=field name=floop key=k}
            {if $smarty.foreach.floop.iteration == ($smarty.foreach.floop.total/2|@round)}
                {*divide form to 2 columns*}
                </div>
                <div class="col-12 col-md-6">
            {/if}
            <div class="form-group_{$k} {if ($field.field_type == 'Input' && $k != 'captcha' && $k != 'phonenumber') || $field.field_type == 'Password' || $field.field_type == 'Select'} form-label-group {elseif $field.field_type == 'File'} {else} form-group {/if}
                    {if $field.type=='Company' && $fields.type} iscomp  {if !$submit.type || $submit.type=='Private'} d-none {/if}
                    {elseif $field.type=='Private' && $fields.type} ispr {if $submit.type=='Company'} d-none {/if}
                    {/if}">
                {if ($field.field_type != 'Input' || $k === 'phonenumber') && $field.field_type != 'Select' && $field.field_type != 'Password'}
                    <label for="field_{$k}">
                        {if $k=='type'}
                            {$lang.clacctype}
                        {elseif $field.options & 1}
                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                        {else}
                            {$field.name}
                        {/if}
                        {if $field.options & 2}*{/if}
                        {if $field.description}
                            <span class="vtip_description vtip_description_signup_form_label" title="{$field.description|htmlspecialchars}" {if $field.field_type=='Check'}style="position: relative; right: 0;" {/if}></span>
                        {/if}
                    </label>
                {/if}

                {if $k=='type'}
                    <select required name="type" id="field_{$k}" class="form-control" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').addClass('d-none').hide();$('.ispr').removeClass('d-none').show();}else {$('.ispr').addClass('d-none').hide();$('.iscomp').removeClass('d-none').show();}{/literal}" {parsley data=$field value=$submit[$k]} >
                        <option value="" hidden selected disabled>{$lang.clacctype}</option>
                        <option value="Private" {if $submit.type=='Private' || (!$submit.type && in_array('Private', $field.default_value)) || (!$submit.type && !$field.default_value)}selected="selected"{/if}>{$lang.Private}</option>
                        <option value="Company" {if $submit.type=='Company' || (!$submit.type && in_array('Company', $field.default_value))}selected="selected"{/if}>{$lang.Company}</option>
                    </select>
                {elseif $k=='country'}
                    <select required name="country" id="field_{$k}" class="form-control" {parsley data=$field value=$submit[$k]}>
                        <option value="" hidden selected disabled>{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}</option>
                        {foreach from=$countries key=cc item=v}
                            <option value="{$cc}" {if $cc == $submit.country || (!$submit.country && $cc==$defaultCountry)} selected="Selected"{/if}>{$v}</option>
                        {/foreach}
                    </select>
                {else}
                    {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}
                        {if $k=='captcha'}
                            <hr>
                            <div>
                                <img class="capcha" src="?cmd=root&action=captcha#{$stamp}" />
                                <span>
                                    {$lang.typethecharacters}<br />
                                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                </span>
                            </div>
                            <input type="text" placeholder="{$lang.captcha}" value="" name="{$k}" class="form-control"  id="field_{$k}" {parsley data=$field value=$submit[$k]} autocomplete="off"/>
                        {else}
                            {if $k=='phonenumber' || $field.field_type=='Phonenumber'}
                                {assign var=unique_id value=10|mt_rand:999}
                                <input type="text" placeholder="{$field.placeholder}" value="{$submit[$k]}" name="{$k}" class="form-control"  id="field_{$k}_{$unique_id}" data-parsley-errors-container=".form-group_{$k}" {parsley data=$field value=$submit[$k]} data-initial-country="{$submit.country|default:$default_country}"/>
                                <script>initPhoneNumberField($('#field_{$k}_{$unique_id}'));</script>
                            {else}
                                <input type="text" placeholder="{$field.placeholder}" value="{$submit[$k]}" name="{$k}" class="form-control"  id="field_{$k}" {parsley data=$field value=$submit[$k]} />
                            {/if}
                        {/if}
                    {elseif $field.field_type=='Password'}
                        <input type="password" placeholder="{$field.placeholder}" autocomplete="new-password" name="{$k}" class="form-control" id="field_{$k}" {parsley data=$field value=$submit[$k]}/>
                    {elseif $field.field_type=='Select'}
                        <select name="{$k}" id="field_{$k}" class="form-control" {parsley data=$field value=$submit[$k]} >
                            <option value="" selected disabled>{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}</option>
                            {foreach from=$field.default_value item=fa}
                                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                            {/foreach}
                        </select>
                    {elseif $field.field_type=='Check'}
                        {foreach from=$field.default_value item=fa}
                            <input type="checkbox"  name="{$k}[{$fa|escape}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" {parsley data=$field value=$submit[$k]} />{$fa}<br />
                        {/foreach}
                    {elseif $field.field_type=='File'}
                        <div>
                            <div class="d-flex flex-row align-items-center">
                                <input type="file" name="{$k}" />
                                <small class="form-text text-muted">{$field.expression|string_format:$lang.allowedext}</small>
                            </div>
                        </div>
                    {/if}
                {/if}
                    {if ($field.field_type == 'Input' && $k != 'captcha' && $k != 'phonenumber') || $field.field_type == 'Password' || $field.field_type == 'Select'}
                        <label class="form-label-placeholder" for="field_{$k}">
                            {if $k=='type'}
                                {$lang.clacctype}
                            {elseif $field.options & 1}
                                {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                            {else}
                                {$field.name}
                            {/if}
                            {if $field.options & 2}*{/if}
                        </label>
                    {/if}
                {if $field.description && $field.field_type!='Check'}
                    <span class="vtip_description vtip_description_signup_form_label" title="{$field.description|htmlspecialchars}"></span>
                {/if}
            </div>
        {/foreach}
    </div>
</div>
<script type="text/javascript" src="{$template_dir}../common/js/singup.js"></script>
{literal}
    <script>
        // ParsleyConfig definition if not already set
        window.ParsleyConfig = window.ParsleyConfig || {};
        window.ParsleyConfig.i18n = window.ParsleyConfig.i18n || {};
        // Define then the messages
        window.ParsleyConfig.i18n.en = $.extend(window.ParsleyConfig.i18n.en || {}, {
            defaultMessage: "{/literal}{$lang.thisvalueseemsbeinvalid}{literal}",
            type: { {/literal}
                email: "{$lang.thisvalueshouldavalidemail}",
                url: "{$lang.thisvalueshouldavalidurl}",
                number: "{$lang.thisvalueshouldavalidnumber}",
                integer: "{$lang.thisvalueshouldavalidinteger}",
                digits: "{$lang.thisvalueshoulddigits}",
                alphanum: "{$lang.thisvalueshouldalphanumeric}"
                {literal} }, {/literal}
            notblank: "{$lang.thisvalueshouldnotblank}",
            required: "{$lang.thisvaluerequired}",
            pattern: "{$lang.thisvalueseemsbeinvalid}",
            min: "{$lang.thisvalueshouldgreaterthanequals}",
            max: "{$lang.thisvalueshouldlowerthanequals}",
            range: "{$lang.thisvalueshouldbetweenss}",
            minlength: "{$lang.thisvaluetooshortshouldhavescharact}",
            maxlength: "{$lang.thisvaluetoolongshouldhavescharacte}",
            length: "{$lang.thisvaluelengthinvalidshouldbetween}",
            mincheck: "{$lang.youmustselectleastschoices}",
            maxcheck: "{$lang.youmustselectschoicesfewer}",
            check: "{$lang.youmustselectbetweensschoices}",
            equalto: "{$lang.thisvalueshouldthesame}" {literal}
        });
        // If file is loaded after Parsley main file, auto-load locale
        if ('undefined' !== typeof window.ParsleyValidator)
            window.ParsleyValidator.addCatalog('en', window.ParsleyConfig.i18n.en, true);
        $(function () {$('select[name="type"]').trigger('change');})
    </script>
{/literal}
