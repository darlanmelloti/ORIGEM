# CP-D2-065 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Optimização do orçamento de iluminação e composição distante da Cúpula Final.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após a captura e sincronização deste passe.

O CP-D2-065 removeu um beacon decorativo distante da coroa final. O inventário passou de `meshes=121` para `meshes=121` e de `omni_lights=34` para `omni_lights=33`; `CupulaFinal` passou de 4 para 3 OmniLights. Parser Godot 4.7.1, guard `REGIONS_7_12_ONLY`, autoridade `mapaorigem.webp`, contratos físicos, gameplay de 30 segundos, print 1600×900 e os três handoffs continuam válidos.

A redução de luz foi mensurável no inventário, mas não resolveu o desempenho: o trecho final registou 17 FPS, com draw calls entre 320–340. O estado permanece rejeitado.

**Evidência:** gameplay `d3c335be51e025b3dbec99e18b4f920fcdcec587648f7cfc1b1571101f780a94`; print `09ae08e60c893b304e3ce0d2ccf5772a46942950558dbb19b25e800047411389`.

**NEXT_ACTION_IMMEDIATE:** executar um passe de visibilidade contextual para que a decoração remota da Cúpula e da aproximação deixe de ser instanciada durante a validação de travessia R10→R12, mantendo sempre a caverna, o Cube, a soleira, o núcleo temporal, gateway, âncoras e colliders; repetir a validação completa antes de novo estado.
