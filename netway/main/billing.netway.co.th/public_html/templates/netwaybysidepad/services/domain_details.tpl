{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/domain_details.tpl.php');
{/php}

{if $bulkdetails}
    <ul class="breadcrumb">
        <li><a href="{$ca_url}clientarea/"><strong>{$lang.clientarea}</strong></a> <span class="divider">/</span></li>
        <li><a href="{$ca_url}clientarea/domains/"><strong>{$lang.domains}</strong></a> <span class="divider">/</span></li>
                    {if $widget} 
            <li><a href="{$ca_url}clientarea/services/domains/{$service.id}/"><strong>{$details.name}</strong></a>  <span class="divider">/</span></li>
            <li class="active">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</li>
            {else}
            <li class="active">{$details.name}</li>
            {/if}
    </ul>

    <div class="wbox">
        <div class="wbox_header">{$lang.bulkdomains}</div>
        <div  class="wbox_content" id="cartSummary">
            {foreach from=$bulkdetails item=b}
                <a href="{$ca_url}clientarea/domains/{$b.id}/{$b.name}/">{$b.name}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            {/foreach}
        </div>
    </div>

    {if $widget.replacetpl}
        {include file=$widget.replacetpl}
    {elseif $widget.appendtpl}
        {include file=$widget.appendtpl}
    {elseif $widget.appendaftertpl}
        <a name="{$widget.name}"></a>
        {include file=$widget.appendaftertpl}
    {/if}

{elseif $details}

    {if ($details.status=='Pending' || $details.status=='Pending Registration' || $details.status=='Pending Transfer' || $details.status=='Active') && stristr($details.name, '.hu') }
        <div class="wbox" style="display:none" id="huregistrar">
            <div class="wbox_header">
                {$lang.hu_formtitle}
            </div>
            <div class="wbox_content">
                <div class="tabb" style="padding:5px;border-bottom: 1px solid #DDDDDD;">
                    {$lang.hu_linkdescr} <a href="" id="hu_form_link" target="_blank">{$lang.hu_downloadform}</a>
                </div>
                <div style="padding:5px;">
                    <form style="padding:10px 0 0;"action="" method="POST" enctype="multipart/form-data" id="hu_upform" class="form-inline">
                        <input type="file" name="signedform"> <input class="btn btn-primary" type="submit" value="{$lang.hu_sendform}" style="vertical-align: bottom">
                    </form>
                </div>
            </div>
        </div>
    {/if}
    <div class="wrapper-bg">
        <div class="services-box">
            <ul class="nav nav-list">
                <li class="nav-header">
                    <div class="service-nav-header">{$lang.domdetails}</div>
                </li>
                {if $details.status=='Active'}
                    <li {if !$widget}class="active-service"{/if}><a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/">
                            <i class="icon-domain-details"></i>{$lang.domdetails}</a><span></span>
                    </li>
					{if isset($aDnsService.id) && isset($aDnsService.slug)}
                    <li><a href="{$ca_url}clientarea/services/{$aDnsService.slug}/{$aDnsService.id}/&act=dns_manage&domain_id={if $dnsDomainId}{$dnsDomainId}{else}{$details.name}{/if}">
                            <i class="icon-config-service"></i>DNS Management</a><span></span>
                    </li>
					{else}
                    <li><a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/dnsservices">
                            <i class="icon-config-service"></i>DNS Management</a><span></span>
                    </li>
					{/if}
					
					{* start: link domain forwarding *}
					<li><a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/rvdomainforwarding/">
                            <i class="icon-config-service"></i>Domain Forwarding</a><span></span>
                    </li>
                    <li><a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/rvgooglecode/">
                            <i class="icon-config-service"></i>Google Apps Code</a><span></span>
                    </li>
                    {* end: link domain forwarding *}
					
                    {foreach from=$widgets item=widg name=cst}
                        {if $widg.name!='reglock' && $widg.name!='nameservers'  && $widg.name!='autorenew' }
                            {if $widg.name=='idprotection' && $details.offerprotection && !$details.offerprotection.purchased}
                                {*continue*}
                            {/if}

                            <li {if $widget.name==$widg.name}class="active-service"{/if}>
                                <a  href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}#{$widg.name}">
                                    <i>
                                        <img src="{$system_url}{$widg.location}/small.png" alt="" />
                                    </i>
                                    {assign var=widg_name value="`$widg.name`_widget"}
                                    {if $lang[$widg_name]}
                                        {$lang[$widg_name]}
                                    {elseif $lang[$widg.name]}
                                        {$lang[$widg.name]}
                                    {elseif $widg.fullname}
                                        {$widg.fullname}
                                    {else}
                                        {$widg.name}
                                    {/if}
                                </a>
                            </li>
                        {/if}
                    {/foreach}
                    {if $custom}
                        {foreach from=$custom item=btn name=cst}
                            <li {if $smarty.foreach.cst.last}class="last"{/if}>
                                <a href="#" onclick="$('#cbtn_{$btn}').click();
                                        return false;">{$lang.$btn}</a> </li>
                            {/foreach}
                        {/if}
                    {/if}

					
					{* start: dnssec request *}
                    {if $details.reg_module == '179'}
					<li><a href="?cmd=dnssechandle&action=serviceRequest&domainId={$details.id}">
                        <i class="icon-config-service"></i>DNSSEC Record</a><span></span>
                    </li>
                    {/if}
                    {* end: dnssec request *}

            </ul>
            {if $details.status!='Active'}
                <div class="sidebar-block">
                    {if $details.status=='Pending' ||  $details.status=='Pending Registration'}
                        {$lang.domainpendinginfo}
                    {elseif $details.status=='Pending Transfer'}
                        {$lang.domainpendingtransferinfo}
                    {elseif $details.status=='Expired'}
                        {$lang.domainexpiredinfo}
                    {elseif $details.status=='Cancelled' ||  $details.status=='Fraud'}
                        {$lang.domaincanceledinfo}
                    {/if}
                </div>
            {/if}
        </div>
        <!-- Right Content -->
        <div class="services-content">
            <div class="domain-title">
                <h2>
                    {if $details} {$details.name}
                    {elseif $widget}
                        {if $lang[$widget.name]}{$lang[$widget.name]}
                        {elseif $widget.fullname}{$widget.fullname}
                        {else}{$widget.name}
                        {/if}
                    {/if}
                </h2>
            </div>
            <ul class="breadcrumb">
                <li><a href="{$ca_url}clientarea/">{$lang.clientarea}</a> <span>></span></li>
                <li><a href="{$ca_url}clientarea/domains/">{$lang.domains}</a> <span>></span></li>
                    {if $widget}
                    <li><a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/">{$details.name}</a>  <span>></span></li>
                    <li>
                        {if $lang[$widget.name]}
                            {$lang[$widget.name]}
                        {elseif $widget.fullname}
                            {$widget.fullname}
                        {else}
                            {$widget.name}
                        {/if}
                    </li>
                {else}
                    <li>{$details.name}</li>
                    {/if}
            </ul>
            <div class="line-separaotr-m"></div>
            
			{if isset($NsError)}
                {include file='../common/dnsmodules/nserror.tpl'}
            {elseif isset($NsError) && isset($requireUpdateNS)}
                {include file='../common/dnsmodules/nsinfo.tpl'}
			{else}
			
            {if $widget.appendtpl}
                {include file=$widget.appendtpl}
            {/if}

            {if $widget.replacetpl}
                {include file=$widget.replacetpl}
            {else}
                
                {if ! $widget.appendaftertpl} {* แสดงข้อมูลนี้ภ้ามีการ ไม่มี load widget*}
                
                <div class="services-container no-p-left">
                    <p>{$lang.domain}</p>
                    <a href="http://{$details.name}" target="_blank">{$details.name}</a>

                    <div>
                        <div class="domain-info-box span2">
                            <p>{$lang.registrationdate}</p>
                            <span>{if !$details.date_created || $details.date_created == '0000-00-00'}{$lang.none}{else}{$details.date_created|date_format:'%d %b %Y'}{/if}</span>
                        </div>

                        {if $details.status == 'Active' || $details.status == 'Expired'}
                            <div class="domain-info-box span3">
                                <p>{$lang.expirydate}</p>
                                {if !$details.expires || $details.expires == '0000-00-00'}{$lang.none}
                                {else}<span>{$details.expires|date_format:'%d %b %Y'}</span>
                                    {if $details.daytoexpire >= 0}
                                        <small>({$details.daytoexpire} {if $domain.daytoexpire==1}{$lang.day}{else}{$lang.days}{/if} {$lang.toexpire})</small>
                                    {/if}
                                {/if}
                            </div>
                        {/if}
                    </div>
                    {if $allowrenew && isset($oAdmin->id)}
                        {if $details.daytoexpire >= -30}<a  style="font-size:11px;" href="{$ca_url}clientarea/domains/renew/&ids[]={$details.id}" class="clearstyle btn grey-custom-btn"><i class="icon-cycle-large"></i>{$lang.renewdomain}</a>{else}<a><font color="green">**ต้องการต่ออายุโดเมนหลังจาก Expired แล้ว <br>
กรุณาติดต่อฝ่ายขาย 02-912-2558 หรือ Email : NwTeam@netway.co.th</font></a>{/if}
                        {/if}
                </div>
                
                <div class="services-container no-p-left">
                    <div>
                        <div class="domain-status span2">
                            <p>{$lang.status}</p>
                            <span class="label label-{$details.status}">{$lang[$details.status]}</span>
                        </div>
                        
                        <div class="domain-status span2">
                            <p>Private domain</p>
                                {if $details.idprotection=='1'}
                                    <span class="label-Active">{$lang.On}</span>
                                {else}
                                    <span class="label-Expired">{$lang.Off}</span>
                                {/if}
                        </div>

                        {if $widget.appendtpl}
                            {include file=$widget.appendtpl}
                        {/if}

                        {if $details.status == 'Active'}

                            <div class="domain-status span2" style="display: none;">
                                <p>{$lang.reglock}: </p>
                                {if $details.reglock=='1'}
                                    <span class="label-Active">{$lang.On}</span>
                                {else}
                                    <span class="label-Expired">{$lang.Off}</span>
                                {/if}
                                <!--<i class="icon-info-tip"></i>-->
                            </div>
                            {foreach from=$widgets item=widg name=cst}
                                {if $widg.name=='reglock'}
                                    <a style="font-size:11px;" class="clearstyle btn grey-custom-btn" href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#reglock">
                                        <i class="icon-lock-large"></i>
                                        {assign var=widg_name value="`$widg.name`_widget"}
                                        {if $lang[$widg_name]}{$lang[$widg_name]}
                                        {elseif $lang[$widg.name]}{$lang[$widg.name]}
                                        {elseif $widg.fullname}{$widg.fullname}
                                        {else}{$widg.name}
                                        {/if}
                                    </a>{break}
                                {/if}
                            {/foreach}&nbsp;
                        {/if}
                    </div>

                    {if !$details.not_renew}
                        <div style="display: none;">
                            <div class="domain-info-box">
                                <p>{$lang.autorenew}:</p>
                                {if $details.autorenew=='1'}
                                    <span class="label-Active">{$lang.On}</span>
                                {else}
                                    <span class="label-Expired">{$lang.Off}</span>
                                {/if}
                            </div>
                            {foreach from=$widgets item=widg name=cst}
                                {if $widg.name=='autorenew'}
                                    <a style="font-size:11px;" class="clearstyle btn grey-custom-btn" href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#autorenew">
                                        <i class="icon-renewal"></i>
                                        {assign var=widg_name value="`$widg.name`_widget"}
                                        {if $lang[$widg_name]}{$lang[$widg_name]}
                                        {elseif $lang[$widg.name]}{$lang[$widg.name]}
                                        {elseif $widg.fullname}{$widg.fullname}
                                        {else}{$widg.name}
                                        {/if}</a>{break}
                                    {/if}
                                {/foreach}
                            &nbsp;
                        </div>
                    {/if}
                </div>
                
                {if in_array($details.status, array('Pending', 'Pending Registration', 'Pending Transfer'))}
                <div class="services-container no-p-left">
                    
                    <link href="{$template_dir}css/fileuploader.css?v={$hb_version}" rel="stylesheet" media="all" />
                    <script src="{$template_dir}js/fileuploader.js"></script>
                    
                    {if count($aCustomUpload)}
                    <h4>เอกสารที่เกี่ยวข้อง</h4>
                    
                    <form class="form-horizontal">
                        
                        {foreach from=$aCustomUpload key=catId item=aUpload}
                        {**}
                        
                        <div class="control-group">
                            <label class="control-label">{$aUpload.name}</label>
                            <div class="controls">
                                    <input type="hidden" id="custom_field_{$catId}" name="custom[{$catId}]" value="{$aUpload.data}" />
                                    <span id="custom_field_display_{$catId}"></span>
                                    <div id="fileUploaderAttachment_{$catId}">
                                        <noscript><p>Please enable JavaScript to use file uploader.</p></noscript>
                                    </div>
                            </div>
                        </div>
                          
                        <script language="JavaScript">
                        {literal}
                        $(document).ready(function () {
                            var uploader_{/literal}{$catId}{literal}   = new qq.FileUploader({
                                element: document.getElementById('fileUploaderAttachment_{/literal}{$catId}{literal}'),
                                action: '?cmd=supporthandle&action=customfieldFileupload',
                                params: {type:'Domain',accountId:{/literal}{$details.id}{literal},catId:{/literal}{$catId}{literal},configId:{/literal}{$aUpload.config_id}{literal}},
                                uploadButtonText: 'Upload file',
                                onComplete: function(id, fileName, responseJSON){
                                    if (typeof responseJSON.filename != 'undefined') {
                                        var oldFile     = $('#custom_field_{/literal}{$catId}{literal}').val();
                                        $('#custom_field_{/literal}{$catId}{literal}').val(''+responseJSON.filename+'');
                                        $('#custom_field_display_{/literal}{$catId}{literal}').text(fileName);
                                        
                                        nwMakeFileUrl('#custom_field_{/literal}{$catId}{literal}', '#custom_field_display_{/literal}{$catId}{literal}');
                                        
                                        if (oldFile != '') {
                                            $.post('?cmd=supporthandle&action=customfieldDeleteFile', {filename:oldFile}, function (){});
                                        }
                                        
                                        $('.qq-upload-success').fadeOut({duration:2000});
                                        
                                    } else {
                                        $('#custom_field_display_{/literal}{$catId}{literal}').text('');
                                    }
                                }
                            });
                            
                            var oldFile     = $('#custom_field_{/literal}{$catId}{literal}').val();
                            if (oldFile != '') {
                                $('#custom_field_display_{/literal}{$catId}{literal}').text(oldFile);
                                nwMakeFileUrl('#custom_field_{/literal}{$catId}{literal}', '#custom_field_display_{/literal}{$catId}{literal}');
                            }
                            
                        });
                        {/literal}
                        </script>
                        
                        {/foreach}
                        
                    </form>
                    
                    {/if}
                    
                </div>
                <script language="JavaScript">
                {literal}
                function nwMakeFileUrl (inputId, labelId)
                {
                    var inputVal        = $(inputId).val();
                    
                    var n               = inputVal.indexOf('::');
                    var fileId          = inputVal.substring(0, n);
                    
                    if (fileId != '') {
                        $(labelId).html('<a href="{/literal}{$ca_url}{literal}root&amp;action=download&amp;type=downloads&amp;id='+ fileId +'" target="_blank">'+ $(labelId).text() +'</a>');
                    }
                }
                {/literal}
                </script>
                {/if}
                
                <p class="ns">{$lang.nameservers}</p>
                <div class="services-table">
                    <table class="table table-striped tb-header-fix">
                        <tr class="header-row">
                            <td class="w50 table-g">{$lang.hostname}</td>
                            <td class="w50 table-g border-h">{$lang.ipadd}</td>
                        </tr>
                        {foreach from=$details.nameservers_sort item=ns name=namserver}
                            {if $ns!=''}
                                <tr>
                                    <td class="cell-border">{$ns}</td>
                                    <td class="cell-border">
                                        {if $details.nsips_sort[$smarty.foreach.namserver.index]}{$details.nsips_sort[$smarty.foreach.namserver.index]}
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                        <tr>
                            <td>
                                {foreach from=$widgets item=widg name=cst}
                                    {if $widg.name=='nameservers'}
                                        <a  href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#nameservers">
                                            <i class="icon-mg-ns"></i>
                                            {assign var=widg_name value="`$widg.name`_widget"}
                                            {if $lang[$widg_name]}
                                                {$lang[$widg_name]}
                                            {elseif $lang[$widg.name]}
                                                {$lang[$widg.name]}
                                            {elseif $widg.fullname}
                                                {$widg.fullname}
                                            {else}
                                                {$widg.name}
                                            {/if}
                                        </a>{break}
                                    {/if}
                                {/foreach}&nbsp;
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </div>
                
                {/if}

                {if $widget.appendaftertpl}
                    <a name="{$widget.name}"></a>
                    {include file=$widget.appendaftertpl}
                {/if}

                {* eof: if widget replace *}
                
                
                {* start: rvcustomtemplate *}
                    {if $rvcustomtemplate}
                        {include file=$rvcustomtemplate}
                    {/if}
                {* eof: rvcustomtemplate *}
                

            {/if}

            </div>
        </div>
    {/if}
    {* eof: if details *}
{/if}