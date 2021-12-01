{foreach from=$cst.items item=cit}
    {if $cit.name}{$cit.name}{/if}
    {if $cst.data[$cit.id]}
        <span id="field-{$cst.id}-pwd" style="display: none; font-family: monospace">
            {$cst.data[$cit.id]}
        </span>
        <span id="field-{$cst.id}-pwd" style="font-family: monospace">
            {if strlen($cst.data[$cit.id]) > 6}
                {$cst.data[$cit.id]|regex_replace:'/./':'*'}
            {else}******{/if}
        </span>
        <a href="#" class="editbtn" onclick="$(this).prev().toggle().prev().toggle(); return false">{$lang.show}</a>
    {/if}
    <br/>
{/foreach}