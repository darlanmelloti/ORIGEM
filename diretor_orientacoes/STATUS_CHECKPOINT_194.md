# ORIGEM — Checkpoint 194: Micro-detalhes Narrativos da Casa Voss

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `37e5f42` — `feat(voss): add candle on table and wall lantern for interior narrative detail`.

## Incremento aplicado

Foram adicionados dois micro-detalhes narrativos ao interior da Casa Voss (`_build_interior` no `VossHouse.gd`):

**Vela na mesa de Tomás** — cilindro de cera (`0.07 × 0.22 × 0.07`) com chama emissiva (`0.04 × 0.06`) e `OmniLight3D` de 0.90 de energia e alcance 3.2 m, cor laranja quente `(1.0, 0.48, 0.10)`. Ancora o olhar no objeto narrativo central da casa sem competir com a lareira.

**Lanterna de parede junto à espada** — caixa metálica (`0.18 × 0.28 × 0.18`, metálico 0.60) com núcleo emissivo e `OmniLight3D` de 0.75 de energia e alcance 4.5 m, cor âmbar `(1.0, 0.44, 0.10)`. Ilumina o objeto narrativo da espada sem apagar o crepúsculo exterior visível pela janela.

| Elemento | Posição local | Energia | Alcance |
|---|---|---|---|
| Vela (chama) | `(0.68, 1.78, 1.22)` | emissão 1.60 | — |
| Luz da vela | `(0.68, 1.95, 1.22)` | 0.90 | 3.2 m |
| Lanterna de parede | `(-3.30, 2.62, 0.62)` | emissão 1.20 | — |
| Luz da lanterna | `(-3.30, 2.78, 0.62)` | 0.75 | 4.5 m |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 1 | `origem_v2_audit_take1.png` | Exterior da Casa Voss estável; árvore focal visível; lanterna da varanda activa. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `VossHouse.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase194_VossCandle_Validated.zip`

SHA-256: `e4c7bfd3b1191f8eca9dd33dffc0fd462d41c550c6b8cffe54ce035e04a6b6b5`

## Próximas prioridades

1. **CP 195 — Passe de ecologia da margem sul da Estrada do Rio** — adicionar 2–3 pedras de margem e fetos na curva sul do rio para completar a ecologia ribeirinha.
2. **CP 196 — Auditoria final de Takes 1–11** — recapturar todos os takes para confirmar que os refinamentos dos CPs 182–194 são visíveis.
3. **Push pendente** — os commits `37e5f42` e `9f783dc` aguardam push para o GitHub (requer autenticação).

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
