# CP-AAA-02 — Recolha de Evidência AAA Condicionada

## Resultado executivo

O CP-AAA-02 produziu evidência técnica adicional, mas não autoriza ainda a aprovação AAA formal. A sessão de jogo headless em Compatibility completou os 36 segundos obrigatórios por timeout controlado (`QA_EXIT=124`), sem `Parse Error` ou `SCRIPT ERROR`. A cena isolada `CartographicGroundingPreview.tscn` também completou 36 segundos e registou dois candidatos grounded por raycast, com X/Z preservados.

A auditoria continua condicionada porque foram emitidos avisos de FSR1 incompatível com o renderer Compatibility, a telemetria de frame time/luzes não foi fornecida por esta sessão, e os parâmetros literais `floor_max_angle` e `floor_snap_length` não foram encontrados em `entities/player/Player.gd`. A produção não foi alterada nem promovida.

## Evidência de runtime

| Verificação | Resultado | Decisão |
|---|---:|---|
| Parser/import Godot | Exit `0` na execução de editor | Passou |
| Runtime de jogo | `QA_EXIT=124` após 36 s | Passou o gate temporal |
| Erros de sintaxe | `0` | Passou |
| Avisos FSR1 em Compatibility | `1` na sessão de 36 s; muitos no editor | Pendente de configuração |
| Produção alterada | `false` | Preservada |
| Promoção automática | `false` | Bloqueada |

A sessão de jogo foi executada sem `--quit`, evitando o falso positivo da execução anterior que terminou em aproximadamente três segundos com exit `0`. O timeout controlado aos 36 segundos confirma apenas a duração da sessão, não uma métrica de frame time estável.

## Evidência de grounding isolado

A cena `CartographicGroundingPreview.tscn` completou uma sessão de 36 segundos (`QA_EXIT=124`) e registou:

| Candidato | Grounded | Y desejado | Y de impacto | X/Z preservados | Colisor |
|---|---:|---:|---:|---:|---|
| `anexo_casa_voss` | `true` | `15.00` | `-2.78` | `true` | `TerrenoColisorQA` |
| `ponte_marco_2` | `true` | `18.00` | `-2.71` | `true` | `TerrenoColisorQA` |

A evidência confirma o contrato isolado de raycast e preservação cartográfica X/Z. Ela não prova, por si só, que o controlador de Elias v9 aplica `floor_max_angle=70°` ou um `floor_snap_length` específico, porque esses identificadores não foram encontrados no `Player.gd` auditado.

## Estado de criação e decisão

O pacote está tecnicamente mais forte do que no CP-AAA-01: o gate temporal de 36 segundos foi cumprido e o grounding isolado produziu evidência observável. Ainda assim, o estado correto é **AAA_CONDITIONAL / RUNTIME_GATE_PASS / GROUNDING_PREVIEW_PASS / FORMAL_APPROVAL_PENDING**.

A próxima ação deve recolher telemetria real de frame time e luzes, resolver o aviso FSR1 ou documentar a escolha do renderer, e apresentar a alteração versionada do controlador de Elias caso o ângulo de 70° e o snap sejam requisitos de produção. Nenhuma integração em `Player.gd`, `VossHouse.gd` ou outros módulos de produção deve ser feita sem aprovação explícita.

**STATUS_CODE: CP-AAA-02 / 36S_RUNTIME_PASS / ISOLATED_GROUNDING_PASS / PRODUCTION_BOUNDARY_PRESERVED / OWNER_APPROVAL_REQUIRED.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-02_RUNTIME_36S.log` — sessão de runtime de jogo de 36 segundos.

[2]: `diretor_orientacoes/CP-AAA-02_GROUNDING.log` — sessão isolada de grounding por raycast.

[3]: `levels/dev5/CartographicGroundingSystem.gd` — implementação isolada do contrato de grounding.

[4]: `entities/player/Player.gd` — controlador auditado para confirmação dos parâmetros de movimento.
