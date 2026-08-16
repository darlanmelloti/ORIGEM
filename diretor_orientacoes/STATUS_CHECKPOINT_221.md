# CP 221 — Vista Cartográfica Lago → Vila Elevada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Região 6 e interface técnica autorizada para Região 7.  
**Contrato aplicado:** `CONTRATO_CARTOGRAFICO_MUNDO_3D.md`.

## Alteração

Foi criado o nó `VistaCartograficaLagoParaVila` em `TempleLevel.gd`, antes do handoff técnico de `z=285`. Duas estelas de pedra e respectivas bases musgosas fazem a subida além do lago tornar-se uma direcção visual clara, preservando o portão de entrada da Região 7 em `Vector3(140, y, 352)`.

Os elementos estão colocados em `z=276` e `z=281`: antes da Região 7, sem colisores, luzes ou alteração a `HighlandRegion.gd` e `OrionDestinationRegion.gd`.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Alteração de módulos Regiões 7–12 | Nenhuma |
| Handoff `Vector3(140, y, 352)` | Preservado |

## Próximo incremento autónomo

**CP 222 — Auditoria de escala cartográfica das Regiões 1–6.** Será verificada a sequência de distâncias, vistas e marcos Casa → Rio → Arco → Floresta → Majestic → Lago, para identificar a próxima lacuna de topologia sem alterar o bloco do Dev2.
