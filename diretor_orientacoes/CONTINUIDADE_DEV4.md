# Continuidade — Dev4

- **Último checkpoint material:** `DEV4_ORION_MASTER_PRODUCTION_RELEASE_07` — pacote limpo aprovado, editor Godot 4.7.1 validado e Novo Jogo executado durante 30 segundos. SHA-256 do pacote auditado: `cea4935d07e7b52ba119309c498cdd2d7294fb483a08c19c7a7a64f108a85d8f`.
- **QA-STATE-01 concluída e validada:** entrada real Orion medida em runtime Xvfb durante 33 segundos, com captura 1600×900 no segundo 30. Elias transitou de `(-22.0, 0.76765, 8.0)` para `(0.0, 0.84990, 0.45)`; saúde `100` e stamina `100.0` foram preservadas.
- **Tarefa consecutiva materialmente iniciada:** `QA-STATE-02` — ida e volta Orion. O runner executável `tools/qa/run_player_state_roundtrip.gd` e o gatilho `ORIGEM_QA_STATE_ROUNDTRIP=1` já existem. O próximo ciclo executará a prova de retorno e comparará posição, rotação, saúde e stamina.
- **Escopo Dev4:** `tools/qa/`, `reports/`, estabilidade de input, orçamento GTX 1050 Ti, transições, integridade de pacote e documentos de evidência. Dev4 não altera geometria regional de Dev1/Dev2.
- **Critério de aceitação:** parser Godot sem erro crítico, pelo menos 30 segundos de runtime/captura, logs verificáveis e commit próprio.

## Regra operacional obrigatória

> **Commit, ZIP, print e relatório são marcos de auditoria, não paragens.** Dentro de uma activação, Dev4 executa a tarefa corrente e inicia materialmente apenas a primeira tarefa consecutiva. Ao terminar a activação, a tarefa seguinte é marcada `PRONTA PARA RETOMA`; nunca é alegada como execução persistente.

## Motivo objectivo de inactividade

- **Motivo actual:** nenhum bloqueio técnico.
- **Retoma seguinte:** executar `QA-STATE-02` pelo runtime normal, conservar a evidência e abrir apenas a primeira acção da auditoria pós-retorno.
- **Proibição:** não declarar release, QA ou CINE-PAIR concluído sem log, evidência, commit e tarefa seguinte material iniciada. A referência externa ao commit `06300ee` não é reconhecida na ponta canónica e não pode substituir evidência auditável.
