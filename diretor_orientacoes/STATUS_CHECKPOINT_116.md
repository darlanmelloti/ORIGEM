# ORIGEM — Ponto de Situação Técnico

**Branch:** `feature/dev1-gameplay-core`
**Marco atual:** Checkpoint 116 — Consolidação do Trilho Florestal
**Fronteira aplicável:** apenas Takes 1–5
**Estado:** validado localmente; pronto para sincronização.

## Alteração consolidada

O ciclo restringiu-se à transição periférica entre Casa Voss, Arco das Ruínas, Floresta Densa e corredor ribeirinho. Foram introduzidas cinco balizas de pedra com brasa de baixa intensidade, alternadas nas margens do trilho entre `z=122` e `z=148`. O objetivo é recuperar a leitura direcional do percurso no crepúsculo sem iluminar toda a floresta nem adicionar sinalização moderna.

A composição do Take 3 passou a observar a transição efetiva da Floresta Densa, com a câmara em `(-5.0, 4.6, 96.0)`, alvo em `(-4.0, 1.5, 132.0)` e FOV de `45°`. O enquadramento mostra lajes, coníferas, balizas quentes e os marcos azuis de margem como uma cadeia visual até ao setor do lago.

| Verificação | Resultado | Evidência |
|---|---|---|
| Validação Godot headless | Aprovado | Editor Godot 4.7.1 carregou sem erro de GDScript. |
| Captura física Take 3 | Aprovado | `origem_v2_phase116_take3_forest_wayfinding.png`. |
| Gameplay de 30 segundos | Aprovado | `origem_v2_phase113_twilight_stable_30s.png`, sem `Parse Error` nem falha de carregamento. |
| Limite de âmbito | Aprovado | Não houve alteração de Take 6, Take 7, canyon, caverna profunda, arena ou Cubo de Orion. |

## Artefactos

| Artefacto | Finalidade |
|---|---|
| `ORIGEM_V2_RegionalWorld_Phase116_ForestWayfinding_Validated.zip` | Checkpoint recuperável do passe de consolidação. |
| `ORIGEM_V2_RegionalWorld_Phase116_ForestWayfinding_Validated.sha256` | SHA-256 `ee1a31d4dd2fc36f3b3d66c82e6f7ffb04d175bdcb2b9da59e470e062d99c393`. |
| `takes1to5_peripheral_audit.txt` | Auditoria da prioridade e do limite operacional. |
| `FRONTEIRA_OPERATIVA_TAKES_ORIGEM.md` | Contrato formal de divisão entre as branches dev1 e dev2. |

> O Take 5 permanece encerrado para expansão de escopo. A frente principal pode apenas corrigir regressões verificadas nos Takes 1–5; os Takes 6–7 pertencem exclusivamente à branch `feature/dev2-mountain-canyon`.
