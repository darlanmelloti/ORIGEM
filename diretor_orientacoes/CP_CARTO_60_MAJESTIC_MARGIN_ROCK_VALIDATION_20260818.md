# CP-CARTO-60 — Material das Rochas do Conector Majestic

## Hipótese

As dez instâncias `RochaLigacaoMajestic` do conector Floresta→Majestic não tinham material explícito e podiam explicar os pequenos props claros junto às lajes.

## Alteração

Foi aplicado `ruin_material` exclusivamente a essas rochas laterais. A posição, escala, vegetação, lajes, colisores e iluminação do conector permaneceram inalterados.

## Validação

O parser Godot 4.7.1 passou. A sessão `forest_to_majestic` completou 36 segundos sem erro de script. A captura `cp_carto60_majestic_rocks_1600x900.png` removeu o prop claro que ocupava a laje no primeiro plano da tomada anterior, mantendo a rota física e a leitura do corredor.

## Decisão

CP-CARTO-60 aprovado. A alteração é limitada às Regiões 1–6. CP-CARTO-56 continua aguardando a publicação Dev2 para a integração R6→R7.
