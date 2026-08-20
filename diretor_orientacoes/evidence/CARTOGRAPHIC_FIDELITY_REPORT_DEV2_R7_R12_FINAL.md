# ORIGEM — Relatório Final de Fidelidade Cartográfica Dev2

## Estado actual

A branch `feature/dev2-mountain-canyon` está sincronizada no commit `bb2035f93237543011c3693e62f8f52d6c1d1cf1`. O escopo deste relatório cobre exclusivamente as Regiões 7–12; as Regiões 1–6 permanecem sob Dev1 em standby/read-only. A autoridade espacial continua a ser `mapaorigem.webp`, consumida por `levels/CartographicAnchors.gd`.

| Handoff | Distância auditada | Estado | Evidência principal |
|---|---:|---|---|
| R6→R7 | 128.062 | PASSED | CP-D2-R6R7-001 a 007 |
| R7→R8 | 74.967 | PASSED | CP-D2-R7R8-001 a 003 |
| R8→R9 | 22.361 | PASSED com limiar seguro de aproximação | CP-D2-R8R9-001 a 003 |
| R9→R10 | 319.462 | PASSED | CP-D2-R9R10-001 a 004 |
| R10→R11 | 14.000 | PASSED | CP-D2-R10R11-001 a 004 |
| R11→R12 | 449.782 | PASSED | CP-D2-R11R12-001 a 005 |
| R12→Cúpula Final | 7 segmentos | PASSED | CP-D2-R12-001 a 003 |

## Implementação física

O corredor R11→R12 foi alinhado aos anchors oficiais `R11 = (-116.0, 562.0)` e `R12 = (164.0, 210.0)`, com grounding contratual `y=0.15`, oito colliders `ColliderHandoffHubR12` e distância exacta de 449.782 unidades. A prova de percurso confirmou oito segmentos livres com clearance de 4.0 unidades.

A aproximação final do Hub à Cúpula termina agora no ponto autorizado `(164.0, 181.5)`. O último degrau visual da transição Hub→Cúpula foi corrigido para que a aproximação anterior `(164.0, 216.0)` termine no anchor do Hub `(164.0, 210.0)`, eliminando a descontinuidade de seis unidades sem criar uma autoridade concorrente.

| Área R12 | Resultado técnico |
|---|---|
| Degraus Hub→Cúpula | 7 |
| Colliders dos degraus | 7 |
| Portal vertical | Presente |
| Collider do portal | Presente |
| Collider da soleira da Cúpula | Presente |
| Luzes dinâmicas inventariadas | 13 |
| Limite GTX 1050 Ti | 16 |

## Evidência gráfica e QA

O panorama integrado R1→R12 foi corrigido com câmara ortográfica de tamanho 900 e tipografia reduzida para manter as 12 regiões no mesmo enquadramento. O auditor headless confirmou `CP-D2-R1R6-026_R1_R12_PANORAMA_CAPTURE=PASS`, 12 anchors, escopo `R1-R6_readonly` e `R7-R12_owner_dev2`, além de `PANORAMA_LIGHT_BUDGET_CONTRACT=PASS`.

A captura final da Cúpula Final produziu gameplay de 30.000000 segundos e print de 1600×900. O capturador confirmou `R12_DOME_LIGHT_BUDGET_CONTRACT=PASS max=16` e `R12_DOME_SCOPE_GUARD=PASS regions_7_12_only`. Toda a sobreposição de mapa e os capturadores panorâmicos permanecem QA-only; não substituem a geometria final de produção.

## Checkpoints publicados

| Commit | Entrega |
|---|---|
| `83e61851` | Panorama integrado inicial R1→R12 |
| `b65bd568` | Evidência visual R10→R11 |
| `0ff7a39a` | Corredor cartográfico R11→R12 e prova visual |
| `47e611c1` | Aproximação final R12 alinhada ao anchor |
| `f86266a4` | Panorama integrado final corrigido |
| `bb2035f9` | Cúpula Final, travessia e inventário R12 |

### ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R7→R12 — consolidação final Dev2
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Relatório técnico final e índice de evidências
- **NEXT_ACTION_IMMEDIATE**: Auditoria independente do pacote final e preparação da próxima directiva de acabamento, sem modificar R1–R6
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T23:42:30+01:00
