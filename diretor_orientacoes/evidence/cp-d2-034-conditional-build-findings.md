# CP-D2-034 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 11–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Construção condicional do Hub/Cúpula para validação segmentada da Câmara R11.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

A `OrionDestinationRegion` agora consulta `ORIGEM_VALIDATION_REGION`: quando o alvo é R11, constrói Caverna, Câmara e aproximação, mas não instancia o Hub Temporal nem a Cúpula Final; quando o alvo é R12 ou a rota completa, mantém a construção integral. O resultado é mensurável:

| Validação | Meshes | OmniLights | StaticBody3D | FPS observado | Draw calls |
|---|---:|---:|---:|---:|---:|
| Câmara R11 segmentada | 59 | 25 | 5 | 32–34 | 76–107 |
| R12 completo | 129 | 40 | 15 | 18–22 | 320–347 |

Ambas as execuções passaram o parser/runtime Godot 4.7.1, gameplay de 30 segundos e print de 1600×900. O passe resolve o carregamento excessivo durante QA segmentado sem degradar a rota completa R12.

**Evidência R11:** gameplay `8972b96d8aa30e95b167c97bc8e0faa88f5136f2ceca5181c3428aaa44cddf7e`; print `634418dd0356adbe24790dbc70e3fd927393cdf131cef2fee3051b8dd8955619`.

**Evidência R12:** gameplay `e20454c1d42f9eaa80094af44495063a84c929d66a880f903caf1297f9d1cb42`; print `211d492f6795bdd15cb422ad6aad8a4b74c0d42f8bfbd3009a20dab182ade077`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-034, iniciar o passe integrado final R11 → R12 com a construção completa e manter a segmentação apenas para QA diagnóstico.
