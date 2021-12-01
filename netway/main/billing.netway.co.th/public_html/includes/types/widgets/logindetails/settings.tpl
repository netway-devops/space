<div class="form-horizontal" style="max-width: 95%">
    <div class="form-group">
        <div class="col-sm-10">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="config[password]" value="1" {if $widget.config.password}checked{/if}> <b>Hide Password</b>
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-10">
            <div class="checkbox">
                <label>
                    <input type="checkbox"  name="config[rootpassword]" value="1" {if $widget.config.rootpassword}checked{/if}> <b>Hide Root Password</b>
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-12">
            <label >Additional fields </label>
            <input type="text" class="form-control" name="config[additionalforms]" value="{$widget.config.additionalforms}" id="additionalforms"/>
            <p class="help-block">Comma-separated list of variable names of form items which should appear on login details page in client portal</p>
        </div>
    </div>
</div>