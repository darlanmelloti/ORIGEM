# CP-D2-R6R7-001 — Continuidade física R6 → R7

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: R6→R7 — Ruínas Submersas → Vila Elevada
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Preparar a integração física do corredor no mundo jogável sem tocar na propriedade Dev1 de R6
- **NEXT_ACTION_IMMEDIATE**: Integrar/verificar colliders e travessia real do handoff R6→R7, consumindo `CartographicAnchors.continuity_6_to_7()`
- **TARGET_REGION**: R6→R7
- **DEADLINE_PROXIMO_PUSH**: 2026-08-20T15:32:30+01:00

A validação headless em Godot 4.7.1 passou com 41 amostras lineares, distância percorrida de 128.062 unidades, grounding exacto em `y=0.15`, desvio lateral máximo permitido de 8.0 unidades e verificação de origem/destino contra `CartographicAnchors.gd`. O ownership guard passou: R6 continua read-only do Dev1 e R7 pertence ao Dev2.

As coordenadas mundiais usadas no capturador são `R6 Vector3(60.0, 0.15, 252.0)` e `R7 Vector3(140.0, 0.15, 352.0)`. As coordenadas no mapa `mapaorigem.webp` são R6 `(408.0, 351.0)` e R7 `(542.0, 235.0)`. A direcção normalizada do corredor é aproximadamente `(0.624695, 0.0, 0.780869)`.

A evidência visual foi capturada em 1600×900, com gameplay de 30.000000 segundos. O corredor dourado QA-only liga os dois marcos e ambos os rótulos são legíveis. A sobreposição permanece temporária e não substitui a geometria de produção.

### 🔄 Estado do Ciclo

- **STATUS_CODE**: PASSED
- **NEXT_ACTION_IMMEDIATE**: Integrar e validar a travessia física real R6→R7, mantendo R6 read-only.
- **TARGET_REGION**: R6→R7
- **DEADLINE_NEXT_PUSH**: 2026-08-20T15:32:30+01:00
