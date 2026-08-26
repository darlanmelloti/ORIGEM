# ORIGEM — Notas de Campo Dev7

**Task ID:** `DEV7-VISUAL-PLAYABLE-PHYSICS-BASELINE-001`
**Branch:** `dev7/visual-playable-physics`
**Base de integração:** `origin/integration/r1-r6-sprint1`
**Estado:** Evidência runtime em recolha.

## Achados iniciais

A primeira execução de `voss_to_road`, com doze segundos de estabilização após o marcador de spawn, registou ainda o ecrã de arranque Godot. Essa imagem foi descartada como evidência visual. A execução repetida com sessenta segundos produziu uma imagem runtime 1600×900 válida, sem cartela de arranque.

| Rota | Frame | Objetivo espacial | Intrusões/superfícies | Solo e escala | Luzes visíveis | Estado |
|---|---:|---|---|---|---|---|
| `voss_to_road` | `voss_to_road_postload.png` | O trilho de pedra conduz claramente ao arco distante; a continuidade R1→R2 está perceptível. | A haste/arma do jogador entra excessivamente no canto inferior direito. Vegetação, terreno e ruínas ainda apresentam leitura simplificada. | O caminho é contínuo, mas a composição oferece pouca escala vertical e uma grande área de céu sem função. | Não há luz dinâmica evidente no frame sob luz diurna. | Aceite para a baseline, com observação de enquadramento. |

> A primeira hipótese a testar nos restantes percursos é uma melhoria **modular, regional, sem nova luz e sem nova física** focada na legibilidade composicional — e não uma alteração de câmara, colisão, ancoragem ou geometria de produção.

## Condição de captura validada

No ambiente de rasterização por software, o marcador `[ORIGEM_QA_ROUTE] Spawn` não garante que o primeiro frame de gameplay já tenha sido apresentado. Para esta baseline, cada captura deve usar pelo menos **60 segundos de estabilização** após o spawn e deve ser verificada visualmente para excluir ecrãs de arranque.

## Corredores R3→R5

| Rota | Frame | Objetivo espacial | Intrusões/superfícies | Solo e escala | Luzes visíveis | Estado |
|---|---:|---|---|---|---|---|
| `arch_to_forest` | `arch_to_forest_postload.png` | O vale entre encostas oferece uma direção geral, porém a saída para a floresta não se diferencia visualmente. | Rochas de forma simples, pequenos elementos luminosos ciano e vegetação pouco densa quebram a leitura arqueológica realista. A arma continua intrusiva no canto inferior direito. | O caminho é descontínuo, reduzido a uma laje isolada em primeiro plano; falta uma banda de circulação legível. A composição perde escala e não demonstra a clareira protegida. | Sem luz dinâmica perceptível; há pequenos acentos ciano no cenário. | Aceite apenas como diagnóstico; não atinge a intenção visual do storyboard. |
| `forest_to_majestic` | `forest_to_majestic_postload.png` | O caminho aponta para estruturas distantes, mas o Acampamento Majestic não se lê como destino de interesse. | Marcadores/objetos ciano e volumes retangulares escuros expostos funcionam como intrusões. A arma do jogador mantém-se no frame. | A via de pedra é contínua e navegável no eixo, mas o vale aberto e a escala horizontal tornam o destino frágil. | Não há luz dinâmica evidente no frame. | Aceite para a baseline, com défice severo de leitura ambiental. |

> As três primeiras imagens runtime válidas apontam para um problema comum de **leitura de percurso**: a geometria do trilho existe, mas a sua presença visual é descontínua ou compete com elementos de teste/baixo detalhe. A hipótese de intervenção continua limitada a uma solução modular, regional, sem iluminação ou física novas.

## Corredores de aproximação a R6

| Rota | Frame | Objetivo espacial | Intrusões/superfícies | Solo e escala | Luzes visíveis | Estado |
|---|---:|---|---|---|---|---|
| `forest_to_ruins` | `forest_to_ruins_postload.png` | A margem do lago é reconhecível à esquerda, mas o destino das Ruínas Submersas não é anunciado pelo enquadramento. | Água apresenta um recorte geométrico rígido; blocos, marcadores ciano e uma peça vermelha exposta quebram a ilusão de mundo. | As lajes conduzem em linha, mas estão separadas e não organizam uma chegada dramática à margem. | Sem luz dinâmica evidente; pontos ciano parecem marcadores/acentos, não sinais narrativos controlados. | Aceite para diagnóstico; falha a promessa de descoberta do storyboard. |
| `majestic_to_lake` | `majestic_to_lake_postload.png` | O conector segue em frente, porém nem o Acampamento nem o lago são distinguíveis como referência espacial. | Sombra de objeto/estrutura atravessa o primeiro plano; árvores e rochas de baixo detalhe, pequenos pontos ciano e a arma do jogador reduzem a leitura. | A sequência de placas demonstra atravessabilidade, mas não comunica um corredor regional coerente ou escala de aproximação. | Não há luz dinâmica evidente no frame. | Aceite para a baseline, com fraca continuidade perceptiva. |

> A evidência R4→R6 reforça que o problema a priorizar não é de iluminação nem de física: é a ausência de um **módulo ambiental de leitura do trilho** que una visualmente as placas existentes, a margem e o destino sem criar obstáculos, árvores-parede, luzes ou colisores novos.

## Chegada a R6 e medições físicas

| Rota / prova | Resultado | Evidência |
|---|---|---|
| `ruins_arrival` | A chegada não revela ruínas, água ou objetivo de exploração. Mostra terreno aberto, elementos soltos, uma árvore isolada e uma estela; a arma do jogador volta a ocupar o canto inferior direito. O frame é runtime 1600×900 válido, mas não cumpre a leitura pretendida de Ruínas Submersas. | `ruins_arrival/ruins_arrival_postload.png` |
| Grounding `voss_to_road` | **Aprovado**: 180 frames com chão; desvio vertical pós-aquecimento 0,00 m. | `physics/voss_to_road/summary.txt` |
| Grounding `arch_to_forest` | **Falhou**: 0 frames em chão; desvio vertical máximo 1,749 m; pior velocidade descendente 5,063 m/s. A sonda regional independente confirmou `no_chao=false` até 6,0 s e uma discrepância persistente entre `y` real e `esperado_y`. | `physics/arch_to_forest/summary.txt`; `physics/arch_to_forest_floor_probe/summary.txt` |
| Grounding `forest_to_majestic` | **Aprovado**: 180 frames com chão; desvio vertical pós-aquecimento 0,00 m. | `physics/forest_to_majestic/summary.txt` |
| Grounding `forest_to_ruins` | **Aprovado**: 180 frames com chão; desvio vertical pós-aquecimento 0,00 m. | `physics/forest_to_ruins/summary.txt` |
| Grounding `majestic_to_lake` | **Aprovado**: 180 frames com chão; desvio vertical pós-aquecimento 0,00 m. | `physics/majestic_to_lake/summary.txt` |
| Grounding `ruins_arrival` | **Aprovado**: 180 frames com chão; desvio vertical pós-aquecimento 0,00 m. | `physics/ruins_arrival/summary.txt` |
| Estado do jogador `QA-STATE-01` | **Aprovado**: entrada Orion concluída em 33 s; saúde 100 e stamina 100 antes/depois. | `physics/state_transition/runtime.log` |

> **Risco urgente, isolado e não corrigido nesta baseline:** o ponto QA `arch_to_forest` não estabiliza sobre o solo físico. Esta entrega não altera `Player`, câmara, colisores, ancoragens ou geometria de produção; por isso, o defeito é registado e encaminhado ao proprietário regional em vez de ser mascarado.
