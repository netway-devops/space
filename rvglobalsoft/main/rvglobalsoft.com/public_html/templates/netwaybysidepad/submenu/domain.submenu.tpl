

{if $offer}
  <ul class="nav nav-tabs">
    {foreach from=$offer item=o}
    <li {if $action=='services' && $cid==$o.id || $service.category_id==$o.id}class='active-nav'{/if}><a href="{$ca_url}clientarea/services/{$o.slug}/"><div class="nav-bg-fix">{$o.name}</div></a></li>
    {/foreach}
    {if $enableFeatures.domains!='off'}
    <li><a href="{$ca_url}clientarea/domains/"><div class="nav-bg-fix">{$lang.mydomains}</div></a></li>
    {/if}
    <li class="more-hidden"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><div class="nav-bg-fix">
    {$lang.more}<span class="caret"></span>
    </div></a>
        <ul id="more-hidden" class="dropdown-menu">
            <div class="dropdown-padding">
            </div>
        </ul>
    </li>
  </ul>
{/if}