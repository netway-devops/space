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
        <tr class="{if $smarty.foreach.ff.index%2==0}even{/if}">
            <td><a href="{$ca_url}profiles/edit/{$p.id}/">{$p.firstname}</a></td>
            <td align="center"><a href="{$ca_url}profiles/edit/{$p.id}/">{$p.lastname}</a></td>
            <td align="center"><a href="{$ca_url}profiles/edit/{$p.id}/">{$p.email}</a></td>
            <td align="center">{if !$p.lastlogin|dateformat:$date_format}-{else}{$p.lastlogin|dateformat:$date_format}{/if}</td>
            <td>
                <div class="btn-group">
                    <a href="{$ca_url}profiles/edit/{$p.id}/" class="btn dropdown-toggle" data-toggle="dropdown"><i class="icon-cog"></i> <span class="caret"></span></a>
                    <ul class="dropdown-menu">

                        <li><a href="{$ca_url}profiles/edit/{$p.id}/">{$lang.editcontact}</a></li>
                        <li><a href="{$ca_url}profiles/loginascontact/{$p.id}/">{$lang.loginascontact}</a></li>
                        <li><a href="{$ca_url}profiles/&do=delete&id={$p.id}&security_token={$security_token}" onclick="return confirm('{$lang.areyousuredelete}');" style="color:red">{$lang.delete}</a></li>

                    </ul>
                </div>

            </td>
        </tr>
    {/foreach}
{/if}