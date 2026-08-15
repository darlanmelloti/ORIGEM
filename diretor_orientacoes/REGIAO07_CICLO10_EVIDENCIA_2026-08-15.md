# Região 7 — Ciclo 10 de Validação Contínua

**Branch:** `feature/dev2-mountain-canyon`  
**Motor:** Godot 4.7.1  
**Escopo:** Região 7 / Take 12 — Vila Elevada

## Implementação

O passe substituiu os placeholders de caixa da Vila Elevada por instâncias orgânicas CC0 de pedra, limitou o número de casas-âncora para o orçamento GTX 1050, elevou o conjunto acima do TerrainPatch, adicionou fachos locais de ressonância âmbar/ciano e criou uma câmera de validação determinística no `Takes5to7Director.gd`. A câmera regional duplicada foi removida do modo de validação para evitar disputa de viewport.

## Evidência formal

| Evidência | Ficheiro |
| --- | --- |
| Gameplay de 30 segundos | `validation/region7-cycle-10/region7-gameplay-30s.mp4` |
| Print 1600×900 | `validation/region7-cycle-10/region7-print-1600x900.jpg` |
| Findings | `validation/region7-cycle-10/region7-cycle-findings.md` |
| Harness | `validation/run_region7_capture_cycle10.sh` |

O parser Godot passou e o F5 completou a gravação. O único aviso recorrente é a ausência de dispositivo ALSA no ambiente de captura, com fallback para áudio dummy. O print mostra a rota elevada em primeiro plano, a plataforma distante e a leitura coerente da montanha. A abordagem está aceite como baseline estável; a identificação da vila ainda será reforçada na próxima revelação em proximidade.

## Fronteira

Nenhum módulo, câmara, geometria ou ativo das Regiões 1–6 foi alterado. O passe Casa Voss → Ruínas Submersas continua reservado à `feature/dev1-gameplay-core`. A próxima subtarefa desta branch é a continuidade autorizada para a Região 8 / Observatório, mantendo a cadeia Vila Elevada → Observatório → Trilha da Montanha.
