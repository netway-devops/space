{*

Edit main profile details

*}
<article>
    <h2><i class="icon-acc"></i> {$lang.account}</h2>
    <p>{$lang.account_descr}</p>
    <div class="account-info-box">
        {include file='clientarea/leftnavigation.tpl'}

        <div class="account-info-container">
            <div class="padding">
                <h2>{$lang.details}</h2>
                <form class="m20" action='' method='post'>
                    <input type="hidden" name="make" value="details" />
                    {counter name=colummnpad print=false start=0 assign=colummnpad}
                    <fieldset>
                        {foreach from=$fields item=field name=floop key=k}
                            {if $field.field_type=='Password'}{continue}
                            {/if}
                            <div class="client-column {if $colummnpad % 2 != 0 }column-m{/if}
                                 {if $field.type=='Company' && $fields.type} iscomp
                                 {elseif $field.type=='Private' && $fields.type} ispr
                                 {/if}"
                                 {if $fields.type && (($field.type=='Company' && !$client.company) || ($field.type=='Private' && $client.company=='1') || ($client.type!=$field.type && $field.type!='All'))}style="display:none"
                                 {else}{counter name=colummnpad}
                                 {/if}
                                 >
                                <label>
                                    {if $k=='type'}{$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $lang[$k]}{$lang[$k]}
                                        {else}{$field.name}
                                        {/if}
                                    {else}{$field.name}
                                    {/if}
                                    {if $field.options & 2}*
                                    {/if}
                                </label>
                                {if $k=='type'}
                                    <select  name="type" onchange="account_type_change(this);">
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
                            </div>
                        {/foreach}              
                    </fieldset>
                    <div class="pull-right m15">
                        <button type="submit" class="btn c-green-btn"> {$lang.savechanges}</button>
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
    </div>     
</article>
