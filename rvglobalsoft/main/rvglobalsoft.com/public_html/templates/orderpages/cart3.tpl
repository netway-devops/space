{php}
    $templatePath = $this->get_template_vars('template_path');
    require_once(dirname($templatePath) . '/orderpages/order_coupon.tpl.php');
    require_once(dirname($templatePath) . '/orderpages/cart3.tpl.php');
{/php}

{if $product.id == '108'}
<script type="text/javascript" src="{$orderpage_dir}cart_license/js/cart.js?step={$step}"></script>
<script type="text/javascript">
var caUrl       = '{$ca_url}';
var systemUrl   = '{$system_url}';
</script>
{/if}


<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
{literal}
    <script type="text/javascript">
        function changeCycle(forms) {
            $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
            return true;
        }
        
        if("{/literal}{$smarty.session.ADD_LOADER_CART_SSL}{literal}" == "TRUE"){
            $('.container-bg').addLoader();    
        }
        
        function verifyDomain() {
        
             $.post('?cmd=serviceshandle&action=verifyDomain',{
                 hostname: jQuery("#domain").val()
             },function(data) {
                 // CALL BACK
                 data = jQuery.parseJSON(data);
        
                 if (data.ERROR != "" || data.ERROR != null || data.ERROR != undefined) {
                     jQuery("#rv-site-error-domain").html(data.ERROR);
                 } else {
                     jQuery("#rv-site-error-domain").html("");         
                 }
                 
             });
             
        }

    </script>
{/literal}
<div class="default-cart">
    
     <!-- start rv modify for : product license -->
    <div class="wbox" style="display:none;" id="div_addinfo_Recommend">
        <div class="wbox_header" style="color:red;">
            <strong>Sorry, cannot order cPanel/WHM license for <span id="txtip"></span>.</strong>
        </div>
        <div class="wbox_content" id="addinfo_Recommend">
        It has been licensed by other license provider. If you want to move the license provider to us, <br />
        make a request for dedicated server 
        <a href="javascript:void(0);" onclick="submit_change_product('dedicated')">Click here</a> 
        and VPS server 
        <a href="javascript:void(0);" onclick="submit_change_product('vps')">Click here</a>.
    <br /><br />
        NOTE: Your server will not be affected while changing license provider. This process is only change the biller.
        <!--<a href="javascript:void(0);" onclick="submit_change_product('dedicated')">link product cpanel license dedicate transfer</a><br />
        <a href="javascript:void(0);" onclick="submit_change_product('vps')">link product cpanel license VPS transfer</a><br />
        -->
        </div>
    </div>
    <!-- end rv modify for : product license -->
    
    <form action="" method="post" id="cart3"  {if $product.id == '108'} onsubmit="return false;" {/if} >
        {if $product.description!='' || $product.paytype=='Once' || $product.paytype=='Free'}
            <div class="wbox">
                <div class="wbox_header">
                    <strong>{$product.name}</strong>
                </div>
                <div class="wbox_content" id="product_description">

                    {$product.description}

                    {if $product.paytype=='Free'}<br />
                        <input type="hidden" name="cycle" value="Free" />
                        {$lang.price} <strong>{$lang.free}</strong>

                    {elseif $product.paytype=='Once'}<br />
                        <input type="hidden" name="cycle" value="Once" />
                        {price product=$product}
                        {$lang.price}  <strong>@@price</strong> {$lang.once} @@setupline<<' + '@
                        {/price}
                    {/if}

                </div>
            </div>
        {/if}



        {if   $product.type=='Dedicated' || $product.type=='Server' || $product.hostname || $custom || ($product.paytype!='Once' && $product.paytype!='Free')}

            <div class="wbox">
                <div class="wbox_header">
                    <strong>{$lang.config_options}</strong>
                </div>
                <div class="wbox_content">

                    {if $product.paytype!='Once' && $product.paytype!='Free'}

                        <div class="cart-item cart-cycle">
                            <div class="pb10"  width="175">
                                <strong>{$lang.pickcycle}</strong>
                            </div>
                            <div class="pb10">
                                <select id = "selectcycle" name="cycle"   onchange="{if $custom}changeCycle('#cart3');{else}simulateCart('#cart3');{/if}" style="width:99%">
                                    {price product=$product}
                                    <option value="@@cycle" @@selected>@@line</option>
                                    {/price}
                                </select>
                            </div>
                            
                            {php}   
                            order_coupon::singleton()->displayCoupon(3);
                            {/php}  
                            
                        </div>

                    {/if}

                    {if $product.hostname}
                        <div class="cart-item cart-hostname">
                            <div class="pb10" width="175">
                                <strong>{$lang.hostname}</strong> *
                            </div>
                            <div class="pb10">
                                <span id="rv-site-error-domain" class="alert-error"></span>
                                <input id="domain" name="domain" type="text" value="{$item.domain}" 
                                       onchange="verifyDomain();"
                                       class="styled" size="50" style="width:96%"/>
                            </div>  
                        </div>
                    {/if}

                    {if $custom} 
                        <input type="hidden" name="custom[-1]" value="dummy" />
                        {foreach from=$custom item=cf} 
                            {if $cf.items}

                              <!-- start rv for product transfer -->
                              {if $cf.variable eq 'rv_dummy'}
                                   <div colspan="2" style="display:none;">
                                       
                                   </div>
                              {elseif $cf.variable eq 'qty_rvskin'}
                                  <div colspan="2" class="{$cf.key} cf_option"><label for="custom[{$cf.id}]" class="styled">
                                  <input type="checkbox" class="pconfig_ styled" onclick="rv_runcal($(this));" value="1" name="{$cf.name}" id="chkboxrvskin"tagtype="rvskin">
                                  {$cf.name} {if $cf.options & 1}*{/if}</label>{if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>{/if}
                                  </div>
                              {elseif $cf.variable eq 'qty_rvsitebuilder'}
                                  <div colspan="2" class="{$cf.key} cf_option"><label for="custom[{$cf.id}]" class="styled">
                                  <input type="checkbox" class="pconfig_ styled" onclick="rv_runcal($(this));" value="1" name="{$cf.name}"  id="chkboxrvsitebuilder"tagtype="rvsitebuilder">
                                  {$cf.name} {if $cf.options & 1}*{/if}</label>{if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>{/if}
                             
                                  </div>
                             {else}

                                <div class="cart-form cart-item {if $cf.key|strstr:'cf_'}{$cf.key} cf_option{/if}">
                                    <label for="custom[{$cf.id}]" class="styled">
                                        {$cf.name} {if $cf.options & 1}*{/if}
                                    </label>
                                    {if $cf.description!=''}
                                        <div class="fs11 descr" style="">{$cf.description}</div>
                                    {/if}

                                    {include file=$cf.configtemplates.cart}
                                </div>
                            
                            {/if}
                            
                            {/if}
                        {/foreach}

                    {/if}


                    <small>{$lang.field_marked_required}</small>

                </div>
            </div>
        {/if}


        {if $subproducts}
            <div class="wbox">
                <div class="wbox_header">
                    <strong>{$lang.additional_services}</strong>
                </div>
                <div class="wbox_content">

                    {foreach from=$subproducts item=a key=k}
                        <div class="cart-item cart-subproduct">
                            <div class="checkbox">
                                <input name="subproducts[{$k}]" type="checkbox" value="1" 
                                       id="subproducts{$k}"
                                       {if $selected_subproducts.$k}checked="checked"{/if}  
                                       onchange="simulateCart('#cart3');"/>
                                <label for="subproducts{$k}">{$a.category_name} - {$a.name}</label>
                            </div>
                            <div class="cart-item-price">
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    {$lang.free}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
                                    @@line
                                {else}
                                
                                    {if $cycle=='h'} {$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='d'} {$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='w'}{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='m'}{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='q'}{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='s'}{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='a'}{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='b'} {$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='t'} {$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='p4'} {$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                    {if $cycle=='p5'}{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}{/if}
                                
                                    <select name="subproducts_cycles[{$k}]"  
                                            style="display:none;"
                                            onchange="if ($('input[name=\'subproducts[{$k}]\']').is(':checked'))
                                                        simulateCart('#cart3');">
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                            </div>
                        </div>

                    {/foreach}

                </div>
            </div>
        {/if}

        {if $addons}
            <div class="wbox">
                <div class="wbox_header">
                    <strong>{$lang.addons_single}</strong>
                </div>
                <div class="wbox_content">
                    <p>{$lang.addons_single_desc}</p>


                    {foreach from=$addons item=a key=k}
                        <div class="cart-item cart-addon">
                            <div class="checkbox">
                                
                                {if $a.name == 'Free Monitoring'}
                                    <input name="addon[{$k}]" type="checkbox" value="1" checked="checked" onchange="simulateCart('#cart3');"/>
                                    {literal}
                                        <script type="text/javascript">
                                        $(document).ready(function () {
                                            simulateCart('#cart3');
                                        });
                                        </script>
                                    {/literal}
                                {else}
                                
                                <input name="addon[{$k}]" type="checkbox" value="1" 
                                       id="addon{$k}"
                                       {if $selected_addons.$k}checked="checked"{/if}  
                                       onchange="simulateCart('#cart3');"/>
                                
                                {/if}
                                
                                <label for="addon{$k}">{$a.name}</label>
                            </div>
                            {if $a.description!=''}
                                <div class="cart-item-description">
                                    {$a.description}
                                </div>
                            {/if}
                            <div class="cart-item-price">
                                {price product=$a}
                                {if $a.paytype=='Free'}
                                    {$lang.free}
                                    <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                                {elseif $a.paytype=='Once'}
                                    <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                                    @@line
                                {else}
                                    <select name="addon_cycles[{$k}]"   onchange="if ($('input[name=\'addon[{$k}]\']').is(':checked'))
                                                simulateCart('#cart3');">
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/if}
                                {/price}
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}

        <input name='action' value='addconfig' type='hidden' />

        <div class="orderbox">
            <div class="orderboxpadding">
                <center>
                    <input type="submit" value="{$lang.continue}" 
                           style="font-weight:bold;font-size:12px;"  
                           class="padded btn  btn-primary"/>
                </center>
            </div>
        </div>
        
        <input type="hidden" name="tagproductname" value="{$product.name}" id="tagproductname" />
        
    </form>
</div>


<!-- start rv function check license -->

<form id="rv_product_transfer" name="rv_product_transfer" action="index.php?/cart" method="post">
    <input name="action" type="hidden" value="add">
    <input name="id" type="hidden" value="">
    <input name="dedicated_id" id="dedicated_id" type="hidden" value="">
    <input name="vps_id" id="vps_id" type="hidden" value="">
    <input name="cycle" type="hidden" value="{$cycle}">
</form> 
{php}
    require_once(dirname($templatePath) . '/orderpages/order_ccycle.tpl.php');
{/php}

<script type="text/javascript">
{literal}
function submit_change_product(itype){
    if (itype == 'dedicated') {
        $('#rv_product_transfer').find('input[name="id"]').val($('#dedicated_id').val()); 
    } else {
        $('#rv_product_transfer').find('input[name="id"]').val($('#vps_id').val());
    }
    $('#rv_product_transfer').submit();
}

function verify_product_license(){ 
     var valueIp = $('form#cart3').find('input[type="text"]').val();
     if (valueIp =='' || valueIp == 'n/a' || valueIp == 'n/a.'|| valueIp == 'N/A'|| valueIp == 'N/A.') {
        $('#cart3').submit();
     } else {
        $('.orderbox').addLoader();
        //$.post("?cmd=rv_verifylicense&action=verify_cpanel_license", $('form#cart3').serialize(),
        $.post("?cmd=rvproduct_license&action=verify_license", $('form#cart3').find('input[name*="custom"],input[name*="subproducts"],input[name*="tagproductname"]').serialize(),
            function(data) {
                //=== เป็น product license ที่มี ip
                var datares = data.aResponse;
              ///datares.status_product_license = true;
              //  datares.res = false;
                if (datares.isnotfraud == false){
                            $('#preloader').remove();
                            $('.alert-error').show().append("<span>Your IP can't order. Any help and support? Please submit a ticket <a href=\"https://rvglobalsoft.com/tickets/new&deptId=2/tickets/new&deptId=2\" target=\"_blank\">here</a>.</span>");
                }else{
                    if (datares.status_product_license == true) {
                        $('#status_product_license').val('yes');
                        if (datares.res == true) {
                            //=== ip นี้ใช้ได้ ยังไม่เคยจด license
                            $('#cart3').submit();
                        } else {
                            if (datares.formatip == false) {
                                $('#preloader').remove();
                                $('.alert-error').show().append('<span>Field "IP Address" format invalid</span>');
                            } else if (datares.res  == false){
                                var msg = '';
                                for(var k in datares.main){
                                    if (k== 'msg' || k== 'message') {
                                        msg = msg + datares.main[k] + "<br />";
                                    }else{
                                        continue;
                                    }
                                    //alert(k + " = " + datares.main[k]);
                                }
                                if (datares.main.product_dedicated_id) {
                                    $('#txtip').html($('form#cart3').find('input[type="text"]').val());
                                    $('#div_addinfo_Recommend').show();
                                    $('#rv_product_transfer').find('input[name="dedicated_id"]').val(datares.product_dedicated_id);
                                    $('#rv_product_transfer').find('input[name="vps_id"]').val(datares.product_vps_id);
                                }
                                for(var k in datares.sub){
                                    if (datares.sub[k].res == false) {
                                        for (var d in datares.sub[k]) {
                                            if (d == 'msg' || d== 'message') {
                                                msg = msg + datares.sub[k][d] + "<br />"
                                                $('form#cart3').find('input[name="subproducts['+k+']"]').attr('checked',false);
                                                //alert(k + " = " + datares.main[k]);
                                            } else continue;
                                        }
                                    } else {
                                        continue;
                                    }
                                }
                                msg+='<br><a href="tickets/new/" target="_blank" >Open New Support Ticket</a>';
                                if ($('.alert-error').find('#rvmsg').get(0)) {
                                    $('#rvmsg').html(msg);
                                } else {
                                    $('.alert-error').show().append('<span id="rvmsg">'+msg+'</span>');
                                }
                                $('#preloader').remove();
                                simulateCart('#cart3');
                            }
                        }
                    } else {
                        // เป็น product อื่นๆ ก็ปล่อยให้ทำงานตามปกติ
                        $('#cart3').submit();
                    }
                }
        });
    }
}


    $('#rv_main_qty').keyup(function(){
        $('input[type="checkbox"]').each(function(){
           rv_runcal($(this));
        
        });
    });

    function rv_runcal(obj){
         var chkCheck = obj.is(':checked');
         var itype = obj.attr('tagtype');
         var getMainVal = 0;
          if (obj.is(':checked') == true) {
            getMainVal = $('#rv_main_qty').val();
          } else {
            getMainVal = 0;
          }
          $('#rv_qty_'+itype).val(getMainVal);
          $('#rv_qty_'+itype).trigger('onkeyup');         
         

     }
    var productname = $('#tagproductname').val();
    //var isProductCpanel=productname.match(/Cpanel License/gi); 

    var isProductLicense=productname.match(/(Cpanel License|RVSiteBuilder|RVSkin leased|RVLogin)/gi);
    //alert(isProductLicense);
    if (isProductLicense) {
        $('#product_cpanel_yes').show();
        $('#product_cpanel_no').hide();
        rv_runcal($('#chkboxrvsitebuilder'));
        rv_runcal($('#chkboxrvskin'));
    } 
    var isProductTransfer = productname.match(/License Transfer/gi); 
    if (isProductTransfer) {
        rv_runcal($('#chkboxrvsitebuilder'));
        rv_runcal($('#chkboxrvskin'));
    } 

    var cartItem = {/literal}{$cartItems}{literal};
    var havelicense    = '{/literal}{$havelicence}{literal}';
    if(cartItem > 0 && havelicense == '1' ){
        
        $(".pb10").hide();
        if($('#selectcycle').val() != '{/literal}{$recurr}{literal}'){
            $('#selectcycle').val('{/literal}{$recurr}{literal}');
            {/literal}
            {if $custom}
                {literal}
                    changeCycle('#cart3');
                {/literal}
            {else}
                {literal}
                    simulateCart('#cart3');
                {/literal}
            {/if}
            {literal}
        }
    }
    
    
    var productID = '{/literal}{$item.id}{literal}';
    if(productID == 58){
        $('#cart3').submit(function(){
            var url = '{/literal}{$system_url}{literal}index.php?cmd=order2factorhb&action=checkLogIn';
            window.location.assign(url);
            return false;
        });
    }
    else if(productID == 59){
        var status = '{/literal}{php}echo $_REQUEST["status"];{/php}{literal}';
        var have2Fa = '{/literal}{$have2Fa}{literal}';
        if(status == 'Terminated'){
            var error = '';

                error    += 'Your account had used RV2Factor before, and the account was terminated (ended without ';
                error    += 'renewal) already. If you want to use RV2Factor to secure your server again. Please make a new order as a Paid Account here. <br><br>';
                error    += 'Or contact to <a href="https://rvglobalsoft.com/tickets/new/" >RVGlobalsoft staff</a>';
                error    += ' for RV2Factor free-trial request.';
     
            
            $('.alert-error').append(error);
            $('.alert-error').show();
            $('#sidemenu').hide();
            $('#cont').removeAttr('id');
            $('.left').css('width','100%');
        }else if(status == 'Suspended' || status == 'Expired'){
            $('#sidemenu').hide();
            $('#cont').removeAttr('id');
            $('.left').css('width','100%');
        }else{
            if(have2Fa == 1){
                var url = '{/literal}{$system_url}{literal}clientarea/services/rv2factor/';
                window.location.assign(url);
            }
             var error = '';
             error    += 'You can define the quantity for RV2Factor Account in this upgrade to paid account only. Please specify the quantity you need, and continue the upgrade to paid account.';
             
             $('.alert-error').append(error);
             $('.alert-error').show();
        
             $('#sidemenu').hide();
             $('#cont').removeAttr('id');
             $('.left').css('width','100%');
        }
        $('#product_cpanel_no').click(function(){
            var url = '{/literal}{$system_url}{literal}index.php?cmd=order2factorhb&action=checkLogInPaidProduct&cycle='+$("#selectcycle option:selected").attr('value')+'&qty='+$('#custom_field_13').val();
            window.location.assign(url);
            return false;
        });

    }
{/literal} 
</script>

<!-- end rv function check license -->

