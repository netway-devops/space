<div class="row">
    <div class="col-lg-6">
        <div class="form-group">
            <label for="field1">Private key file location (.json)</label>
            <input type="text" name="field1" id="field1" class="form-control" value="{$server.field1}"
                   autocomplete="off"/>
        </div>
        <div class="form-group">
            <label for="gusername">Domain Administrator Email</label>
            <input type="text" name="username" id="gusername" value="{$server.username}" class="form-control"/>
        </div>


        {if $server.id && $server.id!='new'}
        <div class="form-group">
            <label for="">Setup import cache </label>
            <p>If your import from Extras->import accounts fails with timeouts, use this button to cache import data in background and use cached data on next import</p>

            <br/>
            <a href="?cmd=gsuite&action=cacheaccounts&server_id={$server.id}&security_token={$security_token}" onclick="return confirm('Are you sure?');" class="btn btn-default" >Setup import cache</a>
        </div>
        {/if}
    </div>
    <div class="col-lg-6" id="googleapps-conf">
        <strong>Setup API access</strong>
        <p>
            Create new project on
            <a href="https://console.developers.google.com" target="_blank"
               class="external">https://console.developers.google.com</a>
            <br/>
            Open it and navigate to <code>APIs & services > Library</code>, activate:
        </p>
        <pre>Admin SDK Google
Apps Reseller API</pre>

        <p>
            More info:
            <a href="https://developers.google.com/admin-sdk/reseller/v1/how-tos/prerequisites" target="_blank"
               class="external">https://developers.google.com/admin-sdk/reseller/v1/how-tos/prerequisites</a>
        </p>
        <br/>
        <p>
            <strong>Create Service account </strong><br/>
            Navigate to <code>Identity & Access management (IAM) > Service accounts</code> or <code>Administration >
                Service
                accounts</code>.
        </p>

        <p>
            Create new <b>Service Account</b> with <b>Furnish a new private key</b> and <b>Enable G Suite Domain-wide
                Delegation</b> options enabled, <b>Key type</b> has to be set to <b>JSON</b>.
        </p>
        <p>
            More info:
            <a href="https://developers.google.com/accounts/docs/OAuth2ServiceAccount#creatinganaccount"
               target="_blank" class="external">https://developers.google.com/accounts/docs/OAuth2ServiceAccount#creatinganaccount</a>
        </p>

        <br/>
        <strong>Authorize service account</strong>
        <p>
            From the domain console, authorize your new service account going under
            <code>Security > Advanced settings > Manage API client access</code> and add your
            <strong>Client ID</strong> (you can find it in the API console)
            with scope:
        </p>
        <pre>{foreach from=$scopes item=scope}{$scope},
{/foreach}</pre>

        More info:
        <a href="https://developers.google.com/accounts/docs/OAuth2ServiceAccount#delegatingauthority"
           target="_blank" class="external">https://developers.google.com/accounts/docs/OAuth2ServiceAccount#delegatingauthority</a>

        <p>
            When you <b>Authorize service account</b> you may need to wait some time before those changes take effect.
        </p>
    </div>
</div>
<br/>
