<div class="text-block clear clearfix">

    {include file='affiliates/summary.tpl'}
    
    <div class="clear clearfix">
        <div class="table-box">
            <div class="table-header">
                {if $payout}
                <div class="right-btns">
                </div>
                {/if}
                <h6>{$lang.affiliate}</h6>
                <p class="inline-block header-p">{$lang.Statistics}</p>
            </div>
            <table class="table table-striped table-hover">
                <tr>
                    <td>{$lang.Commissions}:</td>
                    <td><strong>{$stats.monthly_commision}</strong> / <strong>{$stats.total_commision}</strong> ({$lang.thismonth} / {$lang.total})</td>
                </tr>
                <tr class="even">
                    <td>{$lang.referred}</td>
                    <td class="cell-border">{$stats.monthly_visits} / {$stats.total_visits} ({$lang.thismonth} / {$lang.total})</td>
                </tr>
                <tr >
                    <td>{$lang.singupreferred}</td>
                    <td class="cell-border">{$stats.monthly_singups} / {$stats.total_singups} ({$lang.thismonth} / {$lang.total})</td>
                </tr>
                <tr class="even">
                    <td>{$lang.curbalance}</td>
                    <td class="cell-border">{$affiliate.balance|price:$affiliate.currency_id}</td>
                </tr>
                <tr>
                    <td>{$lang.landingpage}<a href="#" class="vtip_description" title="{$lang.landurldescr}" ></a></td>
                    <td><a href="{$landingpage}" data-toggle="modal" data-target="#landinglink" data-remote="false" style="font-weight:bold">{$landingpage}</a></td>
                </tr>
            </table>
        </div>
        {if $integration_code!=''}
          <div class="row">
          <div class="span6">
          <h3>{$lang.intcodes}</h3>
          <pre class="prettyprint linenums">{$integration_code|escape}</pre>
          </div>
          <div class="span6">
          
          
          <h3>{$lang.preview}</h3>
          {$integration_code}
          </div>
          <div class="clear"></div>
          </div>
        
        {/if}
    </div>
</div>
 <form method="POST" action="{$ca_url}affiliates/" class="form-horizontal">
<div id="landinglink" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="refModal" aria-hidden="true">
    
        <div class="modal-header">
            <h3 id="refModal">{$lang.landingpage}</h3>
        </div>
        <div class="modal-body">
            <label class="control-group">
                <p>{$lang.enternewlandingurl}</p>
                <input type="text" name="landingurl" placeholder="{$landingpage}" class="span5" id="lpi">
            </label>
        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">{$lang.close}</button>
            <button class="btn btn-primary" id="lpi_s">{$lang.savechanges}</button>
        </div>
        
    {literal}
    <script type="text/javascript">
        $('#lpi').bind('keyup change input', function(){
            var t = $(this),
                v = t.val(),
                b = $('#lpi_s');
            if(v.length && !v.match(new RegExp("^https?://"+window.location.hostname.replace(/\./g,'\\.')+"/",'i'))){
                t.parent().addClass('error');
                b.prop('disabled',true);
            }else{
                t.parent().removeClass('error');
                b.prop('disabled',false);
            }  
        });
    </script>
    {/literal}
</div>
</form>