# QA-POST-PROLOGUE-INPUT-060 — reprodução e correção do bloqueio de Elias

**Data:** 2026-08-28
**Escopo:** input físico, colocação pós-prólogo, colisão do terreno e telemetria exclusiva de QA.
**Fora de escopo:** rotas cartográficas, luzes, geometria visual, água, IA, combate e câmara normal do jogador.

## Conclusão

O relato do Diretor foi **reproduzido**. Não era falta de mapeamento WASD nem ilusão causada pela espada. Na primeira sessão, o motor recebeu as teclas físicas, calculou velocidade horizontal próxima de 2,80 m/s e manteve a janela ativa com rato capturado, mas Elias ficou retido no `TerrainPatch/ColisaoDoTerreno`, sem contacto de chão e sem deslocamento mensurável.

A causa foi a orientação inversa das faces usadas exclusivamente pelo `ConcavePolygonShape3D` do terreno. A geometria visual já possuía a orientação correta; a cópia física usava a orientação contrária. Com a normal do piso invertida, o `CharacterBody3D` atravessava/encostava no lado incorreto do triângulo, acumulava velocidade vertical negativa e bloqueava o avanço horizontal.

A correção torna a malha de colisão congruente com a malha visual, conserva a topografia e os mesmos triângulos, e eleva a recuperação de spawn pós-prólogo para uma folga de 2,00 m acima da altura analítica do terreno. Esta folga apenas permite que a cápsula entre no colisor pelo lado correto; não cria plataforma, plano artificial, geometria adicional nem altera as rotas.

## Evidência de reprodução antes da correção

| Indicador | Resultado observado |
|---|---:|
| Duração da sessão pós-prólogo | 60,23 s |
| Teclas físicas recebidas | W, D, A e W novamente |
| Vetor e velocidade calculados | vetor WASD ativo; até 2,80 m/s |
| Caminho efetivamente percorrido | 0,30 m |
| Frames `is_on_floor()` | 0 |
| Posição vertical final | -0,279 m |
| Colisor que reteve Elias | `/root/Main/TempleLevel/TerrainPatch/ColisaoDoTerreno` |
| Resultado | **REPRODUZIDO — FALHOU** |

A telemetria demonstrou, portanto, uma situação em que o input existia mas não se convertia em deslocamento físico real.

## Correção aplicada

| Ficheiro | Alteração |
|---|---|
| `levels/TerrainPatch.gd` | A cópia de faces para `collision_surface` passou a usar a mesma orientação das faces visuais, expondo a frente superior ao `ConcavePolygonShape3D`. |
| `levels/VossHouse.gd` | Definida a constante `POST_OPENING_TERRAIN_CLEARANCE = 2.00` e aplicada ao spawn técnico pós-prólogo na Estrada do Rio. |
| `tools/qa/run_player_grounding.gd` | Removida a aprovação alternativa por estabilidade vertical: zero frames no chão já não pode passar como grounding válido. |
| `qa/player/verify_post_prologue_input_gameplay.gd` | Nova telemetria visível, ativada apenas por `ORIGEM_QA_POST_PROLOGUE_INPUT`, que mostra teclas, vetor, posição, velocidade, chão, colisores e câmara. |
| `tools/qa/verify_post_prologue_input_gameplay.sh` | Runner X11 que envia teclas reais à janela do jogo, recolhe capturas e exige uma sessão de 60 s. |

## Prova final com teclado físico

A sessão final foi executada em janela X11 do Godot, com eventos de teclado entregues pelo sistema operativo. O runner não chama `Input.action_press()` nem altera o vetor de movimento dentro do motor. A medição começa apenas depois de `VossHouse` devolver a `Camera3D` e o controlo pós-prólogo a Elias.

| Indicador | Resultado final |
|---|---:|
| Duração contínua | **60,41 s** |
| Caminho acumulado | **41,324 m** |
| Velocidade horizontal máxima | **2,80 m/s** |
| Frames `is_on_floor()` | **115** |
| Deslocamento W inicial | **12,061 m** |
| Deslocamento D | **5,286 m** |
| Deslocamento W intermédio | **10,954 m** |
| Deslocamento A | **5,732 m** |
| Deslocamento S | **2,132 m** |
| Resultado | **PASS** |

As capturas versionadas `post_prologue_input_060_start.png`, `post_prologue_input_060_mid.png` e `post_prologue_input_060_result.png` registam a telemetria. A captura intermédia mostra, durante W físico, janela ativa, rato capturado, velocidade de 2,80 m/s, 28,1 m de percurso, 78 frames no chão e contacto com `TerrainPatch/ColisaoDoTerreno` como piso.

## Regressões executadas após a correção

| Validação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| `QA-GROUND-01` com critério estrito | PASS — 180 frames no chão |
| `QA-PLAYER-LOCO-026` | PASS — melhor deslocamento 3,469 m; olhos a 0,88 m; alcance descendente da espada 1,17 m |
| Porta regional R2 | PASS |
| Porta regional R3 | PASS |
| Porta regional R4 | PASS |
| Porta regional R5 | PASS |
| Porta regional R6 | PASS |

Os avisos `Parameter material is null` após o encerramento do processo no backend de testes são mensagens conhecidas da limpeza GLES3/Dummy e não ocorreram durante a sessão de gameplay nem correspondem a `Parse Error`, `SCRIPT ERROR` ou falha de carregamento.
