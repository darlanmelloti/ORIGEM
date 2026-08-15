# ORIGEM — Checkpoint 153: Continuidade Normal Casa Voss–Vale

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

## Auditoria concluída

O fluxo normal da Casa Voss foi executado novamente com o roteiro de 30 segundos. As capturas pós-prólogo e exterior confirmam que a saída frontal conduz Elias ao vale, à estrada de lajes e ao Arco das Ruínas. A auditoria não identificou nova grade, colisor residual ou bloqueio de passagem depois da ação `[E]`; por isso nenhuma alteração de gameplay foi aplicada neste checkpoint.

| Verificação | Evidência | Resultado |
|---|---|---|
| Interior pós-prólogo | Captura 1280×720 | Porta frontal e abertura de luz identificáveis. |
| Saída para o vale | Captura 1280×720 | Trilho e Arco das Ruínas alinhados em frente a Elias. |
| Roteiro normal | `test_checkpoint113_twilight_30s.sh` | Produziu estados pós-prólogo, exterior e estabilidade de 30 segundos. |
| Alterações técnicas | Auditoria de ficheiros | Nenhuma correção adicional necessária. |
| Fronteira operacional | Regiões 1–6 | Mantida integralmente. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase113_twilight_postprologue.png` | Evidência do interior após o prólogo. |
| `/home/ubuntu/origem_v2_phase113_twilight_exterior.png` | Evidência da saída para o vale. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de estabilidade do fluxo normal. |

> O checkpoint é uma evidência, não uma pausa. A continuidade automática permanece limitada às Regiões 1–6.
