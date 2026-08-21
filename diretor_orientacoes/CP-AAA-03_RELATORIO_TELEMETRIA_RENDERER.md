# CP-AAA-03 — Auditoria de Telemetria e Renderer

## Resultado executivo

A sessão de runtime em Godot Compatibility/OpenGL3 completou os 36 segundos obrigatórios por timeout controlado (`QA_EXIT=124`) e não apresentou erros de parser (`PARSER_ERRORS=0`). A branch estava sincronizada em `72142ea` antes da execução. A produção permaneceu protegida e a promoção automática continuou desactivada.

A telemetria de frame time e de luzes dinâmicas **não foi exposta pelo comando headless utilizado**. Portanto, o CP-AAA-03 confirma duração e ausência de erro de sintaxe, mas não confirma desempenho sustentado, orçamento de luzes ou estabilidade de frame time.

## Renderer

O projecto declara `scaling_3d/mode=1` e `scaling_3d/scale=0.75` em `project.godot`. Durante a execução Compatibility/OpenGL3 foi emitido um aviso: `FSR1 is only available when using the Forward+ renderer.` O aviso não causou erro de parser nem interrompeu a sessão, mas indica que a configuração de upscaling precisa ser resolvida ou documentada antes da aprovação visual/performance final.

| Verificação | Resultado | Classificação |
|---|---:|---|
| Sincronização inicial | `0 0` | Passou |
| Runtime | 36 s, `QA_EXIT=124` | Passou gate temporal |
| Erros de parser | `0` | Passou |
| Frame time | Não exposto | Pendente |
| Luzes dinâmicas | Não exposto | Pendente |
| Aviso FSR1 | 1 | Pendente de configuração |
| Produção alterada | `false` | Preservada |
| Promoção automática | `false` | Bloqueada |

## Decisão

O estado do pacote é **AAA_CONDITIONAL / RUNTIME_36S_PASS / TELEMETRY_PENDING / RENDERER_WARNING_PENDING**. Não há base suficiente para afirmar que a build cumpre o padrão AAA de performance. A integração de `Player.gd`, `VossHouse.gd` ou qualquer módulo de produção continua bloqueada até existir telemetria de frame time/luzes e uma decisão explícita dos owners.

A próxima tarefa deve adicionar ou activar uma fonte segura de telemetria em uma cena isolada, confirmar o orçamento de luzes e decidir entre desactivar o modo FSR1 no Compatibility ou executar a validação Forward+ compatível com FSR1.

**STATUS_CODE: CP-AAA-03 / RUNTIME_36S_PASS / TELEMETRY_NOT_EXPOSED / FSR_WARNING / PRODUCTION_BOUNDARY_PRESERVED.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-03_TELEMETRY_RENDERER.log` — log bruto da sessão de runtime e renderer.

[2]: `project.godot` — configuração de escala 3D auditada.

[3]: `diretor_orientacoes/CP-AAA-02_RELATORIO_EVIDENCIA_CONDICIONADA.md` — evidência anterior de runtime e grounding.
