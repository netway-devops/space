<h1>{$lang.accounthash}{$details.id}</h1>

{include file='_common/accounts_cancelrequest.tpl'}

{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '_common/accounts_billing.tpl.php');
{/php}

<div id="client_nav">
    <!--navigation-->
    <a class="nav_el nav_sel left" href="#">{$lang.accountbdetails}</a>
    <a class="nav_el  left" href="?cmd=accounts&action=log&id={$details.id}"
       onclick="return false">{$lang.accountlog}</a>
    {include file="_common/quicklists.tpl" _client=$details.client_id}


    <div class="clear"></div>
</div>

<div class="ticketmsg ticketmain" id="client_tab">
    <div class="slide" style="display:block">
        <table cellspacing="2" cellpadding="3" border="0" width="100%">
             {if !$details.billingcycle|in_array:$regular_cycles &&  $details.billingcycle != 'Free'}         
               <h1 style="color: red;">Billing Cycle {$details.billingcycle} ไม่มีการตั้งราคา ให้รีบแก้ไขด่วน</h1>
            {/if}
            <tbody>
                <tr>
                    <td width="15%">{$lang.orderid}</td>
                    <td width="35%">
                        <a href="?cmd=orders&action=edit&id={$details.order_id}">
                            {$details.order_id}
                        </a>
                    </td>
                    <td width="15%">{$lang.paymethod}</td>
                    <td width="35%">
                        <select name="payment_module" onclick="new_gateway(this)">
                            <!--<option value="0">{$lang.none}</option>-->
                            {if $details.payment_module == '0'}
                                {assign var= 'default_payment' value='4'} <!-- set default payment select bank transfer -->
                            {/if}
                            {foreach from=$gateways item=module key=id}
                                <option value="{$id}" {if $details.payment_module==$id}selected="selected"{elseif $default_payment==$id}selected="selected"{/if}>
                                    {$module}
                                </option>
                            {/foreach}
                            <option value="new" style="font-weight: bold">{$lang.newgateway}</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>{$lang.Client}</td>
                    <td>
                        {$details|@profilelink:true|@login_as_client:$system_url:$details.client_id}
                    </td>
                    <td>
                        {if $metered_enable || $details.flavor.type === 'PrePay'}
                            Generate invoices
                        {else}{$lang.billingcycle}
                        {/if}
                    </td>
                    <td>
                        <select id="billing-cycle-select" name="billingcycle"
                                {if $details.metered_type=='PrePay' || $details.flavor.type === 'PrePay'}style="display:none"{/if}>
                            <!--Free -->
                            {if $details.paytype == 'Free'}
                            <option value="Free"
                                    {if $details.billingcycle=='Free'}selected='selected'{/if}>
                                {if $metered_enable}Off
                                {else}{$lang.Free}
                                {/if}
                            </option>
                            {/if}
                            <!--One Time -->
                            {if $details.paytype == 'Once'}
                                {if !$metered_enable}
                                    <option value="One Time"
                                            {if $details.billingcycle=='One Time'}selected='selected'{/if}>{$lang.OneTime}
                                    </option>
                                {/if}
                            {/if}
                            <!--Regular -->
                                {foreach from=$regular_cycles item=cycle}
                                    <option value="{$cycle}" {if $details.billingcycle==$cycle}selected{/if}>
                                        {$lang[$cycle]}
                                    </option>
                                {/foreach}
                        </select>

                        {if $details.metered_type=='PrePay' || $details.flavor.type === 'PrePay'}
                            <em>On low credit</em>
                        {/if}

                        {if !$details.metered_enable && $details.flavor.type !== 'PrePay'}
                            <select id="billing-type-select" name="billingtype">
                                <option value="PrePay" {if $details.billingtype=='PrePay'}selected='selected'{/if}>
                                    {$lang.PrePay}
                                </option>
                                <option value="PostPay" {if $details.billingtype=='PostPay'}selected='selected'{/if}>
                                    {$lang.PostPay}
                                </option>
                            </select>
                        {/if}
                    </td>
                </tr>
                <tr>
                    <td>{$lang.regdate}</td>
                    <td>
                        <input type="text" class="haspicker" value="{$details.date_created|dateformat:$date_format}"
                               name="date_created" size="12"/>
                    </td>
                    <td>{$lang.next_due}</td>
                    <td>
                        <input type="text" class="haspicker" value="{$details.next_due|dateformat:$date_format}"
                               name="next_due" size="12"/>
                        <a class="editbtn" href="?cmd=invoices&filter[item_id]={$details.id}&filter[type]=Hosting">
                            {$lang.findrelatedinv}
                        </a>
                    </td>
                </tr>
                <tr>
                    <td >&nbsp;</td>
                    <td ></td>
                    <td >Next Invoice Date</td>
                    <td >{$details.next_invoice|date_format:"%d/%m/%Y"}</td>
                </tr>
                <tr>
                    <td >&nbsp;</td>
                    <td ></td>
                    <td ><span class="ui-tooltips" title="ดึงจากวัน duedate ของ invoice ที่ paid ล่าสุด" style="border-bottom:1px dotted red; cursor:pointer;">Expiry Date<span></td>
                    <td >{if $details.next_due|dateformat:$date_format != ''}{if isset($aDetails.expire)}<span style="color:{$aDetails.color};">{$aDetails.expire}</span>{elseif isset($aDetails.error)}{$aDetails.error}{else}-{/if}{/if}</td>
                </tr>
                <tr>
                    <td>{$lang.Addons}</td>
                    <td><span id="numaddons">{$details.addons}</span> {$lang.addons_plu}</td>
                    {if $admindata.access.viewAccountsPrices}
                        <td>{$lang.firstpayment}</td>
                        <td>{$details.currency.sign}
                            <input type="text" value="{$details.firstpayment}"
                                   name="firstpayment" size="10"/>
                        </td>
                    {else}
                        <td>
                            <input type="hidden" value="{$details.firstpayment}"
                                   name="firstpayment" size="10"/></td>
                    {/if}
                </tr>

                <tr>
                    <td>
                        {$lang.Status}
                        <span class="ui-tooltips" title="ถ้าเปลี่ยน status เป็น Active ระบบจะทำการบันทึก invoice item ที่เกี่ยวข้องเป็น is_shipped (ส่งของแล้ว) ด้วย" style="border-bottom:1px dotted red; cursor:pointer;">
                            <i class="fa fa-info-circle"></i>
                        </span>
                    </td>
                    <td>
                        <select name="status" {if $details.manual != '1'}style="display:none"{/if} class="manumode">
                            <option {if $details.status == 'Pending'}selected="selected" {/if}
                                    value="Pending">{$lang.Pending}</option>
                            <option {if $details.status == 'Active'}selected="selected" {/if}
                                    value="Active">{$lang.Active}</option>
                            <option {if $details.status == 'Suspended'}selected="selected" {/if}
                                    value="Suspended">{$lang.Suspended}</option>
                            <option {if $details.status == 'Terminated'}selected="selected" {/if}
                                    value="Terminated">{$lang.Terminated}</option>
                            <option {if $details.status == 'Cancelled'}selected="selected" {/if}
                                    value="Cancelled">{$lang.Cancelled}</option>
                            <option {if $details.status == 'Fraud'}selected="selected" {/if}
                                    value="Fraud">{$lang.Fraud}</option>
                            <option {if $details.status == 'PendingVerify'}selected="selected" {/if}  
                                value="PendingVerify">PendingVerify</option>
                            <option {if $details.status == 'PendingReconfig'}selected="selected" {/if}  
                                value="PendingReconfig">PendingReconfig</option>
                            <option {if $details.status == 'Expired'}selected="selected" {/if}  
                                value="Expired">Expired</option>
                        </select>
                        <span class="{$details.status} livemode"
                              {if $details.manual == '1'}style="display:none"{/if}>
                            <strong>{$lang[$details.status]}</strong>
                        </span>
                        {*if $details.status == 'PendingVerify'*}
                    </td>
                    {if $details.metered_type=='PrePay' || $details.flavor.type == 'PrePay'}
                        <td colspan="2"></td>
                    {else}
                        <td>
                            {if $admindata.access.viewAccountsPrices}
                                {if $metered_enable}
                                    Next invoice total
                                    <a href="#" class="editbtn orspace" id="focus-metered">Details</a>
                                {else}
                                     {$lang.recurring}
                                {/if}
                            {/if}

                        </td>
                        <td>
                            {if $admindata.access.viewAccountsPrices}
                                {if $metered_enable}
                                    <b>{$details.metered_total|price:$details.currency}</b>
                                    <br/>Incl. Fixed fee:
                                {/if}

                                    {$details.currency.sign}
                                    <input type="text" value="{$details.total}" name="total"
                                                                   size="10"/>


                            {else}
                                <input type="hidden" value="{$details.total}" name="total" />
                            {/if}
                            {*if $isValidRecurringShow*}
                        </td>
                    {/if}
                </tr>

                <tr>
                    {if $autorenew_control}
                        <td class="auto-renew">
                            Auto-Renewal Invoice
                        </td>
                        <td class="auto-renew">
                            <div>
                                <label>
                                    <input type="radio" name="autorenew" value="1"
                                           {if $details.autorenew == 1}checked{/if} hidden/>
                                    <span class="label-livemode label label-success-invert"
                                          data-value="1">{$lang.yes}</span>
                                </label>
                                <label>
                                    <input type="radio" name="autorenew" value="0"
                                           {if $details.autorenew == 0}checked{/if} hidden/>
                                    <span class="label-livemode label label-default-invert"
                                          data-value="0">{$lang.no}</span>
                                </label>
                            </div>
                        </td>
                    {/if}
                    {if $affiliate}
                        <td>
                            Referral
                        </td>
                        <td>
                            <a href="?cmd=affiliates&action=affiliate&id={$affiliate.id}">{$affiliate|@client}</a>
                            {if $affiliate.plan.name}
                                (Plan:
                                <a href="?cmd=affiliates&action=commision&make=edit&id={$affiliate.plan.id}">
                                     {$affiliate.plan.name}
                                </a>&nbsp;
                                {if $affiliate.custom_rate}
                                    / {$affiliate.custom_rate.rate} {$affiliate.custom_rate.type}
                                {/if}
                                <a href="#" title="Customize commission plan"
                                    id="customize-aff" ><i class="fa fa-pencil-square-o"></i></a>{*
                                *})
                            {/if}
                        </td>
                    {/if}
                </tr>
                <tr>
                    <td>Contract</td>
                    <td>
                        {if $details.contract_id}
                            <a href="#" onclick="
                                $('.nav_el_contracts').click().addClass('nav_sel minim');
                                $('.nav_el').not('.nav_el_contracts').removeClass('nav_sel');
                                $('.slide').hide().eq(parseInt($('.nav_el_contracts').attr('tab-id'))+1).show();
                                $('html > head').append($('<style>.contractlist-{$details.contract_id} td{literal}{background-color:#fff8bc;}{/literal}</style>'));
                                return false;">{$details.contract_number} ({$details.contract_template})</a>
                        {else} No contract
                        {/if}
                    </td>
                    {if $details.commitment_date && $details.commitment_date != '0000-00-00'}
                    <td>Commitment until</td>
                    <td>
                        <div {if $details.manual != '1'}style="display:none"{/if} class="manumode">
                            <input class="haspicker" value="{if $details.commitment_date}{$details.commitment_date|dateformat:$date_format}{else}{/if}" name="commitment_date"/>
                        </div>
                        <div class="{$details.status} livemode" {if $details.manual == '1'}style="display:none"{/if}>
                            {if !$details.commitment_date || $details.commitment_date === '0000-00-00'}
                                None
                            {elseif $details.commitment_date|@strtotime > $timestamp}
                                <span style="color: #0C0">{$details.commitment_date|dateformat:$date_format}</span>
                            {else}
                                <span style="color: red">{$details.commitment_date|dateformat:$date_format}</span>
                            {/if}
                        </div>
                    </td>
                    {/if}
                </tr>
            </tbody>
        </table>
        {*if $aFulfillmentTicket|@count*}
    </div>
    {include file="_common/quicklists.tpl" _placeholder=true}
</div>
{literal}
    <script>
        $(function () {
            $("#billing-cycle-select").on('change', function () {
                var state = ['Free', 'One Time'].indexOf(this.value) === -1;
                $("#billing-type-select").toggle(state).prop('disabled', !state)
            }).trigger('change');

            $("#billing-type-select").on('change', function () {
                $('.auto-renew').toggle(this.value == 'PrePay');
            }).trigger('change');

            $('#focus-metered').on('click', function () {
                var picker = $('#tabbedmenu .tpicker.tab-metered');
                picker.click().ShowNicely();
                $('.tab_content').eq(picker.index()).ShowNicely();
                return false;
            })
            $('#customize-aff').on('click', function (e) {
                var dialog = bootbox.dialog({
                    title: 'Commission Plan',
                    message: '<div class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</div>',
                    backdrop: true,
                    onEscape: true,
                    buttons: {
                        confirm: {
                            label: 'Save changes',
                            className: 'btn-success',
                            callback: function(){
                                $('form', dialog).submit();
                                return false;
                            }
                        },
                        cancel: {
                            label: 'Cancel',
                            className: 'btn-default'
                        }
                    },
                })
                $.post('?cmd=affiliates&action=customize',
                    {relid: $('#account_id').val(), reltype: 'Hosting'},
                    function (data) {
                        data = parse_response(data);
                        $('.bootbox-body', dialog).html(data);
                    });
                return false;;
            })
        })
    </script>
{/literal}