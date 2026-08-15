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

### 🔄 Estado do Ciclo

- **STATUS_CODE**: `REJECTED_VISUAL`
- **NEXT_ACTION_IMMEDIATE**: Recuar e reposicionar a câmara de validação da Região 10 para uma vista lateral exterior; elevar o alvo para a abertura escura da Caverna do Orion e enquadrar os braseiros de ressonância; recompilar, executar F5 e submeter novo gameplay/print.
- **TARGET_REGION**: Região 10 — Caverna do Orion
- **DEADLINE_NEXT_PUSH**: `2026-08-15T16:42:33Z` (UTC)

## Refinamento imediato pós-ciclo

A releitura pós-commit confirmou novamente a recomendação da Direção: a câmara dedicada evita o prólogo, mas a composição continua a enquadrar uma massa de pedra em vez de revelar inequivocamente a boca da Caverna do Orion. O ciclo seguinte deve abandonar este ponto de vista e usar uma câmara exterior mais lateral, com o alvo na abertura escura e não nos marcadores posteriores. O estado permanece **não aceite visualmente**, apesar de parser, gameplay e print formais estarem presentes.

## Ciclo 2 — Resultado e transição de estado

A vista lateral exterior recuada removeu o landmark azul posterior e recuperou a silhueta alpina, mas ficou demasiado ampla: a boca da Caverna do Orion e os braseiros não aparecem como foco legível. O resultado do Ciclo 2 é rejeitado visualmente.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: `REJECTED_VISUAL`
- **NEXT_ACTION_IMMEDIATE**: Criar uma câmara dedicada no limiar da Região 10, mais próxima das coordenadas oficiais da boca, com deslocamento lateral suficiente para evitar clipping; manter os landmarks posteriores omitidos e enquadrar a abertura escura com pelo menos dois braseiros azuis no terço central.
- **TARGET_REGION**: Região 10 — Caverna do Orion
- **DEADLINE_NEXT_PUSH**: `2026-08-15T16:44:03Z` (UTC)

## Ciclo 3/4 — Resultado e transição de estado

A câmara ancorada no nó runtime e o novo limiar de rocha orgânica foram compilados e capturados. A cena continua a mostrar a trilha, as fendas emissivas e massas de referência, mas não apresenta uma abertura escura reconhecível nem dois braseiros enquadrados. O resultado permanece rejeitado visualmente; a evidência confirma execução, não aceitação.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: `REJECTED_VISUAL`
- **NEXT_ACTION_IMMEDIATE**: Criar uma tomada de limiar dedicada e determinística a partir da própria CavernaDoOrion, desativar temporariamente os marcadores de trilha dentro do campo de visão e iluminar a cavidade recuada com dois OmniLight3D azuis visíveis na abertura; repetir parser, F5, gameplay e print.
- **TARGET_REGION**: Região 10 — Caverna do Orion
- **DEADLINE_NEXT_PUSH**: `2026-08-15T16:47:46Z` (UTC)

## Ciclo 5 — Resultado e transição de estado

A supressão de `TransicaoRegiao09Para10` foi aplicada apenas ao modo de validação, mas o print ainda mostra massas de pedra, símbolos e a fenda emissiva sem uma boca de caverna inequívoca. O Ciclo 5 é rejeitado visualmente; o próximo ciclo deve tornar a tomada determinística e focal, com o arco orgânico no centro e sem elementos auxiliares de trilha.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: `REJECTED_VISUAL`
- **NEXT_ACTION_IMMEDIATE**: Criar uma tomada de limiar determinística que desative também as fendas/marcadores auxiliares durante a captura, posicione a câmara a poucos metros do arco orgânico e enquadre os dois OmniLight3D azuis dentro da abertura recuada; repetir parser, F5, gameplay e print.
- **TARGET_REGION**: Região 10 — Caverna do Orion
- **DEADLINE_NEXT_PUSH**: `2026-08-15T16:49:04Z` (UTC)

## Ciclo 6 — Resultado e transição de estado

A tomada de limiar aproximada e a ocultação dos marcadores auxiliares foram executadas, mas o frame continua a mostrar terreno, massas pétreas e símbolos sem a boca escura legível. O Ciclo 6 é `REJECTED_VISUAL`; a falha permanece de composição e não de parser ou captura.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: `REJECTED_VISUAL`
- **NEXT_ACTION_IMMEDIATE**: Forçar uma tomada de entrada determinística ancorada na geometria frontal da CavernaDoOrion, ocultar todos os símbolos/rock markers fora do arco, aumentar o contraste da cavidade e verificar por frame que a abertura e dois braseiros ocupam o centro visual.
- **TARGET_REGION**: Região 10 — Caverna do Orion
- **DEADLINE_NEXT_PUSH**: `2026-08-15T16:50:25Z` (UTC)

## Ciclo 7 — Resultado e transição de estado

A mudança para o eixo exterior positivo-Z não alterou a composição funcional: a captura continua a mostrar símbolos de rota e fenda emissiva, sem revelar a boca do Orion. O Ciclo 7 é `REJECTED_VISUAL`.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: `REJECTED_VISUAL`
- **NEXT_ACTION_IMMEDIATE**: Criar um proxy de entrada exclusivo para validação dentro do mesmo ramo activo da Região 10, com arco orgânico, cavidade recuada e dois OmniLight3D azuis; apontar a câmara directamente ao proxy e validar que os símbolos auxiliares ficam fora do campo.
- **TARGET_REGION**: Região 10 — Caverna do Orion
- **DEADLINE_NEXT_PUSH**: `2026-08-15T16:52:02Z` (UTC)
