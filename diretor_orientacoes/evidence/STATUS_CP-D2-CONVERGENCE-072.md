# ORIGEM — CP-D2-CONVERGENCE-072

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| Região actual | R7–R9 — Vila Elevada, Observatório e Trilha da Montanha |
| STATUS_CODE | `REJECTED_VISUAL` |
| Validação técnica | Godot `4.7.1.stable.official.a13da4feb`; parser/headless limpo; gameplay 30.000 s; print 1600×900 |
| Correcção executada | Remoção do overlay QA persistente da `main.tscn`; carregamento fica runtime-gated em `scripts/main.gd` |
| Resultado visual | Rejeitado: enquadramento mostra sobretudo terreno, horizonte vazio e elementos flutuantes; R7–R9 não são legíveis como cadeia cartográfica |
| Próxima acção imediata | CP-D2-CONVERGENCE-073 — corrigir a câmara da rota R7→R9, remover/aterrar artefactos flutuantes e garantir uma composição com Vila/Observatório/Trilha visíveis |
| Luzes | Inventário não expandido; teto máximo Dev2 de 16 preservado |
| Fronteira | R1–R6 permanecem read-only |

O harness QA passou tecnicamente depois da remoção do overlay persistente. A verificação `MAP_MIRROR_VALIDATION=1` foi separadamente rejeitada pelo próprio harness porque os asserts existentes estão hard-coded para a cadeia R9→R12, não para a rota R7→R9 seleccionada; por isso a captura visual foi executada com o overlay desligado e essa limitação ficou registada, sem mascarar o resultado.

A evidência não é aceite como `PASSED`. O CP073 já está aberto: a próxima alteração deve ser concreta na orientação da câmara e no grounding dos sujeitos R7–R9, seguida de nova captura de 30 segundos e print 1600×900.
