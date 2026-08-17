# CP-D2-025 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 11–12
- **STATUS_CODE**: PASSED_WITH_PERFORMANCE_FOLLOWUP
- **TAREFA_EM_EXECUCAO_AGORA**: Validação contínua da navegação Cube → soleira → Hub Temporal.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

O percurso integrado voltou a passar no parser/headless Godot 4.7.1, com gameplay de 30 segundos e print 1600×900. O log registou aproximadamente 18–22 FPS e 320–347 draw calls no harness de validação. Não foram encontrados erros de runtime que interrompessem o percurso; os avisos de abertura de ficheiros pertencem à instrumentação auxiliar de captura e não provocaram falha do QA. O resultado visual permanece legível, mas o orçamento para GTX 1050 exige um passe posterior de redução controlada de custo, sem remover os marcos físicos ou alterar as Regiões 1–6.

**Evidência:** gameplay `4fb504d1abf1bd0559eb0c42a5b1bc3e2118a12426716a7864f8f2763bec77e3`; print `13da55dd6bcd7cca2343b2fc04f2d2d18e474e128760972eaff9d1332f6f6f97`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-025 e iniciar a redução controlada de custo apenas nas fontes/materiais das Regiões 10–12, repetindo o ciclo de 30 segundos e 1600×900.
