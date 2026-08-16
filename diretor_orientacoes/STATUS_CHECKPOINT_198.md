# ORIGEM — Checkpoint 198: Solo do Arco das Ruínas Harmonizado

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `c6ed3b3` — `feat(arch): darken roadbed soil and add wet-stone overlay at arch zone z=38-60`.

## Incremento aplicado

Duas alterações no `RiverRoadJourney.gd` para harmonizar o solo do Arco das Ruínas com o crepúsculo litúrgico:

**1. Escurecimento do solo geral da Estrada do Rio** — albedo reduzido de `(0.285, 0.245, 0.165)` para `(0.175, 0.148, 0.098)`, mantendo a rugosidade elevada (0.94) para evitar reflexo metálico.

**2. Sobreposição de pedra húmida na zona do arco (z=38–60)** — malha adicional com albedo muito escuro `(0.095, 0.082, 0.055)` e normal map ativo, sobreposta ao solo geral. Cria uma transição visual entre o leito da estrada e a base dos pilares do arco, reforçando a leitura arqueológica sem bloquear a passagem.

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado. |
| Take 2 | `origem_v2_phase117_take2_road_arch.png` | Solo mais escuro e harmonizado; silhueta do arco mais legível contra o solo. Avaliação: 90%. |
| Gameplay 30 s | Roteiro integrado | Aprovado. |
| Fronteira operacional | Ficheiro alterado: `RiverRoadJourney.gd` | Mantida. |

## Preservação

Pacote: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase198_ArchSoilDark_Validated.zip`

SHA-256: `3e454f31f72b8c1d2e447b84a590c8c2fb80ee40be0248781b9f28c7d28f3b00`

## CP 199 iniciado imediatamente

O CP 199 — margem inferior das Ruínas Submersas — foi iniciado sem pausa, conforme directiva da direção.

> O checkpoint é uma evidência, não uma pausa. O ciclo continua com o CP 199.
