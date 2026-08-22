# Pesquisa: métodos eficientes de solo 3D em Godot 4.x

## Fontes consultadas

1. [Godot — HeightMapShape3D](https://docs.godotengine.org/en/stable/classes/class_heightmapshape3d.html)
2. [Godot — Procedural geometry](https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/index.html)

## Achados verificados

- `HeightMapShape3D` é uma forma de colisão específica para terrenos em grelha regular. Internamente cada célula é dividida em dois triângulos.
- A colisão heightmap é mais rápida de verificar do que `ConcavePolygonShape3D`, embora mais lenta do que formas primitivas como `BoxShape3D`.
- `HeightMapShape3D` não suporta overhangs ou cavernas; estes devem ter colisores separados. Vértices com `NaN` podem abrir buracos no heightmap.
- Os pontos do heightmap têm espaçamento de 1 unidade em X/Z e a grelha é centrada na origem do `CollisionShape3D`. Para outro espaçamento, a documentação alerta para limitações de escala não uniforme no GodotPhysics3D; os dados devem ser pré-escalados ou deve ser usado Jolt quando aplicável.
- Para dados de altura, EXR/HDR de 16 ou 32 bits é recomendado. Imagens de 8 bits podem criar degraus visíveis.
- A geometria procedural documentada pelo Godot é gerada no CPU; não se deve presumir geração de malha no GPU.
- `ArrayMesh` é ligeiramente mais rápido que `SurfaceTool` para geometria estática. `SurfaceTool` é mais confortável e fornece utilitários como geração de normais e indexação.
- `ImmediateMesh` é apropriado para protótipos/debug, mas é lento quando a geometria é reconstruída frequentemente.
- `MeshDataTool` não é indicado para geração de terreno em tempo real quando não é necessário editar faces/arestas.

## Implicação para ORIGEM

A opção de maior prioridade para um terreno de altura sem cavernas é trocar a colisão côncava por `HeightMapShape3D`, usando exactamente a mesma grelha e valores de `height_at()` que alimentam a malha visual. Para cavernas, ruínas ou margens com overhang, manter colisores modulares separados. A malha visual pode evoluir para `ArrayMesh` indexado e chunks com LOD, enquanto a colisão permanece numa grelha mais baixa e estável perto do jogador.
