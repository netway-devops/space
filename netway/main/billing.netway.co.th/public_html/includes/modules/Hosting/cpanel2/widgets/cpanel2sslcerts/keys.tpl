{if $key}
    <div class="body-content">
        <div class="section">
            <h3 id="hdrViewKey">
                {$lang.cpanel_key_view}
            </h3>
            <p class="description">
                {$lang.cpanel_key_view_desc}
            </p>
        </div>
        <div class="section">
            <div class="control-group">
                <label for="encoded-key" id="lblEncodedKey">{$lang.cpanel_key_encoded}</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="encoded-key">{$key}</pre>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="decoded-key" id="lblDecodedKey">{$lang.cpanel_key_decoded}</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="decoded-key">{$keydecoded}</pre>
                    </div>
                </div>
            </div>
        </div>
        <a href="{$widget_url}&act=keys" id="lnkHomeReturn" class="btn">
            <span class="icon icon-chevron-left"></span>
            {$lang.cpanel_ssl_go_back}
        </a>
    </div>
{else}

    <div class="body-content">
        <div class="section">
            <h3 id="h2Header">
                {$lang.cpanel_key_priv}
            </h3>
            <p class="description" id="descPrivate">
                {$lang.cpanel_key_priv_desc}
            </p>
        </div>
        <div class="section">
            <h3 id="hdrOnserver">{$lang.cpanel_key_on_server}</h3>
            <table id="ssltable" class="sortable table table-striped">
                <thead>
                    <tr>
                        <th >{$lang.cpanel_key_name}</th>
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
                                <a href="{$widget_url}&act=keys&key={$entry.host|escape:'url'}" class="cp-btn"><span class="fa fa-pencil"></span></a>
                                <a href="{$widget_url}&act=keys&del={$entry.host|escape:'url'}&security_token={$security_token}"
                                   class="cp-btn" onclick="return confirm('{$lang.cpanel_delete_entry_q}')"><span class="fa fa-trash"></span></a>
                            </td>
                        </tr>
                    {foreachelse}
                        <tr class="">
                            <td  colspan="4">
                                {$lang.cpanel_key_no_added}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
                <tfoot></tfoot>
            </table>
        </div>

        <div class="section">
            <h3 class="secondary" id="hdrNewPrivate">{$lang.cpanel_key_generate}</h3>
            <p class="description" id="descNewPrivate">
                {$lang.cpanel_key_generate_desc}
            </p>

            <form method="post" name="keyform" action="{$widget_url}&act=keys&gen=1" id="genkey">
                <input type="hidden" value="1" name="do_generate" id="hidDogenerate">
                <div class="control-group">
                    <label for="keysize" id="lblKeysize">{$lang.cpanel_ssl_key_size}
                    </label>
                    <div class="row-fluid">
                        <div class="span6">
                            <select class="form-control" id="keysize" name="keysize">
                                <option value="2048">2,048 {$lang.cpanel_key_bits}</option>
                                <option value="4096">4,096 {$lang.cpanel_key_bits}</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label for="gen-fname" id="lblGenfname">{$lang.cpanel_key_description}</label>
                    <div class="row-fluid">
                        <div class="span6">
                            <input  name="fname" class="form-control" type="text" required />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <input type="hidden" value="" name="ref" id="hidRef">
                    <input type="submit" value="{$lang.cpanel_key_generate}" class="btn btn-flat-primary btn-primary" id="genkey-action">
                </div>
                {securitytoken}
            </form>
        </div>

        <div class="section">
            <h3 class="secondary" id="hdrNewPrivate">
                {$lang.cpanel_key_upload}
            </h3>
            <p class="description" id="descExisting">{$lang.cpanel_key_upload_desc}</p>
            <div class="section">
                <form enctype="multipart/form-data" method="post" action="{$widget_url}&act=keys&paste=1" id="uploadkey">
                    <div class="control-group">
                        <label for="key" id="lblKey">{$lang.cpanel_key_paste}</label>
                        <div class="row-fluid">
                            <div class="span6">
                                <textarea class="form-control" name="key" id="key" dir="ltr"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="up-fname" id="lblUpfname">
                            {$lang.cpanel_key_description}
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input  name="fname" class="form-control" type="text" required />
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <input type="hidden" value="paste" name="type" id="hidType">
                        <input type="submit" value="{$lang.shortsave}" title="{$lang.cpanel_key_click_to_save}" class="btn btn-flat-primary btn-primary" id="pastekey-action">
                    </div>
                    {securitytoken}
                </form>
            </div>

            <div class="or-seperator">
                <strong>{$lang.cpanel_ssl_or}</strong>
            </div>

            <div class="section">
                <form enctype="multipart/form-data" method="post" action="{$widget_url}&act=keys&upload=1" id="uploadkey2">
                    <div class="control-group">
                        <label for="uploadkey-file" id="lblUploadKeyfile">{$lang.cpanel_key_choose_file}</label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input type="file" name="keyfile" id="uploadkey-file">
                            </div>
                            <div class="span6">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="up2-fname" id="lblUp2fname">{$lang.cpanel_key_description}</label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input  name="fname" class="form-control" type="text" required />
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <input type="hidden" value="upload" name="type" id="hidType2">
                        <input type="submit" value="Upload" title="{$lang.cpanel_key_click_to_upload}" class="btn btn-flat-primary btn-primary" id="uploadkey-action">
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
        <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            {$lang.cpanel_csrs_return}
        </a>
    </div>
{/if}