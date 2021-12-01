<br />
<a href="?cmd={$cmd}&action=default" class="tstyled {if $action == 'default'}selected{/if}"><strong>Home</strong></a><br />
<h3>Bank info</h3>
กสิกร<br>
url : <a href="https://rt05.kasikornbank.com/paymentgateway/" target="_blank">https://rt05.kasikornbank.com/<br />paymentgateway/</a><br/>
User Name: 750RV2222<br>
Password: peqe5Ke8.<br>
<br>
VEDC กสิกร<br>
url : <a href="https://rt05.kasikornbank.com/paymentgateway/Default.aspx" target="_blank">https://rt05.kasikornbank.com/<br />paymentgateway/Default.aspx</a><br/>
User :  779NETVEDC<br>
password : netwayB(58<br>
<br>
{foreach from=$aBankTransfer key=k item=name}
<a href="?cmd={$cmd}&action=bankinfo&id={$k}" class="tstyled {if $action == 'bankinfo' && $k == $id}selected{/if}">{$name}</a>
{/foreach}
<br />