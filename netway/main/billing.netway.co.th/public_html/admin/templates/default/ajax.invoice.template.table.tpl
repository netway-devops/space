<table class="table table-striped" cellspacing="0" cellpadding="3">
    {foreach from=$items item=tpl}

    <tr>
        <td width="10">
            {if $config}
            <input class="left" type="radio" name="{$config}" value="{$tpl.id}"
                   {if $configuration[$config]==$tpl.id}checked="checked"{/if}
                   id="seo_{$tpl.id}"/>
            {/if}
        </td>
        <td>
            {if $configuration[$config]==$tpl.id}<strong>{/if}
                {$tpl.name}
                {if $configuration[$config]==$tpl.id}</strong>{/if}
        </td>
        <td style="width: 50px;">
            <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}"
               class="menuitm menu-auto ">Preview</a>
        </td>
        <td style="width: 88px; text-align: right">

            {if $tpl.parent_id=='0'}
                <a href="?cmd=configuration&action=invoicetemplates&make=customize&id={$tpl.id}&security_token={$security_token}"
                   class="menuitm menu-auto ">Customize</a>
            {else}
                <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}"
                   class="menuitm menu-auto "><span style="color: red">Edit</span></a>
                <a href="?cmd=configuration&action=invoicetemplates&make=delete&id={$tpl.id}&security_token={$security_token}"
                   class="menuitm menu-auto "
                   onclick="return confirm('Are you sure you wish to remove this template?')"  alt="Delete"><span class="delsth"></span></a>
            {/if}
        </td>
    </tr>
    {/foreach}
</table>
