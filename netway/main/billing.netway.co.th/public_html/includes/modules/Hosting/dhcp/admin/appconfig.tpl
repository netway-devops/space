<div class="container">
    <div class="row">
        <div class="col-md-6">
            {include file='ajax.servers.tpl' custom_template=false}
        </div>
        <div class="col-md-6 panel panel-default">
            <div class="panel-body">
                <strong>Configuration mode</strong>
                <ul style="padding-left: 1.2em">
                    <li>
                        <strong>Dedicated files</strong> - settings will be written to path specified in configuration, overwriting
                        previous config. You are expected to <code>include</code> those files in your dhcp configuration.
                    </li>
                    <li>
                        <strong>Injected configuration</strong> - files specified in configuration will be updated, dhcp settings will be
                        injected between special comment tags
                        <code>bof:ipam-v4</code> and <code>eof:ipam-v4</code> for IPv4 and <code>bof:ipam-v6</code> and
                        <code>eof:ipam-v6</code> for IPv6.
                    </li>
                </ul>
                {literal}
                    <pre>#Example

subnet 192.168.100.0 netmask 255.255.255.0 {
    range 192.168.100.50 192.168.100.150;
}

# bof:ipam-v4
# IPv4 configuration well be injected here
# eof:ipam-v4
</pre>
                {/literal}
            </div>
        </div>
    </div>
</div>