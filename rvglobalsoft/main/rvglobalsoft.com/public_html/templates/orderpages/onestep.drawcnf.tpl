{if $config}
{foreach from=$config item=c}
{if $c.type=='text'}
            
             
              <tr><td colspan="2"><label for="custom_field[{$c.id}]" class='styled'>{$c.name}
              {if $c.required=='1'}*{/if}
              </label>
             <input name='custom_field[{$c.id}]' class='styled' style="width:50%" value="{$contents[0].config[$c.id]}" onchange="simulateCart('#cart3');"/></td>
             </tr>
   

{elseif $c.type=='checkbox'}
            
        <tr><td colspan="2">        
        
             
          
                 <input name='custom_field[{$c.id}]'  type='checkbox' value='1' {if $contents[0].config[$c.id]=='1'}checked="checked"{/if} onchange="simulateCart('#cart3');"/> 
             <strong >{$c.name}</strong>
              {if $c.required=='1'}*{/if}
        
             </td></tr>
 

{elseif $c.type=='textarea'}
           
              <tr><td colspan="2"><label for="custom_field[{$c.id}]" class='styled'>{$c.name}
              {if $c.required=='1'}*{/if}
              </label>
             <textarea name='custom_field[{$c.id}]' class='styled' onchange="simulateCart('#cart3');">{$contents[0].config[$c.id]}</textarea>
              </td></tr>

{elseif $c.type=='radio'}
          
           <tr><td colspan="2"><label for="custom_field[{$c.id}]" class='styled'>{$c.name}
              {if $c.required=='1'}*{/if}
              </label>
            
           
            {foreach from=$c.allvalues item=val}
                {$val}: <input name='custom_field[{$c.id}]' type='radio' value="{$val}" {if $contents[0].config[$c.id]==$val}checked="checked"{/if} onchange="simulateCart('#cart3');"/> <br/>

           {/foreach}
              </td></tr>
			  
{elseif $c.type=='select'}
            <tr><td colspan="2"><label for="custom_field[{$c.id}]" class='styled'>{$c.name}
              {if $c.required=='1'}*{/if}
              </label>
            
             <select name='custom_field[{$c.id}]' class='styled' style="width:98%" onchange="simulateCart('#cart3');">
            {foreach from=$c.allvalues item=val}
                <option value="{$val}" {if $contents[0].config[$c.id]==$val}selected="selected"{/if}>{$val}</option>
           {/foreach}

            </select></td></tr>

{elseif $c.type=='multiselect'}
            <tr><td colspan="2"><label for="custom_field[{$c.id}][]" class='styled'>{$c.name}
              if ($config['required']=='1')
               *
              </label>
            
             <select name='custom_field[{$c.id}][]' class='styled' multiple style="width:98%">
            {foreach from=$c.allvalues item=val}
                <option value="{$val}">{$val}</option>
             {/foreach}
              </select></td></tr>
        {/if}
{/foreach}
{/if}