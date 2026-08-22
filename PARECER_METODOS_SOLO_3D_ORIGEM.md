# Parecer técnico — métodos eficientes de criação de solo 3D para ORIGEM

**Data:** 22 de Agosto de 2026  
**Escopo:** Godot 4.7.1, vertical slice R1–R6, GTX 1050 Ti, prioridade em grounding e eliminação de quedas através de falsos pisos.

## Conclusão executiva

A solução mais segura para o ORIGEM não é continuar a usar uma `ConcavePolygonShape3D` gigante como colisão primária. Para o terreno regional actual, com 640 × 880 metros e sem necessidade de cavernas no piso base, a arquitectura recomendada é uma **malha visual por chunks/LOD acompanhada por uma `HeightMapShape3D` de resolução controlada para a colisão**. A documentação oficial indica que `HeightMapShape3D` foi concebida para terrenos em grelha regular, divide cada célula em dois triângulos e é mais rápida em colisões do que `ConcavePolygonShape3D` [1].

A colisão deve usar exactamente a mesma função de altura e o mesmo sistema de coordenadas da malha visual. Casas, pontes, ruínas, margens com overhang e eventuais cavernas devem manter colisores próprios, pois um heightmap não representa saliências ou cavidades [1].

## Comparação das arquitecturas

| Método | Vantagem principal | Risco/limitação | Adequação ao ORIGEM |
|---|---|---|---|
| `ConcavePolygonShape3D` único | Representa qualquer superfície triangulada | Mais caro na consulta física; mais sensível a erros de triangulação, normais, gaps e regiões degeneradas | **Baixa como solução primária**; aceitável para peças estáticas pequenas |
| `HeightMapShape3D` | Colisão regular, determinística e mais rápida que concave; alinha naturalmente com uma grelha | Não suporta overhangs/cavernas e exige atenção a escala e origem | **Alta para o solo base** |
| Colisão por caixas/convexos modulares | Muito barata para física | Não acompanha bem relevo orgânico; exige muitos volumes | Alta para estradas, lajes, degraus, pontes e arquitectura |
| Malha visual `ArrayMesh` indexada | Mais eficiente que `SurfaceTool` para geometria estática, segundo a documentação oficial [2] | Implementação mais complexa | Alta para chunks estáticos |
| `SurfaceTool` | API simples, geração de normais/tangentes conveniente | Mais custo de CPU e duplicação se não houver indexação | Adequada para protótipo e geração inicial |
| Terrain3D/GDExtension | C++/GPU, clipmap, até 10 LODs, regiões variáveis e foliage instancing [3] | Dependência externa, binários por versão/renderer, migração e risco de integração | Alta para mundo aberto; **não é a primeira alteração para corrigir o vertical slice** |
| Clipmap/streaming próprio | Escala para mundo grande e orçamento previsível | Exige engenharia de seams, LOD, jobs e sincronização de colisão | Fase posterior, após estabilizar R1–R6 |

## Recomendação de arquitectura em três camadas

A primeira camada deve ser o **solo físico canónico**. Deve existir uma fonte única de dados de altura, com amostragem regular e funções `height_at_world(x, z)` e `normal_at_world(x, z)`. A partir dela deve ser criada uma `HeightMapShape3D` para a zona física activa. A forma deve ficar centrada no mesmo centro X/Z da grelha, e o espaçamento deve ser resolvido por pré-escala dos dados ou por uma transformação uniforme compatível com o motor. A documentação alerta que o GodotPhysics3D não suporta escala não uniforme de forma física da mesma maneira que uma simples malha visual [1].

A segunda camada deve ser a **malha visual por chunks**. O terreno regional pode ser dividido inicialmente em 4–8 chunks, com uma resolução mais alta perto da Casa Voss, estrada e transição para a relva, e resoluções progressivamente menores fora do corredor jogável. Os seams devem partilhar a mesma amostra de fronteira; não se deve gerar cada chunk com ruído independente. Para o código existente, migrar a construção estática de `SurfaceTool` para `ArrayMesh` indexado é uma optimização posterior, não uma condição para corrigir o grounding [2].

A terceira camada deve ser a **geometria especial**. A estrada de pedra, lajes, ponte, casa e ruínas devem ter colisores separados, preferencialmente caixas, cápsulas ou convexos simples. Quando uma peça tem uma face irregular mas permanece estática, pode usar uma concave pequena e local; não deve ser incorporada numa concave regional de centenas de metros.

## Aplicação ao estado actual do ORIGEM

O `TerrainPatch.gd` usa uma grelha de 192 × 220 células sobre 640 × 880 metros, ou seja, aproximadamente 42.240 células e 84.480 triângulos visuais/físicos se cada célula for dividida em dois. Esta dimensão é razoável para uma malha visual de protótipo, mas é uma base menos robusta para uma concave física única do que para um heightmap regular.

A alteração já aplicada de construir directamente as faces da `ConcavePolygonShape3D` é uma melhoria em relação a derivar a colisão de um `ArrayMesh`, mas não resolve estruturalmente os custos e as fragilidades de uma concave regional. Deve ser tratada como **ponte de estabilização**, não como arquitectura final.

O próximo refactor recomendado é manter `height_at()` como autoridade, gerar uma `PackedFloat32Array` na ordem `z * map_width + x`, definir `map_width = CELLS_X + 1` e `map_depth = CELLS_Z + 1`, e anexar a shape a um `StaticBody3D` com origem no centro geométrico do terreno. Como a documentação define os pontos do heightmap com espaçamento de 1 unidade, o código deverá pré-escalar a grelha ou adoptar uma resolução física em que o espaçamento mundial seja exactamente 1 metro; não se deve aplicar uma escala X/Z diferente da escala Y sem validar o backend físico [1].

Para evitar a queda livre durante a transição Casa Voss–relva, a região do jogador deve ter uma camada física de alta resolução e uma margem de sobreposição entre chunks. O spawn deve ser projectado por raycast contra a colisão final, e não apenas por uma estimativa de `height_at()`. Se o raycast não encontrar o solo dentro de uma tolerância curta, o teste deve falhar e impedir o início da travessia.

## Decisão sobre Terrain3D

O Terrain3D é uma alternativa credível para uma fase de mundo aberto. O projecto declara uma implementação em C++ como GDExtension, suporte a terrenos de 64 × 64 m até 65,5 × 65,5 km, até 10 níveis de detalhe, clipmap geométrico, importação de heightmaps e foliage instancing [3]. Isso torna-o tecnicamente adequado para R7–R12 e expansão futura, mas a adopção imediata introduziria uma dependência binária e uma migração da autoridade de altura, colisão e materiais. Para o bug actual, o caminho de menor risco é primeiro provar `HeightMapShape3D` no corredor R1–R6 em uma branch/feature isolada; só depois comparar runtime, memória, colisão e estabilidade com Terrain3D.

## Plano de implementação recomendado

| Ordem | Acção | Critério de aceitação |
|---:|---|---|
| 1 | Extrair uma fonte de dados de altura partilhada entre visual, colisão, spawn e QA | Nenhum sistema calcula uma altura divergente para o mesmo X/Z |
| 2 | Criar `HeightMapShape3D` para o solo base | Elias atravessa Casa Voss–relva sem queda e sem ficar congelado |
| 3 | Separar colisores de estrada, lajes, ponte, casa e ruínas | Cada peça especial mantém grounding independente do terreno base |
| 4 | Adicionar raycast de spawn e probes de continuidade a cada 1–2 m no corredor | Qualquer gap, degrau não intencional ou ausência de contacto falha o QA |
| 5 | Dividir apenas a malha visual em chunks, preservando a fonte de altura comum | Sem seam visível nem diferença física entre fronteiras |
| 6 | Optimizar a malha visual para `ArrayMesh` indexado e LOD | Menor CPU sem regressão visual ou física |
| 7 | Fazer um spike controlado de Terrain3D | Só migrar se superar a solução nativa em FPS, memória e estabilidade |

## Veredicto

Para o problema concreto de Elias ficar preso ou cair em falsos pisos, a decisão técnica recomendada é **HeightMapShape3D para o solo base + colisores modulares para elementos especiais + malha visual em chunks/LOD**. Esta combinação é mais determinística, mais fácil de testar e mais compatível com o vertical slice do que uma troca imediata para um plugin ou a manutenção de uma única concave gigante.

> A implementação actual deve ser convertida para esta arquitectura em uma tarefa isolada de grounding. A alteração da malha visual, materiais e vegetação não deve ser misturada com a migração da colisão, para que qualquer regressão possa ser atribuída a uma única camada.

## Referências

[1]: https://docs.godotengine.org/en/stable/classes/class_heightmapshape3d.html "Godot Engine — HeightMapShape3D"

[2]: https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/index.html "Godot Engine — Procedural geometry"

[3]: https://github.com/TokisanGames/Terrain3D "TokisanGames — Terrain3D"
