# ORIGEM — Região 9 → Região 10 — Ciclo 1

## Escopo

Este ciclo atua exclusivamente na `feature/dev2-mountain-canyon`, nas Regiões 9–10 do mapa oficial. Nenhuma geometria ou gameplay das Regiões 1–6 foi alterada. A directiva mais recente em `diretor_orientacoes/assets/take57-visual-findings.md` foi lida antes da implementação; ela confirma que a validação precisa iniciar fora do prólogo e que câmaras dentro de geometria produzem frames pretos.

## Implementação

A entrada da Caverna do Orion recebeu uma transição física orgânica a partir da Trilha da Montanha, usando `stone_largeB.glb` para degraus, raízes pétreas e massas de enquadramento. Foram acrescentadas fendas de ressonância emissivas, marcadores de wayfinding azul-ciano, um olho orgânico de baixa emissão na boca da caverna e preenchimento OmniLight azul. O antigo plano/caixa preta da boca foi removido para evitar o bloqueio visual documentado nos ciclos anteriores.

Foi adicionada uma câmara de validação opt-in para `ORIGEM_VALIDATION_REGION=10`, com bypass do prólogo apenas neste modo. O fluxo normal de lançamento permanece inalterado. O parser Godot 4.7.1 passou sem `SCRIPT ERROR` ou `Parse Error`; a captura OpenGL utiliza llvmpipe e apresenta apenas os avisos esperados de ALSA/dummy audio e limitações SDFGI/SSR do modo Compatibility.

## Evidência

| Artefacto | Localização |
|---|---|
| Gameplay aproximadamente 30 s | `diretor_orientacoes/evidence/region9-to-10-cycle1/region9-to10-gameplay-30s.mp4` |
| Print 1600×900 | `diretor_orientacoes/evidence/region9-to-10-cycle1/region9-to10-print-1600x900.jpg` |
| Log Godot/F5 | `diretor_orientacoes/evidence/region9-to-10-cycle1/f5-region9-to10.log` |
| Log ffmpeg | `diretor_orientacoes/evidence/region9-to-10-cycle1/ffmpeg.log` |

## Avaliação visual

A cena renderiza e a transição está presente no mundo, mas este ciclo **não deve ser marcado como checkpoint visual final**: o enquadramento capturado ainda fica demasiado próximo/ocluído pelas massas de rocha escuras e não apresenta a boca da caverna com a clareza cinematográfica exigida. O próximo ciclo deve afastar a câmara para uma posição exterior inequívoca, elevar o alvo da boca e validar novamente antes de aceitar a composição.

## Continuidade

Após este registo, a branch continua automaticamente no próximo ciclo de refinamento da Região 10. As Regiões 1–6 e a `feature/dev1-gameplay-core` permanecem fora do escopo.

## Refinamento imediato pós-ciclo

A releitura pós-commit confirmou novamente a recomendação da Direção: a câmara dedicada evita o prólogo, mas a composição continua a enquadrar uma massa de pedra em vez de revelar inequivocamente a boca da Caverna do Orion. O ciclo seguinte deve abandonar este ponto de vista e usar uma câmara exterior mais lateral, com o alvo na abertura escura e não nos marcadores posteriores. O estado permanece **não aceite visualmente**, apesar de parser, gameplay e print formais estarem presentes.
