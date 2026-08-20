# CP-D5-534 — Handoff de bounding boxes e restrições R6→R7

## Objectivo

Formalizar o pacote de integração para a frente proprietária da Região 7, sem criar geometria canónica de produção. O pacote descreve a expansão modular aprovada do corredor R6→R7, fornece bounding boxes auditáveis e preserva o espelhamento cartográfico e o grounding já validados.

## Âncoras e volumes

| Elemento | Centro aproximado | Extensão | Bounding box aproximada X/Y/Z |
|---|---|---|---|
| Plano de preview | `(100,-0.5,302)` | `180×1×180` | `[10..190] × [-1..0] × [212..392]` |
| Plataforma R6 | `(60,0.3,252)` | `8×0.6×8` | `[56..64] × [0..0.6] × [248..256]` |
| Pilar R6 | `(60,2,252)` | `1.2×4×1.2` | `[59.4..60.6] × [0..4] × [251.4..252.6]` |
| Gate central | `(100,0,302)` | `7×5×12` aprox. | `[96.5..103.5] × [0..5] × [296..308]` |
| Faixa principal | eixo `(100,0.12,282..322)` | `4×0.24×43.6` aprox. | `[98..102] × [0..0.24] × [260..324]` |
| Faixa paralela | eixo `(108,0.12,282..322)` | `3.2×0.24×43.6` aprox. | `[106.4..109.6] × [0..0.24] × [260..324]` |
| Marcador R7 | `(140,0.3,352)` | plataforma `8×0.6×8` | `[136..144] × [0..0.6] × [348..356]` |

Os volumes são referências de preview; a frente proprietária deve recalcular o Y no terreno canónico antes de integrar. O eixo Z cresce para norte e a entrada R7 permanece no marcador `PASSAGEM: VILA ELEVADA`, ID 7.

## Restrições

A integração deve manter `marker_only=true` até autorização explícita da frente proprietária. Não deve instanciar `Player.gd`, `TempleLevel.gd` ou `HighlandRegion.gd` neste pacote. O preview mantém `dynamic_lights=0`, com limite global de `≤16` luzes para a GTX 1050 Ti; qualquer iluminação regional futura deve ser contabilizada conjuntamente. A passagem mínima de referência é `2.4 m`, e o corredor de duas faixas permanece navegável no modo técnico.

## Evidência

A origem dos dados é `R6R7ModularMirrorPreview.tscn` e o relatório `CP_D5_533_AUDITORIA_FINAL_R6_R7.md`. A validação seguinte deve incluir parser Godot, QA de 36 segundos, contagem de luzes, grounding, `production_modules_changed=false` e checksum SHA-256.

**STATUS_CODE: HANDOFF_READY.**
