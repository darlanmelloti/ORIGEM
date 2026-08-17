# CP-D2-062 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Reduzir a carga de geometria decorativa e componentes emissivos distantes na vista integral do Hub/Cúpula, sem alterar silhueta próxima, âncoras ou rota física.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após a optimização estrutural e nova captura Godot 4.7.1.

O passe 4 manteve parser/headless, `REGIONS_7_12_ONLY`, `mapaorigem.webp`, `HANDOFF_CONTRACT`, `HANDOFF_ORDER`, `FULL_HANDOFF_CONTRACT`, gameplay de 30 segundos, print 1600×900 e os três colliders nomeados. A redução de luzes e visibilidade não recuperou o trecho final: a captura registou 17–18 FPS entre 30 e 35 segundos, com 320–340 draw calls. O critério de desempenho permanece rejeitado.

**Evidência:** gameplay `281a74deb73417ecd2ca8e0a5308fef9e3ae1ea92701b97847a9f971a9d942d6`; print `8df1ed62f6934e32ca40b88e10819bad9190dd267fab50fcda5a7e29e430e822`.

**NEXT_ACTION_IMMEDIATE:** executar um passe estrutural no Hub/Cúpula: reduzir instâncias decorativas remotas e consolidar componentes emissivos em pontos únicos, mantendo a leitura do núcleo temporal, a entrada da Cúpula e os marcos Cube/Soleira/Hub; repetir a validação completa antes de marcar PASSED.
