# DEV4_ORION_MASTER_PRODUCTION_RELEASE_07

## Estado de publicação

**VALIDADA LOCALMENTE; publicação pendente deste checkpoint.** A referência externa ao commit `06300ee` não existe em nenhuma referência Git local ou remota disponível; por isso não foi usada como prova de conclusão. A release foi executada e medida no checkout canónico sincronizado na ponta `776bbc0`.

## Verificação de pacote

A verificação `QA-PACKAGE-01` reconstruiu o pacote a partir do checkout, extraiu-o limpo, validou-o pelo editor Godot 4.7.1 e abriu **Novo Jogo** durante 30 segundos. O pacote resultante recebeu SHA-256 `cea4935d07e7b52ba119309c498cdd2d7294fb483a08c19c7a7a64f108a85d8f`.

| Prova | Resultado |
|---|---|
| Parser Godot no pacote extraído | Aprovado |
| Novo Jogo no pacote extraído | Aprovado após 30 s |
| Captura da release | Gerada pelo `verify_clean_package.sh` |
| Erros de script críticos no log | Ausentes |

## QA-STATE-01 — Entrada Orion

A sonda foi deslocada para o runtime gráfico normal porque a execução isolada por `--script` não carrega os autoloads de `EventBus` e `OrionTransitionState`. O harness Xvfb iniciou a cena principal, executou a entrada real Orion no segundo 15 e recolheu a imagem 1600×900 no segundo 30.

| Métrica | Antes da entrada | Depois da entrada |
|---|---:|---:|
| Posição | `(-22.0, 0.76765, 8.0)` | `(0.0, 0.84990, 0.45)` |
| Rotação Y | `0.0` | `2.83226` |
| Saúde | `100` | `100` |
| Stamina | `100.0` | `100.0` |

A imagem ao segundo 30 confirma o interior Orion carregado. A transição preservou a saúde e a stamina de Elias e alterou correctamente posição e orientação para o spawn interior.

## Próxima tarefa já materializada

> **QA-STATE-02 — auditoria de ida e volta Orion.** O runner `tools/qa/run_player_state_roundtrip.gd` e o gatilho de runtime `ORIGEM_QA_STATE_ROUNDTRIP=1` já foram criados nesta activação. A tarefa seguinte não foi apenas registada: o código executável para medir o estado antes da entrada, no interior e depois do retorno já está no repositório de trabalho.

A execução de QA-STATE-02 fica **PRONTA PARA RETOMA**; não há alegação de execução persistente após a entrega.
