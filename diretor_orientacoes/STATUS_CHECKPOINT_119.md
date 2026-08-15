# ORIGEM — Checkpoint 119: Passagem Física para a Margem

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 1–6 / Takes 1–11 corrigidos
**Estado:** Validação concluída; pronto para sincronização.

## Continuidade entregue

O corredor Floresta Densa → Acampamento Majestic → Ruínas Submersas recebeu sete lajes de chegada entre `z=222` e `z=240`. Cada laje possui um `StaticBody3D` e um `CollisionShape3D` próprio, eliminando a dependência exclusiva da colisão da malha do terreno no último trecho até à margem ocidental. A faixa principal mantém-se livre de caixas, afloramentos e vegetação.

A captura de QA do Take 11 foi ajustada para 1600×900, com espera de carregamento suficiente para a câmara cinematográfica permanecer ativa. A composição documenta o trilho, a bacia escura do lago, a separação de luz fria da água, os pilares e a montanha distante, sem invadir Regiões 7–12.

## Validações

| Teste | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado, sem erro de GDScript. |
| Captura cinematográfica | Take 11 ativo e gravado em 1600×900. |
| Gameplay de 30 segundos | Aprovado, sem `Parse Error` ou falha de carregamento. |
| Integridade da rota | Lajes da margem com colisores próprios; terreno regional conserva colisão. |
| Fronteira de branches | Nenhum módulo de Regiões 7–12 foi alterado. |

## Artefactos

| Ficheiro | Utilidade |
|---|---|
| `origem_v2_phase118_take11_majestic_lake_transition.png` | Evidência de composição em alta resolução. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase119_ShoreAccess_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase119_ShoreAccess_Validated.sha256` | SHA-256 `956be48b1bbfcbf6feb058aa2e0020fc0e100dd9ddd430acb4e13d1eb765ad99`. |

> **Continuidade automática:** este commit é uma evidência de execução, não um ponto de paragem. Após a publicação, o desenvolvimento prossegue imediatamente na próxima melhoria das Regiões 1–6, com consulta periódica de `diretor_orientacoes/`.
