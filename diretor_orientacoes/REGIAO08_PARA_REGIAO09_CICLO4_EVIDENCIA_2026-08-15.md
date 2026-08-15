# Região 8 → Região 9 — Ciclo 4 de Continuidade

**Branch:** `feature/dev2-mountain-canyon`  
**Motor:** Godot 4.7.1  
**Escopo:** Região 8 / Observatório da Orion → Região 9 / Trilha da Montanha  
**Data:** 2026-08-15

## Implementação

A transição foi construída a partir da rota oficial já definida em `HighlandRegion.gd`. A Trilha da Montanha deixou de usar caixas primitivas no trecho Região 8→9 e passou a usar degraus orgânicos baseados em `stone_largeA.glb`, com material de pedra húmida, emissão azul contida e luzes de wayfinding de baixa energia. Foi criada uma câmara de transição larga e uma câmara próxima, selecionável por ambiente, sem duplicar a Câmara do Orion Cube.

A câmara próxima foi colocada a partir de coordenadas medidas pelo próprio `TerrainPatch.height_at`: os primeiros marcadores da rota estão aproximadamente em `(174.0, 28.27, 414.0)`, `(152.0, 23.88, 420.0)` e `(130.0, 23.51, 426.0)`. O diagnóstico permanece condicionado a `ORIGEM_DEBUG_ROUTE=1` e não aparece no fluxo normal.

## Evidência

| Artefacto | Caminho |
| --- | --- |
| Gameplay ~30 s | `validation/region8-to-9-close-cycle4/region8-to9-gameplay-30s.mp4` |
| Print 1600×900 | `validation/region8-to-9-close-cycle4/region8-to9-print-1600x900.jpg` |
| Findings | `validation/region8-to-9-close-cycle4/region8-to9-close-findings.md` |
| Parser | `validation/region8-to-9-close-cycle4/parser.log` |
| Diagnóstico de coordenadas | `validation/region8-to-9-close-cycle2/route-probe.log` |

## Resultado de auditoria visual

O ciclo foi aceito como **marcador de continuidade jogável**: uma cadeia diagonal de degraus orgânicos é visível no plano médio/direito e demonstra o caminho físico para a Trilha da Montanha. O ambiente ainda pode receber contraste atmosférico posterior, mas o requisito de wayfinding do sub-shot foi atingido sem greybox.

## Fronteira

Nenhum arquivo ou ativo das Regiões 1–6 foi alterado. A ordem urgente sobre Floresta → Acampamento Majestic → Ruínas Submersas continua pertencente exclusivamente à `feature/dev1-gameplay-core`. O próximo incremento desta branch deve conduzir Região 9 → Região 10, mantendo a montanha como destino e sem entrar no bloco do Desenvolvedor Principal.
