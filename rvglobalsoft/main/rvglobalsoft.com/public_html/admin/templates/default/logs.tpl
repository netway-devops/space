<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.logsection}</h3></td>
      <td  {if $action!='manage'}class="searchbox"{/if}>

          {if $cmd=='emails'}

                 <div id="hider2" style="text-align:right"><a href="?cmd=emails&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
                  <a href="?cmd=emails&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
                  </div>
          {elseif $cmd=='portal_notifications'}

              <div id="hider2" style="text-align:right"><a href="?cmd=portal_notifications&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
                  <a href="?cmd=portal_notifications&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
              </div>
          {elseif $cmd=='queue'}
          {elseif $cmd=='clientcredit'}


              <div id="hider2" style="text-align:right"><a href="?cmd=clientcredit&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
          <a href="?cmd=clientcredit&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
          </div>
          {elseif $action!='manage'}
              <div id="hider2" style="text-align:right">
                  <a href="?cmd=logs&action=getadvanced&log={$action}{if $logfile}&logfile={$logfile}{/if}"
                     class="fadvanced">
                      {$lang.filterdata}
                  </a>
                  <a href="?cmd=logs&action={$action}&resetfilter=1{if $logfile}&logfile={$logfile}{/if}"
                     {if $currentfilter}style="display:inline"{/if}
                     class="freseter">
                      {$lang.filterisactive}
                  </a>
              </div>
          {/if}
          <div id="hider" style="display:none"></div>

      </td>
  </tr>
  <tr>
    <td class="leftNav">

 <a href="?cmd=logs&action=manage"   class="tstyled {if $cmd=='logs' && $action=='manage'}selected{/if}"><strong>{$lang.managelogs}</strong></a>
 <br />
    <a href="?cmd=logs"   class="tstyled {if $cmd=='logs' && $action=='default'}selected{/if}">{$lang.systemlog}</a>
    <a href="?cmd=logs&action=logfiles"   class="tstyled {if $cmd=='logs' && $action=='logfiles'}selected{/if}">Main Log file</a>
    <a href="?cmd=logs&action=adminactivity"   class="tstyled  {if $action=='adminactivity'}selected{/if}">{$lang.adminactivity}</a>
    <a href="?cmd=logs&action=clientactivity"   class="tstyled  {if $action=='clientactivity'}selected{/if}">{$lang.clientactivity}</a>
    <a href="?cmd=logs&action=accountlogs"   class="tstyled  {if $action=='accountlogs'}selected{/if}">{$lang.accountlogs}</a>
    <a href="?cmd=logs&action=domainlogs"   class="tstyled  {if $action=='domainlogs'}selected{/if}">{$lang.domainlogs}</a>
    <a href="?cmd=logs&action=gdprrequests"   class="tstyled  {if $action=='gdprrequests'}selected{/if}">{$lang.gdprrequests}</a>
    <a href="?cmd=clientcredit"   class="tstyled  {if $cmd=='clientcredit'}selected{/if}">{$lang.clientcreditlog}</a>
    <a href="?cmd=logs&action=coupons"   class="tstyled  {if $action=='coupons'}selected{/if}">{$lang.couponsusage}</a>
    <a href="?cmd=logs&action=cancelations"  class="tstyled  {if $action=='cancelations'}selected{/if}">{$lang.canceltitle}</a>
    <a href="?cmd=logs&action=apilog"  class="tstyled  {if $action=='apilog'}selected{/if}">{$lang.apilog}</a>
    <a href="?cmd=logs&action=errorlog"  class="tstyled  {if $action=='errorlog'}selected{/if}">{$lang.errorlog}</a>
    <a href="?cmd=logs&action=fraudlog"  class="tstyled  {if $action=='fraudlog'}selected{/if}">Fraud screening output</a>
    <a href="?cmd=emails" class="tstyled  {if $cmd=='emails'}selected{/if}">{$lang.emailssent}</a>
    <a href="?cmd=portal_notifications" class="tstyled  {if $cmd=='portal_notifications'}selected{/if}">{$lang.notificationssent}</a>
    <a href="?cmd=queue" class="tstyled  {if $cmd=='queue'}selected{/if}">Task queue log</a>

    <a href="?cmd=logs&action=importlog"   class="tstyled  {if $action=='importlog' || $action=='getimportlog'}selected{/if}">{$lang.ticketimplog}</a>

	</td>
    <td  valign="top"  class="bordered">
        <div id="bodycont">
            {if $cmd=='emails'}
                {include file='ajax.emails.tpl'}
            {elseif $cmd=='portal_notifications'}
                {include file='ajax.portal_notifications.tpl'}
            {elseif $cmd=='queue'}
                {include file='queue/logs.tpl'}
            {elseif $cmd=='clientcredit'}
                {include file='ajax.clientcredit.tpl'}
            {elseif $cmd=='logs'}
                {include file='ajax.logs.tpl'}
            {/if}
	    </div>
    </td>
  </tr>
</table>