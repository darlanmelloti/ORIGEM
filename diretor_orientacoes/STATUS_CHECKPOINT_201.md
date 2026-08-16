# ORIGEM — Checkpoint 201: Ponte de Integração Física Região 6 → Região 7

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 1–6 exclusivamente. Este checkpoint prepara o handoff para o Dev2.

## Incremento Aplicado

Foi adicionada a função `_build_region7_transition()` ao `TempleLevel.gd`, que cria o nó `Region7TransitionGate` como ponte física entre as Ruínas Submersas (Região 6, z≈282) e a Vila Elevada (Região 7, z≈352).

### Elementos criados

**Trilho de acesso:** 12 lajes de pedra (z=285–345, x≈140) com escala e rotação variadas, cada uma com StaticBody3D e CollisionShape3D para navegação física. O jogador pode caminhar desde a margem norte do lago até ao portão sem saltar.

**Portão de transição:** dois pilares (0.65×4.8×0.65m) e uma verga (7.2×0.55×0.65m) em z=348, com material de pedra escura harmonizado com o Arco das Ruínas.

**Marcador de spawn para o Dev2:** nó `SpawnRegiao7_Dev2_HandoffPoint` em `Vector3(140, y, 352)` — este é o ponto exacto onde o Dev2 deve posicionar o spawn de entrada da Região 7.

**Luz de sinalização:** OmniLight3D âmbar (energia 0.65, alcance 12m) no topo do portão para guiar o jogador visualmente.

## Instruções para o Dev2

O Dev2 deve:

1. Verificar que o `HighlandRegion.gd` posiciona a Vila Elevada com `village_x=140, village_z=352`.
2. Criar um trigger de área (Area3D) em `Vector3(140, y, 352)` que activa a transição para a Região 7.
3. O portão `Region7TransitionGate` já existe na branch dev1 — o Dev2 não deve duplicar este nó.

## Verificações

| Verificação | Resultado |
|---|---|
| Sintaxe Godot (headless) | ✅ Aprovado |
| Gameplay integrado 30s | ✅ Aprovado |
| Fronteira operacional | ✅ Mantida — TempleLevel.gd é módulo partilhado |

## Próximo Passo

CP 202 — Refinamento visual do trilho de acesso à Região 7: adicionar ecologia lateral (pedras e fetos) no corredor z=285–345 para que a transição não pareça um corredor vazio.
