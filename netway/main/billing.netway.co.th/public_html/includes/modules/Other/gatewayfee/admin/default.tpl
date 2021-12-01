<link href="{$system_url}includes/modules/Other/gatewayfee/admin/default.css" rel="stylesheet" media="all">
<form action="" method="post">
    <div class="lighterblue" style="padding: 10px">
        <div style="display: none" class="howitworks">
            <strong>1. Percent</strong> is added to the invoice, based on the total amount of the invoice (without
            <strong>amount</strong> param below)<br/>
            <strong>2. Amount</strong> is added to the invoice<br/><br/>
            For ex. <br/>
            <em>Percent = 3%</em><br/>
            <em>Amount = $ 0.40 USD</em><br/>
            <em>Invoice total = $ 7.00 USD</em><br/><br/>
            <font style="text-decoration: underline">Final Invoice Total</font> = ( 7.00 * 3% ) + 0.40 = $
            <strong>7.61</strong> USD
        </div>
        <div style="padding: 10px">
            <a href="" class="btn btn-default" onclick="{literal}$(this).slideUp(500, function() {$('.howitworks').slideDown(1000);}); return false;{/literal}">
                How it works?
            </a>
            <input style="font-weight: bold;" class="btn btn-primary" type="submit" name="savecharges" value="Save Changes"/>
        </div>
    </div>
    <table cellspacing="0" cellpadding="3" border="0" class="glike hover" width="100%">
        <tbody>
            <tr>
                <th width="20"></th>
                <th width="100">Gateway ID</th>
                <th>Gateway</th>
                {foreach from=$curx item=ci}
                    <th width="90">Amount {$ci.code}</th>
                    <th width="90">Percent {$ci.code}</th>
                {/foreach}
                <th></th>
            </tr>
            {if !empty($gateways)}
                {foreach from=$gateways key=gid item=g}
                    <tr>
                        <td></td>
                        <td>#{$gid} <input type="hidden" value="{$g.modname|strip_tags:false}" name="gateways[{$gid}][gateway_name]"/>
                            <input type="hidden" value="{$g.filename}" name="gateways[{$gid}][gateway_filename]"/></td>
                        <td>
                            <strong>{$g.modname}</strong>
                        </td>
                        {foreach from=$curx item=ci}
                            <td>
                                <div class="currency" {if $ci.sign}data-sign="{$ci.sign}"{/if}>
                                    <input class="form-control text-right" type="text" {if $g.amount[$ci.id] != 0}style="background-color: #ffe7c7" {/if} value="{$g.amount[$ci.id]}" name="gateways[{$gid}][currencies][{$ci.id}]"/>
                                </div>
                            </td>
                            <td>
                                <div class="percent">
                                    <input class="form-control" type="text" {if $g.percent[$ci.id] != 0}style="background-color: #ffe7c7" {/if} value="{$g.percent[$ci.id]}" name="gateways[{$gid}][percent][{$ci.id}]"/>
                                </div>
                            </td>
                        {/foreach}
                        <td></td>
                    </tr>
                {/foreach}
            {else}
                <tr>
                    <td colspan="6" style="text-align: center; padding: 5px;"><strong>Nothing to display</strong></td>
                </tr>
            {/if}

        </tbody>
    </table>
    {if count($gateways)>20}
        <div class="lighterblue" style="padding: 10px">
            <div style="padding: 10px">
                <input style="font-weight: bold;" type="submit" class="btn btn-primary" name="savecharges" value="Save Changes"/>
            </div>
        </div>
    {/if}

    {securitytoken}
</form>