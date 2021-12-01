

  <!-- Services -->
  <div class="text-block clear clearfix">
      {if $enableFeatures.kb!='off'}
          <a href="{$ca_url}knowledgebase/">
              <div class="support-home-img">
                  <div class="center-img">
                      <i class="icon-large-knowledgebase"></i>
                  </div>
                  <p>{$lang.knowledgebase}</p>
              </div>
          </a>
          <div class="support-home-table">
              <div class="table-box">
                  <div class="table-header">
                      <div class="right-btns">
                          <a href="{$ca_url}knowledgebase/" class="clearstyle btn grey-custom-btn">{$lang.more} <i class="icon-more-arrow"></i></a>
                      </div>
                      <p class="small-txt bold">{$lang.knowledgebase} </p>
                  </div>
                  <ul class="nav nav-header s-home-list">
                  	{foreach from=$topkb item=kb}
                    	<li><a href="{$ca_url}knowledgebase/category/{$kb.id}/">{$kb.name}</a></li>
              		{foreachelse}
                    	<li>{$lang.nothing}</li>
              		{/foreach}
              	  </ul>
              </div>
          </div>
          
          <div class="dotted-line-m"></div>
       {/if}
       {if $enableFeatures.downloads!='off'}  
          <a href="{$ca_url}downloads/">
              <div class="support-home-img">
                  <div class="center-img">
                      <i class="icon-large-download"></i>
                  </div>
                  <p>{$lang.downloads}</p>
              </div>
          </a>
          <div class="support-home-table">
              <div class="table-box">
                  <div class="table-header">
                      <div class="right-btns">
                          <a href="{$ca_url}downloads/" class="clearstyle btn grey-custom-btn">{$lang.more} <i class="icon-more-arrow"></i></a>
                      </div>
                      <p class="small-txt bold">{$lang.downloads}</p>
                  </div>
                  <ul class="nav nav-header s-home-list">
                  	{foreach from=$topdw item=kb}
                    	<li><a href="{$ca_url}knowledgebase/category/{$kb.id}/">{$kb.name}</a></li>
              		{foreachelse}
                    	<li>{$lang.nothing}</li>
              		{/foreach}
              	  </ul>
              </div>
          </div>
          
          <div class="dotted-line-m"></div>
       {/if}
          <div class="support-home-table">
              <div class="table-box">
                  <div class="table-header">
                      <p class="small-txt bold">{$lang.tickets}</p>
                  </div>
                  <table class="table table-striped table-hover">
                  	{foreach from=$openedtickets item=ticket name=foo}
                        <tr>
                        	<td class="w30"><span class="label-{$ticket.status}">{$lang[$ticket.status]}</span></td>
                            <td class="border-cell"></td>
                        </tr>
                    {foreachelse}
                    	<tr>
                  			<td>{$lang.nothing}</td>
                    	</tr>
                    {/foreach}
                  </table>
              </div>
          </div>
          
          {if $enableFeatures.netstat!='off'}
          <div class="dotted-line-m"></div>
          
          <a href="{$ca_url}netstat/">
              <div class="support-home-img">
                  <div class="center-img">
                      <i class="icon-large-server"></i>
                  </div>
                  <p>{$lang.netstat|capitalize}</p>
              </div>
          </a>
          <div class="support-home-table">
            <div class="table-box support-server-status">
                <p>{$lang.networkstatusintro}  </p>
              <div class="pull-right btn-margin">
                  <a href="{$ca_url}netstat/" class="clearstyle btn grey-custom-btn">{$lang.more} <i class="icon-more-arrow"></i></a>
              </div>
            </div>
          </div>
          
          {/if}
          
        
  </div>
   




