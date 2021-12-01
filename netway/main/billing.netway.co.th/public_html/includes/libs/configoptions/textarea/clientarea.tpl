{once}{literal}
 <style>
      .field-textarea{
          font-family: Menlo,Monaco,Consolas,"Liberation Mono","Courier New",monospace;
          white-space: pre;
          padding: 0;
          background: none;
          border: none;
          font-size: 13px;
      }
 </style>
{/literal}{/once}
{foreach from=$cst.items item=cit}{if $cit.name}{$cit.name}{/if}
     <pre class="field-textarea text-small">{if $cst.data[$cit.id]}{$cst.data[$cit.id]|escape}{/if}</pre>
 {/foreach}