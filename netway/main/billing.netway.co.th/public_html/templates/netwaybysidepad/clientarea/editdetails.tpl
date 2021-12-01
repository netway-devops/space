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
                    {if $k == 'addresstype'}{continue}{/if}
                    {if $k == 'googleauthenticator'}{continue}{/if}
                    {if $k == 'googleauthenticatorcode'}{continue}{/if}
                    
                     <tr  {if $field.type=='Company' && $fields.type}class="{if $smarty.foreach.floop.iteration%2==0}even{/if} iscomp" style="{if !$client.company || $client.type=='Private'}display:none{/if}"
						{elseif $field.type=='Private' && $fields.type}class="ispr {if $smarty.foreach.floop.iteration%2==0}even{/if} " style="{if $client.company=='1'}display:none{/if}"
                {elseif $smarty.foreach.floop.iteration%2==0}class="even" {/if}>
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
