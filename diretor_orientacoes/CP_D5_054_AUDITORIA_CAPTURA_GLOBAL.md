# CP-D5-054 — Auditoria global de captura headless

## Resultado

A auditoria global encontrou **sete handlers** que ainda chamam directamente `get_viewport().get_texture().get_image()` sem testar textura ou imagem nulas. Os handlers protegidos do contrato Elias e de outros previews já cobertos não aparecem nesta lista.

| Estado | Quantidade |
|---|---:|
| Handlers vulneráveis identificados | 7 |
| Handlers com fallback `snapshot_unavailable` | 12 |
| Módulos de produção envolvidos | 0 |

Ficheiros pendentes de endurecimento:

| Ficheiro | Área |
|---|---|
| `entities/player/third_person/EliasThirdPersonPreview.gd` | Elias isolado |
| `levels/dev5/CartographicPlacementPreview.gd` | Placement |
| `levels/dev5/MajesticEliasVegetationReadPreview.gd` | R5 leitura |
| `levels/dev5/R6MonolithClearancePreview.gd` | R6 folga |
| `levels/dev5/StoneBridgeLandmarkPreview.gd` | R2 ponte |
| `levels/dev5/SubmergedShoreMonolithPreview.gd` | R6 monólito |
| `levels/dev5/VossWaystationPreview.gd` | R1 Voss |

O parser Compatibility permanece limpo e nenhum módulo de produção foi alterado. A auditoria não mascara a pendência: a correcção destes sete handlers é aberta como CP-D5-055 para preservar uma alteração pequena, reproduzível e verificável.

O inventário completo está em `CP-D5-054_UNSAFE_CAPTURE_HANDLERS.list`.
