{if $wechat_qrcode}
    <div style="text-align: center">
        <img src="https://api.qrserver.com/v1/create-qr-code/?data={$wechat_qrcode}&size=220x220"/>
        <label style="margin-top: 20px;">{$lang.wechat_qr_code}</label>
    </div>
{else}
    <div style="text-align: center">
        <label>{$lang.wechat_qr_code_error}</label>
    </div>
{/if}

