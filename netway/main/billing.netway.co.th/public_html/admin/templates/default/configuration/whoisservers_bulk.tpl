
<div id="confirm_lookup" hidden bootbox data-title="Bulk update Lookup Engine"
     data-btnclass="btn-success">
    <form action="?cmd=whoisservers&action=bulk&type=lookup" method="post">

        All TLDs supported by selected engine will be updated to use it:
        <select class="form-control" name="engine">
            <option value="0" > Core: Whois</option>
            <option value="-1" > Core: DNS</option>
            {foreach from=$lookup_engines item=e key=k}
                <option value="{$k}"  >{$e}</option>
            {/foreach}
        </select>

        {securitytoken}

    </form>
</div>
<div id="confirm_whois" hidden bootbox data-title="Bulk update WHOIS Engine"
     data-btnclass="btn-success">
    <form action="?cmd=whoisservers&action=bulk&type=whois" method="post">

        All TLDs supported by selected engine will be updated to use it:
        <select class="form-control" name="engine">
            <option value="0" > Core</option>
            {foreach from=$whois_engines item=e key=k}
                <option value="{$k}"  >{$e}</option>
            {/foreach}
        </select>

        {securitytoken}

    </form>
</div>
{literal}
    <script>
        $(function () {
            $('#confirm_lookup').bootboxform();
            $('#confirm_whois').bootboxform();
        });
    </script>
{/literal}