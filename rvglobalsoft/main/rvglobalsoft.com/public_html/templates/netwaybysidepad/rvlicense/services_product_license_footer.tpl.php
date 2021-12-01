<div class="top-btm-padding">
            {if $cid}
                {foreach from=$offer item=oo}
                    {if $cid==$oo.id && $oo.visible=='1'}
                        <form method="post" action="{$ca_url}cart&cat_id={$cid}" style="display:inline-block;">
                            <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}</button>
                            {securitytoken}</form>
                        {/if}
                    {/foreach}
                {/if}
                
        </div>