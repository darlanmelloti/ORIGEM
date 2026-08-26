# Dev6 — Contrato de Trabalho Contínuo das Ruínas Submersas

> **Regra operacional:** uma porta R6 aprovada não encerra o Dev6. Cada entrega validada deve publicar, abrir ou atualizar uma única tarefa de continuidade e avançar o contrato para o próximo incremento seguro.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV6-R6-SHORE-HANDOFF-002
owner: Dev6
branch: dev6/r6-submerged-ruins
```

## Base oficial e recuperação da entrega declarada

A fonte de trabalho é o repositório oficial do ORIGEM na branch canónica `dev6/r6-submerged-ruins`, sincronizada com `integration/r1-r6-sprint1`. A entrega declarada no commit local `3a6f9c8` e na branch local `feature/dev6-r6-submerged-ruins` não existe no remoto GitHub, não pode ser reproduzida a partir do repositório e **não foi aprovada como entrega independente**.

A única feature Dev6 publicada, `feature/dev6-environment-art`, não partilha histórico com a integração atual, não contém o módulo R6 declarado e possui um construtor `_build_submerged_ruins()` byte-a-byte idêntico ao da integração. Nenhuma geometria desta feature deve ser transplantada em bloco. A recuperação segura é a correção incremental validada na branch canónica.

## Entrega validada — DEV6-R6-LIGHT-BUDGET-001

A Região 6 já possuía bacia, pilares, domo, cascata de filetes 3D, estela de chegada e rotas físicas. A auditoria runtime revelou **sete luzes filhas do lago mais duas luzes mundiais**, ultrapassando o limite contratual de quatro luzes R6. A entrega removeu a luz submersa lateral, as três balizas dos marcos emergentes e o brilho adicional da estela.

O conjunto final mantém quatro focos reais: dois preenchimentos mundiais da bacia, um preenchimento de margem e uma luz submersa central. A água, os pilares, o domo e a cascata permanecem geometria legível, sem compensação por emissão excessiva.

| Critério | Resultado validado |
|---|---|
| Orçamento R6 | 4 luzes: `world=2`, `lake_omni=2`, `lake_spot=0` |
| Rotas físicas | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` aprovadas |
| Contrato | Contrato R6 e parser Godot 4.7.1 aprovados |
| Recuperação | Nenhum commit/branch declarado inexistente foi tratado como aprovado |

## Tarefa ativa — DEV6-R6-SHORE-HANDOFF-002

Criar uma leitura física de chegada R6→R7 a partir da margem oposta: dois sinais arqueológicos assimétricos, uma continuidade clara no trilho de lajes e uma orientação narrativa para a Vila Elevada, sem construir a região R7 nem formar um portão, parede, painel ou corredor artificial. O trabalho deve ser modular em `levels/regions/r6/`, não adicionar `Light3D` e preservar cascata, domo, pilares e as três rotas R6.

| Limite | Obrigatório |
|---|---|
| Escopo | R6, QA R6, documentação, `ForestLakeRegion.gd` apenas para montagem mínima |
| Cartografia | Âncora R6 `(60, 252)`, entrada Majestic→margem e handoff físico para a futura R7 preservados |
| Água | Sem painel, emissão excessiva, novo shader pesado ou luz adicional |
| Luz | Exatamente quatro luzes R6; a sonda `inspect_r6_light_budget.gd` é obrigatória |
| QA | Parser, `tools/qa/run_regional_gate.sh R6`, orçamento R6 e as três rotas contratuais antes do PR |

## Fecho e sucessão obrigatória

Dev6 só conclui uma tarefa após commit publicado, porta R6 aprovada e substituição por um novo `task_id` em estado `ACTIVE`. A esteira mantém uma única issue `[Dev6 Continuous]` e encerra automaticamente qualquer item Dev6 obsoleto.
