{*
 * NOC-PS Hostbill module
 * Provisioning form template
 *
 * Copyright (C) Maxnet 2010-2012
 *
 * You are free to modify this module to fit your needs
 * However be aware that you need a NOC-PS license to actually provision servers
 *}

{if $status}
    {* BEGIN PROVISIONING STATUS *}
    <div class="wbox">
        <div class="wbox_header">Provisioning status</div>
        <div class="wbox_content">

            <p>
                Your server is currently being provisioned... Be aware that this could take 10+ minutes to complete...
            </p>

            <form name="prov" method="post" action="">
                <input type="hidden" name="nps_nonce" value="{$nonce}"/>

                <table width="100%" cellspacing="10" cellpadding="10">
                    <tr>
                        <td width="150" class="fieldarea">MAC-address</td>
                        <td>{$mac}</td>
                    </tr>

                    <tr>
                        <td width="150" class="fieldarea">IP-address</td>
                        <td>{$ip}</td>
                    </tr>

                    <tr>
                        <td width="150" class="fieldarea">Hostname</td>
                        <td>{$status.hostname|escape}</td>
                    </tr>

                    <tr>
                        <td width="150" class="fieldarea">Installation profile</td>
                        <td>{$status.profilename|escape}</td>
                    </tr>

                    <tr>
                        <td width="150" class="fieldarea">Last status message</td>
                        <td id="statusmsg">{$status.statusmsg|escape}</td>
                    </tr>

                    <tr>
                        <td>&nbsp;
                        <td><input type="submit" name="cancelprovisioning" value="Cancel provisioning">
                    </tr>

                    <tr>
                        <td colspan=2 align="center"><br><br>Provisioning powered by NOC-PS</td>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
{literal}
    <script type="text/javascript">
        function pollForStatus(oldeventid) {
            $.post(document.location.href, {oldeventid: oldeventid}, function (reply) {

                var e = document.getElementById("statusmsg");

                if (reply.statusmsg) {
                    e.innerHTML = reply.statusmsg;
                    pollForStatus(reply.eventnr);
                } else {
                    e.innerHTML = "<b>Finished!</b>";
                    document.forms.prov.cancelprovisioning.style.visibility = "hidden";
                }

            }, 'json');
        }

        pollForStatus(0);
    </script>
{/literal}

    {* END PROVISIONING STATUS *}
{else}
    <script type="text/javascript">
        {* Function to fill in the 'disklayout', 'package selection' and 'extra' combos depending on profile *}
        function onProfileChange() {ldelim}
            var a = {$addons_json};
            var p = {$profiles_json};
            {literal}
            var f = document.forms.prov;
            var pid = f.profile.value;
            var pr = false;

            for (var k = 0; k < p.length; k++) {
                pr = p[k];
                if (pr.id == pid) {
                    break;
                }
            }

            var t = pr.tags;
            var tags;
            if (t) {
                tags = t.split(' ');
            } else {
                tags = [];
            }

            var packages = [['', 'Standard']];
            var disklayouts = [['', 'Standard']];
            var extras = [['', 'None']];
            var totalAddons = a.length;

            for (var i = 0; i < totalAddons; i++) {
                pr = a[i];
                t = pr.tag;

                for (var j = 0; j < tags.length; j++) {
                    if (t == tags[j]) {
                        var typ = pr.type;
                        var item = [t + ':' + pr.name, pr.descr];

                        if (typ == 'packages') {
                            packages.push(item);
                        } else if (typ == 'disklayout') {
                            disklayouts.push(item);
                        } else {
                            extras.push(item);
                        }

                        break;
                    }
                }
            }

            array2options(f.disklayout, disklayouts);
            array2options(f.packageselection, packages);
            array2options(f.extra1, extras);
            array2options(f.extra2, extras);

            f.disklayout.disabled = (disklayouts.length == 1);
            f.packageselection.disabled = (packages.length == 1);
            f.extra1.disabled = (extras.length == 1);
            f.extra2.disabled = (extras.length < 3);
        }

        function array2options(sel, arr) {
            var opt = sel.options;
            opt.length = 0;

            for (var i = 0; i < arr.length; i++) {
                opt[opt.length] = new Option(arr[i][1], arr[i][0]);
            }
        }

        {/literal}

    </script>
    <div class="wbox">
        <div class="wbox_header">{$lang.Provision}</div>
        <div class="wbox_content">

            {if !$ip && !$error}
            Your order has not been assigned to a server yet!
        </div>
    </div>
    </div>
{/if}

    {if $errormsg}
        <p>
            <b>Error:</b> {$errormsg}
        </p>
    {/if}

    {if $ip}
        <form name="prov" method="post" action="" onsubmit="provbutton.disabled=true; return true;">
            <input type="hidden" name="nps_nonce" value="{$nonce}"/>

            <table width="100%" cellspacing="5" cellpadding="5">
                <tr>
                    <td width="150" class="fieldarea">MAC-address</td>
                    <td>{$mac}</td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">IP-address</td>
                    <td>{$ip}</td>
                </tr>

                {if $ask_ipmi_password}
                    <tr>
                        <td width="150" class="fieldarea">Your server's IPMI password</td>
                        <td><input type="password" name="ipmipassword" style="width: 350px;"></td>
                    </tr>
                {/if}

                <tr>
                    <td width="150" class="fieldarea">Hostname</td>
                    <td><input type="text" name="hostname" style="width: 350px;"></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Installation profile</td>
                    <td><select name="profile" style="width: 350px;" onchange="onProfileChange();">
                            {foreach item=profile from=$profiles}
                                <option value="{$profile.id}"{if $defaultProfile == $profile.id} selected{/if}>
                                    {$profile.name|escape}
                                </option>
                            {/foreach}
                        </select></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Disk layout</td>
                    <td><select name="disklayout" style="width: 350px;">
                        </select></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Package selection</td>
                    <td><select name="packageselection" style="width: 350px;">
                        </select></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Extras</td>
                    <td>
                        <select name="extra1" style="width: 350px;"></select><br><br>
                        <select name="extra2" style="width: 350px;"></select>
                    </td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Root user password</td>
                    <td><input type="password" name="rootpassword" style="width: 350px;"></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Repeat root user password</td>
                    <td><input type="password" name="rootpassword2" style="width: 350px;"></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Regular user name (optional)</td>
                    <td><input type="text" name="adminuser" value="charlie" style="width: 350px;"></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">User password (optional)</td>
                    <td><input type="password" name="userpassword" style="width: 350px;"></td>
                </tr>

                <tr>
                    <td width="150" class="fieldarea">Repeat user password (optional)</td>
                    <td><input type="password" name="userpassword2" style="width: 350px;"></td>
                </tr>

                <tr>
                    <td>&nbsp;
                    <td><input type="submit" name="provbutton"
                               value="Provision server (WARNING: overwrites data on disk)"
                               onclick="return confirm('This will delete all existing data on disk. Are you sure?');">
                </tr>
            </table>
        </form>
        </div></div></div>
        <script type="text/javascript">
            {* Load comboboxes with information of default profile *}
            onProfileChange();
        </script>
    {/if}
{/if}