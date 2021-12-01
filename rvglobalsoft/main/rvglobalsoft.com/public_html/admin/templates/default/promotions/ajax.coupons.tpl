{if $coupons}
    {foreach from=$coupons item=coupon}
        <tr>
            <td>
                <a href="?cmd=coupons&action=edit&id={$coupon.id}" >{$coupon.id}</a>
            </td>
            <td>
                <a href="?cmd=coupons&action=edit&id={$coupon.id}" >{$coupon.code}</a>
            </td>
            <td>
                {if $coupon.status == 'Active'}
                    <span style="color: #00CE3C"><b>{$coupon.status}</b></span>
                {else}
                    <span style="color: #6f828b"><b>{$coupon.status}</b></span>
                {/if}
            </td>
            <td>{$coupon.coupon_type|ucfirst}</td>
            <td>
                {if $coupon.type=='percent'}{$coupon.value}%{else}{$coupon.value|price:$currency}{/if}
            </td>
            <td>
                <a href="?cmd=logs&action=coupons&filter[coupon]={$coupon.code}">{$coupon.num_usage}</a>
            </td>
            <td>{$coupon.notes}</td>
            <td>
                <a href="?cmd=coupons&make=delete&id={$coupon.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.confirmdel}')">{$lang.Delete}</a>
            </td>
        </tr>
    {/foreach}
{elseif $action=='getclients'}
    <select name="client_id" class="inp" load="clients" default="{$draft.client_id}" style="width: 180px">
        <option value="0">{$lang.All}</option>
        {*foreach from=$clients item=cl}
        <option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
        {/foreach*}
    </select>
    <script type="text/javascript">Chosen.find();</script>
{else}
    <tr>
        <td colspan="8">
            <p align="center">{$lang.Click} <a
                        href="?cmd=coupons&action=new">{$lang.here}</a> {$lang.tocreatecoupon}</p>
        </td>
    </tr>
{/if}
