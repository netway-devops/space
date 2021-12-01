
<div class="onapptab" id="provisioning_tab">
    To start please configure and select server above.<br/>

    <div class="onapp_opt {if $default.type=='single'}onapp_active{/if} ">
        <table border="0" width="500">
            <tr>
                <td class="opicker">
                    <input type="radio" name="options[type]" id="single_vm" value="single" {if $default.type=='single'}checked='single'{/if} />
                </td>
                <td class="odescr">
                    <h3>Single VPS</h3>
                    <div class="graylabel">One account in HostBill = 1 virtual machine in Virtualizor</div>
                </td>
            </tr>
        </table>
    </div>
    <div class="onapp_opt {if $default.type=='cloud'}onapp_active{/if} ">
        <table border="0" width="500">
            <tr>
                <td class="opicker">
                    <input type="radio" name="options[type]" id="cloud_vm" value="cloud" {if $default.type=='cloud'}checked='checked'{/if} />
                </td>
                <td class="odescr">
                    <h3>Cloud Hosting</h3>
                    <div class="graylabel">Your client will be able to create machines by himself in HostBill interface </div>
                </td>
            </tr>
        </table>
    </div>

    <div class="nav-er" id="step-1">
        <a href="#" class="next-step">Next step</a>
    </div>

</div>
