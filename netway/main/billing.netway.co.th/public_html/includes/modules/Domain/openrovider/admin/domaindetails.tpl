{if $spamexperts}
    <div style="margin:10px 0px;">
        <ul class="accor">
            <li>
                <a>SpamExperts</a>
                <div class="sor">
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>Name</label>
                        </div>
                        <div class="col-sm-10">
                            <span>{$spamexperts.domainName}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>Status</label>
                        </div>
                        <div class="col-sm-10">
                            {if $spamexperts.isActive}
                                <span class="label label-success badge badge-pill badge-success">Active</span>
                            {else}
                                <span class="label label-warning badge badge-pill badge-warning">Inactive</span>
                            {/if}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>User Email</label>
                        </div>
                        <div class="col-sm-10">
                            <span>{$spamexperts.userEmail}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>User Password</label>
                        </div>
                        <div class="col-sm-10">
                            <span style="color: red; cursor: pointer;" onclick="show_password(this);">Click here to show password</span>
                            <span style="display: none;">{$spamexperts.userPassword}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>SMTP Password</label>
                        </div>
                        <div class="col-sm-10">
                            <span style="color: red; cursor: pointer;" onclick="show_password(this);">Click here to show password</span>
                            <span style="display: none;">{$spamexperts.smtpPassword}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>Incoming filter</label>
                        </div>
                        <div class="col-sm-10">
                            {if $spamexperts.products.incoming}
                                <span class="label label-success badge badge-pill badge-success">Active</span>
                            {else}
                                <span class="label label-warning badge badge-pill badge-warning">Inactive</span>
                            {/if}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>Outgoing filter</label>
                        </div>
                        <div class="col-sm-10">
                            {if $spamexperts.products.outgoing}
                                <span class="label label-success badge badge-pill badge-success">Active</span>
                            {else}
                                <span class="label label-warning badge badge-pill badge-warning">Inactive</span>
                            {/if}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>E-mail archiving</label>
                        </div>
                        <div class="col-sm-10">
                            {if $spamexperts.products.archiving}
                                <span class="label label-success badge badge-pill badge-success">Active</span>
                            {else}
                                <span class="label label-warning badge badge-pill badge-warning">Inactive</span>
                            {/if}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <label>Expiration Date</label>
                        </div>
                        <div class="col-sm-10">
                            <span>{$spamexperts.expirationDate|dateformat:$date_format}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 text-right">
                            <a href="?cmd=openrovider&action=sso&name={$details.name}" target="_blank" class="btn btn-sm btn-primary">SSO</a>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
{/if}
{literal}
    <script>
        function show_password(self) {
            $(self).hide().next().show();
        }
    </script>
{/literal}