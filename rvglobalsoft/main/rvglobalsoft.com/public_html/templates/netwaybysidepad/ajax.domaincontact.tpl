{* copy code from ajax.signup.tpl *}


<div class="row-fluid">
	<div class="span12 pull-right"><span class="label label-info">Info</span> ข้อมูลจะต้องเป็นภาษาอังกฤษเท่านั้น</div>
	<hr />
	<div class="span12 form-horizontal">
		
		{foreach from=$aDomainFields item=field name=floop key=k}
		
		<div class="control-group">
            <label class="control-label" for="field_{$k}">
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
			<div class="controls">


                {if $k=='type'}
                    <select  id="field_{$k}" name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$(this).parent().parent().next().hide();}else{$(this).parent().parent().next().show();}{/literal}">
                        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
						<option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                    </select>
                {elseif $k=='country'}
                    <select name="country" style="width: 90%;" id="field_{$k}" class="chzn-select">
                        {foreach from=$countries key=k item=v}
                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>
                        {/foreach}
                    </select>
                {else}
                    <input type="text" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                {/if}
				
				
			</div>
		</div>
		
		{/foreach}
		
		<hr />
	</div>
</div>

