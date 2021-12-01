<div id="newshelfnav" class="newhorizontalnav" style="margin-top: -32px; position: relative;">
    <div class="list-1">
        <ul>
            <li class="active last">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>Billing Alerts</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2">
        <div class="subm1" style="display: block; padding:10px;">
            Below you can configure if HostBill should issue invoice for Metered/Bandwidth billed services before regular renewal date,
            if total amount of upcoming invoice reaches certain threshold/amount.<br/>
            Additionally, under <a href="../?cmd=billingalerts" target="_blank">this url</a> this module allows customer to define  generic email alert in client portal if renewal invoice reach user-defined threshold.
        </div>
    </div>
</div>
{if $list}
    <div >
        <form id="suggestform" method="post" action="?cmd={$modulename}">
        <table class="whitetable" width="100%" cellspacing=0>
            <tr>
                <th style="width: 20px"></th>
                <th>Name</th>
                <th style="width: 77px; text-align: center">Enabled</th>
                <th style="width: 77px; text-align: center">Disabled</th>
                <th style="width: 77px; text-align: center">Amount</th>
                <th style="width: 20px;"></th>
            </tr>
            {foreach from=$list item=category}
                {if $category.ctype != 'domain'}
                    <tbody>
                        <tr><td></td></tr>
                        <tr class="havecontrols disabled">
                            <td colspan="2">
                                <a href="?cmd=services&action=category&id={$category.id}" >{$category.name}</a>
                            </td>
                            <td align="center"></td>
                            <td align="center"></td>
                            <td align="center"></td>
                            <td><img style="display: none; position: absolute; background: white; border: 1px solid white;" src="{$template_dir}img/ajax-loader3.gif" /></td>
                        </tr>
                        {foreach from=$category.products item=product name=list}
                            <tr class="havecontrols ">
                                <td>{if $smarty.foreach.list.last}&boxur;{else}&boxvr;{/if}</td>
                                <td>
                                    <a href="?cmd=services&action=product&id={$product.id}" >{$product.name}</a>
                                </td>
                                <td align="center"><input type="radio" name="product[{$product.id}][enable]" {if $product.alerts.enable == '1'}checked="checked"{/if} value="1"/></td>
                                <td align="center"><input type="radio" name="product[{$product.id}][enable]" {if !$product.alerts || $product.alerts.enable == '0'}checked="checked"{/if} value="0"/></td>
                                <td align="center"><input type="text" size="6" name="product[{$product.id}][amount]" value="{$product.alerts.amount}" /></td>
                                <td><img style="display: none; position: absolute; background: white; border: 1px solid white;" src="{$template_dir}img/ajax-loader3.gif" /></td>
                            </tr>
                        {/foreach}
                    </tbody>
                {/if}
            {/foreach}
        </table>
        </form>
    </div>
    {literal}
    <script type="text/javascript">
        $('.havecontrols input').change(function(){
            var that = $(this),
                tr = that.parents('tr').eq(0),
                data = that.serializeObject();
            data.action = 'change';
            var img = tr.find('img').show().offset(that.offset());
            $.post($('#suggestform').prop('action'), data, function(){
                img.hide();
                var newclass = that.val() == '1' ? 'havecontrols disabled' : (that.val() == '2' ? 'havecontrols forced' : 'havecontrols');
                tr.attr('class', newclass);
                if(tr.is(':nth-child(2)')){
                    tr.nextAll().attr('class', newclass).find('input[value='+that.val()+']').prop('checked', true);                    
                }
            });
        });
    </script>
    <style>
        .havecontrols.disabled td{
            background: #f5f5f5;
            font-style: italic;
        }
        .havecontrols.forced td{
            background: #FFFED1;
        }
        .havecontrols.forced:hover td{
            background: #FFF9B8  !important;
        }
    </style>
    {/literal}
{else}
    <div class="blank_state blank_kb">
        <div class="blank_info">
            <h1>Billing Alerts</h1>
            You will need to add few products first.
            <div class="clear"></div>
            <a style="margin-top:10px" href="?cmd=services" class="new_add new_menu">
                <span>Add new Product</span></a>
            <div class="clear"></div>
        </div>
    </div>
{/if}