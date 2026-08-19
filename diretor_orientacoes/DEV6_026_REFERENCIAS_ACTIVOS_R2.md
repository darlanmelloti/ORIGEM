# DEV6-026 — Referências dos Activos R2

A auditoria confirmou que os preloads usados pela integração R2 recorrem a caminhos `res://` relativos ao projecto. As dependências de rocha, pilar, feto, pinheiro, carvalho e cervo existem fisicamente no clone Dev6.

| Activo | Caminho relativo | Estado |
|---|---|---:|
| Pilar CC0 | `res://assets/models_cc0/stone_tallC.glb` | PASS |
| Rocha CC0 | `res://assets/models_cc0/cliff_cave_rock.glb` | PASS |
| Feto | `res://assets/models_polyhaven/fern_02/fern_02_1k.gltf` | PASS |
| Pinheiro | `res://assets/models_generated/ez_pine_medium_pbr.glb` | PASS |
| Carvalho | `res://assets/models_cc0/tree_oak_dark.glb` | PASS |
| Cervo CC0 | `res://assets/models_cc0/deer_quaternius_cc0.glb` | PASS |
| Sistemas Dev5 reutilizados | `res://levels/dev5/...` | PASS |

Não foram encontrados caminhos absolutos, referências quebradas ou dependências externas na camada R2. A integração mantém-se portátil entre clones Git.
