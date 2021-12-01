{include file='header.tpl'}

<script type="text/javascript" src="templates/default/js/ace/ace.js"></script>
<form action="" method="post" >
    <div class="container-fluid" style="padding-top:14px;padding-bottom:14px;">

        <div class="row">
            <div class="col-md-12">
                Use following javascript samples to render details about your products on your external website.<br/><br/>
                Common additional url arguments to use in code samples below:
                <ul>
                    <li><strong><code>&amp;format=javascript</code></strong> - output format to render, available formats: <code>javascript json text</code></li>
                    <li><strong><code>&amp;currency=USD</code></strong> - currency to output price in, available currencies: <code>{foreach from=$currencies item=c}{$c.iso} {/foreach}</code></li>
                    <li><strong><code>&amp;language=english</code></strong> - language to output names/descriptions in: <code>{foreach from=$clanguages item=c}{$c} {/foreach}</code></li>
                    <li><strong><code>&amp;cycle=m</code></strong> - product billing cycle to return price for, all cycles (m-monthly, a-annually, p4 - 4 years, p5 - 5 years etc): <code>{foreach from=$cycles item=c}{$c} {/foreach}</code></li>
                    <li><strong><code>&amp;hidecurrency</code></strong> - hide currency name/formatting</code></li>

                </ul>
                Domain only additional url arguments
                <ul>
                    <li><strong><code>&amp;period=1</code></strong> - registration period in years, ie <code>1</code></li>
                    <li><strong><code>&amp;category_id=1</code></strong> - id of domain category to look in</li>

                </ul>
            </div>

        </div>

        {foreach from=$samples item=sample}

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-8">
                <strong>{$sample.name}</strong>
                <pre>&lt;script src="{$system_url}?cmd=integrator&{$sample.url}"&gt;&lt;/script&gt;</pre>
            </div>
            <div class="col-md-4">
                Sample output:
                <pre>document.write('{$sample.sample|addslashes}');</pre>
            </div>
        </div>
        {/foreach}


        {foreach from=$domainsamples item=sample}

            <div class="row" style="margin-top: 20px;">
                <div class="col-md-8">
                    <strong>{$sample.name}</strong>
                    <pre>&lt;script src="{$system_url}?cmd=integrator&{$sample.url}"&gt;&lt;/script&gt;</pre>
                </div>
                <div class="col-md-4">
                    Sample output:
                    <pre>document.write('{$sample.sample|addslashes}');</pre>
                </div>
            </div>
        {/foreach}
    </div>
    {securitytoken}
</form>
