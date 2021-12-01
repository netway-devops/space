<ul class="hbnav breadcrumb">
    <li class="step {if  $do!='accounts'}active{/if}">
        <a {if $section != 'default'} href="?cmd=module&module={$moduleid}"{/if}><span>Select Server</span></a>
    </li>
    <li class="step {if  $do=='accounts'}active{/if}">
        <a><span>Result</span></a>
    </li>
</ul>

<div  style="margin: 20px">



    {if $do=='accounts'}

    {if $accounts}

        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <tbody>
            <tr>
                <th >Match</th>
                <th>{$lang.accounthash}</th>
                <th>{$lang.clientname}</th>
                <th>{$lang.Domain}</th>
                <th>{$lang.Service}</th>
                <th>{$lang.billingcycle}</th>
                <th>{$lang.Status}</th>
                <th>{$lang.nextdue}</th>
                <th width="20"></th>
            </tr>
            </tbody>
            <tbody id="updater">
            {foreach from=$accounts item=account}
                <tr >
                    <td class="toloads" id="{$account.id}"><img src="{$template_dir}img/ajax-loading2.gif" alt="working"/></td>

                    <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}">{$account.id}</a></td>
                    <td><a href="?cmd=clients&action=show&id={$account.client_id}">{$account.firstname} {$account.lastname}</a></td>
                    <td>{$account.domain}</td>
                    <td>{$account.name}</td>

                    <td>{$lang[$account.billingcycle]}</td>
                    <td><span class="{$account.status}">{$lang[$account.status]}</span></td>
                    <td>{if $account.next_due == '0000-00-00'}-{else}{$account.next_due|dateformat:$date_format}{/if}</td>
                    <td><a href="?cmd=accounts&action=edit&id={$account.id}&list={$currentlist}" class="editbtn">{$lang.Edit}</a></td>

                </tr>
            {/foreach}

            </tbody>

        </table>
        <script type="text/javascript">{literal}
            function loadStatuses() {
                if ($('.toloads').length<1)
                    return;
                var id=$('.toloads').eq(0).attr('id');
                $.post('?cmd=module&module=domainresolver&do=account',{account_id:id},function(data){
                    var resp = parse_response(data);
                    if(resp.length>1) {
                        $('.toloads').eq(0).html(resp);
                        $('.toloads').eq(0).removeClass('toloads');
                        loadStatuses();
                    }

                });
            }
            appendLoader('loadStatuses');
            {/literal}</script>
    {else}
        This server dont have accounts suitable to resolve.
    {/if}
{else}


        <form action="?cmd=module&module={$moduleid}&do=accounts" id="f1" method="post">

            <label>Pick app :</label>
            <select name="server_id"  class="form-control chosen">
                <option value="0">Select App connection</option>

                {foreach from=$groups item=group}
                    <optgroup label="{$group.name}">
                        {foreach from=$group.servers item=server}
                            <option value="{$server.id}">{$server.name}</option>
                        {/foreach}
                    </optgroup>
                {/foreach}

            </select>
            <hr>
            <input type="submit" value="Continue" class="btn btn-primary" />

        </form>
    {/if}
</div>

{literal}
<script>
    $(function () {

        $(".chosen").chosenedge({
            width: "100%",
            disable_search_threshold: 5,
            allow_single_deselect: true
        });
    });

</script>{/literal}