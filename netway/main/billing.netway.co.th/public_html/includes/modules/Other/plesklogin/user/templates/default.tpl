<h1 class="invoices2">Choose an account</h1>
{if $accounts}
    <table class="table table-bordered table-striped ">
        <thead>
            <tr>
                <th>Account ID</th>
                <th>Domain</th>
                <th>Username</th>
                <th width="120"></th>
            </tr>
        </thead>
        <tbody>
        {foreach from=$accounts item=account name=foo}
            <tr>
                <td align="center">{$account.id}</td>
                <td align="center">{$account.domain}</td>
                <td align="center">{$account.username}</td>
                <td align="center">
                    <a href="?cmd=plesklogin&action=makelogin&account_id={$account.id}" class="btn btn-default btn-xs">Log in</a>
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    <br />
{else}
    <div>{$lang.nothing}</div>
{/if}


