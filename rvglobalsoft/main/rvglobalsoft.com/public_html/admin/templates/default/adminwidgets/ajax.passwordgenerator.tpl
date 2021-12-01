{if !$password}
    {literal}
        <style>
            .slidecontainer-pg {
                width: 100% !important;
            }

            .slider-pg {
                -webkit-appearance: none !important;
                width: 100% !important;
                height: 15px !important;
                border-radius: 5px !important;
                background: #d3d3d3 !important;
                outline: none !important;
                opacity: 0.7 !important;
                -webkit-transition: .2s !important;
                transition: opacity .2s !important;
                cursor: default !important;
            }

            .slider-pg:hover {
                opacity: 1;
            }

            .slider-pg::-webkit-slider-thumb {
                -webkit-appearance: none;
                appearance: none;
                width: 25px;
                height: 25px;
                border-radius: 50%;
                background: #0277BD;
                cursor: pointer;
            }

            .slider-pg::-moz-range-thumb {
                width: 25px;
                height: 25px;
                border-radius: 50%;
                background: #0277BD;
                cursor: pointer;
            }
            input[type='range'] {
                overflow: hidden;
            }
            input[type='range']::-webkit-slider-thumb {
                -webkit-appearance: none;
                box-shadow: -500px 0 0 500px #29B6F6;
            }

            input[type="range"]::-moz-range-progress {
                background-color: #29B6F6;
            }
            input[type="range"]::-moz-range-track {
                background-color: #0277BD;
            }
            input[type="range"]::-ms-fill-lower {
                background-color: #29B6F6;
            }
            input[type="range"]::-ms-fill-upper {
                background-color: #0277BD;
            }
        </style>
    {/literal}
    <div class="content" style="padding: 15px;">
        <div class="row">
            <div class="col-sm-9 new_pass_content">
                <div class="input-group">
                    <input type="text" class="form-control" id="new_pass">
                    <span class="input-group-btn">
                        <button id="copy_pass" class="btn btn-default" title=""><span class="glyphicon glyphicon-copy"></span> Copy </button>
                    </span>
                </div>
            </div>
            <div class="col-sm-3 text-left">
                <button id="generate_pass" class="btn btn-default">Generate Password</button>
            </div>
        </div>
        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-1">
                <span>Length</span>
            </div>
            <div class="col-sm-8">
                <div class="slidecontainer-pg">
                    <input type="range" min="5" max="20" value="{if $pass.length}{$pass.length}{else}8{/if}" class="slider-pg" id="lenght">
                </div>
            </div>
            <div class="col-sm-1">
                <p><span id="lenght-value"></span></p>
            </div>
        </div>
        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-1">
                <span>Digits</span>
            </div>
            <div class="col-sm-8">
                <div class="slidecontainer-pg">
                    <input type="range" min="{if !$pass.numbers}0{else}1{/if}" max="10" value="3" class="slider-pg" id="digits">
                </div>
            </div>
            <div class="col-sm-1">
                <p><span id="digits-value"></span></p>
            </div>
        </div>
        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-1">
                <span>Symbols</span>
            </div>
            <div class="col-sm-8">
                <div class="slidecontainer-pg">
                    <input type="range" min="{if !$pass.noalpha}0{else}1{/if}" max="10" value="2" class="slider-pg" id="symbols">
                </div>
            </div>
            <div class="col-sm-1">
                <p><span id="symbols-value"></span></p>
            </div>
        </div>
    </div>
    {literal}
    <script>
        var lenght_slider = $('#lenght'),
            lenght_value = $('#lenght-value'),
            digits_slider = $('#digits'),
            digits_value = $('#digits-value'),
            symbols_slider = $('#symbols'),
            sybbols_value = $('#symbols-value');
        lenght_value.html(lenght_slider.val());
        lenght_slider.on('input', function () {
            var lval = parseInt(digits_slider.val()) + parseInt(symbols_slider.val());
            if (lenght_slider.val() <= lval) {
                lenght_slider.val(lval);
            }
            lenght_value.html(lenght_slider.val());
        });

        digits_value.html(digits_slider.val());
        digits_slider.on('input', function () {
            var dval1 = parseInt(digits_slider.val()) + parseInt(symbols_slider.val()),
                dval2 = parseInt(lenght_slider.val()) - parseInt(symbols_slider.val());
            if (dval1 >= lenght_slider.val()) {
                digits_slider.val(dval2);
            }
            digits_value.html(digits_slider.val());
        });

        sybbols_value.html(symbols_slider.val());
        symbols_slider.on('input', function () {
            var sval1 = parseInt(digits_slider.val()) + parseInt(symbols_slider.val()),
                sval2 = parseInt(lenght_slider.val()) - parseInt(digits_slider.val());
            if (sval1 >= lenght_slider.val()) {
                symbols_slider.val(sval2);
            }
            sybbols_value.html(symbols_slider.val());
        });

        $('#generate_pass').on('click', function () {
            generate();
        });

        $('#lenght, #digits, #symbols').on('change', function () {
           generate();
        });

        function generate() {
            var content = $('.new_pass_content');
            $.post("?cmd=root&action=generate_password",
                {
                    lenght: lenght_slider.val(),
                    numbers: digits_slider.val(),
                    symbols: symbols_slider.val(),
                    security_token: {/literal}'{$security_token}'{literal}
                },
                function (result) {
                    content.html(result);
                    $('#copy_pass').attr('data-original-title', '');
                });
        }
    </script>
    {/literal}
{else}
    <div class="input-group">
        <input type="text" class="form-control" id="new_pass" value="{$password}">
        <span class="input-group-btn">
            <button id="copy_pass" class="btn btn-default" title=""><span class="glyphicon glyphicon-copy"></span> Copy </button>
        </span>
    </div>
    {literal}
        <script>
            $('#copy_pass, #new_pass').on('click', function () {
                var pass = $('#new_pass').val();
                if (!isEmpty(pass)) {
                    copyToClipboard($('#new_pass').val(), $(this));
                }
            });

            function copyToClipboard(text, el) {
                var copyTest = document.queryCommandSupported('copy');
                if (copyTest === true) {
                    var copyTextArea = document.createElement("textarea");
                    copyTextArea.value = text;
                    document.body.appendChild(copyTextArea);
                    copyTextArea.select();
                    try {
                        var successful = document.execCommand('copy');
                        var msg = successful ? {/literal}'{if $copied}{$copied}{else}Copied{/if}' : '{$wrong_copy}'{literal};
                        el.attr('data-original-title', msg).tooltip('show');
                    } catch (err) {
                        console.log('Oops, unable to copy');
                    }
                    document.body.removeChild(copyTextArea);
                }
            }
        </script>
    {/literal}
{/if}