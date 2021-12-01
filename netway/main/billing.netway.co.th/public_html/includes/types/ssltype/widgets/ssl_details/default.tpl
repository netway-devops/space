<div class="widget">
    <h2>{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</h2>
    <hr/>
    <div class="table-responsive">
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-striped">
            <tr>
                <td>{$lang.commonName}:</td>
                <td>{$cert.cn}</td>
                <td>{$lang.status}:</td>
                <td><span class="label label-Active">{if $lang[$cert.status]}{$lang[$cert.status]}{else}{$cert.status|capitalize}{/if}</span></td>
            </tr>
            <tr>
                <td>{$lang.webserver}:</td>
                <td>{$cert.software}</td>
                <td>{$lang.supplierorderid}:</td>
                <td>{$cert.order_id}</td>
            </tr>
            {if $cert.status == 'Issued'}
                <tr>
                    {if $cert.start_date}
                        <td>{$lang.creationdate}:</td>
                        <td>{$cert.start_date|dateformat:$date_format}</td>
                    {/if}
                    {if $service.next_due}
                        <td>{$lang.expirydate}:</td>
                        <td>{$service.next_due|dateformat:$date_format}</td>
                    {/if}
                </tr>
            {/if}
        </table>
    </div>
    <hr>
    {if $cert.san}
        <div id="san" class="ssl-block">
            <h3>{$lang.ssl_san}</h3>
            <ul>
                {foreach from=$cert.san item=san}
                    <li>
                        {$san}
                    </li>
                {/foreach}
            </ul>
        </div>
        <hr/>
    {/if}
    <form action="" method="POST">
        <div id="csr">
            <h3>{$lang.sslw_csr}</h3>
            <div class="table-responsive">
                <table class="table table-striped">
                    {foreach from=$cert.csr_data key=csrkey item=csrval}
                        <tr class="grid-6">
                            {assign var="lang_key" value=$csr_keys[$csrkey]}
                            <td><strong>{$lang[$lang_key]}</strong></td>
                            <td>{$csrval}</td>
                        </tr>
                    {/foreach}
                </table>
            </div>
            <button class="btn btn-default" type="button" id="show-csr">{$lang.ssl_show_csr}</button>
            {if $cert.private_key}<button class="btn btn-default" type="button" id="show-private-key">{$lang.ssl_show_private_key}</button>{/if}
            <div style="margin-top: 20px;">
                <div id="show-csr-content" style="display: none;">
                    <h3>{$lang.ssl_csr}</h3>
                    <pre>{$cert.csr}</pre>
                </div>
                {if $cert.private_key}
                    <div id="show-private-key-content" style="display: none;">
                        <h3>{$lang.ssl_private_key}</h3>
                        <pre>{$cert.private_key}</pre>
                    </div>
                {/if}
            </div>
        </div>
        <hr/>
        {securitytoken}
    </form>
    {if in_array($cert.status, array('Processing', 'Awaiting Validation')) && $dcv}
        <h3>{$lang.ssl_dcv}</h3>
        {if $cert.dcv == 'dns'}
            <form action="{$widget_url}&act=verify" method="POST">
                <p>{$lang.ssl_dcv_dns1}</p>
                <ol>
                    <li>{$lang.ssl_dcv_dns2}</li>
                    <li>{$lang.ssl_dcv_dns3} <br/><br/>
                        {foreach from=$dcv item=dcvn key=dcvname}
                            <p>
                                {if $dcvn.status}
                                    <span class="pull-right right label label-{$dcvn.status.class}">{$dcvn.status.name}</span>
                                {/if}
                                <strong>{$lang.ssl_for} {$dcvname}:</strong>
                            </p>
                            <pre id="zone-{$dcvn.domain}" style="overflow: auto; white-space: pre">
                                <code>{$dcvn.name} 3600 IN {$dcvn.type} {$dcvn.content}</code>
                            </pre>
                        {/foreach}
                    </li>
                </ol>
                {securitytoken}
            </form>
        {elseif $cert.dcv == 'http' || $dcv.type == 'https'}
            <form action="{$widget_url}&act=verify" method="POST">
                <p>{$lang.ssl_dcv_http1}</p>
                <ol>
                    <li>
                        <a href="{$widget_url}&act=dcvfile" target="_blank">{$lang.ssl_dcv_http2}</a>
                    </li>
                    <li>
                        {$lang.ssl_dcv_http3} <br/><br/>
                        {foreach from=$dcv item=dcvn key=dcvname}
                            <p>
                                {if $dcvn.status}
                                    <span class="pull-right right label label-{$dcvn.status.class}">{$dcvn.status.name}</span>
                                {/if}
                                <strong>{$lang.ssl_for} {$dcvname}:</strong>
                            </p>
                            <pre id="zone-{$dcvn.domain}" style="overflow: auto; white-space: pre">
                                <code>{$dcvn.url}</code>
                            </pre>
                        {/foreach}
                    </li>
                </ol>
                {securitytoken}
            </form>
        {/if}
        <hr>
    {/if}
</div>
{literal}
<script>
    $('#show-csr, #show-private-key').on('click', function () {
       var id = $(this).attr('id'),
           content = $('#' + id + '-content');
       if (content.is(':visible')) {
           content.slideUp('slow');
       } else {
           content.slideDown('slow');
       }
    });
</script>
{/literal}