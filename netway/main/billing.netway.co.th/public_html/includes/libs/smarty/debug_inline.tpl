{assign_debug_info}
[Smarty Debug]

**included templates & config files **{if $_smarty_debug_output=='html'}<br />{/if}
{section name=templates loop=$_debug_tpls}
    {section name=indent loop=$_debug_tpls[templates].depth}{if $_smarty_debug_output=='html'}&nbsp;&nbsp;&nbsp;{else}   {/if}{/section}
    {$_debug_tpls[templates].type}::{$_debug_tpls[templates].filename}{if $_smarty_debug_output=='html'}<br />{/if}
{sectionelse}
    - no templates included -{if $_smarty_debug_output=='html'}<br />{/if}
{/section}
{if $_smarty_debug_output=='html'}<br />{/if}
**assigned template variables**{if $_smarty_debug_output=='html'}<br />{/if}
{section name=vars loop=$_debug_keys}
    
{ldelim}${$_debug_keys[vars]}{rdelim} => {$_debug_vals[vars]|@debug_print_var:1:40:$_smarty_debug_output}{if $_smarty_debug_output=='html'}<br />{/if}
{sectionelse}
    - no template variables assigned -{if $_smarty_debug_output=='html'}<br />{/if}
{/section}
{if $_smarty_debug_output=='html'}<br />{/if}
**assigned config file variables (outer template scope)**{if $_smarty_debug_output=='html'}<br />{/if}
{section name=config_vars loop=$_debug_config_keys}
    
{ldelim}#{$_debug_config_keys[config_vars]}#{rdelim} => {$_debug_config_vals[config_vars]|@debug_print_var:1:40:$_smarty_debug_output}{if $_smarty_debug_output=='html'}<br />{/if}
{sectionelse}
    - no config vars assigned -{if $_smarty_debug_output=='html'}<br />{/if}
{/section}
{if $_smarty_debug_output=='html'}<br />{/if}
