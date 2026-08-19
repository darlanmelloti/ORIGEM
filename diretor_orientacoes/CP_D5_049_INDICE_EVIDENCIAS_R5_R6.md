# CP-D5-049 — Índice cruzado de evidências R5/R6

**Objectivo:** permitir que Dev1 localize, numa só tabela, os candidatos Dev5, as cenas de prova, evidências, contratos e regras de reversão antes de qualquer integração regional.

## Índice de decisão

| Região / candidato | Estado Dev5 | Cena QA | Evidência local | Documento de contrato | Aceitação de produção por Dev1 | Reversão |
|---|---|---|---|---|---|---|
| R5 — Pavilhão Majestic | Aprovado técnico QA; não integrado | `MajesticGroundedPavilionPreview.tscn` | `/home/ubuntu/qa_evidence_dev5_majestic_grounding/majestic_grounding.png` | `CP_D5_029_ATERRAMENTO_PAVILHAO_MAJESTIC.md`, `CP_D5_032_MAJESTIC_ATERRAMENTO_QA.md` | 30 s Floresta→Majestic→Margem, raycast apenas em Y, rota e luzes intactas | Suspensão, desvio X/Z, bloqueio ou luz não orçamentada |
| R5 — Elias no corredor Majestic | Aprovado técnico QA; não integrado | `EliasMajesticClearancePreview.tscn` | `/home/ubuntu/qa_evidence_dev5_elias_majestic/elias_majestic.png` | `CP_D5_043_ELIAS_PAVILHAO_MAJESTIC.md`, `CP_D5_048_CHECKLIST_INTEGRACAO_ELIAS_R5_R6.md` | Elias atravessa sem bloqueio; folga real ≥4,00 m (QA: 5,45 m) | Queda, `test_move` bloqueado, conflito de câmara |
| R6 — Baliza monolítica | Aprovado técnico QA; não integrado | `SubmergedShoreMonolithPreview.tscn` | `/home/ubuntu/qa_evidence_dev5_r6_monolith/monolith_material.png` | `CP_D5_035_BALIZA_MONOLITICA_R6.md`, `CP_D5_040_FOLGA_PASSAGEM_R6.md` | 30 s Majestic→Ruínas; âncora `(52,260)` e folga real ≥4,00 m (QA: 6,05 m) | Colisão, objecto suspenso, desvio X/Z ou retorno a cais de lajes |
| R6 — Elias na margem | Aprovado técnico QA; não integrado | `EliasR6ClearancePreview.tscn` | `/home/ubuntu/qa_evidence_dev5_elias_r6/elias_r6.png` | `CP_D5_041_ELIAS_TERCEIRA_PESSOA_R6.md`, `CP_D5_046_AUDITORIA_CAMERAS_ELIAS.md` | Elias percorre a rota sem bloqueio e câmara externa exclusiva | Queda, bloqueio, câmara de Elias toma a viewport |
| R4/R5 — Vegetação média | Aprovado técnico QA; não integrada | `GroundedVegetationR4R5Preview.tscn` | `/home/ubuntu/qa_evidence_dev5_vegetation_grounding/vegetation_grounding_fixed.png` | `CP_D5_030_VEGETACAO_ATERRADA_R4_R5.md` | Corredor preservado, sem parede de árvores, LOD dentro dos limites | Densidade bloqueia percurso ou leitura do pavilhão |
| Global — grounding | Fundação validada | `CartographicGroundingPreview.tscn` | `/home/ubuntu/qa_evidence_dev5_grounding/grounding_postrebase.png` | `CP_D5_022_ATERRAMENTO_CARTOGRAFICO.md`, `CP_D5_023_CATALOGO_ALTURAS_ATERRAMENTO.md` | X/Z preservado; raycast ajusta somente Y no colisor regional correto | Sem hit, colisor impróprio ou alteração de X/Z |
| Global — câmara Elias | Fundação validada | `EliasCameraContractPreview.tscn` | `/home/ubuntu/qa_evidence_dev5_elias_camera/camera_contract.png` | `CP_D5_045_CONTRATO_CAMARA_ELIAS.md`, `CP_D5_047_MATRIZ_CONTRATOS_ELIAS.md` | Uma câmara activa; produção mantém controlo explícito | Concorrência de câmara ou troca de viewport |

## Ordem de decisão Dev1

1. Integrar no máximo **um** candidato de cada vez; nunca pavilhão e baliza na mesma alteração.
2. Aplicar o candidato somente na sua região proprietária, mantendo R7–R12 excluídas.
3. Executar parser Godot, 30 segundos de gameplay real e captura interna antes de manter a alteração.
4. Se a integração falhar, reverter apenas o candidato testado e registar a causa neste índice; não reutilizar a mesma hipótese rejeitada.

## Integridade do índice

A lista liga cinco cenas QA principais, sete directórios de evidência, contratos de grounding/câmara e os critérios de reversão. Os caminhos foram verificados localmente durante CP-D5-049; eles são evidências de sandbox e não substituem a aprovação visual regional de Dev1.

## Próxima tarefa automática

**CP-D5-050 — Plano de teste de regressão de integração R5/R6.** Preparar uma sequência de execução para Dev1, incluindo ordem de inicialização, rota, comportamentos de falha e artefactos obrigatórios. Não alterar produção.
