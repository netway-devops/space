{if $action=='preview' && $profile}
    {$profile.firstname} {$profile.lastname}<br />
    {if $profile.companyname!=''}{$profile.companyname}<br />{/if}
    {if $profile.address1!=''}{$profile.address1}<br />{/if}
    {if $profile.address2!=''}{$profile.address2}<br />{/if}
    {if $profile.city!=''}{$profile.city}, {/if}
    {if $profile.state!=''}{$profile.state}, {/if}
    {if $profile.postcode!=''}{$profile.postcode}<br />{/if}
    {if $profile.country2!=''}{$profile.country2}<br />{/if}
    {$profile.email}<br />
{else}
    {foreach from=$profiles item=p name=ff}
        <tr>
            <td data-label="{$lang.firstname}"><b>{$p.firstname}</b></td>
            <td data-label="{$lang.lastname}"><b>{$p.lastname}</b></td>
            <td data-label="{$lang.email}">{$p.email}</td>
            <td data-label="{$lang.lastlogin}">
                {if !$p.lastlogin|dateformat:$date_format} -
                {else}{$p.lastlogin|dateformat:$date_format}
                {/if}
            </td>
            <td class="text-md-right text-left">
                <div class="dropdown">
                    <a class="cursor-pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="material-icons icon-info-color">settings</i></a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="{$ca_url}profiles/edit/{$p.id}/">{$lang.editcontact}</a>
                        <a class="dropdown-item" href="{$ca_url}profiles/loginascontact/{$p.id}/">{$lang.loginascontact}</a>
                        <a class="dropdown-item confirm_js" href="{$ca_url}profiles/&do=delete&id={$p.id}&security_token={$security_token}" data-confirm="{$lang.areyousuredelete}">{$lang.delete}</a>
                    </div>
                </div>
            </td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="20">
                {$lang.nothing}
            </td>
        </tr>
    {/foreach}
{/if}