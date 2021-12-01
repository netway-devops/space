<div class="row">
    {foreach from=$series item=data key=name}
        {foreach from=$data.data item=r}



                {foreach from=$r item=col key=k}
                    <div class="col-md-4">
                        <div class="stat-item">
                            <div class="stat-data"><span>{if is_numeric($col) && !is_int($col)}{$col|price:$currency}{else}{$col}{/if}</span></div>
                            <div class="stat-label">{$k}</div>
                        </div>
                    </div>
                {/foreach}
            {break}
        {/foreach}




    {/foreach}
</div>