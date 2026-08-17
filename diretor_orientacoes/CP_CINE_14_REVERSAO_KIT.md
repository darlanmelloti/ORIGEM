# CP-CINE-14 — Reversão do Kit Isolado de Corredor

O kit isolado utilizou `cliff_blockSlope_rock.glb` como piso e `cliff_cave_rock.glb` como paredes, cada piso com um colisor próprio. A prova visual revelou que os pivôs e as caixas de limites destes activos não correspondem à sua base aparente: a composição produziu uma massa escalonada e elementos sem aterramento visual. Como o teste isolado não atingiu o nível visual exigido, o kit não foi integrado na Caverna Orion.

A implementação e o harness temporário foram removidos integralmente. A base voltou a passar a validação Godot headless sem alterações de geometria em R10–R12.

| Critério | Resultado |
|---|---|
| Kit isolado compilou | Sim |
| Piso e contrafortes visualmente aterrados | Não |
| Integração no mundo | Não realizada |
| Reversão e validação headless | Aprovadas |

## CP-CINE-15 já iniciado

Antes de qualquer novo corredor, a equipa deve medir os pivôs e limites reais dos activos `cliff_blockSlope_rock.glb`, `cliff_cave_rock.glb` e `stone_largeB.glb` em cena isolada. A próxima solução deve posicionar cada activo pelo limite inferior medido, e não pela origem do nó. Só um activo com base calibrada poderá ser usado para piso, parede ou tecto da Caverna Orion.
