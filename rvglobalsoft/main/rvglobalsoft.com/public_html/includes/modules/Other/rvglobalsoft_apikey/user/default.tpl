<h1>API Setup </h1>
<div>This API setup will allow you to build a powerful engine for your reselling business on WMH/cPanel and WHMCS. It provides a method to process order from your customer on cPanel and WHMCS, so you can pool together order from your customers located around the world and everywhere into your dashboard.</div>
        
<h1>How to Configure on cPanel </h1>
<div>   
    <ol class="lineheight">
        <li>Connect via SSH to your server as root and download the installer using the command below: 
            <div class="code" style="color:#0066CC; padding:10px 0px;">
                <p>mkdir -p /usr/local/rvglobalsoft;
                cd /usr/local/rvglobalsoft;
                rm -f rvglobalsoftinstaller.tar;
                wget http://download.rvglobalsoft.com/download.php/download/rvglobalsoft-upgrade -O rvglobalsoftauto.tar.bz2;
                tar -xopf rvglobalsoftauto.tar.bz2;
                chmod 755 /usr/local/rvglobalsoft/rvglobalsoft/auto/autorvglobalsoft.cgi;
                /usr/local/rvglobalsoft/rvglobalsoft/auto/autorvglobalsoft.cgi;
                </p>
            </div>
        </li>
        <li>Open root WHM, at the left menu under Plugins section, you will find RVGlobalSoft Manager menu.</li>
        <li>Find RVGlobalSoft Setup Menu.</li>
        <li>Click “agree” to the terms and conditions.</li>
        <li>Save the control panel API Key you get from rvglobalsoft.com.</li>
        <li>If you are the root and need to control and manage how your reseller accounts use the products, please go to Restrict Reseller to Access and grant access to RVGlobalSoft products for your resellers. </li>
    </ol>               
</div>

<h1>How to Configure on WHMCS</h1>
<div>
    <ol class="lineheight">    
        <li> Download RVGlobalSoft WHMCS add-on from the below link and install WHMCS path<br /> 
            <a href="http://download.rvglobalsoft.com/rvglobalsoft_whmcs_addon.tar">http://download.rvglobalsoft.com/rvglobalsoft_whmcs_addon.tar</a>
        </li>
        <li>  Login to use admin console with your admin account. </li>
        <li> Find the Setup menu and then Add-on Module. </li>
        <li> Activate RVGlobalSoft Module and refresh your screen. </li>
        <li> Find Addon menu and choose RVGlobalSoft. Then, click “Agree” to the terms and conditions.</li>
        <li> Save the Billing API Key you get from RVGlobalSoft.com. Then, you can Set up how you can manage your control over the product use rights.</li>
        <li> The system will set up the products and you will be led to RVGlobalSoft Management page.</li>
        <li> Once, you installed RVGlobalSoft Add-on Module, the RVglobalSoft Add-on menu will appear on your management console. </li>
        <!-- 2.9 Set up the control over product use rights.<br />
             2.10 The system will set up the products and you will be led to RVGlobalSoft Management page.<br />
             2.11 Once, you installed RVGlobalSoft Add-on Module, the RVglobalSoft Add-on menu will be your management console. <br /><br />-->
    </ol>
</div>

<div>
    <h1>Secret Key Generator</h1>
        <div id="ajaxMessage" class="message"><!-- Do not remove, MSIE fix --></div>
        <form method="post" id="frmaddview" name="frmaddview" action="">
            <fieldset class="hide">
                <input type="hidden" name="rv_action" value="dogen" />
            </fieldset>
            <p>
                <div>Generate the API Keys to connect with your customer’s billing system. </div>
                <div><label for="resConf[accesskey]"><b>Billing Public Key Generator</b></label></div>
                <textarea name="resConf[accesskey]" id="resConf[accesskey]" readonly="readonly" class="block-genkey">{$showapikey.billing_accesskey}</textarea>
            </p>
                        
            <p>
                <div>Generate the API Keys to connect with your customer’s Home on their control panel. </div>
                <div><label for="resConf[accesskey]"><b>Control Panel Public Key</b></label></div>
                <textarea name="resConf[accesskey]" id="resConf[accesskey]" readonly="readonly" class="block-genkey">{$showapikey.cp_accesskey}</textarea>
            </p>
            <p>
                <button id="submit" onclick="$('#frmaddview').submit();" class="btn">Generate Secret Key and Access Key</button>
            </p>
        </form>
</div>
