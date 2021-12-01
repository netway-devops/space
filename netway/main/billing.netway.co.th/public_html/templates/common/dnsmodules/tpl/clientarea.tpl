<link media="all" type="text/css" rel="stylesheet" href="{$type_dir}style.css" />

{if $act=='dns_manage' || $act=='add_record' || $act=='edit_record'}
    <script type="text/javascript">
        var types = {$record_types_json};
    </script>
{/if}

{if $act=='add_domain'}
    
    {literal}
        <script type="text/javascript">
        
        function sh_option(val)  {
            $('.sh_option').hide();
            $('#option_'+val).show();
        }
            
        </script>
    {/literal}
    <form action="{$service_url}&act=add_domain" method="POST">
        <div class="wbox"><div class="wbox_header"><strong>{$lang.addzone}</strong></div>
            <div class="wbox_content">
                <table width="98%" cellspacing="0" border="0" class="checker">
                    <tr>
                        <td width="145"><b>{$lang.domain}:</b></td>
                        <td><input type="text" name="domain" value="" class="styled" style="font-size:16px"/></td>
                        <td style="color:#808080">{$lang.enter_domain_name} 'example.com'</td>
                    </tr>
                    {if $require_ip}
                        <tr>
                            <td width="145"><b>{$lang.ipadd}</b></td>
                            <td><input type="text" name="ipaddress" value="" class="styled" style="font-size:16px"/></td>
                            <td style="color:#808080"></td>
                        </tr>
                    {/if}
                    {if $user_domains || $dns_templates}
                        <tr>
                            <td>{$lang.zonecontents}</td>
                            <td colspan="2">
                                <input type="radio" checked="checked" name="postaction" value="none" onclick="sh_option(0)" id="val1" />
                                <label for="val1"> {$lang.iwillentriesmanually}
                                    <a class="vtip_description" title="{$lang.afteraddingzone}"></a>
                                </label> 
                                <br/>
                                {if $user_domains} 
                                    <input type="radio" name="postaction" value="clone"  onclick="sh_option(1)" id="val11" /> 
                                    <label for="val11">{$lang.cloneentriesfromotherdomain}  
                                        <a title="{$lang.newdomainzoneclone}" class="vtip_description"></a>
                                    </label>
                                    <br/> 
                                {/if}
                                <input type="radio" name="postaction" value="premade"  onclick="sh_option(2)"  id="val111" /> 
                                <label for="val111">{$lang.usepremadetemplate}  
                                    <a title="{$lang.usepremadednstemplatetooltip}" class="vtip_description"></a>
                                </label> 
                                <br/>
                            </td>
                        </tr>
                    {/if}
                    {if $user_domains}  <tr id="option_1" style="display:none" class="sh_option">
                            <td>{$lang.clone_zone} </td>
                            <td colspan="2">
                                <select name="clone" style="width: 180px;">
                                    {foreach from=$user_domains item=domain}
                                        <option value="{$domain.$domain_indent}">{$domain.domain}</option>
                                    {/foreach}

                                </select> 
                                <input type="checkbox" name="clonenames"  id="clonenames" value="1" checked="checked" /> 
                                <label for="clonenames">{$lang.replacerecordcontent}  
                                    <a class="vtip_description" title="{$lang.clonedzonecontdescr}" class="vtip_description"></a>
                                </label>
                            </td>
                        </tr>
                    {/if}
                    {if $dns_templates} 
                        <tr id="option_2" style="display:none" class="sh_option">
                            <td>{$lang.dnstemplate}</td>
                            <td colspan="2"><select name="dns_template" style="width: 180px;" id="dns_tpl" onchange="$('.dns_id').hide();$('#dns_id_'+$(this).val()).show();">
                                    {foreach from=$dns_templates item=template key=name}
                                        <option value="{$template[0].id}">{$template[0].template}</option>
                                    {/foreach}

                                </select> <a href="#" onclick="$('#dns_preview').show();$('#dns_id_'+$('#dns_tpl').val()).show();$(this).hide();return false">{$lang.preview}</a>
                            </td>
                        </tr>
                        <tr id="dns_preview" style="display:none">
                            <td></td>
                            <td colspan="3">
                                {foreach from=$dns_templates item=template key=tid name=floop}
                                    <div class="dns_id" id="dns_id_{$template[0].id}" style="display:none;">
                                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled table table-striped table-condensed">
                                            <thead >
                                                <tr>
                                                    <th>{$lang.name}</th>
                                                    <th>TTL</th>
                                                    <th>{$lang.priority}</th>
                                                    <th>{$lang.type}</th>
                                                    <th>{$lang.content}</th>
                                                </tr>
                                            </thead>

                                            <tbody >
                                                {foreach from=$template item=record}
                                                    <tr>
                                                        <td>{$record.name}</td>
                                                        <td>{$record.ttl}</td>
                                                        <td>{$record.priority}</td>
                                                        <td>{$record.type}</td>
                                                        <td>{$record.content}</td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td align="center" colspan="3" style="border-bottom:none">
                            <input type="submit" name="submit" class="btn btn-primary"  value="{$lang.submit}" style="padding:4px 3px;font-weight:bold;font-size:12px"/> 
                            &nbsp; {$lang.or} &nbsp; <a href="{$service_url}" class="editbtn">{$lang.cancel}
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
{elseif $act=='clone_record'}
    {literal}
        <script type="text/javascript">
            $(function() {
        
    });
        </script>
    {/literal}
    <form action="" method="POST" class="form-horizontal">
        <div class="wbox">
            <div class="wbox_header"><strong>{$lang.clone_zone}</strong></div>
            <div class="wbox_content">
                <label>{$lang.from}</label><select name="clone">
                    <option>---</option>
                    {if $user_domains}
                        {foreach from=$user_domains item=domain}
                            <option value="{$domain.$domain_indent}">{$domain.domain}</option>
                        {/foreach}
                    {/if}
                </select>
                <input type="checkbox" name="clonenames"  id="clonenames" value="1" checked="checked" /> 
                <label for="clonenames">
                    {$lang.replacerecordcontent}  
                    <a title="{$lang.clonedzonecontdescr}" class="vtip_description"></a>
                </label>
                <center>
                    <input type="submit" name="submit" class="btn btn-primary"  value="{$lang.submit}" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
                    <a href="{$service_url}">{$lang.cancel}</a>
                </center>
            </div>
        </div>
        <div class="wbox">
            <div class="wbox_header">{$lang.bulkdomains}</div>
            <div class="wbox_content">
                {foreach from=$sected_domains item=domain name=row}
                    <div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.$domain_indent}" name="dom[]" checked="checked"/> 
                        {$domain.domain}
                    </div>
                {/foreach}
                <center>
                <input type="submit" name="submit" class="btn btn-primary"  value="{$lang.shortsave}" /> &nbsp; &nbsp; 
                    <a href="{$service_url}">{$lang.cancel}</a>
                </center>
            </div> 
        </div>
    </form>
            
{elseif $act=='add_record'}
    
    {literal}
        <script type="text/javascript">
        $(function() {
            var type = $('#type').val();
            var ht, rr;
            if (types[type] !== undefined) {
                for (var i = 0; i < types[type].length; i++) {
                    rr = types[type][i];
                    ht = '<input name="content[' + i + ']" type="' + rr.type + '" class="styled" > ';
                    ht += rr.label;

                    if (rr.description){
                        ht += '<a class="vtip_description" title="' + rr.description + '"></a>';
                    }
                    ht += '<br>';

                    if (i === 0) $('#contentbox').html(ht);
                    else $('#contentbox').append(ht);
                }
            }
        });
	
        </script>
    {/literal}
    <form action="" method="POST">
        <input id="type" type="hidden" name="type" value="{$r_type}" />
        {if $domid}
            <input type="hidden" name="dom" value="{$domid}" />
        {/if}
        <div class="wbox">
            <div class="wbox_header"><strong>{$lang.addnew} '{$r_type}' {$lang.record}</strong></div>
            <div class="wbox_content">
                <div class="recordbox form-inline" style="line-height:26px">  
                    <label>{$lang.name}:</label>
                    {if $sected_domains}
                        <a href="#" class="editbtn" onclick="$('.owname').show();$(this).hide();$('input[name=\'namesover\']').val('1');return false">
                           {$lang.defaultnames}
                        </a>
                        <input type="hidden" value="0" name="namesover" >
                    {/if}
                    <input type="text" name="name" value="" class="styled {if $sected_domains}owname{/if}" />{if $r_type != 'PTR' && !$sected_domains && $domname}.{$domname}{/if}
                </div>
                <div class="recordbox">
                    <label>TTL</label>
                    <select class="styled" name="ttl" >
                        <option value="3600">1 {$lang.yhour}</option>
                        <option value="43200">12 {$lang.yhours}</option>
                        <option value="86400">24 {$lang.yhours}</option>
                        <option value="172800">48 {$lang.yhours}</option>
                    </select> <a class="vtip_description" title="{$lang.ttlfeqdescription}"></a>
                </div>
                {if $r_type == 'MX' || $r_type == 'SRV'}
                    <div class="recordbox">
                        <label>{$lang.priority}</label>
                        <input type="text" name="priority" value="0" class="styled" />
                        {if  $r_type == 'MX'}
                            <a class="vtip_description" title="{$lang.prioritysettingdesc}"></a>
                        {/if}
                    </div>
                {/if}
                <div class="recordbox">
                    <label>{$lang.content}</label>
                    <div id="contentbox">

                    </div>
                </div>
                <center>
                    <input type="submit" class="btn btn-primary" name="submit" value="{$lang.submit}" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
                    <a href="{$service_url}">{$lang.cancel}</a>
                </center>
            </div>
        </div>

        {if $sected_domains}
            <div class="wbox">
                <div class="wbox_header">{$lang.bulkdomains}</div>
                <div class="wbox_content">
                    {foreach from=$sected_domains item=domain name=row}
                        <div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.$domain_indent}" name="dom[]" checked="checked"/>
                            {$domain.domain}
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
    </form>

{elseif $act=='edit_record'}
    
    {literal}
        <script type="text/javascript">
        $(function() {
            var type = $('#type').val();
            var ht;
            if (types[type] !== undefined) {
                for (var i = 0; i < types[type].length; i++) {
                    ht = types[type][i].label;

                    if (types[type][i].description){
                        ht += '<a class="vtip_description" title="' + types[type][i].description + '"></a>';
                    }
                    $('input[name="content[' + i + ']"]').after(ht);
                }
            }
	
        });
        </script>
    {/literal}
    <form action="" method="POST">
        <input id="type" type="hidden" name="type" value="{$record.type}" />
        <input type="hidden" name="dom" value="{$domid}" />

        <div class="wbox">
            <div class="wbox_header"><strong>{$lang.editrecord}</strong></div>
            <div class="wbox_content">
                <div class="recordbox">
                    <label>{$lang.name}:</label>
                    <input type="text" name="name" value="{$record.name}" class="styled" />
                </div>
                <div class="recordbox">
                    <label>TTL</label>
                    <select class="styled" name="ttl" >
                        <option {if $record.ttl == '3600'}selected="selected"{/if} value="3600">1 {$lang.yhour}</option>
                        <option {if $record.ttl == '43200'}selected="selected"{/if}value="43200">12 {$lang.yhours}</option>
                        <option {if $record.ttl == '86400'}selected="selected"{/if} value="86400">24 {$lang.yhours}</option>
                        <option {if $record.ttl == '172800'}selected="selected"{/if} value="172800">48 {$lang.yhours}</option>
                    </select> <a class="vtip_description" title="{$lang.ttlfeqdescription}"></a>
                </div>
                {if $record.type == 'MX'}
                    <div class="recordbox">
                        <label>{$lang.priority}</label>
                        <input type="text" name="priority" value="{$record.priority}" class="styled" /> <a class="vtip_description" title="{$lang.prioritysettingdesc}"></a>
                    </div>
                {/if}
                <div class="recordbox">
                    <label>{$lang.content}</label>
                    <div id="contentbox">
                        {foreach from=$record.content item=content key=ky}
                            <input type="text" name="content[{$ky}]" class="styled" value="{$content|escape}" /> <br>
                        {/foreach}
                    </div>
                </div>
                <center>
                    <input type="submit" class="btn btn-primary" name="submit" value="{$lang.submit}" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
                    <a href="{$service_url}">{$lang.cancel}</a>
                </center>
            </div>
        </div> 
    </form>
                    
{elseif $act=='default' || !$act}
    {if $service.status=='Active'}
        {literal}
            <script type="text/javascript">
                $(function() {
                        if($('#cont').length) {
                            var ch = $('#more_list').parents('#cont').height()
                    while($('#more_list').height() > ch)
                        $('#more_list').width($('#more_list').width()+1);
                        }
			

                    $('.idchecker').click(function(){
                        if($('.idchecker:checked').length < 1)
                            unbind_ico();
                        else
                            bind_ico();
                    });
                    unbind_ico();
			
                    $(document).click(function(event) {
                        if($('#more_list:visible').length && !$(event.target).parents('#more_icon').length && !$(event.target).is('#more_icon').length ) {
                             $("#more_list").hide();
                        }
                    });
                });
                function switchRenew(el,id){
                    ajax_update("{/literal}{$service_url}{literal}",{did:id, make:'renewstate',state:$(el).hasClass('off')?1:0},function (a){
                            $(el).toggleClass('off');
                        });
                    return false;
                }
                function bind_ico(){
                    $('.icons ul a:[href]').unbind().click(function(){
                        var ids = $('.idchecker:checked').serialize();
                        if(ids=='') {
                            return false;
                        }
                        window.location = $(this).attr('href')+'&'+ids;
                        return false; 	
                    });
                    $('.icons > ul > li > a:last').unbind().click(function(){
                        $('#more_list').toggle();
                    });
                    $('.icons > ul > li').removeClass('disabled');
                }
                function unbind_ico(){
                    $('.icons > ul > li > a:last').unbind().click(function(){return false});
                    $('.icons ul a:[href]').unbind().click(function(){return false});
                    $('.icons > ul > li').addClass('disabled');
                }
            </script>
        {/literal}
        {if $widget.appendtpl}
            {include file=$widget.appendtpl}
        {/if}

        {include file='../common/dnsmodules/upgrades.tpl'}
        
        <div class="icons">
            <div class="left dwarrow">{$lang.withdomains}</div>  

            <ul class="right">
                {if $dns_templates}
                    <li class="disabled">
                        <a href="{$service_url}&act=dns_templates" >
                            <img src="{$type_dir}icons/ico-renew.png" alt="">
                            <span>{$lang.dnstemplates}</span>
                        </a>
                    </li> 
                {/if}
                <li class="disabled">
                    <a href="{$service_url}&act=add_record&type=A" >
                        <img src="{$type_dir}icons/ico_domains2.jpg" alt="">
                        <span>{$lang.addrecorda}</span>
                    </a>
                </li> 
                <li class="disabled">
                    <a href="{$service_url}&act=add_record&type=MX" >
                        <img src="{$type_dir}icons/email_foward.png" alt="">
                        <span>{$lang.addentrymx}</span>
                    </a>
                </li>
                <li class="disabled">
                    <a href="{$service_url}&act=add_record&type=CNAME" >
                        <img src="{$type_dir}icons/foward.png" alt="">
                        <span>{$lang.addaliasname}</span>
                    </a>
                </li>
                <li class="disabled">
                    <a href="{$service_url}&act=clone_record" >
                        <img src="{$type_dir}icons/ico_invoices2.jpg" alt="">
                        <span>{$lang.clonesettingsdns}</span>
                    </a>
                </li>
                <li class="disabled" id="more_icon">
                    <a>
                        <img src="{$type_dir}icons/ico_resources.png" alt="">
                        <span>{$lang.more}</span>
                    </a>
                    <ul style="display:none" id="more_list">
                        {foreach from=$supp_type item=stype}
                            {if $stype != 'MX' && $stype != 'A' && $stype != 'CNAME'}
                                <li><a href="{$service_url}&act=add_record&type={$stype}">{$lang.Add} {$stype} {$lang.record}</a></li>
                            {/if}
                        {/foreach}
                    </ul>
                </li>
            </ul>
            <div class="clear"></div>
        </div>
        <form action="" method="POST">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display">
                <thead>
                    <tr>
                        <th width="20">
                            <input type="checkbox" {literal}onclick="if(this.checked && $('.idchecker').length){ $('.idchecker').attr('checked',true); bind_ico(); }else {$('.idchecker').attr('checked',false); unbind_ico();}"{/literal} />
                        </th>
                        <th align="left">{$lang.domain}</th>
                        <th width="150">{$lang.creationdate}</th>
                        {if $metered_enable}
                            <th width="80">{$lang.price}</th>
                        {/if}
                        <th width="20"></th>
                    </tr>
                </thead>

                {if $user_domains}	
                    <tbody>
                        {foreach from=$user_domains item=domain name=row}
                            <tr {if  $smarty.foreach.row.index%2 == 0}class="even"{else}class="odd"{/if}>
                                <td width="20"><input class="idchecker" type="checkbox" onclick="" name="dom[]"  value="{$domain.$domain_indent}"/></td>
                                <td align="left"><a  href="{$service_url}&act=dns_manage&domain_id={$domain.$domain_indent}">{$domain.domain}</a></td>
                                <td>{if $domain.created}{$domain.created|dateformat:$date_format}{else}-{/if}</td>
                                {if $metered_enable}
                                    <td>{if $domain.charge}{$domain.charge|price:$domain.currency_id}{else}-{/if}</td> 
                                {/if}
                                    <!--<td><a class="autorefreash {if $domain.qty==0}off{/if}" href="#" onclick="return switchRenew(this,'{$domain.id}')" title="{$lang.autorenew}: {if $domain.qty==0}{$lang.Off}{else}{$lang.On}{/if}"></a></td>-->
                                <td><a title="{$lang.delete}" onclick="return confirm('{$lang.suretoremovedomain}');" href="{$service_url}&did={$domain.$domain_indent}&make=removedomain" class="deleteico icon-trash"> </a></td>
                            </tr>
                        {/foreach}
                    </tbody>

                    <tbody>
                        <tr>
                            <th colspan="{if $metered_enable}2{else}4{/if}" style="font-weight:normal">{$lang.domainscount}:  <b {if $dom_limit && $user_domains_cnt==$dom_limit}style="color:red"{/if}>{$user_domains_cnt}</b>{if $dom_limit!="disabled"} {$lang.maxallowed}: <b>{if $lang[$dom_limit]}{$lang[$dom_limit]}{else}{$dom_limit}{/if}</b>{/if}</th>
                            {if $metered_enable}
                                <th style="text-align:right">{$lang.total}:</th>
                                <th colspan="2" > <b>{$service.metered_total|price:$currency}</b></th>
                            {/if}
                        </tr>
                    </tbody>
                {else}
                    <tbody>
                        <tr>
                            <td colspan="{if $metered_enable}5{else}4{/if}" align="center">{$lang.nodomainsaddedyet}</td>
                        </tr>
                    </tbody>
                {/if}
            </table>
            <table border="0" width="100%">
                <tr>
                    <td >
                        {if $dom_limit && $dom_limit!='unlimited' && $dom_limit!="disabled" && $user_domains_cnt>=$dom_limit}
                            <span class="fs11" style="color:red">{$lang.youvereachedyourdomainslimit}</span>
                        {elseif $dom_limit!="disabled"}
                            <a class="btnx btn_dS fl" href="{$service_url}&act=add_domain">{$lang.adddomain}</a>
                        {/if}
                    </td>
                    <td  style="text-align: right">
                        {if $metered_enable}
                            {if $next_price} 
                                {$lang.yourcurrentpricenextdomainis} {$next_price|price:$currency}
                            {/if} 
                            <a href="#" onclick="$('#mpricing').toggle();return false">{$lang.viewpricing}</a>
                        {/if}
                    </td>
                </tr>
            </table>
        {/if}

        <div class="wbox" style="margin-top:30px;">
            <div class="wbox_header">{$lang.billing_info}</div>
            <div class="wbox_content">
                <table cellspacing="0" cellpadding="0" class="checker table" width="100%">
                    <tr >
                        <td style="border:none; text-align: right"><b>{$lang.status}</b></td>
                        <td style="border:none;">
                            <span class="{$service.status} label label-{$service.status}">{$lang[$service.status]}</span>
                            {if $upgrades && $upgrades!='-1'}
                                <small><a href="{$service_url}&make=upgrades&upgradetarget=service" class="lmore">{$lang.UpgradeDowngrade}</a></small>
                            {/if}
                        </td>
                        
                        {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.next_due!='' && $service.next_due!='0000-00-00'}
                            <td style="border:none;text-align: right"><b>{$lang.nextdue}</b></td>
                            <td style="border:none;">{$service.next_due|dateformat:$date_format}</td>
                            </tr><tr>
                            <td style="border:none;text-align: right"><b>{if $metered_enable}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</b></td>
                            <td style="border:none;">
                                {if $metered_enable}
                                    {$user_domains_cnt} {$lang.domains} * {$curent_price|price:$currency}/{$lang.domain} = <b>{$summary.charge|price:$currency}</b>
                                {else}
                                    {$service.total|price:$currency}
                                {/if}
                            </td>
                        {/if}
                        {if $service.status!='Terminated' && $service.status!='Cancelled'}
                             <td style="border:none;text-align: right">
                                 <a href={$service_url}&cid={$service.category_id}&cancel" style="color:red">
                                     <span class="cancel">{$lang.cancelrequest}</span>
                                 </a>
                             </td>
                        {/if}
                    </tr>
                </table>
                    
                {if $service.custom}
                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table table-striped fullscreen" >
                        {foreach from=$service.custom item=cst}
                        <tr >
                            <td align="right" width="160"><strong>{$cst.name}</strong>  </td>
                            <td>{include file=$cst.configtemplates.clientarea} </td>
                        </tr>
                        {/foreach}
                    </table>
                {/if}
                
                <div id="mpricing" style="display:none">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" class="checker table table-striped " >
                        {foreach from=$pricebrackets item=bracket}
                            {foreach from =$bracket.prices item=p key=k name=bloop}
                                <tr {if $smarty.foreach.bloop.index%2==0}class="even"{/if}>
                                    <td width="20"></td>
                                    <td >{$lang.from} {$p.qty} {$bracket.unit_name}</td>
                                    <td >{if $p.qty_max>0}{$lang.to} {$p.qty_max} {$bracket.unit_name}{else} {$lang.to} <b>{$lang.unlimited}</b>{/if}</td>
                                    <td >{$p.price|price:$currency} / {$lang[$service.billingcycle]}</td>
                                </tr>
                            {/foreach}
                        {/foreach}
                    </table>
                </div>
            </div>
        </div>

        {if $service.status=='Active'}
            {if $nameserv}
                <div class="wbox" style="margin-top:30px;">
                    <div class="wbox_header">{$lang.updateyourdomainregistrarsnameserve}</div>
                    <div class="wbox_content">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                            <tr>
                                <td width="50%" style="padding-right:10px;">
                                    <ul style="" class="listi">
                                        <li>{$lang.dnsguideline1}</li>
                                        <li>{$lang.dnsguideline2}</li>
                                        <li>{$lang.dnsguideline3}</li>
                                        <li>{$lang.dnsguideline4}</li>
                                    </ul>
                                </td>
                                <td valign="top">
                                    <table cellspacing="0" cellpadding="0" class="checker table table-striped table-bordered" width="100%">
                                        <tr>
                                            <th style="text-align: left">{$lang.hostname}</th><th  style="text-align: left">{$lang.ipadd} </th>
                                        </tr>
                                        {foreach from=$nameserv item=ns name=namserver}
                                            {if $ns!=''}
                                                <tr {if $smarty.foreach.namserver.index%2==0}class="even"{/if}>
                                                    <td>{$ns.name}</td>
                                                    <td>{$ns.ip}</td>
                                                </tr>
                                            {/if}
                                        {/foreach}
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            {/if}
        {/if}
    </form>
{/if}
{if $act=='dns_manage'}
    <script type="text/javascript" src="{$type_dir}js/punycode.min.js"></script>
    <script type="text/javascript" src="{$type_dir}js/script.js"></script>
    {literal}
        <script type="text/javascript">
            function ask(){
                if(!confirm('{/literal}{$lang.confirm_delrecord}{literal}'))
                    return false;
            }	
        </script>
    {/literal}

    <form action="{$service_url}&act=dns_manage&domain_id={$domid}" method="POST">
        {foreach from=$record_types item=ids key=type}
            {if $type=='SOA'}
                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display"  style="margin-bottom:15px">
                    <col class="col-name" />
                    <col class="col-ttl" />
                    <col class="col-priority" />
                    <col class="col-type" />
                    <col class="col-content" />
                    <col class="col-action" />
                    <thead>
                        <tr>
                            <th colspan="6">{$lang.soarecord}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>{$lang.name}</th>
                            <th>{$lang.priority}</th>
                            <th>TTL</th>
                            <th>{$lang.type}</th>
                            <th>{$lang.data}</th>
                            <th></th>
                        </tr>
                    </tbody>
                    <tbody>
                        {foreach from=$records item=record}
                            {if in_array($record.id, $ids)}
                                <tr style="vertical-align:top">
                                    <td><span class="overflow-e rr-name">{$record.name}</span></td>
                                    <td>{$record.priority}</td>
                                    <td>{$record.ttl}</td>
                                    <td>{$record.type}</td>
                                    <td align="left" style="padding-left:1em"><span class="rr-content">{$record.content[0]} {$record.content[1]}</span> (<br />
                                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[2]};</div><div> {$lang.serial}</div>
                                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[3]};</div><div> {$lang.refresh}</div>
                                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[4]};</div><div> {$lang.retry}</div>
                                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[5]};</div><div> {$lang.expire}</div>
                                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[6]}</div><div>{$lang.minimumttl}</div>
                                        &nbsp;&nbsp;&nbsp;)
                                    </td>
                                    <td><a class="fs11" href="{$service_url}&act=edit_record&domain_id={$domid}&record={$record.id}" title="{$lang.edit}">{$lang.edit}</a> &nbsp;&nbsp;</td>
                                </tr>
                            {/if}
                        {/foreach}
                    </tbody>
                </table>
            {/if}
        {/foreach}
        {foreach from=$record_types item=ids key=type}
            {if $type!='SOA'}
                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display" style="margin-bottom:15px">
                    <col class="col-name" />
                    <col class="col-ttl" />
                    <col class="col-priority" />
                    <col class="col-type" />
                    <col class="col-content" />
                    <col class="col-action" />
                    <thead><tr><th align="left" colspan="6">{$type} {$lang.records}</th></tr></thead>
                    <tbody>
                        <tr>
                            <th >{$lang.name}</th>
                            <th >{$lang.priority}</th>
                            <th >TTL</th>
                            <th >{$lang.type}</th>
                            <th>{$lang.data}</th>
                            <th ></th>
                        </tr>
                        {foreach from=$records item=record name=rc}
                            {if in_array($record.id, $ids)}
                                <tr  {if  $smarty.foreach.rc.index%2 == 0}class="even"{else}class="odd"{/if}>
                                    <td><span class="overflow-e rr-name">{$record.name}</span></td>
                                    <td>{$record.priority}</td>
                                    <td>{$record.ttl}</td>
                                    <td>{$record.type}</td>
                                    <td align="left">
                                        <span class="overflow-e rr-content">
                                        {if is_array($record.content)}
                                            {foreach from=$record.content item=content name=row}
                                                {$content}&nbsp;
                                            {/foreach}
                                        {else}
                                            {$record.content}
                                        {/if}
                                        </span>
                                    </td>
                                    <td style="text-align: right">
                                        <div class="dns-actions">
                                        {if in_array($record.type,$supported_types) && isset($record.id)}
                                            <a class="fs11 " href="{$service_url}&act=edit_record&domain_id={$domid}&record={$record.id}" title="{$lang.edit}">{$lang.edit}</a> |
                                            <a class="fs11 lmore " href="{$service_url}&act=dns_manage&domain_id={$domid}&delete={$record.id}&security_token={$security_token}" onclick="return ask()" title="{$lang.delete}">{$lang.delete}</a>
                                        {else}
                                            &nbsp;
                                        {/if}
                                        </div>
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                        <tr>
                            <td colspan="6" style="text-align:right"><a href="{$service_url}&act=add_record&dom={$domid}&type={$type}" class="fs11">{$lang.addnew} {$lang.record}</a></td>
                        </tr>
                    </tbody>

                </table>
            {/if}
        {/foreach}

        <div style="margin-top:2em">
            <div class="left" style="margin-right: 5px">{$lang.newrecord}
                <select id="add_record">
                    {foreach from=$supported_types item=stype}
                        <option  value="{$stype}" >{$stype}</option>
                    {/foreach}
                </select>
            </div>
            <a class="btnx btn_d fl" href="#" onclick="window.location='{$service_url}&act=add_record&dom={$domid}&type='+$('#add_record').val();return false;">{$lang.Add}</a>
            <div class="clear"></div>
        </div>

    </form>
{/if}
{if $act=='dns_templates'}
    {literal}
        <script type="text/javascript">
            var start = false;
                $(document).ready(function(){

                    $("#nitems strong").click(function(){
                        $(this).parent().find('input').click();
                        return false;
                    });

                    $('#nitems input').click(function(){
                        $('.diss').removeClass('diss');
                        $('#nitems .nitem').removeClass('niselected');
                        $(this).parent().addClass('niselected');
                        var id=$(this).val();
                        $('.oitem').hide();
                         $('.oitem_'+id).fadeIn('fast');

                    });
                
                });
  
        </script>
        <style type="text/css">
            #dns_templ {list-style:none; padding:0; margin:0}
            #dns_templ li {padding:2px 10px; cursor:pointer; font-weight:bold}
            #dns_templ li:hover , #dns_templ li.active {color:#026BeB}
            #dns_prev {border:solid 1px #bbb; min-height:250px; margin-bottom:20px}
            .diss {
                color:#C0C0C0 !important;
            }
        </style>
    {/literal}
    <form id="mform" action="{$service_url}&act=dns_templates" method="post">
        {if $sected_domains} 
            <div class="wbox"><div class="wbox_header">{$lang.bulkdomains}</div>
                <div class="wbox_content">
                    {foreach from=$sected_domains item=domain name=row}
                        <div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.id}" name="dom[]" checked="checked"/> 
                            {$domain.name}
                        </div>
                    {/foreach}
                </div></div>
            {/if}

        <h3>{$lang.availabletemplates}</h3>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="ntable">
            <tr>
                <td valign="top" width="33%" style="padding:10px 0px;" id="nitems">

                    {foreach from=$templates item=template key=name}
                        <div class="nitem">
                            <input type="radio" name="template" value="{$template[0].id}"/> <strong>{$template[0].template}</strong>
                        </div>
                    {/foreach}
                </td>
                <td valign="top" class="orderbox1" id="orderitems">
                    <div class="oitem">
                        {$lang.selectoavailablednstempl}


                    </div>
                    {foreach from=$templates item=template key=tid name=floop}
                        <div class="oitem oitem_{$tid}" style="display:none;">
                            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display">
                                <col class="col-name" />
                                <col class="col-ttl" />
                                <col class="col-priority" />
                                <col class="col-type" />
                                <col class="col-content" />
                                <thead >
                                    <tr>
                                        <th>{$lang.name}</th>
                                        <th>TTL</th>
                                        <th>{$lang.priority}</th>
                                        <th>{$lang.type}</th>
                                        <th>{$lang.content}</th>
                                    </tr>
                                </thead>

                                <tbody >
                                    {foreach from=$template item=record}
                                        <tr>
                                            <td><span class="overflow-e">{$record.name}</span></td>
                                            <td>{$record.ttl}</td>
                                            <td>{$record.priority}</td>
                                            <td>{$record.type}</td>
                                            <td><span class="overflow-e">{$record.content}</span></td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>

                    {/foreach}
                </td>
            </tr>
            <tr>
                <td></td>
                <td class="orderbox2">
                    <table width="100%" cellspacing="0">
                        <tbody><tr>
                                <td width="70%" class="orderbox3" style="text-align: right">
                                    <input type="submit"    onclick="return  $('input[name=template]:checked').val()!=undefined" value="{$lang.applytemplate}" name="submit" class="btn btn-primary diss" style="font-weight: bold;padding:4px 2px;">
                                </td>

                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </form>
{/if}
