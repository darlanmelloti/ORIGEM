# ORIGEM — DEV6-R6-CONTINUITY-AUDIT-004

**Estado:** ACTIVE
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas
**Tarefa anterior:** DEV6-R6-WATERLINE-READING-003
**PR anterior:** #67 — merge concluído

## Objetivo ativo

Auditar a integração efetiva de WATERLINE-READING-003 na branch `integration/r1-r6-sprint1`, confirmando que a leitura arqueológica da linha de água permanece fora da elipse da bacia e fora do trilho jogável, sem regressão no handoff R6→R7.

## Matriz obrigatória

| Verificação | Critério de encerramento |
|---|---|
| Linha de água | Nove detritos assimétricos legíveis e fora do leito |
| Trilho R5→R6 | Sem bloqueio, lacuna ou colisão nova |
| Auditoria de luzes | Quatro luzes locais R6; nenhuma criada pela tarefa anterior |
| Porta R6 | Contratos e escopo regional aprovados |
| `forest_to_ruins` | Gameplay real sem queda, bloqueio ou erro fatal |
| `majestic_to_lake` | Gameplay real sem regressão na ligação |
| `ruins_arrival` | Porta R6, estela e ruínas legíveis |
| Handoff R6→R7 | Estrada e destino R7 preservados, sem geometria nova de R7 |

## Regra de continuidade

Não adicionar novos efeitos visuais, luzes, shaders, painéis, emissão, colisores ou geometria R7 antes de fechar esta auditoria. O próximo commit deve conter apenas evidência, correção causal R6 ou documentação diretamente relacionada a esta tarefa ACTIVE.

## Dependência ambiental

As provas runtime devem usar Godot 4.7.1 e renderer `gl_compatibility`. O sandbox local não possui o binário Godot; a validação autorizada deve ser lida dos checks do GitHub Actions ou executada no workspace Godot da equipa.
