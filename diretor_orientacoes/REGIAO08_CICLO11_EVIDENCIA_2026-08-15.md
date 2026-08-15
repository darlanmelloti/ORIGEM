# Região 8 — Ciclo 11 de Validação Contínua

**Branch:** `feature/dev2-mountain-canyon`  
**Motor:** Godot 4.7.1  
**Escopo:** Região 8 / Take 13 — Observatório da Orion

## Implementação

A Região 8 recebeu uma montagem orgânica CC0 baseada em `stone_largeA.glb` e `stone_tallC.glb`: cinco massas de casca, três massas de coroa, seis pilares, um olho rochoso emissivo e iluminação de ressonância azul com preenchimento frontal controlado. Os placeholders de plinth cilíndrico e domo esférico foram removidos. Foi criado o modo de validação `ORIGEM_VALIDATION_REGION=8`, com bypass de prólogo limitado à Região 8 e câmara determinística no `Takes5to7Director.gd`.

## Evidência

| Artefacto | Caminho |
| --- | --- |
| Gameplay ~30 s | `validation/region8-cycle-11/region8-gameplay-30s.mp4` |
| Print 1600×900 | `validation/region8-cycle-11/region8-print-1600x900.jpg` |
| Findings | `validation/region8-cycle-11/region8-cycle-findings.md` |
| Parser | `validation/region8-cycle-11/parser.log` |

O parser e o F5 passaram sem erros de script. O aviso ALSA/dummy-audio é específico do ambiente de captura. O olho azul está comprovado na imagem; o anel orgânico permanece em estado de refinamento visual, sem escalada adicional de emissão.

## Fronteira

Nenhuma Região 1–6 foi alterada. A branch continua limitada às Regiões 7–12. A próxima subtarefa deve melhorar a continuidade Região 8→9, mantendo o Observatório como marco e conduzindo a Trilha da Montanha sem tocar no bloco do Desenvolvedor Principal.
