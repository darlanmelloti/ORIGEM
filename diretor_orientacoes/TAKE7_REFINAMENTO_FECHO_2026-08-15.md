# ORIGEM — Fecho de Refinamento do Take 7

**Branch:** `feature/dev2-mountain-canyon`  
**Âmbito:** capítulos 11–22; este ciclo alterou exclusivamente a composição do santuário do Take 7.

## Correções executadas

A partir da evidência visual enviada pela direção, o passe refinou a abordagem do santuário, afastou a câmara dos maciços de entrada, reduziu o raio e a altura das colunas ciclópicas mais intrusivas, reposicionou a presença táctica de Kharu no eixo central e substituiu os braseiros tácticos de emissão branca por fontes ciano controladas. O Cubo de Orion permanece azul profundo, emissivo e legível, sem retornar ao bloco branco sobre-exposto.

O Take 5 e a zona ribeirinha não foram reabertos. O bloco do Take 6 também não foi alterado neste passe.

## Validação jogável

A validação foi executada em Godot 4.7.1 com o ambiente de captura compatível disponível no sandbox. O parser e o runtime não apresentaram erro de script; os avisos de áudio pertencem à ausência de dispositivo ALSA no ambiente de captura e não interrompem o jogo. Foi gravado um percurso de aproximadamente 30 segundos com movimento de câmara e extraído um print de 1600×900 a partir do percurso.

| Evidência | Ficheiro |
| --- | --- |
| Print final | `take7-refine-print-1600x900.jpg` |
| Gameplay final | `take7-refine-gameplay-30s.mp4` |
| Findings dos ciclos | `take7-refine-findings.md` |
| Harness reprodutível | `run_take7_refine_capture.sh` |

## Comparação e decisão

O Cubo de Orion está centrado e com emissão controlada; a praça e o anel de arena estão mais legíveis; Kharu mantém presença no eixo táctico; e os braseiros já não dominam a imagem com branco. O resultado é aceite como avanço funcional e visual do protótipo. Permanece como trabalho futuro um passe de arte com malhas CC0/PBR de maior detalhe, sem bloquear a progressão para o capítulo seguinte.
