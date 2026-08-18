# CP-CARTO-28 — Restauração e Validação da Rota Única Floresta→Margem→Ruínas

**Branch:** `feature/cine07-final`  
**Escopo respeitado:** exclusivamente Regiões 1–6. A Região 7 não foi modificada.  
**Data:** 18 de agosto de 2026

## Alteração restaurada

A reinicialização do sandbox tinha removido uma alteração local ainda não publicada. O ficheiro `levels/ForestLakeRegion.gd` voltou a separar fisicamente as duas fases da rota: o **Trilho da Floresta Densa** termina em `z = RUINAS_SUBMERSAS.y - 107.0`, com 12 lajes, e o **Trilho até à Margem do Lago** inicia-se nesse mesmo limiar. Cada uma das 30 lajes de margem recebe agora um `StaticBody3D` próprio com `BoxShape3D(1.72, 0.18, 3.05)`.

Esta separação elimina a sobreposição de dois trilhos no mesmo espaço e mantém um corredor de colisão contínuo até aos degraus de chegada das Ruínas Submersas.

| Verificação | Resultado | Evidência |
| --- | --- | --- |
| Validação Godot 4.7.1 headless | **Aprovada** | `/home/ubuntu/qa_evidence_voss_vista/cp_carto28_headless.log` |
| Sessão real OpenGL3 com harness QA | **Aprovada** | 35 segundos; `timeout` esperado após a janela de teste |
| Erros de script, parse, crash ou falha de carregamento | **Nenhum detectado** | `/home/ubuntu/qa_evidence_voss_vista/cp_carto28_gameplay_35s.log` |
| Integridade de diff | **Aprovada** | `git diff --check` sem saída |
| Fronteira regional R7–R12 | **Preservada** | apenas `ForestLakeRegion.gd` e documentação R6→R7 foram alterados |

## Continuidade automática

A restauração do CP-CARTO-28 é aceite tecnicamente. A próxima integração física R6→R7 continua dependente da publicação do **CP-D2-214** pelo Dev2. Enquanto essa entrega não chega, o ciclo Dev1 continua dentro das Regiões 1–6 com validações reais, sem alterar módulos da Região 7.

> A passagem deste checkpoint não encerra a fila. A primeira lacuna independente seguinte deve ser seleccionada dentro do corredor R1–R6, respeitando a matriz cartográfica e o orçamento de 16 luzes dinâmicas visíveis.
