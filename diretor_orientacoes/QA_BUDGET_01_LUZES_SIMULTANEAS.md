# QA-BUDGET-01 — Orçamento de Luzes Simultâneas

## Resultado

A auditoria foi corrigida para separar o inventário global de luzes carregadas da métrica útil para a GTX 1050 Ti: as luzes dinâmicas que podem afectar simultaneamente a câmara activa.

| Medição | Resultado | Limite | Estado |
|---|---:|---:|---|
| Luzes visíveis no mundo carregado | 77 | Não aplicável como orçamento simultâneo | Inventário de diagnóstico |
| Luzes simultâneas no frustum da câmara de prólogo | 1 | 16 | `PASS` |
| Parser Godot 4.7.1 após preflight | Sem erros | 0 erros | `PASS` |
| Novo Jogo no modo GL Compatibility | 36 segundos sem erro de script ou crash | ≥30 segundos | `PASS` |

A luz simultânea identificada foi a luz direccional solar no enquadramento da Casa Voss. O inventário de 77 luzes explica por que a contagem global anterior foi rejeitada: ela inclui regiões e emissores fora do frustum e não mede pressão simultânea no renderizador.

> Esta prova aceita exclusivamente o orçamento técnico do enquadramento de abertura. Não substitui futuras medições no Arco, Floresta, Majestic, Ruínas ou corredor Orion; cada uma requer a própria câmara activa e sessão de gameplay.

## Artefactos

- Sonda de runtime: `tools/qa/audit_light_budget_runtime.gd` e `tools/qa/audit_light_budget_runtime.tscn`.
- Executor com preflight: `tools/qa/run_light_budget_audit.sh`.
- Prova de 36 segundos: `tools/qa/run_light_budget_gameplay_36s.sh` e `/home/ubuntu/qa_evidence_dev4_budget/qa_budget_gameplay_36s.log`.
