# CP-AAA-08 — Decisão Condicionada do Perfil de Renderer

## Matriz de decisão

| Perfil | Evidência obtida | Vantagem | Risco/pendência | Estado |
|---|---|---|---|---|
| Compatibility/OpenGL3 | P05 FPS `144,00`, P95 `6,944 ms`, 1 luz; aviso FSR1 | Compatibilidade com o perfil actualmente utilizado | FSR1 incompatível com este renderer | Referência actual |
| Forward+/Vulkan | P05 FPS `144,00`, P95 `6,944 ms`, 1 luz; zero aviso FSR1 | Suporta FSR1 e remove o aviso | Ainda não validado na GTX 1050 Ti nem promovido | Candidato isolado |

## Decisão

A evidência isolada favorece tecnicamente **Forward+/Vulkan** quando FSR1 é requisito visual, pois o ensaio concluiu com `FORWARD_PLUS_EXIT=0`, `PARSER_ERRORS=0` e `FSR_WARNING_COUNT=0`. Contudo, não existe autorização para alterar `project.godot` ou o perfil de produção. O Compatibility/OpenGL3 permanece como referência operacional até que Dev4/owners confirmem o hardware-alvo e aprovem a mudança.

A produção permanece intacta, a promoção automática está desactivada e o rollback continua disponível. O estado correcto é **AAA_CONDITIONAL / FORWARD_PLUS_PREFERRED_ISOLATED / PRODUCTION_PROFILE_UNCHANGED / HARDWARE_APPROVAL_PENDING**.

**STATUS_CODE: CP-AAA-08 / RENDERER_PROFILE_MATRIX_READY / OWNER_APPROVAL_REQUIRED.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-07_RELATORIO_FORWARD_PLUS_ISOLADO.md` — evidência Forward+ Vulkan isolada.

[2]: `diretor_orientacoes/CP-AAA-06_RELATORIO_DECISAO_RENDERER.md` — referência Compatibility/OpenGL3.
