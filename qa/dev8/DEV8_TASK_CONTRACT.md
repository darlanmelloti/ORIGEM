# DEV8 — Contrato de Fidelidade Cartográfica

| Campo | Valor |
|---|---|
| `owner` | Dev8 |
| `branch` | `dev8/cartographic-fidelity` |
| `issue` | #393 |
| `status` | ACTIVE |
| `task_id` | `DEV8-CARTOGRAPHIC-DISCOVERY-EVIDENCE-REVIEW-004` |
| `scope` | Revisão QA somente de leitura da evidência da descoberta narrativa que afecta o marcador e o destino do mapa nas transições R1–R6. |

## Invariantes

- `levels/CartographicAnchors.gd` é a autoridade espacial e é **somente de leitura** para Dev8.
- `ui/menus/CartographicMapUI.gd` é **somente de leitura** para Dev8.
- Não modificar quaisquer rotas, âncoras, player, câmara, FOV, geometria, colisores, luzes, água, materiais, partículas, ambiente ou módulos regionais.
- É proibido criar sinalização artificial no mundo, painéis, fundos falsos, paredes de vegetação ou efeitos para disfarçar diferença entre mapa e terreno.
- A captura deve vir de uma rota QA reconhecida e da cena de jogo, em 1600×900 por Xvfb/OpenGL.

## Entrega 001

1. Construir uma matriz somente de leitura para âncoras 1–6, contendo `X/Z`, posição correspondente no mapa, destino cartográfico e rota associada.
2. Capturar a UI do mapa em cada rota canónica sem alterar o estado do jogo fora do ambiente QA.
3. Registrar se o marcador de Elias e o destino seguinte correspondem ao momento espacial real.
4. Medir saltos de marcador ou alteração de destino apenas como observação; nenhum resultado é autorização para alterar a função de conversão.
5. Executar parser, `git diff --check`, prova Dev8, rotas aplicáveis, orçamento e CI cumulativa antes de publicação.

## Critério de conclusão

A tarefa será `CONCLUIDA` somente se as capturas e a telemetria estiverem versionadas, a revisão declarar explicitamente `production_mutations=0` e uma única sucessora `ACTIVE` for criada. Uma anomalia deve ser entregue como hipótese delimitada ao proprietário Dev1 ou regional correspondente; Dev8 não a implementa.

## Baseline 001 — concluída

- A prova de seis âncoras passou: `[ORIGEM_DEV8_CARTOGRAPHIC_BASELINE_OK] anchors=6 production_mutations=0 canvas=800x600`.
- As seis rotas canónicas foram capturadas pela cena de jogo com Xvfb/OpenGL em 1600×900 e estão indexadas em `reports/dev8/cartographic_fidelity_baseline_001/CAPTURE_MATRIX_001.md`.
- Parser Godot e porta cumulativa R2 passaram; a entrega não modifica produção.
- A expectativa da Estrada do Rio permanece destino 2. A autoridade devolve 2 em `z=12`; a alegação de destino 3 foi rejeitada por execução real.

## Tarefa concluída — DEV8-CARTOGRAPHIC-DISCOVERY-STATE-HYPOTHESIS-002

1. Os sinais narrativos foram mapeados somente por leitura e a captura controlada Casa Voss→Estrada confirmou a atualização de `estrada_revelada` após `voss_door_opened`.
2. A hipótese H-DEV8-002 foi confirmada: o teleporte técnico não substitui a descoberta persistente e não evidencia defeito cartográfico.
3. A evidência está em `reports/dev8/cartographic_discovery_controlled_capture_003/`, com `production_mutations=0`.

## Tarefa ativa — DEV8-CARTOGRAPHIC-DISCOVERY-EVIDENCE-REVIEW-004

1. Rever e indexar a evidência controlada para o handoff Dev1, sem criar nova captura, runner, timeline ou mudança de produção.
2. Confirmar que qualquer futura captura R2 use a porta Casa Voss ou um estado de timeline QA explicitamente autorizado e restaurável.
3. Manter `production_mutations=0` e exactamente esta tarefa ACTIVE.
