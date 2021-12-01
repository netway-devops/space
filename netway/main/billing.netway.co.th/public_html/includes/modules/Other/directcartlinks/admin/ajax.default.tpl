{if $action === 'carts'}
    {foreach from=$carts item=cart}
        <tr>
            <td>
                <input type="checkbox" class="check" name="selected[]" value="{$cart.id}">
            </td>
            <td>{$cart.id}</td>
            <td>
                {if $cart.admin_id}
                    <a href="?cmd=editadmins&action=administrator&id={$cart.admin_id}">#{$cart.admin_id} {$cart.admin.firstname} {$cart.admin.lastname}</a>
                {else}
                    <i>None</i>
                {/if}
            </td>
            <td>
                {if $cart.client_id}
                    {$cart->client|@profilelink}
                {else}
                    <i>None</i>
                {/if}
                <br> <i>({$cart.client_ip})</i>
            </td>
            {if $brands|@count > 1}
                <td>
                    {if $cart.host}
                        <a href="{$cart.host}">{$cart.host}</a>
                    {/if}
                </td>
            {/if}
            <td width="220">
                {if $cart.link}
                    <input type="text" readonly="readonly" value="{$cart.link}" style="width: 150px" title="{$cart.link}">
                    <a style="padding: 0 2px;" class="btn btn-sm copy-link" data-link="{$cart.link}" onclick="return false;" data-original-title="" title=""><i class="fa fa-files-o f-a" aria-hidden="true"></i></a>
                    <a style="padding: 0 2px;" class="btn btn-sm" href="{$cart.link}" target="_blank" title="{$cart.link}"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                {else}
                    <i>None</i>
                    <a style="margin-left: 5px;" href="?cmd=directcartlinks&action=carts&make=link&id={$cart.id}">Generate Link</a>
                {/if}
            </td>
            <td valign="top" style="color:#767679;font-size:11px">
                {if $cart.pname}
                    <i>Product/s:</i> <br>
                    <strong>{$cart.pname}</strong>
                {/if}

                {if $cart.dname}
                    <br> <i>Domain/s:</i> <br>
                    <strong>{$cart.dname}</strong><br />
                {/if}
            </td>
            <td><b>{$cart.total|price:$cart.currency_id}</b></td>
            <td>{$cart.date_created|dateformat:$date_format}</td>
            <td>{$cart.date_updated|dateformat:$date_format}</td>
            <td>
                <i>Email 1:</i> {if $cart.email_sent}<span style="color: green">{$cart.date_email|dateformat:$date_format}</span>{else} <span style="color:#888;">Not sent</span>{/if}<br>
                <i>Email 2:</i> {if $cart.email_sent2}<span style="color: green">{$cart.date_email2|dateformat:$date_format}</span>{else} <span style="color:#888;">Not sent</span>{/if}<br>
                <i>Email 3:</i> {if $cart.email_sent3}<span style="color: green">{$cart.date_email3|dateformat:$date_format}</span>{else} <span style="color:#888;">Not sent</span>{/if}<br>
            </td>
            <td align="right">
                {if $cart.client_id}
                    <button style="width: 110px;margin-bottom:4px;" href="#" onclick="if (confirm('Are you sure you want to send reminder E-mail{if $cart.email_sent} again{/if}? {if $cart.email_sent}The email has already been sent {$cart.date_email|dateformat:$date_format}{/if}'))return emailCarts({$cart.id});" class="btn btn-default btn-sm">Send Email</button>
                    <a style="width: 110px;margin-bottom:4px;" target="_blank" href="?cmd=directcartlinks&action=carts&make=order&id={$cart.id}" onclick="return confirm('Are you sure you want to create Draft Order from this cart?')" class="btn btn-default btn-sm">Create Draft order</a>
                    <br>
                {/if}
                <a style="width: 110px;margin-bottom:4px;" target="_blank" href="?cmd=directcartlinks&action=carts&make=coupon&id={$cart.id}" class="btn btn-default btn-sm">Generate Coupon</a>
                <a style="width: 110px;margin-bottom:4px;" href="?cmd=directcartlinks&action=carts&make=delete&selected[]={$cart.id}&security_token={$security_token}" class="btn btn-danger btn-sm" onclick="if (!confirm('Are you sure you want to delete?'))return false;">Delete</a>
            </td>
        </tr>
    {foreachelse}
        <tr>
            <td colspan="100%">Nothing to display</td>
        </tr>
    {/foreach}
{/if}