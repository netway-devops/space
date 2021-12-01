{foreach from=$groups item=i name=cat}
    <tr class="havecontrols">
        <td class="name">
            <a href="?cmd=formgroups&action=form_group&id={$i.id}" class="direct">{$i.name}</a>
        </td>
        <td>{$i.count_forms}</td>
        <td>{$i.description}</td>
        <td><i>{", "|implode:$i.flags_enabled}</i></td>
        <td>
            {if $lang[$i.type]}{$lang[$i.type]}
            {else}{$i.type}
            {/if}
        </td>
        <td style="width: 160px; text-align: right;">
            <a href="?cmd=formgroups&action=form_group&id={$i.id}" class="menuitm menu-auto">
                <span style="color: red">{$lang.Edit}</span>
            </a>
            <a href="?cmd=formgroups&action=delete_form_group&id={$i.id}&security_token={$security_token}"
               onclick="return confirm('Do you really want to remove this group?');" class="menuitm menu-auto ajax">
                <span class="delsth"></span>
            </a>
        </td>
    </tr>
{/foreach}