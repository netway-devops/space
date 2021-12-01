<link href="{$widgetdir_url}widget.css" rel="stylesheet" type="text/css"/>
<div class="widget">
    <h2>{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</h2>
    {if $act == 'contacts'}
        {include file="`$widget_dir`conf_contacts.tpl"}
    {elseif $act == 'csr'}
        {include file="`$widget_dir`conf_csr.tpl"}
    {elseif $act == 'dcv'}
        {include file="`$widget_dir`conf_dcv.tpl"}
    {else}
        <p>
            {$lang.cert_conf_descr}
        </p>
        <hr/>
        <form action="" method="POST">
            <div id="csr">
                <h3>{$lang.cert_csr_title}</h3>
                <p>{$lang.cert_csr_descr}</p>
                <div class="table-responsive">
                    <table class="table table-striped">
                        {foreach from=$csr_data key=csrkey item=csrval}
                            <tr class="grid-6">
                                <td><strong>{$lang[$csrkey]}</strong></td>
                                <td>{$csrval}</td>
                            </tr>
                        {/foreach}
                    </table>
                </div>
                <a href="{$widget_url}&act=csr" class="btn btn-primary">{$lang.change_csr}</a>
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
            {if $san}
                <div id="san">
                    {include file="`$widget_dir`conf_san.tpl"}
                    <hr/>
                </div>
            {/if}

            {if $contacts}
                <div id="contacts">
                    {include file="`$widget_dir`conf_contacts.tpl"}
                    <hr/>
                </div>
            {/if}

            <div class="submit">
                {if $invoice}
                    <div class="alert alert-warning">
                        {$lang.cert_invoice_unpaid|sprintf:$invoicelink}
                    </div>
                {/if}
                {if $opt.dcv}
                    <button type="submit" class="btn btn-success">{$lang.continue}</button>
                {elseif $invoice || $edit}
                    <button type="submit" class="btn btn-success">{$lang.savechanges}</button>
                {else}
                    <button type="submit" class="btn btn-success">{$lang.completeorder}</button>
                {/if}
            </div>
            {securitytoken}
        </form>
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