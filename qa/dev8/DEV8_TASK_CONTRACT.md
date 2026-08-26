# DEV8 — Contrato de Fidelidade Cartográfica

| Campo | Valor |
|---|---|
| `owner` | Dev8 |
| `branch` | `dev8/cartographic-fidelity` |
| `issue` | #393 |
| `status` | ACTIVE |
| `task_id` | `DEV8-CARTOGRAPHIC-FIDELITY-BASELINE-001` |
| `scope` | Auditoria QA da correspondência mundo→mapa e da legibilidade espacial das transições R1–R6. |

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
