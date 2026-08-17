# CP-CINE-47 — Corredor Orion Independente

## Resultado validado

A validação confirmou que a cena independente `res://scenes/orion_interior.tscn` elimina a dependência do `TerrainPatch` e, portanto, deixa de expor céu no teste interior. O corredor é formado por uma malha contínua irregular; a colisão é derivada da mesma `ArrayMesh`; não existem Cubo, altar, emissões Chronos nem activos soltos no espaço de passagem.

A leitura do percurso foi melhorada pela combinação de um piso PBR CC0 próprio, uma luz de preenchimento e um projector de percurso, ambos sem sombras. O interior mantém **duas luzes locais**, muito abaixo do orçamento de 16 luzes simultâneas para a GTX 1050 Ti.

| Verificação | Resultado |
|---|---|
| Sintaxe e carregamento Godot 4.7.1 | Aprovado |
| Captura OpenGL do corredor | Gerada em `cp_cine47_orion_ambient_calibrated.png` |
| Runtime de 30 segundos | Aprovado, sem erro de script ou chamada inválida |
| Céu visível no módulo independente | Ausente |
| Cube/altar/efeito Chronos | Ausentes |
| Luzes dinâmicas locais | 2, ambas sem sombra |

## Limite de aceitação

A cena é aprovada como **primeiro módulo técnico de interior** e não como Câmara final do Cubo. A próxima composição deve introduzir uma transição de entrada/retorno pela cena principal, sem expor o artefacto e sem substituir o corredor por paredes primitivas.

## Próximo ciclo já iniciado

**CP-CINE-48 — Transição exterior–interior:** ligar o gatilho físico da garganta Orion à cena independente através de um handoff controlado, com estado de retorno seguro.
