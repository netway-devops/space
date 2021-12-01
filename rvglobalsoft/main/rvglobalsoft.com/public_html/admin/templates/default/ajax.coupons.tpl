{if $action=='getclients'}
    <select name="client_id" class="inp" load="clients" default="{$draft.client_id}" style="width: 180px">
        <option value="0">{$lang.All}</option>
        {*foreach from=$clients item=cl}
        <option value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.firstname} {$cl.lastname}{/if}</option>
        {/foreach*}
    </select>
    <script type="text/javascript">Chosen.find();</script>
{elseif $action=='default'}
{if $showall}
    <form action="" method="post" id="testform"><input type="hidden" value="{$totalpages}" name="totalpages2"
                                                       id="totalpages"/>
        <div class="blu">
            <div class="right">
                <div class="pagination"></div>
            </div>

            <div class="clear"></div>
        </div>

        <a href="?cmd=accounts&list={$currentlist}" id="currentlist" style="display:none" updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>
                    <th style="width:90px"><a href="?cmd=coupons&orderby=id|ASC"
                                              class="sortorder">{$lang.couponhash}</a>
                    </th>
                    <th style="width:15%"><a href="?cmd=coupons&orderby=code|ASC" class="sortorder">{$lang.Code}</a>
                    </th>
                    <th style="width:15%"><a href="?cmd=coupons&orderby=value|ASC"
                                             class="sortorder">{$lang.Discount}</a></th>
                    <th style="width:15%"><a href="?cmd=coupons&orderby=num_usage|ASC"
                                             class="sortorder">{$lang.Used}</a></th>
                    <th><a href="?cmd=coupons&orderby=notes|ASC" class="sortorder">{$lang.Notes}</a></th>
                    <th width="20"></th>
                </tr>
            </tbody>
            <tbody id="updater">
                {/if}
                {if $coupons}
                    {foreach from=$coupons item=coupon}
                        <tr>

                            <td><a href="?cmd=coupons&action=edit&id={$coupon.id}" data-pjax>{$coupon.id}</a></td>
                            <td><a href="?cmd=coupons&action=edit&id={$coupon.id}" data-pjax>{$coupon.code}</a></td>
                            <td>{if $coupon.type=='percent'}{$coupon.value}%{else}{$coupon.value|price:$currency}{/if}</td>
                            <td>{$coupon.num_usage}</td>
                            <td>{$coupon.notes}</td>
                            <td><a href="?cmd=coupons&make=delete&id={$coupon.id}&security_token={$security_token}"
                                   class="delbtn" onclick="return confirm('{$lang.confirmdel}')">{$lang.Delete}</a></td>

                        </tr>
                    {/foreach}
                {else}
                    <tr>
                        <td colspan="5">
                            <p align="center">{$lang.Click} <a
                                        href="?cmd=coupons&action=new">{$lang.here}</a> {$lang.tocreatecoupon}</p>
                        </td>
                    </tr>
                {/if}

                {if $showall}
            </tbody>
            <tbody id="psummary">
                <tr>
                    <th colspan="6">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span
                                id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span
                                id="sorterrecords">{$sorterrecords}</span>
                    </th>
                </tr>
            </tbody>
        </table>
        <div class="blu">
            <div class="right">
                <div class="pagination"></div>
            </div>

            <div class="clear"></div>
        </div>
        {securitytoken}
    </form>
{/if}
{elseif $action=='edit' || $action=='new'}
    <link href="{$template_dir}js/chosen/chosen.css" rel="stylesheet" media="all">
    <script type="text/javascript" src="{$template_dir}js/chosen/chosen.min.js?v={$hb_version}"></script>
    <form method="post" name="coupon-post" id="coupon-post">
        <input type="hidden" name="make" value="{if $action=='new'}add{else}update{/if}"/>
        <input type="hidden" name="coupon_id" id="coupon_id" value="{if $action=='new'}{else}{$coupon.id}{/if}" />
        <input type="hidden" name="rv_action" id="rv_action" value="{if $action=='new'}add{else}update{/if}" />

        <div class="lighterblue2">
            <div class="row">
                <div class="col-md-6">
                    <table border="0" cellpadding="6" cellspacing="0" width="100%">
                        <tr>

                            <td width="160" align="right"><strong>{$lang.couponcode}</strong></td>
                            <td>

                                <div class="input-group">
                                    <input type="text" name="code" id="code" style="font-weight:bold"
                                           value="{$coupon.code}" class="form-control">
                                    <span class="input-group-btn">
                                        <input type="button" value="{$lang.genrandom}"
                                               onclick="return randomCode('#code');" class="btn btn-success"/>
                                    </span>
                                </div>

                        </tr>

                        <tr>
                            <td width="160" align="right"><strong>{$lang.Discount}</strong></td>
                            <td><input class="inp" size="4" name="value" value="{$coupon.value}"/> <select
                                        class="inp" name="type">
                                    <option value="percent"
                                            {if $coupon.type=='percent'}selected="selected"{/if}>{$lang.percent}</option>
                                    <option value="fixed"
                                            {if $coupon.type=='fixed'}selected="selected"{/if}>{$lang.fixed}</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td width="160" align="right"><strong>{$lang.disctype}</strong></td>
                            <td>
                                <select class="inp" name="cycle" <!-- id="cycle_code" --> >
                                    <option value="once"
                                            {if $coupon.cycle=='once'}selected="selected"{/if}>{$lang.applyonce}</option>
                                    <option value="recurring"
                                            {if $coupon.applyto!='setupfee' && $coupon.cycle=='recurring'}selected="selected"{/if} {if $coupon.applyto=='setupfee'}disabled="disabled"{/if}>{$lang.Recurring}</option>
                                </select>
                            </td>
                        </tr>

                        <tr id="increase_in_days" {if $coupon.cycle!='recurring'} style="display: none;" {/if}>
                            <td width="160" align="right"><strong>Set regular price after</strong> <a
                                        class="vtip_description"
                                        title="Use this if you wish to set package price back to regular in certain time - ie. you wish to discount only first 3 months"></a>
                            </td>
                            <td><input type="checkbox" name="increase_in_days_check" onclick="check_i(this)"
                                       {if $coupon && $coupon.cycle=='recurring' && $coupon.increase_in_days > 0}checked="checked"{/if} />
                                <input size="4" name="increase_in_days" class="inp config_val"
                                       {if !$coupon || $coupon.increase_in_days=='0'}disabled="disabled"{/if}
                                       value="{$coupon.increase_in_days}"/>
                                days
                            </td>
                        </tr>
                        <tr>
                            <td width="160" align="right"><strong>Apply to</strong></td>
                            <td>
                                <select class="inp" name="applyto" onchange="recurring_check(this.value);"
                                        id="apply_code">
                                    <option value="price" {if $coupon.applyto=='price'}selected="selected"{/if}>
                                        Recurring price
                                    </option>
                                    <option value="setupfee"
                                            {if $coupon.applyto=='setupfee'}selected="selected"{/if}>Setup fee
                                    </option>
                                    <option value="both" {if $coupon.applyto=='both'}selected="selected"{/if}>Total
                                        price
                                    </option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.appby}</strong></td>
                            <td><select class="inp" name="clients" onchange="client_check(this.value);">
                                    <option value="all"
                                            {if $coupon.clients=='all'}selected="selected"{/if}>{$lang.allcusts}</option>
                                    <option value="new"
                                            {if $coupon.clients=='new'}selected="selected"{/if}>{$lang.onlynewcusts}</option>
                                    <option value="existing"
                                            {if $coupon.clients=='existing'}selected="selected"{/if}>{$lang.existcusts}</option>
                                </select></td>
                        </tr>

                        <tr id="specify" {if $coupon.clients!='existing'}style="display:none"{/if}>
                            <td width="160" align="right"><strong>{$lang.specifiedcusts}</strong></td>
                            <td id="loadcustomers">
                                {if $coupon.client_id=='0'} {$lang.allcustx}
                                    <a href="#"
                                       onclick="ajax_update('?cmd=coupons&action=getclients',{literal} {}{/literal}, '#loadcustomers', true);
                                               return false;">{$lang.clherex}</a>
                                {else}
                                    <input type="hidden" name="client_id" value="{$coupon.client_id}"/>
                                    <a href="?cmd=clients&action=show&id={$coupon.client_id}">#{$coupon.client_id} {$coupon.lastname} {$coupon.firstname}</a>
                                    <a href="#"
                                       onclick="ajax_update('?cmd=coupons&action=getclients',{literal} {}{/literal}, '#loadcustomers', true);
                                               return false;">Change customer</a>
                                {/if}

                            </td>
                        </tr>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.maxusage}</strong></td>
                            <td><input type="checkbox" name="max_usage_limit" onclick="check_i(this)"
                                       {if $coupon && $coupon.max_usage!='0'}checked="checked"{/if} /><input
                                        size="4" name="max_usage" class="inp config_val"
                                        {if !$coupon || $coupon.max_usage=='0'}disabled="disabled"{/if}
                                        value="{$coupon.max_usage}"/></td>
                        </tr>

                        <tr>
                            <td width="160" align="right"><strong>Max. use per one client</strong></td>
                            <td><input type="checkbox" name="max_client_usage_limit" onclick="check_i(this)"
                                       {if $coupon && $coupon.max_client_usage!='0'}checked="checked"{/if} /><input
                                        size="4" name="max_client_usage" class="inp config_val"
                                        {if !$coupon || $coupon.max_client_usage=='0'}disabled="disabled"{/if}
                                        value="{$coupon.max_client_usage}"/></td>
                        </tr>

                        <tr>
                            <td width="160" align="right"><strong>{$lang.expdate}</strong></td>
                            <td><input type="checkbox" onclick="check_i(this)" style="float:left"
                                       {if $coupon && $coupon.expires!='0000-00-00'}checked="checked"{/if}/><input
                                        name="expires"
                                         readonly="readonly"
                                        class="inp config_val haspicker" {if !$coupon || $coupon.expires=='0000-00-00'} disabled="disabled"{/if} {if $coupon.expires}value="{$coupon.expires|dateformat:$date_format}"{/if}/>
                            </td>
                        </tr>

                        <tr>
                            <td width="160" align="right"><font color="red">*</font><strong> View Cart0</strong></td>
                            <td><input type="checkbox" name="view_order_cart0" id="view_order_cart0" {if $coupon && $coupon.view_order_cart0!='0'}checked="checked"{/if} /></td>        
                        </tr>
                        <tr>
                            <td width="160" align="right"><font color="red">*</font><strong> View Cart3</strong></td>
                            <td><input type="checkbox" name="view_order_cart3" id="view_order_cart3" {if $coupon && $coupon.view_order_cart3!='0'}checked="checked"{/if} /></td>        
                        </tr>   

                        <tr>
                            <td width="160" align="right"><strong>{$lang.notesadmin}</strong></a></td>
                            <td><textarea name="notes"
                                          style="height: 4em; width: 100%;">{if $coupon.notes}{$coupon.notes}{/if}</textarea>
                            </td>
                        </tr>

    
    <tr>
        <td width="160" align="right"><font color="red">**</font><strong> View Coupon Info</strong></a></td>
        <td><textarea name="view_coupon_details" id="view_coupon_details" style="height: 4em; width: 100%;">{if $coupon.view_coupon_details}{$coupon.view_coupon_details}{/if}</textarea></td>     
    </tr>
    
{literal}    
    <tr>
        <td colspan="2" width="100%">
<style>
pre.precode {
  /*background-color: #FFFF99 ;*/
  border: 1px solid #006600 ;
}
</style>
        
        
<br><br><font color="red">* </font>นอกเหนือจาก cart0, cart3 ถ้าต้องการ Display หน้าอื่นให้ใส่ Code ดังนี้ใน Smarty<br>
<pre class="precode">
{assign var='productid' value=$i.id}
{php}
    $templatePath = $this->get_template_vars('template_path');
    include(dirname($templatePath) . '/orderpages/order_coupon.tpl.php');
    
    /*
    * @param $viewCart - {0, 3}
    * @param $productId
    */
    $productid = $this->get_template_vars('productid');
    order_coupon::singleton()->displayCoupon(0, $productid);
{/php}
</pre>
<font color="red">** </font>View discount info สามารถใส่ HTML code ได้
            
        </td>
    </tr>
{/literal}    

                    </table>
                </div>
                <div class="col-md-6" id="applicable">
                    <div class="form-group" id="toggles">
                        <label>{$lang.appliesto}:</label>
                        <div class="checkbox" style="margin-top: 0;">
                            <label>
                                <input type="checkbox" name="apply_products" data-toggle="#products"
                                       {if $coupon.products!=''}checked="checked"{/if}/> {$lang.Products}
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="apply_categories" data-toggle="#categories"
                                       {if $coupon.categories!=''}checked="checked"{/if}/> Categories
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="apply_domains" data-toggle="#domains"
                                       {if $coupon.domains!=''}checked="checked"{/if}/> {$lang.Domains}
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="apply_addons" data-toggle="#addons"
                                       {if $coupon.addons!=''}checked="checked"{/if}/> {$lang.Addons}
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="apply_forms" data-toggle="#forms"
                                       {if $coupon.forms!=''}checked="checked"{/if} disabled/>
                                Form components
                                <span class="vtip_description">
                                    <div>
                                        When this option is enabled product price <strong><u>will not</u></strong> be
                                        discounted. Discount will only apply to price from selected form components.
                                        When disabled discount is calculated from product price and all forms that allow it.
                                    </div>
                                </span>
                            </label>
                        </div>
                        {*}<input type="checkbox" name="apply_upgrades" onclick="sh_('#upgrades', this)" {if $coupon.upgrades!=''}checked="checked"{/if} /> {$lang.Upgrades}<br />{*}
                    </div>

                    <div class="form-group" id="products" hidden>
                        <label>{$lang.appliproduc}</label>
                        <select multiple="multiple" name="products[]" class="form-control" data-chosen
                                data-placeholder="Select applicable products" id="product_selector">
                            <option value="0"
                                    {if $coupon.products.0=='0'}selected="selected"{/if} >{$lang.applytoall}</option>
                            {foreach from=$products item=i }
                                {foreach from=$i item=prod name=product}
                                    {if $smarty.foreach.product.first}<optgroup label="{$prod.catname}">{/if}
                                    <option value="{$prod.id}"
                                            {if $coupon.products[$prod.id]}selected="selected"{/if}>{$prod.name}</option>
                                    {if $smarty.foreach.product.last}</optgroup>{/if}
                                {/foreach}
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group" id="categories" hidden>
                        <label>Applicable categories</label>
                        <select multiple="multiple" name="categories[]" class="form-control" data-chosen
                                data-placeholder="Select applicable product categories" id="category_selector">
                            {foreach from=$categories item=i key=c }
                                <option value="{$c}"
                                        {if $coupon.categories[$c]}selected="selected"{/if}>{$i}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group" id="upgrades" hidden>
                        <label>{$lang.applyupgrades}</label>
                        <select multiple="multiple" name="upgrades[]" class="form-control">
                            <option value="0"
                                    {if $coupon.upgrades.0=='0'}selected="selected"{/if}>{$lang.applyallupgrades}</option>
                            {foreach from=$upgrades item=i key=k}
                                <option value="{$k}"
                                        {if $coupon.upgrades[$k]}selected="selected"{/if}>{$i}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group" id="addons" hidden>
                        <label>{$lang.appliaddons}</label>
                        <select multiple="multiple" name="addons[]" class="form-control" data-chosen
                                data-placeholder="Select applicable addons" id="addon_selector">
                            <option value="0"
                                    {if $coupon.addons.0=='0'}selected="selected"{/if}>{$lang.applialladd}</option>
                            {foreach from=$addons item=i key=k}
                                <option value="{$k}"
                                        {if $coupon.addons[$k]}selected="selected"{/if}>{$i}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group" id="domains" hidden>
                        <label>{$lang.applidom}</label>

                        <select multiple="multiple" name="domains[]" class="form-control" data-chosen
                                data-placeholder="Select applicable TLDs" id="domain_selector">
                            <option value="0"
                                    {if $coupon.domains.0=='0'}selected="selected"{/if}>{$lang.applitld}</option>
                            {foreach from=$domains item=i key=k}
                                <option value="{$k}"
                                        {if $coupon.domains[$k]}selected="selected"{/if}>{$i}</option>
                            {/foreach}
                        </select>
                        <div>
                            <div class="checkbox">
                                <label>
                                    <input name="options[]" value="1" type="checkbox"
                                           {if $coupon.options & 1}checked{/if}/>
                                    Apply to domain registration
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input name="options[]" value="2" type="checkbox"
                                           {if $coupon.options & 2}checked{/if}/>
                                    Apply to domain transfers
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input name="options[]" value="4" type="checkbox"
                                           {if $coupon.options & 4}checked{/if}/>
                                    Apply to domain renewals
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" id="cycles" hidden>
                        <label>{$lang.appcycles}</label>
                        <select multiple="multiple" name="cycles[]" class="form-control" data-chosen
                                data-placeholder="Select applicable cycles" id="cycle_selector">
                            <option value="0"
                                    {if $coupon.cycles.0=='0'}selected="selected"{/if}>{$lang.appallcyc}</option>
                            {assign var='semi' value='Semi-Annually'}
                            <option value="Hourly" {if $coupon.cycles.Hourly} selected="selected"{/if}>{$lang.Hourly}</option>
                            <option value="Daily" {if $coupon.cycles.Daily} selected="selected"{/if}>{$lang.Daily}</option>
                            <option value="Weekly" {if $coupon.cycles.Weekly} selected="selected"{/if}>{$lang.Weekly}</option>
                            <option value="Monthly" {if $coupon.cycles.Monthly} selected="selected"{/if}>{$lang.Monthly}</option>
                            <option value="Quarterly" {if $coupon.cycles.Quarterly} selected="selected"{/if}>{$lang.Quarterly}</option>
                            <option value="Semi-Annually" {if $coupon.cycles[$semi]} selected="selected"{/if}>{$lang.SemiAnnually}</option>
                            <option value="Annually" {if $coupon.cycles.Annually} selected="selected"{/if}>{$lang.Annually}</option>
                            <option value="Biennially" {if $coupon.cycles.Biennially} selected="selected"{/if}>{$lang.Biennially}</option>
                            <option value="Triennially" {if $coupon.cycles.Triennially} selected="selected"{/if}>{$lang.Triennially}</option>
                            {foreach from=$periods item=p}
                                {assign var='tld' value="tld$p"}
                                <option value="tld{$p}" {if $coupon.cycles.$tld} selected="selected"{/if}>{$lang.Domains} {$p} {$lang.years}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group" id="forms" hidden>
                        <label>Applicable form components</label>
                        <select multiple="multiple" name="forms[]" class="form-control" data-chosen
                                data-placeholder="Select applicable form variables" id="form_selector">
                            {foreach from=$applyforms item=variable}
                                <option value="{$variable}"
                                        {if $coupon.forms[$variable]}selected="selected"{/if}>{$variable}</option>
                            {/foreach}
                        </select>
                        <div class="help-block">
                            <small>Select variables used in forms that you want to discount.</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {literal}
            <script>
                $(document).ready(function () {
                    var proRel = $('[name=apply_products], [name=apply_categories], [name=apply_domains]', '#toggles');

                    proRel.on('change', function () {
                        var checked = proRel.filter(":checked").length > 0;
                        $('#cycles').toggle(checked)
                        $('[name=apply_forms]', '#toggles').prop('disabled', !checked);
                    })

                    $('#toggles').on('change', '[data-toggle]', function () {
                        $(this.dataset.toggle).toggle(this.checked);
                    }).find('[data-toggle]').trigger('change');

                    $('#applicable [data-chosen]').chosenedge({
                        width: "100%",
                        search_contains: true,
                    });


                    $('#cycle_code').change(function () {
                        var val = $(this).val();
                        var target = $('#increase_in_days');
                        if (val == 'once') {
                            target.hide();
                            $('input[name=increase_in_days_check]').removeAttr('checked');
                            $('input[name=increase_in_days]').attr('disabled', 'disabled').val(0);
                        } else {
                            target.show();

                        }
                    });
                });
            </script>
        {/literal}
        <div class="blu">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td><a href="?cmd=coupons" data-pjax><strong>&laquo; {$lang.backtoexi}</strong></a>&nbsp;</td>
                    <td><input type="button" onclick="doCoupon();" name="save"
                               value="{if $action=='new'}{$lang.addcoupon}{else}{$lang.savechanges}{/if}"
                               class="btn btn-primary btn-sm"/></td>
                </tr>
            </table>
        </div>

        {securitytoken}
    </form>
{/if}



<script type="text/javascript">
{literal}

function doCoupon() {

    subaction = $('#rv_action').val(); // update, add
    
    data = {
            cmd: 'rvglobalsoft_common',
            action: 'coupon',
            subaction: subaction, 
            couponId: $('#coupon_id').val(),
            viewOrderCart0: ($('#view_order_cart0').is(':checked') == true) ? 1 : 0,
            viewOrderCart3: ($('#view_order_cart3').is(':checked') == true) ? 1 : 0,
            viewCouponDetails: $('#view_coupon_details').val()
   };


   if (subaction == 'update') {
          $.ajax({
                   type: 'POST',
                   data: data,
                   success: function(data) {
                       $('#coupon-post').submit();
                   },
                   error: function(xhr,error) {
                   }
         });
   } else if (subaction == 'add') {

        //$('#coupon-post').submit();
        
        // Manage After Submit Redirect 
        currentUrl = document.URL;
        redirectTo = currentUrl.replace(/\&action=(.*?)$/g, "");

        $.ajax({
            type: 'POST',
            data: $('#coupon-post').serialize(),
            success: function(data) {


                // CALL BACK AFTER SUBMIT
                data = {
                        cmd: 'rvglobalsoft_common',
                        action: 'coupon',
                        subaction: subaction,
                        couponCode: ($('#code')).val(),
                        viewOrderCart0: ($('#view_order_cart0').is(':checked') == true) ? 1 : 0,
                        viewOrderCart3: ($('#view_order_cart3').is(':checked') == true) ? 1 : 0,
                        viewCouponDetails: $('#view_coupon_details').val()
                };
                
                $.ajax({
                    type: 'POST',
                    data: data,
                    success: function(data) {
                         window.location.href = redirectTo;
                    },
                    error: function(xhr,error) {
                    }
                });

                
            },
            error: function(xhr,error) {
            }
        });
       
       
   }
    
    
}

{/literal}
</script>