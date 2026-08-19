# DEV6-001 — Integração R2 Estrada do Rio Viva

## Resultado

A integração de produção do candidato Dev5 R2 foi concluída de forma reversível em `levels/RiverRoadJourney.gd`. O módulo acrescenta uma ponte modular lateral, dois cervos CC0 decorativos, duas árvores, dois fetos e dois vestígios de abrigo. Todos os novos elementos mantêm-se fora da faixa física de 4,15 m da estrada e não introduzem luzes dinâmicas.

| Critério | Estado | Evidência |
|---|---:|---|
| Escopo de código | PASS | Apenas `levels/RiverRoadJourney.gd` foi alterado |
| Parser Godot 4.7.1 | PASS | `parser_bridge_material=PASS` |
| Fauna e vegetação | PASS | 2 cervos, 4 elementos vegetais, 2 vestígios |
| Aterramento cartográfico | PASS | `grounding=9 expected=9 xz_preserved=true` |
| Orçamento de luzes do incremento | PASS | `dynamic_lights=0` |
| Rota `road_to_arch` | PASS | Sessão com entrada contínua durante 36 s, sem erro de parser ou asserção |
| Captura de gameplay | PASS | `qa_evidence_dev6_r2/road_to_arch_r2_midrun.png` |

## Reversão

A integração inteira está isolada na função `_build_dev6_r2_living_integration()` e funções auxiliares `Dev6`. Uma reversão limita-se a este bloco e às constantes Dev6 no mesmo ficheiro, sem apagar a evidência QA Dev5.

## Continuidade activa

Sem aguardar uma nova tarefa externa, o ciclo seguinte Dev6 é **DEV6-002 — auditoria de materiais e LOD R2**. Deve reduzir a leitura residual de protótipo na captura, preservando exactamente a rota, os X/Z e o contrato de nove aterramentos validado aqui.
