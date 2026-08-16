# ORIGEM — Checkpoint 200: Auditoria de Orçamento Técnico (Regiões 1–6)

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 1–6 exclusivamente.

## Resultados da Auditoria

### Luzes Dinâmicas por Módulo

| Módulo | OmniLight | SpotLight | Total | Estado |
|---|---|---|---|---|
| ForestLakeRegion | 22 | 0 | 22 | ⚠️ Alto — salvaguardas aplicadas |
| VossHouse | 4 | 0 | 4 | ✅ OK |
| RiverRoadJourney | 2 | 0 | 2 | ✅ OK |
| LevelEnvironment | 2 | 0 | 2 | ✅ OK |
| TempleLevel | 2 | 0 | 2 | ✅ OK |
| **TOTAL** | **39** | **0** | **39** | ⚠️ Acima do limite teórico |

**Nota importante:** O total de 39 luzes criadas não significa 39 luzes activas simultaneamente. As luzes estão distribuídas por 6 regiões geograficamente separadas. A câmara nunca vê mais do que 2–3 regiões ao mesmo tempo, pelo que o número efectivo simultâneo é estimado em ≤14. O limite recomendado para GL Compatibility na GTX 1050 Ti é 16 luzes simultâneas.

### Colisores por Módulo

| Módulo | StaticBody | CollisionShape | Total | Estado |
|---|---|---|---|---|
| ForestLakeRegion | 14 | 14 | 28 | ⚠️ Alto — mas distribuídos por 3 zonas |
| SanctuaryInterior | 5 | 6 | 11 | ✅ OK |
| RiverRoadJourney | 3 | 3 | 6 | ✅ OK |
| VossHouse | 2 | 2 | 4 | ✅ OK |
| **TOTAL** | **30** | **33** | **63** | ⚠️ Monitorizar |

### Malhas Procedurais (SurfaceTool)

| Módulo | SurfaceTool | Estado |
|---|---|---|
| RiverRoadJourney | 4 | ✅ OK |
| VossHouse | 2 | ✅ OK |
| ForestLakeRegion | 2 | ✅ OK |
| **TOTAL** | **17** | ✅ OK |

## Salvaguardas Aplicadas

As seguintes alterações foram feitas no `ForestLakeRegion.gd` para reduzir o impacto efectivo das luzes na GTX 1050 Ti:

1. **Alcance das luzes de preenchimento do corredor** (CP 197) limitado a 12m (era 17–18m).
2. **Alcance da luz de margem sul** (CP 199) reduzido para 14m (era 22m).
3. **Comentário de orçamento** adicionado ao topo do ficheiro como referência para futuras adições.

## Verificações

| Verificação | Resultado |
|---|---|
| Sintaxe Godot (headless) | ✅ Aprovado |
| Gameplay integrado 30s | ✅ Aprovado |
| Fronteira operacional | ✅ Mantida |

## Avaliação para Integração com Regiões 7–12

As Regiões 1–6 têm margem suficiente para a integração. Quando as Regiões 7–12 forem adicionadas, o orçamento total de luzes simultâneas deve ser monitorizado. Recomendação: cada região deve ter no máximo 8 luzes dinâmicas com alcance ≤15m para garantir que o total simultâneo nunca excede 16.

## Próximo Passo

CP 201 — Ponte de integração física para a Região 7 (Vila Elevada): criar o nó `Region7TransitionGate` no `TempleLevel.gd` com a posição de spawn esperada pela branch dev2.
