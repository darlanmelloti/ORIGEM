# STATUS — AMBIENTE E ORÇAMENTO DE LUZ 022

**Workflow:** `ORIGEM Regional Continuous Gate`  
**Data:** 25 de agosto de 2026  
**Coordenação:** Dev1

## Base visual preservada

O vale já dispõe de um controlador global consolidado: céu diurno, sol direcional, neblina leve, perfis Chronos e materiais de rio/vegetação. Não foram adicionadas luzes nem geometria redundantes nesta revisão.

A auditoria runtime confirmou a abertura em Casa Voss com **1 luz simultânea no frustum da câmara**, abaixo do limite técnico de 16. A luz ativa é o sol direcional de `LevelEnvironment`.

## Proteção contínua

A workflow agora executa o job **Orçamento global de luz** em cada atualização regional e antes do resultado agregado `ORIGEM Regional Gate`. Se a auditoria falhar, os seus logs são guardados como artefacto de CI durante 14 dias.

A primeira execução completa com a nova condição foi aprovada: orçamento global, R2, R3, R4, R5, R6 e o check agregado terminaram em sucesso.
