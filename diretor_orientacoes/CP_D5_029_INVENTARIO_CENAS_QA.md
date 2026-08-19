# CP-D5-029 — Inventário e varredura das cenas QA Dev5

## Resultado

A varredura de editor Godot 4.7.1 encontrou **15 cenas QA** em `levels/dev5/` e não encontrou `SCRIPT ERROR`, `Parse Error` ou `Failed to load script`. Os avisos repetidos sobre FSR1 pertencem ao renderer Compatibility em modo headless e não indicam falha de parser.

| Grupo | Cenas |
|---|---:|
| Cartografia/aterramento/regressão | 5 |
| Marcos e candidatos | 6 |
| Auditorias de malha/vegetação | 3 |
| Composição multi-marco | 1 |

As cenas permanecem isoladas em QA. A varredura não promoveu candidatos R4/R6, não alterou módulos regionais, não repetiu geometrias rejeitadas e mantém a captura gráfica como pendência separada. O log bruto está em `CP-D5-029_PARSER_SWEEP.log`.

## Higiene

Os ficheiros `.uid` gerados automaticamente pela abertura do editor foram removidos antes da publicação; não fazem parte do checkpoint. `git diff --check` passou.

## Próxima acção

A continuidade abre o CP-D5-030 para a próxima auditoria ou melhoria de fundação não concorrente permitida pelo protocolo.
