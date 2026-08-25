# PROTOCOLO 014 — CICLO CONTÍNUO DEV2 E REGIÕES

**Branch de integração:** `integration/r1-r6-sprint1`  
**Responsável pela esteira:** Dev1  
**Data:** 25 de agosto de 2026

## Princípio de operação

Uma alteração enviada para a branch de Dev2 ou para uma pull request dirigida à integração comum inicia automaticamente a workflow **ORIGEM Regional Continuous Gate**. O mesmo mecanismo cobre Dev3–Dev6 nas suas branches regionais.

> A esteira não altera conteúdo artístico nem cria commits de jogo por conta própria. Ela executa testes determinísticos, expõe regressões e impede que uma integração técnica seja tratada como aprovada sem parser, contrato e rota funcional.

## Gatilhos automáticos

| Evento | Ação da esteira |
|---|---|
| Push em `feature/dev2-r2-river-road` | Valida R2: parser, contratos, Estrada→Arco e ponte positiva |
| Push em `dev3` a `dev6` | Seleciona e valida apenas a região atribuída |
| Pull request para integração | Determina a branch de origem e executa a região correspondente |
| Push na integração comum | Executa R2–R6 para detectar regressões entre regiões |
| Execução manual | Permite escolher uma região ou toda a cadeia R2–R6 |

## Critérios automáticos de reprovação

A workflow falha se o diff tiver erros de formatação, o módulo contratual regional estiver ausente, o parser Godot falhar, os contratos R1–R6 forem invalidados, uma rota QA não iniciar ou o jogo emitir erro fatal, script ou shader durante a rota.

## Dever de cada dev

Antes de abrir pull request, o responsável deve executar localmente:

```bash
export GODOT_BIN="/caminho/para/Godot_v4.x"
tools/qa/run_regional_gate.sh R2 origin/integration/r1-r6-sprint1
```

A aprovação local não substitui o ciclo GitHub; ela reduz tempo de espera e evita enviar uma falha previsível. A integração de Dev1 só aceita entregas com workflow verde e checkpoint regional atualizado.

## Estado de Dev2

A entrega atual de Dev2 já está integrada na branch comum: Estrada do Rio, fluxo de água e reflexo Orion foram validados e a correção de shader Godot 4 foi aplicada. A branch legada de Dev2 permanece atrás da integração por 12 commits e sem alterações exclusivas; por isso, o próximo trabalho de R2 deve partir de `integration/r1-r6-sprint1` ou de uma nova branch atualizada a partir dela.
