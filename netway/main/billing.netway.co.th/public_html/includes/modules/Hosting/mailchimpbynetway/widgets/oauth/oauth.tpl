<h3>Authentication</h3>

<div class="row">
    <table class="table">
    <thead>
    <tr>
        <th>Result</th>
        <th><span class="text-success">{$connection}</span></th>
    </tr>
    </thead>
    </table>
</div>

<div class="row">
    <p align="center">
        <form action="https://login.mailchimp.com/login/post/" method="post" target="_blank">
            <input type="hidden" name="username" value="{$username}" />
            <input type="hidden" name="password" value="{$password}" />
            <input type="submit" {*name="submit"*} value="Access email marketing"  class="btn btn-large btn-success" />
        </form>
    </p>
</div>
