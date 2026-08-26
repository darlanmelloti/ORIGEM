# DEV8 — Contrato de Fidelidade Cartográfica

| Campo | Valor |
|---|---|
| `owner` | Dev8 |
| `branch` | `dev8/cartographic-fidelity` |
| `issue` | #393 |
| `status` | ACTIVE |
| `task_id` | `DEV8-CARTOGRAPHIC-DISCOVERY-STATE-HYPOTHESIS-002` |
| `scope` | Auditoria QA somente de leitura do estado narrativo de descoberta que afecta o marcador e o destino do mapa nas transições R1–R6. |

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

## Tarefa ativa — DEV8-CARTOGRAPHIC-DISCOVERY-STATE-HYPOTHESIS-002

1. Mapear, somente por leitura, os sinais narrativos já existentes que controlam `casa_visitada`, `estrada_revelada` e a descoberta subsequente do mapa.
2. Formular uma hipótese causal para a diferença entre teleporte técnico de rota e estado de descoberta, sem alterar `CartographicAnchors.gd`, UI, timeline ou Player.
3. Entregar a hipótese ao Dev1 com posição, rota, captura e caminho de estado. Não implementar mudança de produção.
4. Manter `production_mutations=0` e exactamente esta tarefa ACTIVE.
