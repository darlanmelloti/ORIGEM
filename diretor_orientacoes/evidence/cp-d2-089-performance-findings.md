# CP-D2-089 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12 concluídas; fila seguinte em Regiões 7–9
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Iniciar CP-D2-090 — passe visual controlado na Vila Elevada e Observatório, preservando os ganhos de R10–R12.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo checkpoint após evidência visual e pacote reproduzível.

A correcção CP-D2-089 ocultou apenas `LuzContactoArco_2.2` durante a rota QA `R10_CAVE_TO_R12_HUB_FULL`. A iluminação funcional da soleira, arco esquerdo, núcleo temporal, gateway e referências de navegação foi preservada.

A validação Godot 4.7.1 passou no parser/headless, gameplay de 30 segundos e print 1600×900. Os handoffs Cube `171.12`, Soleira `170.38` e Hub `169.40` mantiveram posições e colliders. O inventário permaneceu `meshes=76`, `omni_lights=27`, `static_bodies=15`; o trecho final estabilizou em 20–21 FPS com 304 draw calls, dentro do alvo operacional actual Dev2.

**Evidência CP-D2-089:** gameplay `79c5fe3177924d147781f2c4e69ec26cb17a024f49c66dbcc6b8b249e64e8ad1`; print `c52ce6d5d2e764d273ca8f1436c1b8f21108129319b1c0f7774d7506d92d7b77`.

**NEXT_ACTION_IMMEDIATE:** iniciar CP-D2-090 em R7→R9 com foco na leitura vertical da Vila Elevada, Observatório e início da Trilha da Montanha; não alterar `OrionDestinationRegion.gd` além do necessário para preservar o orçamento R10–R12.
