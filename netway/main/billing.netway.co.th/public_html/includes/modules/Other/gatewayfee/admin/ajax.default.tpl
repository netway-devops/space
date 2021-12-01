<div class="box box-primary  ">
    <div class="box-header">
        <h3 class="box-title">Gateway fees override <i class="fa fa-money  pull-left"></i></h3>
    </div>
    <div class="box-body">
        <div class="">
            Gateway fees are {if $feeenable}
                <span class="Success"><b>Enabled</b></span>
                <a href="?cmd=gatewayfee&action=changefee&do=disable&client_id={$client_id}&security_token={$security_token}" onclick="return confirm('Are you sure?');">Disable</a>
            {else}
                <span class="Unpaid"><b>Disabled</b></span>
                <a href="?cmd=gatewayfee&action=changefee&do=enable&client_id={$client_id}&security_token={$security_token}" onclick="return confirm('Are you sure?');">Enable</a>
            {/if}
        </div>
    </div>
</div>
