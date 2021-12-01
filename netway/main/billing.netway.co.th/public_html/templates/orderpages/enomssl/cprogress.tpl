<div id="progress-indicator">
	<div class="progress-el {if $progress>1}progress-done{else}progress-active{/if}">
	<span class="step">01</span> {if $progress>1}<a href="{$ca_url}cart&do=1">{$lang.en_certtype}</a>{else}{$lang.en_certtype}{/if}
	</div>
	<div class="progress-el {if $progress>2}progress-done{elseif $progress==2}progress-active{/if}">
	<span class="step">02</span> {if $progress>2}<a href="{$ca_url}cart&do=2">{if $nocsr}{$lang.en_cn}{else}{$lang.en_csr}{/if}</a>{else}{if $nocsr}{$lang.en_cn}{else}{$lang.en_csr}{/if}{/if}
	</div>
	<div class="progress-el {if $progress>3}progress-done{elseif $progress==3}progress-active{/if}">
	<span class="step">03</span> {if $progress>3}<a href="{$ca_url}cart&do=3">{$lang.en_contacts}</a>{else}{$lang.en_contacts}{/if}
	</div>
	<div class="progress-el {if $progress>4}progress-done{elseif $progress==4}progress-active{/if}">
	<span class="step">04</span> {if $progress>4}<a href="{$ca_url}cart&do=4">{$lang.config_options}</a>{else}{$lang.config_options}{/if}
	</div>
	<div class="progress-el progress-last  {if $progress>4}progress-active{/if}">
	<span class="step">05</span> {$lang.en_payment}
	</div>
</div>
