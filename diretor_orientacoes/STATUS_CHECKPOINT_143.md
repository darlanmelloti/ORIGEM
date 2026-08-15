# ORIGEM — Checkpoint 143: Validação Integrada das Regiões 1–6

**Branch:** `feature/dev1-gameplay-core`
**Escopo:** Regiões 1–6 apenas.
**Estado:** validado localmente; roteiro de QA e registo prontos para commit e sincronização futura.

## Incremento contínuo

Foi criado o roteiro `test_checkpoint143_regions1to6_continuity.sh` para consolidar, numa única operação reprodutível, as verificações obrigatórias da fundação da experiência. O roteiro valida o projeto em modo headless e executa duas janelas independentes de gameplay real: a primeira cobre prólogo, porta `[E]` e exterior; a segunda parte do Acampamento Majestic e termina na margem das Ruínas Submersas.

| Etapa | Evidência | Resultado |
|---|---|---|
| Validação técnica | Godot 4.7.1 headless | Aprovado, sem `Parse Error`. |
| Fundação do jogo | Prólogo, porta e exterior | 30 segundos concluídos. |
| Corredor regional | Acampamento Majestic → lago | 30 segundos concluídos. |
| Artefactos | Duas capturas PNG 1600×900 | Confirmadas pelo roteiro. |

## Roteiro e artefactos

| Ficheiro | Finalidade |
|---|---|
| `test_checkpoint143_regions1to6_continuity.sh` | Validação integrada reprodutível. |
| `checkpoint143_regions1to6_continuity.log` | Registo do último ciclo aprovado. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência do prólogo e exterior. |
| `origem_v2_phase126_majestic_to_lake_30s.png` | Evidência da travessia física até ao lago. |

> Esta automação reforça a regra operacional: cada incremento continua a exigir prova técnica e gameplay real, mas a evidência nunca interrompe o desenvolvimento das Regiões 1–6.
