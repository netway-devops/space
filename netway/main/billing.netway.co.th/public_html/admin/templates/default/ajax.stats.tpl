{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.stats.tpl.php');
{/php}

{if $showall}

    <script type="text/javascript" src="{$template_dir}js/graph/raphael-min.js"></script>
    <script type="text/javascript" src="{$template_dir}js/graph/g.raphael.js"></script>
    <script type="text/javascript" src="{$template_dir}js/graph/g.bar.js"></script>

    <script src="{$template_dir}js/statistics.js?v={$hb_version}" type="text/javascript"></script>
    <script src="{$template_dir}js/cookie.js" type="text/javascript"></script>
{literal}
    <style type="text/css">

        #graph1 {background:#fff; padding:5px 1%; }

        #graph1div {width:100%; overflow: hidden;}
        #graph1div table{
            width: 100%;
            text-align: right;
        }
        #graph1div table td{
            white-space: nowrap;
            padding: 1px 5px;
        }
        #graph1div table td:last-child{
            padding-right: 100px;
        }
        #graph1div table td div{
            background: #444;
            height: 15px;
            position: relative;
        }
        #graph1div table td div span{
            position: absolute;
            left:100%;
            padding-left: 5px;
        }
        #graph1div table tr:last-child td{
            padding-bottom: 10px;
        }
        #graph1div table td div:hover {
            opacity: 0.8;
        }
        #graph-total{
            border-top: 1px solid #000000;
            line-height: 20px;
            text-align: right;
            padding: 10px;
        }
        #graph2 { height:200px; margin-top:15px; background:#fff; float:left; width:40%}
        .stat-result {background:#fff;}
        .bc#graph2{ height:270px;  width:38%}
        .stat-result , .stat-result li ul {list-style:none; margin: 0; padding:0; }
        .stat-result li {padding: 10px 5px 10px 30px; border-bottom: 1px solid #eee }
        .stat-result li li {border:none; clear:left; padding: 5px 20px}
        .stat-result li li span {float:left; display:block; width: 150px}
        .stat-result li.odd { background:#F4F4F4 }
        .stat-result li.first {  font-size:15px;}
        #interval{
            background: url("{/literal}{$template_dir}{literal}img/bg_pag.gif") repeat-x scroll left top #eee;
            border: 1px solid #B0B0B0;
            border-radius: 2px 2px 2px 2px;
            font-size: 11px;
            padding-left: 5px;
            height: 21px;
            margin: 0 0 2px;
            vertical-align: middle;
            text-shadow: 0 1px 0 #FFFFFF;
        }
        .list-2{margin-bottom:20px;}
        .list-2 .subm1.haveitems {padding: 10px 0 7px 16px; display:none;  background:#fff}
        .newhorizontalnav .datetab {}
        li.datetab span{border: 1px solid #CCCCCC; padding: 4px;}
        li.datetab span.picker{border-left:none; padding-left:28px; background: url('{/literal}{$template_dir}{literal}img/calendar-month.png') no-repeat center center #f5f5f5}
        li.datetab.active span{border:none; background:none; padding-left: 5px;}
        a.dp-choose-date{padding:1px 10px; float:none;display:inline}
        .data-point-label{text-align :center; position:absolute; color:#999}
        div.subm1.haveitems a{display:inline-block; vertical-align: middle;}
        div.ui-daterangepicker-arrows{ display: inline-block; padding: 1px 0;    vertical-align: middle; border:none}
        input#daterange {font-family: Tahoma}
        select#daterange,select#daterangem{min-width:100px; padding:3px}
        .tag{
            background: #dddfe0;
            padding: .1em .4em .1em;
            border-radius: .25em;
            cursor: pointer;
            margin: 4px;
            color: white;
            display: inline-block;
            font-size: 85%;
        }
        .ticket-graph{
            margin-top: 5px;
        }
        .excluded{}
        .panel-heading{
            cursor: pointer;
        }
        .onetag{

            position: relative;
        }
        .onetag:after{
            display: block;
            clear: both;
        }
        .row{
            margin-left: 0px !important;
            margin-right: 0px !important;
        }
        .separator{
            height: 25px;
        }
        .currency-select {
            margin: 6px;
            padding: 0 10px;
            height: 28px;
        }
    </style>
    <script type="text/javascript">

        var p2jq = [['d', 'dd'], ['j', 'd'], ['l', 'DD'], ['m', 'mm'], ['n', 'm'], ['F', 'MM'], ['Y', 'yy']];
        var dateformat ={/literal} '{$date_format}'{literal};
        for (var i = 0; i < p2jq.length; i++)
            dateformat = dateformat.replace(p2jq[i][0], p2jq[i][1])

        $(function() {
            $('.datetab').click(function() {
                if ($('li.datetab').hasClass('active')) {
                    $('li.datetab').removeClass('active');
                    $('.subm1').hide();
                } else {
                    $(this).addClass('active');
                    $('.subm1').show();
                }
                return false;
            });
        });

        function updateQueryStringParameter(uri, key, value) {
          var re = new RegExp("&" + key + "=.*?(&|$)", "i");
          var separator = uri.indexOf('?') !== -1 ? "&" : "?";
          if (uri.match(re)) {
              if (value == '') {
                  return uri.replace(re, '$1');
              } else {
                  return uri.replace(re, separator + key + "=" + value );
              }
          }
          else {
            return uri + separator + key + "=" + value;
          }
        }

        function changeCurrency() {
            var value = $('.currency-select').val();
            if (value) {
                var uri = window.location.href;
                var key = 'stats_currency';
                var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
                var separator = uri.indexOf('?') !== -1 ? "&" : "?";
                if (value === 'none') {
                    window.location.href = updateQueryStringParameter(uri, key, '');
                } else {
                    window.location.href = updateQueryStringParameter(uri, key, value);
                }
            }
        }
    </script>
{/literal}
{/if}{*END SHOWALL*}
{if $action=="default" || $action=="report" ||  $action=="orders" || $action=="transactions" || $action=="singup" || $action=="tickets" || $action=="supportreply" || $action=="ticketsgen" || $make=='byservice' || $make=='bycountry' || $action=='income' || $action=='incomepaymentgateway' || $action=='revenueapp'}
    {if $showall}
        <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-1">
            <ul>
                <li>
                    <a href="#"><span class="ico money">{if $action=='default'}Yearly Income{elseif $lang[$action]}{$lang[$action]}{else}Statistics{/if}</span></a>
                </li>
                <li class="datetab last">
                    <a href="#"><span>{$dateFrom|dateformat:$date_format} - {$dateTo|dateformat:$date_format}</span><span class="picker"></span></a>
                </li>
                {if $monetary}

                <li>
                                    Convert to:

</li>
                    <li>
                        <select name="currency" class="form-control currency-select" onchange="changeCurrency();">
                            <option value="none" {if is_numeric($stats_currency) === false}selected="selected"{/if}>Currency: Original</option>
                            {foreach from=$currencies item=crx}
                                <option value="{$crx.id}" {if $crx.id === $stats_currency} selected="selected" {/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                            {/foreach}
                        </select>
                    </li>
                {/if}
            </ul>
        </div>
        <div class="list-2">
            <div class="subm1 haveitems" >
                <select type="text" id="daterange" >{foreach from=$dates item=y key=v}<option {if $selectedyear == $v}selected="selected"{/if} value="{$y}">{$v}</option>{/foreach}</select>
                {if $months}
                    <select type="text" id="daterangem" >{foreach from=$months item=y key=v}<option {if $selectedmonth == $v}selected="selected"{/if} value="{$v}">{$y}</option>{/foreach}</select>
                    {if $weeks}
                        <select id="daterangew">
                            {foreach from=$weeks item=week key=v}
                                <option value="{$v}" {if $selectedweek == $v}selected{/if}>{$week}</option>
                            {/foreach}
                        </select>
                    {/if}
                    {if $departments}
                        <select id="datedept">
                            <option value="0" {if $selecteddept == 0}selected{/if}>All departments</option>
                            {foreach from=$departments item=dept}
                                <option value="{$dept.id}" {if $selecteddept == $dept.id}selected{/if}>{$dept.name}</option>
                            {/foreach}
                        </select>
                    {/if}
                {/if}
                <a href="#" onclick="submitdate('{$action}')" class="new_control greenbtn"><span>{$lang.submit}</span></a>
                <a href="#" class="new_control datetab" onclick="">{$lang.Cancel}</a>
            </div>
        </div>

        <div class="niecers" style="border:none; padding:10px 0">
        {if $action=="ticketsgen"}
            <ul class="stat-result">
                <li>
                    <h3>{$lang.avg_rp_time} <a href="#" class="vtip_description" title="{$lang.avg_rp_time_dscr}"></a> </h3>
                    {if $data.avg_response}
                        {if $data.avg_response.4}{$data.avg_response.4} {$lang.weeks}{/if}
                        {if $data.avg_response.3}{$data.avg_response.3} {$lang.days}{/if}
                        {if $data.avg_response.2}{$data.avg_response.2} {$lang.hours}{/if}
                        {if $data.avg_response.1}{$data.avg_response.1} {$lang.minutes}{/if}
                        {if $data.avg_response.0}{$data.avg_response.0} {$lang.seconds}{/if}
                    {else}
                        {$lang.avg_rp_none}
                    {/if}
                </li>
                <li>
                    <h3>{$lang.avg_rs_time} <a href="#" class="vtip_description" title="{$lang.avg_rs_time_dscr}"></a> </h3>
                    {if $data.avg_resolve}
                        {if $data.avg_resolve.4}{$data.avg_resolve.4} {$lang.weeks}{/if}
                        {if $data.avg_resolve.3}{$data.avg_resolve.3} {$lang.days}{/if}
                        {if $data.avg_resolve.2}{$data.avg_resolve.2} {$lang.hours}{/if}
                        {if $data.avg_resolve.1}{$data.avg_resolve.1} {$lang.minutes}{/if}
                        {if $data.avg_resolve.0}{$data.avg_resolve.0} {$lang.seconds}{/if}
                    {else}
                        {$lang.avg_rs_none}
                    {/if}
                </li>
                <li>
                    <h3>{$lang.status_brk}</h3>
                    <ul>
                        {assign value="Client-Reply" var=clientreply}
                        {assign value="In-Progress" var=inprogress}
                        <li><span class="Open">{$lang.opentickets}</span> {$data.Open} </li>
                        <li><span class="Answered">{$lang.answtickets} </span>{$data.Answered} </li>
                        <li><span class="Client-Reply">{$lang.clientrtickets} </span>{$data.$clientreply} </li>
                        <li><span class="In-Progress">{$lang.inprogresstickets} </span>{$data.$inprogress} </li>
                        <li><span class="Closed">{$lang.closedtickets} </span>{$data.Closed}</li>
                    </ul>
                </li>
                <li>
                    <h3>{$lang.support_brk}</h3>
                    <ul>
                        <li><span>{$lang.rp_line1}</span> {$data.rp_single} {$lang.ticket_s} ({$data.rp_percent1}%)</li>
                        <li><span>{$lang.rp_line2}</span> {$data.rp_morthanone} {$lang.ticket_s} ({$data.rp_percent2}%)</li>
                    </ul>
                </li>
            </ul>
        {elseif $action=="report"}
            <table style="width: 100%" cellspacing="0" cellpadding="5" class="table glike hover">
                <tr>
                    <th>Type</th>
                    <th>Item</th>
                    <th>Period</th>
                    <th>Start Date</th>
                    {foreach from=$data.timeline item=items key=period}
                        <th>{$period}</th>
                    {/foreach}
                </tr>
                {foreach from=$data.items item=item key=itemkey}
                    <tr>
                        <td>{*
                    {if $item.invoice_type & 1}Recurring{/if}
                    {if $item.invoice_type & 4}Mettered{/if}
                    *}
                            {if $item.is_refnud}Refund{/if}
                        </td>
                        {*<td>{$item.item_id}</td>*}
                        <td>
                            {if $item.type=='Hosting' || $item.type=='Addon' }
                                <a href="?cmd=accounts&action=edit&id={$item.rel_id}&list=all" >{$item.item_name}</a>
                            {elseif $item.type=='Domain Register' || $item.type=='Domain Transfer'}
                                <a href="?cmd=domains&action=edit&id={$item.rel_id}&list=all" >{$item.item_name}</a>
                            {else}
                                {$item.item_name}
                            {/if}
                        </td>
                        <td>{if $item.cycle && is_numeric($item.cycle)}{$item.cycle} {$lang.Year}{elseif $item.cycle}{$lang[$item.cycle]}{else}{$lang.once}{/if}</td>
                        <td>{$item.date|dateformat:$date_format}</td>
                        {foreach from=$data.timeline item=items key=period}
                            <td style="white-space: nowrap; border-left: 1px solid #ddd;{if $items[$itemkey] < 0}color:#500;{/if}">
                                {if $items[$itemkey]}{$items[$itemkey]|price:$item.currency_id:true:false:true:2:false}{else}-{/if}
                            </td>
                        {/foreach}
                    </tr>
                {/foreach}
            </table>
        {else}
            <div id="graph1"  {if $make=="bycountry"}class="bc"{/if}>
            <div id="graph1div" data-max="{$graph_max}" data-min="{$graph_min}">
                {if $action=='incomepaymentgateway'}
                    <table>
                        {foreach from=$gateway item=gate key=gw}
                            <tbody>
                            {foreach from=$mchart item=result key=index}
                                <tr>
                                    {if $gw == $result.module}
                                        <td style="width:1%">{$gw}</td>
                                        <td>
                                            <div style="width:{if $bar_width[$index]}{$bar_width[$index]}{else}0%{/if}; background-color:{$result.bar_color}">
                                                    <span>
                                                        {if $result.currency}
                                                            {if $stats_currency}
                                                                {$result.total|price:$stats_currency}
                                                            {else}
                                                                {$result.total|price:$result.currency_id}
                                                            {/if}
                                                        {else}
                                                            {if $result.total}
                                                                {$result.total}
                                                            {else}0
                                                            {/if}
                                                        {/if}
                                                    </span>
                                            </div>
                                        </td>
                                    {/if}
                                </tr>
                            {/foreach}
                            </tbody>
                        {/foreach}
                    </table><br>
                {elseif $mchart}
                    <table>
                        {foreach from=$tick item=tickgroup key=indx}
                            <tbody class="ticket-month">
                            {foreach from=$tickgroup item=tick key=tidx}
                                <tr>
                                    {foreach from=$tick item=label}
                                        <td style="width:1%">{$label}</td>
                                    {/foreach}
                                    <td>
                                        <div style="width:{if $bar_width[$tidx][$indx]}{$bar_width[$tidx][$indx]}{else}0%{/if}; background-color:{$bar_color[$tidx]}">
                                            <span>
                                                {if $bar_currency[$tidx]}
                                                    {if $stats_currency}
                                                        {$mchart[$tidx][$indx]|price:$stats_currency}
                                                    {else}
                                                        {$mchart[$tidx][$indx]|price:$bar_currency[$tidx]}
                                                    {/if}
                                                {else}
                                                    {if $mchart[$tidx][$indx]}
                                                        {$mchart[$tidx][$indx]}
                                                    {else}0
                                                    {/if}
                                                {/if}
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        {/foreach}
                    </table>
                {elseif $action == 'revenueapp'}
                    <table>
                        {foreach from=$tick item=item key=indx}
                            <tr>
                                <td style="width:1%;color:#aaa">{$item.group_name}</td>
                                <td style="width:1%"><a href="?cmd=servers&action=edit&id={$item.id}" target="_blank">{$item.label}</a></td>
                                <td>
                                    <div style="width:{$item.bar_width}; background-color:{if $item.negative}red{else}#63b0e3{/if} ">
                                        <span>
                                            {if $stats_currency}
                                                {$item.revenue|price:$stats_currency}
                                            {else}
                                                {$item.revenue|price:0}
                                            {/if}
                                        </span>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                {elseif $chart}
                    <table>
                        {foreach from=$tick item=label key=indx}
                            <tr>
                                <td style="width:1%">{$label}</td>
                                <td>
                                    <div style="width:{if $bar_width[$indx]}{$bar_width[$indx]}{else}0%{/if}; background-color:#63b0e3"><span>{$chart[$indx]}</span></div>
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                {else}
                    <div class="blank_state" style="text-align: center">
                        <h1>No Data to display</h1>
                    </div>
                {/if}
                {if $total}


                    <div id="graph-total">
                    <div class="pull-left">
                        {if $statgroup == 'income' && $action != 'revenueapp'}
                            <mark>Note: This is gross income statistic and does not include gateway fees</mark>
                        {elseif $statgroup == 'income' && $action == 'revenueapp'}
                            <mark>Note: This statistics uses current App costs to calculate revenue</mark>
                        {/if}
                    </div>
                    <div class="pull-right">
                        <span>{$total.prefix}</span>
                        <strong>
                            {if $total.money}
                                {if $total.value}
                                    {if $stats_currency}
                                        {$total.value|price:$stats_currency}
                                    {else}
                                        {$total.value|price:$currency}
                                    {/if}
                                {else}
                                    {if $stats_currency}
                                        {$total_value|price:$stats_currency}
                                    {else}
                                        {$total_value|price:$currency}
                                    {/if}
                                {/if}
                            {else}
                                {if $total.value}
                                    {$total.value}
                                {else}
                                    {$total_value}
                                {/if}{$total.sufix}
                            {/if}
                        </strong>
                        {if $action=="default" || $action=='income'||$action=='incomebycountry'}
                        </br><span style="color: red;">(รวม VAT, รวม credit, หักส่วนลดทั้งหมดแล้ว, หัก refund แล้ว, หักค่าธรรมการชำระเงิน และ ภาษีหัก ณ ที่จ่าย แล้ว)</span>
                        {/if}
                        {if $action=="incomebyservice"}
                        <br/><span style="color: red;">(ไม่รวม Domain, ไม่รวม VAT, ไม่รวม credit, ไม่รวม refund หักส่วนลดตามรอบบิล, ยังไม่หักส่วนลด coupon, ไม่รวมค่าธรรมการชำระเงิน และ ภาษีหัก ณ ที่จ่าย)</span>
                        {/if}
                   </div>
                   <div class="clear"></div>

                    </div>
                {/if}
            </div>

        {/if}
        </div>
    {/if}{*END SHOWALL*}
    {if $action == 'supportreply' && $range == 'year'}
    {literal}
        <script>
            $(function() {
                var tmonth = $('.ticket-month');
                tmonth.each(function() {
                    if ($(this).height() > 0) {
                        $(this).append("<tr class='separator'></tr>");
                    }
                })
            });
        </script>
    {/literal}
    {/if}
{/if}
{if $action=='tickettags'}
    <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-1">
            <ul>
                <li>
                    <a href="#"><span class="ico money">Tags per {if $range=='year'}year{else}month{/if}</span></a>
                </li>
                <li>
                    <select type="text" id="daterange" >{foreach from=$dates item=y key=v}<option {if $cYear == $v}selected{else}{if $selectedyear == $v}selected="selected"{/if}{/if} value="{$y}">{$v}</option>{/foreach}</select>
                    {if $months}<select type="text" id="daterangem" >{foreach from=$months item=y key=v}<option value="{$v}" {if $cMonth == $v}selected{/if}>{$y}</option>{/foreach}<option value="all" {if $cMonth == 'all' || is_array($cMonth) || $cMonth == 'undefined'}selected{/if}>All</option></select>{/if}
                </li>
                <li style="margin-left: 25px;">
                    <select type="text" id="order" >
                        <option value="0" {if $cOrder == 0}selected{/if}>Order</option>
                        <option value="1" {if $cOrder == 1}selected{/if}>Usage frequency</option>
                        <option value="2" {if $cOrder == 2}selected{/if}>Alphabetically</option>
                    </select>
                </li>
                <li style="margin-left: 3px;">
                    <select type="text" id="filter" >
                        <option value="0" {if $cFilter == 0}selected{/if}>Filter</option>
                        <option value="1" {if $cFilter == 1}selected{/if}>Show all tags</option>
                        <option value="2" {if $ranger == null && ($cFilter == 0 || is_array($cFilter))}selected {elseif $cFilter == 2}selected{/if}>Show used tags</option>
                    </select>
                </li>
            </ul>
        </div>
        <div class="row"></div>
        <div id="tags-graph" class="row">

                {if $action == 'ticketgraph'}
                    {include file='ajax.ticketgraph.tpl'}
                {/if}

        </div>
    </div>
{literal}
    <script>
        var m = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        var year = $('#daterange option:selected').val();
        var month = $('#daterangem option:selected').val();
        var order = $('#order option:selected').val();
        var filter = $('#filter option:selected').val();
        Cookies.set("TicketYear", year);
        Cookies.set("TicketMonth",month);
        Cookies.set("TicketOrder", order);
        Cookies.set("TicketFilter", filter);

        updateData(year, month, order, filter);
        updateMonth(month);

        $('#daterange').change(function() {
            year = $(this).val();
            Cookies.set("TicketYear", year);
            updateData(year, month, order, filter);
        });
        $('#daterangem').change(function() {
            month = $(this).val();
            Cookies.set("TicketMonth",month);
            updateData(year, month, order, filter);
        });
        $('#order').change(function() {
            order = $(this).val();
            Cookies.set("TicketOrder", order);
            updateData(year, month, order, filter);
        });
        $('#filter').change(function() {
            filter = $(this).val();
            Cookies.set("TicketFilter", filter);
            updateData(year, month, order, filter);
        });

        function updateData(year, month, order, filter) {
            $.post("?cmd=stats&action=ticketgraph&range={/literal}{$range}{literal}",
            {
                year: year,
                month: month,
                order: order,
                filter: filter
            },
            function(data, status) {
                $('#tags-graph').html(data);
                if ({/literal}{$range}{literal} != null){
                    updateMonth(month);
                }
            });
        }

        function updateMonth(month){

            if (month == 'all'){
                for (i = 0; i < m.length; i++){
                    $('#month-'+m[i]).parent().parent().show();
                }
            }else{
                for (i = 0; i < m.length; i++){
                    $('#month-'+m[i]).parent().parent().hide();
                }
                $('#month-'+m[month]).parent().parent().show();
                showmonth(m[month]);
            }
        }

        function disabledTag(id) {
            Cookies.set("DisableTag"+id, id);
            var tag = $('#atag'+id);
            tag.hide();
            $('#tags-graph #'+id).hide();
            $('#dtag'+id).show();
        }

        function activeTag(id) {
            Cookies.remove("DisableTag"+id);
            var tag = $('#dtag'+id);
            tag.hide();
            $('#tags-graph #'+id).show();
            $('#atag'+id).show();
        }

        function hidemonth(month) {
            header = $('#month-'+month);
            body = $('#body-month-'+month);
            header.addClass('excluded');
            body.hide();
            header.attr('onclick', '').unbind('click');
            header.click(function(){ showmonth(month); });
            $('#plus'+month).show();

        }
        function showmonth(month) {
            header = $('#month-'+month);
            body = $('#body-month-'+month);
            header.removeClass('excluded');
            body.show();
            header.attr('onclick', '').unbind('click');
            header.click(function(){ hidemonth(month); });
            $('#plus'+month).hide();
        }
    </script>
{/literal}
{/if}