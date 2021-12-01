{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/lists.tpl.php');
{/php}

<script type="text/javascript">
{literal}
$(document).ready( function () {
    $('#searchForm').submit( function () {
        var keyword         = $(this).find('input[name="keyword"]').val();
        document.location   = '{/literal}{$ca_url}{literal}clientarea/services/licenses/&keyword='+ keyword +'';
        return false;
    });
    
    $('.buynow').click( function () {
        var ip              = $(this).attr('title');
        var url             = $(this).attr('href');
        $.get('?cmd=productlicensehandle&action=preorder&ip='+ ip, function () {
            document.location   = url;
            return true;
        });
        
        return false;
    });
    
});
{/literal}
</script>

<div class="row">
    <div class="span3">
        <h2>Licenses</h2>
    </div>
    <div class="span3 pull-right">
        <p align="right">
            <br />
            <a href="{$ca_url}cart/licenses" class="btn btn-inverse" style="margin-right: 15px;"><i class="icon-plus-sign icon-white"></i> Order new license</a>
        </p>
    </div>
</div>

<div class="row">&nbsp;</div>

<div class="row">
    <div class="span8">
        <ul class="nav nav-pills">
            <li class="{if $status == 'All' || $status == ''} active {/if} "><a href="{$ca_url}clientarea/services/licenses/" class="text-info"><i class="icon-th"></i> All license ({$aTotal.All})</a> </li>
            <li class="{if $status == 'Pending'} active {/if} "><a href="{$ca_url}clientarea/services/licenses/&s=Pending" class="muted"><i class="icon-th-list"></i> Pending ({$aTotal.Pending})</a> </li>
            <li class="{if $status == 'Active'} active {/if} "><a href="{$ca_url}clientarea/services/licenses/&s=Active" class="text-success"><i class="icon-ok-sign"></i> Active ({$aTotal.Active})</a> </li>
            <li class="{if $status == 'Suspended'} active {/if} "><a href="{$ca_url}clientarea/services/licenses/&s=Suspended" class="text-warning"><i class="icon-pause"></i> Suspended ({$aTotal.Suspended})</a> </li>
            <li class="{if $status == 'Expired'} active {/if} "><a href="{$ca_url}clientarea/services/licenses/&s=Expired" class="text-error"><i class="icon-remove-sign"></i> Expired ({$aTotal.Expired})</a> </li>
        </ul>
    </div>
    <div class="span3 pull-right">
        <form id="searchForm" class="form-search">
            <div class="input-append" align="right">
                <input name="keyword" type="text" value="{$keyword}" class="span2 search-query" placeholder="Search by IP Address" />
                <button type="submit" class="btn">Search</button>
            </div>
        </form>
    </div>
</div>

<div class="row">&nbsp;</div>

{if $aLicenses.lists|count}

<div class="row">
    <table class="table table-hover">
        
    <thead>
    <tr style="background: #8E8E8E; color: #FFFFFF; ">
        <th class="span5">Server IP</th>
        <th class="span2">Expiration date</th>
        <th class="span2">Status</th>
        <th class="span2">Manage</th>
    </tr>
    </thead>
    
    <tbody>
   {foreach from=$aLicenses.lists item=aLicense key=ip name=foo}
    <tr style="background: #DCDCDC;">
        <td colspan="3"><strong>{$aLicense.ip} {if $aLicense.hostname != ''}({$aLicense.hostname}){/if}</strong></td>
        <td>
            {if $smarty.foreach.foo.index != 0 && $aLicense.more|count}
            <div class="btn-group">
                <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-plus-sign"></i> Add license
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li class="disabled"><a tabindex="-1" href="#" onclick="return false;">Select product</a></li>
                    <li class="divider"></li>
                    {foreach from=$aLicense.more item=aMore}
                    <li><a tabindex="-1" href="{$ca_url}?cmd=cart&action=add&id={$aMore.Dedicated}&ip={$aLicense.ip}" title="{$aLicense.ip}" class="buynow" target="_blank">{$aMore.name}</a></li>
                    {/foreach}
                </ul>
            </div>
            {/if}
        </td>
    </tr>
    
    {foreach from=$aLicense.items item=aItem}
    <tr>
        <td style="text-indent: 15px;"><a href="{$ca_url}clientarea/services/licenses/{$aItem.id}/">{$aItem.product}</a></td>
        <td>{if $aItem.expire == 'Jan 1, 1970'} - {else} {$aItem.expire} {/if}</td>
        <td><span class="label label-{$aItem.status}">{$lang[$aItem.status]}</span></td>
        <td>
            
            <div class="btn-group">
                <a class="btn btn-small dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-wrench"></i>
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    {if $aItem.status == 'Active'}
                    <li><a tabindex="-1" href="{$ca_url}clientarea/services/licenses/{$aItem.id}/">Sevice management</a></li>
                    {/if}
                </ul>
            </div>
            
        </td>
    </tr>
    {/foreach}
    
    
    <tr>
        <td colspan="4" style="padding-left: 25px;">
            {if $smarty.foreach.foo.index == 0 && $aLicense.more|count}
            <h4>You may need more available license for this IP Address</h4>
            <div class="row">
                <div class="span8 well well-small">
                {foreach from=$aLicense.more item=aMore}
                <div class="row" style="line-height: 2.4em;">
                    <div class="span4"><strong>{$aMore.name}</strong> <span class="muted">${$aMore.price|number_format} / Month</span></div>
                    <div class="span2"><span class="text-success">{$aMore.available}</span></div>
                    <div class="span2"><a href="{$ca_url}?cmd=cart&action=add&id={$aMore.VPS}&ip={$aLicense.ip}" title="{$aLicense.ip}" target="_blank" class="buynow btn btn-warning btn-small">Buy now</a></div>
                </div>
                {/foreach}
                </div>
            </div>
            {/if}
        </td>
    </tr>
    
    {/foreach}
    </tbody>
    
    </table>
</div>

<div class="row">&nbsp;</div>

<div class="row">
    <ul class="pager">
        <li class="{if $page == 1}disabled{/if}">
            {assign var=previous value=$page-1}
            <a {if $page == 1}onclick="return false;"{/if} href="{$ca_url}clientarea/services/licenses/&s={$status}&p={$previous}&keyword={$keyword}">&larr; Previous</a>
        </li>
        <li class="{if $aLicenses.pages == $page}disabled{/if}">
            {assign var=next value=$page+1}
            <a {if $aLicenses.pages == $page}onclick="return false;"{/if} href="{$ca_url}clientarea/services/licenses/&s={$status}&p={$next}&keyword={$keyword}">Next &rarr;</a>
        </li>
    </ul>
</div>

{else}

<div class="row">
    <div class="alert alert-info">
        <p align="center">
            <blockquote>No license to list.</blockquote>
        </p>
    </div>
</div>

{/if}
