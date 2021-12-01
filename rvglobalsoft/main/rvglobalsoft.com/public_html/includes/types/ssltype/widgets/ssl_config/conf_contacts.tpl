<em>{$lang.field_marked_required}</em>
<div class="widget-container">
    {foreach from=$contacts item=group key=type}
        {if $group.type == 'group'}
            <div class="grid-6 contacts contacts-{$type}">
                <h3>
                    {if $group.name}{$group.name}
                    {elseif $lang[$group.lang]}{$lang[$group.lang]}
                    {else}{$type|capitalize}
                    {/if}
                </h3>
                <div class="strike-line"></div>
                {include file="../common/sslcerts/contactforms.tpl" forms=$group.forms}

            </div>
        {else}
            <div class="grid-12" id="biltech">
                <h3>{$lang.en_billtech}</h3>
                <div class="strike-line"></div>
                <input type="checkbox" value="1" checked="checked" name="useadmin" /> {$lang.en_copybill}
            </div>
        {/if}
    {/foreach}
</div>
