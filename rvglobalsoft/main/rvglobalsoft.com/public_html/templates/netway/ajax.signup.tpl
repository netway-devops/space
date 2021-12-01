{php}

$aSubmit            = $this->get_template_vars('submit');
$address            = isset($aSubmit['mailingaddress']) ?  $aSubmit['mailingaddress'] : '';
$mailingAddress     = preg_match('/ชื่อผู้รับ\:(.*)ที่อยู่\:(.*)จังหวัด\:(.*)รหัสไปรษณีย์\:(.*)/ism', $address, $matches);

$this->assign('isMailingAddress',  (isset($matches[0]) && trim($matches[0])) ? true : false);
$this->assign('mAddrPerson',       isset($matches[1]) ? trim($matches[1]) : '');
$this->assign('mAddrAddress',      isset($matches[2]) ? trim($matches[2]) : '');
$this->assign('mAddrProvince',     isset($matches[3]) ? trim($matches[3]) : '');
$this->assign('mAddrZipcode',      isset($matches[4]) ? trim($matches[4]) : '');

{/php}

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin:15px 0px">
    <tr>
        <td valign="top" width="50%">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
                    {foreach from=$fields item=field name=floop key=k}
                        {if $smarty.foreach.floop.iteration > ($smarty.foreach.floop.total/2)}{break}{/if}
                        {if $k=='captcha' || $k=='mailingaddress'}{continue}{/if}
                        <tr height="46"  {if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
                            {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
                            <td class="{if $smarty.foreach.floop.iteration>0}bord{/if}"> <label for="field_{$k}" >
                                    {if $k=='type'}
                                        {$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                    {else}
                                        {$field.name}
                                    {/if}
                                    {if $field.options & 2}*{/if}
                                    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                                </label>
                                {if $k=='type'}
                                    <select  id="field_{$k}" name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                                        <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                                        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                                    </select>
                                {elseif $k=='country'}
                                    <select name="country" style="width: 90%;" id="field_{$k}" class="chzn-select">
                                        {foreach from=$countries key=k item=v}
                                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>
                                        {/foreach}
                                    </select>
                                {else}
                                    {if $field.field_type=='Input'}
                                        {if  $k=='captcha'}
                                            <div style="white-space: nowrap;">
                                                <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                                                <span style="display: inline-block; width: 65%; white-space: normal;">
                                                    {$lang.typethecharacters}<br />
                                                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                                </span>
                                            </div>
                                        {/if}
                                        <input type="text" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Password'}
                                        <input type="password" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Select'}
                                        <select name="{$k}" style="width: 90%;" id="field_{$k}" >
                                            {foreach from=$field.default_value item=fa}
                                                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $field.field_type=='Check'}
                                        {foreach from=$field.default_value item=fa}
                                            <input type="checkbox" name="{$k}[{$fa}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
                                        {/foreach}
                                    {/if}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="50%">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
                    {foreach from=$fields item=field name=floop key=k}
                        {if $smarty.foreach.floop.iteration <= ($smarty.foreach.floop.total/2)}{continue}{/if}
                        {if $k=='captcha' || $k=='mailingaddress'}{continue}{/if}
                        <tr height="46" {if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
                            {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
                            <td class=""> 
                                <label for="field_{$k}" >
                                    {if $k=='type'}
                                        {$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                    {else}
                                        {$field.name}
                                    {/if}
                                    {if $field.options & 2}*{/if}
                                    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                                </label>
                                {if $k=='type'}
                                    <select  id="field_{$k}"  name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                                        <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                                        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                                    </select>
                                {elseif $k=='country'}
                                    <select name="country" style="width: 90%;" id="field_{$k}"  class="chzn-select">
                                        {foreach from=$countries key=k item=v}
                                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

                                        {/foreach}
                                    </select>
                                {else}
                                    {if $field.field_type=='Input'}
                                        {if  $k=='captcha'}
                                            <div style="white-space: nowrap;">
                                                <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                                                <span style="display: inline-block; width: 65%; white-space: normal;">
                                                    {$lang.typethecharacters}<br />
                                                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                                </span>
                                            </div>
                                        {/if}
                                        <input type="text" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Password'}
                                        <input type="password" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Select'}
                                        <select name="{$k}" style="width: 90%;" id="field_{$k}" >
                                            {foreach from=$field.default_value item=fa}
                                                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $field.field_type=='Check'}
                                        {foreach from=$field.default_value item=fa}
                                            <input type="checkbox" name="{$k}[{$fa}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
                                        {/foreach}
                                    {/if}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
    </tr>

    <tr>
        <td valign="top" colspan="2">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
			    {foreach from=$fields item=field name=floop key=k}
				{if $k=='mailingaddress'}
				<tr height="46" class="ispr">
					<td class="bord">
                    <label for="field_{$k}" >
                        {if $k=='type'}
                            {$lang.clacctype}
                        {elseif $field.options & 1}
                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                        {else}
                            {$field.name}
                        {/if}
                        {if $field.options & 2}*{/if}
                        {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                    </label>
					
                    {literal}
                    <script language="JavaScript">
                    function nwUpdateMailingAddress () {
                        var mAddress       = '';
                        var isDifference   = $('input:radio[name=isMailingAddress]:checked').val();
                        if (isDifference == '0') {
                            $('#field_mailingaddress').text(mAddress);
                            return false;
                        }
                        mAddress       += 'ชื่อผู้รับ:' + $('#mAddrPerson').val() + "\n"
                                   + 'ที่อยู่:' + $('#mAddrAddress').val() + "\n"
                                   + 'จังหวัด:' + $('#mAddrProvince').val() + "\n"
                                   + 'รหัสไปรษณีย์:' + $('#mAddrZipcode').val();
                        $('#field_mailingaddress').text(mAddress);
                        return false;
                    }
                    </script>
                    {/literal}
					
                     <div>
                     <label><input type="radio" name="isMailingAddress" value="0" {if $isMailingAddress == false} checked="checked" {/if} onclick="$('#mAddrForm').hide();nwUpdateMailingAddress();" class="pull-left" /> &nbsp; {$lang.mailingAsClientAddress}</label>
                     <label><input type="radio" name="isMailingAddress" value="1" {if $isMailingAddress == true} checked="checked" {/if} onclick="$('#mAddrForm').show();nwUpdateMailingAddress();" class="pull-left" /> &nbsp; {$lang.mailingAsDefine}</label>
                     </div>
                     <div id="mAddrForm" class="form-horizontal" style="width:80%; display:block; background-color:#F9F9FB; padding:3px; border:1px solid #CCCCCC; {if !$isMailingAddress} display:none; {/if}">
                        <div class="muted">{$lang.mailingRequireField}</div>
						<div class="control-group">
                        	<label class="control-label" for="mAddrPerson">{$lang.mailingRecipient}:</label>
							<div class="controls">
								<input type="text" id="mAddrPerson" value="{$mAddrPerson}" size="30" class="input-xlarge" onchange="nwUpdateMailingAddress();" />
							</div>
						</div>
                        <div class="control-group">
                            <label class="control-label" for="mAddrAddress">{$lang.mailingAddress}:</label>
                            <div class="controls">
                                <textarea id="mAddrAddress" cols="50" rows="3" class="input-xlarge" onchange="nwUpdateMailingAddress();">{$mAddrAddress}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="mAddrProvince">{$lang.mailingProvince}:</label>
                            <div class="controls form-inline">
                                <input type="text" id="mAddrProvince" value="{$mAddrProvince}" size="30" class="input-medium" onchange="nwUpdateMailingAddress();" />
								<label for="mAddrZipcode">{$lang.mailingPostcode}:</label>
								<input type="text" id="mAddrZipcode" value="{$mAddrZipcode}" size="10" class="input-mini" onchange="nwUpdateMailingAddress();" />
                            </div>
                        </div>
                     </div>
					 
					<textarea name="{$k}" id="field_{$k}" style="display:none;">{$submit[$k]}</textarea>
					</td>
				</tr>
				{/if}
			    {if $k=='captcha'}
				<tr height="46" class="ispr">
					<td class="bord">
		        	<label for="field_{$k}" >
		                {if $k=='type'}
		                    {$lang.clacctype}
		                {elseif $field.options & 1}
		                    {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
		                {else}
		                    {$field.name}
		                {/if}
		                {if $field.options & 2}*{/if}
		                {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
		            </label>
					
                    <div style="white-space: nowrap;">
                        <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                        <span style="display: inline-block; width: 65%; white-space: normal;">
                            {$lang.typethecharacters}<br />
                            <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                        </span>
                    </div>

                    <input type="text" value="{$submit[$k]}" name="{$k}" class="input-small" id="field_{$k}" />

				    </td>
				</tr>
			    {/if}
			    {/foreach}
                </tbody>
            </table>
        </td>
	</tr>

</table>
<script type="text/javascript" src="{$template_dir}js/chosen.min.js"></script>
{literal}
    <script>
        $(document).ready(function(){
            {/literal}{if $cmd=='cart' && $step!=2}{literal}$("#field_country, #state_input, #state_select").change(function(){var e=this;$.post("?cmd=cart&action=regionTax",{country:$("#field_country").val(),state:$("#state_select:visible").length>0?$("#state_select").val():$("#state_input").val()},function(t){if(t==1){$(e).parents("form").append('<input type="hidden" name="autosubmited" value="true" />').submit()}})}){/literal}{/if}{literal}
            $(".chzn-select").chosen();
        });
        function singup_image_reload(){
            var d = new Date();    
            $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
            return false;
        }
    </script>

{/literal}



