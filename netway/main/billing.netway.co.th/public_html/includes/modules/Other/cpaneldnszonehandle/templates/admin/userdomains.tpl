{literal}
<style type="text/css">
.showlog{
    display: block; 
    width: 600px; 
    height: 200px; 
    overflow: auto;
    }
</style>
{/literal}
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
<tr>
    <td ><h3>Netway cPanel DNS Zone</h3></td>
    <td  class="searchbox">
        {if isset($oInfo->title)}
            <h3>{$oInfo->title}</h3>
            <p>{$oInfo->desc}</p>
        {/if}
    </td>
</tr>
<tr>
    <td class="leftNav">
        {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
    
    {if isset($oInfo->alert)}
    <div align="center" class="gbox1">{$oInfo->alert}</div>
    {/if}
    
    <div id="bodycont"> 
    
    {if $aDomains|count}
    <table class="glike" width="100%" cellspacing="0" cellpadding="3" border="0" style="">
    <thead>
    <tr>
        <th>#</th>
        <th>Domain</th>
        <th>Action</th>
        <th>&nbsp;</th>
    </tr>
    <tbody>
    {foreach from=$aDomains item=domain key=i}
    <tr valign="top">
        <td>{$i+1}</td>
        <td>{$domain}</td>
        <td><a href="?cmd=module&module=cpaneldnszonehandle&action=fixdns&domain={$domain}" name="{$domain}">Fix Error</a></td>
        <td>
            <div id="{$domain}"></div>
            {literal}
            <script language="JavaScript">
            $(document).ready( function () {
                $('a[name="{/literal}{$domain}{literal}"]').click( function () {
                    $('div[id="{/literal}{$domain}{literal}"]').append('กำลังดำเนินการ .....');
                    var url     = $(this).attr('href');
                    $.post(url, {}, function (data){
                        parse_response(data);
                        if (data.indexOf("<!-- {") == 0) {
                            var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                            if (codes.HTML.length > 0) {
                                $('div[id="{/literal}{$domain}{literal}"]').append(codes.HTML).addClass('showlog');
                            }
                        }
                    });
                    return false;
                });
            });
            </script>
            {/literal}
        </td>
    </tr>
    {/foreach}
    </tbody>
    </thead>
    </table>
    {/if}
    
    </div>
    </td>
  </tr>
</table>

<script type="text/javascript">

</script>