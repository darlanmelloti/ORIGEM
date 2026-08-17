# CP-CINE-15 — Matriz de Pivôs dos Activos de Rocha

A sonda isolada mediu os limites locais das três malhas candidatas. Todos os pivôs estão **0,05 m abaixo** da base geométrica; para aterrar uma instância no solo de altura `H`, a sua posição-base deve usar `Y = H + 0,05 × escala_y`.

| Activo | Limite inferior Y | Limite superior Y | Offset de aterramento | Uso recomendado |
|---|---:|---:|---:|---|
| `cliff_blockSlope_rock.glb` | -0,0500 | 0,9500 | +0,0500 × escala Y | Piso inclinado ou ombro de corredor |
| `cliff_cave_rock.glb` | -0,0500 | 0,9500 | +0,0500 × escala Y | Parede lateral; limite Z assimétrico, requer orientação controlada |
| `stone_largeB.glb` | -0,0500 | 0,3803 | +0,0500 × escala Y | Pedra de transição e base lateral |

A matriz elimina a causa primária de assentamento arbitrário detectada no CP-CINE-14. O CP-CINE-16 deve montar somente uma secção curta com estas três regras: piso de `cliff_blockSlope_rock` aterrado pelo offset medido; paredes de `cliff_cave_rock` sem escala vertical; pedras `stone_largeB` apenas nas transições. A secção será capturada isoladamente antes de regressar ao corredor Orion.
