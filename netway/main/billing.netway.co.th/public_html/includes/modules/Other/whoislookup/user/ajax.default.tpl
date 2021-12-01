{if $whois}
    {if $check.status == 'ok'}
        <div style="text-align: center;margin:20px;font-size:20px">
            <strong>{$domain}</strong> - {$lang.availorder} <a href="?cmd=checkdomain&action=checkdomain&singlecheck=1&register=1&sld={$sld}&tld={$tld}" class="button button-success btn btn-success">{$lang.regdomain}</a>
        </div>
    {/if}
    <div class="well card card-body bg-light">
        <pre style="border:none">{$whois}</pre>
    </div>
{/if}