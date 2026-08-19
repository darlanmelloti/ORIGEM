# CP-D5-047 — Matriz de contratos da apresentação de Elias

**Finalidade:** consolidar a fundação técnica já validada para Elias em terceira pessoa. Esta matriz permite revisão de integração sem alterar o controlador de produção, os módulos regionais ou a identidade do jogador.

## Matriz de contratos

| Domínio | Contrato actual | Evidência QA | Proprietário | Critério de aceitação para produção | Reversão obrigatória |
|---|---|---|---|---|---|
| Identidade | O jogador chama-se **Elias**; a apresentação é `EliasThirdPersonPresentation`. | CP-D5-041, CP-D5-046 | Dev5 prepara; Dev1 integra | Nomenclatura e UI preservam Elias | Qualquer referência operacional a outro nome |
| Câmara | Nos harnesses Dev5, `follow_camera.current=false` e a câmara QA externa domina a viewport. | CP-D5-045, CP-D5-046 | Dev5 | Uma câmara activa por cena de integração | Concorrência de câmaras, troca involuntária de viewport |
| Colisão QA | Elias utiliza cápsula QA de raio `0,55 m`, separada da implementação de `Player.gd`. | CP-D5-041, CP-D5-043 | Dev5 | Revisão Dev1 do colisor do jogador principal | Queda, penetração ou bloqueio de rota |
| Percurso R6 | Eixo `X=60`, baliza em `(52,260)`, folga de `6,05 m`. | CP-D5-042, CP-D5-043 | Dev1 para produção | 30 s Majestic→Ruínas sem bloqueio | Folga abaixo de `4,00 m` ou colisão com baliza |
| Percurso R5 | Eixo `X=-80`, pavilhão em `(-88,178)`, folga de `5,45 m`. | CP-D5-043 | Dev1 para produção | 30 s Floresta→Majestic→Margem | Bloqueio, queda ou colisão com pavilhão |
| Grounding | O sistema preserva X/Z cartográfico e ajusta apenas Y por raycast. | CP-D5-022, CP-D5-023 | Dev5 | Colisor de produção identificado por Dev1 | Objeto suspenso ou desvio de X/Z |
| Iluminação | Os harnesses criam uma luz direccional; não acrescentam Omni/Spot lights. | CP-D5-040, CP-D5-046 | Dev5 | Orçamento integrado ≤16 luzes dinâmicas | Luzes novas sem orçamento ou regressão visual |
| Produção | Dev5 não altera `Player.gd`, R1–R6 ou R7–R12. | Auditorias de escopo | Dev1/Dev2 | Alteração só por frente proprietária | Qualquer alteração directa fora do escopo |

## Fluxo de integração autorizado

> Dev5 entrega **evidência e contrato**, mas não promove automaticamente candidatos ou a apresentação de Elias. Dev1 decide a integração real no controlador, no colisor e na câmara depois de validar o percurso regional com gameplay de pelo menos 30 segundos.

1. Dev1 escolhe uma única rota regional a integrar, R5 ou R6.
2. Dev1 mantém a coordenada X/Z canónica e adopta apenas o ajuste Y confirmado pelo raycast.
3. Dev1 valida a porta, o salto, a stamina, a colisão do jogador e 30 segundos de travessia física.
4. Dev5 repete a auditoria de câmara e regressão apenas se a apresentação em terceira pessoa for efectivamente chamada pela produção.

## Validação da matriz

A matriz foi reconciliada com as cenas `EliasCameraContractPreview`, `EliasR6ClearancePreview` e `EliasMajesticClearancePreview`, bem como com a telemetria e as capturas QA dos CP-D5-041 a CP-D5-046. Ela não introduz novo código em produção.

## Próxima tarefa automática

**CP-D5-048 — Preparação de checklist de integração Elias R5/R6.** Transformar os contratos desta matriz num checklist operacional curto para o Dev1, com testes obrigatórios, fontes de evidência e condições de reversão. A tarefa mantém-se documental enquanto Dev1 não solicitar integração.
