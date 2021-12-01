{if $key}
    <div class="body-content">
        <div class="section">
            <h3 id="hdrViewKey">
                View Private Key
            </h3>
            <p class="description">
                Below is the private key you selected. If you delete this private key from the server, it cannot be recreated. We recommended that you save this private key in a safe place.
            </p>
        </div>
        <div class="section">
            <div class="control-group">
                <label for="encoded-key" id="lblEncodedKey">Encoded Private Key:</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="encoded-key">{$key}</pre>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="decoded-key" id="lblDecodedKey">Decoded Private Key:</label>
                <div class="row-fluid">
                    <div class="span8">
                        <pre id="decoded-key">{$keydecoded}</pre>
                    </div>
                </div>
            </div>
        </div>
        <a href="{$widget_url}&act=keys" id="lnkHomeReturn" class="btn">
            <span class="icon icon-chevron-left"></span>
            Go Back
        </a>
    </div>
{else}

    <div class="body-content">
        <div class="section">
            <h3 id="h2Header">
                Private Keys
            </h3>
            <p class="description" id="descPrivate">
                A private key is used to decrypt information transmitted over SSL. 
                When you create an SSL certificate, the first step is to generate a 
                private key file associated with that SSL certificate. 
                You should generate a private key for each SSL certificate you create. 
                This private key is very important and should be kept confidential. 
                A copy of each private key should be kept in a safe place; there is 
                no way to recover a lost private key.        
            </p>
        </div>
        <div class="section">
            <h3 id="hdrOnserver">Keys on Server</h3>
            <table id="ssltable" class="sortable table table-striped">
                <thead>
                    <tr>
                        <th >Name / Description</th>
                        <th style="width: 60px;" >Actions</th>
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
                                   class="cp-btn" onclick="return confirm('Do You really want to delete this entry?')"><span class="fa fa-trash"></span></a>
                            </td>
                        </tr>
                    {foreachelse}
                        <tr class="">
                            <td  colspan="4">
                                No private keys added.
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
                <tfoot></tfoot>
            </table>
        </div>

        <div class="section">
            <h3 class="secondary" id="hdrNewPrivate">Generate a New Private Key.</h3>
            <p class="description" id="descNewPrivate">
                You should generate a new key file for each certificate you install.
                A key size of 0 bits is recommended.        
            </p>

            <form method="post" name="keyform" action="{$widget_url}&act=keys&gen=1" id="genkey">
                <input type="hidden" value="1" name="do_generate" id="hidDogenerate">
                <div class="control-group">
                    <label for="keysize" id="lblKeysize">Key Size
                    </label>
                    <div class="row-fluid">
                        <div class="span6">
                            <select class="form-control" id="keysize" name="keysize">
                                <option value="2048">2,048 bits</option>
                                <option value="4096">4,096 bits</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label for="gen-fname" id="lblGenfname">Description:</label>
                    <div class="row-fluid">
                        <div class="span6">
                            <input  name="fname" class="form-control" type="text" required />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <input type="hidden" value="" name="ref" id="hidRef">
                    <input type="submit" value="Generate" class="btn btn-flat-primary btn-primary" id="genkey-action">
                </div>
                {securitytoken}
            </form>
        </div>

        <div class="section">
            <h3 class="secondary" id="hdrNewPrivate">
                Upload a New Private Key.
            </h3>
            <p class="description" id="descExisting">If you have an existing key, paste the key below, or upload it to the server.        </p>
            <div class="section">
                <form enctype="multipart/form-data" method="post" action="{$widget_url}&act=keys&paste=1" id="uploadkey">
                    <div class="control-group">
                        <label for="key" id="lblKey">Paste the key below</label>
                        <div class="row-fluid">
                            <div class="span6">
                                <textarea class="form-control" name="key" id="key" dir="ltr"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="up-fname" id="lblUpfname">
                            Description:
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input  name="fname" class="form-control" type="text" required />
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <input type="hidden" value="paste" name="type" id="hidType">
                        <input type="submit" value="Save" title="Click to save the above key to your server." class="btn btn-flat-primary btn-primary" id="pastekey-action">
                    </div>
                    {securitytoken}
                </form>
            </div>

            <div class="or-seperator">
                <strong>or</strong>
            </div>

            <div class="section">
                <form enctype="multipart/form-data" method="post" action="{$widget_url}&act=keys&upload=1" id="uploadkey2">
                    <div class="control-group">
                        <label for="uploadkey-file" id="lblUploadKeyfile">Choose a .key file:</label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input type="file" name="keyfile" id="uploadkey-file">
                            </div>
                            <div class="span6">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="up2-fname" id="lblUp2fname">Description:</label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input  name="fname" class="form-control" type="text" required />
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <input type="hidden" value="upload" name="type" id="hidType2">
                        <input type="submit" value="Upload" title="Click to upload the above key to your server." class="btn btn-flat-primary btn-primary" id="uploadkey-action">
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
        <a href="{$widget_url}" id="lnkHomeReturn" class="btn">
            <span class="fa fa-chevron-left"></span>
            Return to SSL Manager
        </a>
    </div>
{/if}