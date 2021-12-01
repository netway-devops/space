<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>Servers</span></a>
            </li>
            <li class="{if $action == 'add' || $action == 'edit'}active{/if} last">
                <a {if $action != 'add' && $action == 'edit'}href="?cmd={$modulename}&action=add"{/if}><span>{if $action == 'edit'}{$entry.id|upper}{else}New Server{/if}</span></a>
            </li>
        </ul>
    </div>
</div>
{literal}
    <script type="text/javascript">
        $(function () {
            $('#test').click(function (e) {
                e.preventDefault();
                
                var self = $(this);
                $('#whois').addLoader();
                var post = $('#whois_plugin').serializeForm();

                $.post(window.location.href.replace(/action=[^&]*/, 'action=test'), post, function (data) {
                    $('#preloader').remove();
                    $('#status-text').text(data.status);

                    if (data.data)
                        $('#whois').text(data.data);
                })
                return false;
            })
        })
    </script>
{/literal}

{if $action=="edit"}
    <input type="hidden" name="id" value="{$entry.id}"/>
    <input type="hidden" name="edit" value="{$entry.id}"/>
{else}
    <input type="hidden" name="add" value="{$entry.id}"/>
{/if}
<form method="post" action="?cmd={$modulename}&action={$action}" id="whois_plugin"  style="margin: 10px 0" >
    <div class="container-fluid clear">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="tldId">Name</label>

                    {if $action=="edit"}
                        <div class="input-group">
                            <span  class="form-control">{$entry.id}</span>
                            <span class="input-group-btn">
                                <a class="btn btn-default" href="http://www.iana.org/domains/root/db/{$entry.ptld}.html" target="_blank">IANA</a>
                            </span>
                        </div>

                        <input type="hidden" value="{$entry.id}" name="id" />
                    {else}
                        <input type="text" value="{$entry.id}" id="tldId" name="id" class="form-control" />
                    {/if}
                </div>
                            
                <div class="form-group">
                    <label for="hostUrl">Domain availability check - Server host / Query URL</label>
                    <input type="text" value="{$entry.server}" id="hostUrl" name="server" class="form-control" />

                    <p class="help-block">Whois service address, for whois server use hostnames eg. <b>whois.crsnic.net</b>. For http service use full url,
                        you can use variables eg. https://api.example.com/?domain=&#123;$domain&#125;
                    </p>
                    <div class="checkbox">
                        <label>
                            <input type="hidden" name="sldonly" value="0">
                            <input type="checkbox" name="sldonly" value="1"  {if $entry.sldonly}checked{/if}> 
                            Send lookup query without tld extension
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="testString">Test string</label>
                    <textarea id="testString" name="available" class="form-control">{$entry.available}</textarea>
                    <p class="help-block">String to match when testing whois response, case insensitive. You may use variables.</p>
                    <div class="checkbox">
                        <label>
                            <input type="hidden" name="strict" value="0">
                            <input type="checkbox" name="strict" value="1" {if $entry.strict}checked{/if}>
                            Exact match, test string has to match whole whois response.
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="hostUrl">Availability test</label>
                    <select id="" name="nomatch" class="form-control">
                        <option value="0" {if !$entry.nomatch}selected{/if}> Available if test string found</option>
                        <option value="1" {if $entry.nomatch}selected{/if}> Unavailable if test string found </option>
                    </select>
                    <p class="help-block">Return status when test string matches whois output.</p>
                </div>
                    
                <div class="form-group">
                    <label for="hostUrl">Domain whois data - Server host / Query URL</label>
                    <input type="text" value="{$entry.whoisserver|default:$entry.server}" id="hostUrl" name="whoisserver" class="form-control" />

                    <p class="help-block">Whois service address, <strong>used to pull whois data that can be displayed to client</strong>, for whois server use hostnames eg. <b>whois.crsnic.net</b>. For http service use full url,
                        you can use variables eg. https://api.example.com/?domain=&#123;$domain&#125;
                    </p>
                    <div class="checkbox">
                        <label>
                            <input type="hidden" name="whoissldonly" value="0">
                            <input type="checkbox" name="whoissldonly" value="1"  {if $entry.whoissldonly}checked{/if}> 
                            Send whois query without tld extension
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="hostUrl">Minimum length</label>
                    <input type="text" value="{$entry.namemin|default:3}" name="namemin" id="hostUrl" class="form-control" />
                    <p class="help-block">
                        Minimum length for domain name, excluding {if $entry.id}<b>{$entry.id}</b>{else}<b>TLD</b>{/if} extension.
                        Length is taken from unicode name, making "<b>ë</b>" name <b>1</b> character long.
                    </p>
                </div>

                <div class="form-group">
                    <label for="hostUrl">Maximum length</label>
                    <input type="text" value="{$entry.namemax|default:63}" name="namemax" id="hostUrl" class="form-control" />
                    <p class="help-block">
                        Maximum length for domain name, excluding {if $entry.id}<b>{$entry.id}</b>{else}<b>TLD</b>{/if} extension.
                        Length is taken from idn name, making "<b>ë</b>" name <b>7</b> character long (xn--nea).
                    </p>
                </div>
                <div class="form-group">
                    <label for="hostUrl">IDN Format</label>
                    <select id="" name="unicode" class="form-control">
                        <option value="0" {if !$entry.unicode}selected{/if}> Punycode (default)</option>
                        <option value="1" {if $entry.unicode}selected{/if}> Unicode </option>
                    </select>

                    <p class="help-block">Format sent to server, eg: Unicode <b>èxåmplë.com</b>; Punycode <b>xn--xmpl-qoaq0a.com</b>.</p>
                </div>

                <div class="form-group">
                    <label for="refresh">Cache Time</label>
                    <select id="refresh" name="refresh" class="form-control">
                        <option value="900" {if $entry.refresh == 900}selected{/if}> 15 Min</option>
                        <option value="1800" {if $entry.refresh == 1800}selected{/if}> 30 Min </option>
                        <option value="3600" {if $entry.refresh == 3600}selected{/if}> 1 Hour </option>
                        <option value="10800" {if $entry.refresh == 10800}selected{/if}> 3 Hours </option>
                        <option value="43200" {if $entry.refresh == 43200}selected{/if}> 12 Hours </option>
                        <option value="86400" {if $entry.refresh == 86400}selected{/if}> 1 Day </option>
                    </select>

                    <p class="help-block">Controls how long local cache can be re-used before queering whois service for new record. Setting this to higher value may help with rate limits. </p>
                </div>
            </div>

            <div class="col-md-6">

                <div class="form-group">
                    <label for="domanName">Domain name</label>
                    <div class="input-group">
                        <input type="text" value="example" name="sld" id="domanName" class="form-control" />
                        <span class="input-group-btn">
                            <button type="button" id="test" class="btn btn-info">Send whois request</button>
                        </span>
                    </div>

                </div>

                <div class="panel panel-default">
                    <div class="panel-heading" id="status">
                        <h3 class="panel-title">Status <span id="status-text"></span></h3>
                    </div>
                    <div class="panel-body" id="whois" style="white-space: pre-wrap"> No data yet ... </div>
                </div>


                <div class="panel panel-default">
                    <div class="panel-heading" id="status">
                        <h3 class="panel-title">Available variables</h3>
                    </div>
                    <div class="panel-body"> 
                        <code>&#123;$domain&#125;</code> replaced with searched domain name eg. <code>example.com</code>, <br />
                        <code>&#123;$name&#125;</code> replaced with searched name eg. <code>example</code>, <br />
                        <code>&#123;$tld&#125;</code> replaced with TLD extension eg. <code>com</code>.
                    </div>
                </div>


            </div>
        </div>
    </div>

    <div class="clearfix" style="padding: 0 10px;">
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </div>

    {securitytoken}   
</form>
<div class="clear"></div>