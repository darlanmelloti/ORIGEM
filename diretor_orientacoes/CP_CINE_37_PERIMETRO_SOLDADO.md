# CP-CINE-37 — Perímetro Soldado de Interior Orion

O próximo ensaio substitui planos independentes por uma única malha lateral contínua. O perímetro transversal será uma sequência fechada de oito vértices, reutilizada em cinco anéis longitudinais. Cada quadrilátero entre anéis será dividido em dois triângulos que partilham exactamente os mesmos vértices, eliminando folgas entre piso, paredes e teto.

A entrada do corredor não será representada na captura: a câmara QA ficará entre o segundo e o quarto anel, dirigida ao último anel. Assim, a amostra mede a integridade do casco e não a abertura de ligação ao exterior.

| Elemento | Valor de teste |
|---|---|
| Largura útil | 4,8 m |
| Altura máxima | 4,4 m |
| Comprimento visível | 10,0 m |
| Anéis longitudinais | 5 |
| Perfil transversal | 8 vértices soldados |
| Material | Pedra PBR, culling frontal para leitura interior |
| Colisão | `TrimeshShape3D` derivada da mesma `ArrayMesh` |

A amostra é QA e não será integrada enquanto a imagem não demonstrar, simultaneamente, piso, parede lateral, teto e fundo sem céu exposto.
