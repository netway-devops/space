    <table cellpadding="0" cellspacing="0" class="ttable" width="100%" style="margin-top:0px">
      
        {if $service.showbilling &&  $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.metered_type!='PrePay'}

        <tr>
            <td class="title" align="right"><b>{if $service.billingcycle=='Hourly' || $service.metered}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</b></td>
            <td> 
                {if $service.metered_total}   
                    {$service.metered_total|price:$currency}
                 {else}
                    {$service.total|price:$currency}{/if}
                <span class="fs11">{if $service.billingcycle=='Hourly'}({$lang.updatedhourly}){elseif $service.metered}({$lang.Metered}){else}({$lang[$service.billingcycle]}){/if}</span>
              </td>
            {if $service.billingcycle!='Free' && $service.billingcycle!='Once'}
            <td class="title" align="right"><b>{$lang.nextinvoice}:</b></td>
            <td>{$service.next_invoice|dateformat:$date_format}</td>
            {else}
            <td colspan="2"></td>
            {/if}
        </tr>
        {/if}
            </table>
    <div class="mseparator"></div>
            {if $service.metered && $service.showbilling}
                
            {if $service.metered_type!='PrePay'}<h3 class="summarize">{$lang.nextinvoicedetails}</h3>{/if}

          {if $metered_summary}
          <div class="report">
              {if $service.metered_type!='PrePay'}
               <div class="button green">
                    <span class="value">{$service.metered_total|price:$currency}</span>
                    <span class="attr">{$lang.Totaldue}</span>
                </div>
              {if $service.total}
               <div class="button">
                    <span class="value">{$service.total|price:$currency}</span>
                    <span class="attr">{$lang[$service.billingcycle]}</span>
                </div>
              {/if}

              {foreach from=$metered_summary item=vr}{if $vr.options & 4}{continue}{/if}
                <div class="button">
                    <span class="value">{$vr.charge|price:$currency:true:false:true:4}</span>
                    <span class="attr">{$vr.name}</span>
                </div>
             {/foreach}
             {else}
                <div class="button green">
                    <span class="value">{$service.metered_credit|price:$currency}</span>
                    <span class="attr">Credit left</span>
                </div>
              {/if}

            </div>
          {/if}

            <link rel="stylesheet" href="includes/types/widgets/meteredwidget/demo_table.css" type="text/css" />
            <script type="text/javascript" src="includes/types/widgets/meteredwidget/jquery.dataTables.min.js"></script>
        {literal}    <script type="text/javascript">
                var bPaginate={
                    "bFilter": false,
                    "sPaginationType": "full_numbers",
                    "bLengthChange":false,
                    "iDisplayLength": 24,
                    "aaSorting": []
                };
                function metteredBillinghistory() {
                            $('#pricingtable').addLoader();
                            var url={/literal}'?cmd=clientarea&action=services&service={$service.id}&do=metered_history&widget=meteredwidget';{literal};
                            $.post(url,{metered_period:$('#metered_period').val(),metered_interval:$('#metered_interval').val()},function(data){
                                var r = parse_response(data);
                                if(r) {
                                   var c=$('#pricingtable').empty().html(r).find('th');
                                   c.width(Math.floor(100/c.length)+'%');
                                  $('#pricingtable table').eq(0).dataTable(bPaginate);
                                }
                            });
                            return false;
                    }
                function bindMeUp() {
                    $('#pricingdetails  table').eq(0).dataTable(bPaginate);
                }
                if(typeof(appendLoader)=='function') {
                    appendLoader('bindMeUp');
                } else {
                    $(document).ready(function(){bindMeUp();});
                }
</script>    {/literal}

    <div class="mseparator"></div>
            {* metered table *}
            <div id="pricingdetails">
                <div style="margin-bottom:8px;padding-bottom:2px;border-bottom:1px solid #DADBDD">
                    <h3 class="summarize left" style="border-bottom:none;margin:0px;padding:0px;">{$lang.usagedetails}</h3>
                    <div class="right">
                        {$lang.Interval} <select name="metered_interval" id="metered_interval" onchange="metteredBillinghistory()" style="width:80px;">
                                <option value="1h">{$lang.onehour}</option>
                                <option value="1d">{$lang.oneday}</option>

                            </select>
                            {$lang.entermonth} <select name="metered_period" id="metered_period" onchange="metteredBillinghistory()" style="width:80px;">
                                {foreach from=$metered_periods item=p}
                                    <option value="{$p}">{$p}</option>
                                {/foreach}
                            </select>
                    </div>
                    <div class="clear"></div>
                </div>
        <div id="pricingtable"> {include file="`$custolist_dir`ajax.metered_table.tpl"}</div>

        
                <div class="clear"></div>
            </div>

            {/if}



        
        {literal}
            
            <style>
           
table.ttable tr td {
    border-bottom: 1px solid #DADBDD;
    border-top: 1px solid #FFFFFF;
    vertical-align: middle;
	padding:3px 4px;
    padding: 10px 5px;
}
</style>
{/literal}