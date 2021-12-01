<div class="account-info-menu">
    <ul>
        <li{if $action=='details'} class="active"{/if}>
            <div class="menu-pattern"></div>
            <a href="{$ca_url}clientarea/details/">
                <span>
                    <i class="icon-edit-details"></i>
                </span>
                <p>{$lang.details}</p>
            </a>
            <div class="c-border">
                <span></span>
            </div>
            <div class="bg-fix"></div>
        </li>

        <li{if $action=='password'} class="active"{/if}>
            <div class="menu-pattern"></div>
            <a href="{$ca_url}clientarea/password/">
                <span>
                    <i class="icon-change-pass"></i>
                </span>
                <p>
                    {if $clientdata.contact_id}
                        {$lang.changemainpass}
                    {else}
                        {$lang.changepass}
                    {/if}
                </p>
            </a>
            <div class="c-border">
                <span></span>
            </div>
            <div class="bg-fix"></div>
        </li>

        {if $clientdata.contact_id}

            <li{if $action=='profilepassword'} class="active"{/if}>
                <div class="menu-pattern"></div>
                <a href="{$ca_url}clientarea/profilepassword/">
                    <span>
                        <i class="icon-change-pass"></i>
                    </span>
                    <p>{$lang.changemypass}</p>
                </a>
                <div class="c-border">
                    <span></span>
                </div>
                <div class="bg-fix"></div>
            </li>
        {/if}
        {if $enableFeatures.deposit!='off' }
        <li{if $action=='addfunds'} class="active"{/if}>
            <div class="menu-pattern"></div>
            <a href="{$ca_url}clientarea/addfunds/">
                <span>
                    <i class="icon-add-funds"></i>
                </span>
                <p>{$lang.addfunds}</p>
            </a>
            <div class="c-border">
                <span></span>
            </div>
            <div class="bg-fix"></div>
        </li>
        {/if}
        <li{if $action=='ccard'} class="active"{/if}>
            <div class="menu-pattern"></div>
            <a href="{$ca_url}clientarea/ccard/">
                <span>
                    <i class="icon-cc"></i>
                </span>
                <p>{$lang.ccard}</p>
            </a>
            <div class="c-border">
                <span></span>
            </div>
            <div class="bg-fix"></div>
        </li>

        <li{if $action=='profiles' || $cmd=='profiles'} class="active"{/if}>
            <div class="menu-pattern"></div>
            <a href="{$ca_url}profiles/">
                <span>
                    <i class="icon-contact-list"></i>
                </span>
                <p>{$lang.profiles}</p>
            </a>
            <div class="c-border">
                <span></span>
            </div>
            <div class="bg-fix"></div>
        </li>

        <li{if $action=='ipaccess'} class="active"{/if}>
            <div class="menu-pattern"></div>
            <a href="{$ca_url}clientarea/ipaccess/">
                <span>
                    <i class="icon-ip-access"></i>
                </span>
                <p>{$lang.ipaccess}</p>
            </a>
            <div class="c-border">
                <span></span>
            </div>
            <div class="bg-fix"></div>
        </li>

    </ul>
</div>
