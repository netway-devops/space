

{if $edit}
    {include file='services/domain_details.tpl'}
{else}

{php}
    $templatePath   = $this->get_template_vars('template_path');
    include($templatePath . 'services/domains.tpl.php');
{/php}

{literal}
<style>
.text-block .search-field {
    font-size: 15px;
    width: 165px;
    height: 22px;
    border-radius: 9px;
 
}
.text-block .input-bg {
    width: 227px;
    height: 34px;
    margin-bottom: 0px;
}
.table-header{
    height: 79px;   
}
.table-header-high th{
    font-size:14px;
}
.btnAdd{
    background-color: #fc821a;
    border: 2px solid #fc4a1a;
    display: inline-block;
    color: #fff;
    font-style: normal;
    font-size: 14px;
    padding: 5px 6px;
    text-decoration: none;
    margin-top: 0px;
    font-weight: 600;
}
.btnAdd:hover{
    background: #fc4a1a;  
    background: -webkit-linear-gradient(to right, #f7b733, #fc4a1a); 
    background: linear-gradient(to right, #f7b733, #fc4a1a); 
    border: 2px solid linear-gradient(to right, #f7b733, #fc4a1a);
  
}
.btnSet{
    background-color: #e6e6e6;
    border: 1px solid #a9aaad;
    display: inline-block;
    color: #fff;
    font-style: normal;
    font-size: 14px;
    padding: 5px 20px;
    text-decoration: none;
    margin-top: 0px;
    font-weight: 600;
    border-radius: 3px ;
}
.btnSet:hover{
    border: 1px solid #14509c;
}
</style>
{/literal}

    <div class="text-block clear clearfix" style="padding:17px 35px 17px 35px;">
      
            <h3 class=" g-txt32 re-topic"style="text-align: center;">{$lang.domains|capitalize} </h3>
            <center><span class="nw-2018-content-line" style="margin-bottom: 5px;"></span> </center> 
         
        <!-- <div class="pull-right">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="{$ca_url}clientarea/domains&filter[domain]=active" title="Active / Pending / Transfering"> <i class="icon-chevron-right"></i> Only active</a>
            &nbsp;&nbsp;&nbsp;
            <a href="{$ca_url}clientarea/domains&filter[domain]=all" title="Expired, Cancelled, Transferred away"> <i class="icon-chevron-right"></i> All status</a>
        </div> -->
        
        {if $domains || $currentfilter}

{* start puny code *}
<script src="{$system_url}includes/modules/Other/netway_common/public_html/js/domain/punycode.js"></script>
{literal}
    <script type="text/javascript">
        $(document).ready(function(){
            $('.search-field').keypress(function(e){
               if( e.which == 13 ){ 
                    $("#s_filter").click();
                    return false;
               }
             
            });    
        });  

      var searchDomain = '';
      
       function searchPuny() {      
        searchDomain = $('.search-field').val();
        if (searchDomain != '') {
            
            aSplit = searchDomain.split(".");
            sld = aSplit[0];
            
            if (sld.match(/^[a-z0-9-]+$/gi)) {
            } else {
                $('.search-field').val('xn--' + punycode.encode(searchDomain));
            }
        }
        
    }

    // Puttipong Pengprakhon
    function decodePuny(id, domainName) {
        if (domainName != '') {
            aSplit = domainName.split(".");
            sld = aSplit[0];
            aSplit.shift();
            tld = aSplit.join('.');
            
            if (sld.match(/^xn--/gi)) {
                $('#' + id).html('(' + punycode.decode(sld.substring(4)) + '.' + tld + ')');
            }
        }
        $('.search-field').val();
    }
    
       
    

    
    </script>
  <!-- <script>
  
    $(document).ready(function(){
    $("#statusAll").hide();
     var url_string = window.location.href; 
     var valUrl = url_string.substring(url_string.indexOf('=')+1);
     if(valUrl == 'active'){
        $("#statusAll").show();
        $("#statusOnly").hide();
     }
     if(valUrl == 'all'){
        $("#statusAll").hide();
        $("#statusOnly").show();
     }    
       
        
    });
    
</script> -->
{/literal}
{* end puny code *}                  
        
            <div class="input-bg pull-right search-shadow">
                <form style="margin:0px" id="testform" href="{$ca_url}clientarea/domains/" method="post">
                    <input type="text" class="search-field" name="filter[name]" value="{$currentfilter.name}" placeholder="{$lang.filterdomains}" id="d_filter"  />
                    <button  class="clearstyle submiter" name="resetfilter=1" id="r_filter"  onclick="$('#d_filter').val(''); $('#r_filter').hide();$('#s_filter').show();" style="display:none;">
                        <i class="icon-remove-sign"></i>
                    </button>               
                    <button onclick="searchPuny(); $('#r_filter').show();$('#s_filter').hide();" id="s_filter" class="submiter clearstyle">
                        <i class="icon-search"></i>
                    </button>
                </form>
            </div>
        {/if}
        {if $domains}
            <div class="clear clearfix"  style="padding: 20px 0px 0px 0px;">
                <div class="table-box">
                    <div class="table-header">
                        <p class="inline-block"style="padding: 15px 0px 0px 0px;"><i class="icon-select-all"></i> {$lang.withdomains} </p>
                        <div class="tooltip-group">
                            <a href="{$ca_url}clientarea/domains/renew/" title="{$lang.renew_widget}" class="clearstyle" onclick="return bulk_widget(this)">
                                <!-- <i class="icon-bag"></i> -->
                                <button class="btnAdd" type="submit"><i class="fa fa-plus-circle"></i>&nbsp;Add Year / <i class="fa fa-refresh "></i> Renew</button>
                            </a>
                            {if $domwidgets}
                                {foreach from=$domwidgets item=widg}
                                    
                                    {if $widg.widget == 'nameservers' || $widg.widget == 'contactinfo'}
                                        {continue}
                                    {/if}
                                    
                                    {assign var=widg_name value="`$widg.name`_widget"}

                                    <a href="{$ca_url}clientarea/domains/bulkdomains/&widget={$widg.widget}" title="{*
                                      *} {if $lang[$widg_name]}{*
                                          *} {$lang[$widg_name]}{*
                                       *}{elseif $lang[$widg.widget]}{*
                                           *}{$lang[$widg.widget]}{*
                                      *}{else}{*
                                           *}{$widg.name}{*
                                       *}{/if}" 
                                       class="clearstyle btn domain-header-icon" onclick="return bulk_widget(this)">
                                        <img alt="{$widg.name}" src="{$system_url}{$widg.config.smallimg}" />
                                    </a>
                                {/foreach} 
                            {/if}

                            <!--                        <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-contacts"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-forward"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-cycle"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-lock"></i></a>
                                                    <a href="#" title="Contact Information" class="clearstyle btn domain-header-icon"><i class="icon-address"></i></a>-->
                        </div>
                    </div>
                    <a href="{$ca_url}clientarea&amp;action=domains{$filterDomain}" id="currentlist" style="display:none" updater="#updater"></a>
                    <table class="table table-striped table-hover">
                        <tr class="table-header-high">
                            <th><input type="checkbox" onclick="c_all(this)" title="Select All"/></th>
                            <th class="w35">
                                <a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=name|ASC">{$lang.domain}                             
                                </a>
                            </th>
                            <th class="w15">
                                <a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=date_created|ASC">{$lang.registrationdate}
                                </a>
                            </th>
                            <th class="w15 cell-border">
                                <a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=expires|ASC">{$lang.expirydate}
                                </a>
                            </th>
                            <th class="w20 cell-border">
                                <a class="sortorder" href="{$ca_url}clientarea/domains/&amp;orderby=expires|ASC">{$lang.status}
                                </a>
                               <!-- <div class="pull-right">
                                  <a href="{$ca_url}clientarea/domains&filter[domain]=active" title="Active / Pending / Transfering">
                                      <button class="clearstyle green-custom-btn l-btn " id="statusOnly" style="border-radius: 4px;font-size: 14px !important;">
                                        <i class="fa fa-eye"></i>&nbsp;Only active
                                       </button>
                                 </a>
                                 <a href="{$ca_url}clientarea/domains&filter[domain]=all" title="Expired, Cancelled, Transferred away">
                                     <button class="clearstyle green-custom-btn l-btn " id="statusAll" style="border-radius: 4px;font-size: 14px !important;">
                                        <i class="fa fa-eye"></i>&nbsp;All status
                                     </button>
                                </a>
                              </div> -->
                           </th>
                            {*<th class="w15 cell-border">{$lang.autorenew}</th>*}
                            <th class="w10 cell-border"style="padding-left: 20px;">Setting</th>
                        </tr>
                        <tr class="table-header-row" id="selectedDomainItems" style="display:none;">
                            <th colspan="6">รายการที่เลือก</th>
                        </tr>
                        <tr id="selectedDomainEnd" style="display:none;">

                            <th colspan="6"></th>
                        </tr>
                        <tbody id="updater">

                            {include file='ajax/ajax.domains.tpl'}

                        </tbody>
                    </table>
                </div>
                <div class="top-btm-padding">
                    {if $lang.add_domain}
                        <form method="post" action="{$ca_url}domain-order" style="display:inline-block">
                            <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-white-add"></i> {$lang.add_domain}</button>
                            {securitytoken}
                        </form>
                    {/if}
                    {if $totalpages}
                        <div class="pagination pagination-box">
                            <div class="right p19 pt0 no-margin">
                                <div class="pagelabel left ">{$lang.page}</div>
                                <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
                                    {section name=foo loop=$totalpages}
                                        <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
                                    {/section}
                                </div>
                                <input type="hidden" id="currentpage" value="0" />
                            </div>
                        </div>
                    {/if}
                </div>
            {else}
                {$lang.nothing}
                {if $lang.add_domain}
                    <form method="post" action="{$ca_url}domain-order">
                        <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.add_domain}</button>
                        {securitytoken}
                    </form>
                {/if}
            {/if}
        </div>
    </div>
{/if}
<script type="text/javascript" src="{$template_dir}js/domains.js"></script>
