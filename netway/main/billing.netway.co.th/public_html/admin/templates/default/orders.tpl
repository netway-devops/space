{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'orders.tpl.php');
{/php}

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.Orders}</h3></td>
    <td  class="searchbox"><div id="hider2" style="text-align:right">
        <a href="?cmd=orders&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=orders&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        
      </div>
      <div id="hider" style="display:none"></div></td>
  </tr>
  <tr>
  
  <td class="leftNav">
      <a href="?cmd=orders&action=createdraft"  class="tstyled btn btn-success"><strong>{$lang.createorder}</strong></a><br>

      <a href="?cmd=orders&list=all"  class="tstyled {if $action == 'default' && ($currentlist=='all' || !$currentlist)}selected{/if}">{$lang.allorders} <span>({$stats.All})</span></a>
      <a href="?cmd=orders&list=active" class="tstyled {if $action == 'default' && $currentlist=='active'}selected{/if}">{$lang.activeorders} <span>({$stats.Active})</span></a>
      <a href="?cmd=orders&list=cancelled" class="tstyled {if $action == 'default' && $currentlist=='cancelled'}selected{/if}">{$lang.cancelledorders} <span>({$stats.Cancelled})</span></a>
      <a href="?cmd=orders&list=pending" class="tstyled {if $action == 'default' && $currentlist=='pending'}selected{/if}">{$lang.pendingorders} <span>({$stats.Pending})</span></a>
      <a href="?cmd=orders&list=fraud" class="tstyled {if $action == 'default' && $currentlist=='fraud'}selected{/if}">{$lang.fraudorders} <span>({$stats.Fraud})</span></a>
      {if $canreview}
          <a href="?cmd=orders&list=review" class="tstyled {if $action == 'default' && $currentlist=='review'}selected{/if}">{$lang.pendingReview} <span>({$stats.Review})</span></a>
      {/if}
      <a href="?cmd=orders&action=draft" class="tstyled {if $action=='draft' || $action== 'createdraft'}selected{/if}">{$lang.Draft} <span>({$stats.Draft})</span></a>
      <br>
      <td  valign="top"  class="bordered">
  <div id="bodycont"> 
  
  
  {if $action=='edit' && $details}
   
   {include file='orders/edit.tpl'}
   
    {elseif $action=='add'}
        {include file='orders/add.tpl'}
    {elseif $action=='createdraft'}
   {include file='orders/add.tpl'}

    {elseif $action=="draft"}
        <form action="" method="post" id="testform" >
            <input type="hidden" value="{$totalpages}" name="totalpages" id="totalpages"/>
            <div class="blu">
                <div class="right"><div class="pagination"></div></div>
                <div class="left menubar">
                    {$lang.withselected}
                    <a class="submiter menuitm menu-auto" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.generatefromdrafts}</span></a>        
                    <a class="submiter menuitm confirm menu-auto" name="delete" ><span style="color:red">{$lang.Delete}</span></a>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=orders&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"/></th>
                        <th><a href="?cmd=orders&action=draft&orderby=id|ASC" class="sortorder">ID</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=date_created|ASC"  class="sortorder">{$lang.Date}</a></th>
                        {if $admindata.access.viewOrdersPrices}
                            <th><a href="?cmd=orders&action=draft&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                        {/if}
                        <th><a href="?cmd=orders&action=draft&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=estimate_id|ASC"  class="sortorder">{$lang.estimate_id}</a></th>
                        <th width="20"></th>
                    </tr>
                </tbody>
                <tbody id="updater">
                    {include file='ajax.orders.tpl'}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th></th>
                        <th colspan="9">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        </th>
                    </tr>
                </tbody>
            </table>
        </form>
        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="left menubar">
                {$lang.withselected}                    
                <a class="submiter menuitm menu-auto" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.generatefromdrafts}</span></a>           
                <a class="submiter menuitm confirm menu-auto" name="delete" href="#"  ><span style="color:red">{$lang.Delete}</span></a>
            </div>
            <div class="clear"></div> 
        </div> 
    {else}
        <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right"><div class="pagination"></div></div>
                <div class="left menubar">
                    {$lang.withselected}
                    <a class="submiter menuitm menu-auto" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.Accept}</span></a>
                    <a class="submiter menuitm menu-auto" name="markpending" {if $enablequeue}queue='push'{/if} href="#" ><span >{$lang.setpending}</span></a>
                    <a {if $enablequeue}queue='push'{/if}  class="submiter menuitm menu-auto" name="markcancelled"  href="#" ><span >{$lang.Cancel}</span></a>
                    
                    <span class="menu-auto-reset"></span>
                    {if !$forbidAccess.deleteOrders}
                        <a class="menuitm menu-auto" name="delete" href="#"  onclick="confirm1(); return false;" ><span style="color:red">{$lang.Delete}</span></a>
                    {/if}
                    <a class="menuitm setStatus menu-auto" id="hd1" onclick="return false;" href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=orders&list={$currentlist}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"/></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=id|ASC" class="sortorder">ID</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=number|ASC" class="sortorder">{$lang.orderhash}</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=date_created|ASC"  class="sortorder">{$lang.Date}</a></th>
                        {if $admindata.access.viewOrdersPrices}
                            <th><a href="?cmd=orders&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                        {/if}
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                        <th>{$lang.paymentstatus}</th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                        <th width="20"></th>
                    </tr>
                </tbody>
                <tbody id="updater">
                    {include file='ajax.orders.tpl'}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th></th>
                        <th colspan="9">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        
                        </th>
                    </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right"><div class="pagination"></div></div>
                <div class="left menubar">
                    {$lang.withselected}
                                
                    <a class="submiter menuitm menu-auto" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.Accept}</span></a>
                    <a class="submiter menuitm menu-auto" name="markpending" {if $enablequeue}queue='push'{/if} href="#" ><span >{$lang.setpending}</span></a>
                    <a {if $enablequeue}queue='push'{/if}  class="submiter menuitm menu-auto" name="markcancelled"  href="#" ><span >{$lang.Cancel}</span></a>
                    
                    <span class="menu-auto-reset"></span>
                    {if !$forbidAccess.deleteOrders}
                        <a class="menuitm menu-auto" name="delete" href="#"  onclick="confirm1(); return false;" >
                            <span style="color:red">{$lang.Delete}</span>
                        </a>
                    {/if}
                    <a class="menuitm setStatus menu-auto" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                    
                    <input type="submit"   class="submiter" name="markfraud" value="{$lang.setasfraud}" {if $enablequeue}queue='push'{/if} style="display:none" id="markasfraud1"/>
                    <ul id="hd1_m" class="ddmenu">
                        <li ><a href="#" onclick="return send_msg('orders')">{$lang.SendMessage}</a></li>
                        <li  ><a href="MarkFraud" onclick="$('#markasfraud1').click();">{$lang.setasfraud}</a></li>
                    </ul>
                                
                </div>
                <div class="clear"></div>
                {securitytoken}
        </form>

      <div id="confirm_ord_delete" hidden bootbox data-title="{$lang.orddelheading}" data-btnclass="btn-danger" data-callback="confirmsubmit2" >
          <form action="?cmd=orders&delete=delete" method="post">
              <p><strong>{$lang.orddeldescr}</strong></p>

              <input type="radio" checked="checked" name="harddelete" value="true" class="cc_hard"/> <span> {$lang.deleteopt1}</span><br />
              <input type="radio"  name="harddelete" value="false" /> <span> {$lang.deleteopt2}</span><br />
              {securitytoken}

          </form>
      </div>


            <script type="text/javascript">
            {literal}
                var delete_cb = null;
                function confirm1() {
                    if ($("#testform input[class=check]:checked").length < 1){
                        return false;
                    }
                    delete_cb = function (hard) {
                        ajax_update('?cmd=orders&delete=delete&' + $.param($("#testform input[class=check]:checked")) + hard, {stack: 'push'});
                    };
                    $('#confirm_ord_delete').trigger('show');
                    return false;
                }

                function confirm2(el) {
                    delete_cb = function(hard){
                        window.location = el.getAttribute('href') + hard;
                    };
                    $('#confirm_ord_delete').trigger('show');
                    return false;
                }

                function confirmsubmit2() {
                    delete_cb('&harddelete=' + ($('.bootbox-body input.cc_hard').is(':checked') ? 'true' : 'false'));
                    delete_cb = null;
                    bootbox.hideAll();
                    return false;
                }

                $(function(){
                    $('.setStatus').dropdownMenu({},function(action,el,pos,valx){});
                    $('body').bootboxform();
                });
            {/literal}
            </script>
    {/if}
  </td>
  </tr>
</table>
