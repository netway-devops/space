<div class="wbox">
    <div class="wbox_header"><span style="float: right; margin-top: -2px;">
            <a class="imgbg renew" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress&wact=install">{$lang.cleanform}</a>
            <a class="imgbg back" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget=wordpress">{$lang.backto} {$lang.servicedetails}</a>
        </span>{$lang.newinstallation}
    </div>
    <div id="cartSummary" class="wbox_content">


        <form action="" method="get" id="wpform" class="form-horizontal">
            <div class="bodycontcont">
                <p>{$lang.installwordpresson}: http:// <input id="subv" type="text" value="{$wpd.subdomain}" name="sub" class="span2" /> .{$service.domain}/ <input id="pathv" class="span2" type="text" value="{$wpd.path}" name="path" />
                    <a href="#" class="menuitm btn btn-mini" id="confirm">Install</a>
                </p>
                <div id="step1" class="steps">{$lang.checking} {$lang.domain} <span class="dwstatus noerror"></span><img src="includes/types/widgets/wordpress/assets/ajax-loading2.gif"/></div>
                <div id="step2" class="steps">{$lang.checking} {$lang.Location}<span class="dwstatus noerror"></span><img src="includes/types/widgets/wordpress/assets/ajax-loading2.gif"/></div>
                <div id="step3" class="steps">{$lang.directorynotempty}. <a onclick="step4();">{$lang.continue}</a><span class="dwstatus noerror"></span><img style="display:none;" src="includes/types/widgets/wordpress/assets/ajax-loading2.gif"/></div>
                <div id="step4" class="steps">{$lang.checking} {$lang.database} <span class="dwstatus noerror"></span><img src="includes/types/widgets/wordpress/assets/ajax-loading2.gif"/></div>
                <div id="step5" class="steps">{$lang.downloadinglatestwordpress} <span class="dwstatus noerror"></span><img src="includes/types/widgets/wordpress/assets/ajax-loading2.gif"/> <a style="display: none;" href="#" onclick="$('#step5 img').show();setTimeout('step5()',5000); return false;">{$lang.retry}</a></div>
                <div id="step6" class="steps">{$lang.extractingfiles} <span class="dwstatus noerror"></span><img src="includes/types/widgets/wordpress/assets/ajax-loading2.gif"/></div>
                <div id="step7" class="steps">{$lang.checking} {$lang.configuration}<span class="dwstatus noerror"></span><img src="includes/types/widgets/wordpress/assets/ajax-loading2.gif"/></div>
                <div id="step8" class="steps">{$lang.done} :-) </div>
            </div>
        </form>


    </div>
</div>

<script type="text/javascript">
    var modname = '{$modulename}';
    var domain = '{$service.domain}';
    {if $wact == 'reinstall'}
    start();
    {/if}
    {literal}
    function step1() {
        $('#step1').show();
        $.get('index.php',{ '{/literal}/clientarea/services/{$service.slug}/{$service.id}/{literal}' : '', 'widget': 'wordpress', 'wact' : 'domain', 'sub':$('#wpform input[name=sub]').val(), 'path':$('#wpform input[name=path]').val()  },function(data){
            if(data.status=='ok') {
                $('#step1 img').fadeOut(400);
                $('#step1 span').text('ok');
                step2();
            } else {
                $('#step1 img').fadeOut(400);
                $('#step1 span').text('error');
            }
        },"json");
    }
    function step2() {
        $('#step2').show();
        $.get('index.php',{ '{/literal}/clientarea/services/{$service.slug}/{$service.id}/{literal}' : '', 'widget': 'wordpress', 'wact' : 'path', 'sub':$('#wpform input[name=sub]').val(), 'path':$('#wpform input[name=path]').val()  },function(data){
            if(data.status=='ok') {
                $('#step2 img').fadeOut(400);
                $('#step2 span').text('ok');
                step4();
            } else if (data.status=='not empty') {
                $('#step2 img').fadeOut(400);
                $('#step2 span').text('not found');
                step3();
            } else {
                $('#step2 img').fadeOut(400);
                $('#step2 span').text('error');
            }
        },"json");
    }
    
    function step3() {
        $('#step3').show();
    }
    
    function step4() {
        $('#step4').show();
        $.get('index.php',{ '{/literal}/clientarea/services/{$service.slug}/{$service.id}/{literal}' : '', 'widget': 'wordpress', 'wact' : 'database' , 'sub':$('#wpform input[name=sub]').val(), 'path':$('#wpform input[name=path]').val() },function(data){
            if(data.status=='ok') {
                $('#step4 img').fadeOut(400);
                $('#step4 span').text('ok');
                step5();
            } else {
                $('#step4 img').fadeOut(400);
                $('#step4 span').text('error');
            }
        },"json");
    }
    
    function step5() {
        $('#step5 img').show();
        $('#step5 a').hide();
        $('#step5 span').text('');
        $('#step5').show();
        $.get('index.php',{ '{/literal}/clientarea/services/{$service.slug}/{$service.id}/{literal}' : '', 'widget': 'wordpress', 'wact' : 'download' , 'sub':$('#wpform input[name=sub]').val(), 'path':$('#wpform input[name=path]').val() },function(data){
            if(data.status=='ok') {
                $('#step5 img').fadeOut(400);
                $('#step5 span').text('ok');
                step6();
            } else {
                $('#step5 a').show();
                $('#step5 img').fadeOut(400);
            }
        },"json");
    }
    
    function step6() {
        $('#step6').show();
        $.get('index.php',{ '{/literal}/clientarea/services/{$service.slug}/{$service.id}/{literal}' : '', 'widget': 'wordpress', 'wact' : 'extract' , 'sub':$('#wpform input[name=sub]').val(), 'path':$('#wpform input[name=path]').val() },function(data){
            if(data.status=='ok') {
                $('#step6 img').fadeOut(400);
                $('#step6 span').text('ok');
                step7();
            } else {
                $('#step6 img').fadeOut(400);
                $('#step6 span').text('error');
            }
        },"json");
    }

    function step7() {
        $('#step7').show();
        $.get('index.php',{ '{/literal}/clientarea/services/{$service.slug}/{$service.id}/{literal}' : '', 'widget': 'wordpress', 'wact' : 'configure' , 'sub':$('#wpform input[name=sub]').val(), 'path':$('#wpform input[name=path]').val() },function(data){
            if(data.status=='ok') {
                $('#step7 img').fadeOut(400);
                $('#step7 span').text('ok');
                step8();
            } else {
                $('#step7 img').fadeOut(400);
                $('#step7 span').text('error');
            }
        },"json");
    }
    
    function step8() {
        $('#step8').show();
    }
    function start() {
        $('#confirm').parent().hide();
        var path = $('#pathv').val();
        var sub = $('#subv').val();
        $('#step8').html('<a target="_blank" href="http:\/\/' + (sub.length > 0 ? sub + '.' : '') + domain + '\/'+ path + '/wp-admin/">Continue<\/a> WordPress configuration.' );
        step1();
    }
    $('#confirm').live('click', function(e) {
        e.preventDefault();
        start();
    });
</script>
<style type="text/css">
    .steps {
        display: none;
    }
    .steps img {
        vertical-align: middle;
    }
    #bodycont {
        background: #f5f9ff;
    }
    .bodycontcont {
        margin: 12px;
    }
    a.imgbg {
        font-size: 11px;
        padding-left: 20px;
        line-height: 18px;
        vertical-align: middle;
        background-position: 0px 1px;
        background-repeat:no-repeat;
        display: inline-block;
        margin: auto 6px auto 3px;
        vertical-align: middle;
        color: #005bb8;
        font-weight: normal;
    }
    a.back {
        background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/restore-backup.png);
    }
    a.renew {
        background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/reboot-vm.png);
    }
</style>
{/literal}