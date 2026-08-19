# CP-D5-031 — Handoff de revisão Dev1 dos candidatos QA

## Finalidade

Este pacote organiza a revisão dos candidatos Dev5 sem promover qualquer activo automaticamente. A revisão Dev1 deve decidir apenas depois de consultar as evidências técnicas e, para R4/R6, obter uma captura gráfica válida fora do renderer headless.

| Candidato | Evidência técnica | Evidência visual | Decisão actual |
|---|---|---|---|
| Casa Voss aterrada, R1 | CP-D5-024: raycast, contacto e X/Z | QA interno | Candidato para revisão |
| Ponte Marco 2, R2 | CP-D5-024: raycast, contacto e X/Z | QA interno | Candidato para revisão |
| Portal Floresta, R4 | CP-D5-011/016/025/026/028: runtime e escopo | Captura gráfica pendente | Não promover |
| Vegetação média, R4/R5 | CP-D5-018/019: métricas e limites LOD | QA técnico | Candidato para revisão |
| Pavilhão Majestic, R5 | Catálogo e preview QA | QA técnico | Candidato para revisão |
| Ruínas Submersas, R6 | CP-D5-012/017/025/026/028: runtime e escopo | Captura gráfica pendente | Não promover |

## Checklist de revisão

A revisão deve confirmar a âncora cartográfica, o X/Z canónico, o offset local, o aterramento Y, a presença e limite dos colisores, a ausência de luzes dinâmicas do objecto, o orçamento geométrico, a licença dos activos e a ausência de dependências de `ForestLakeRegion.gd`, `TempleLevel.gd` ou `Player.gd`.

Para R4 e R6, a decisão visual exige um viewport Godot 4.7.1 Compatibility com captura interna válida. O modo headless já confirmou parser e sessão, mas não substitui a imagem: `snapshot_unavailable=headless_image` mantém a decisão como pendente.

## Resultado esperado

Cada candidato deve receber uma decisão explícita: **aceitar como candidato de integração**, **rejeitar com motivo visual/técnico** ou **manter pendente**. Nenhuma decisão deste pacote altera módulos de produção ou integra automaticamente os activos.

## Artefactos

Consultar `CONTINUIDADE_DEV5.md`, `CP_D5_030_FICHA_INTEGRACAO_QA.md`, `CP_D5_025_AVALIACAO_CAPTURA_QA.md`, `CP_D5_028_AUDITORIA_BACKEND_CAPTURA.md` e os logs de runtime correspondentes.

## Próxima acção

Abrir o CP-D5-032 para a próxima auditoria/ficha não concorrente, mantendo R4/R6 pendentes de captura gráfica válida.
