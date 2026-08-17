# CP-D2-031 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: PASSED_TECHNICAL / GROUP_INVENTORY_CAPTURED
- **TAREFA_EM_EXECUCAO_AGORA**: Contagem discriminada de render por sub-região.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

O inventário runtime discriminou os grupos desta forma:

| Sub-região | Meshes | OmniLights |
|---|---:|---:|
| Caverna do Orion (R10) | 18 | 3 |
| Câmara do Orion Cube (R11) | 11 | 5 |
| Hub Temporal (R12) | 18 | 4 |
| Cúpula Final (R12) | 45 | 7 |

O total confirmado é `129` meshes, `40` OmniLights e `15` StaticBody3D, com aproximadamente 18–22 FPS e 320–347 draw calls no harness. O parser/runtime Godot 4.7.1 passou, o gameplay tem 30 segundos e o print tem 1600×900. A Cúpula Final é o maior grupo geométrico e passa a ser o alvo prioritário de uma optimização selectiva, mantendo a silhueta monumental, a entrada, a navegação e os colliders.

**Evidência:** gameplay `e7ade0669cd1d1fa3c18774258dbec147fee301b8950b7aebe7cb4443b0ca554`; print `83a77a90803db92af849e83c6dabd30036f60b4caff4de7ff7d57aaee9be371f`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-031 e iniciar a optimização selectiva das 45 meshes da Cúpula Final, sem tocar nas Regiões 1–6.
