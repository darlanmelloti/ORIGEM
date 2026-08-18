# CP-CARTO-67 — Rejeição da Lanterna QA Diurna

## Hipótese

A lanterna frontal activa por defeito poderia causar o brilho residual da espada e interferir na leitura do caminho em provas diurnas R1–R3.

## Ensaio

A lanterna foi desligada apenas nas rotas QA diurnas `road_to_arch`, `arch_to_forest` e `road_return_voss`. O comportamento do jogo normal e o controlo manual não foram modificados.

## Validação

O parser Godot 4.7.1 passou e a rota `road_to_arch` correu por 36 segundos. A captura `cp_carto67_qa_daylight_flashlight_1600x900.png` manteve a espada com brilho residual e reduziu a leitura geral do terreno e das lajes.

## Decisão

A alteração foi revertida integralmente. Não repetir a desactivação da lanterna nas rotas QA diurnas sem nova evidência causal. CP-CARTO-56 continua aguardando Dev2.
