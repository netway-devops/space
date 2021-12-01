</div>
{adminfooter}
<div class="modal fade" tabindex="-1" role="dialog" id="reloginplace">
    <div class="modal-dialog" role="document">
        <form action="" method="POST">
            <input type="hidden" name="username" value="{$staff.username}">
            {securitytoken}
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Your Session Expired</h4>
                </div>
                <div class="modal-body">

                    <div class="alert alert-info" role="alert">
                        Enter your password to pickup where you left off.
                    </div>
                    <div class="form-group">
                        <label for="reloginpass">Password</label>
                        <input type="password" name="password" class="form-control" id="reloginpass" placeholder="Password">
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="index.php" class="btn btn-default">Logout</a>
                    <button type="submit" class="btn btn-primary">Resume Session</button>
                </div>
            </div><!-- /.modal-content -->
        </form>

    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="back-to-top" ><i class="fa fa-chevron-up"></i></div>

<!--tiptip plugin -->
<div id="tiptip_holder">
    <div id="tiptip_content">
        <div id="tiptip_arrow">
            <div id="tiptip_arrow_inner"></div>
        </div>
    </div>
</div>

</body>
</html>