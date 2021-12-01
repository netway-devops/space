<form action="?cmd=module&module={$moduleid}&action=saverwhois" method="post" id="rwhois-config" style="margin: 10px 0">
    <div class="container-fluid clear">
        <div class="row">
            <div class="col-md-6">

                <div class="form-group">
                    <label for="server">Server hostname</label>
                    <input type="text" value="{$rwhois.server}" placeholder="yourhostbill.install.com" id="server" name="rwhois[server]" class="form-control" >
                    <p class="help-block">Enter your rwhois server hostname, if it runs on same server as your HostBill, it will most likely be set to your HostBill install hostname. This is used when sending "greeting" rwhois response.
                    </p>
                </div>

                <div class="form-group">
                    <label for="pocname">Default POC contact: Name</label>
                    <input type="text" value="{$rwhois.pocname}" placeholder="" id="pocname" name="rwhois[pocname]" class="form-control" >
                </div>

                <div class="form-group">
                    <label for="pocemail">Default POC contact: Email</label>
                    <input type="text" value="{$rwhois.pocemail}" placeholder="" id="pocemail" name="rwhois[pocemail]" class="form-control" >
                </div>
                <div class="form-group">
                    <label for="pocphone">Default POC contact: Phone</label>
                    <input type="text" value="{$rwhois.pocphone}" placeholder="" id="pocphone" name="rwhois[pocphone]" class="form-control" >
                </div>

                <div class="form-group">
                    <label for="techname">Default Tech contact: Name</label>
                    <input type="text" value="{$rwhois.techname}" placeholder="" id="techname" name="rwhois[techname]" class="form-control" >
                </div>

                <div class="form-group">
                    <label for="techemail">Default Tech contact: Email</label>
                    <input type="text" value="{$rwhois.techemail}" placeholder="" id="techemail" name="rwhois[techemail]" class="form-control" >
                </div>
                <div class="form-group">
                    <label for="techphone">Default Tech contact: Phone</label>
                    <input type="text" value="{$rwhois.techphone}" placeholder="" id="techphone" name="rwhois[techphone]" class="form-control" >
                </div>


                <div class="form-group">
                    <label for="netid">Network ID prefix</label>
                    <input type="text" value="{$rwhois.netid}" placeholder="NET-" id="netid" name="rwhois[netid]" class="form-control" >
                    <p class="help-block">This will be used in network:ID, in form of {literal}{PREFIX}{ID}.{NETWORK}{/literal}</p>

                </div>
                <div class="form-group">
                    <label for="techid">Tech contact prefix</label>
                    <input type="text" value="{$rwhois.techid}" placeholder="TECH-" id="techid" name="rwhois[techid]" class="form-control" >
                    <p class="help-block">This will be used in network:Tech-Contact:, in form of {literal}{PREFIX}{ID}.{NETWORK}{/literal}</p>
                </div>


            </div>
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading" id="status">
                        <h3 class="panel-title">RWhois info </h3>
                    </div>
                    <div class="panel-body" >
                        HostBill IPAM plugin allows you to setup RWhois server compatible with rwhois 1.0/1.5 protocol.
                        <br>For server setup details please refer to <a href="https://hostbill.atlassian.net/wiki/spaces/DOCS/pages/127238145/Configuring+RWhois+for+IP+address+manager" target="_blank">documentation</a>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix" style="padding: 0 10px;">
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </div>
    {securitytoken}
    <input type="hidden" name="make" value="save"/>
</form>