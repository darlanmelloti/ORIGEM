# CP-D5-022 — Aterramento cartográfico por raycast

**Escopo:** novos módulos QA em `levels/dev5/`; sem alterações a `TerrainPatch.gd`, `VossHouse.gd`, `RiverRoadJourney.gd` ou qualquer região de produção.

## Objectivo e resultado

O sistema `CartographicGroundingSystem.gd` recebe uma posição canónica de âncora, preserva integralmente X/Z e projecta um raycast vertical para ajustar apenas Y ao primeiro colisor de solo. A prova `CartographicGroundingPreview.tscn` usa terreno físico inclinado QA e aterra dois candidatos existentes: o anexo Casa Voss e a ponte do marco 2.

| Candidato | Âncora | Altura inicial | Impacto medido | X/Z preservado | Colisor |
|---|---:|---:|---:|---|---|
| Anexo Casa Voss | 1 | 15,00 m | -2,78 m | Sim | `TerrenoColisorQA` |
| Ponte Marco 2 | 2 | 18,00 m | -2,71 m | Sim | `TerrenoColisorQA` |

A execução passou o parser Godot 4.7.1, produziu captura interna e manteve uma sessão QA de 36 segundos. O término externo por timeout ocorre após a janela exigida de prova; não houve erro de parser ou de script no log.

## Decisão

**APROVADO como ferramenta QA de integração.** O sistema ainda não toca o terreno de produção, mas passa a ser obrigatório para qualquer candidato Dev5 que seja proposto ao proprietário Dev1. Antes de uma integração, o candidato deve demonstrar o contacto no terreno real do módulo proprietário.

## Próxima tarefa automática

CP-D5-023 cria um **catálogo de alturas e contratos de aterramento** para os seis marcos R1–R6, indicando o proprietário do terreno, o tipo de colisor esperado e o candidato Dev5 que pode usar a ferramenta sem duplicar a lógica regional.
