{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientarea/editdetails.tpl.php');
{/php}

{*

Edit main profile details

*}
<div class="text-block clear clearfix">
    <h5>{$lang.account}</h5>
   
    <div class="clear clearfix">
        <div class="account-box">
        
            {include file='clientarea/leftnavigation.tpl'}
            
            <div class="account-content">
                <h6 class="clear clearfix h-details">{$lang.details}</h6>
                <form action='' method='post' class="no-margin">
                <input type="hidden" name="make" value="details" />
                <table class="table table-striped tb-details">
                {foreach from=$fields item=field name=floop key=k}
                    {if $field.field_type=='Password'}{continue}{/if}
                    
                    
                     <tr  {if $field.type=='Company' && $fields.type}class="{if $smarty.foreach.floop.iteration%2==0}even{/if} iscomp" style="{if !$client.company || $client.type=='Private'}display:none{/if}"
						{elseif $field.type=='Private' && $fields.type}class="ispr {if $smarty.foreach.floop.iteration%2==0}even{/if} " style="{if $client.company=='1'}display:none{/if}"
                {elseif $smarty.foreach.floop.iteration%2==0}class="even" {/if}>
                        
                        {if $k=='newsletter'}
                        <td colspan="2">
                            {foreach from=$field.default_value item=fa}
                            <table class="table">
                            <tr class="hide"><td colspan="2"></td></tr>
                            <tr>
                                <td><input type="checkbox" name="{$k}[{$fa|escape}]" id="{$k}[{$fa|escape}]" value="1" {if in_array($fa,$client[$k])}checked="checked"{/if} /></td>
                                <td><label for="{$k}[{$fa|escape}]">{$field.name}</label></td>
                            </tr>
                            </table>
                            {/foreach}
                        </td>
                        {continue}
                        {/if}
                        
                        <td class="w25 grey-c">
                        {if $k=='type'}
                            {$lang.clacctype}
                        {elseif $field.options & 1}
                            {if $lang[$k]}
                                {$lang[$k]}
                            {else}
                                {$field.name}
                            {/if}
                        {else}
                            {$field.name}
                        {/if}
                        {if $field.options & 2}
                            *
                        {/if}
                        </td>
                        <td>
                        	
		                {if $k=='mailingaddress'}
		                    
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
		                     <div id="mAddrForm" class="form-horizontal" style="width:99%; display:block; background-color:#F9F9FB; padding:3px; border:1px solid #CCCCCC; {if !$isMailingAddress} display:none; {/if}">
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
		                     
		                    <textarea name="{$k}" id="field_{$k}" style="display:none;">{$client[$k]}</textarea>

                        {elseif $k=='type'}
                            <select  name="type" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                                <option value="Private" {if $client.company=='0'}selected="selected"{/if}>{$lang.Private}</option>
                                <option value="Company" {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                            </select>
                        {elseif $k=='country'}
                            {if !($field.options & 8)}
                                {foreach from=$countries key=k item=v} 
                                    {if $k==$client.country}
                                        {$v}
                                    {/if}
                                {/foreach}
                            {else}
                                <select name="country" class="chzn-select">
                                {foreach from=$countries key=k item=v}
                                <option value="{$k}" {if $k==$client.country  || (!$client.country && $k==$defaultCountry)} selected="selected"{/if}>{$v}</option>
                                {/foreach} 
                            {/if}
                        </select>
                    	{else}
                    		{if !($field.options & 8)}
                    			{if $field.field_type=='Password'}
                    			{elseif $field.field_type=='Check'}
                   					{foreach from=$field.default_value item=fa}
                    					{if in_array($fa,$client[$k])}
                                        	{$fa}<br/>
                                        {/if}
									{/foreach}

                    			{else}
                    				{$client[$k]} <input type="hidden" value="{$client[$k]}" name="{$k}"/>

                    			{/if}

                    	{else}
                    		{if $field.field_type=='Input'}
                            	<input type="text" value="{$client[$k]}" name="{$k}" class="styled"/>
                    		{elseif $field.field_type=='Password'}
                    			{elseif $field.field_type=='Select'}
                    				<select name="{$k}">
                        				{foreach from=$field.default_value item=fa}
                        					<option {if $client[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                        				{/foreach}
                    				</select>
                    			{elseif $field.field_type=='Check'}
                    				{foreach from=$field.default_value item=fa}
                    					<input type="checkbox" name="{$k}[{$fa|escape}]" value="1" {if in_array($fa,$client[$k])}checked="checked"{/if} />
                                        {$fa}<br />
                    				{/foreach}
                    			{/if}
                    		{/if}
                    	{/if}
                        </td>
                    </tr>
                    {/foreach}
                    <tr>
                        <td></td>
                        <td>
                        <button type="submit" class="green-custom-btn btn pull-right l-btn">{$lang.savechanges}</button>
                        </td>
                    </tr>
                    {securitytoken}
                </table>
                </form>                    
            </div>

        </div>
        
        
    </div>
 </div>
