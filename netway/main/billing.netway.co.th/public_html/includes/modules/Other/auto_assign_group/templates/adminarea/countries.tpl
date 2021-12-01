{include file="navbar.tpl"}

<script src="{$moduleurl}js/scripts.js"></script>

{if $action == 'countries'}
    <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
        <tr>
            <th width="50">ID</th>
            <th>Group</th>
            <th>Countries</th>
            <th style="width: 100px;"></th>
        </tr>
        {foreach from=$configs item=config name=fff}
            <tr>
                <td>{$config.id}</td>
                <td style="padding-left:10px" width="150"><a
                            href="?cmd=clients&action=editgroup&id={$config.group_id}"
                            class="isclient isclient-{$config.group_id}">#{$config.group_id} {$config.group_name}</a></td>
                <td>
                    {foreach from=$config._countries item=item}
                        {$item} <br>
                    {/foreach}
                </td>

                <td style="white-space: nowrap;">
                    <a href="?cmd={$modulename}&action=removeconfig&id={$config.id}&security_token={$security_token}&page=countries"
                       onclick="return confirm('Are you sure you want to remove this config?')" style="color: red">Remove</a>
                </td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="3">Nothing found</td>
            </tr>
        {/foreach}
    </table>
{elseif $action == 'addcountries'}
    <div style="padding:15px;">
        <form action="?cmd={$modulename}&action=addcountries" method="POST">
            <table id="tableform" cellpadding="5" style="width: 100%">
                <tbody>
                <tr>
                    <td>
                        <label for="">Group</label>
                    </td>
                    <td>
                        <select class="form-control chosenproducts" name="group_id">
                            {foreach from=$groups item=group}
                                <option value="{$group.id}">#{$group.id} {$group.name}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                </tbody>
                <tbody>
                    <tr>
                        <td>
                            <label for="">Countries</label>
                        </td>
                        <td>
                            <select class="form-control chosenwithall" name="items[]" multiple>
                                {foreach from=$countries key=country_id item=country_name}
                                    <option value="{$country_id}">{$country_name}</option>
                                {foreachelse}
                                    <option disabled>Nothing found</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                </tbody>

            </table>
            <input type="hidden" name="type" value="country">
            <input type="hidden" name="make" value="add">
            <button type="submit" class="btn btn-success" style="margin-top: 20px;">{$lang.savechanges}</button>
            {securitytoken}
        </form>
    </div>
{/if}