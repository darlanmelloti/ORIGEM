# CP-D2-067 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Continuar a optimização de draw calls da cadeia R10→R12 sem degradar a leitura monumental da Cúpula.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após o empacotamento e sincronização deste passe.

O CP-D2-067 corrigiu a duplicação do bloco `ArcoOrganicoCupula`: as três massas da coroa são agora instanciadas uma vez, fora do ciclo dos oito pilares. O inventário caiu para `meshes=84`, `omni_lights=30`, `static_bodies=15`; `CupulaFinal` ficou em 7 meshes e 2 OmniLights. Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os três handoffs mantiveram as posições Cube `171.12`, Soleira `170.38` e Hub `169.40`.

A redução estrutural é significativa, mas o critério global ainda não passa: o percurso registou 20–21 FPS no início e 18 FPS no trecho final, com draw calls entre 320–340.

**Evidência:** gameplay `168f594786d5288d4d88d779fa8e34038dbe2a396f4de6bed2b54cc7d158ab61`; print `d9855ccf971afba9a5435477554490e7b737ceeab9059371387a180eda7f1fa1`.

**NEXT_ACTION_IMMEDIATE:** auditar o pico final de draw calls na travessia, reduzindo apenas efeitos emissivos e luzes decorativas remotas ainda activas; preservar o núcleo temporal, a caverna, o Cube, gateway, soleira, âncoras e colliders. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
