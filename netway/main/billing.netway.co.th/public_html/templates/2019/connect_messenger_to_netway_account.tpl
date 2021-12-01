<!-- Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <h3 id="myModalLabel">Already Customer</h3>
  </div>
  <div class="modal-body">
    <form action="/clientarea" target="login" method="post">
        {assign var="onlycustomer" value="1"}
        {include file="ajax.login.tpl"}
    </form>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>

<div>&nbsp;</div>

<div class="row-fluid">
    <div class="span6 offset3">
        
        <table class="table">
        <tr>
            <td width="120">
                <img src="{$oClient.picUrl}" width="100" class="img-rounded" />
            </td>
            <td>
                <p>{$oClient.firstName}</p>
                <p>{$oClient.lastName}</p>
                
                <p align="center">
                    <button id="connectTo" onclick="setConnectMessenger();" data-toggle="modal" data-target="#loginModal" class="btn btn-primary">Connect</button>
                </p>
                
            </td>
        </tr>
        </table>
        
        <div id="conenctedMessenger" style="display: none;">
            <div id="isConnected" align="center" class="well well-small text text-success" style="display: none;">--- ทำการเชื่อมต่อ Messenger กับ netway account เรียบร้อยแล้ว---</div>
            <table class="table table-stripe">
            <tr>
                <td width="100">ชื่อ-นามสกุล</td>
                <td><span id="nwFirstname"></span> <span id="nwLastname"></span></td>
            </tr>
            <tr>
                <td width="100">อีเมล์</td>
                <td><span id="nwEmail"></span> </td>
            </tr>
            </table>
        </div>
        
    </div>
</div>



<script language="javascript">
{literal}

$(document).ready(function() {
    connectMessenger();
});

function setConnectMessenger ()
{
    setTimeout(function () {
        $.post('?cmd=clienthandle&action=connectMessenger', {messengerId: '{/literal}{$oClient.messengerId}{literal}'}, function () {
            connectMessenger();
        });
    }, 3000);
}

function connectMessenger ()
{
    setTimeout(function () {
        $.get('?cmd=clienthandle&action=islogin', function (data) {
            var isLogin = 0;
            var oData   = {};
            if (typeof data.data !== 'undefined') {
                if (typeof data.data.id !== 'undefined') {
                    isLogin = 1;
                    oData   = data.data;
                }
            }
            
            if (isLogin) {
                
                $('#conenctedMessenger').show();
                
                $('#nwFirstname').html(oData.firstname);
                $('#nwLastname').html(oData.lastname);
                $('#nwEmail').html(oData.email);
                
                if (typeof oData.messengerId !== 'undefined') {
                    if (oData.messengerId == {/literal}{$oClient.messengerId}{literal}) {
                        $('#isConnected').show();
                        $('#connectTo').parent().hide();
                    } else {
                        $('#connectTo').removeClass('btn-primary');
                        $('#connectTo').addClass('btn-danger');
                        $('#connectTo').html('Re-Connect');
                    }
                }
                
            } else {
                connectMessenger();
            }
            
        });
    }, 3000);
}

{/literal}
</script>



