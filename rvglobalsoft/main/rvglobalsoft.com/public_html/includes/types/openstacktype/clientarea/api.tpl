<div class="header-bar">
    <h3 class="logs hasicon">OpenStack API</h3>

    <div class="clear"></div>
</div>
<div class="content-bar" >
    Copy data below into <code>openrc</code> file, then type <code>source openrc</code> in the terminal to configure your environment,
    to communicate with OpenStack using CLI tools.
 <br/><br/>
    <pre class="code">
#!/bin/bash

# With the addition of Keystone, to use an openstack cloud you should
# authenticate against keystone, which returns a **Token** and **Service
# Catalog**.  The catalog contains the endpoint for all services the
# user/tenant has access to - including nova, glance, keystone, swift.
#
# *NOTE*: Using the 2.0 *auth api* does not mean that compute api is 2.0.
export OS_AUTH_URL=<b>{$keystoneurl}</b>

# With the addition of Keystone we have standardized on the term **tenant**
# as the entity that owns the resources.
export OS_TENANT_ID=<b>{$tenant_id}</b>

# In addition to the owning entity (tenant), openstack stores the entity
# performing the action as the **user**.
export OS_USERNAME=<b>{$username}</b>

# With Keystone you pass the keystone password.
export OS_PASSWORD=<b>{$password}</b>

    </pre>
</div>