# CP-D2-067 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Afinar o pico final de draw calls e efeitos decorativos remotos da Cúpula Final.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após o empacotamento e sincronização desta evidência.

O CP-D2-067 deduplicou o bloco `ArcoOrganicoCupula`: as três massas da coroa são instanciadas uma vez, fora do ciclo dos oito pilares. A auditoria repetida manteve `meshes=84`, `omni_lights=30` e `static_bodies=15`; `CupulaFinal` permanece em 7 meshes e 2 OmniLights. Parser Godot 4.7.1, guard de escopo, autoridade `mapaorigem.webp`, contratos, gameplay de 30 segundos e print 1600×900 passaram. Os handoffs mantiveram Cube `171.12`, Soleira `170.38` e Hub `169.40`, com os três colliders presentes.

A segunda captura confirmou que a redução estrutural não basta para atingir o critério global de desempenho: o percurso registou 20–21 FPS no início, 19 FPS na janela intermédia e 17–18 FPS no trecho final, com draw calls entre 320–340.

**Evidência actual:** gameplay `d8c45a3873687df9dff394bdbcca7f2968318b2f0f98a8a7f87adc3382398c12`; print `e9bdbf0a701efa00ab23e12019c174f7812f20310438127d1f32882968ebd102`.

**NEXT_ACTION_IMMEDIATE:** investigar a fonte do pico final de draw calls fora da coroa — efeitos emissivos e luzes decorativas da aproximação/Cúpula — sem remover núcleo temporal, gateway, soleira, âncoras ou colliders. Repetir parser, gameplay 30s, print 1600×900, ZIP, SHA-256 e sincronização.
