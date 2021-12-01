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