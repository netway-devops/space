{include file='dedicated/cart_header.tpl'}

<form method="post" id="step2form" action="?cmd=cart" class="form-horizontal">
    <input type="hidden" name="action" value="addconfig"/>
    <input type="hidden" name="do" value="{$progress}"/>
	<div class="content">
		<div id="left">
			<h1>
				<span class="s1"></span>
				<span class="s2">
					{if $progress==2}
						{$lang.serverconfiguration}
					{elseif $progress==3}
						{$lang.networkconfiguration}
					{elseif $progress==4}
						{$lang.software}
					{/if}
				</span>
			</h1>
			<ul id="productS">
                {if $product.hostname && $progress==3}
                    <li id="poptio_{$cf.id}" class="poption_">
                        <ul class="cfl">
                            <li>
                                <span></span> {$lang.hostname}
                            </li>
                            <li class="input">
                                <input name="hostname" value="{$cart_contents[0].domain}"  class="styled pinput_" type="text" />
                            </li>
                            <li class="clear" style="float:none"><br/></li>
                        </ul>
                    </li>
                {/if}
				{if $custom}
					{include file='dedicated/cart_customfields.tpl'}
				{/if}


			</ul>
		</div>
		{include file='dedicated/cart_sidemenu.tpl'}
	</div></form>
{include file='dedicated/cart_footer.tpl'}