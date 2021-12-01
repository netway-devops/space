{include file="head.tpl"}

<div style="padding:0 10px; margin-top: 15px;">

    <form action="" method="POST" id="doc-file">
        <div class="panel panel-default">

            <div class="panel-heading">
                Details
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label for="urlinput">URL to be called</label>
                    <pre>{$hook.url}</pre>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="urlinput">Status</label>
                        <div class="form-control-static" style="font-size: 1.2em">
                            {if $hook.options.active}
                                <span class="label label-success">Active</span>
                            {else}
                                <span class="label label-default">Disabled</span>
                            {/if}
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="urlinput">Request Content type</label>
                        <div class="form-control-static" style="font-size: 1.2em">
                            {if $hook.content == 'json'}
                                <span class="label label-default">application/json</span>
                            {else}
                                <span class="label label-default">application/x-www-form-urlencoded</span>
                            {/if}
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="urlinput">Created: </label>
                        <div class="form-control-static">
                            {$hook.created_at|dateformat:$date_format}
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="urlinput">Last Update: </label>
                        <div class="form-control-static">
                            {$hook.updated_at|dateformat:$date_format}
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label>Secret</label>
                        <div class="input-group">
                            <input type="text" readonly class="form-control disabled" style="font-family: Monospace"
                                   value="{$hook.secret}" id="secret">
                            <div class="btn btn-default input-group-addon" id="copysecret"> Copy</div>
                            <div class="btn btn-default input-group-addon" id="secretdoc"><i class="fa fa-info"></i></div>
                        </div>
                        <a class="key-regen" id="regen"
                           onclick="return confirm('This will replace your current secret, are you sure you want to continue?')"
                           href="?cmd={$modulename}&action=details&id={$hook.id}&secret=1&security_token={$security_token}">
                            Create new secret
                        </a>
                    </div>
                </div>

            </div>

            <div class="panel-footer">
                <a href="?cmd={$modulename}&action=edit&id={$hook.id}"
                   class="btn btn-primary">Edit webhook</a>

            </div>
        </div>
        {securitytoken}
    </form>

    <div class="panel panel-default">

        <div class="panel-heading">
            Events
        </div>
        <div class="panel-body">

            {include file="ajax.events.tpl" }
        </div>
    </div>

    <div class="panel panel-default" style="margin-top: 15px;">
        <div class="panel-heading">
            Log
        </div>
        <ul class="list-group doc-logs">
            {foreach from=$logs item=log}
                <li class="list-group-item">
                    <span>{$log.created_at|dateformat:$date_format}</span>
                    <span class="label label-{if $log.status < 300 && $log.status >= 200}success{else}error{/if}">{$log.status}</span>
                    <pre class="webhook-log">{$log.log|escape}</pre>
                </li>
                {foreachelse}
                <li class="list-group-item">
                    No logs added yet
                </li>
            {/foreach}
        </ul>
    </div>
</div>

<pre style="display: none" id="validation-code">&lt;?php

$secret = '{$hook.secret}';

//verify that request were sent from your system
$data = file_get_contents('php://input');
$payload = $_SERVER["HTTP_HB_TIMESTAMP"] . $data;

$signature = hash_hmac('sha256', $payload, $secret);
if($signature !== $_SERVER["HTTP_HB_SIGNATURE"])
    die('invalid signature')

// signature valid, verify timestamp
if($_SERVER["HTTP_HB_TIMESTAMP"] < time() - 60)
    die('timestamp older than 60 sec')

</pre>

<div style="display: none" id="validation-doc">
    <p>Requests are signed with your secret key, this allows you to validate that the events were sent by us, not by a third party.</p>
    <h1>Verifying signatures</h1>
    <p>
        <strong>Step 1:</strong>
        Obtain timestamp and signature from response headers, the <code>HB-Signature</code> header contains signature
        that you want to verify and <code>HB-Timestamp</code> contains timestamp uset to generate that signature.
    </p>

    <p>
        <strong>Step 2:</strong>
        Prepare the <code>payload</code> string by concatenating:
    </p>
    <ul>
        <li>The timestamp (as a string)</li>
        <li>The actual request body (json string or x-www-form-urlencoded data)</li>
    </ul>

    <p>
        <strong>Step 3:</strong>
        Compute an HMAC with the SHA256 hash function. Use <code>secret</code> as the key, and use the <code>payload</code> string as the message.
    </p>

    <p>
        <strong>Step 4:</strong>
        Compare the signature in the <code>HB-Signature</code> header to the one computed in step 3.
        If it matches, compute the difference between the current timestamp and the received timestamp, then decide if the difference is within your tolerance.
    </p>

    <p>This example shows how to validate it in PHP</p>
    <pre><div class="validate-code"></div></pre>

</div>

<script type="text/javascript" src="{$moduleurl}webhooks.js"></script>



