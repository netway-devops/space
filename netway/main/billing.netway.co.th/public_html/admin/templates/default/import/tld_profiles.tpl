<div id="listproducts">
    {if $profiles}
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
            <thead>
            <tr>
                <th>Name</th>
                <th width="30%">Description</th>
                <th width="20%">Status</th>
                <th width="300px"></th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$profiles item=profile name=cat}
                <tr class="havecontrols">
                    <td class="name">
                        <a href="?cmd=importaccounts&action=tld_profile&id={$profile.id}" class="direct">{$profile.name}</a>
                    </td>
                    <td>{$profile.description}</td>
                    <td>
                        {if $lang[$profile.status]}{$lang[$profile.status]}
                        {else}{$profile.status}
                        {/if}
                    </td>
                    <td style="width: 300px; text-align: right;">
                        <a href="#" class="btn btn-sm btn-info" onclick=" if (confirm('Do you really want to update current TLD prices?')) execute_price_update({$profile.id});">Update prices with current profile</a>
                        <a href="?cmd=importaccounts&action=tld_profile&id={$profile.id}" class="menuitm menu-auto">
                            <span style="color: red">{$lang.Edit}</span>
                        </a>
                        <a href="?cmd=importaccounts&action=tld_profile&make=remove&id={$profile.id}&security_token={$security_token}" onclick="return confirm('Do you really want to remove this profile?');" class="menuitm menu-auto ajax">
                            <span class="delsth"></span>
                        </a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
            <tbody>
            <tr>
                <th width="20"></th>
                <th>
                    <a class="btn btn-sm btn-success" href="?cmd=importaccounts&action=tld_profile">Add TLD profile</a>
                </th>
            </tr>
            </tbody>
        </table>
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>Add new TLD profile</h1>
                <p class="clear">
                    Here you can create different price import profiles. Import profile is automatically executed by cron, allowing your TLD prices to be up-to-date with registry price changes.
                </p>
                <a class="new_add new_menu" href="?cmd=importaccounts&action=tld_profile" style="margin-top:10px">
                    <span>Add TLD profile</span>
                </a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
</div>

<div id="taskexec" style="display:none">
    <h2 style="margin-bottom: 5px;" id="taskname">{$lang.taskrunning} <span></span></h2>
    <div id="taskindicator" style="display:none;padding:5px;text-align: center">
        <img src="ajax-loading.gif" alt="" />
    </div>
    <div id="output" style="display:none;">
        {$lang.taskoutput}
        <div class="consoleout">
            <pre></pre>
        </div>
    </div>
</div>

<script>
    {literal}
        function execute_price_update(id) {
            var d = 0,
                name = 'tldPriceAutoUpdate',
                nicename = 'TLD Price update';
            $('#taskname span').text(nicename);
            $('#output').hide();
            $('#taskindicator').show();
            $.facebox({div: '#taskexec'});
            $.get("?cmd=configuration&action=executetask&task=" + name, {debug: 0, id: id}, function (data) {
                $('#facebox #output pre').text(data);
                $('#facebox #output').show();
                $('#facebox #taskindicator').hide();
                $('#taskindicator').hide()
            });
            return false;
        }
    {/literal}
</script>