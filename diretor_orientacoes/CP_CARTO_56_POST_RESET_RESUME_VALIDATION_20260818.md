# CP-CARTO-56 — Retomada Pós-Reset e Prontidão de Integração

## Estado recuperado

Os dois checkouts foram restaurados directamente das branches remotas publicadas: `feature/cine07-final` em `d9ce862` e `feature/dev2-mountain-canyon` em `fd31a63`. Ambos voltaram limpos. O Godot 4.7.1 foi restaurado no sandbox para a validação técnica.

## Validações executadas

| Verificação | Resultado |
| --- | --- |
| Parser/editor Godot 4.7.1 headless | Aprovado |
| Menu → Novo Jogo → mundo | Aprovado em sessão de 36 segundos |
| Erros de parser/runtime | Nenhum erro de script, parser, fatal ou crash |
| Prova QA oficial do Arco | Aprovada: arco completo, eixo físico correcto e sem intersecção de copa |
| Capturas | `post_reset_menu_newgame_world_1600x900.png`; `post_reset_arch_stage_1600x900.png` |

A primeira captura pós-reset tinha sido obtida ainda no splash do motor e foi rejeitada; a recaptura tardia foi a evidência válida usada nesta decisão.

## Decisão e continuidade

A recuperação está **aceite tecnicamente**. O spawn QA de saída da Casa Voss mantém orientação calculada para o alvo físico do Arco; não foi alterado porque a rotina já usa o eixo correcto. O screenshot desse spawn não é promovido como referência estética isolada; a prova oficial do estágio `arco` continua a ser a tomada macro aprovada.

A integração física R6→R7 não pode iniciar porque Dev2 continua na ponta `fd31a63`. Quando uma ponta posterior for publicada, executar imediatamente a checklist pareada `CHECKLIST_R6_R7_DEV4_CP_D2_214.md`, sem alterar módulos R7–R12 pela branch cinematográfica.
