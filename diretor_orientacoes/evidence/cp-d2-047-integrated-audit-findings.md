# CP-D2-047 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Auditoria integrada de escopo, handoff físico, ordem espacial e runtime.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

O guard `REGIONS_7_12_ONLY` e autoridade `mapaorigem.webp` passaram. O contrato integrado confirmou `HANDOFF_CONTRACT=PASS`, `HANDOFF_ORDER=PASS` e `FULL_HANDOFF_CONTRACT=PASS`. A regressão fresca R10 Caverna → R11 Câmara → R12 Hub passou parser Godot 4.7.1, gameplay exactamente 30 segundos e print 1600×900. Os três colliders foram encontrados com `present=true`; os três marcadores mantiveram sequência 1/2/3 e posições oficiais. Os grupos de render mantiveram Caverna 18/3, Câmara 11/5, Hub 18/4 e Cúpula 45/7. Métricas: aproximadamente 19–22 FPS e 320–347 draw calls.

**Evidência:** gameplay `1dbafe528415bbf73987629e29767c8b04015558dde30b1a4b3dd70e0ecf397e`; print `d339020c06d6d886509fb5d9b35424e6f8880f03b56fc97c2e5f27767d240480`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-047 e iniciar o próximo passe de validação visual/runtime, preservando a construção orgânica e sem alterar Regiões 1–6.
