{if $key}
    <div class="body-content">
        <div class="section">
            <h3 id="hdrViewKey">
                {$lang.cpanel_csrs_view_cert}
            </h3>
            <p class="description">
                {$lang.cpanel_csrs_view_cert_desc}
            </p>
        </div>
        <div class="section">
            <div class="control-group">
                <label for="domain" id="lblDomain">{$lang.cpanel_ssl_domain} </label>
                <div class="row-fluid">
                    <div class="span6">
                        {$name}
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label for="encoded-key" id="lblEncodedKey">{$lang.cpanel_csrs_encoded} </label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="encoded-key">{$key}</pre>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="decoded-key" id="lblDecodedKey">{$lang.cpanel_csrs_decoded} </label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="decoded-key">{$keydecoded}</pre>
                    </div>
                </div>
            </div>
        </div>
        <a href="{$widget_url}&act=keys" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            {$lang.cpanel_ssl_go_back}
        </a>
    </div>
{else}

    <div class="body-content">
        <div class="section">
            <h3 id="hdrCsr">
                {$lang.cpanel_csrs_cert_request}
            </h3>
            <p class="description" id="descCsr">
                {$lang.cpanel_csrs_cert_request_desc}
            </p>
            <h3 id="hdrCsrOnserver">{$lang.cpanel_csrs_request_to_server} </h3>
            <table id="ssltable" class="sortable table table-striped">
                <thead>
                    <tr>
                        <th class=" clickable">{$lang.cpanel_domain}</th>
                        <th style="width: 60px;" >{$lang.cpanel_actions}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$list item=entry}
                        <tr class="">
                            <td class="name-column">
                                <div title="test" class="name-column column">{$entry.host|escape}</div>
                            </td>

                            </td>
                            <td class="actions-column">
                                <a href="{$widget_url}&act=csrs&key={$entry.host|escape:'url'}" class="cp-btn" ><span class="fa fa-pencil"></span></a>
                                <a href="{$widget_url}&act=csrs&del={$entry.host|escape:'url'}&security_token={$security_token}"
                                   class="cp-btn" onclick="return confirm('{$lang.cpanel_delete_entry_q}')"><span class="fa fa-trash"></span></a>
                            </td>
                        </tr>
                    {foreachelse}

                        <tr>
                            <td class="errors" colspan="4" id="nocsrErrorMsg">{$lang.cpanel_csrs_no_cert} </td>
                        </tr>

                    {/foreach}
                </tbody>
            </table>
        </div>

        <div class="section">
            <h3 id="hdrGenerateCsr">{$lang.cpanel_csrs_generate_cert} </h3>
            <div class="cjt-pagenotice-container cjt-notice-container" id="cjt_pagenotice_container"></div>
            <p class="description" id="descNewsrc">
                {$lang.cpanel_csrs_generate_cert_desc1}

                {$lang.cpanel_csrs_generate_cert_desc2}
            </p>
            <form name="csrform" id="csrform" method="post" action="{$widget_url}&act=csrs">
                {include file="`$widget_dir`gencert.tpl"}
            </form>
        </div>


        <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            {$lang.cpanel_csrs_return}
        </a>

    </div>
{/if}