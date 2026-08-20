# CP-D5-528 — Contrato de integração modular e espelhamento R6→R7

## Objectivo

A nova frente Dev5 apoia directamente a integração de malhas 3D modulares e a expansão do espelhamento cartográfico na transição entre o marco 6 e a entrada da Região 7. A implementação permanece isolada em `levels/dev5/`, `assets/models_dev5/` e `entities/player/third_person/`, sem alteração de `Player.gd`, `TempleLevel.gd`, `HighlandRegion.gd` ou outros módulos de produção.

## Contrato espacial

| Elemento | Contrato |
|---|---|
| Âncora R6 | `Vector3(60, y, 252)`; somente Y resolvido por grounding |
| Gate de transição | Corredor técnico entre R6 e R7, com eixo norte em Z crescente |
| Entrada R7 | `Vector3(140, y, 352)`; marcador `PASSAGEM: VILA ELEVADA`, ID 7 |
| Distância de referência | Pelo menos `60 m` entre marcos principais |
| Offset local | `(0, 0)` no plano X/Z; deslocamentos explícitos e auditáveis |
| Espelhamento | Preserva X/Z canónicos, replica leitura cartográfica e resolve Y por raycast |
| Terceira pessoa | Elias apresentado por `EliasThirdPersonPreview` com `CameraQA` isolada |

## Contrato modular

Cada malha deve ser uma cena candidata independente, com materiais e colisores locais, pivô definido, bounding box documentada e sem dependência de módulos regionais de produção. A composição da transição deve privilegiar uma sequência navegável R6→gate→R7, sem criar geometria canónica de Região 7; a integração posterior pertence ao proprietário da Região 7.

## Orçamento técnico

| Recurso | Limite Dev5 para o preview |
|---|---:|
| Luzes dinâmicas próprias | `0` no espelhamento cartográfico; máximo `8` se a integração regional autorizar iluminação diegética |
| Limite global simultâneo | `≤16` luzes, incluindo as restantes frentes |
| Colisores por módulo | `≤20` |
| SurfaceTool por módulo | `≤4` |
| Alcance de luz regional | `≤15 m` |
| Alterações em produção | `0` |

## Aceitação

O checkpoint será aceite somente com parser Godot 4.7.1 sem `SCRIPT ERROR` ou `Parse Error`, QA headless de 36 segundos em 1600×900, grounding confirmado em R6 e na entrada R7, câmara `CameraQA` activa, `production_modules_changed=false`, contagem de luzes dentro do orçamento e pacote SHA-256 do relatório e logs.

O contrato não autoriza integração automática na Região 7. Ele fornece a evidência técnica e o handoff para a frente proprietária, mantendo o ciclo No-Stop activo.
