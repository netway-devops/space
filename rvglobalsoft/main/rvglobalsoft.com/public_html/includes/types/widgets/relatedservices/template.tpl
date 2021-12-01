<div class="wbox">
        <div class="wbox_header">
            {$lang.relatedservices}
        </div>
        <div class="wbox_content">
            <table class="checker table table-striped" style="width:100%">
                <thead>
                <tr>
                    <th >{$lang.type}</th>
                    <th >#</th>
                    <th >{$lang.domain}</th>
                    <th >{$lang.service}</th>
                </tr>
                </thead>
                <tbody>
                    {foreach from=$relations item=r}

                        <tr>

                        <td>{$lang[$r.type]}</td>
                        <td><a href="{$ca_url}clientarea/{if $r.type=='Domain'}domains/{$r.id}/{$r.domain}/{else}services/-/{$r.id}/{/if}" target="_blank">{$r.id}</a></td>
                        <td><a href="{$ca_url}clientarea/{if $r.type=='Domain'}domains/{$r.id}/{$r.domain}/{else}services/-/{$r.id}/{/if}" target="_blank">{$r.domain}</a></td>
                        <td><a href="{$ca_url}clientarea/{if $r.type=='Domain'}domains/{$r.id}/{$r.domain}/{else}services/-/{$r.id}/{/if}" target="_blank">{$r.product}</a></td>

                        </tr>

                        {foreachelse}

                        <tr>
                        <td colspan="4">{$lang.none}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>

        </div>
</div>

