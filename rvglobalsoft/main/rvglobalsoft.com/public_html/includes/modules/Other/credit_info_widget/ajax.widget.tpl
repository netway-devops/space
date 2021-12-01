    <h3>{$widget.name}:</h3>
    {foreach from=$summary item=stat}
            <div class="stat-item">
                <div class="pp-amount">
                    <span class="pp-amt">{$stat.credit|price:$stat.currency_id:false}</span>
                    <span class="pp-code">{$currencies[$stat.currency_id].iso}</span>
                </div>
                <div class="stat-data Open"><span class="Answered"></span></div>
                {*<div class="stat-label">Credit balance</div>*}
            </div>
    {/foreach}
    <div class="pull-right">
        <a target="_blank" class="btn btn-sm btn-primary" onclick='return loadCreditEntries();' style="margin:5px">Load credit details</a>
        <a target="_blank" class="btn btn-sm btn-primary" onclick='return loadTransactionsEntries();' style="margin:5px">Last transactions</a>

    </div>
    <div class="clear"></div>

<div id="creditload">

</div>
{literal}
<script>
    function loadCreditEntries() {
        var container = $('#creditload');
        container.parents('.box').append('<div class="overlay"><img src="ajax-loading.gif" /></div>');


        $.get('?cmd=credit_info_widget',{action:'loadcredit'},function(data) {
            container.parents('.box').find('.overlay').remove();

            $('#creditload').html(data);
        });
        return false;
    }
    function loadTransactionsEntries() {
        var container = $('#creditload');
        container.parents('.box').append('<div class="overlay"><img src="ajax-loading.gif" /></div>');


        $.get('?cmd=credit_info_widget',{action:'loadtransactions'},function(data) {
            container.parents('.box').find('.overlay').remove();

            $('#creditload').html(data);
        });
        return false;
    }
</script>
    <style>

        .box.credit_info_widget {
            border-color: #bdcad8;
            background:none;
            border-radius: 0px;
        }

        .box.credit_info_widget .box-title {
            display: none;
        }
        .box.credit_info_widget .box-header {
            float:right;
            width: 200px;
        }
        .box.credit_info_widget .box-footer {
            background: none;
            border-radius: 0px;
            border:0px;
        }
        .box.credit_info_widget  #datatable_credit_wrapper {
            margin-top:10px;
        }

       .box.credit_info_widget .stat-item {
           float:left;
           margin-top:5px;
           margin-left:10px
       }
        .box.credit_info_widget .box-body {
            padding-bottom: 2px;
        }
        .box.credit_info_widget h3 {
            font-size: 15px;
            font-weight: bold;
            display: block;
            margin: 10px 0px;
            float: left;
        }
        .box.credit_info_widget .pp-amount{
            display: inline-block;
            vertical-align: top;

            font-size: 15px;
            font-weight: bold;
            line-height: 25px;
        }
        .box.credit_info_widget .pp-amt{
            border: 1px solid #3598DC;
            border-right: none;
            float: left;
            color: #323538;
            border-radius: 2px 0 0 2px;
            padding: 0 3px;
        }
        .box.credit_info_widget .pp-code{
            border-radius: 0 2px 2px 0;
            border: solid 1px #3598DC;
            border-left: none;
            background: #3598DC;
            color: white;
            float: left;
            padding: 0 4px;
        }
    </style>

{/literal}
