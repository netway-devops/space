<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>HostBill - {$business_name} </title>
    <link href="{$template_dir}_style.css" rel="stylesheet" media="all" />
    <script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js"></script>
    {literal}
        <style type="text/css">
            a {
                font-weight:bold;
                color:#699ccb;
                text-decoration:none;
            }
            a:hover {
                text-decoration:underline;
            }
            small {
                font-size:11px;
            }
            html, body {
                height:100%;
                min-height:100%;
                position:relative;
                line-height:20px;
                font-size:11px;
                font-family: Tahoma,Arial !important;
            }
            .btn {
                text-decoration: none;
                display: inline-block;
                font-weight: normal;
                text-align: center;
                vertical-align: middle;
                touch-action: manipulation;
                cursor: pointer;
                background-image: none;
                border: 1px solid transparent;
                white-space: nowrap;
                margin: 10px auto;
                padding: 5px;
            }
            .btn:disabled {
                opacity: .7;
            }
            .btn:hover {
                opacity: .7;
            }
            .btn-request {
                color: #fff;
                background-color: #03a9f4;
                border-color: #0398db;
            }
            .btn-submit {
                color: #fff;
                background-color: #8bc34a;
                border-color: #7eb73d;
            }
            label {
                width: 100%;
            }
            input {
                width: 100%;
            }
        </style>
    {/literal}
</head>
<body>
<div style="max-width:350px;margin:0 auto;position:relative;height:100%;padding:0;min-height:100%">
    <div style="width:350px;position:absolute;top:50%;margin-top:-200px;left: 0; right: 0;">
        <img src="{$template_dir}img/hb_logo.gif" style="margin-bottom:10px;"  alt="{$business_name}"/>
        <div style="border:3px solid #85a8c8; padding: 10px;;margin-bottom:4px;background:#ffffff;">
            <div>
                <div style="max-width: 800px; width: 100%; margin: 0 auto;">
                    <h3>{$lang.mobile2fa_login_header}</h3>
                    <p>{$lang.mobile2fa_login_desc}</p>
                    <hr>
                    <div style="text-align: center;">
                        <button href="#" class="btn btn-request btnRequest" data-resend="0">
                                <span style="max-height: 24px; overflow:hidden; margin-right: 10px;">
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="svg1" x="0px" y="0px" viewBox="0 0 490 490" style="enable-background:new 0 0 490 490;" xml:space="preserve" width="12px" height="12px">
                                    <g>
                                        <g>
                                            <path d="M410.103,458.74L281.861,353.511H105.453C47.313,353.511,0,305.166,0,245.755V139.016    C0,79.606,47.313,31.26,105.453,31.26h279.094C442.687,31.26,490,79.606,490,139.016v106.739    c0,49.99-33.511,92.697-79.897,104.511V458.74z M105.453,61.886c-41.257,0-74.828,34.603-74.828,77.131v106.739    c0,42.528,33.571,77.131,74.828,77.131h187.354l86.671,71.104v-70.043l13.518-1.6c37.848-4.456,66.379-37.384,66.379-76.592    V139.016c0-42.528-33.571-77.131-74.828-77.131H105.453z" fill="#eeeeee"/>
                                        </g>
                                        <g>
                                            <path d="M87.284,210.524c5.458,3.32,16.778,7.223,25.556,7.223c8.972,0,12.681-3.125,12.681-8c0-4.89-2.931-7.223-14.041-10.931    c-19.709-6.639-27.32-17.361-27.126-28.681c0-17.75,15.223-31.208,38.82-31.208c11.125,0,21.085,2.527,26.931,5.458l-5.264,20.486    c-4.292-2.348-12.486-5.473-20.681-5.473c-7.223,0-11.32,2.931-11.32,7.806c0,4.486,3.708,6.834,15.417,10.931    c18.139,6.236,25.75,15.417,25.945,29.459c0,17.75-14.042,30.819-41.362,30.819c-12.486,0-23.612-2.722-30.819-6.624    L87.284,210.524z" fill="#eeeeee"/>
                                            <path d="M172.131,171.496c0-11.888-0.389-22.042-0.778-30.431h24.973l1.361,12.875h0.583c4.097-6.041,12.486-15.013,28.875-15.013    c12.292,0,22.042,6.236,26.139,16.18h0.389c3.514-4.875,7.806-8.778,12.292-11.499c5.279-3.125,11.125-4.68,18.154-4.68    c18.333,0,32.195,12.875,32.195,41.347v56.196h-28.875V184.58c0-13.862-4.501-21.862-14.056-21.862    c-6.819,0-11.709,4.68-13.653,10.348c-0.778,2.138-1.166,5.264-1.166,7.611v55.792h-28.875V183.01    c0-12.098-4.292-20.292-13.668-20.292c-7.596,0-12.098,5.862-13.847,10.737c-0.972,2.333-1.166,5.069-1.166,7.417v55.598h-28.875    V171.496z" fill="#eeeeee"/>
                                            <path d="M339.686,210.524c5.458,3.32,16.778,7.223,25.556,7.223c8.972,0,12.681-3.125,12.681-8c0-4.89-2.931-7.223-14.042-10.931    c-19.709-6.639-27.32-17.361-27.126-28.681c0-17.75,15.223-31.208,38.82-31.208c11.125,0,21.07,2.527,26.931,5.458l-5.264,20.486    c-4.292-2.348-12.486-5.473-20.681-5.473c-7.223,0-11.32,2.931-11.32,7.806c0,4.486,3.708,6.834,15.417,10.931    c18.139,6.236,25.75,15.417,25.945,29.459c0,17.75-14.041,30.819-41.362,30.819c-12.486,0-23.612-2.722-30.819-6.624    L339.686,210.524z" fill="#eeeeee"/>
                                        </g>
                                    </g>
                                </svg>
                                </span>
                            <span data-state="visible">{$lang.mobile2fa_sendpass}</span>
                            <span data-state="hidden" style="display: none;">{$lang.mobile2fa_resendpass}</span>
                        </button>
                    </div>
                    <form action="?cmd=mobile_2fa" method="POST" style="display:none;margin-top: 20px;" class="formToken">
                        <p>{$lang.mobile2fa_sendsuccessful}</p>
                        <hr>
                        <label for="mobile_token">{$lang.password}</label>
                        <input type="text" class="form-control" id="mobile_token" name="mobile_token">
                        {securitytoken}
                        <input type="hidden" name="make" value="verify">
                        <div>
                            <button class="btn btn-submit btn-primary" style="margin-right: 20px;">Submit</button>
                            <a class="btn-link" href="?cmd=root&action=logout">Logout</a>
                        </div>
                    </form>
                    {literal}
                        <script type="text/javascript">
                            $(document).on('click','.btnRequest',function (e) {
                                e.preventDefault();
                                var b = $(this);
                                var w = {/literal}'{$lang.mobile2fa_waitplease}'{literal};
                                var v = $(b).html();
                                var t = $('input[name="security_token"]').val();
                                var r = $(b).attr('data-resend');
                                $(b).prop('disabled', true).html(w);
                                setTimeout(function(){
                                    $(b).prop('disabled', false);
                                }, 10000); //turn off for 10 seconds
                                $.ajax({url: '?cmd=mobile_2fa&action=request&make=request&resend='+r+'&security_token='+t, type: 'post', data: {}, success: function (data) {
                                    $(b).attr('data-resend','1').html(v);
                                    $('.formToken').fadeOut('fast').fadeIn('fast');
                                    $(b).find('[data-state="visible"]').hide();
                                    $(b).find('[data-state="hidden"]').show();
                                }});
                            });
                        </script>
                    {/literal}
                </div>
            </div>
        </div>
        <div style="text-align:center;"><small>Powered by <a href="http://hostbillapp.com" target="_blank" >HostBill</a></small></div>
    </div>
</div>
</body>
</html>