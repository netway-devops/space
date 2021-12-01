
{if $newticket}
    {include file='support/addticket.tpl'}
{/if}
{if $ticketcreated}
<div class="wrapper-bg">
    <div class="service-white-bg">
        <div class="text-block clear clearfix">
            <div id="loginbox_container">
                <div class="wbox">
                    <div class="wbox_header">{$lang.ticketcreated}</div>
                    <div class="wbox_content">
                        <div class="alert alert-info">
                           {$lang.tcreatednfo}
                        </div>
                        <center>
                            <a href="{$ca_url}" class="clearstyle btn grey-custom-btn l-btn">{$lang.back}</a>
                            
                        </center>
                        
                    </div>
                </div>
            </div>
		</div>
	</div>
</div>

{/if}

{if $ticket}
    {include file='support/viewticket.tpl'}
{/if}


{if $action=='default' || $action=='_default'}
    {include file='support/listtickets.tpl'}
{/if}




